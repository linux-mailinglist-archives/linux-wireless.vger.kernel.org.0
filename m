Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892821E837A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgE2QTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgE2QTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 12:19:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132AAC08C5C6
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uh2u2YWrRhetBGfGTo3HSLQbVc985tguHSIkK2PUxSo=; b=oOSIS5dmu6rEOYk3EpIPIU9Ja2
        jwhbI7jqZE0NZj3e9UqrfVHDPAvSI+/lB5d4WXRDpqQgVzy/adRBQ3hNm6U5pSGAO4Bi3xwzsTCB8
        FSk1kdM6TYgqDgqyoYVUAFjkaNrrGZhyLw6xY6H3hb4sJqGnArc4GB4Y7ZMFk3KNOs1U=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jehjH-0007eH-BH
        for linux-wireless@vger.kernel.org; Fri, 29 May 2020 18:19:31 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id C2A47891744A; Fri, 29 May 2020 18:19:29 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7615: implement support for using DT rate power limits
Date:   Fri, 29 May 2020 18:19:29 +0200
Message-Id: <20200529161929.24751-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200529161929.24751-1-nbd@nbd.name>
References: <20200529161929.24751-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Limits are used to update the channel max_power settings and also passed
to the firmware on channel changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 11 +++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 61 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e2d80518e5af..04a32123e7fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -234,6 +234,7 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 	int delta_idx, delta = mt76_tx_power_nss_delta(n_chains);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
+	struct mt76_power_limits limits;
 	u8 rate_val;
 
 	delta_idx = mt7615_eeprom_get_power_delta_index(dev, band);
@@ -262,7 +263,11 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 			target_power = max(target_power, eep[index]);
 		}
 
-		target_power = DIV_ROUND_UP(target_power + delta, 2);
+		target_power += delta;
+		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+							  &limits,
+							  target_power);
+		target_power = DIV_ROUND_UP(target_power, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
 					target_power);
 		chan->orig_mpwr = target_power;
@@ -280,8 +285,12 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	struct mt7615_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
+	mt7615_init_txpower(dev, &mphy->sband_2g.sband);
+	mt7615_init_txpower(dev, &mphy->sband_5g.sband);
+
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 6e869b8c5e26..0b1933111004 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2654,16 +2654,75 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 {
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
+	struct mt76_power_limits limits;
+	s8 *limits_array = (s8 *)&limits;
 	int n_chains = hweight8(mphy->antenna_mask);
 	int tx_power;
 	int i;
+	static const u8 sku_mapping[] = {
+#define SKU_FIELD(_type, _field) \
+		[MT_SKU_##_type] = offsetof(struct mt76_power_limits, _field)
+		SKU_FIELD(CCK_1_2, cck[0]),
+		SKU_FIELD(CCK_55_11, cck[2]),
+		SKU_FIELD(OFDM_6_9, ofdm[0]),
+		SKU_FIELD(OFDM_12_18, ofdm[2]),
+		SKU_FIELD(OFDM_24_36, ofdm[4]),
+		SKU_FIELD(OFDM_48, ofdm[6]),
+		SKU_FIELD(OFDM_54, ofdm[7]),
+		SKU_FIELD(HT20_0_8, mcs[0][0]),
+		SKU_FIELD(HT20_32, ofdm[0]),
+		SKU_FIELD(HT20_1_2_9_10, mcs[0][1]),
+		SKU_FIELD(HT20_3_4_11_12, mcs[0][3]),
+		SKU_FIELD(HT20_5_13, mcs[0][5]),
+		SKU_FIELD(HT20_6_14, mcs[0][6]),
+		SKU_FIELD(HT20_7_15, mcs[0][7]),
+		SKU_FIELD(HT40_0_8, mcs[1][0]),
+		SKU_FIELD(HT40_32, ofdm[0]),
+		SKU_FIELD(HT40_1_2_9_10, mcs[1][1]),
+		SKU_FIELD(HT40_3_4_11_12, mcs[1][3]),
+		SKU_FIELD(HT40_5_13, mcs[1][5]),
+		SKU_FIELD(HT40_6_14, mcs[1][6]),
+		SKU_FIELD(HT40_7_15, mcs[1][7]),
+		SKU_FIELD(VHT20_0, mcs[0][0]),
+		SKU_FIELD(VHT20_1_2, mcs[0][1]),
+		SKU_FIELD(VHT20_3_4, mcs[0][3]),
+		SKU_FIELD(VHT20_5_6, mcs[0][5]),
+		SKU_FIELD(VHT20_7, mcs[0][7]),
+		SKU_FIELD(VHT20_8, mcs[0][8]),
+		SKU_FIELD(VHT20_9, mcs[0][9]),
+		SKU_FIELD(VHT40_0, mcs[1][0]),
+		SKU_FIELD(VHT40_1_2, mcs[1][1]),
+		SKU_FIELD(VHT40_3_4, mcs[1][3]),
+		SKU_FIELD(VHT40_5_6, mcs[1][5]),
+		SKU_FIELD(VHT40_7, mcs[1][7]),
+		SKU_FIELD(VHT40_8, mcs[1][8]),
+		SKU_FIELD(VHT40_9, mcs[1][9]),
+		SKU_FIELD(VHT80_0, mcs[2][0]),
+		SKU_FIELD(VHT80_1_2, mcs[2][1]),
+		SKU_FIELD(VHT80_3_4, mcs[2][3]),
+		SKU_FIELD(VHT80_5_6, mcs[2][5]),
+		SKU_FIELD(VHT80_7, mcs[2][7]),
+		SKU_FIELD(VHT80_8, mcs[2][8]),
+		SKU_FIELD(VHT80_9, mcs[2][9]),
+		SKU_FIELD(VHT160_0, mcs[3][0]),
+		SKU_FIELD(VHT160_1_2, mcs[3][1]),
+		SKU_FIELD(VHT160_3_4, mcs[3][3]),
+		SKU_FIELD(VHT160_5_6, mcs[3][5]),
+		SKU_FIELD(VHT160_7, mcs[3][7]),
+		SKU_FIELD(VHT160_8, mcs[3][8]),
+		SKU_FIELD(VHT160_9, mcs[3][9]),
+#undef SKU_FIELD
+	};
 
 	tx_power = hw->conf.power_level * 2 -
 		   mt76_tx_power_nss_delta(n_chains);
+
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &limits, tx_power);
 	mphy->txpower_cur = tx_power;
 
 	for (i = 0; i < MT_SKU_1SS_DELTA; i++)
-		sku[i] = tx_power;
+		sku[i] = limits_array[sku_mapping[i]];
 
 	for (i = 0; i < 4; i++) {
 		int delta = 0;
-- 
2.24.0

