Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEDF479312
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbhLQRtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbhLQRtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:49:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF62C061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 09:49:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A56E62355
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B0C36AE8;
        Fri, 17 Dec 2021 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763349;
        bh=MtcIHjIqxAzb6pSWLF3S+9T0pVjTECMXR/8MT1Xo9RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaF7FQHhKS4mheeSAct0z8KifNpq0tahYSBgM1G8ddnnwtDo0O+1YSwe6c4o5JwQf
         QTXu3C4oSmMcmJfnXVwrgWzCzXuC3Z+cApd5H72Us68tNxcUxFGDuqNjfoeapIO72y
         pA+kq0tOPie8uk9fQNriNL1O4YLRy4ZrVB7UpF8RoC30BmyoEd3syJenbpOMUOl769
         mJhGYIFX+ehF7anvdkknLzKvZsJQb1ElLDKGr8Z9l2gpR68n4bgZSoDXfQM0PkFBuy
         6r+mSgiFlX9OwM6/QuScn2wXu4wV//pbU+a9eCApsXH5zmvVO08YFcdbXrydPV60Xc
         iI8n+qNkuVWrA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 5/7] mt76: connac: move mt76_connac_chan_bw in common code
Date:   Fri, 17 Dec 2021 18:48:49 +0100
Message-Id: <cfd2c3b0c6676e14498f8383288830b8dfcb8675.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639763123.git.lorenzo@kernel.org>
References: <cover.1639763123.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_chan_bw in mt76-connac code and remove
duplicated code from mt7921 and mt7915 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 19 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 23 ++-----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 21 +----------------
 3 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 45ee7b06fba3..09165aed8845 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -105,6 +105,25 @@ static inline bool is_mt7915(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7915;
 }
 
+static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
+{
+	static const u8 width_to_bw[] = {
+		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
+		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
+		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
+		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
+		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
+		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
+		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+	};
+
+	if (chandef->width >= ARRAY_SIZE(width_to_bw))
+		return 0;
+
+	return width_to_bw[chandef->width];
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b29f03409587..ab1a286ba94d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -85,25 +85,6 @@ struct mt7915_fw_region {
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
-static u8 mt7915_mcu_chan_bw(struct cfg80211_chan_def *chandef)
-{
-	static const u8 width_to_bw[] = {
-		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
-		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
-		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
-		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
-		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
-		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
-		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
-		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
-	};
-
-	if (chandef->width >= ARRAY_SIZE(width_to_bw))
-		return 0;
-
-	return width_to_bw[chandef->width];
-}
-
 static const struct ieee80211_sta_he_cap *
 mt7915_get_he_phy_cap(struct mt7915_phy *phy, struct ieee80211_vif *vif)
 {
@@ -722,7 +703,7 @@ mt7915_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	ch = (struct bss_info_rf_ch *)tlv;
 	ch->pri_ch = chandef->chan->hw_value;
 	ch->center_ch0 = ieee80211_frequency_to_channel(freq1);
-	ch->bw = mt7915_mcu_chan_bw(chandef);
+	ch->bw = mt76_connac_chan_bw(chandef);
 
 	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
 		int freq2 = chandef->center_freq2;
@@ -3371,7 +3352,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	} __packed req = {
 		.control_ch = chandef->chan->hw_value,
 		.center_ch = ieee80211_frequency_to_channel(freq1),
-		.bw = mt7915_mcu_chan_bw(chandef),
+		.bw = mt76_connac_chan_bw(chandef),
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
 		.band_idx = ext_phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 0858b026de2d..e14677f669c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -93,25 +93,6 @@ struct mt7921_fw_region {
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
-static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
-{
-	static const u8 width_to_bw[] = {
-		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
-		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
-		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
-		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
-		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
-		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
-		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
-		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
-	};
-
-	if (chandef->width >= ARRAY_SIZE(width_to_bw))
-		return 0;
-
-	return width_to_bw[chandef->width];
-}
-
 static int
 mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 {
@@ -1019,7 +1000,7 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
 	} __packed req = {
 		.control_ch = chandef->chan->hw_value,
 		.center_ch = ieee80211_frequency_to_channel(freq1),
-		.bw = mt7921_mcu_chan_bw(chandef),
+		.bw = mt76_connac_chan_bw(chandef),
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
 		.band_idx = phy != &dev->phy,
-- 
2.33.1

