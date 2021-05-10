Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35309377F56
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEJJ2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F561C06138A
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DC3dWpmfMDAWIB5qtBDA6DZfg8UmqHyLnwSp2YU5LXI=; b=JJ5wmK2ALD43zsswqEYVttyip0
        bQ1NTFICZmAcbvlR6fYbtlI3FZC2cAaF6wceixbvotyDRyqG4m+qlKb21xjIyRovmhS1t9kAELRTW
        9xw4FeJ8Qsd3xYphMB4PX1dsDGC+kNuRlVoorkZ+OLZJ81W58i7aWSYrdV8f5OixAJlg=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bu-000572-NJ
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 9/9] mt76: mt7915: add support for tx status reporting
Date:   Mon, 10 May 2021 11:27:03 +0200
Message-Id: <20210510092703.90500-9-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210510092703.90500-1-nbd@nbd.name>
References: <20210510092703.90500-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For now, this only reports ACK status

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 124 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  56 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +-
 4 files changed, 154 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9b453e45fde0..f8bb043f9be7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -887,7 +887,7 @@ mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
 }
 
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, bool beacon)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -946,7 +946,12 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 
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
 
@@ -986,11 +991,11 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_tx_cb *cb = mt76_tx_skb_cb(tx_info->skb);
 	struct mt76_txwi_cache *t;
 	struct mt7915_txp *txp;
 	int id, i, nbuf = tx_info->nbuf - 1;
 	u8 *txwi = (u8 *)txwi_ptr;
+	int pid;
 
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
@@ -998,10 +1003,10 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-			      false);
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 
-	cb->wcid = wcid->idx;
+	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key,
+			      false);
 
 	txp = (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1088,9 +1093,7 @@ static void
 mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 		 struct ieee80211_sta *sta, struct list_head *free_list)
 {
-	struct ieee80211_tx_status status = {};
 	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_tx_info *info;
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
@@ -1110,26 +1113,6 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
 	}
 
-	info = IEEE80211_SKB_CB(t->skb);
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
-		struct ieee80211_hw *hw;
-
-		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
-			info->flags |= IEEE80211_TX_STAT_ACK;
-
-		info->status.rates[0].count = 0;
-		info->status.rates[0].idx = -1;
-
-		status.skb = t->skb;
-		status.sta = sta;
-		status.info = info;
-
-		hw = mt76_tx_status_get_hw(mdev, t->skb);
-		ieee80211_tx_status_ext(hw, &status);
-
-		goto out;
-	}
-
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
 
 out:
@@ -1221,11 +1204,89 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static bool
+mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
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
+static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
+{
+	struct mt7915_sta *msta = NULL;
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
+	if (wcidx >= MT7915_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data);
+
+	if (!wcid->sta)
+		goto out;
+
+	msta = container_of(wcid, struct mt7915_sta, wcid);
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
 
 	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
@@ -1240,6 +1301,11 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	case PKT_TYPE_TXRXV:
 		mt7915_mac_fill_rx_vector(dev, skb);
 		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+		    mt7915_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
 	case PKT_TYPE_NORMAL:
 		if (!mt7915_mac_fill_rx(dev, skb)) {
 			mt76_rx(&dev->mt76, q, skb);
@@ -1775,6 +1841,8 @@ void mt7915_mac_work(struct work_struct *work)
 
 	mutex_unlock(&mphy->dev->mutex);
 
+	mt76_tx_status_check(mphy->dev, NULL, false);
+
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7915_WATCHDOG_TIME);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 0f929fb53027..eb1885f4bd8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -304,6 +304,62 @@ struct mt7915_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
+#define MT_TXS0_FIXED_RATE		BIT(31)
+#define MT_TXS0_BW			GENMASK(30, 29)
+#define MT_TXS0_TID			GENMASK(28, 26)
+#define MT_TXS0_AMPDU			BIT(25)
+#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+#define MT_TXS0_BA_ERROR		BIT(22)
+#define MT_TXS0_PS_FLAG			BIT(21)
+#define MT_TXS0_TXOP_TIMEOUT		BIT(20)
+#define MT_TXS0_BIP_ERROR		BIT(19)
+
+#define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
+#define MT_TXS0_RTS_TIMEOUT		BIT(17)
+#define MT_TXS0_ACK_TIMEOUT		BIT(16)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+
+#define MT_TXS0_TX_STATUS_HOST		BIT(15)
+#define MT_TXS0_TX_STATUS_MCU		BIT(14)
+#define MT_TXS0_TX_RATE			GENMASK(13, 0)
+
+#define MT_TXS1_SEQNO			GENMASK(31, 20)
+#define MT_TXS1_RESP_RATE		GENMASK(19, 16)
+#define MT_TXS1_RXV_SEQNO		GENMASK(15, 8)
+#define MT_TXS1_TX_POWER_DBM		GENMASK(7, 0)
+
+#define MT_TXS2_BF_STATUS		GENMASK(31, 30)
+#define MT_TXS2_LAST_TX_RATE		GENMASK(29, 27)
+#define MT_TXS2_SHARED_ANTENNA		BIT(26)
+#define MT_TXS2_WCID			GENMASK(25, 16)
+#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+#define MT_TXS3_ANT_ID			GENMASK(23, 0)
+
+#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
+
+#define MT_TXS5_F0_FINAL_MPDU		BIT(31)
+#define MT_TXS5_F0_QOS			BIT(30)
+#define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
+#define MT_TXS5_F0_FRONT_TIME		GENMASK(24, 0)
+#define MT_TXS5_F1_MPDU_TX_COUNT	GENMASK(31, 24)
+#define MT_TXS5_F1_MPDU_TX_BYTES	GENMASK(23, 0)
+
+#define MT_TXS6_F0_NOISE_3		GENMASK(31, 24)
+#define MT_TXS6_F0_NOISE_2		GENMASK(23, 16)
+#define MT_TXS6_F0_NOISE_1		GENMASK(15, 8)
+#define MT_TXS6_F0_NOISE_0		GENMASK(7, 0)
+#define MT_TXS6_F1_MPDU_FAIL_COUNT	GENMASK(31, 24)
+#define MT_TXS6_F1_MPDU_FAIL_BYTES	GENMASK(23, 0)
+
+#define MT_TXS7_F0_RCPI_3		GENMASK(31, 24)
+#define MT_TXS7_F0_RCPI_2		GENMASK(23, 16)
+#define MT_TXS7_F0_RCPI_1		GENMASK(15, 8)
+#define MT_TXS7_F0_RCPI_0		GENMASK(7, 0)
+#define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
+#define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
+
 struct mt7915_dfs_pulse {
 	u32 max_width;		/* us */
 	int max_pwr;		/* dbm */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9ec414de317e..76e8aa604e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2440,7 +2440,7 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
 		cont->csa_ofs = cpu_to_le16(offs->cntdwn_counter_offs[0] - 4);
 
 	buf = (u8 *)tlv + sizeof(*cont);
-	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
+	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
 			      true);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0342729145e7..c4bf8edeb1dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -395,7 +395,7 @@ void mt7915_mac_reset_counters(struct mt7915_phy *phy);
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy);
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, bool beacon);
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
 int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.30.1

