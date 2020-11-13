Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E202B18CB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 11:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKMKLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 05:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgKMKLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 05:11:43 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B3B206FB;
        Fri, 13 Nov 2020 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605262301;
        bh=9/cwaAI/s1m/XkaIiCD522pxuRgdKC4Y3apPkHtNswQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enIwwgjMiObSwUtqE2y4ifWqOkyzLn09hSnZmtLfLr+F14yr5R1/RFwL8zydqQwh/
         3VThd90YpIJPLxNvrxx6M1KU60TPUeqXB/jk2gGFVkhYaG4zQu49Q8iB/W69jdkcc+
         y3yUUjIm4oUGjvTTnuy8SOXtijzJAFjkR6UpMZL4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH v2 1/3] mt76: move hw mac_addr in mt76_phy
Date:   Fri, 13 Nov 2020 11:11:30 +0100
Message-Id: <6f41e52ef38d4943dd37cef209e43f1423b3d478.1605261982.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605261982.git.lorenzo@kernel.org>
References: <cover.1605261982.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to properly support mt7915 dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c     | 12 +++++++-----
 drivers/net/wireless/mediatek/mt76/mac80211.c   | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h       |  5 +++--
 .../net/wireless/mediatek/mt76/mt7603/eeprom.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/init.c    |  7 +++++--
 .../net/wireless/mediatek/mt76/mt76x0/eeprom.c  |  6 +++---
 .../net/wireless/mediatek/mt76/mt76x02_mac.c    | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt76x02_util.c   |  8 ++++----
 .../net/wireless/mediatek/mt76/mt76x2/eeprom.c  |  6 +++---
 .../wireless/mediatek/mt76/mt76x2/pci_init.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/testmode.c   | 17 +++++++++--------
 13 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 3044e0069991..90278aeb6721 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -88,8 +88,10 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 }
 
 void
-mt76_eeprom_override(struct mt76_dev *dev)
+mt76_eeprom_override(struct mt76_phy *phy)
 {
+	struct mt76_dev *dev = phy->dev;
+
 #ifdef CONFIG_OF
 	struct device_node *np = dev->dev->of_node;
 	const u8 *mac = NULL;
@@ -97,14 +99,14 @@ mt76_eeprom_override(struct mt76_dev *dev)
 	if (np)
 		mac = of_get_mac_address(np);
 	if (!IS_ERR_OR_NULL(mac))
-		ether_addr_copy(dev->macaddr, mac);
+		ether_addr_copy(phy->macaddr, mac);
 #endif
 
-	if (!is_valid_ether_addr(dev->macaddr)) {
-		eth_random_addr(dev->macaddr);
+	if (!is_valid_ether_addr(phy->macaddr)) {
+		eth_random_addr(phy->macaddr);
 		dev_info(dev->dev,
 			 "Invalid MAC address, using random address %pM\n",
-			 dev->macaddr);
+			 phy->macaddr);
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_eeprom_override);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3f4d4b86efd3..a840396f2c74 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -273,12 +273,13 @@ mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 }
 
 static void
-mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
+mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
 	SET_IEEE80211_DEV(hw, dev->dev);
-	SET_IEEE80211_PERM_ADDR(hw, dev->macaddr);
+	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
 
 	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
@@ -354,7 +355,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 {
 	int ret;
 
-	mt76_phy_init(phy->dev, phy->hw);
+	mt76_phy_init(phy, phy->hw);
 
 	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(phy, rates, n_rates);
@@ -450,7 +451,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
-	mt76_phy_init(dev, hw);
+	mt76_phy_init(phy, hw);
 
 	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(phy, rates, n_rates);
@@ -830,7 +831,7 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
 		return;
 
 	if (!wcid || !wcid->sta) {
-		if (!ether_addr_equal(hdr->addr1, dev->macaddr))
+		if (!ether_addr_equal(hdr->addr1, dev->phy.macaddr))
 			return;
 
 		wcid = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7204106cfe68..ed988d27f736 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -573,6 +573,8 @@ struct mt76_phy {
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 
+	u8 macaddr[ETH_ALEN];
+
 	u32 vif_mask;
 
 	int txpower_cur;
@@ -628,7 +630,6 @@ struct mt76_dev {
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
 
-	u8 macaddr[ETH_ALEN];
 	u32 rev;
 
 	u32 aggr_stats[32];
@@ -784,7 +785,7 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len);
 
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
-void mt76_eeprom_override(struct mt76_dev *dev);
+void mt76_eeprom_override(struct mt76_phy *phy);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 2cd97228e280..d951cb81df83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -172,7 +172,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 
 	eeprom = (u8 *)dev->mt76.eeprom.data;
 	dev->mphy.cap.has_2ghz = true;
-	memcpy(dev->mt76.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
+	memcpy(dev->mphy.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
 
 	/* Check for 1SS devices */
 	dev->mphy.antenna_mask = 3;
@@ -181,7 +181,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	    is_mt7688(dev))
 		dev->mphy.antenna_mask = 1;
 
-	mt76_eeprom_override(&dev->mt76);
+	mt76_eeprom_override(&dev->mphy);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 67f7a1ed9258..c4c7357d226b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -342,10 +342,10 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 	}
 
 	mt7615_eeprom_parse_hw_cap(dev);
-	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
 
-	mt76_eeprom_override(&dev->mt76);
+	mt76_eeprom_override(&dev->mphy);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 4f2ef4982001..a73b76e57c7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -422,8 +422,11 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	 * Make the secondary PHY MAC address local without overlapping with
 	 * the usual MAC address allocation scheme on multiple virtual interfaces
 	 */
-	mphy->hw->wiphy->perm_addr[0] |= 2;
-	mphy->hw->wiphy->perm_addr[0] ^= BIT(7);
+	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	       ETH_ALEN);
+	mphy->macaddr[0] |= 2;
+	mphy->macaddr[0] ^= BIT(7);
+	mt76_eeprom_override(mphy);
 
 	/* second phy can only handle 5 GHz */
 	mphy->cap.has_5ghz = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index ebf4c96532d3..dd66fd12a2e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -342,10 +342,10 @@ int mt76x0_eeprom_init(struct mt76x02_dev *dev)
 	dev_info(dev->mt76.dev, "EEPROM ver:%02hhx fae:%02hhx\n",
 		 version, fae);
 
-	memcpy(dev->mt76.macaddr, (u8 *)dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	memcpy(dev->mphy.macaddr, (u8 *)dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
-	mt76_eeprom_override(&dev->mt76);
-	mt76x02_mac_setaddr(dev, dev->mt76.macaddr);
+	mt76_eeprom_override(&dev->mphy);
+	mt76x02_mac_setaddr(dev, dev->mphy.macaddr);
 
 	mt76x0_set_chip_cap(dev);
 	mt76x0_set_freq_offset(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index da6d3f51f6d4..16b40a73fd1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -727,24 +727,24 @@ void mt76x02_mac_setaddr(struct mt76x02_dev *dev, const u8 *addr)
 	static const u8 null_addr[ETH_ALEN] = {};
 	int i;
 
-	ether_addr_copy(dev->mt76.macaddr, addr);
+	ether_addr_copy(dev->mphy.macaddr, addr);
 
-	if (!is_valid_ether_addr(dev->mt76.macaddr)) {
-		eth_random_addr(dev->mt76.macaddr);
+	if (!is_valid_ether_addr(dev->mphy.macaddr)) {
+		eth_random_addr(dev->mphy.macaddr);
 		dev_info(dev->mt76.dev,
 			 "Invalid MAC address, using random address %pM\n",
-			 dev->mt76.macaddr);
+			 dev->mphy.macaddr);
 	}
 
-	mt76_wr(dev, MT_MAC_ADDR_DW0, get_unaligned_le32(dev->mt76.macaddr));
+	mt76_wr(dev, MT_MAC_ADDR_DW0, get_unaligned_le32(dev->mphy.macaddr));
 	mt76_wr(dev, MT_MAC_ADDR_DW1,
-		get_unaligned_le16(dev->mt76.macaddr + 4) |
+		get_unaligned_le16(dev->mphy.macaddr + 4) |
 		FIELD_PREP(MT_MAC_ADDR_DW1_U2ME_MASK, 0xff));
 
 	mt76_wr(dev, MT_MAC_BSSID_DW0,
-		get_unaligned_le32(dev->mt76.macaddr));
+		get_unaligned_le32(dev->mphy.macaddr));
 	mt76_wr(dev, MT_MAC_BSSID_DW1,
-		get_unaligned_le16(dev->mt76.macaddr + 4) |
+		get_unaligned_le16(dev->mphy.macaddr + 4) |
 		FIELD_PREP(MT_MAC_BSSID_DW1_MBSS_MODE, 3) | /* 8 APs + 8 STAs */
 		MT_MAC_BSSID_DW1_MBSS_LOCAL_BIT);
 	/* enable 7 additional beacon slots and control them with bypass mask */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 86c1b545f363..7ac20d3c16d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -305,12 +305,12 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	/* Allow to change address in HW if we create first interface. */
 	if (!dev->mphy.vif_mask &&
-	    (((vif->addr[0] ^ dev->mt76.macaddr[0]) & ~GENMASK(4, 1)) ||
-	     memcmp(vif->addr + 1, dev->mt76.macaddr + 1, ETH_ALEN - 1)))
+	    (((vif->addr[0] ^ dev->mphy.macaddr[0]) & ~GENMASK(4, 1)) ||
+	     memcmp(vif->addr + 1, dev->mphy.macaddr + 1, ETH_ALEN - 1)))
 		mt76x02_mac_setaddr(dev, vif->addr);
 
 	if (vif->addr[0] & BIT(1))
-		idx = 1 + (((dev->mt76.macaddr[0] ^ vif->addr[0]) >> 2) & 7);
+		idx = 1 + (((dev->mphy.macaddr[0] ^ vif->addr[0]) >> 2) & 7);
 
 	/*
 	 * Client mode typically only has one configurable BSSID register,
@@ -678,7 +678,7 @@ void mt76x02_config_mac_addr_list(struct mt76x02_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(dev->macaddr_list); i++) {
 		u8 *addr = dev->macaddr_list[i].addr;
 
-		memcpy(addr, dev->mt76.macaddr, ETH_ALEN);
+		memcpy(addr, dev->mphy.macaddr, ETH_ALEN);
 
 		if (!i)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 410ffce3baff..c57e05a5c65e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -16,7 +16,7 @@ mt76x2_eeprom_get_macaddr(struct mt76x02_dev *dev)
 {
 	void *src = dev->mt76.eeprom.data + MT_EE_MAC_ADDR;
 
-	memcpy(dev->mt76.macaddr, src, ETH_ALEN);
+	memcpy(dev->mphy.macaddr, src, ETH_ALEN);
 	return 0;
 }
 
@@ -502,8 +502,8 @@ int mt76x2_eeprom_init(struct mt76x02_dev *dev)
 
 	mt76x02_eeprom_parse_hw_cap(dev);
 	mt76x2_eeprom_get_macaddr(dev);
-	mt76_eeprom_override(&dev->mt76);
-	dev->mt76.macaddr[0] &= ~BIT(1);
+	mt76_eeprom_override(&dev->mphy);
+	dev->mphy.macaddr[0] &= ~BIT(1);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 48a3ebc9892a..620484390418 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -69,7 +69,7 @@ mt76x2_fixup_xtal(struct mt76x02_dev *dev)
 
 int mt76x2_mac_reset(struct mt76x02_dev *dev, bool hard)
 {
-	const u8 *macaddr = dev->mt76.macaddr;
+	const u8 *macaddr = dev->mphy.macaddr;
 	u32 val;
 	int i, k;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index d65910cc0709..6f0f1d4c702a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -87,10 +87,10 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 		return ret;
 
 	mt7915_eeprom_parse_hw_cap(dev);
-	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
 
-	mt76_eeprom_override(&dev->mt76);
+	mt76_eeprom_override(&dev->mphy);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index a36134deb267..581eb56dc4be 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -59,13 +59,14 @@ static int
 mt76_testmode_tx_init(struct mt76_dev *dev)
 {
 	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_phy *phy = &dev->phy;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
 	u16 fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
 		 IEEE80211_FCTL_FROMDS;
 	struct ieee80211_tx_rate *rate;
-	u8 max_nss = hweight8(dev->phy.antenna_mask);
+	u8 max_nss = hweight8(phy->antenna_mask);
 
 	if (td->tx_antenna_mask)
 		max_nss = min_t(u8, max_nss, hweight8(td->tx_antenna_mask));
@@ -78,9 +79,9 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 	td->tx_skb = skb;
 	hdr = __skb_put_zero(skb, td->tx_msdu_len);
 	hdr->frame_control = cpu_to_le16(fc);
-	memcpy(hdr->addr1, dev->macaddr, sizeof(dev->macaddr));
-	memcpy(hdr->addr2, dev->macaddr, sizeof(dev->macaddr));
-	memcpy(hdr->addr3, dev->macaddr, sizeof(dev->macaddr));
+	memcpy(hdr->addr1, phy->macaddr, sizeof(phy->macaddr));
+	memcpy(hdr->addr2, phy->macaddr, sizeof(phy->macaddr));
+	memcpy(hdr->addr3, phy->macaddr, sizeof(phy->macaddr));
 
 	info = IEEE80211_SKB_CB(skb);
 	info->flags = IEEE80211_TX_CTL_INJECTED |
@@ -96,14 +97,14 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 
 	switch (td->tx_rate_mode) {
 	case MT76_TM_TX_MODE_CCK:
-		if (dev->phy.chandef.chan->band != NL80211_BAND_2GHZ)
+		if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
 			return -EINVAL;
 
 		if (rate->idx > 4)
 			return -EINVAL;
 		break;
 	case MT76_TM_TX_MODE_OFDM:
-		if (dev->phy.chandef.chan->band != NL80211_BAND_2GHZ)
+		if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
 			break;
 
 		if (rate->idx > 8)
@@ -114,7 +115,7 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 	case MT76_TM_TX_MODE_HT:
 		if (rate->idx > 8 * max_nss &&
 			!(rate->idx == 32 &&
-			  dev->phy.chandef.width >= NL80211_CHAN_WIDTH_40))
+			  phy->chandef.width >= NL80211_CHAN_WIDTH_40))
 			return -EINVAL;
 
 		rate->flags |= IEEE80211_TX_RC_MCS;
@@ -143,7 +144,7 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 		info->flags |= IEEE80211_TX_CTL_STBC;
 
 	if (td->tx_rate_mode >= MT76_TM_TX_MODE_HT) {
-		switch (dev->phy.chandef.width) {
+		switch (phy->chandef.width) {
 		case NL80211_CHAN_WIDTH_40:
 			rate->flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
 			break;
-- 
2.26.2

