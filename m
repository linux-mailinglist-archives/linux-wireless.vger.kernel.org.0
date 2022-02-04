Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5394A9F13
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 19:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiBDSd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 13:33:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51016 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbiBDSd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 13:33:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90CC461BB3
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 18:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB3C004E1;
        Fri,  4 Feb 2022 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643999636;
        bh=HmP3WSjGDWqlAwznGSKh8/I0PYGUPdMSwJ+AKyq1uE0=;
        h=From:To:Cc:Subject:Date:From;
        b=SMGAwqmlIaD9w72WljA9jBHiEC21vclDT0fckbbvGq5870wvma/SIAiPb4yhtCn2M
         RT325NVLlDtg1ZJppOTy9yWOsz7BXs04IyCYDdaAucLURRdzmhP0Od9Kg5Svyztwnw
         23NFb8wChWeLKqar9X4F6X4P+c2Gl5N6mObrIoZgdC1mRQVniR/hhrAHOMo6Wfeeli
         unmRX7SrVooKMubytlfZsgm1TZqR/fsfbE9vsNOG6Zc1KhVouwzslVJa7+EHSLOEfz
         j6g4UOIWP69s0mQ0Ehy9O5PM5n2YmiFblf+xLrVjkfAtSq47hRdcj5e4jlMe+SAGVC
         TBvFYDvSPSvgA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: introduce SAR support
Date:   Fri,  4 Feb 2022 19:33:39 +0100
Message-Id: <56f00506762466bdbee1229a3a629c55788d5fc7.1643999485.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add SAR spec support to mt7615 driver to allow configuring SAR power
limitations on the frequency ranges from the userland.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  7 +++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7dcf1fb97eca..d79cbdbd5a05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -431,6 +431,29 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return err;
 }
 
+static int mt7615_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	int err;
+
+	if (!cfg80211_chandef_valid(&phy->mt76->chandef))
+		return -EINVAL;
+
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		return err;
+
+	if (mt7615_firmware_offload(phy->dev))
+		return mt76_connac_mcu_set_rate_txpower(phy->mt76);
+
+	ieee80211_stop_queues(hw);
+	err = mt7615_set_channel(phy);
+	ieee80211_wake_queues(hw);
+
+	return err;
+}
+
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -1333,6 +1356,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.set_wakeup = mt7615_set_wakeup,
 	.set_rekey_data = mt7615_set_rekey_data,
 #endif /* CONFIG_PM */
+	.set_sar_specs = mt7615_set_sar_specs,
 };
 EXPORT_SYMBOL_GPL(mt7615_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f992e1285eaa..120760ea1c89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2020,7 +2020,7 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 	struct mt76_power_limits limits;
 	s8 *limits_array = (s8 *)&limits;
 	int n_chains = hweight8(mphy->antenna_mask);
-	int tx_power;
+	int tx_power = hw->conf.power_level * 2;
 	int i;
 	static const u8 sku_mapping[] = {
 #define SKU_FIELD(_type, _field) \
@@ -2077,9 +2077,8 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 #undef SKU_FIELD
 	};
 
-	tx_power = hw->conf.power_level * 2 -
-		   mt76_tx_power_nss_delta(n_chains);
-
+	tx_power = mt76_get_sar_power(mphy, mphy->chandef.chan, tx_power);
+	tx_power -= mt76_tx_power_nss_delta(n_chains);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &limits, tx_power);
 	mphy->txpower_cur = tx_power;
-- 
2.34.1

