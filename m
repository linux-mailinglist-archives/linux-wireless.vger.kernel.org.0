Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F36254B1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 08:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKHyb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 02:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiKKHya (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 02:54:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22467111
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 23:54:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so4104811pji.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzWZ6+k08Kx/vMfz8tBTX4eICsy583jKg296PgR825g=;
        b=7Ow7UQLjkzdNl8foQGUUDHxhvmAnIkrzj+6uBHxQ5V1CBkyk3veO5mj5Ockq3ZFTGm
         nQql3r/TCcv99k2Jvli7CfKmoSMv6JpfXlr1nkRI7JWufPQjAw81/Lo+iQHUNVhgOdGQ
         VV1uJDTLGgvu5riMQpM3QtN00kgnApIiR0Roowv8muWdJNrcBatCkctb7uNFl/9BbjUS
         F2vjqndGzyeTQngSN7/OiI5SjWzEOMFnsopFd5QtjSWADCy7ypZto7rJfLrMU+Gc//Wj
         uu0PTzqYmUO5hxHHj7AthsOv6oh87raXSGTe15/GGZUknG3CMallqm0/Z1yhRtgVgdT2
         ZbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzWZ6+k08Kx/vMfz8tBTX4eICsy583jKg296PgR825g=;
        b=XVHiU8LH07QBA51DbifISTjwMLpQ69pHiA0OadYkvsw6lkyEvLqdBh8DzmBUoQatTr
         i60cuL22fbP2Idd44wnbUGE/rG9GMF0OihewJdSxjq84Aa3qKQwgbc2NAOHnHmmGct+1
         fkCIZmncNriq9/3bDzFBiGI0oiVF2BTLByeNNMtwBm9RC16dtGg9t6ih+n89cCz2zSA1
         OFJ2uegA639E0nKNB+C0UQa15VlHAW8FWhn3uHj3FBKleMMQJri2IPNWKnXH1VyknLdq
         jRK3fnbzUEQX4SYlus5QtsgpsDj1neQmjxjr0fYY7Djr5y7iQOINzfu1Zs95xkxcDGYh
         wl/g==
X-Gm-Message-State: ANoB5pkUwLCZwaJksv1Dm920NXMwl0Ii1KC6QTikR8ZV1uJYvXRTZF6b
        51JcJUsExgb9aXYaRaJwMdmBciCbSjmNcw==
X-Google-Smtp-Source: AA0mqf4Gtai5s1bVu2SuRxfXnlKwj9HmT9RwkkKrZpiM9A4Cqxjjq+fPaCcNkcbcZFkKcNcIcX9jMA==
X-Received: by 2002:a17:90a:ebc9:b0:205:d3f8:5241 with SMTP id cf9-20020a17090aebc900b00205d3f85241mr612650pjb.188.1668153264475;
        Thu, 10 Nov 2022 23:54:24 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b00186b6a04636sm984536plg.255.2022.11.10.23.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:54:23 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, aspriel@gmail.com
Cc:     dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] wifi: brcmfmac: Check the count value of channel spec to prevent out-of-bounds reads
Date:   Fri, 11 Nov 2022 16:53:46 +0900
Message-Id: <20221111075346.136376-1-linuxlovemin@yonsei.ac.kr>
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
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index ae9507dec74a..3a1c0743e19c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6840,6 +6840,13 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
 			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
 
 	total = le32_to_cpu(list->count);
+	if (total > BRCMF_DCMD_MEDLEN / sizeof(__le32) - 1) {
+		bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
+			 total);
+		err = -EINVAL;
+		goto fail_pbuf;
+	}
+
 	for (i = 0; i < total; i++) {
 		ch.chspec = (u16)le32_to_cpu(list->element[i]);
 		cfg->d11inf.decchspec(&ch);
@@ -6985,6 +6992,13 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
 		band = cfg_to_wiphy(cfg)->bands[NL80211_BAND_2GHZ];
 		list = (struct brcmf_chanspec_list *)pbuf;
 		num_chan = le32_to_cpu(list->count);
+		if (num_chan > BRCMF_DCMD_MEDLEN / sizeof(__le32) - 1) {
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

