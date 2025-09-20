Return-Path: <linux-wireless+bounces-27539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28589B8C8FD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A53A1BC408E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39252F5495;
	Sat, 20 Sep 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="P92NlU5t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01822E3E9;
	Sat, 20 Sep 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374847; cv=none; b=l5PFyPETZ+fdszYxOFwUdhQwn7YlS7EY1yHz9qy8jkLTYRDnvuoCnL0QdyoCVERSh5TvxyUz4cHIvUs7l4GLNsrFbE/aB0GS2GOcCbFHRYqpe1kT5jssDH82VSBzSXlvahaMeoj2Q7t0loaQuWZHdTbam5Ht3MDDN7yo/FECsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374847; c=relaxed/simple;
	bh=Fu5+7KudZfuA2gGeA1DToqemNOr0nkDF6v9+i/0HzqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKjLQdwtHj7/rNCTdQhSaf7SMD5dVslHWWRihabOqXsaQE9QtCFmWJUE+6zgnxaL8F2LjzhuHFn4aypudSxOHYr7DRVpn+K2SH2xapvS0bfXg3rG9SCNevDJmBEgwbdGnb/IeqLKlvM+F6E6CDFIsP9F6GgKZLMhVPVlUydhbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=P92NlU5t; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id C58E0407674B;
	Sat, 20 Sep 2025 13:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C58E0407674B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374843;
	bh=Kaz0l7AUcbnFvp4Giv0NQuUgXXNYoArRazUEpM90nwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P92NlU5t+40TBRLyzD/5dzbcBanZeqNwbVYOnHLYKNQNvtCKcIMa+z1rujfXn8OAQ
	 By+TGNCRnTZzl6BiT8xrQMRGs7pe8umZn45vIIKHvA6UkrRx3fJohLCb900BRfxIaE
	 s8b808kqpTmn1RVlLsa8ECj5waEdYJqNSzR5StJE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 5/6] wifi: rtw89: process TX wait skbs for USB via C2H handler
Date: Sat, 20 Sep 2025 16:26:10 +0300
Message-ID: <20250920132614.277719-6-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX wait skbs need to be completed when they are done.  PCIe part does this
inside rtw89_pci_tx_status() during RPP processing.  Other HCIs use a
mechanism based on C2H firmware messages.

Store a sequence number in a TX wait object so that it'll be possible to
identify completed items inside C2H handler.  No need to add the
corresponding skb to the &txcb->tx_ack_queue on USB part.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/core.h | 18 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c  |  9 ++++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3e7bd0cedbdf..e76f04736502 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1161,18 +1161,19 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
+	list_add_tail_rcu(&wait->list, &rtwdev->tx_waits);
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
 
 	if (time_left == 0) {
 		ret = -ETIMEDOUT;
-		list_add_tail(&wait->list, &rtwdev->tx_waits);
 		wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work,
 					 RTW89_TX_WAIT_WORK_TIMEOUT);
 	} else {
 		if (!wait->tx_done)
 			ret = -EAGAIN;
+		list_del_rcu(&wait->list);
 		rtw89_tx_wait_release(wait);
 	}
 
@@ -1237,11 +1238,12 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.skb = skb;
 	tx_req.vif = vif;
 	tx_req.sta = sta;
+	tx_req.wait = wait;
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
 
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+	if (wait || (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
 		rtw89_hci_tx_rpt_enable(rtwdev, &tx_req);
 
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4e597a5df005..e7948bd0bdf6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1199,6 +1199,7 @@ struct rtw89_core_tx_request {
 	struct sk_buff *skb;
 	struct ieee80211_vif *vif;
 	struct ieee80211_sta *sta;
+	struct rtw89_tx_wait_info *wait;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	struct rtw89_tx_desc_info desc_info;
@@ -3521,6 +3522,7 @@ struct rtw89_tx_wait_info {
 	struct completion completion;
 	struct sk_buff *skb;
 	bool tx_done;
+	u8 sn;
 };
 
 struct rtw89_tx_skb_data {
@@ -6289,7 +6291,7 @@ static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
 	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
 		if (!completion_done(&wait->completion))
 			continue;
-		list_del(&wait->list);
+		list_del_rcu(&wait->list);
 		rtw89_tx_wait_release(wait);
 	}
 }
@@ -7392,6 +7394,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
+static inline bool rtw89_core_is_tx_wait(struct rtw89_dev *rtwdev,
+					 struct rtw89_tx_skb_data *skb_data)
+{
+	struct rtw89_tx_wait_info *wait;
+
+	guard(rcu)();
+
+	wait = rcu_dereference(skb_data->wait);
+	if (!wait)
+		return false;
+
+	return true;
+}
+
 static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       bool tx_done)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 831e53aedccc..79409eb4d028 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5477,6 +5477,7 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
 	u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
 	u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
+	struct rtw89_tx_wait_info *wait;
 	struct sk_buff *cur, *tmp;
 	unsigned long flags;
 	u8 *n;
@@ -5485,6 +5486,16 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 		    "C2H TX RPT: sn %d, tx_status %d\n",
 		    sw_define, tx_status);
 
+	rcu_read_lock();
+	list_for_each_entry_rcu(wait, &rtwdev->tx_waits, list) {
+		if (wait->sn == sw_define) {
+			wait->tx_done = tx_status == RTW89_TX_DONE;
+			complete_all(&wait->completion);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
 	spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
 	skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
 		n = (u8 *)RTW89_TX_SKB_CB(cur)->hci_priv;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 98eff955fc96..342c05227191 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -191,8 +191,13 @@ static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
 static void rtw89_usb_ops_tx_rpt_enable(struct rtw89_dev *rtwdev,
 					struct rtw89_core_tx_request *tx_req)
 {
+	struct rtw89_tx_wait_info *wait = tx_req->wait;
+
 	tx_req->desc_info.report = true;
 	tx_req->desc_info.sn = atomic_inc_return(&rtwdev->sn) & 0xF;
+
+	if (wait)
+		wait->sn = tx_req->desc_info.sn;
 }
 
 static void rtw89_usb_write_port_complete(struct urb *urb)
@@ -313,7 +318,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 		txcb->txch = txch;
 		skb_queue_head_init(&txcb->tx_ack_queue);
 
-		skb_queue_tail(&txcb->tx_ack_queue, skb);
+		/* tx_wait skbs are completed in rtw89_mac_c2h_tx_rpt() */
+		if (!rtw89_core_is_tx_wait(rtwdev, RTW89_TX_SKB_CB(skb)))
+			skb_queue_tail(&txcb->tx_ack_queue, skb);
 
 		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
 					   txcb);
-- 
2.51.0


