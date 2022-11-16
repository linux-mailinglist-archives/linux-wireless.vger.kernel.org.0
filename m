Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B499062C1AE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 16:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiKPPAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 10:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiKPO7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 09:59:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C3E2A955
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 06:58:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z26so17715037pff.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad2A2hFXN1uQyJwE/8f6ZJiNXp0QN42x1D4UKZjZKTE=;
        b=2vxEcTnxD4S9bAadC1SMSAR2PAuWLuAOMDl6y/mirJWDVH63uvlNFjpR2dHPZz7540
         sgOLBWXW3sNxaaCt0PhKB6WTDfZYn62neQewD5/BLtga7gmNHO1EtKGEQABW5OHC2w9r
         y4JrMb2F/55Rd3lleVsRGYtmodb/3yKLamEtQUtjdlCtUO8xHl+P3om/hSJIIl7+Eeas
         2tufNQZOQjXP49YC1eQXPCq15gtsikImDfCc0maPzWiQD6YP68plh/fHkXXkpkDTruNu
         5vmrDembZ0HjTU3/w5y4ndpMJ+/3cTZ+K9vh/GYdbQszfONWGGeRoqDpWPNIYGzI6Ku+
         j3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad2A2hFXN1uQyJwE/8f6ZJiNXp0QN42x1D4UKZjZKTE=;
        b=7SLnxBDAUG2RlsezDHWw0cDlTQkZOABNJC6czIbBaIhhFGr+ByAbor0eu7ZN4mOsKs
         tsiDLGCsQcJRbhQ0XCu3CkyFb4T/r90iiZr22gcOGlsypffTNu9xYNF/I4dCuPEqP5A5
         UEQjCyYc/0CydPMaAnyfs4S7LSy5yra+QnrZ25IPoU7Gq9FBmcaCKbb/9dC2RUz9SKvK
         omaZ7L4dq0DR2rp/Xzhq/m2uDCXmRi/FAc3vcYGj5qTneFiGYZIvB7FrdgV19wtc2QEo
         8jprVaK4vtYYbx+GMkTsoFoGvSEuWRcb/wEwJa+hPjaT1hlw2TYVAt6mkigeMUevusFF
         FsYA==
X-Gm-Message-State: ANoB5pnjWKyms/b6YAPg6F4ALdmBB3Nb6QIvQSi4RB/tZz0dR5UcPYKC
        gE0VaBeKHVlNHt2IoU4ViILlBRnGCD+iS95y
X-Google-Smtp-Source: AA0mqf6FJcILQCaxmfCNhfqJnSw51U604dZNKr0STY9Upxn9Gx43qTYJNpMQm9iICwOn8lXQCMW0OQ==
X-Received: by 2002:a63:f1a:0:b0:476:e3bb:2340 with SMTP id e26-20020a630f1a000000b00476e3bb2340mr3917290pgl.530.1668610733877;
        Wed, 16 Nov 2022 06:58:53 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b00186b04776b0sm12290234pli.118.2022.11.16.06.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:58:53 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org
Cc:     arend.vanspriel@broadcom.com, dokyungs@yonsei.ac.kr,
        jisoo.jang@yonsei.ac.kr, Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] wifi: brcmfmac: Fix potential slab-out-of-bounds read in brcmf_inform_single_bss()
Date:   Wed, 16 Nov 2022 23:58:21 +0900
Message-Id: <20221116145821.544266-1-linuxlovemin@yonsei.ac.kr>
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

This patch fixes a slab-out-of-bounds read in brcmfmac that occurs in
cfg80211_find_elem_match() called from brcmf_inform_single_bss() when
the offset and length values of information elements provided by the
device exceed the boundary of the escan buffer that contains information
elements. The patch adds a check that makes the function return -EINVAL
if that is the case. Note that the negative return is handled by the
caller, brcmf_inform_bss().

Found by a modified version of syzkaller.

==================================================================
BUG: KASAN: slab-out-of-bounds in cfg80211_find_elem_match+0x164/0x180
Read of size 1 at addr ffff888018f0fde9 by task kworker/0:2/1896

CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #139
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: events brcmf_fweh_event_worker
Call Trace:
 dump_stack_lvl+0x8e/0xd1
 print_address_description.constprop.0.cold+0x93/0x334
 ? cfg80211_find_elem_match+0x164/0x180
 kasan_report.cold+0x79/0xd5
 ? cfg80211_find_elem_match+0x164/0x180
 cfg80211_find_elem_match+0x164/0x180
 cfg80211_get_bss_channel+0x69/0x320
 cfg80211_inform_single_bss_data+0x1a6/0x1060
 ? cfg80211_bss_update+0x1e20/0x1e20
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? find_held_lock+0x2d/0x110
 ? cfg80211_inform_bss_data+0xcb/0x160
 cfg80211_inform_bss_data+0xcb/0x160
 ? cfg80211_parse_mbssid_data+0x1540/0x1540
 ? kvm_clock_get_cycles+0x14/0x20
 ? ktime_get_with_offset+0x2b9/0x450
 brcmf_inform_single_bss+0x36d/0x4d0
 ? brcmf_notify_mic_status+0xb0/0xb0
 ? __lock_acquire+0x181f/0x5790
 ? brcmf_p2p_cancel_remain_on_channel+0x30/0x30
 brcmf_inform_bss+0x131/0x210
 brcmf_cfg80211_escan_handler+0x779/0xd20
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lock_acquire+0x19d/0x4e0
 ? find_held_lock+0x2d/0x110
 ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
 ? brcmf_fweh_event_worker+0x249/0xc00
 ? mark_held_locks+0x9f/0xe0
 ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
 ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
 brcmf_fweh_call_event_handler.isra.0+0x90/0x100
 brcmf_fweh_event_worker+0x117/0xc00
 ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
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
page:ffffea000063c000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18f00
head:ffffea000063c000 order:4 compound_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=1)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 4, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 1896, ts 44510886600, free_ts 0
 prep_new_page+0x1aa/0x240
 get_page_from_freelist+0x159a/0x27c0
 __alloc_pages+0x2da/0x6a0
 alloc_pages+0xec/0x1e0
 kmalloc_order+0x39/0xf0
 kmalloc_order_trace+0x19/0x120
 brcmf_cfg80211_attach+0x5c9/0x3fd0
 brcmf_attach+0x389/0xd40
 brcmf_usb_probe+0x12de/0x1690
 usb_probe_interface+0x2aa/0x760
 really_probe+0x205/0xb70
 __driver_probe_device+0x311/0x4b0
 driver_probe_device+0x4e/0x150
 __device_attach_driver+0x1cc/0x2a0
 bus_for_each_drv+0x156/0x1d0
 __device_attach+0x23f/0x3a0
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888018f0fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888018f0fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888018f0fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe fe fe
                                                          ^
 ffff888018f0fe00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888018f0fe80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
v1->v2: Use the correct format for size_t in bphy_err()

 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index ae9507dec74a..2148027eb42b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3298,6 +3298,13 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	notify_ielen = le32_to_cpu(bi->ie_length);
 	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
 
+	if ((unsigned long)notify_ie + notify_ielen -
+		(unsigned long)cfg->escan_info.escan_buf > BRCMF_ESCAN_BUF_SIZE) {
+		bphy_err(drvr, "Invalid information element offset: %u, length: %zu\n",
+			 le16_to_cpu(bi->ie_offset), notify_ielen);
+		return -EINVAL;
+	}
+
 	brcmf_dbg(CONN, "bssid: %pM\n", bi->BSSID);
 	brcmf_dbg(CONN, "Channel: %d(%d)\n", channel, freq);
 	brcmf_dbg(CONN, "Capability: %X\n", notify_capability);
-- 
2.25.1

