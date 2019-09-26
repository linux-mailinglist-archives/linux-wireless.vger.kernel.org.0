Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43FBF7D9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIZRri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:38 -0400
Received: from nbd.name ([46.4.11.11]:55254 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfIZRrh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PzD5c/BIsvqCPO3Xpxvq27XUKaj250pepsVvv5ek9zg=; b=lAORO7cMSaeBTqY5rS0H3xaHJW
        B9vR1BPM0XZiIT8s/p7lQ24VfSwwcP5UMa/yC5aOIiXJHDLlPuVOJnx7602D5PiyHFYuR4G1Feqb4
        eCHxma2KXgFVdtEoXCBImi9MiIU2q/QdoE7L4vjI30aU9cXq87fA8YYDYCmjJWUxMlwM=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000z0-JJ
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B88BF69B6A8E; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 14/15] mt76: mt7615: track tx/rx airtime for airtime fairness
Date:   Thu, 26 Sep 2019 19:47:31 +0200
Message-Id: <20190926174732.42375-14-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Poll per-station hardware counters available in WTBL after tx/rx
status events in order to report tx/rx airtime to mac80211 layer

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  2 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 12 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 92 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 16 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  3 +
 6 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index fe532cecbbdd..285d4f1d6178 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -110,6 +110,8 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++)
 		mt76_queue_tx_cleanup(dev, queue_map[i], false);
 
+	mt7615_mac_sta_poll(dev);
+
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 05a9e1154dd5..1e7723aceee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -21,6 +21,7 @@ static void mt7615_phy_init(struct mt7615_dev *dev)
 static void mt7615_mac_init(struct mt7615_dev *dev)
 {
 	u32 val, mask, set;
+	int i;
 
 	/* enable band 0/1 clk */
 	mt76_set(dev, MT_CFG_CCR,
@@ -97,7 +98,12 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_rmw(dev, MT_DMA_BN0RCFR0, mask, set);
 	mt76_rmw(dev, MT_DMA_BN1RCFR0, mask, set);
 
+	for (i = 0; i < MT7615_WTBL_SIZE; i++)
+		mt7615_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_EN);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
@@ -262,12 +268,14 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	struct wiphy *wiphy = hw->wiphy;
 	int ret;
 
+	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
 	ret = mt7615_init_hardware(dev);
 	if (ret)
 		return ret;
 
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
-
 	hw->queues = 4;
 	hw->max_rates = 3;
 	hw->max_report_rates = 7;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2e36b3289fa6..2b810ba359ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -57,6 +57,7 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 	mt76_rr(dev, MT_MIB_SDR36(0));
 	mt76_rr(dev, MT_MIB_SDR37(0));
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
@@ -80,6 +81,16 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
 	status->wcid = mt7615_rx_get_wcid(dev, idx, unicast);
 
+	if (status->wcid) {
+		struct mt7615_sta *msta;
+
+		msta = container_of(status->wcid, struct mt7615_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
 	/* TODO: properly support DBDC */
 	status->freq = dev->mt76.chandef.chan->center_freq;
 	status->band = dev->mt76.chandef.chan->band;
@@ -501,6 +512,82 @@ bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
+void mt7615_mac_sta_poll(struct mt7615_dev *dev)
+{
+	static const u8 ac_to_tid[4] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	static const u8 hw_queue_map[] = {
+		[IEEE80211_AC_BK] = 0,
+		[IEEE80211_AC_BE] = 1,
+		[IEEE80211_AC_VI] = 2,
+		[IEEE80211_AC_VO] = 3,
+	};
+	struct ieee80211_sta *sta;
+	struct mt7615_sta *msta;
+	u32 addr, tx_time[4], rx_time[4];
+	int i;
+
+	rcu_read_lock();
+
+	while (true) {
+		bool clear = false;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&dev->sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&dev->sta_poll_list,
+					struct mt7615_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		addr = mt7615_mac_wtbl_addr(msta->wcid.idx) + 19 * 4;
+
+		for (i = 0; i < 4; i++, addr += 8) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+		}
+
+		if (clear) {
+			mt7615_mac_wtbl_update(dev, msta->wcid.idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < 4; i++) {
+			u32 tx_cur = tx_time[i];
+			u32 rx_cur = rx_time[hw_queue_map[i]];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+						       rx_cur);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
 void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
@@ -1064,6 +1151,11 @@ void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	msta = container_of(wcid, struct mt7615_sta, wcid);
 	sta = wcid_to_sta(wcid);
 
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9707fa8b5485..942076b6d1ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -99,8 +99,12 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	dev->vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT(mvif->omac_idx);
 	idx = MT7615_WTBL_RESERVED - mvif->idx;
+
+	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
+	mt7615_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
@@ -360,9 +364,12 @@ int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
+	INIT_LIST_HEAD(&msta->poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
+	mt7615_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	mt7615_mcu_add_wtbl(dev, vif, sta);
 	mt7615_mcu_set_sta_rec(dev, vif, sta, 1);
@@ -383,9 +390,18 @@ void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 
 	mt7615_mcu_set_sta_rec(dev, vif, sta, 0);
 	mt7615_mcu_del_wtbl(dev, sta);
+
+	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
 static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 070afba63e43..d537f68c5531 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -56,6 +56,9 @@ struct mt7615_sta {
 
 	struct mt7615_vif *vif;
 
+	struct list_head poll_list;
+	u32 airtime_ac[8];
+
 	struct ieee80211_tx_rate rates[4];
 
 	struct mt7615_rate_set rateset[2];
@@ -83,6 +86,9 @@ struct mt7615_dev {
 
 	__le32 rx_ampdu_ts;
 
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
 	struct {
 		u8 n_pulses;
 		u32 period;
@@ -235,6 +241,7 @@ bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
+void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 226b9ada89f6..99bd5939d33f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -202,6 +202,8 @@
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
 #define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
 
+#define MT_WF_RMAC_MIB_AIRTIME0		MT_WF_RMAC(0x0380)
+
 #define MT_WF_RMAC_MIB_TIME5		MT_WF_RMAC(0x03d8)
 #define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
 
@@ -236,6 +238,7 @@
 #define MT_WTBL_UPDATE			MT_WTBL_OFF(0x030)
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(7, 0)
 #define MT_WTBL_UPDATE_RXINFO_UPDATE	BIT(11)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_RATE_UPDATE	BIT(13)
 #define MT_WTBL_UPDATE_TX_COUNT_CLEAR	BIT(14)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
-- 
2.17.0

