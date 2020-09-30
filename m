Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC61327E718
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 12:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgI3Kvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 06:51:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:50899 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgI3KvZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463084; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ifBTq/7Ai3NXRH6p+UKjsI7LHbDt0Cb+vfJRmLkZv/c=; b=PLOCwNIzCoFe/gXPzWNpuGShwikjzCBtB1F0MAZY49AIrd6SHUeMinwCSBh4RsM/ZgAFG5tb
 ymDWjq089cjVehu4g+lNaXRHLJyPnx6mAJaI8Ly53asQRBrwIqmrb6BVaHxbLy/TxcOd0ZBT
 TLiSeJZh0Cxr6SCUyBXJLucLwkw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f74632b1fdd3a1390aa0620 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:51:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7188C433CA; Wed, 30 Sep 2020 10:51:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49DDCC43382;
        Wed, 30 Sep 2020 10:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49DDCC43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] ath11k: mac: remove unused conf_mutex to solve a deadlock
Date:   Wed, 30 Sep 2020 13:51:11 +0300
Message-Id: <1601463073-12106-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
References: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

The conf_mutex is not use and lead below deadlock, remove it to solve
the deadlock issue.

[   44.967496] NET: Registered protocol family 42
[   45.119629] ath11k_pci 0000:06:00.0: WARNING: ath11k PCI support is experimental!
[   45.120087] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdc000000-0xdc0fffff 64bit]
[   45.120108] ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
[   45.206525] ath11k_pci 0000:06:00.0: aspm 0x42 changed to 0x40
[   45.207430] mhi 0000:06:00.0: Requested to power ON
[   45.208609] mhi 0000:06:00.0: Power on setup success
[   46.190711] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0x101 soc_id 0xffffffff
[   46.190729] ath11k_pci 0000:06:00.0: fw_version 0x306a70f fw_build_timestamp 2000-01-01 00:00 fw_build_id
1]: Starting Load/Save RF Kill Switch Status...
[   46.385118] ath11k_pci 0000:06:00.0 wlp6s0: renamed from wlan0
1]: Started Load/Save RF Kill Switch Status.
[   53.566669] wlp6s0: authenticate with 00:03:7f:48:dd:bf
[   53.809092] wlp6s0: send auth to 00:03:7f:48:dd:bf (try 1/3)
[   53.816490] wlp6s0: authenticated
[   53.818618] wlp6s0: associate with 00:03:7f:48:dd:bf (try 1/3)
[   53.820839] wlp6s0: RX AssocResp from 00:03:7f:48:dd:bf (capab=0x1 status=0 aid=2)
[   53.834859]
[   53.834861] ======================================================
[   53.834862] WARNING: possible circular locking dependency detected
[   53.834863] 5.9.0-rc5-wt-ath+ #198 Not tainted
[   53.834864] ------------------------------------------------------
[   53.834865] kworker/u16:3/166 is trying to acquire lock:
[   53.834866] ffff8c4b37184f78 (&ar->conf_mutex){+.+.}-{3:3}, at: ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.834875]
[   53.834875] but task is already holding lock:
[   53.834876] ffff8c4b37182808 (&local->iflist_mtx){+.+.}-{3:3}, at: ieee80211_set_associated+0x167/0x360
[   53.834879]
[   53.834879] which lock already depends on the new lock.
[   53.834879]
[   53.834880]
[   53.834880] the existing dependency chain (in reverse order) is:
[   53.834881]
[   53.834881] -> #1 (&local->iflist_mtx){+.+.}-{3:3}:
[   53.834884]        __lock_acquire+0x3bf/0x6e0
[   53.834886]        lock_acquire+0xb6/0x270
[   53.834887]        __mutex_lock+0x88/0x8e0
[   53.834890]        ieee80211_set_hw_80211_encap+0x3e/0x1f0
[   53.834895]        ath11k_mac_op_add_interface+0x348/0x7f0 [ath11k]
[   53.834897]        drv_add_interface+0x7c/0x190
[   53.834899]        ieee80211_do_open+0x552/0x9a0
[   53.834901]        __dev_open+0xe5/0x190
[   53.834902]        __dev_change_flags+0x1c6/0x230
[   53.834903]        dev_change_flags+0x1c/0x50
[   53.834905]        do_setlink+0x246/0xc60
[   53.834906]        __rtnl_newlink+0x607/0x990
[   53.834907]        rtnl_newlink+0x3f/0x60
[   53.834908]        rtnetlink_rcv_msg+0x174/0x490
[   53.834910]        netlink_rcv_skb+0x42/0x100
[   53.834911]        netlink_unicast+0x18c/0x250
[   53.834912]        netlink_sendmsg+0x227/0x460
[   53.834914]        sock_sendmsg+0x59/0x60
[   53.834915]        ____sys_sendmsg+0x1f5/0x230
[   53.834916]        ___sys_sendmsg+0x70/0xb0
[   53.834917]        __sys_sendmsg+0x54/0xa0
[   53.834919]        do_syscall_64+0x33/0x40
[   53.834920]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   53.834921]
[   53.834921] -> #0 (&ar->conf_mutex){+.+.}-{3:3}:
[   53.834923]        check_prev_add+0x98/0x9f0
[   53.834925]        validate_chain+0x404/0x6c0
[   53.834926]        __lock_acquire+0x3bf/0x6e0
[   53.834927]        lock_acquire+0xb6/0x270
[   53.834929]        __mutex_lock+0x88/0x8e0
[   53.834934]        ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.834935]        ieee80211_hw_config+0xb3/0x270
[   53.834937]        ieee80211_set_associated+0x17c/0x360
[   53.834938]        ieee80211_assoc_success.constprop.0+0x5a2/0xc80
[   53.834940]        ieee80211_rx_mgmt_assoc_resp+0x16a/0x350
[   53.834941]        ieee80211_sta_rx_queued_mgmt+0xca/0x410
[   53.834943]        ieee80211_iface_work+0x1f3/0x350
[   53.834945]        process_one_work+0x265/0x5d0
[   53.834946]        worker_thread+0x49/0x300
[   53.834948]        kthread+0x135/0x150
[   53.834949]        ret_from_fork+0x22/0x30
[   53.834950]
[   53.834950] other info that might help us debug this:
[   53.834950]
[   53.834951]  Possible unsafe locking scenario:
[   53.834951]
[   53.834952]        CPU0                    CPU1
[   53.834952]        ----                    ----
[   53.834953]   lock(&local->iflist_mtx);
[   53.834954]                                lock(&ar->conf_mutex);
[   53.834955]                                lock(&local->iflist_mtx);
[   53.834956]   lock(&ar->conf_mutex);
[   53.834957]
[   53.834957]  *** DEADLOCK ***
[   53.834957]
[   53.834958] 4 locks held by kworker/u16:3/166:
[   53.834959]  #0: ffff8c4b37c22948 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1d3/0x5d0
[   53.834961]  #1: ffffa98300abfe70 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x1d3/0x5d0
[   53.834963]  #2: ffff8c4b371e4cd0 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_sta_rx_queued_mgmt+0x4b/0x410
[   53.834965]  #3: ffff8c4b37182808 (&local->iflist_mtx){+.+.}-{3:3}, at: ieee80211_set_associated+0x167/0x360
[   53.834968]
[   53.834968] stack backtrace:
[   53.834969] CPU: 1 PID: 166 Comm: kworker/u16:3 Not tainted 5.9.0-rc5-wt-ath+ #198
[   53.834970] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[   53.834972] Workqueue: phy0 ieee80211_iface_work
[   53.834974] Call Trace:
[   53.834976]  dump_stack+0x77/0xa0
[   53.834978]  check_noncircular+0x15d/0x180
[   53.834980]  check_prev_add+0x98/0x9f0
[   53.834982]  ? add_chain_cache+0x143/0x440
[   53.834984]  validate_chain+0x404/0x6c0
[   53.834986]  __lock_acquire+0x3bf/0x6e0
[   53.834988]  lock_acquire+0xb6/0x270
[   53.834993]  ? ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.834999]  ? ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.835001]  __mutex_lock+0x88/0x8e0
[   53.835006]  ? ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.835007]  ? sched_clock_cpu+0xc/0xb0
[   53.835009]  ? __lock_release+0x179/0x2c0
[   53.835014]  ath11k_mac_op_config+0x16/0x30 [ath11k]
[   53.835016]  ieee80211_hw_config+0xb3/0x270
[   53.835018]  ieee80211_set_associated+0x17c/0x360
[   53.835019]  ieee80211_assoc_success.constprop.0+0x5a2/0xc80
[   53.835021]  ? lockdep_hardirqs_on_prepare.part.0+0x9f/0x140
[   53.835023]  ? cmpxchg_double_slab.constprop.0+0x185/0x1a0
[   53.835025]  ? trace_hardirqs_on+0x1c/0x100
[   53.835027]  ? __slab_free+0x8f/0x330
[   53.835029]  ? slab_free_freelist_hook+0xf8/0x150
[   53.835031]  ? ieee802_11_parse_elems_crc+0x147/0x1d0
[   53.835032]  ? kfree+0x2b0/0x2d0
[   53.835034]  ? ieee802_11_parse_elems_crc+0x147/0x1d0
[   53.835036]  ieee80211_rx_mgmt_assoc_resp+0x16a/0x350
[   53.835041]  ieee80211_sta_rx_queued_mgmt+0xca/0x410
[   53.835043]  ? __lock_acquire+0x3bf/0x6e0
[   53.835045]  ? lock_acquire+0xb6/0x270
[   53.835046]  ? skb_dequeue+0x13/0x70
[   53.835048]  ? find_held_lock+0x32/0x90
[   53.835049]  ? sched_clock_cpu+0xc/0xb0
[   53.835051]  ? mark_held_locks+0x50/0x80
[   53.835053]  ? lockdep_hardirqs_on_prepare.part.0+0x9f/0x140
[   53.835054]  ? _raw_spin_unlock_irqrestore+0x34/0x40
[   53.835056]  ? trace_hardirqs_on+0x1c/0x100
[   53.835058]  ieee80211_iface_work+0x1f3/0x350
[   53.835060]  process_one_work+0x265/0x5d0
[   53.835062]  worker_thread+0x49/0x300
[   53.835063]  ? process_one_work+0x5d0/0x5d0
[   53.835065]  kthread+0x135/0x150
[   53.835066]  ? kthread_create_worker_on_cpu+0x60/0x60
[   53.835068]  ret_from_fork+0x22/0x30
[   53.835075] wlp6s0: associated
[   53.835132] IPv6: ADDRCONF(NETDEV_CHANGE): wlp6s0: link becomes ready

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c43844ed6b61..76e218e53fe7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -758,21 +758,12 @@ static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 
 static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct ath11k *ar = hw->priv;
-	int ret = 0;
-
 	/* mac80211 requires this op to be present and that's why
 	 * there's an empty function, this can be extended when
 	 * required.
 	 */
 
-	mutex_lock(&ar->conf_mutex);
-
-	/* TODO: Handle configuration changes as appropriate */
-
-	mutex_unlock(&ar->conf_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
-- 
2.7.4

