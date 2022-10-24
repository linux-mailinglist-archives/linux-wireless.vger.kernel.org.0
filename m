Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F1609B0E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJXHNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJXHNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 03:13:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8FA59256
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 00:13:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so8391503pjl.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1dsXFHKEvPw/aJ1Uon9oecdo5dPhwSf08ZsRBZOkf4=;
        b=s/CBoNAQiw00CDQasqZB4ix315K6WYT4yuLlPSOLSvH9ftuay2OHpJpnxgVA/EspPJ
         WMUzMNIbgH38szsXtADRzHKfzOVMV9BZqbVH2dqnUFckjTP+HRBB6FdaIBIQDVGoXFWT
         odFLF2utuS/9hVwivNkPNL8uDlTeqeKkXcioW4ml0bgl3EyqLEc8fpYpo8ysVBRWKQpY
         3NO3W0k/timkXIDorTtOznyXoS6E4brjJ47mX19TKvhwfAQ2IEja8auQo86+leyohoX3
         bVSYYLJ2VtOcavyefZNIzYv7z6sIfbhhWvt4YkODYfsWL6TH4f/qlmIPlwE74tqI8dM2
         e2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1dsXFHKEvPw/aJ1Uon9oecdo5dPhwSf08ZsRBZOkf4=;
        b=yMXeyEReOUIwRvSfRL00/tfe+t/TZkfdfKj6991eGz77ACfNN4o+aUK9A+1CYY+2uN
         yIh0FRtTLdvhji01F/rrXtVa0F/SDOvRLbM2Mh2hnfWaV+Wc5E98JUP74+GHc/DCZZoB
         0eYJjnZyTcPIpoR9xWsGtgSSVDf+9/jDp5EKR0qJCCPs4w5dgA69YisjE+Y2/DPQOu/r
         Br9W/ZYhoEMh28eH3SsiO3BiKGaP9j16HlI7yxy4dPmDunQ8/qkArYPHvce0B5eMs1oH
         FRKPOTdC2dD+hblTrNDOCCZzKK93pjk1HZyt56zY7UMSpaN0FpqlEOVGaHbPESwmehGe
         hlrA==
X-Gm-Message-State: ACrzQf0flw9xo3cyfPPnVcQhBQC/AK3Wxt5CioZ1zLs2uuxXOCnErvnE
        2qbUBZHM9hH6w5jQaFEegPu0o/ZAyRWcWg==
X-Google-Smtp-Source: AMsMyM4BX031P70dYAp06dmnZMXfaKa7UDBfbL08oRl6kPKS7zkHxTvxTZQEKKvhdFSiDNBVtUEsog==
X-Received: by 2002:a17:903:11c8:b0:179:de93:bd7e with SMTP id q8-20020a17090311c800b00179de93bd7emr32477018plh.95.1666595615684;
        Mon, 24 Oct 2022 00:13:35 -0700 (PDT)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090a664200b001f94d25bfabsm3538291pjm.28.2022.10.24.00.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 00:13:35 -0700 (PDT)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, aspriel@gmail.com
Cc:     dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] wifi: brcmfmac: Fix potential shift-out-of-bounds in brcmf_fw_alloc_request()
Date:   Mon, 24 Oct 2022 16:13:29 +0900
Message-Id: <20221024071329.504277-1-linuxlovemin@yonsei.ac.kr>
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

This patch fixes a shift-out-of-bounds in brcmfmac that occurs in
BIT(chiprev) when a 'chiprev' provided by the device is too large.
It should also not be equal to or greater than BITS_PER_TYPE(u32)
as we do bitwise AND with a u32 variable and BIT(chiprev). The patch
adds a check that makes the function return NULL if that is the case.
Note that the NULL case is later handled by the bus-specific caller,
brcmf_usb_probe_cb() or brcmf_usb_reset_resume(), for example.

Found by a modified version of syzkaller.

UBSAN: shift-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
shift exponent 151055786 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 1885 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 dump_stack_lvl+0x57/0x7d
 ubsan_epilogue+0x5/0x40
 __ubsan_handle_shift_out_of_bounds.cold+0x53/0xdb
 ? lock_chain_count+0x20/0x20
 brcmf_fw_alloc_request.cold+0x19/0x3ea
 ? brcmf_fw_get_firmwares+0x250/0x250
 ? brcmf_usb_ioctl_resp_wait+0x1a7/0x1f0
 brcmf_usb_get_fwname+0x114/0x1a0
 ? brcmf_usb_reset_resume+0x120/0x120
 ? number+0x6c4/0x9a0
 brcmf_c_process_clm_blob+0x168/0x590
 ? put_dec+0x90/0x90
 ? enable_ptr_key_workfn+0x20/0x20
 ? brcmf_common_pd_remove+0x50/0x50
 ? rcu_read_lock_sched_held+0xa1/0xd0
 brcmf_c_preinit_dcmds+0x673/0xc40
 ? brcmf_c_set_joinpref_default+0x100/0x100
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lock_acquire+0x19d/0x4e0
 ? find_held_lock+0x2d/0x110
 ? brcmf_usb_deq+0x1cc/0x260
 ? mark_held_locks+0x9f/0xe0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 ? _raw_spin_unlock_irqrestore+0x47/0x50
 ? trace_hardirqs_on+0x1c/0x120
 ? brcmf_usb_deq+0x1a7/0x260
 ? brcmf_usb_rx_fill_all+0x5a/0xf0
 brcmf_attach+0x246/0xd40
 ? wiphy_new_nm+0x1476/0x1d50
 ? kmemdup+0x30/0x40
 brcmf_usb_probe+0x12de/0x1690
 ? brcmf_usbdev_qinit.constprop.0+0x470/0x470
 usb_probe_interface+0x25f/0x710
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 ? usb_match_id.part.0+0x88/0xc0
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 ? driver_allows_async_probing+0x120/0x120
 bus_for_each_drv+0x123/0x1a0
 ? bus_rescan_devices+0x20/0x20
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 ? trace_hardirqs_on+0x1c/0x120
 __device_attach+0x207/0x330
 ? device_bind_driver+0xb0/0xb0
 ? kobject_uevent_env+0x230/0x12c0
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 ? __mutex_unlock_slowpath+0xe7/0x660
 ? __fw_devlink_link_to_suppliers+0x550/0x550
 usb_set_configuration+0x984/0x1770
 ? kernfs_create_link+0x175/0x230
 usb_generic_driver_probe+0x69/0x90
 usb_probe_device+0x9c/0x220
 really_probe+0x1be/0xa90
 __driver_probe_device+0x2ab/0x460
 driver_probe_device+0x49/0x120
 __device_attach_driver+0x18a/0x250
 ? driver_allows_async_probing+0x120/0x120
 bus_for_each_drv+0x123/0x1a0
 ? bus_rescan_devices+0x20/0x20
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 ? trace_hardirqs_on+0x1c/0x120
 __device_attach+0x207/0x330
 ? device_bind_driver+0xb0/0xb0
 ? kobject_uevent_env+0x230/0x12c0
 bus_probe_device+0x1a2/0x260
 device_add+0xa61/0x1ce0
 ? __fw_devlink_link_to_suppliers+0x550/0x550
 usb_new_device.cold+0x463/0xf66
 ? hub_disconnect+0x400/0x400
 ? _raw_spin_unlock_irq+0x24/0x30
 hub_event+0x10d5/0x3330
 ? hub_port_debounce+0x280/0x280
 ? __lock_acquire+0x1671/0x5790
 ? wq_calc_node_cpumask+0x170/0x2a0
 ? lock_release+0x640/0x640
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 process_one_work+0x873/0x13e0
 ? lock_release+0x640/0x640
 ? pwq_dec_nr_in_flight+0x320/0x320
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x8b/0xd10
 ? __kthread_parkme+0xd9/0x1d0
 ? process_one_work+0x13e0/0x13e0
 kthread+0x379/0x450
 ? _raw_spin_unlock_irq+0x24/0x30
 ? set_kthread_struct+0x100/0x100
 ret_from_fork+0x1f/0x30

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index f2207793f6e2..09d2f2dc2b46 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -803,6 +803,11 @@ brcmf_fw_alloc_request(u32 chip, u32 chiprev,
 	u32 i, j;
 	char end = '\0';
 
+	if (chiprev >= BITS_PER_TYPE(u32)) {
+		brcmf_err("Invalid chip revision %u\n", chiprev);
+		return NULL;
+	}
+
 	for (i = 0; i < table_size; i++) {
 		if (mapping_table[i].chipid == chip &&
 		    mapping_table[i].revmask & BIT(chiprev))
-- 
2.25.1

