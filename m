Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF33F0009
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhHRJK7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 05:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhHRJK6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 05:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5F0E6103A;
        Wed, 18 Aug 2021 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629277823;
        bh=6JvaY2bdLYLSm2aj35i2SHOKYHRMaJoE37BePqAjKl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARsf2TIr9kr3p7VCJOFkAUj51vTrBrB7T92Y0x7I5JN6YrPMaIGWHA7H/Gjg7wY3F
         wKss7Vi56Scsz4fih1WYHgow0AQ4+Od9LrYJ8KwMQYZTneqiN/rXywuenx1qt7zfy5
         CLAkqdfrX/tQVV8MW/jn0MhKGg6Y61inoEgqrs/72QH3GCEbE7mVO1N2g58RzIm/HA
         ZYnQ2zx3wmjG82KxULAn/BpKy/U/tO7O/TzS7wl+fLwalCqaSbgMh27Aj2Dg8aTHEo
         ISspaGlQna8rOQNzK7jpwy1oAZxEuqumULiN6RCptF82JIdwnANjogXBnfEKlWbkGR
         ww6wquaQ9leDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 2/5] mt76: mt7921: add support for tx status reporting
Date:   Wed, 18 Aug 2021 11:09:57 +0200
Message-Id: <8e3ff6a699187db7c4e791f09d3d87cf6290540f.1629277624.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629277624.git.lorenzo@kernel.org>
References: <cover.1629277624.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce infrastructure support for tx status reporting

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 102 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   7 ++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   3 -
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 63151bdb8fcf..83eed0797314 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -801,9 +801,11 @@ static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
 			       FIELD_PREP(MT_TXD5_PID, pid));
 }
 
-void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
-			   struct ieee80211_key_conf *key, bool beacon)
+static void
+mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+		      struct sk_buff *skb, struct mt76_wcid *wcid,
+		      struct ieee80211_key_conf *key, int pid,
+		      bool beacon)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -852,7 +854,12 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 
 	txwi[3] = cpu_to_le32(val);
 	txwi[4] = 0;
-	txwi[5] = 0;
+
+	val = FIELD_PREP(MT_TXD5_PID, pid);
+	if (pid >= MT_PACKET_ID_FIRST)
+		val |= MT_TXD5_TX_STATUS_HOST;
+	txwi[5] = cpu_to_le32(val);
+
 	txwi[6] = 0;
 	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
@@ -943,7 +950,7 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-			      false);
+			      MT_PACKET_ID_NO_SKB, false);
 
 	txp = (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
 	memset(txp, 0, sizeof(struct mt7921_txp_common));
@@ -1158,11 +1165,89 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
+static bool
+mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
+		       __le32 *txs_data)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_tx_info *info;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	mt76_tx_status_lock(mdev, &list);
+	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	if (!skb)
+		goto out;
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!(txs_data[0] & le32_to_cpu(MT_TXS0_ACK_ERROR_MASK)))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+
+	info->status.rates[0].idx = -1;
+	mt76_tx_status_skb_done(mdev, skb, &list);
+
+out:
+	mt76_tx_status_unlock(mdev, &list);
+
+	return !!skb;
+}
+
+static void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
+{
+	struct mt7921_sta *msta = NULL;
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u32 txs;
+	u8 pid;
+
+	txs = le32_to_cpu(txs_data[0]);
+	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1)
+		return;
+
+	txs = le32_to_cpu(txs_data[2]);
+	wcidx = FIELD_GET(MT_TXS2_WCID, txs);
+
+	txs = le32_to_cpu(txs_data[3]);
+	pid = FIELD_GET(MT_TXS3_PID, txs);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT7921_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	mt7921_mac_add_txs_skb(dev, wcid, pid, txs_data);
+
+	if (!wcid->sta)
+		goto out;
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
 	u16 flag;
 
@@ -1179,6 +1264,11 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	case PKT_TYPE_RX_EVENT:
 		mt7921_mcu_rx_event(dev, skb);
 		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7921_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
 	case PKT_TYPE_NORMAL_MCU:
 	case PKT_TYPE_NORMAL:
 		if (!mt7921_mac_fill_rx(dev, skb)) {
@@ -1544,6 +1634,8 @@ void mt7921_mac_work(struct work_struct *work)
 	}
 
 	mt7921_mutex_release(phy->dev);
+
+	mt76_tx_status_check(mphy->dev, NULL, false);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
 				     MT7921_WATCHDOG_TIME);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index f0194c878037..4b29d2728f4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -317,6 +317,13 @@ struct mt7921_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+
+#define MT_TXS2_WCID			GENMASK(25, 16)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+
 static inline struct mt7921_txp_common *
 mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 0baa9b37aeda..761fc605e5e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -326,9 +326,6 @@ static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
 int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
-void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
-			   struct ieee80211_key_conf *key, bool beacon);
 void mt7921_mac_set_timing(struct mt7921_phy *phy);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
-- 
2.31.1

