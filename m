Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC145833C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 13:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhKUMPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 07:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhKUMPr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 07:15:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C2E460E90;
        Sun, 21 Nov 2021 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637496762;
        bh=IPWh+Kk/K77c0XnP+v/a4VrwZ8P/XhJJkJ66rXrbijc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mI0RqWc0Tg5qpe7alSRZOjiE3/1mphGt5NlJWGJhcpwL3xDu0Gbr25l34XPvD0DKm
         UzxRE5eTf42n2Owq4hG+767UNcsFD3fm/+GgxwY6Pp/tQBPRuD+VJvnHWKHq9K7X9x
         g0yAtU45QVr4udkVgj2dbyFMjhyXagmuDcnVrYoxbLG5oUihmEmqUA20Wyxepcow46
         qy88k4jAbTiPvYclcBmJMLsTEhXX28kuvTvJ24DX6mO34fKoIHcLOp4LrhDLTTb8Dg
         MeCPr0vOX77jzmVT+mHy/46J/+R0oC3TOpiwtIUD3KjLUBGdxXzs8MIfQNF6GwauMk
         rNGpizS3hz76Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 1/2] mt76: move sar utilities to mt76-core module
Date:   Sun, 21 Nov 2021 13:12:24 +0100
Message-Id: <8911f8a49dc0e166cdff3b55f61ce02c7fdd9ee6.1637496644.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637496643.git.lorenzo@kernel.org>
References: <cover.1637496643.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_get_sar_power and mt76_init_sar_power in the common code.
This is a preliminary patch to add sar support to mt76x02 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 53 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 27 +---------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 26 ++-------
 4 files changed, 63 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index b0869ff86c49..c4d3b936b91e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1348,6 +1348,59 @@ int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_get_txpower);
 
+int mt76_init_sar_power(struct ieee80211_hw *hw,
+			const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *phy = hw->priv;
+	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
+	int i;
+
+	if (sar->type != NL80211_SAR_TYPE_POWER || !sar->num_sub_specs)
+		return -EINVAL;
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		u32 index = sar->sub_specs[i].freq_range_index;
+		/* SAR specifies power limitaton in 0.25dbm */
+		s32 power = sar->sub_specs[i].power >> 1;
+
+		if (power > 127 || power < -127)
+			power = 127;
+
+		phy->frp[index].range = &capa->freq_ranges[index];
+		phy->frp[index].power = power;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_init_sar_power);
+
+int mt76_get_sar_power(struct mt76_phy *phy,
+		       struct ieee80211_channel *chan,
+		       int power)
+{
+	const struct cfg80211_sar_capa *capa = phy->hw->wiphy->sar_capa;
+	int freq, i;
+
+	if (!capa || !phy->frp)
+		return power;
+
+	if (power > 127 || power < -127)
+		power = 127;
+
+	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
+	for (i = 0 ; i < capa->num_freq_ranges; i++) {
+		if (phy->frp[i].range &&
+		    freq >= phy->frp[i].range->start_freq &&
+		    freq < phy->frp[i].range->end_freq) {
+			power = min_t(int, phy->frp[i].power, power);
+			break;
+		}
+	}
+
+	return power;
+}
+EXPORT_SYMBOL_GPL(mt76_get_sar_power);
+
 static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e2da720a91b6..e3e159c65434 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1157,6 +1157,11 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm);
+int mt76_init_sar_power(struct ieee80211_hw *hw,
+			const struct cfg80211_sar_specs *sar);
+int mt76_get_sar_power(struct mt76_phy *phy,
+		       struct ieee80211_channel *chan,
+		       int power);
 
 void mt76_csa_check(struct mt76_dev *dev);
 void mt76_csa_finish(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index eba827f99790..92b45e98dbc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1881,30 +1881,6 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 	}
 }
 
-static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
-				    struct ieee80211_channel *chan,
-				    s8 target_power)
-{
-	const struct cfg80211_sar_capa *capa = phy->hw->wiphy->sar_capa;
-	struct mt76_freq_range_power *frp = phy->frp;
-	int freq, i;
-
-	if (!capa || !frp)
-		return target_power;
-
-	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
-	for (i = 0 ; i < capa->num_freq_ranges; i++) {
-		if (frp[i].range &&
-		    freq >= frp[i].range->start_freq &&
-		    freq < frp[i].range->end_freq) {
-			target_power = min_t(s8, frp[i].power, target_power);
-			break;
-		}
-	}
-
-	return target_power;
-}
-
 static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
 				   struct ieee80211_channel *chan,
 				   s8 target_power)
@@ -2049,8 +2025,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 
 			reg_power = mt76_connac_get_ch_power(phy, &chan,
 							     tx_power);
-			sar_power = mt76_connac_get_sar_power(phy, &chan,
-							      reg_power);
+			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
 
 			mt76_get_rate_power_limits(phy, &chan, &limits,
 						   sar_power);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 14261f845c58..aaefff09345e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1338,35 +1338,17 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 				const struct cfg80211_sar_specs *sar)
 {
-	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt76_freq_range_power *data, *frp;
 	struct mt76_phy *mphy = hw->priv;
 	int err;
-	u32 i;
-
-	if (sar->type != NL80211_SAR_TYPE_POWER || !sar->num_sub_specs)
-		return -EINVAL;
 
 	mt7921_mutex_acquire(dev);
-
-	data = mphy->frp;
-
-	for (i = 0; i < sar->num_sub_specs; i++) {
-		u32 index = sar->sub_specs[i].freq_range_index;
-		/* SAR specifies power limitaton in 0.25dbm */
-		s32 power = sar->sub_specs[i].power >> 1;
-
-		if (power > 127 || power < -127)
-			power = 127;
-
-		frp = &data[index];
-		frp->range = &capa->freq_ranges[index];
-		frp->power = power;
-	}
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		goto out;
 
 	err = mt76_connac_mcu_set_rate_txpower(mphy);
-
+out:
 	mt7921_mutex_release(dev);
 
 	return err;
-- 
2.31.1

