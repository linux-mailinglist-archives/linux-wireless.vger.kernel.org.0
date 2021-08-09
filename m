Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97DA3E4AD7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhHIR31 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 13:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhHIR3Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 13:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C938660E76;
        Mon,  9 Aug 2021 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628530145;
        bh=F5qB4vBPdVM5lYyWLWRw0Hb+0oPRAx2k5+vWuoPabu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoAEpDFHqmoS/Pm0dJ7pjFvu7qWeOFy6yyWNflzxK/LUfU5SM3qEVsPtsVYls8qPh
         sTyPG1wW1M8mpkCHMMBKk+MGOnLAYFrlTrLwm1rHo1a6LWkHlk1yc+oPwEKul/nqjj
         RjACkIo2rFzo8DSmtS5ATLaRBBKv9Mx9Kbt7cVNjs7yptHGopfB6O1zvmkvGTYfk4U
         LLP/IIdk7ti0dBQmN0xuXuxWXQYvBHemMB+Q45kgMh4XOGTxD70b9uExT8yLKutvix
         U00/bcfJaykJ9l7PK6LxwWhxFM4FGu+SIDFD/hCFdQogY7jDVuf1CcyyGsV3OD4imt
         RPkTE/MAet55w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v2 mac80211-next 3/7] mt76: mt7915: introduce __mt7915_get_tsf routine
Date:   Mon,  9 Aug 2021 19:28:29 +0200
Message-Id: <15b2e93b013ee9b8dda6fa44f1971c1cfa9dc384.1628529781.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628529781.git.lorenzo@kernel.org>
References: <cover.1628529781.git.lorenzo@kernel.org>
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
index 48b5e2051bad..fa4fd04affd8 100644
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
index a6b5b300d415..068ef0f881b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -271,7 +271,7 @@ extern const struct ieee80211_ops mt7915_ops;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
 
 u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
-
+u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
-- 
2.31.1

