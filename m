Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5745A796
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKWQ1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 11:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhKWQ1y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 11:27:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4735160F5A;
        Tue, 23 Nov 2021 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637684686;
        bh=D6/GWU6y51q5xDOOg1hGwsiAzMFchVwjcAshTdT3uMY=;
        h=From:To:Cc:Subject:Date:From;
        b=qC4Hrzjicabn/TMmOOeZ9HVaUod5c83UjJdh65a0wpFdBLykKdsrXSplhsd7JAL0X
         RNflUBcnnhf9PEUHiJI6T5LUFhEL/TE05AacnMot7E/bm6HlISndfvqR+wcW8xceiz
         PVTJra5+RXRRJdbMdHQ5My+l3NK3RXfdzy/Q60VeFVx4/2u23ZQ/q2RTh9ilC2PkDX
         1OuHErVM1JGo5tSGsqHBsHnWdqPVDprhLdYdNhTpO0gx0mzon4y8OSunIVnyfEHiJa
         vgsywZhxrNPG8TIcDv3Xoz9alhkL7Jsiy3n0NYgsR43WLdNmtz+0U4o1cl9gOtAGaL
         D/FmbXJ6MXdTw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: introduce SAR support
Date:   Tue, 23 Nov 2021 17:24:31 +0100
Message-Id: <ed704f40d9681041d330b1c55dcaf4b10f50c331.1637684612.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add SAR spec support to mt7915 driver to allow configuring SAR power
limitations on the frequency ranges from the userland.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 23 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  8 +++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 057ab27b7083..2179ea85d304 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -425,6 +425,28 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return err;
 }
 
+static int mt7915_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	int err = -EINVAL;
+
+	mutex_lock(&dev->mt76.mutex);
+	if (!cfg80211_chandef_valid(&phy->mt76->chandef))
+		goto out;
+
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		goto out;
+
+	err = mt7915_mcu_set_txpower_sku(phy);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
 static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
@@ -1331,6 +1353,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sw_scan_complete = mt76_sw_scan_complete,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
+	.set_sar_specs = mt7915_set_sar_specs,
 	.channel_switch_beacon = mt7915_channel_switch_beacon,
 	.get_stats = mt7915_get_stats,
 	.get_et_sset_count = mt7915_get_et_sset_count,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 7ed1c47dec63..d7a6df23fc42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3856,11 +3856,11 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 	struct mt76_power_limits limits_array;
 	s8 *la = (s8 *)&limits_array;
 	int i, idx, n_chains = hweight8(mphy->antenna_mask);
-	int tx_power;
-
-	tx_power = hw->conf.power_level * 2 -
-		   mt76_tx_power_nss_delta(n_chains);
+	int tx_power = hw->conf.power_level * 2;
 
+	tx_power = mt76_get_sar_power(mphy, mphy->chandef.chan,
+				      tx_power);
+	tx_power -= mt76_tx_power_nss_delta(n_chains);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &limits_array, tx_power);
 	mphy->txpower_cur = tx_power;
-- 
2.31.1

