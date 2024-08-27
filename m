Return-Path: <linux-wireless+bounces-12040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCA960598
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93FC1F24419
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F619D89E;
	Tue, 27 Aug 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sDoaoJB6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAA19CD17
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751024; cv=none; b=KttxnZl9982tQL0Z50spxoM1Xmf33BcKsBcFno4m+IjKAa/SQe50qzDac37cV+Dovl7DAc+OKC0PTNl6QEyM+8mYmFTcT2wiW9g4YlcxKeabibjs1k3PTBz3D3IGYcIR2zoydikBVYXYMnX7CN+HDC+rb3BwXdGnth4hRAw7gHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751024; c=relaxed/simple;
	bh=HTNF2otldyO/+MoizoaAigYj/FFgWrMZH6eM9UKpR8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F98xfQdhaU1CXac7pHBpYTdRDqHV4YfAbCr24iOzYdzq19owITsm4nTeohg7HM0guezYyRwrX0NAyLVRDwqKHzAsnnYRh1bxXITKSh2gRObzmjaM3tOCGsWupVgKOzBGUJ+9aPCnjtkqT/9FnCt7fGRxUO+nUWc/PHsPsdfB3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sDoaoJB6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=he+WEB26cup5S4F6QkLmRDR69yVTKcJm9u5yBaUaWXA=; b=sDoaoJB6HmsySHyRfThYYz+E6m
	Zz8Uoc5uviXpMqa1pERMSDwnBhhxyBRmnrPsVjnVf2kp6Upr2L3JcgQllLk+vJCYjXmSzVZCipCtx
	30eIJrOssMFL1i/wScXsugT88ksSZsMsxDp5CDLXwVxyKn7QPtgX5Sy9she6TFkxNJwo=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWk-004Ww8-23
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 06/24] wifi: mt76: add separate tx scheduling queue for off-channel tx
Date: Tue, 27 Aug 2024 11:29:53 +0200
Message-ID: <20240827093011.18621-6-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that packets are not sent out to the wrong channel

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  7 +--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 59 ++++++++++++-------
 3 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a24186c9a913..6183b021f6eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -941,8 +941,7 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	mutex_lock(&dev->mutex);
 	set_bit(MT76_RESET, &phy->state);
 
-	ieee80211_stop_queues(phy->hw);
-
+	mt76_worker_disable(&dev->tx_worker);
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(phy);
 
@@ -959,12 +958,11 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 
 	if (chandef->chan != phy->main_chan)
 		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
+	mt76_worker_enable(&dev->tx_worker);
 
 	ret = dev->drv->set_channel(phy);
 
 	clear_bit(MT76_RESET, &phy->state);
-	ieee80211_wake_queues(phy->hw);
-
 	mt76_worker_schedule(&dev->tx_worker);
 
 	mutex_unlock(&dev->mutex);
@@ -1548,6 +1546,7 @@ void mt76_wcid_init(struct mt76_wcid *wcid)
 {
 	INIT_LIST_HEAD(&wcid->tx_list);
 	skb_queue_head_init(&wcid->tx_pending);
+	skb_queue_head_init(&wcid->tx_offchannel);
 
 	INIT_LIST_HEAD(&wcid->list);
 	idr_init(&wcid->pktid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6c054f43e7ce..87048aa27fbf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -361,6 +361,7 @@ struct mt76_wcid {
 
 	struct list_head tx_list;
 	struct sk_buff_head tx_pending;
+	struct sk_buff_head tx_offchannel;
 
 	struct list_head list;
 	struct idr pktid;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5cf6edee4d13..7f7783f7d977 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -330,6 +330,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct sk_buff_head *head;
 
 	if (mt76_testmode_enabled(phy)) {
 		ieee80211_free_txskb(phy->hw, skb);
@@ -345,9 +346,15 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 
-	spin_lock_bh(&wcid->tx_pending.lock);
-	__skb_queue_tail(&wcid->tx_pending, skb);
-	spin_unlock_bh(&wcid->tx_pending.lock);
+	if ((info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) ||
+	    (info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+		head = &wcid->tx_offchannel;
+	else
+		head = &wcid->tx_pending;
+
+	spin_lock_bh(&head->lock);
+	__skb_queue_tail(head, skb);
+	spin_unlock_bh(&head->lock);
 
 	spin_lock_bh(&phy->tx_lock);
 	if (list_empty(&wcid->tx_list))
@@ -478,7 +485,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		return idx;
 
 	do {
-		if (test_bit(MT76_RESET, &phy->state))
+		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
 			return -EBUSY;
 
 		if (stop || mt76_txq_stopped(q))
@@ -522,7 +529,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 	while (1) {
 		int n_frames = 0;
 
-		if (test_bit(MT76_RESET, &phy->state))
+		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
 			return -EBUSY;
 
 		if (dev->queue_ops->tx_cleanup &&
@@ -568,7 +575,7 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
 	int len;
 
-	if (qid >= 4)
+	if (qid >= 4 || phy->offchannel)
 		return;
 
 	local_bh_disable();
@@ -586,7 +593,8 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 
 static int
-mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
+mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
+			       struct sk_buff_head *head)
 {
 	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_sta *sta;
@@ -594,8 +602,8 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
 	struct sk_buff *skb;
 	int ret = 0;
 
-	spin_lock(&wcid->tx_pending.lock);
-	while ((skb = skb_peek(&wcid->tx_pending)) != NULL) {
+	spin_lock(&head->lock);
+	while ((skb = skb_peek(head)) != NULL) {
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 		int qid = skb_get_queue_mapping(skb);
@@ -607,13 +615,13 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
 			qid = MT_TXQ_PSD;
 
 		q = phy->q_tx[qid];
-		if (mt76_txq_stopped(q)) {
+		if (mt76_txq_stopped(q) || test_bit(MT76_RESET, &phy->state)) {
 			ret = -1;
 			break;
 		}
 
-		__skb_unlink(skb, &wcid->tx_pending);
-		spin_unlock(&wcid->tx_pending.lock);
+		__skb_unlink(skb, head);
+		spin_unlock(&head->lock);
 
 		sta = wcid_to_sta(wcid);
 		spin_lock(&q->lock);
@@ -621,15 +629,17 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
 		dev->queue_ops->kick(dev, q);
 		spin_unlock(&q->lock);
 
-		spin_lock(&wcid->tx_pending.lock);
+		spin_lock(&head->lock);
 	}
-	spin_unlock(&wcid->tx_pending.lock);
+	spin_unlock(&head->lock);
 
 	return ret;
 }
 
 static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
+	LIST_HEAD(tx_list);
+
 	if (list_empty(&phy->tx_list))
 		return;
 
@@ -637,22 +647,27 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 	rcu_read_lock();
 
 	spin_lock(&phy->tx_lock);
-	while (!list_empty(&phy->tx_list)) {
-		struct mt76_wcid *wcid = NULL;
+	list_splice_init(&phy->tx_list, &tx_list);
+	while (!list_empty(&tx_list)) {
+		struct mt76_wcid *wcid;
 		int ret;
 
-		wcid = list_first_entry(&phy->tx_list, struct mt76_wcid, tx_list);
+		wcid = list_first_entry(&tx_list, struct mt76_wcid, tx_list);
 		list_del_init(&wcid->tx_list);
 
 		spin_unlock(&phy->tx_lock);
-		ret = mt76_txq_schedule_pending_wcid(phy, wcid);
+		ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_offchannel);
+		if (ret >= 0 && !phy->offchannel)
+			ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_pending);
 		spin_lock(&phy->tx_lock);
 
-		if (ret) {
-			if (list_empty(&wcid->tx_list))
-				list_add_tail(&wcid->tx_list, &phy->tx_list);
+		if (!skb_queue_empty(&wcid->tx_pending) &&
+		    !skb_queue_empty(&wcid->tx_offchannel) &&
+		    list_empty(&wcid->tx_list))
+			list_add_tail(&wcid->tx_list, &phy->tx_list);
+
+		if (ret < 0)
 			break;
-		}
 	}
 	spin_unlock(&phy->tx_lock);
 
-- 
2.46.0


