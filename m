Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDA3F5011
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhHWSEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhHWSD7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AB336136F;
        Mon, 23 Aug 2021 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741795;
        bh=l01NMl8lF0PXRBsTJW59JJdfffDBGqJuz3LaisZWph0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm/vLEP4/Fly9XTjvN/f+nDDrK9KOyAJ5Tc6jQHCxAP3SYAhTyuD3DFEztMA6/KMj
         YATAmD4TUy9C0OfuagTCA8dbpknJAlOmiTzWhdTc6mdHyj+AjWldZE/MlKooN16IjT
         q7sTPLM727Ebo7+rT0xqh7zm2vRQ19twA+0pkhJuNFPMzPu53PE70zMaq3haFIMpun
         tjsk33nYFk+AaTUELo3BnFwuMegKXLp+pmFpoCWaen0C2/CbYTmyh0XAKOa/acrNhj
         8sL0WV1vtm1LD53h/E/Q1sosz4I2RfgFqy1ETOLf4npPV8pEGo/DJdmufw3DCyEYyl
         +qFUUUDvkJwHg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 3/7] mt76: mt7915: introduce __mt7915_get_tsf routine
Date:   Mon, 23 Aug 2021 20:02:40 +0200
Message-Id: <097059328c37bfa6d2103ac832438b25b8b90ad7.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce an unlocked verion of mt7915_get_tsf routine.
This is a preliminary patch to add TWT support to mt7915.

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 20 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b3ca2ce8eed2..795d36122398 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -789,10 +789,8 @@ mt7915_get_stats(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static u64
-mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif)
 {
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool band = phy != &dev->phy;
@@ -802,7 +800,7 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	} tsf;
 	u16 n;
 
-	mutex_lock(&dev->mt76.mutex);
+	lockdep_assert_held(&dev->mt76.mutex);
 
 	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
 	/* TSF software read */
@@ -811,9 +809,21 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
 
+	return tsf.t64;
+}
+
+static u64
+mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	u64 ret;
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = __mt7915_get_tsf(hw, mvif);
 	mutex_unlock(&dev->mt76.mutex);
 
-	return tsf.t64;
+	return ret;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index cc74dd2c2c72..c2909247cfd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -273,7 +273,7 @@ extern const struct ieee80211_ops mt7915_ops;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
 
 u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
-
+u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
-- 
2.31.1

