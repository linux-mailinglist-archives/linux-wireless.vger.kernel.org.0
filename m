Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208CB19C1A8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbgDBNHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:40 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440EA20678;
        Thu,  2 Apr 2020 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832859;
        bh=UTW0fIL3PmD5qdCsaKP4Xi6QcmBAT452bcTt2j/RXq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqW8h7t9wAE+pbWHaDta1jHu85pTUwsGdU869doer/T1EqAr43aKCWf0fs20V2qfS
         LHTQm8RWd/wT//4v+EuDN6nZvRGuml5Y/hgHwuGynsFoV+nDolO72q828ooW9ItSnn
         5ojxKTGEvlz/Ys+6PyWv8Uicu2jgfmZc8RXBjy8M=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 03/12] mt76: mt7615: make scs configurable per chain
Date:   Thu,  2 Apr 2020 15:06:33 +0200
Message-Id: <04f19f7fcb125423d1090098c6b8034470b4b87e.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make scs configurable per chain since most of the chipsets do not
support dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  8 +++--
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 29 +++++++------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index b4d0795154e3..18f58706822b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -20,11 +20,15 @@ static int
 mt7615_scs_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
+	struct mt7615_phy *ext_phy;
 
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	mt7615_mac_set_scs(dev, val);
+	mt7615_mac_set_scs(&dev->phy, val);
+	ext_phy = mt7615_ext_phy(dev);
+	if (ext_phy)
+		mt7615_mac_set_scs(ext_phy, val);
 
 	return 0;
 }
@@ -34,7 +38,7 @@ mt7615_scs_get(void *data, u64 *val)
 {
 	struct mt7615_dev *dev = data;
 
-	*val = dev->scs_en;
+	*val = dev->phy.scs_en;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 03b1e56534d6..8b7d8118d9ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -90,7 +90,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_TMAC_CTCR0_INS_DDLMT_EN);
 
 	mt7615_mcu_set_rts_thresh(&dev->phy, 0x92b);
-	mt7615_mac_set_scs(dev, true);
+	mt7615_mac_set_scs(&dev->phy, true);
 
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
 		 MT_AGG_SCR_NLNAV_MID_PTEC_DIS);
@@ -411,6 +411,8 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7615_init_wiphy(mphy->hw);
 
+	mt7615_mac_set_scs(phy, true);
+
 	/*
 	 * Make the secondary PHY MAC address local without overlapping with
 	 * the usual MAC address allocation scheme on multiple virtual interfaces
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5961650e7245..ec6ef6c3478e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1515,40 +1515,33 @@ mt7615_mac_set_default_sensitivity(struct mt7615_phy *phy)
 	phy->last_cca_adj = jiffies;
 }
 
-void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
+void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable)
 {
-	struct mt7615_phy *ext_phy;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (dev->scs_en == enable)
+	if (phy->scs_en == enable)
 		goto out;
 
 	if (is_mt7663(&dev->mt76))
 		goto out;
 
 	if (enable) {
-		mt76_set(dev, MT_WF_PHY_MIN_PRI_PWR(0),
-			 MT_WF_PHY_PD_BLK(0));
-		mt76_set(dev, MT_WF_PHY_MIN_PRI_PWR(1),
-			 MT_WF_PHY_PD_BLK(1));
+		mt76_set(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
+			 MT_WF_PHY_PD_BLK(ext_phy));
 		if (is_mt7622(&dev->mt76)) {
 			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7 << 8);
 			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7);
 		}
 	} else {
-		mt76_clear(dev, MT_WF_PHY_MIN_PRI_PWR(0),
-			   MT_WF_PHY_PD_BLK(0));
-		mt76_clear(dev, MT_WF_PHY_MIN_PRI_PWR(1),
-			   MT_WF_PHY_PD_BLK(1));
+		mt76_clear(dev, MT_WF_PHY_MIN_PRI_PWR(ext_phy),
+			   MT_WF_PHY_PD_BLK(ext_phy));
 	}
 
-	mt7615_mac_set_default_sensitivity(&dev->phy);
-	ext_phy = mt7615_ext_phy(dev);
-	if (ext_phy)
-		mt7615_mac_set_default_sensitivity(ext_phy);
-
-	dev->scs_en = enable;
+	mt7615_mac_set_default_sensitivity(phy);
+	phy->scs_en = enable;
 
 out:
 	mutex_unlock(&dev->mt76.mutex);
@@ -1661,7 +1654,7 @@ mt7615_mac_scs_check(struct mt7615_phy *phy)
 	u32 mdrdy_cck, mdrdy_ofdm, pd_cck, pd_ofdm;
 	bool ext_phy = phy != &dev->phy;
 
-	if (!dev->scs_en)
+	if (!phy->scs_en)
 		return;
 
 	val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS0(ext_phy));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 676ca622c35a..dfc60d3ff836 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -128,6 +128,8 @@ struct mt7615_phy {
 
 	u16 noise;
 
+	bool scs_en;
+
 	unsigned long last_cca_adj;
 	int false_cca_ofdm, false_cca_cck;
 	s8 ofdm_sensitivity;
@@ -209,7 +211,6 @@ struct mt7615_dev {
 	u32 hw_pattern;
 
 	u8 mac_work_count;
-	bool scs_en;
 	bool fw_debug;
 
 	spinlock_t token_lock;
@@ -367,7 +368,7 @@ void mt7615_update_channel(struct mt76_dev *mdev);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
-void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
+void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable);
 void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy);
 void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
-- 
2.25.1

