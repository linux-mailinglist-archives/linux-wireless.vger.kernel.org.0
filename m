Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2B5641E1
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiGBRfQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 13:35:16 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FADFB8
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 10:35:12 -0700 (PDT)
Date:   Sat, 02 Jul 2022 17:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1656783309; x=1657042509;
        bh=iILpwwk1OP0q6tgIJOYEDphJskRvDbtg4pkBqD471MQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=RC86Mz3D1BeW22m6igcOeaz9Nt8ooH5ipU+EUgC/IUD637MJVtNx+CqvvcXIaoQp8
         SC19quCJMBOw5ynd5R4zVk6/l6bTkQSVKpWNrbHEsook73arf/bROzVivuRVGb14dt
         dnOt0+QKqdqPBBsRONM4ZJcUOQR/66yS4IHSrtkBOTEEXyfrn5u0ILF5E32sD3b0R6
         Cg2XkteEBky7bGFjoNTNmODDxhLihn7HNwRhbtg0ZmfdVBEhls3510cCfGVsRc5AQb
         X2Mg8xE83dN8TQmpRwIW9BbgO+w47/G5cWcZtboNzu29dRz6K3DWyeuEDOkEkPBTmp
         yzfFXlSyJDdQA==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Message-ID: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 31 ++++++++++++-------
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 10 +-----
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ac02244a6fdf..dd634edaa0b3 100644
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
@@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sdio_func =
*func)
 =09if (bus_if) {
 =09=09sdiodev =3D bus_if->bus_priv.sdio;

+=09=09if (func->num !=3D 1) {
+=09=09=09/* Satisfy kernel expectation that the irq is released once the
+=09=09=09 * '.remove' callback has executed, while respecting the design
+=09=09=09 * that removal is executed for 'sdiodev', instead of individual
+=09=09=09 * function.
+=09=09=09 */
+=09=09=09brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
+=09=09=09sdio_claim_host(sdiodev->func1);
+=09=09=09sdio_release_irq(func);
+=09=09=09sdio_release_host(sdiodev->func1);
+=09=09=09return;
+=09=09}
+
+=09=09/* func 1: so do full clean-up and removal */
+
 =09=09/* start by unregistering irqs */
 =09=09brcmf_sdiod_intr_unregister(sdiodev);

-=09=09if (func->num !=3D 1)
-=09=09=09return;
-
 =09=09/* only proceed with rest of cleanup if func 1 */
 =09=09brcmf_sdiod_remove(sdiodev);

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

