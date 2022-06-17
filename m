Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0162954F91E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382498AbiFQOYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiFQOYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 10:24:47 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511D205C3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 07:24:44 -0700 (PDT)
Date:   Fri, 17 Jun 2022 14:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1655475881; x=1655735081;
        bh=8oc95WGMLbKY5AqlvSrVKa6x0dn4EqKvQizMvvd1z84=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=lPZKh+x5tPxc7QKzfD1TPu8Z9ZQH/tmSU4JnH1aYj1R8XH4hfMpf7QKLkT5HvPE94
         XsVpjEdSnYkE1ymoFRgBq+1twh4HVrQAEnQkpmGQS8DE6GpRhVTYwcqA/jIrtbg8Zw
         vCBiERH3XJ/5K+GiOm0Hzcd3HFz7mluAPo/IPVt733NzKjM+MLfQBeNzkHlDn2cpii
         pmwnS64CcFc+BW/XvVnA0VQdGfAgtsK17BC1OAbiNtPmeSRt/fAxL1MkFduA8Qvz1X
         EjNdHFoamyB3y/fPYmH4N7vijgs652nx97MBhXqZwh0dH2IUZWygq4FtRtGWN+YcZl
         dOmJSA+BmNN6Q==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.
Message-ID: <ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=@dannyvanheumen.nl>
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

From f1fcceb65d4a44c078cd684ea25a2f2c7f53deb2 Mon Sep 17 00:00:00 2001
From: Danny van Heumen <danny@dannyvanheumen.nl>
Date: Tue, 24 May 2022 18:30:50 +0200
Subject: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.

In case of buggy firmware, brcmfmac may perform a hardware reset. If during
reset and subsequent probing an early failure occurs, a memory region is
accidentally double-freed. With hardened memory allocation enabled, this er=
ror
will be detected.

- return early where appropriate to skip unnecessary clean-up.
- set '.freezer' pointer to NULL to prevent double-freeing under possible
  other circumstances and to re-align result under various different
  behaviors of memory allocation freeing.

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 9c598ea97499..40f40ac4ef73 100644
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

@@ -911,7 +912,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 =09if (ret) {
 =09=09brcmf_err("Failed to set F1 blocksize\n");
 =09=09sdio_release_host(sdiodev->func1);
-=09=09goto out;
+=09=09return ret;
 =09}
 =09switch (sdiodev->func2->device) {
 =09case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
@@ -933,7 +934,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 =09if (ret) {
 =09=09brcmf_err("Failed to set F2 blocksize\n");
 =09=09sdio_release_host(sdiodev->func1);
-=09=09goto out;
+=09=09return ret;
 =09} else {
 =09=09brcmf_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
 =09}
--
2.34.1

