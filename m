Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278FD1AC640
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393939AbgDPOgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 10:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbgDPOgi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 10:36:38 -0400
Received: from lore-desk.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5816821D7E;
        Thu, 16 Apr 2020 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587047797;
        bh=IVAR9KENcfw+2n2vlgRPtdYKEGazDW+IkLXh6McWs5g=;
        h=From:To:Cc:Subject:Date:From;
        b=Nz6BV1Q3NwwpOjP+knQfujnn8qquMgzGVIbc2j2zjY4SCYm+iE8QxqycIU3Gnm/XG
         kU/leYiqQNm63SGxLl/ojw3i8MVnu/CDtKtJ+Xwm22ylEzUhNl8aTiVNA/QsEQyOxz
         NsOzBR2jsgf/EMQjY+EloTwAl72pMDgFX9XDOkKE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: enable scs for mt7663 driver
Date:   Thu, 16 Apr 2020 16:36:19 +0200
Message-Id: <7e7d76ac34d6405e67d851db03afb7933c569802.1587047739.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing register definitions in order to enable sensitivity tuning
for mt7663 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 77 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  8 ++
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 571554ffe8b6..b6e92bb3b128 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1417,17 +1417,40 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 EXPORT_SYMBOL_GPL(mt7615_queue_rx_skb);
 
 static void
-mt7615_mac_set_default_sensitivity(struct mt7615_phy *phy)
+mt7615_mac_set_sensitivity(struct mt7615_phy *phy, int val, bool ofdm)
 {
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 
-	mt76_rmw(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
-		 MT_WF_PHY_PD_OFDM_MASK(ext_phy),
-		 MT_WF_PHY_PD_OFDM(ext_phy, 0x13c));
-	mt76_rmw(dev, MT_WF_PHY_RXTD_CCK_PD(ext_phy),
-		 MT_WF_PHY_PD_CCK_MASK(ext_phy),
-		 MT_WF_PHY_PD_CCK(ext_phy, 0x92));
+	if (is_mt7663(&dev->mt76)) {
+		if (ofdm)
+			mt76_rmw(dev, MT7663_WF_PHY_MIN_PRI_PWR(ext_phy),
+				 MT_WF_PHY_PD_OFDM_MASK(0),
+				 MT_WF_PHY_PD_OFDM(0, val));
+		else
+			mt76_rmw(dev, MT7663_WF_PHY_RXTD_CCK_PD(ext_phy),
+				 MT_WF_PHY_PD_CCK_MASK(ext_phy),
+				 MT_WF_PHY_PD_CCK(ext_phy, val));
+		return;
+	}
+
+	if (ofdm)
+		mt76_rmw(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
+			 MT_WF_PHY_PD_OFDM_MASK(ext_phy),
+			 MT_WF_PHY_PD_OFDM(ext_phy, val));
+	else
+		mt76_rmw(dev, MT_WF_PHY_RXTD_CCK_PD(ext_phy),
+			 MT_WF_PHY_PD_CCK_MASK(ext_phy),
+			 MT_WF_PHY_PD_CCK(ext_phy, val));
+}
+
+static void
+mt7615_mac_set_default_sensitivity(struct mt7615_phy *phy)
+{
+	/* ofdm */
+	mt7615_mac_set_sensitivity(phy, 0x13c, true);
+	/* cck */
+	mt7615_mac_set_sensitivity(phy, 0x92, false);
 
 	phy->ofdm_sensitivity = -98;
 	phy->cck_sensitivity = -110;
@@ -1438,25 +1461,29 @@ void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable)
 {
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
+	u32 reg, mask;
 
 	mutex_lock(&dev->mt76.mutex);
 
 	if (phy->scs_en == enable)
 		goto out;
 
-	if (is_mt7663(&dev->mt76))
-		goto out;
+	if (is_mt7663(&dev->mt76)) {
+		reg = MT7663_WF_PHY_MIN_PRI_PWR(ext_phy);
+		mask = MT_WF_PHY_PD_BLK(0);
+	} else {
+		reg = MT_WF_PHY_MIN_PRI_PWR(ext_phy);
+		mask = MT_WF_PHY_PD_BLK(ext_phy);
+	}
 
 	if (enable) {
-		mt76_set(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
-			 MT_WF_PHY_PD_BLK(ext_phy));
+		mt76_set(dev, reg, mask);
 		if (is_mt7622(&dev->mt76)) {
 			mt76_set(dev, MT_MIB_M0_MISC_CR(0), 0x7 << 8);
 			mt76_set(dev, MT_MIB_M0_MISC_CR(0), 0x7);
 		}
 	} else {
-		mt76_clear(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
-			   MT_WF_PHY_PD_BLK(ext_phy));
+		mt76_clear(dev, reg, mask);
 	}
 
 	mt7615_mac_set_default_sensitivity(phy);
@@ -1547,19 +1574,9 @@ mt7615_mac_adjust_sensitivity(struct mt7615_phy *phy,
 	}
 
 	if (update) {
-		u16 val;
+		u16 val = ofdm ? *sensitivity * 2 + 512 : *sensitivity + 256;
 
-		if (ofdm) {
-			val = *sensitivity * 2 + 512;
-			mt76_rmw(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
-				 MT_WF_PHY_PD_OFDM_MASK(ext_phy),
-				 MT_WF_PHY_PD_OFDM(ext_phy, val));
-		} else {
-			val = *sensitivity + 256;
-			mt76_rmw(dev, MT_WF_PHY_RXTD_CCK_PD(ext_phy),
-				 MT_WF_PHY_PD_CCK_MASK(ext_phy),
-				 MT_WF_PHY_PD_CCK(ext_phy, val));
-		}
+		mt7615_mac_set_sensitivity(phy, val, ofdm);
 		phy->last_cca_adj = jiffies;
 	}
 }
@@ -1576,11 +1593,17 @@ mt7615_mac_scs_check(struct mt7615_phy *phy)
 	if (!phy->scs_en)
 		return;
 
-	val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS0(ext_phy));
+	if (is_mt7663(&dev->mt76))
+		val = mt76_rr(dev, MT7663_WF_PHY_R0_PHYCTRL_STS0(ext_phy));
+	else
+		val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS0(ext_phy));
 	pd_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_CCK, val);
 	pd_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_OFDM, val);
 
-	val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS5(ext_phy));
+	if (is_mt7663(&dev->mt76))
+		val = mt76_rr(dev, MT7663_WF_PHY_R0_PHYCTRL_STS5(ext_phy));
+	else
+		val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS5(ext_phy));
 	mdrdy_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_CCK, val);
 	mdrdy_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_OFDM, val);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 370e03432e81..ab3c6b77df07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -160,16 +160,22 @@ enum mt7615_reg_base {
 #define MT_WF_PHYCTRL_STAT_PD_OFDM	GENMASK(31, 16)
 #define MT_WF_PHYCTRL_STAT_PD_CCK	GENMASK(15, 0)
 
+#define MT7663_WF_PHY_R0_PHYCTRL_STS0(_phy)	MT_WF_PHY(0x0210 + ((_phy) << 12))
+
 #define MT_WF_PHY_R0_PHYCTRL_STS5(_phy)	MT_WF_PHY(0x0220 + ((_phy) << 9))
 #define MT_WF_PHYCTRL_STAT_MDRDY_OFDM	GENMASK(31, 16)
 #define MT_WF_PHYCTRL_STAT_MDRDY_CCK	GENMASK(15, 0)
 
+#define MT7663_WF_PHY_R0_PHYCTRL_STS5(_phy)	MT_WF_PHY(0x0224 + ((_phy) << 12))
+
 #define MT_WF_PHY_MIN_PRI_PWR(_phy)	MT_WF_PHY((_phy) ? 0x084 : 0x229c)
 #define MT_WF_PHY_PD_OFDM_MASK(_phy)	((_phy) ? GENMASK(24, 16) : \
 					 GENMASK(28, 20))
 #define MT_WF_PHY_PD_OFDM(_phy, v)	((v) << ((_phy) ? 16 : 20))
 #define MT_WF_PHY_PD_BLK(_phy)		((_phy) ? BIT(25) : BIT(19))
 
+#define MT7663_WF_PHY_MIN_PRI_PWR(_phy)	MT_WF_PHY((_phy) ? 0x2aec : 0x22f0)
+
 #define MT_WF_PHY_RXTD_BASE		MT_WF_PHY(0x2200)
 #define MT_WF_PHY_RXTD(_n)		(MT_WF_PHY_RXTD_BASE + ((_n) << 2))
 
@@ -180,6 +186,8 @@ enum mt7615_reg_base {
 					 GENMASK(8, 1)
 #define MT_WF_PHY_PD_CCK(_phy, v)	((v) << ((_phy) ? 24 : 1))
 
+#define MT7663_WF_PHY_RXTD_CCK_PD(_phy)	MT_WF_PHY((_phy) ? 0x2350 : 0x234c)
+
 #define MT_WF_PHY_RXTD2_BASE		MT_WF_PHY(0x2a00)
 #define MT_WF_PHY_RXTD2(_n)		(MT_WF_PHY_RXTD2_BASE + ((_n) << 2))
 
-- 
2.25.2

