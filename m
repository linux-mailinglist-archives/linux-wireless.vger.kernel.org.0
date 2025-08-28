Return-Path: <linux-wireless+bounces-26839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A8B3AC94
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9013B7B6C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD062D0C72;
	Thu, 28 Aug 2025 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UegVakjz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72A17A300;
	Thu, 28 Aug 2025 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415586; cv=none; b=QbrgtNA9VYqpDuvsL3zX0Bn8xxxzWAPGiHtyNsiCBbGgnX/X6I2A+j8Jh5xQlyCEbPkRbhv4xttO7yZhF3TqMR/72CrGPITKrt4Tnu+kayKI60NGlzxMLUGRhqNZIJTZLPe/+YceGhNc4AX4haLYi9LbsX8OJnWfMKj4Z53iLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415586; c=relaxed/simple;
	bh=J/dMs7Y1ILkOYB8+Ur6h/3+WXuUJi6Zyyn+8+7UEoVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azkZB2RZlfkwerF3TCRZH52rEfmtKU/TOyYc+diMkbYe+yPz00hGoitvwaeKCugpMPe17IZF6Y46ZKVVVQDVPJ1IIEZMNRggQcLi+ZOofFd80TjaWZpIRQvDjb17wEhnZHrfsth3xnQ1zGWEWeGFq+vUDP3dNzv1tWc/6BlyBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UegVakjz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id A0C7E406C3E0;
	Thu, 28 Aug 2025 21:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A0C7E406C3E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756415578;
	bh=8vsYTfJQdYXWzdyE/FzCeHxtEMTe5RQpU1+8a1SMLac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UegVakjzcoyKIsviv3VBVIfHG88R7gUYnKZxdpwVqPN18Gaiue7HPpqtxPstrWfym
	 LpiIRe6PfFS+HYO0yDmk6kxb2xlGD1rqyjIE9Sho67uQZrIHJKj3+ejtELsK17Do5Y
	 oPCSivR9bnC7M2LSyEsHi20D9TGFo1gNtBmupyvM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw v3 1/5] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Date: Fri, 29 Aug 2025 00:11:57 +0300
Message-ID: <20250828211245.178843-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828211245.178843-1-pchelkin@ispras.ru>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
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

v3: - decrease waiting timeout in rtw89_tx_wait_work() (Zong-Zhe)
    - clear tx_waits list from rtw89_hci_reset(), too (Zong-Zhe)
    - keep RCU updating for skb_data->wait (Zong-Zhe)
    - keep the old order of calls in rtw89_pci_tx_status() (Zong-Zhe)
    - drop wait->finished as complete_all() would make the completion be
      done permanently (me)

v2: - use a work function to manage release of tx_waits and associated skbs (Zong-Zhe)


FWIW, I think RCU locking becomes unnecessary after the next patch
[PATCH rtw v3 2/5] wifi: rtw89: fix tx_wait initialization race
but let's keep it if you feel that's more safe.


 drivers/net/wireless/realtek/rtw89/core.c | 28 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 38 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.c  |  3 +-
 drivers/net/wireless/realtek/rtw89/ser.c  |  2 ++
 4 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 57590f5577a3..5c964283cd67 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1073,6 +1073,14 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						tx_wait_work);
+
+	rtw89_tx_wait_list_clear(rtwdev);
+}
+
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	u8 ch_dma;
@@ -1090,6 +1098,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	unsigned long time_left;
 	int ret = 0;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait) {
 		rtw89_core_tx_kick_off(rtwdev, qsel);
@@ -1098,17 +1108,22 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 
 	init_completion(&wait->completion);
 	rcu_assign_pointer(skb_data->wait, wait);
+	wait->skb = skb;
 
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
-	if (time_left == 0)
+
+	if (time_left == 0) {
 		ret = -ETIMEDOUT;
-	else if (!wait->tx_done)
-		ret = -EAGAIN;
+		list_add_tail(&wait->list, &rtwdev->tx_waits);
+		wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work);
 
-	rcu_assign_pointer(skb_data->wait, NULL);
-	kfree_rcu(wait, rcu_head);
+	} else {
+		if (!wait->tx_done)
+			ret = -EAGAIN;
+		rtw89_tx_wait_release(&wait->rcu_head);
+	}
 
 	return ret;
 }
@@ -4972,6 +4987,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
 	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
+	wiphy_work_cancel(wiphy, &rtwdev->tx_wait_work);
 	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
 	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
 	wiphy_work_cancel(wiphy, &btc->arp_notify_work);
@@ -5203,6 +5219,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
 	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
+	INIT_LIST_HEAD(&rtwdev->tx_waits);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -5233,6 +5250,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	wiphy_work_init(&rtwdev->ips_work, rtw89_ips_work);
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
+	wiphy_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
 	skb_queue_head_init(&rtwdev->c2h_queue);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e10278e14d..9b22bb116af9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3506,9 +3506,12 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_TX_WAIT_DEFAULT_TIMEOUT 10
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
+	struct list_head list;
 	struct completion completion;
+	struct sk_buff *skb;
 	bool tx_done;
 };
 
@@ -5925,6 +5928,9 @@ struct rtw89_dev {
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
 
+	struct list_head tx_waits;
+	struct wiphy_work tx_wait_work;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -6181,6 +6187,30 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 	list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), dlink_schd); \
 })
 
+static inline void rtw89_tx_wait_release(struct rcu_head *rcu_head)
+{
+	struct rtw89_tx_wait_info *wait =
+		container_of(rcu_head, struct rtw89_tx_wait_info, rcu_head);
+
+	dev_kfree_skb_any(wait->skb);
+	kfree(wait);
+}
+
+static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tx_wait_info *wait, *tmp;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
+		if (!wait_for_completion_timeout(&wait->completion,
+						 RTW89_TX_WAIT_DEFAULT_TIMEOUT))
+			continue;
+		list_del(&wait->list);
+		call_rcu(&wait->rcu_head, rtw89_tx_wait_release);
+	}
+}
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
@@ -6190,6 +6220,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev);
 }
 
 static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
@@ -7258,11 +7289,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
-static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       bool tx_done)
 {
 	struct rtw89_tx_wait_info *wait;
+	bool ret = false;
 
 	rcu_read_lock();
 
@@ -7270,11 +7302,13 @@ static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 	if (!wait)
 		goto out;
 
+	ret = true;
 	wait->tx_done = tx_done;
-	complete(&wait->completion);
+	complete_all(&wait->completion);
 
 out:
 	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..4e3034b44f56 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -464,7 +464,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+		return;
 
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index bb39fdbcba0d..fe7beff8c424 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -502,7 +502,9 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		}
 
 		drv_stop_rx(ser);
+		wiphy_lock(wiphy);
 		drv_trx_reset(ser);
+		wiphy_unlock(wiphy);
 
 		/* wait m3 */
 		hal_send_m2_event(ser);
-- 
2.51.0


