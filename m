Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1F24283D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHLK2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHLK2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5696C06178A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dOqAmpAxhE38WVD2u4qgKqtSmbV9yYFa3DQbG4tY6jw=; b=OWCL/WgNKMet1AnvespbJCv6VW
        13C+W11T+IzqZIf/bzcudqB3zn5kORbsAL6v01C6dvzUk8ejMYic55G6nbdAJH2XeLn4wMZsorGRo
        egKl3jJfkzy8BOBuqiSkNnY5duQNBIyQwXvisxV+GWugbbQmgAvpOJlWcP2GcQDVWYEo=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzk-0002U3-Bz
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] mt76: move mt76_check_agg_ssn to driver tx_prepare calls
Date:   Wed, 12 Aug 2020 12:28:27 +0200
Message-Id: <20200812102831.11991-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812102831.11991-1-nbd@nbd.name>
References: <20200812102831.11991-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615 and newer drivers do not need this, since they use sequence number offload
Moving this code also reduces the number of callsites to make it easier to review

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 38 +++++++------------
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c7afc1c7cb2f..f11978f2bd8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -914,6 +914,7 @@ void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq);
 void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar);
+void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_phy *phy);
 void mt76_tx_tasklet(unsigned long data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8060c1514396..625dc6d581f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1036,6 +1036,8 @@ int mt7603_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				    IEEE80211_TX_CTL_CLEAR_PS_FILT)) ||
 		    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
 			mt7603_wtbl_set_ps(dev, msta, false);
+
+		mt76_tx_check_agg_ssn(sta, tx_info->skb);
 	}
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index e4e03beabe43..af2e6ffce001 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -349,6 +349,8 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 
 	memset(txwi, 0, sizeof(*txwi));
 
+	mt76_tx_check_agg_ssn(sta, skb);
+
 	if (!info->control.hw_key && wcid && wcid->hw_key_idx != 0xff &&
 	    ieee80211_has_protected(hdr->frame_control)) {
 		wcid = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 40ec55ac9a7c..d8252e28bacd 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -83,17 +83,27 @@ mt76_txq_get_qid(struct ieee80211_txq *txq)
 	return txq->ac;
 }
 
-static void
-mt76_check_agg_ssn(struct mt76_txq *mtxq, struct sk_buff *skb)
+void
+mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_txq *txq;
+	struct mt76_txq *mtxq;
+	u8 tid;
 
-	if (!ieee80211_is_data_qos(hdr->frame_control) ||
+	if (!sta || !ieee80211_is_data_qos(hdr->frame_control) ||
 	    !ieee80211_is_data_present(hdr->frame_control))
 		return;
 
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	txq = sta->txq[tid];
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+	if (!mtxq->aggr)
+		return;
+
 	mtxq->agg_ssn = le16_to_cpu(hdr->seq_ctrl) + 0x10;
 }
+EXPORT_SYMBOL_GPL(mt76_tx_check_agg_ssn);
 
 void
 mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
@@ -288,19 +298,6 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
 
-	if (sta && ieee80211_is_data_qos(hdr->frame_control)) {
-		struct ieee80211_txq *txq;
-		struct mt76_txq *mtxq;
-		u8 tid;
-
-		tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-		txq = sta->txq[tid];
-		mtxq = (struct mt76_txq *)txq->drv_priv;
-
-		if (mtxq->aggr)
-			mt76_check_agg_ssn(mtxq, skb);
-	}
-
 	if (ext_phy)
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 
@@ -390,9 +387,6 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			if (!skb)
 				break;
 
-			if (mtxq->aggr)
-				mt76_check_agg_ssn(mtxq, skb);
-
 			nframes--;
 			if (last_skb)
 				mt76_queue_ps_skb(dev, sta, last_skb, false);
@@ -446,9 +440,6 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 	ampdu = IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	limit = ampdu ? 16 : 3;
 
-	if (ampdu)
-		mt76_check_agg_ssn(mtxq, skb);
-
 	idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid, txq->sta);
 
 	if (idx < 0)
@@ -479,9 +470,6 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 
 		info->control.rates[0] = tx_rate;
 
-		if (cur_ampdu)
-			mt76_check_agg_ssn(mtxq, skb);
-
 		idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid,
 						   txq->sta);
 		if (idx < 0)
-- 
2.28.0

