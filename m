Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0E49196B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiARCyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:54:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55602 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiARCmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:42:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D36ECE13A1;
        Tue, 18 Jan 2022 02:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2196C36AE3;
        Tue, 18 Jan 2022 02:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473752;
        bh=LaksSdNhVd4U/nUy+N1NWpS58iAZEhC7d/NEn5f4/ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sndE/FnNNtnwBRaIWv/tuqiKliHwMzAYmxV2X6mFVl+bgHgH9dTH2BmFbsneYiSAE
         veFn7hFTXqJpMguwCo2tdZitksPrOaqHm/Jgw2SAfbukmduJPegQX9xoXelvkpQZeu
         SqfnhEm5x/HPeGrxjPt8DNu4LZjCae5T+/S/fs+Tb2KIk21Zmjn7L0dM6B1GE2GgpF
         EYnhtq/iJ1x7bNm7LARCDlK8Jx3njuRdEK5A97794gwr7AhsinPa1+aZnDkn73mx1x
         /IVW6IUUqRNkzBFEmwwyyWsW+3vjjfvSLL6hpA27E5OzCkHOiwM6X636hQmeBWYtu0
         84EX09YgjivuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 053/116] ath11k: avoid deadlock by change ieee80211_queue_work for regd_update_work
Date:   Mon, 17 Jan 2022 21:39:04 -0500
Message-Id: <20220118024007.1950576-53-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024007.1950576-1-sashal@kernel.org>
References: <20220118024007.1950576-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit ed05c7cf1286d7e31e7623bce55ff135723591bf ]

When enable debug config, it print below warning while shut down wlan
interface shuh as run "ifconfig wlan0 down".

The reason is because ar->regd_update_work is ran once, and it is will
call wiphy_lock(ar->hw->wiphy) in function ath11k_regd_update() which
is running in workqueue of ieee80211_local queued by ieee80211_queue_work().
Another thread from "ifconfig wlan0 down" will also accuqire the lock
by wiphy_lock(sdata->local->hw.wiphy) in function ieee80211_stop(), and
then it call ieee80211_stop_device() to flush_workqueue(local->workqueue),
this will wait the workqueue of ieee80211_local finished. Then deadlock
will happen easily if the two thread run meanwhile.

Below warning disappeared after this change.

[  914.088798] ath11k_pci 0000:05:00.0: mac remove interface (vdev 0)
[  914.088806] ath11k_pci 0000:05:00.0: mac stop 11d scan
[  914.088810] ath11k_pci 0000:05:00.0: mac stop 11d vdev id 0
[  914.088827] ath11k_pci 0000:05:00.0: htc ep 2 consumed 1 credits (total 0)
[  914.088841] ath11k_pci 0000:05:00.0: send 11d scan stop vdev id 0
[  914.088849] ath11k_pci 0000:05:00.0: htc insufficient credits ep 2 required 1 available 0
[  914.088856] ath11k_pci 0000:05:00.0: htc insufficient credits ep 2 required 1 available 0
[  914.096434] ath11k_pci 0000:05:00.0: rx ce pipe 2 len 16
[  914.096442] ath11k_pci 0000:05:00.0: htc ep 2 got 1 credits (total 1)
[  914.096481] ath11k_pci 0000:05:00.0: htc ep 2 consumed 1 credits (total 0)
[  914.096491] ath11k_pci 0000:05:00.0: WMI vdev delete id 0
[  914.111598] ath11k_pci 0000:05:00.0: rx ce pipe 2 len 16
[  914.111628] ath11k_pci 0000:05:00.0: htc ep 2 got 1 credits (total 1)
[  914.114659] ath11k_pci 0000:05:00.0: rx ce pipe 2 len 20
[  914.114742] ath11k_pci 0000:05:00.0: htc rx completion ep 2 skb         pK-error
[  914.115977] ath11k_pci 0000:05:00.0: vdev delete resp for vdev id 0
[  914.116685] ath11k_pci 0000:05:00.0: vdev 00:03:7f:29:61:11 deleted, vdev_id 0

[  914.117583] ======================================================
[  914.117592] WARNING: possible circular locking dependency detected
[  914.117600] 5.16.0-rc1-wt-ath+ #1 Tainted: G           OE
[  914.117611] ------------------------------------------------------
[  914.117618] ifconfig/2805 is trying to acquire lock:
[  914.117628] ffff9c00a62bb548 ((wq_completion)phy0){+.+.}-{0:0}, at: flush_workqueue+0x87/0x470
[  914.117674]
               but task is already holding lock:
[  914.117682] ffff9c00baea07d0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_stop+0x38/0x180 [mac80211]
[  914.117872]
               which lock already depends on the new lock.

[  914.117880]
               the existing dependency chain (in reverse order) is:
[  914.117888]
               -> #3 (&rdev->wiphy.mtx){+.+.}-{4:4}:
[  914.117910]        __mutex_lock+0xa0/0x9c0
[  914.117930]        mutex_lock_nested+0x1b/0x20
[  914.117944]        reg_process_self_managed_hints+0x3a/0xb0 [cfg80211]
[  914.118093]        wiphy_regulatory_register+0x47/0x80 [cfg80211]
[  914.118229]        wiphy_register+0x84f/0x9c0 [cfg80211]
[  914.118353]        ieee80211_register_hw+0x6b1/0xd90 [mac80211]
[  914.118486]        ath11k_mac_register+0x6af/0xb60 [ath11k]
[  914.118550]        ath11k_core_qmi_firmware_ready+0x383/0x4a0 [ath11k]
[  914.118598]        ath11k_qmi_driver_event_work+0x347/0x4a0 [ath11k]
[  914.118656]        process_one_work+0x228/0x670
[  914.118669]        worker_thread+0x4d/0x440
[  914.118680]        kthread+0x16d/0x1b0
[  914.118697]        ret_from_fork+0x22/0x30
[  914.118714]
               -> #2 (rtnl_mutex){+.+.}-{4:4}:
[  914.118736]        __mutex_lock+0xa0/0x9c0
[  914.118751]        mutex_lock_nested+0x1b/0x20
[  914.118767]        rtnl_lock+0x17/0x20
[  914.118783]        ath11k_regd_update+0x15a/0x260 [ath11k]
[  914.118841]        ath11k_regd_update_work+0x15/0x20 [ath11k]
[  914.118897]        process_one_work+0x228/0x670
[  914.118909]        worker_thread+0x4d/0x440
[  914.118920]        kthread+0x16d/0x1b0
[  914.118934]        ret_from_fork+0x22/0x30
[  914.118948]
               -> #1 ((work_completion)(&ar->regd_update_work)){+.+.}-{0:0}:
[  914.118972]        process_one_work+0x1fa/0x670
[  914.118984]        worker_thread+0x4d/0x440
[  914.118996]        kthread+0x16d/0x1b0
[  914.119010]        ret_from_fork+0x22/0x30
[  914.119023]
               -> #0 ((wq_completion)phy0){+.+.}-{0:0}:
[  914.119045]        __lock_acquire+0x146d/0x1cf0
[  914.119057]        lock_acquire+0x19b/0x360
[  914.119067]        flush_workqueue+0xae/0x470
[  914.119084]        ieee80211_stop_device+0x3b/0x50 [mac80211]
[  914.119260]        ieee80211_do_stop+0x5d7/0x830 [mac80211]
[  914.119409]        ieee80211_stop+0x45/0x180 [mac80211]
[  914.119557]        __dev_close_many+0xb3/0x120
[  914.119573]        __dev_change_flags+0xc3/0x1d0
[  914.119590]        dev_change_flags+0x29/0x70
[  914.119605]        devinet_ioctl+0x653/0x810
[  914.119620]        inet_ioctl+0x193/0x1e0
[  914.119631]        sock_do_ioctl+0x4d/0xf0
[  914.119649]        sock_ioctl+0x262/0x340
[  914.119665]        __x64_sys_ioctl+0x96/0xd0
[  914.119678]        do_syscall_64+0x3d/0xd0
[  914.119694]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  914.119709]
               other info that might help us debug this:

[  914.119717] Chain exists of:
                 (wq_completion)phy0 --> rtnl_mutex --> &rdev->wiphy.mtx

[  914.119745]  Possible unsafe locking scenario:

[  914.119752]        CPU0                    CPU1
[  914.119758]        ----                    ----
[  914.119765]   lock(&rdev->wiphy.mtx);
[  914.119778]                                lock(rtnl_mutex);
[  914.119792]                                lock(&rdev->wiphy.mtx);
[  914.119807]   lock((wq_completion)phy0);
[  914.119819]
                *** DEADLOCK ***

[  914.119827] 2 locks held by ifconfig/2805:
[  914.119837]  #0: ffffffffba3dc010 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x17/0x20
[  914.119872]  #1: ffff9c00baea07d0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_stop+0x38/0x180 [mac80211]
[  914.120039]
               stack backtrace:
[  914.120048] CPU: 0 PID: 2805 Comm: ifconfig Tainted: G           OE     5.16.0-rc1-wt-ath+ #1
[  914.120064] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW (1.33 ) 07/29/2011
[  914.120074] Call Trace:
[  914.120084]  <TASK>
[  914.120094]  dump_stack_lvl+0x73/0xa4
[  914.120119]  dump_stack+0x10/0x12
[  914.120135]  print_circular_bug.isra.44+0x221/0x2e0
[  914.120165]  check_noncircular+0x106/0x150
[  914.120203]  __lock_acquire+0x146d/0x1cf0
[  914.120215]  ? __lock_acquire+0x146d/0x1cf0
[  914.120245]  lock_acquire+0x19b/0x360
[  914.120259]  ? flush_workqueue+0x87/0x470
[  914.120286]  ? lockdep_init_map_type+0x6b/0x250
[  914.120310]  flush_workqueue+0xae/0x470
[  914.120327]  ? flush_workqueue+0x87/0x470
[  914.120344]  ? lockdep_hardirqs_on+0xd7/0x150
[  914.120391]  ieee80211_stop_device+0x3b/0x50 [mac80211]
[  914.120565]  ? ieee80211_stop_device+0x3b/0x50 [mac80211]
[  914.120736]  ieee80211_do_stop+0x5d7/0x830 [mac80211]
[  914.120906]  ieee80211_stop+0x45/0x180 [mac80211]
[  914.121060]  __dev_close_many+0xb3/0x120
[  914.121081]  __dev_change_flags+0xc3/0x1d0
[  914.121109]  dev_change_flags+0x29/0x70
[  914.121131]  devinet_ioctl+0x653/0x810
[  914.121149]  ? __might_fault+0x77/0x80
[  914.121179]  inet_ioctl+0x193/0x1e0
[  914.121194]  ? inet_ioctl+0x193/0x1e0
[  914.121218]  ? __might_fault+0x77/0x80
[  914.121238]  ? _copy_to_user+0x68/0x80
[  914.121266]  sock_do_ioctl+0x4d/0xf0
[  914.121283]  ? inet_stream_connect+0x60/0x60
[  914.121297]  ? sock_do_ioctl+0x4d/0xf0
[  914.121329]  sock_ioctl+0x262/0x340
[  914.121347]  ? sock_ioctl+0x262/0x340
[  914.121362]  ? exit_to_user_mode_prepare+0x13b/0x280
[  914.121388]  ? syscall_enter_from_user_mode+0x20/0x50
[  914.121416]  __x64_sys_ioctl+0x96/0xd0
[  914.121430]  ? br_ioctl_call+0x90/0x90
[  914.121445]  ? __x64_sys_ioctl+0x96/0xd0
[  914.121465]  do_syscall_64+0x3d/0xd0
[  914.121482]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  914.121497] RIP: 0033:0x7f0ed051737b
[  914.121513] Code: 0f 1e fa 48 8b 05 15 3b 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 3a 0d 00 f7 d8 64 89 01 48
[  914.121527] RSP: 002b:00007fff7be38b98 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  914.121544] RAX: ffffffffffffffda RBX: 00007fff7be38ba0 RCX: 00007f0ed051737b
[  914.121555] RDX: 00007fff7be38ba0 RSI: 0000000000008914 RDI: 0000000000000004
[  914.121566] RBP: 00007fff7be38c60 R08: 000000000000000a R09: 0000000000000001
[  914.121576] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000fffffffe
[  914.121586] R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
[  914.121620]  </TASK>

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20211201071745.17746-2-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 74ebe8e7d1d81..c6f91e0367a90 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5421,7 +5421,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 		ar = ab->pdevs[pdev_idx].ar;
 		kfree(ab->new_regd[pdev_idx]);
 		ab->new_regd[pdev_idx] = regd;
-		ieee80211_queue_work(ar->hw, &ar->regd_update_work);
+		queue_work(ab->workqueue, &ar->regd_update_work);
 	} else {
 		/* This regd would be applied during mac registration and is
 		 * held constant throughout for regd intersection purpose
-- 
2.34.1

