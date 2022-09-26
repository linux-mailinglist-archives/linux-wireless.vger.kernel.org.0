Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3205EB33C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIZVgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 17:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiIZVga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 17:36:30 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E9A4062
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 14:36:27 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.120])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E3D231C007D
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 21:36:25 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B3D6834007F
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 21:36:25 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 46EC713C2B0;
        Mon, 26 Sep 2022 14:36:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 46EC713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664228185;
        bh=x1AtGXhEGHEIVHDfPYyqs4ykDW7sEKO9WVnHcwAJEGk=;
        h=From:To:Cc:Subject:Date:From;
        b=JNDr3mDWsJpeleY90zUTH6KHWU9y3/FIZRNlMcNZBP2v0TU8BM8l3Kd4fGNqUsXfd
         TKT/jR0fC6Y4n4ocP92tL8j25Kdzenm7Re/0vPFLu78OYEFAc4vjxPzMyMPjKac67H
         hA4VgPeZtBL7plA1VxUgY40SWxUU0fiYTPykZl7Y=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [RFC] wifi: iwlwifi: fix double free on tx path.
Date:   Mon, 26 Sep 2022 14:36:23 -0700
Message-Id: <20220926213623.11348-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1664228186-AlYWmy6BPrma
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

We see kernel crashes and lockups and KASAN errors related to ax210
firmware crashes.  One of the KASAN dumps pointed at the tx path,
and it appears there is indeed a way to double-free an skb.

If iwl_mvm_tx_skb_sta returns non-zero, then the 'skb' sent into the
method will be freed.  But, in case where we build TSO skb buffer,
the skb may also be freed in error case.  So, return 0 in that particular
error case and do cleanup manually.

BUG: KASAN: use-after-free in __list_del_entry_valid+0x12/0x90
iwlwifi 0000:06:00.0: 0x00000000 | tsf hi
Read of size 8 at addr ffff88813cfa4ba0 by task btserver/9650

CPU: 4 PID: 9650 Comm: btserver Tainted: G        W         5.19.8+ #5
iwlwifi 0000:06:00.0: 0x00000000 | time gp1
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Call Trace:
 <TASK>
 dump_stack_lvl+0x55/0x6d
 print_report.cold.12+0xf2/0x684
iwlwifi 0000:06:00.0: 0x1D0915A8 | time gp2
 ? __list_del_entry_valid+0x12/0x90
 kasan_report+0x8b/0x180
iwlwifi 0000:06:00.0: 0x00000001 | uCode revision type
 ? __list_del_entry_valid+0x12/0x90
 __list_del_entry_valid+0x12/0x90
iwlwifi 0000:06:00.0: 0x00000048 | uCode version major
 tcp_update_skb_after_send+0x5d/0x170
 __tcp_transmit_skb+0xb61/0x15c0
iwlwifi 0000:06:00.0: 0xDAA05125 | uCode version minor
 ? __tcp_select_window+0x490/0x490
iwlwifi 0000:06:00.0: 0x00000420 | hw version
 ? trace_kmalloc_node+0x29/0xd0
 ? __kmalloc_node_track_caller+0x12a/0x260
 ? memset+0x1f/0x40
 ? __build_skb_around+0x125/0x150
 ? __alloc_skb+0x1d4/0x220
 ? skb_zerocopy_clone+0x55/0x230
iwlwifi 0000:06:00.0: 0x00489002 | board version
 ? kmalloc_reserve+0x80/0x80
 ? rcu_read_lock_bh_held+0x60/0xb0
 tcp_write_xmit+0x3f1/0x24d0
iwlwifi 0000:06:00.0: 0x034E001C | hcmd
 ? __check_object_size+0x180/0x350
iwlwifi 0000:06:00.0: 0x24020000 | isr0
 tcp_sendmsg_locked+0x8a9/0x1520
iwlwifi 0000:06:00.0: 0x01400000 | isr1
 ? tcp_sendpage+0x50/0x50
iwlwifi 0000:06:00.0: 0x48F0000A | isr2
 ? lock_release+0xb9/0x400
 ? tcp_sendmsg+0x14/0x40
iwlwifi 0000:06:00.0: 0x00C3080C | isr3
 ? lock_downgrade+0x390/0x390
 ? do_raw_spin_lock+0x114/0x1d0
iwlwifi 0000:06:00.0: 0x00200000 | isr4
 ? rwlock_bug.part.2+0x50/0x50
iwlwifi 0000:06:00.0: 0x034A001C | last cmd Id
 ? rwlock_bug.part.2+0x50/0x50
 ? lockdep_hardirqs_on_prepare+0xe/0x200
iwlwifi 0000:06:00.0: 0x0000C2F0 | wait_event
 ? __local_bh_enable_ip+0x87/0xe0
 ? inet_send_prepare+0x220/0x220
iwlwifi 0000:06:00.0: 0x000000C4 | l2p_control
 tcp_sendmsg+0x22/0x40
 sock_sendmsg+0x5f/0x70
iwlwifi 0000:06:00.0: 0x00010034 | l2p_duration
 __sys_sendto+0x19d/0x250
iwlwifi 0000:06:00.0: 0x00000007 | l2p_mhvalid
 ? __ia32_sys_getpeername+0x40/0x40
iwlwifi 0000:06:00.0: 0x00000000 | l2p_addr_match
 ? rcu_read_lock_held_common+0x12/0x50
 ? rcu_read_lock_sched_held+0x5a/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? rcu_read_lock_sched_held+0x5a/0xd0
 ? rcu_read_lock_sched_held+0x5a/0xd0
 ? lock_release+0xb9/0x400
 ? lock_downgrade+0x390/0x390
 ? ktime_get+0x64/0x130
 ? ktime_get+0x8d/0x130
 ? rcu_read_lock_held_common+0x12/0x50
 ? rcu_read_lock_sched_held+0x5a/0xd0
 ? rcu_read_lock_held_common+0x12/0x50
 ? rcu_read_lock_sched_held+0x5a/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 __x64_sys_sendto+0x6f/0x80
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f1d126e4531
Code: 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 35 80 0c 00 41 89 ca 8b 00 85 c0 75 1c 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
RSP: 002b:00007ffe21a679d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000000000000ffdc RCX: 00007f1d126e4531
RDX: 0000000000010000 RSI: 000000000374acf0 RDI: 0000000000000014
RBP: 00007ffe21a67ac0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 </TASK>

Allocated by task 9650:
 kasan_save_stack+0x1c/0x40
 __kasan_slab_alloc+0x6d/0x90
 kmem_cache_alloc_node+0xf3/0x2b0
 __alloc_skb+0x191/0x220
 tcp_stream_alloc_skb+0x3f/0x330
 tcp_sendmsg_locked+0x67c/0x1520
 tcp_sendmsg+0x22/0x40
 sock_sendmsg+0x5f/0x70
 __sys_sendto+0x19d/0x250
 __x64_sys_sendto+0x6f/0x80
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 9650:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0x102/0x170
 kmem_cache_free+0xc8/0x3e0
 iwl_mvm_mac_itxq_xmit+0x124/0x270 [iwlmvm]
 ieee80211_queue_skb+0x874/0xd10 [mac80211]
 ieee80211_xmit_fast+0xf80/0x1180 [mac80211]
 __ieee80211_subif_start_xmit+0x287/0x680 [mac80211]
 ieee80211_subif_start_xmit+0xcd/0x730 [mac80211]
 dev_hard_start_xmit+0xf6/0x420
 __dev_queue_xmit+0x165b/0x1b50
 ip_finish_output2+0x66e/0xfb0
 __ip_finish_output+0x487/0x6d0
 ip_output+0x11c/0x350
 __ip_queue_xmit+0x36b/0x9d0
 __tcp_transmit_skb+0xb35/0x15c0
 tcp_write_xmit+0x3f1/0x24d0
 tcp_sendmsg_locked+0x8a9/0x1520
 tcp_sendmsg+0x22/0x40
 sock_sendmsg+0x5f/0x70
 __sys_sendto+0x19d/0x250
 __x64_sys_sendto+0x6f/0x80
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88813cfa4b40
 which belongs to the cache skbuff_fclone_cache of size 472
The buggy address is located 96 bytes inside of
 472-byte region [ffff88813cfa4b40, ffff88813cfa4d18)

The buggy address belongs to the physical page:
page:ffffea0004f3e900 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88813cfa6c40 pfn:0x13cfa4
head:ffffea0004f3e900 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x5fff8000010200(slab|head|node=0|zone=2|lastcpupid=0x3fff)
raw: 005fff8000010200 ffffea0004656b08 ffffea0008e8cf08 ffff8881081a5240
raw: ffff88813cfa6c40 0000000000170015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88813cfa4a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88813cfa4b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88813cfa4b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88813cfa4c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813cfa4c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f9e08b339e0c..aaaacc80bde5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1206,6 +1206,7 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct sk_buff_head mpdus_skbs;
 	unsigned int payload_len;
 	int ret;
+	struct sk_buff *orig_skb = skb;
 
 	if (WARN_ON_ONCE(!mvmsta))
 		return -1;
@@ -1238,8 +1239,17 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 		ret = iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
 		if (ret) {
+			/* Free skbs created as part of TSO logic that have not yet been dequeued */
 			__skb_queue_purge(&mpdus_skbs);
-			return ret;
+			/* skb here is not necessarily same as skb that entered this method,
+			 * so free it explictly.
+			 */
+			if (skb == orig_skb)
+				ieee80211_free_txskb(mvm->hw, skb);
+			else
+				kfree_skb(skb);
+			/* there was error, but we consumed skb one way or another, so return 0 */
+			return 0;
 		}
 	}
 
-- 
2.20.1

