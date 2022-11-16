Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5462C0E8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 15:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiKPObp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 09:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiKPObj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 09:31:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDC27173
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 06:31:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q9so17630295pfg.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLSczmXDYF7ts8G+p/U7FQlieHtFEbU47LUZzBW6Uqo=;
        b=b1JZlErCuTp9AaA/BwNm8/wGyMqviLaxD5bo9/NYWSA5gz0XPbx8adUXvJDZCrZINa
         ubRUkUnIH8KB7eTopJPnytzaAlp59pQK9vD80iBuHCXI03saXwfPtQtP6WA4EGaoqCrP
         sFNeSHFBVhJZBiXawBMcUj9m26jjURRw1EezMaGoZSyH9vpwD7uhmol/6fyzP3QB8Gxv
         mX6TW7xOUmlF3h/wIw6mtUtabtciX9ciErYDmyzGWBPf4/d7vu40ReI1WS24XAEeG/FE
         we8z//2ydrg6GJt5qwxreCbxcc0aV64LecoDuRHHgzlWJJTyojnlLkISHTGEkDMSS4N8
         0D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLSczmXDYF7ts8G+p/U7FQlieHtFEbU47LUZzBW6Uqo=;
        b=ieya2XudwZsYsZv+oChsqx1FteNQ4hPtcJ2QkFqaTZIIh/45xUjITdEg4qVEcACzPK
         Wny/bgzcJVy9Z/aqTncpBu3CHj0lXCx5Q8dgcFpcC6bBNteORnAoMY982sSlHX6mVtKc
         4sLahxU1uKdr6/+D8tMPXMZh2uQEI4srskhN7ZYRKfvfOPX6z6TtyI2Qx45k0yVd6rqB
         79d/wE7+X7KkGhHFUyDNcepECvPNLMnNxuDCg1gDpD0/ZGshCJGx5oF4igpCNj5Q90NR
         F4z7O+AoBWzLx3y+m0AYlmreZhDdKHTDsOyw9qH/OixyLp7UJyBrf/8NVGnRNi/6kgdM
         48ow==
X-Gm-Message-State: ANoB5pnRRb0z6vU6LipWhkecXtbbVYl1celFY66bYd3RiXsgmp31ac6w
        i7AY7iIcDH6IIYH1E55HE1dLkdDUbQwU/5TG
X-Google-Smtp-Source: AA0mqf6ffIJD1A6JGLNrC7vDdBgBcyhn1CUlH9VskcLkYQ2MyNKag9S/ZOLsElnSAtq1b/KQDdxzmQ==
X-Received: by 2002:a63:2065:0:b0:476:ed2a:6216 with SMTP id r37-20020a632065000000b00476ed2a6216mr2157850pgm.556.1668609079169;
        Wed, 16 Nov 2022 06:31:19 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b00186a68ec086sm12348305plk.193.2022.11.16.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:31:18 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org
Cc:     arend.vanspriel@broadcom.com, dokyungs@yonsei.ac.kr,
        jisoo.jang@yonsei.ac.kr, Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH v2] wifi: brcmfmac: Check the count value of channel spec to prevent out-of-bounds reads
Date:   Wed, 16 Nov 2022 23:29:52 +0900
Message-Id: <20221116142952.518241-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes slab-out-of-bounds reads in brcmfmac that occur in
brcmf_construct_chaninfo() and brcmf_enable_bw40_2g() when the count
value of channel specifications provided by the device is greater than
the length of 'list->element[]', decided by the size of the 'list'
allocated with kzalloc(). The patch adds checks that make the functions
free the buffer and return -EINVAL if that is the case. Note that the
negative return is handled by the caller, brcmf_setup_wiphybands() or
brcmf_cfg80211_attach().

Found by a modified version of syzkaller.

Crash Report from brcmf_construct_chaninfo():
==================================================================
BUG: KASAN: slab-out-of-bounds in brcmf_setup_wiphybands+0x1238/0x1430
Read of size 4 at addr ffff888115f24600 by task kworker/0:2/1896

CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 dump_stack_lvl+0x57/0x7d
 print_address_description.constprop.0.cold+0x93/0x334
 kasan_report.cold+0x83/0xdf
 brcmf_setup_wiphybands+0x1238/0x1430
 brcmf_cfg80211_attach+0x2118/0x3fd0
 brcmf_attach+0x389/0xd40
 brcmf_usb_probe+0x12de/0x1690
 usb_probe_interface+0x25f/0x710
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_set_configuration+0x984/0x1770
 usb_generic_driver_probe+0x69/0x90
 usb_probe_device+0x9c/0x220
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_new_device.cold+0x463/0xf66
 hub_event+0x10d5/0x3330
 process_one_work+0x873/0x13e0
 worker_thread+0x8b/0xd10
 kthread+0x379/0x450
 ret_from_fork+0x1f/0x30

Allocated by task 1896:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc+0x7c/0x90
 kmem_cache_alloc_trace+0x19e/0x330
 brcmf_setup_wiphybands+0x290/0x1430
 brcmf_cfg80211_attach+0x2118/0x3fd0
 brcmf_attach+0x389/0xd40
 brcmf_usb_probe+0x12de/0x1690
 usb_probe_interface+0x25f/0x710
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_set_configuration+0x984/0x1770
 usb_generic_driver_probe+0x69/0x90
 usb_probe_device+0x9c/0x220
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_new_device.cold+0x463/0xf66
 hub_event+0x10d5/0x3330
 process_one_work+0x873/0x13e0
 worker_thread+0x8b/0xd10
 kthread+0x379/0x450
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888115f24000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1536 bytes inside of
 2048-byte region [ffff888115f24000, ffff888115f24800)

Memory state around the buggy address:
 ffff888115f24500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888115f24580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888115f24600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888115f24680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115f24700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Crash Report from brcmf_enable_bw40_2g():
==================================================================
BUG: KASAN: slab-out-of-bounds in brcmf_cfg80211_attach+0x3d11/0x3fd0
Read of size 4 at addr ffff888103787600 by task kworker/0:2/1896

CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 dump_stack_lvl+0x57/0x7d
 print_address_description.constprop.0.cold+0x93/0x334
 kasan_report.cold+0x83/0xdf
 brcmf_cfg80211_attach+0x3d11/0x3fd0
 brcmf_attach+0x389/0xd40
 brcmf_usb_probe+0x12de/0x1690
 usb_probe_interface+0x25f/0x710
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_set_configuration+0x984/0x1770
 usb_generic_driver_probe+0x69/0x90
 usb_probe_device+0x9c/0x220
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_new_device.cold+0x463/0xf66
 hub_event+0x10d5/0x3330
 process_one_work+0x873/0x13e0
 worker_thread+0x8b/0xd10
 kthread+0x379/0x450
 ret_from_fork+0x1f/0x30

Allocated by task 1896:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc+0x7c/0x90
 kmem_cache_alloc_trace+0x19e/0x330
 brcmf_cfg80211_attach+0x3302/0x3fd0
 brcmf_attach+0x389/0xd40
 brcmf_usb_probe+0x12de/0x1690
 usb_probe_interface+0x25f/0x710
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_set_configuration+0x984/0x1770
 usb_generic_driver_probe+0x69/0x90
 usb_probe_device+0x9c/0x220
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 bus_for_each_drv+0x123/0x1a0
 __device_attach+0x207/0x330
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 usb_new_device.cold+0x463/0xf66
 hub_event+0x10d5/0x3330
 process_one_work+0x873/0x13e0
 worker_thread+0x8b/0xd10
 kthread+0x379/0x450
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888103787000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1536 bytes inside of
 2048-byte region [ffff888103787000, ffff888103787800)

Memory state around the buggy address:
 ffff888103787500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888103787580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888103787600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888103787680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888103787700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
v1->v2: Added a macro BRCMF_MAX_CHANSPEC_LIST

 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index ae9507dec74a..bff3128c2f26 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -101,6 +101,9 @@
 #define BRCMF_ASSOC_PARAMS_FIXED_SIZE \
 	(sizeof(struct brcmf_assoc_params_le) - sizeof(u16))
 
+#define BRCMF_MAX_CHANSPEC_LIST \
+	(BRCMF_DCMD_MEDLEN / sizeof(__le32) - 1)
+
 struct brcmf_dump_survey {
 	u32 obss;
 	u32 ibss;
@@ -6840,6 +6843,13 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
 			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
 
 	total = le32_to_cpu(list->count);
+	if (total > BRCMF_MAX_CHANSPEC_LIST) {
+		bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
+			 total);
+		err = -EINVAL;
+		goto fail_pbuf;
+	}
+
 	for (i = 0; i < total; i++) {
 		ch.chspec = (u16)le32_to_cpu(list->element[i]);
 		cfg->d11inf.decchspec(&ch);
@@ -6985,6 +6995,13 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
 		band = cfg_to_wiphy(cfg)->bands[NL80211_BAND_2GHZ];
 		list = (struct brcmf_chanspec_list *)pbuf;
 		num_chan = le32_to_cpu(list->count);
+		if (num_chan > BRCMF_MAX_CHANSPEC_LIST) {
+			bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
+				 num_chan);
+			kfree(pbuf);
+			return -EINVAL;
+		}
+
 		for (i = 0; i < num_chan; i++) {
 			ch.chspec = (u16)le32_to_cpu(list->element[i]);
 			cfg->d11inf.decchspec(&ch);
-- 
2.25.1

