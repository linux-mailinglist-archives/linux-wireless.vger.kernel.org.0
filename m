Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C321A15D464
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgBNJML (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:12:11 -0500
Received: from nbd.name ([46.4.11.11]:41282 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387409AbgBNJML (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yWYbNPqca0QVHiZjBmw1CW3r38l8GdOOkYB2oHmDUj4=; b=Kzkx5bfUmIm1U01/CYuEGu99pF
        hkqOsEw3U7STMuwxBNnhWty/Urrtd1apofKGHMeeN9+oG/M+ufdwhhXFw3QCZiJrrXl59kWaSSHRq
        y4o90wFRCqf2mJfRkxr1qiXNvZ/8dGL198P0nTuvs9IZhLO8EFWsIEebhcb/k6pcIvos=;
Received: from [80.255.7.100] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j2X17-0006Mr-Sd
        for linux-wireless@vger.kernel.org; Fri, 14 Feb 2020 10:12:10 +0100
Received: by maeck.local (Postfix, from userid 501)
        id D73A67C82120; Fri, 14 Feb 2020 10:12:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: fix rounding issues on converting per-chain and combined txpower
Date:   Fri, 14 Feb 2020 10:12:06 +0100
Message-Id: <20200214091208.59619-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unify code converting between the different txpower values. Always add/remove
the combined txpower delta before dividing half-dB values.
Also fix the combined txpower delta values. The correct half-dB delta for
3 chains is 9, not 8.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 20 ++-----------------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  7 +++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 17 ++--------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  7 ++++---
 4 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4b19ac91ab72..f74fc7130ed2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1051,25 +1051,9 @@ int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76_phy *phy = hw->priv;
 	int n_chains = hweight8(phy->antenna_mask);
+	int delta = mt76_tx_power_nss_delta(n_chains);
 
-	*dbm = DIV_ROUND_UP(phy->txpower_cur, 2);
-
-	/* convert from per-chain power to combined
-	 * output power
-	 */
-	switch (n_chains) {
-	case 4:
-		*dbm += 6;
-		break;
-	case 3:
-		*dbm += 4;
-		break;
-	case 2:
-		*dbm += 3;
-		break;
-	default:
-		break;
-	}
+	*dbm = DIV_ROUND_UP(phy->txpower_cur + delta, 2);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ca9d8ae43fec..844e58f18a2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -755,6 +755,13 @@ static inline bool mt76_is_skb_pktid(u8 pktid)
 	return pktid >= MT_PACKET_ID_FIRST;
 }
 
+static inline u8 mt76_tx_power_nss_delta(u8 nss)
+{
+	static const u8 nss_delta[4] = { 0, 6, 9, 12 };
+
+	return nss_delta[nss - 1];
+}
+
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
 void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 4c9f52e04bb8..889eb72ad6bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -269,6 +269,7 @@ mt7615_init_txpower(struct mt7615_dev *dev,
 	int i, n_chains = hweight8(dev->mphy.antenna_mask), target_chains;
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
+	int delta = mt76_tx_power_nss_delta(n_chains);
 
 	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
 	for (i = 0; i < sband->n_channels; i++) {
@@ -283,21 +284,7 @@ mt7615_init_txpower(struct mt7615_dev *dev,
 			target_power = max(target_power, eep[index]);
 		}
 
-		target_power = DIV_ROUND_UP(target_power, 2);
-		switch (n_chains) {
-		case 4:
-			target_power += 6;
-			break;
-		case 3:
-			target_power += 4;
-			break;
-		case 2:
-			target_power += 3;
-			break;
-		default:
-			break;
-		}
-
+		target_power = DIV_ROUND_UP(target_power + delta, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
 					target_power);
 		chan->orig_mpwr = target_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f5b04afe9cf4..68f35aa15c60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1595,14 +1595,14 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 
 static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 {
-	static const u8 nss_delta[4] = { 0, 6, 8, 12 };
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
 	int n_chains = hweight8(mphy->antenna_mask);
 	int tx_power;
 	int i;
 
-	tx_power = hw->conf.power_level * 2 - nss_delta[n_chains - 1];
+	tx_power = hw->conf.power_level * 2 -
+		   mt76_tx_power_nss_delta(n_chains);
 	mphy->txpower_cur = tx_power;
 
 	for (i = 0; i < MT_SKU_1SS_DELTA; i++)
@@ -1612,7 +1612,8 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 		int delta = 0;
 
 		if (i < n_chains - 1)
-			delta = nss_delta[n_chains - 1] - nss_delta[i];
+			delta = mt76_tx_power_nss_delta(n_chains) -
+				mt76_tx_power_nss_delta(i + 1);
 		sku[MT_SKU_1SS_DELTA + i] = delta;
 	}
 }
-- 
2.24.0

