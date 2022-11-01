Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5736A6151A1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 19:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKASgw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKASgv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 14:36:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08819016
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 11:36:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d24so14376994pls.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs2pkPS818OvkF4os4YzRHrsAl1yfdMrXzjnxxVuYSA=;
        b=WndJMxa6IAUfmtDJx01zDkozR06E5lgwuhqYUJFRuHm/r+eZulIBIr22N74rLtSWZ7
         +LC8s4+LODvb2ya+Kk+m8PwNNHGNdmh3PijeNZSXWvF8PgX173h6KndH+rStgCf8vFgf
         NTEX13JJYO7MK5EhLHoYK4JWN0TwGrHakZWG3BwxixuNwWJq/gzPuMFL9lmz4ef3a5Me
         vzgDWSRx3vasDeibhA9FFDfJE14bBXYsvBfKay5sla0HcJjPP3tQbotc3gIRjVI9zMsY
         DOIfETa5QRfT3p0WoVeGweLX8T4FugF5py03Q0ujLUGDH0Oqmq3z/Ldp0mDZ+rrUPgTf
         ZrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs2pkPS818OvkF4os4YzRHrsAl1yfdMrXzjnxxVuYSA=;
        b=ivvD6Zd2LMDIjFYJ7Tx2xTBoYqKndKjgLHJZVuGqp6Mu+nE2CwTeegx6DyYOiQ+f+t
         9BuUBTJ7IcVplxPoxE7ow+0dIjsD7FTreWWrp8mYQF2Pzno70/poebGQJE6UHOVUDQc3
         2miDIfDVrH2Z+jGhuaxKn67uqyJoKcGMtsF5uQF/YewMfyZ70sWHEKjas2/slvcNsWY+
         EqJ5F1M29T+DCUxh9DBY9P4Jw8p3YPLMlqy4/62hAY6uVrJDsL/2iWSpKdr2yWXDiXj3
         nLIGKhq3PST+ZaVHO0arLszNwP5bxcBWTPEwf0Ynj1ORlJE48GrpYz5Gy60E6Beru2Ic
         0ORA==
X-Gm-Message-State: ACrzQf2euDqWk9mWYA/YcosuTHF+BB+Y4926XscRWDwZquixUxcAQ2FZ
        563zyf9elD8/se2BXPh3DGWG
X-Google-Smtp-Source: AMsMyM7Vp/eQAXIfndjLPG6J8OaDxc/N79elXp3xKcm/NIqo0FwYD5kSwvUUMTvGlziPAQodxEpToQ==
X-Received: by 2002:a17:902:cecc:b0:186:cd5c:3fc2 with SMTP id d12-20020a170902cecc00b00186cd5c3fc2mr20546521plg.152.1667327806307;
        Tue, 01 Nov 2022 11:36:46 -0700 (PDT)
Received: from localhost.localdomain ([165.132.118.55])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b00186afd756edsm6634514plk.283.2022.11.01.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:36:46 -0700 (PDT)
From:   Jisoo Jang <jisoo.jang@yonsei.ac.kr>
To:     aspriel@gmail.com, linux-wireless@vger.kernel.org, kvalo@kernel.org
Cc:     Dokyung Song <dokyungs@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH v2] wifi: brcmfmac: Fix potential NULL pointer dereference in 'brcmf_c_preinit_dcmds()'
Date:   Wed,  2 Nov 2022 03:36:42 +0900
Message-Id: <20221101183642.166450-1-jisoo.jang@yonsei.ac.kr>
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

This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
when ptr which is NULL pointer passed as an argument of strlcpy() in
brcmf_c_preinit_dcmds(). This happens when the driver passes a firmware
version string that does not contain a space " ", making strrchr()
return a null pointer. This patch adds a null pointer check.

Found by a modified version of syzkaller.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 1983 Comm: kworker/0:2 Not tainted 5.14.0+ #79
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:strlen+0x1a/0x90
Code: 23 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 b8 00 00 00 00
00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04
02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0018:ffffc90002bfedd8 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: 1ffff9200057fdc1 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000039 R09: ffffed1023549801
R10: ffff88811aa4c007 R11: ffffed1023549800 R12: ffff88800bc68d6c
R13: ffffc90002bfef08 R14: ffff88800bc6bc7c R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020546180 CR3: 0000000117ff1000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 brcmf_c_preinit_dcmds+0x9f2/0xc40
 ? brcmf_c_set_joinpref_default+0x100/0x100
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lock_acquire+0x19d/0x4e0
 ? find_held_lock+0x2d/0x110
 ? brcmf_usb_deq+0x1a7/0x260
 ? brcmf_usb_rx_fill_all+0x5a/0xf0
 brcmf_attach+0x246/0xd40
 ? wiphy_new_nm+0x1703/0x1dd0
 ? kmemdup+0x43/0x50
 brcmf_usb_probe+0x12de/0x1690
 ? brcmf_usbdev_qinit.constprop.0+0x470/0x470
 usb_probe_interface+0x2aa/0x760
 ? usb_probe_device+0x250/0x250
 really_probe+0x205/0xb70
 ? driver_allows_async_probing+0x130/0x130
 __driver_probe_device+0x311/0x4b0
 ? driver_allows_async_probing+0x130/0x130
 driver_probe_device+0x4e/0x150
 __device_attach_driver+0x1cc/0x2a0
 bus_for_each_drv+0x156/0x1d0
 ? bus_rescan_devices+0x30/0x30
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 ? trace_hardirqs_on+0x46/0x160
 __device_attach+0x23f/0x3a0
 ? device_bind_driver+0xd0/0xd0
 ? kobject_uevent_env+0x287/0x14b0
 bus_probe_device+0x1da/0x290
 device_add+0xb7b/0x1eb0
 ? wait_for_completion+0x290/0x290
 ? __fw_devlink_link_to_suppliers+0x5a0/0x5a0
 usb_set_configuration+0xf59/0x16f0
 usb_generic_driver_probe+0x82/0xa0
 usb_probe_device+0xbb/0x250
 ? usb_suspend+0x590/0x590
 really_probe+0x205/0xb70
 ? driver_allows_async_probing+0x130/0x130
 __driver_probe_device+0x311/0x4b0
 ? usb_generic_driver_match+0x75/0x90
 ? driver_allows_async_probing+0x130/0x130
 driver_probe_device+0x4e/0x150
 __device_attach_driver+0x1cc/0x2a0
 bus_for_each_drv+0x156/0x1d0
 ? bus_rescan_devices+0x30/0x30
 ? _raw_spin_unlock_irqrestore+0x47/0x50
 __device_attach+0x23f/0x3a0
 ? device_bind_driver+0xd0/0xd0
 ? kobject_uevent_env+0x287/0x14b0
 bus_probe_device+0x1da/0x290
 device_add+0xb7b/0x1eb0
 ? __fw_devlink_link_to_suppliers+0x5a0/0x5a0
 ? kfree+0x14a/0x6b0
 ? __usb_get_extra_descriptor+0x116/0x160
 usb_new_device.cold+0x49c/0x1029
 ? hub_disconnect+0x450/0x450
 ? rwlock_bug.part.0+0x90/0x90
 ? _raw_spin_unlock_irq+0x24/0x30
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 hub_event+0x248b/0x31c9
 ? usb_port_suspend.cold+0x139/0x139
 ? check_irq_usage+0x861/0xf20
 ? drain_workqueue+0x280/0x360
 ? lock_release+0x640/0x640
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 process_one_work+0x92b/0x1460
 ? pwq_dec_nr_in_flight+0x330/0x330
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x95/0xe00
 ? __kthread_parkme+0x115/0x1e0
 ? process_one_work+0x1460/0x1460
 kthread+0x3a1/0x480
 ? set_kthread_struct+0x120/0x120
 ret_from_fork+0x1f/0x30
Modulesdd linked in:
---[ end trace c112c68924ddd800 ]---
RIP: 0010:strlen+0x1a/0x90
Code: 23 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 b8 00 00 00 00
00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04
02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0018:ffffc90002bfedd8 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: 1ffff9200057fdc1 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000039 R09: ffffed1023549801
R10: ffff88811aa4c007 R11: ffffed1023549800 R12: ffff88800bc68d6c
R13: ffffc90002bfef08 R14: ffff88800bc6bc7c R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020546180 CR3: 0000000117ff1000 CR4: 0000000000750ef0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
---
v1->v2: Rebase the patch to latest version

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 74020fa10065..22344e68fd59 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -305,8 +305,12 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 	brcmf_info("Firmware: %s %s\n", ri->chipname, buf);
 
 	/* locate firmware version number for ethtool */
-	ptr = strrchr(buf, ' ') + 1;
-	strscpy(ifp->drvr->fwver, ptr, sizeof(ifp->drvr->fwver));
+	ptr = strrchr(buf, ' ');
+	if (!ptr) {
+		bphy_err(drvr, "Retrieving version number failed");
+		goto done;
+	}
+	strscpy(ifp->drvr->fwver, ptr + 1, sizeof(ifp->drvr->fwver));
 
 	/* Query for 'clmver' to get CLM version info from firmware */
 	memset(buf, 0, sizeof(buf));
-- 
2.25.1

