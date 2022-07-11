Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45993570E33
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiGKXWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGKXWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:22:52 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9E8AB02
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:22:49 -0700 (PDT)
Date:   Mon, 11 Jul 2022 23:21:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1657581766; x=1657840966;
        bh=z5pmUjPAReFi5eaf37aRjen4nn8VeagdX6tDmw6ryGo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=lIRmPUQqrgx/afifo5VZrDkzGsfUtw3IkS+kOPKaHm33GjpmwDgwfFM3RhrTU9jLS
         AFglJu5FNdahF1pEiJbgNOb+Pnf8DQVmuiWMiTWbcuCqBsMIAbq6kgvJi74oRmuyN/
         6yggScjXw+EjL76ezMv7f2CBCbVj7bXtV9UYzf0oUgvMgOaYP5zB0z2haCJ5WnVBf/
         Qi4C9qtKHdZMFf36/Ago0mHfama1NdhLXEfABlYiwYnI0qkBYtCd35Ajnr5XKVR0o9
         Y7MrlV79Mt78KSeKpqjvTMZY7RZiDUQR1R+lfajZB6frCEHl6qKHHOARpVtH3w5qLz
         fNDB5tkMgxLYA==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Message-ID: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case of buggy firmware, brcmfmac may perform a hardware reset. If during
reset and subsequent probing an early failure occurs, a memory region is
accidentally double-freed. With hardened memory allocation enabled, this er=
ror
will be detected.

- return early where appropriate to skip unnecessary clean-up.
- set '.freezer' pointer to NULL to prevent double-freeing under possible
  other circumstances and to re-align result under various different
  behaviors of memory allocation freeing.
- correctly claim host on func1 for disabling func2.
- after reset, do not initiate probing immediately, but rely on events.

Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitial=
ize
the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
early, which includes calling 'brcmf_sdiod_remove'. In both cases
'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
has not yet been re-allocated the second time.

Stacktrace of (failing) hardware reset after firmware-crash:

Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
 ret_from_fork+0x10/0x20
 kthread+0x154/0x160
 worker_thread+0x188/0x504
 process_one_work+0x1f4/0x490
 brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
 brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
 brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
 brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
 kfree+0x210/0x220
 __slab_free+0x58/0x40c
Call trace:
x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
sp : ffff80000a22bbf0
lr : kfree+0x210/0x220
pc : __slab_free+0x58/0x40c
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
Workqueue: events brcmf_core_bus_reset [brcmfmac]
Hardware name: Pine64 Pinebook Pro (DT)
CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.=
4-arm64 #1  Debian 5.16.12-1~bpo11+1
 nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core s=
nd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib=
_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
Internal error: Oops - BUG: 0 [#1] SMP
kernel BUG at mm/slub.c:379!

Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   | 13 +++++--------
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 10 +---------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ac02244a6fdf..414ee21f42e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_sdi=
o_dev *sdiodev)
 =09if (sdiodev->freezer) {
 =09=09WARN_ON(atomic_read(&sdiodev->freezer->freezing));
 =09=09kfree(sdiodev->freezer);
+=09=09sdiodev->freezer =3D NULL;
 =09}
 }

@@ -875,13 +876,9 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev)

 =09brcmf_sdiod_freezer_detach(sdiodev);

-=09/* Disable Function 2 */
-=09sdio_claim_host(sdiodev->func2);
-=09sdio_disable_func(sdiodev->func2);
-=09sdio_release_host(sdiodev->func2);
-
-=09/* Disable Function 1 */
+=09/* Disable functions 2 then 1. */
 =09sdio_claim_host(sdiodev->func1);
+=09sdio_disable_func(sdiodev->func2);
 =09sdio_disable_func(sdiodev->func1);
 =09sdio_release_host(sdiodev->func1);

@@ -911,7 +908,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 =09if (ret) {
 =09=09brcmf_err("Failed to set F1 blocksize\n");
 =09=09sdio_release_host(sdiodev->func1);
-=09=09goto out;
+=09=09return ret;
 =09}
 =09switch (sdiodev->func2->device) {
 =09case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
@@ -933,7 +930,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 =09if (ret) {
 =09=09brcmf_err("Failed to set F2 blocksize\n");
 =09=09sdio_release_host(sdiodev->func1);
-=09=09goto out;
+=09=09return ret;
 =09} else {
 =09=09brcmf_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
 =09}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 212fbbe1cd7e..2ed70f809097 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4152,7 +4152,6 @@ int brcmf_sdio_get_fwname(struct device *dev, const c=
har *ext, u8 *fw_name)

 static int brcmf_sdio_bus_reset(struct device *dev)
 {
-=09int ret =3D 0;
 =09struct brcmf_bus *bus_if =3D dev_get_drvdata(dev);
 =09struct brcmf_sdio_dev *sdiodev =3D bus_if->bus_priv.sdio;

@@ -4169,14 +4168,7 @@ static int brcmf_sdio_bus_reset(struct device *dev)
 =09sdio_release_host(sdiodev->func1);

 =09brcmf_bus_change_state(sdiodev->bus_if, BRCMF_BUS_DOWN);
-
-=09ret =3D brcmf_sdiod_probe(sdiodev);
-=09if (ret) {
-=09=09brcmf_err("Failed to probe after sdio device reset: ret %d\n",
-=09=09=09  ret);
-=09}
-
-=09return ret;
+=09return 0;
 }

 static const struct brcmf_bus_ops brcmf_sdio_bus_ops =3D {
--
2.34.1

