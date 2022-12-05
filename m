Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECA64212B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiLEBoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Dec 2022 20:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiLEBoN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Dec 2022 20:44:13 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2A5F91
        for <linux-wireless@vger.kernel.org>; Sun,  4 Dec 2022 17:44:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c13so2843121pfp.5
        for <linux-wireless@vger.kernel.org>; Sun, 04 Dec 2022 17:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay6xEaNIZu3dbyCk6HcOQSiqlmMapsolc6B/qhCKOOk=;
        b=zJYyx+LDT6glzMagYiI2uGM472jJ2pCGxnZF6cAXUQv3LcUFmuvNFOyfC+As8BGMNR
         1KAVsnK6I+xIuBymDLuHFAiDdPV1YZYLrzQJK598lBh56sDPszoxlvCUQazrnyn1nQ93
         FevSOvEG7lxIdPJMQjfRBD4PgR9KFbIgTt2VTkr6P9yUy7wWbHbXgfvoM7gJo/VPlcO1
         WY8BYNkTt9s8hnqonbHAi6PkWgNhehp2CI22zS1kSLReQRb6RAOfJSyibbe+VGDZADGC
         gq4+X1Vt6iSp0oXOC5tc4eHrW36nyXP6thB1lmgajPsT6U/0YZSsKU1nlWnpmXJiHEkt
         UmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay6xEaNIZu3dbyCk6HcOQSiqlmMapsolc6B/qhCKOOk=;
        b=8E6BHT+aIZEi4lyFPS2f+YEQDZZDX+u1MdkDkSM9cXW7ukxO6Pup1zhldfzJazwJPu
         TeaHRagsMJbhQCwPTJnsz4VabwFKw9fCxqU3hxklnKUpVn8VPXsgLf8q/CpDHIw/amya
         ljvZL/uPms4Bv8Z6S2H6ikPICuLEPqgrOIAFUGQrYZR2DgN051bViemZuERlpv/oSCcW
         PFGgrxly1ovPvcP77NCAnSqBmTRQ1WOf5/0tPB4ClhBQkDhjXcMSlRA//n7D1tNywlmS
         wkTusFmLq6rb4aLy2YrigFFK6DYDGSxZ+WFhU2XBcBLeZ56RtnQM0KYJfQ8eO3+TS56N
         wjOg==
X-Gm-Message-State: ANoB5pkZECpgfKC84xO+NUy1cMcmX9iumiUGuGVy6eykdMi5fW8xv37X
        l37YQ07ojUvhiol/qz10AjfuZ+xC41GTpGRe
X-Google-Smtp-Source: AA0mqf5aTID0imcAmC/QtLbnc1Q+fFsS05b9c+ERiG/4+yV2hv9eY2437pgz43Cnv2FRunifKbJVMQ==
X-Received: by 2002:a63:f5a:0:b0:470:18d4:f18d with SMTP id 26-20020a630f5a000000b0047018d4f18dmr54691385pgp.295.1670204646630;
        Sun, 04 Dec 2022 17:44:06 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ff0200b0018975488514sm9265172plj.126.2022.12.04.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:44:06 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, toke@toke.dk
Cc:     dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] ath9k: Fix use-after-free in ath9k_hif_usb_disconnect()
Date:   Mon,  5 Dec 2022 10:43:08 +0900
Message-Id: <20221205014308.1617597-1-linuxlovemin@yonsei.ac.kr>
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

This patch fixes a use-after-free in ath9k that occurs in
ath9k_hif_usb_disconnect() when ath9k_destroy_wmi() is trying to access
'drv_priv' that has already been freed by ieee80211_free_hw(), called by
ath9k_htc_hw_deinit(). The patch moves ath9k_destroy_wmi() before
ieee80211_free_hw(). Note that urbs from the driver should be killed
before freeing 'wmi' with ath9k_destroy_wmi() as their callbacks will
access 'wmi'.

Found by a modified version of syzkaller.

==================================================================
BUG: KASAN: use-after-free in ath9k_destroy_wmi+0x38/0x40
Read of size 8 at addr ffff8881069132a0 by task kworker/0:1/7

CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: G O 5.14.0+ #131
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 dump_stack_lvl+0x8e/0xd1
 print_address_description.constprop.0.cold+0x93/0x334
 ? ath9k_destroy_wmi+0x38/0x40
 ? ath9k_destroy_wmi+0x38/0x40
 kasan_report.cold+0x83/0xdf
 ? ath9k_destroy_wmi+0x38/0x40
 ath9k_destroy_wmi+0x38/0x40
 ath9k_hif_usb_disconnect+0x329/0x3f0
 ? ath9k_hif_usb_suspend+0x120/0x120
 ? usb_disable_interface+0xfc/0x180
 usb_unbind_interface+0x19b/0x7e0
 ? usb_autoresume_device+0x50/0x50
 device_release_driver_internal+0x44d/0x520
 bus_remove_device+0x2e5/0x5a0
 device_del+0x5b2/0xe30
 ? __device_link_del+0x370/0x370
 ? usb_remove_ep_devs+0x43/0x80
 ? remove_intf_ep_devs+0x112/0x1a0
 usb_disable_device+0x1e3/0x5a0
 usb_disconnect+0x267/0x870
 hub_event+0x168d/0x3950
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? hub_port_debounce+0x2e0/0x2e0
 ? check_irq_usage+0x860/0xf20
 ? drain_workqueue+0x281/0x360
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

The buggy address belongs to the page:
page:ffffea00041a44c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106913
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 7, ts 38347963444, free_ts 41399957635
 prep_new_page+0x1aa/0x240
 get_page_from_freelist+0x159a/0x27c0
 __alloc_pages+0x2da/0x6a0
 alloc_pages+0xec/0x1e0
 kmalloc_order+0x39/0xf0
 kmalloc_order_trace+0x19/0x120
 __kmalloc+0x308/0x390
 wiphy_new_nm+0x6f5/0x1dd0
 ieee80211_alloc_hw_nm+0x36d/0x2230
 ath9k_htc_probe_device+0x9d/0x1e10
 ath9k_htc_hw_init+0x34/0x50
 ath9k_hif_usb_firmware_cb+0x25f/0x4e0
 request_firmware_work_func+0x131/0x240
 process_one_work+0x92b/0x1460
 worker_thread+0x95/0xe00
 kthread+0x3a1/0x480
page last free stack trace:
 free_pcp_prepare+0x3d3/0x7f0
 free_unref_page+0x1e/0x3d0
 device_release+0xa4/0x240
 kobject_put+0x186/0x4c0
 put_device+0x20/0x30
 ath9k_htc_disconnect_device+0x1cf/0x2c0
 ath9k_htc_hw_deinit+0x26/0x30
 ath9k_hif_usb_disconnect+0x2d9/0x3f0
 usb_unbind_interface+0x19b/0x7e0
 device_release_driver_internal+0x44d/0x520
 bus_remove_device+0x2e5/0x5a0
 device_del+0x5b2/0xe30
 usb_disable_device+0x1e3/0x5a0
 usb_disconnect+0x267/0x870
 hub_event+0x168d/0x3950
 process_one_work+0x92b/0x1460

Memory state around the buggy address:
 ffff888106913180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888106913200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888106913280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff888106913300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888106913380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 2 --
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 1a2e0c7eeb02..86ede591dafa 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1411,8 +1411,6 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
 
 	if (hif_dev->flags & HIF_USB_READY) {
 		ath9k_htc_hw_deinit(hif_dev->htc_handle, unplugged);
-		ath9k_hif_usb_dev_deinit(hif_dev);
-		ath9k_destroy_wmi(hif_dev->htc_handle->drv_priv);
 		ath9k_htc_hw_free(hif_dev->htc_handle);
 	}
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 07ac88fb1c57..96a3185a96d7 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -988,6 +988,8 @@ void ath9k_htc_disconnect_device(struct htc_target *htc_handle, bool hotunplug)
 
 		ath9k_deinit_device(htc_handle->drv_priv);
 		ath9k_stop_wmi(htc_handle->drv_priv);
+		ath9k_hif_usb_dealloc_urbs((struct hif_device_usb *)htc_handle->hif_dev);
+		ath9k_destroy_wmi(htc_handle->drv_priv);
 		ieee80211_free_hw(htc_handle->drv_priv->hw);
 	}
 }
-- 
2.25.1

