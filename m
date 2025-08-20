Return-Path: <linux-wireless+bounces-26477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89EB2DEEA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470E858004E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFC26E6E6;
	Wed, 20 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="m1oUMek9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A321FF24;
	Wed, 20 Aug 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699304; cv=none; b=SUT/537h6YknHPlLzKiLdz8vYr4TvDyOE4099al8a2Nvp5DFl3vhi7/Q7pGa6qRrUgOBJd/v9VKD+wE2UdyltMd0u/c4ZVa+TcDNTc9dIA+zfmf8B+q9bWAQ5fucLBWbVeWec5Bvq79sWpQeuuQ35EZHx5X6ZFsFVXdVqH1LFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699304; c=relaxed/simple;
	bh=gtU6zVpCfLilqmweYMJWBdWiyEXgPx2YbOTShozMP1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhuAurFpPHnPEuP2aEfJWYd2Pzy1A8o2HpfbT4FdZotb9FXJ0tOTriOOTzQYgHxgpvPdW+nlYP6FR90AFK7/ThOtVuOWUCwHHmooM5Mg0gxzD/GYhVB9tG90gxtQoN96U7gl1wK4nR/CImuKoba0Vr9mTgYaiPldllaMzvDEKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=m1oUMek9; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9BCBE4028387;
	Wed, 20 Aug 2025 14:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9BCBE4028387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755699296;
	bh=5JjmZf15UhpzUiI7r1soRuB11AzCTswYFwRBjFzcgeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1oUMek9RNDsIJ4HeXGz/o150u0WEeSk6ETi9tKsXmkmg4D3BzO8GtmvmPynYDjyD
	 BcxNaHcnmqI93nFr2Al7k3UnGgIYFEwNf/m1sFUkP89TaaspUmjMkVnMukio6mwWdr
	 cm/syvM5cXFHDDCK9MQPmg/AG9JaSbNor6o7oAJQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Date: Wed, 20 Aug 2025 17:13:45 +0300
Message-ID: <20250820141441.106156-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820141441.106156-1-pchelkin@ispras.ru>
References: <20250820141441.106156-1-pchelkin@ispras.ru>
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

It is a consequence of a race between the waiting and the signalling side
of the completion:

            Thread 1                                    Thread 2
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

The signalling side might proceed and free the underlying skb even before
the waiting side is fully awoken and run to execution.

RCU synchronization here would work well if the signalling side didn't go
on and release skb on its own.  Thus the waiting side should be told
somehow about what is happening on the completion side.

It seems the only correct way is to use standard locking primitives with
owner tracking, like was originally published in one [1] of the versions
of the patch mentioned in Fixes.

[1]: https://lore.kernel.org/linux-wireless/20230404025259.15503-3-pkshih@realtek.com/

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of TX skbs")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

The bug is tricky because the waiter-completer interaction isn't simple
here.  I've tried to come up with something that wouldn't require taking
additional locks at rtw89_core_tx_wait_complete() but these ideas don't
eliminate the possible race entirely, to my mind.

Though one solution that _works_ currently is to get rid of
'struct rtw89_tx_wait_info' and replace it with the only field it is
used for - 'bool tx_done'.  Then it can be stored at
'struct ieee80211_tx_info::status::status_driver_data' directly without
the need for allocating an extra dynamic object and tracking its lifecycle.
I didn't post this since then the structure won't be expandable for new
fields and that's probably the reason for why it wasn't done in this manner
initially.

 drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 32 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++--
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 57590f5577a3..826540319027 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1088,6 +1088,7 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct rtw89_tx_wait_info *wait;
 	unsigned long time_left;
+	bool free_wait = true;
 	int ret = 0;
 
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
@@ -1097,7 +1098,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	}
 
 	init_completion(&wait->completion);
-	rcu_assign_pointer(skb_data->wait, wait);
+	spin_lock_init(&wait->owner_lock);
+	skb_data->wait = wait;
 
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
@@ -1107,8 +1109,15 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	else if (!wait->tx_done)
 		ret = -EAGAIN;
 
-	rcu_assign_pointer(skb_data->wait, NULL);
-	kfree_rcu(wait, rcu_head);
+	spin_lock_bh(&wait->owner_lock);
+	if (time_left == 0 && wait->owner != RTW89_TX_WAIT_OWNER_WAIT) {
+		free_wait = false;
+		wait->owner = RTW89_TX_WAIT_OWNER_COMPLETE;
+	}
+	spin_unlock_bh(&wait->owner_lock);
+
+	if (free_wait)
+		kfree(wait);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e10278e14d..0117f24324d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3506,14 +3506,21 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+enum rtw89_tx_wait_owner {
+	RTW89_TX_WAIT_OWNER_UNDET,
+	RTW89_TX_WAIT_OWNER_WAIT,
+	RTW89_TX_WAIT_OWNER_COMPLETE,
+};
+
 struct rtw89_tx_wait_info {
-	struct rcu_head rcu_head;
 	struct completion completion;
 	bool tx_done;
+	spinlock_t owner_lock; /* lock to access owner */
+	enum rtw89_tx_wait_owner owner;
 };
 
 struct rtw89_tx_skb_data {
-	struct rtw89_tx_wait_info __rcu *wait;
+	struct rtw89_tx_wait_info *wait;
 	u8 hci_priv[];
 };
 
@@ -7259,22 +7266,23 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 }
 
 static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
-					       struct rtw89_tx_skb_data *skb_data,
+					       struct rtw89_tx_wait_info *wait,
 					       bool tx_done)
 {
-	struct rtw89_tx_wait_info *wait;
-
-	rcu_read_lock();
-
-	wait = rcu_dereference(skb_data->wait);
-	if (!wait)
-		goto out;
+	bool free_wait = true;
 
 	wait->tx_done = tx_done;
+
+	spin_lock_bh(&wait->owner_lock);
 	complete(&wait->completion);
+	if (wait->owner != RTW89_TX_WAIT_OWNER_COMPLETE) {
+		free_wait = false;
+		wait->owner = RTW89_TX_WAIT_OWNER_WAIT;
+	}
+	spin_unlock_bh(&wait->owner_lock);
 
-out:
-	rcu_read_unlock();
+	if (free_wait)
+		kfree(wait);
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..d9d4558b21ea 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -462,9 +462,11 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 				struct sk_buff *skb, u8 tx_status)
 {
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct rtw89_tx_wait_info *wait = skb_data->wait;
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+	if (wait)
+		rtw89_core_tx_wait_complete(rtwdev, wait, tx_status == RTW89_TX_DONE);
 
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
@@ -1387,7 +1389,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	rcu_assign_pointer(skb_data->wait, NULL);
+	skb_data->wait = NULL;
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-- 
2.50.1


