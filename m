Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F552B0264
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgKLJ5k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 04:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgKLJ50 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:26 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3729B22228;
        Thu, 12 Nov 2020 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175045;
        bh=LS443XO9/wWgPBxK424aAHSl4tSvljlYd7NgUnMSGeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2q9X49bd6Vw5RhOTcoDFrKoQKnHvBlDPkcR95ElcxorFP6vvoQp58aeW9jmBgOFL
         h8zabn6pqcZrVh11FMfADPNH1LANZc5OT1bR8fzCUaeYbmuw+UTxBDTEDRIqqF+Ljq
         ebo+QOxEdNJcDyk55vO6ml6uaKtdbFzjlchbsFzg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH 3/6] mt76: move band allocation in mt76_register_phy
Date:   Thu, 12 Nov 2020 10:56:58 +0100
Message-Id: <8c2d2d880479c0688cca5724e8652c90a294982a.1605173301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605173301.git.lorenzo@kernel.org>
References: <cover.1605173301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce dbdc support to mt7915 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 56 ++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
 4 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 043f1198ffad..3f4d4b86efd3 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -332,65 +332,57 @@ mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 	       const struct ieee80211_ops *ops)
 {
 	struct ieee80211_hw *hw;
+	unsigned int phy_size;
 	struct mt76_phy *phy;
-	unsigned int phy_size, chan_size;
-	unsigned int size_2g, size_5g;
-	void *priv;
 
 	phy_size = ALIGN(sizeof(*phy), 8);
-	chan_size = sizeof(dev->phy.sband_2g.chan[0]);
-	size_2g = ALIGN(ARRAY_SIZE(mt76_channels_2ghz) * chan_size, 8);
-	size_5g = ALIGN(ARRAY_SIZE(mt76_channels_5ghz) * chan_size, 8);
-
-	size += phy_size + size_2g + size_5g;
-	hw = ieee80211_alloc_hw(size, ops);
+	hw = ieee80211_alloc_hw(size + phy_size, ops);
 	if (!hw)
 		return NULL;
 
 	phy = hw->priv;
 	phy->dev = dev;
 	phy->hw = hw;
+	phy->priv = hw->priv + phy_size;
 
-	mt76_phy_init(dev, hw);
-
-	priv = hw->priv + phy_size;
+	return phy;
+}
+EXPORT_SYMBOL_GPL(mt76_alloc_phy);
 
-	phy->sband_2g = dev->phy.sband_2g;
-	phy->sband_2g.chan = priv;
-	priv += size_2g;
+int mt76_register_phy(struct mt76_phy *phy, bool vht,
+		      struct ieee80211_rate *rates, int n_rates)
+{
+	int ret;
 
-	phy->sband_5g = dev->phy.sband_5g;
-	phy->sband_5g.chan = priv;
-	priv += size_5g;
+	mt76_phy_init(phy->dev, phy->hw);
 
-	phy->priv = priv;
+	if (phy->cap.has_2ghz) {
+		ret = mt76_init_sband_2g(phy, rates, n_rates);
+		if (ret)
+			return ret;
+	}
 
-	hw->wiphy->bands[NL80211_BAND_2GHZ] = &phy->sband_2g.sband;
-	hw->wiphy->bands[NL80211_BAND_5GHZ] = &phy->sband_5g.sband;
+	if (phy->cap.has_5ghz) {
+		ret = mt76_init_sband_5g(phy, rates + 4, n_rates - 4, vht);
+		if (ret)
+			return ret;
+	}
 
+	wiphy_read_of_freq_limits(phy->hw->wiphy);
 	mt76_check_sband(phy, &phy->sband_2g, NL80211_BAND_2GHZ);
 	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
 
-	return phy;
-}
-EXPORT_SYMBOL_GPL(mt76_alloc_phy);
-
-int
-mt76_register_phy(struct mt76_phy *phy)
-{
-	int ret;
-
 	ret = ieee80211_register_hw(phy->hw);
 	if (ret)
 		return ret;
 
 	phy->dev->phy2 = phy;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_register_phy);
 
-void
-mt76_unregister_phy(struct mt76_phy *phy)
+void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3239a99a94d9..7204106cfe68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -775,7 +775,8 @@ void mt76_unregister_phy(struct mt76_phy *phy);
 
 struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 				const struct ieee80211_ops *ops);
-int mt76_register_phy(struct mt76_phy *phy);
+int mt76_register_phy(struct mt76_phy *phy, bool vht,
+		      struct ieee80211_rate *rates, int n_rates);
 
 struct dentry *mt76_register_debugfs(struct mt76_dev *dev);
 int mt76_queues_read(struct seq_file *s, void *data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 4ba52848cc61..4f2ef4982001 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -426,14 +426,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->hw->wiphy->perm_addr[0] ^= BIT(7);
 
 	/* second phy can only handle 5 GHz */
-	mphy->sband_2g.sband.n_channels = 0;
-	mphy->hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+	mphy->cap.has_5ghz = true;
 
 	/* mt7615 second phy shares the same hw queues with the primary one */
 	for (i = 0; i <= MT_TXQ_PSD ; i++)
 		mphy->q_tx[i] = dev->mphy.q_tx[i];
 
-	ret = mt76_register_phy(mphy);
+	ret = mt76_register_phy(mphy, true, mt7615_rates,
+				ARRAY_SIZE(mt7615_rates));
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 53eec43135bb..10d263f6ce3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -620,7 +620,8 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mphy->hw->wiphy->perm_addr[0] |= 2;
 	mphy->hw->wiphy->perm_addr[0] ^= BIT(7);
 
-	ret = mt76_register_phy(mphy);
+	ret = mt76_register_phy(mphy, true, mt7915_rates,
+				ARRAY_SIZE(mt7915_rates));
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
 
-- 
2.26.2

