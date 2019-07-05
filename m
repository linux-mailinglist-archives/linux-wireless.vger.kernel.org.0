Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45605FB3E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfGDPx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 11:53:28 -0400
Received: from nbd.name ([46.4.11.11]:38248 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfGDPx0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZTDtM5IEBN6JDAFWnUDK2rbtNlC7lqjtilu00xgVZYU=; b=dWBog994tphCSUMh8cj9HVlj6n
        CstVsSQ74tU3NRGWIgu/ADQzOWMbIx/8+5AhIsahjUiUHFOJsKeuOmY5hyJdCuprH5XvsFh/QlJFj
        AWLnAGfTYYcv80FiZopP/1eAO6t4amKI/IPWUtJ6uBFpUu3U9rzFXBZtTixew22zkrgM=;
Received: from p54ae9425.dip0.t-ipconnect.de ([84.174.148.37] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hj432-0004qU-Vh
        for linux-wireless@vger.kernel.org; Thu, 04 Jul 2019 17:53:25 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 60C646165C11; Thu,  4 Jul 2019 17:53:24 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt7615: move mt7615_mcu_set_rates to mac.c
Date:   Thu,  4 Jul 2019 17:53:22 +0200
Message-Id: <20190704155324.56693-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190704155324.56693-1-nbd@nbd.name>
References: <20190704155324.56693-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It bypasses the MCU, so it does not belong in mcu.c
Also make mt7615_mac_tx_rate_val static

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 100 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  88 ---------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   5 +-
 4 files changed, 97 insertions(+), 98 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 08cc3f46b011..49c14eb008d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -248,9 +248,10 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 		mt76_tx_complete_skb(mdev, e->skb);
 }
 
-u16 mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
-			   const struct ieee80211_tx_rate *rate,
-			   bool stbc, u8 *bw)
+static u16
+mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
+		       const struct ieee80211_tx_rate *rate,
+		       bool stbc, u8 *bw)
 {
 	u8 phy, nss, rate_idx;
 	u16 rateval;
@@ -446,6 +447,95 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
 
+void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
+			  struct ieee80211_tx_rate *probe_rate,
+			  struct ieee80211_tx_rate *rates)
+{
+	int wcid = sta->wcid.idx;
+	u32 addr = MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
+	bool stbc = false;
+	int n_rates = sta->n_rates;
+	u8 bw, bw_prev, bw_idx = 0;
+	u16 val[4];
+	u16 probe_val;
+	u32 w5, w27;
+	int i;
+
+	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
+		return;
+
+	for (i = n_rates; i < 4; i++)
+		rates[i] = rates[n_rates - 1];
+
+	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
+	bw_prev = bw;
+
+	if (probe_rate) {
+		probe_val = mt7615_mac_tx_rate_val(dev, probe_rate, stbc, &bw);
+		if (bw)
+			bw_idx = 1;
+		else
+			bw_prev = 0;
+	} else {
+		probe_val = val[0];
+	}
+
+	val[1] = mt7615_mac_tx_rate_val(dev, &rates[1], stbc, &bw);
+	if (bw_prev) {
+		bw_idx = 3;
+		bw_prev = bw;
+	}
+
+	val[2] = mt7615_mac_tx_rate_val(dev, &rates[2], stbc, &bw);
+	if (bw_prev) {
+		bw_idx = 5;
+		bw_prev = bw;
+	}
+
+	val[3] = mt7615_mac_tx_rate_val(dev, &rates[3], stbc, &bw);
+	if (bw_prev)
+		bw_idx = 7;
+
+	w27 = mt76_rr(dev, addr + 27 * 4);
+	w27 &= ~MT_WTBL_W27_CC_BW_SEL;
+	w27 |= FIELD_PREP(MT_WTBL_W27_CC_BW_SEL, bw);
+
+	w5 = mt76_rr(dev, addr + 5 * 4);
+	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE);
+	w5 |= FIELD_PREP(MT_WTBL_W5_BW_CAP, bw) |
+	      FIELD_PREP(MT_WTBL_W5_CHANGE_BW_RATE, bw_idx ? bw_idx - 1 : 7);
+
+	mt76_wr(dev, MT_WTBL_RIUCR0, w5);
+
+	mt76_wr(dev, MT_WTBL_RIUCR1,
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE0, probe_val) |
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE1, val[0]) |
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, val[0]));
+
+	mt76_wr(dev, MT_WTBL_RIUCR2,
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, val[0] >> 8) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE3, val[1]) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, val[1]) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE5_LO, val[2]));
+
+	mt76_wr(dev, MT_WTBL_RIUCR3,
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE5_HI, val[2] >> 4) |
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, val[2]) |
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE7, val[3]));
+
+	mt76_wr(dev, MT_WTBL_UPDATE,
+		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid) |
+		MT_WTBL_UPDATE_RATE_UPDATE |
+		MT_WTBL_UPDATE_TX_COUNT_CLEAR);
+
+	mt76_wr(dev, addr + 27 * 4, w27);
+
+	if (!(sta->wcid.tx_info & MT_WCID_TX_INFO_SET))
+		mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000);
+
+	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
+	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+}
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -470,7 +560,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
 		spin_lock_bh(&dev->mt76.lock);
 		msta->rate_probe = true;
-		mt7615_mcu_set_rates(dev, msta, &info->control.rates[0],
+		mt7615_mac_set_rates(dev, msta, &info->control.rates[0],
 				     msta->rates);
 		spin_unlock_bh(&dev->mt76.lock);
 	}
@@ -645,7 +735,7 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 		if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
 			spin_lock_bh(&dev->mt76.lock);
 			if (sta->rate_probe) {
-				mt7615_mcu_set_rates(dev, sta, NULL,
+				mt7615_mac_set_rates(dev, sta, NULL,
 						     sta->rates);
 				sta->rate_probe = false;
 			}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8fefcfba83b1..3f5f355d1f9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -391,7 +391,7 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 			break;
 	}
 	msta->n_rates = i;
-	mt7615_mcu_set_rates(dev, msta, NULL, msta->rates);
+	mt7615_mac_set_rates(dev, msta, NULL, msta->rates);
 	msta->rate_probe = false;
 	spin_unlock_bh(&dev->mt76.lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0c9d1df86212..e57b51290c61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1647,92 +1647,4 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 				   &wtbl_req, sizeof(wtbl_req), true);
 }
 
-void mt7615_mcu_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
-			  struct ieee80211_tx_rate *probe_rate,
-			  struct ieee80211_tx_rate *rates)
-{
-	int wcid = sta->wcid.idx;
-	u32 addr = MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
-	bool stbc = false;
-	int n_rates = sta->n_rates;
-	u8 bw, bw_prev, bw_idx = 0;
-	u16 val[4];
-	u16 probe_val;
-	u32 w5, w27;
-	int i;
-
-	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
-		return;
-
-	for (i = n_rates; i < 4; i++)
-		rates[i] = rates[n_rates - 1];
-
-	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
-	bw_prev = bw;
-
-	if (probe_rate) {
-		probe_val = mt7615_mac_tx_rate_val(dev, probe_rate, stbc, &bw);
-		if (bw)
-			bw_idx = 1;
-		else
-			bw_prev = 0;
-	} else {
-		probe_val = val[0];
-	}
-
-	val[1] = mt7615_mac_tx_rate_val(dev, &rates[1], stbc, &bw);
-	if (bw_prev) {
-		bw_idx = 3;
-		bw_prev = bw;
-	}
-
-	val[2] = mt7615_mac_tx_rate_val(dev, &rates[2], stbc, &bw);
-	if (bw_prev) {
-		bw_idx = 5;
-		bw_prev = bw;
-	}
-
-	val[3] = mt7615_mac_tx_rate_val(dev, &rates[3], stbc, &bw);
-	if (bw_prev)
-		bw_idx = 7;
-
-	w27 = mt76_rr(dev, addr + 27 * 4);
-	w27 &= ~MT_WTBL_W27_CC_BW_SEL;
-	w27 |= FIELD_PREP(MT_WTBL_W27_CC_BW_SEL, bw);
-
-	w5 = mt76_rr(dev, addr + 5 * 4);
-	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE);
-	w5 |= FIELD_PREP(MT_WTBL_W5_BW_CAP, bw) |
-	      FIELD_PREP(MT_WTBL_W5_CHANGE_BW_RATE, bw_idx ? bw_idx - 1 : 7);
-
-	mt76_wr(dev, MT_WTBL_RIUCR0, w5);
-
-	mt76_wr(dev, MT_WTBL_RIUCR1,
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE0, probe_val) |
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE1, val[0]) |
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, val[0]));
 
-	mt76_wr(dev, MT_WTBL_RIUCR2,
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, val[0] >> 8) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE3, val[1]) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, val[1]) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE5_LO, val[2]));
-
-	mt76_wr(dev, MT_WTBL_RIUCR3,
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE5_HI, val[2] >> 4) |
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, val[2]) |
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE7, val[3]));
-
-	mt76_wr(dev, MT_WTBL_UPDATE,
-		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid) |
-		MT_WTBL_UPDATE_RATE_UPDATE |
-		MT_WTBL_UPDATE_TX_COUNT_CLEAR);
-
-	mt76_wr(dev, addr + 27 * 4, w27);
-
-	if (!(sta->wcid.tx_info & MT_WCID_TX_INFO_SET))
-		mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000);
-
-	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
-	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3713db874ef4..1135023507b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -151,7 +151,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd);
-void mt7615_mcu_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
+void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
 int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -206,9 +206,6 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
-u16 mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
-			   const struct ieee80211_tx_rate *rate,
-			   bool stbc, u8 *bw);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
-- 
2.17.0

