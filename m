Return-Path: <linux-wireless+bounces-26699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E096B381EE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6E8207594
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F49302772;
	Wed, 27 Aug 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Ct1rbZV0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E262482EB;
	Wed, 27 Aug 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296406; cv=none; b=ZIpnAbf/sTa5U82mNeGjrXS+YUqm1ZibYhd1w4E7nqNuMKXXaSdDM/CDPkllr2kb1Ahp+14H+MUJm24LW/GduHkHsSIHrAc7i9AFJD7ZSO6wquJHL65EeBQm5zxixADGlZLj9MnA8hVtZMlvfm2WDbc6c3kQbH209AJmouSuQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296406; c=relaxed/simple;
	bh=ltGKl3e/7swTIxGSgNABd1Z6Y13L8HAhErf3zfINjxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGpZ7hn5iQcdVnWTA2fzuhWbcGJ00HGyP/G6fbz08au05u6EsGA8E8pz1KjmumGMLgkSzGRXj58JZFMbI47yGTxIPs3M5fjOX6iFvyADMFIblBNY1TVea18s2Bx72GsUDqEBgDk9X0BNQhUJuXcqlCZDmfF5EGT/Q4A0dn/7b6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Ct1rbZV0; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6A5D5406B8A5;
	Wed, 27 Aug 2025 12:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6A5D5406B8A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756296399;
	bh=9RyUcudEzoL6X6XXNPOz80pAhNVEKgHr7S9bPQpGFFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ct1rbZV0ZLmsAlcSEid9txjnJ9+GOTWAEfpToSDWaO5Ikuz9a8AhxDts1kcfdErB0
	 d+wyRxr9XRqsG6yKJhDUu0YR1XG0vROyX/I4SkQ7+cUIxLnt0RKjLhzIAMvUHwXaXw
	 0/5gfq1Sytg3PRoNAmLS5DMHEA5vvxd8agwQQEig=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Date: Wed, 27 Aug 2025 15:05:14 +0300
Message-ID: <20250827120603.723548-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827120603.723548-1-pchelkin@ispras.ru>
References: <20250827120603.723548-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug observed when rtw89_core_tx_kick_off_and_wait() tries to
access already freed skb_data:

 BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait drivers/net/wireless/realtek/rtw89/core.c:1110

 CPU: 6 UID: 0 PID: 41377 Comm: kworker/u64:24 Not tainted  6.17.0-rc1+ #1 PREEMPT(lazy)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523-14.fc42 05/23/2025
 Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]

 Use-after-free write at 0x0000000020309d9d (in kfence-#251):
 rtw89_core_tx_kick_off_and_wait drivers/net/wireless/realtek/rtw89/core.c:1110
 rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
 rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
 rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
 rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.h:141
 rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
 rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
 rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
 process_one_work kernel/workqueue.c:3241
 worker_thread kernel/workqueue.c:3400
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

 kfence-#251: 0x0000000056e2393d-0x000000009943cb62, size=232, cache=skbuff_head_cache

 allocated by task 41377 on cpu 6 at 77869.159548s (0.009551s ago):
 __alloc_skb net/core/skbuff.c:659
 __netdev_alloc_skb net/core/skbuff.c:734
 ieee80211_nullfunc_get net/mac80211/tx.c:5844
 rtw89_core_send_nullfunc drivers/net/wireless/realtek/rtw89/core.c:3431
 rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
 rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
 rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
 rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.c:3194
 rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
 rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
 rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
 process_one_work kernel/workqueue.c:3241
 worker_thread kernel/workqueue.c:3400
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

 freed by task 1045 on cpu 9 at 77869.168393s (0.001557s ago):
 ieee80211_tx_status_skb net/mac80211/status.c:1117
 rtw89_pci_release_txwd_skb drivers/net/wireless/realtek/rtw89/pci.c:564
 rtw89_pci_release_tx_skbs.isra.0 drivers/net/wireless/realtek/rtw89/pci.c:651
 rtw89_pci_release_tx drivers/net/wireless/realtek/rtw89/pci.c:676
 rtw89_pci_napi_poll drivers/net/wireless/realtek/rtw89/pci.c:4238
 __napi_poll net/core/dev.c:7495
 net_rx_action net/core/dev.c:7557 net/core/dev.c:7684
 handle_softirqs kernel/softirq.c:580
 do_softirq.part.0 kernel/softirq.c:480
 __local_bh_enable_ip kernel/softirq.c:407
 rtw89_pci_interrupt_threadfn drivers/net/wireless/realtek/rtw89/pci.c:927
 irq_thread_fn kernel/irq/manage.c:1133
 irq_thread kernel/irq/manage.c:1257
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

It is a consequence of a race between the waiting and the signaling side
of the completion:

            Waiting thread                            Completing thread

rtw89_core_tx_kick_off_and_wait()
  rcu_assign_pointer(skb_data->wait, wait)
  /* start waiting */
  wait_for_completion_timeout()
                                                rtw89_pci_tx_status()
                                                  rtw89_core_tx_wait_complete()
                                                    rcu_read_lock()
                                                    /* signals completion and
                                                     * proceeds further
                                                     */
                                                    complete(&wait->completion)
                                                    rcu_read_unlock()
                                                  ...
                                                  /* frees skb_data */
                                                  ieee80211_tx_status_ni()
  /* returns (exit status doesn't matter) */
  wait_for_completion_timeout()
  ...
  /* accesses the already freed skb_data */
  rcu_assign_pointer(skb_data->wait, NULL)

The completing side might proceed and free the underlying skb even before
the waiting side is fully awoken and run to execution.  Actually the race
happens regardless of wait_for_completion_timeout() exit status, e.g.
the waiting side may hit a timeout and the concurrent completing side is
still able to free the skb.

Skbs which are sent by rtw89_core_tx_kick_off_and_wait() are owned by the
driver.  They don't come from core ieee80211 stack so no need to pass them
to ieee80211_tx_status_ni() on completing side.

Introduce a work function which will act as a garbage collector for
rtw89_tx_wait_info objects and the associated skbs.  Thus no potentially
heavy locks are required on the completing side.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of TX skbs")
Cc: stable@vger.kernel.org
Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: use a work function to manage release of tx_waits and associated skbs (Zong-Zhe)

The interesting part is how rtw89_tx_wait_work() should wait for
completion - based on timeout or without it, or just check status with
a call to completion_done().

Simply waiting with wait_for_completion() may become a bottleneck if for
any reason the completion is delayed significantly, and we are holding a
wiphy lock here.  I _suspect_ rtw89_pci_tx_status() should be called
either by napi polling handler or in other cases e.g. by rtw89_hci_reset()
but it's hard to deduce for any possible scenario that it will be called
in some time.

Anyway, the current and the next patch try to make sure that when
rtw89_core_tx_wait_complete() is called, skbdata->wait is properly
initialized so that there should be no buggy situations when tx_wait skb
is not recognized and invalidly passed to ieee80211 stack, also without
signaling a completion.

If rtw89_core_tx_wait_complete() is not called at all, this should
indicate a bug elsewhere.

 drivers/net/wireless/realtek/rtw89/core.c | 42 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h | 22 +++++++-----
 drivers/net/wireless/realtek/rtw89/pci.c  |  9 ++---
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 57590f5577a3..48aa02d6abd4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1073,6 +1073,26 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						tx_wait_work);
+	struct rtw89_tx_wait_info *wait, *tmp;
+
+	lockdep_assert_wiphy(wiphy);
+
+	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
+		if (!wait->finished) {
+			unsigned long tmo = msecs_to_jiffies(wait->timeout);
+			if (!wait_for_completion_timeout(&wait->completion, tmo))
+				continue;
+		}
+		list_del(&wait->list);
+		dev_kfree_skb_any(wait->skb);
+		kfree(wait);
+	}
+}
+
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	u8 ch_dma;
@@ -1090,6 +1110,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	unsigned long time_left;
 	int ret = 0;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait) {
 		rtw89_core_tx_kick_off(rtwdev, qsel);
@@ -1097,18 +1119,23 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	}
 
 	init_completion(&wait->completion);
-	rcu_assign_pointer(skb_data->wait, wait);
+	skb_data->wait = wait;
 
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
-	if (time_left == 0)
+	if (time_left == 0) {
 		ret = -ETIMEDOUT;
-	else if (!wait->tx_done)
-		ret = -EAGAIN;
+	} else {
+		wait->finished = true;
+		if (!wait->tx_done)
+			ret = -EAGAIN;
+	}
 
-	rcu_assign_pointer(skb_data->wait, NULL);
-	kfree_rcu(wait, rcu_head);
+	wait->skb = skb;
+	wait->timeout = timeout;
+	list_add_tail(&wait->list, &rtwdev->tx_waits);
+	wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work);
 
 	return ret;
 }
@@ -4972,6 +4999,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
 	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
+	wiphy_work_cancel(wiphy, &rtwdev->tx_wait_work);
 	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
 	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
 	wiphy_work_cancel(wiphy, &btc->arp_notify_work);
@@ -5203,6 +5231,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
 	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
+	INIT_LIST_HEAD(&rtwdev->tx_waits);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -5233,6 +5262,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	wiphy_work_init(&rtwdev->ips_work, rtw89_ips_work);
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
+	wiphy_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
 	skb_queue_head_init(&rtwdev->c2h_queue);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e10278e14d..06f7d82a8d18 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3508,12 +3508,16 @@ struct rtw89_phy_rate_pattern {
 
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
+	struct list_head list;
 	struct completion completion;
+	struct sk_buff *skb;
+	unsigned int timeout;
 	bool tx_done;
+	bool finished;
 };
 
 struct rtw89_tx_skb_data {
-	struct rtw89_tx_wait_info __rcu *wait;
+	struct rtw89_tx_wait_info *wait;
 	u8 hci_priv[];
 };
 
@@ -5925,6 +5929,9 @@ struct rtw89_dev {
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
 
+	struct list_head tx_waits;
+	struct wiphy_work tx_wait_work;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -7258,23 +7265,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
-static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       bool tx_done)
 {
 	struct rtw89_tx_wait_info *wait;
 
-	rcu_read_lock();
-
-	wait = rcu_dereference(skb_data->wait);
+	wait = skb_data->wait;
 	if (!wait)
-		goto out;
+		return false;
 
 	wait->tx_done = tx_done;
-	complete(&wait->completion);
+	complete_all(&wait->completion);
 
-out:
-	rcu_read_unlock();
+	return true;
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..6356c2c224c5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -464,10 +464,7 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
-
 	info = IEEE80211_SKB_CB(skb);
-	ieee80211_tx_info_clear_status(info);
 
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
@@ -494,6 +491,10 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 		}
 	}
 
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+		return;
+
+	ieee80211_tx_info_clear_status(info);
 	ieee80211_tx_status_ni(rtwdev->hw, skb);
 }
 
@@ -1387,7 +1388,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	rcu_assign_pointer(skb_data->wait, NULL);
+	skb_data->wait = NULL;
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-- 
2.50.1


