Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46106B21C7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 11:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCIKp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjCIKpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 05:45:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A920A1F
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 02:45:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so1657479pja.5
        for <linux-wireless@vger.kernel.org>; Thu, 09 Mar 2023 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112; t=1678358701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFpUJD0HKtCya+XmYxzJS+pgel8DWBJD7mpAc2TjXqU=;
        b=mcgzmHICRCxz5aSTjq6VBNG3SeN9RwOiVSmHHUrQCpxX2qSh1tJs68R1ciivyr/zi9
         pyhBlA+Xtw+GDqZvX6q92+dYIWpndguqK5f8sVWEwjfQa97OLhI5EFhjtAaex98YIKQH
         vQq3twYxPQy0s5weorAViLPBGbprCvDfCTUiJTmV3nOQnMXhmlbJICXqrxfd2JZ0lHOq
         6FqlterM0llP5O60CWlgndYBFTUBoHzRi3k2QvpLePkaZ3iEcA96mGANzlQVxlglojDI
         NIuzcuES0xTCDFKBkUWC+gowwDmtoyX1aAZc8LwOeA7sEG86Q6QIjUXwTCtJ8ZlKmqav
         dKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFpUJD0HKtCya+XmYxzJS+pgel8DWBJD7mpAc2TjXqU=;
        b=KRULO+VEcOqn4hJoLEVr1FjIg92u3x+RtMZoFOndm3DdeT2TIfW3qYUAEgOWgYrldM
         20hdzfDONNB1W+vja3ih2GimQiSIhIhLYYWlqImaRTT1/X6zq/JagQQSbDWFo4ZJIkY8
         Vgw0BuBgeoT46iJl/AJ7Xzs+L2RAHaRYOl1o5vNEIF0hmT65osQScV6gSBm49gtoa6qk
         KX0aeCNwpVNhw5SfA7JAep4Owd1dSAi3ZNVGdhHyh6RhwBe8uzP+txhX1jfXWihRBKkp
         HHpczkKPS6Y4pu4bpriDBEWKwCgsdXXkZykmpfm+49+hAb2WsUMmg7OhI1g5Xt7Uu1u0
         9ogQ==
X-Gm-Message-State: AO0yUKWXS+glQuYRsNs+wnSIdYysxDFubYLBqKSyyJ6J+OJLXYI43H2u
        6Tzk5OQ4tO0ugavU/ijyq6CXmSniaeBDVqD+5w==
X-Google-Smtp-Source: AK7set9r0K4zzqLljxsUTkxb6+VTyQt4rNQk72NT28AS8u8w6PaBZsGYaItgAn0P1rjSYdaOLgnl2g==
X-Received: by 2002:a17:902:d2cd:b0:19c:f005:92de with SMTP id n13-20020a170902d2cd00b0019cf00592demr24312674plc.4.1678358701113;
        Thu, 09 Mar 2023 02:45:01 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.55])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170902f94b00b0019edc1b421asm4507198plb.163.2023.03.09.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:45:00 -0800 (PST)
From:   Jisoo Jang <jisoo.jang@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, arend.vanspriel@broadcom.com
Cc:     dokyungs@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr
Subject: [PATCH v2] wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()
Date:   Thu,  9 Mar 2023 19:44:57 +0900
Message-Id: <20230309104457.22628-1-jisoo.jang@yonsei.ac.kr>
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

Fix a slab-out-of-bounds read that occurs in kmemdup() called from
brcmf_get_assoc_ies().
The bug could occur when assoc_info->req_len, data from a URB provided
by a USB device, is bigger than the size of buffer which is defined as
WL_EXTRA_BUF_MAX.

Add the size check for req_len/resp_len of assoc_info.

Found by a modified version of syzkaller.

[   46.592467][    T7] ==================================================================
[   46.594687][    T7] BUG: KASAN: slab-out-of-bounds in kmemdup+0x3e/0x50
[   46.596572][    T7] Read of size 3014656 at addr ffff888019442000 by task kworker/0:1/7
[   46.598575][    T7]
[   46.599157][    T7] CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: G           O      5.14.0+ #145
[   46.601333][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   46.604360][    T7] Workqueue: events brcmf_fweh_event_worker
[   46.605943][    T7] Call Trace:
[   46.606584][    T7]  dump_stack_lvl+0x8e/0xd1
[   46.607446][    T7]  print_address_description.constprop.0.cold+0x93/0x334
[   46.608610][    T7]  ? kmemdup+0x3e/0x50
[   46.609341][    T7]  kasan_report.cold+0x79/0xd5
[   46.610151][    T7]  ? kmemdup+0x3e/0x50
[   46.610796][    T7]  kasan_check_range+0x14e/0x1b0
[   46.611691][    T7]  memcpy+0x20/0x60
[   46.612323][    T7]  kmemdup+0x3e/0x50
[   46.612987][    T7]  brcmf_get_assoc_ies+0x967/0xf60
[   46.613904][    T7]  ? brcmf_notify_vif_event+0x3d0/0x3d0
[   46.614831][    T7]  ? lock_chain_count+0x20/0x20
[   46.615683][    T7]  ? mark_lock.part.0+0xfc/0x2770
[   46.616552][    T7]  ? lock_chain_count+0x20/0x20
[   46.617409][    T7]  ? mark_lock.part.0+0xfc/0x2770
[   46.618244][    T7]  ? lock_chain_count+0x20/0x20
[   46.619024][    T7]  brcmf_bss_connect_done.constprop.0+0x241/0x2e0
[   46.620019][    T7]  ? brcmf_parse_configure_security.isra.0+0x2a0/0x2a0
[   46.620818][    T7]  ? __lock_acquire+0x181f/0x5790
[   46.621462][    T7]  brcmf_notify_connect_status+0x448/0x1950
[   46.622134][    T7]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   46.622736][    T7]  ? brcmf_cfg80211_join_ibss+0x7b0/0x7b0
[   46.623390][    T7]  ? find_held_lock+0x2d/0x110
[   46.623962][    T7]  ? brcmf_fweh_event_worker+0x19f/0xc60
[   46.624603][    T7]  ? mark_held_locks+0x9f/0xe0
[   46.625145][    T7]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[   46.625871][    T7]  ? brcmf_cfg80211_join_ibss+0x7b0/0x7b0
[   46.626545][    T7]  brcmf_fweh_call_event_handler.isra.0+0x90/0x100
[   46.627338][    T7]  brcmf_fweh_event_worker+0x557/0xc60
[   46.627962][    T7]  ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
[   46.628736][    T7]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   46.629396][    T7]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   46.629970][    T7]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   46.630649][    T7]  process_one_work+0x92b/0x1460
[   46.631205][    T7]  ? pwq_dec_nr_in_flight+0x330/0x330
[   46.631821][    T7]  ? rwlock_bug.part.0+0x90/0x90
[   46.632347][    T7]  worker_thread+0x95/0xe00
[   46.632832][    T7]  ? __kthread_parkme+0x115/0x1e0
[   46.633393][    T7]  ? process_one_work+0x1460/0x1460
[   46.633957][    T7]  kthread+0x3a1/0x480
[   46.634369][    T7]  ? set_kthread_struct+0x120/0x120
[   46.634933][    T7]  ret_from_fork+0x1f/0x30
[   46.635431][    T7]
[   46.635687][    T7] Allocated by task 7:
[   46.636151][    T7]  kasan_save_stack+0x1b/0x40
[   46.636628][    T7]  __kasan_kmalloc+0x7c/0x90
[   46.637108][    T7]  kmem_cache_alloc_trace+0x19e/0x330
[   46.637696][    T7]  brcmf_cfg80211_attach+0x4a0/0x4040
[   46.638275][    T7]  brcmf_attach+0x389/0xd40
[   46.638739][    T7]  brcmf_usb_probe+0x12de/0x1690
[   46.639279][    T7]  usb_probe_interface+0x2aa/0x760
[   46.639820][    T7]  really_probe+0x205/0xb70
[   46.640342][    T7]  __driver_probe_device+0x311/0x4b0
[   46.640876][    T7]  driver_probe_device+0x4e/0x150
[   46.641445][    T7]  __device_attach_driver+0x1cc/0x2a0
[   46.642000][    T7]  bus_for_each_drv+0x156/0x1d0
[   46.642543][    T7]  __device_attach+0x23f/0x3a0
[   46.643065][    T7]  bus_probe_device+0x1da/0x290
[   46.643644][    T7]  device_add+0xb7b/0x1eb0
[   46.644130][    T7]  usb_set_configuration+0xf59/0x16f0
[   46.644720][    T7]  usb_generic_driver_probe+0x82/0xa0
[   46.645295][    T7]  usb_probe_device+0xbb/0x250
[   46.645786][    T7]  really_probe+0x205/0xb70
[   46.646258][    T7]  __driver_probe_device+0x311/0x4b0
[   46.646804][    T7]  driver_probe_device+0x4e/0x150
[   46.647387][    T7]  __device_attach_driver+0x1cc/0x2a0
[   46.647926][    T7]  bus_for_each_drv+0x156/0x1d0
[   46.648454][    T7]  __device_attach+0x23f/0x3a0
[   46.648939][    T7]  bus_probe_device+0x1da/0x290
[   46.649478][    T7]  device_add+0xb7b/0x1eb0
[   46.649936][    T7]  usb_new_device.cold+0x49c/0x1029
[   46.650526][    T7]  hub_event+0x1c98/0x3950
[   46.650975][    T7]  process_one_work+0x92b/0x1460
[   46.651535][    T7]  worker_thread+0x95/0xe00
[   46.651991][    T7]  kthread+0x3a1/0x480
[   46.652413][    T7]  ret_from_fork+0x1f/0x30
[   46.652885][    T7]
[   46.653131][    T7] The buggy address belongs to the object at ffff888019442000
[   46.653131][    T7]  which belongs to the cache kmalloc-2k of size 2048
[   46.654669][    T7] The buggy address is located 0 bytes inside of
[   46.654669][    T7]  2048-byte region [ffff888019442000, ffff888019442800)
[   46.656137][    T7] The buggy address belongs to the page:
[   46.656720][    T7] page:ffffea0000651000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19440
[   46.657792][    T7] head:ffffea0000651000 order:3 compound_mapcount:0 compound_pincount:0
[   46.658673][    T7] flags: 0x100000000010200(slab|head|node=0|zone=1)
[   46.659422][    T7] raw: 0100000000010200 0000000000000000 dead000000000122 ffff888100042000
[   46.660363][    T7] raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
[   46.661236][    T7] page dumped because: kasan: bad access detected
[   46.661956][    T7] page_owner tracks the page as allocated
[   46.662588][    T7] page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7, ts 31136961085, free_ts 0
[   46.664271][    T7]  prep_new_page+0x1aa/0x240
[   46.664763][    T7]  get_page_from_freelist+0x159a/0x27c0
[   46.665340][    T7]  __alloc_pages+0x2da/0x6a0
[   46.665847][    T7]  alloc_pages+0xec/0x1e0
[   46.666308][    T7]  allocate_slab+0x380/0x4e0
[   46.666770][    T7]  ___slab_alloc+0x5bc/0x940
[   46.667264][    T7]  __slab_alloc+0x6d/0x80
[   46.667712][    T7]  kmem_cache_alloc_trace+0x30a/0x330
[   46.668299][    T7]  brcmf_usbdev_qinit.constprop.0+0x50/0x470
[   46.668885][    T7]  brcmf_usb_probe+0xc97/0x1690
[   46.669438][    T7]  usb_probe_interface+0x2aa/0x760
[   46.669988][    T7]  really_probe+0x205/0xb70
[   46.670487][    T7]  __driver_probe_device+0x311/0x4b0
[   46.671031][    T7]  driver_probe_device+0x4e/0x150
[   46.671604][    T7]  __device_attach_driver+0x1cc/0x2a0
[   46.672192][    T7]  bus_for_each_drv+0x156/0x1d0
[   46.672739][    T7] page_owner free stack trace missing
[   46.673335][    T7]
[   46.673620][    T7] Memory state around the buggy address:
[   46.674213][    T7]  ffff888019442700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   46.675083][    T7]  ffff888019442780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   46.675994][    T7] >ffff888019442800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.676875][    T7]                    ^
[   46.677323][    T7]  ffff888019442880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.678190][    T7]  ffff888019442900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.679052][    T7] ==================================================================
[   46.679945][    T7] Disabling lock debugging due to kernel taint
[   46.680725][    T7] Kernel panic - not syncing:

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
---
v1->v2: Integrate two size checks

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a9690ec4c850..5a9f713ea703 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6164,6 +6164,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
-- 
2.25.1

