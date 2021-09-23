Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4E416106
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbhIWOcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241662AbhIWOb4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27ABE6115A;
        Thu, 23 Sep 2021 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632407425;
        bh=UUvp0y++zRuSucojfnFpvyPXoww/yUheTE3sYsz+M+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9MMZnZJzSnpxs8X3eR5L4jqetRtVDQQoZ9NJoUcI192yqxGyn+rf6usFuo8JHY6g
         L4W3PbdNVSptbmOm5XNblsYmOtGNydtzJAxaT4MqsD32gke3qB+Vv8e8mxzAcR/gdy
         dvp2iqm4eMStrAvhe8ht7noO5nG+LQJKumazscedq7Tddp2NIjJVsebUMJq1hJ4Z9Z
         rwa/PcgLIBInDzUCy5b/Quk2STTlBznabXd4OUOMpUgySMVPJDlHEj1tdou2taKd4o
         2J88JLAypb3WM5hZ34kPX/oizyZ/3bX0svR9cy8ZKzr/at3LDQIp1td1YfPAPBMJs4
         hbY5fgBcqwduw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v5 1/5] mt76: mt7915: introduce __mt7915_get_tsf routine
Date:   Thu, 23 Sep 2021 16:29:30 +0200
Message-Id: <e7b7ebed835f16957790021187ea2c249a584452.1632406731.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632406731.git.lorenzo@kernel.org>
References: <cover.1632406731.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce an unlocked verion of mt7915_get_tsf routine.
This is a preliminary patch to add TWT support to mt7915.

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 20 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0aea6272fd14..e2d876c96616 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -792,10 +792,8 @@ mt7915_get_stats(struct ieee80211_hw *hw,
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
@@ -805,7 +803,7 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	} tsf;
 	u16 n;
 
-	mutex_lock(&dev->mt76.mutex);
+	lockdep_assert_held(&dev->mt76.mutex);
 
 	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
 	/* TSF software read */
@@ -814,9 +812,21 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
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
index ab8fc27646e0..5367b92de864 100644
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

