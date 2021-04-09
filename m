Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE935A906
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhDIWwg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 18:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235105AbhDIWwf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 18:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F9C86102A;
        Fri,  9 Apr 2021 22:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618008741;
        bh=W8W6H7tvVEmUqV6EQZVWHMqZVwYpa9Xan6McTUVaH6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLP1uPEPxekt3gfAAgYQ/TBuu1/OKYWuIyCB2K5g4zY9vMFK9FqrYQfAvB306WhF0
         TAytcwOmwszC8H1x3UwvzWQqNbx9aIJz6tMoY3L3NSmtDnpc5GjkcYqg8dllAcE1Ex
         b/HAZp+2D+TWOZXbUkrAGN4nL074OKNGl4tTinrEBH8lS2zvBnUJVURldmtKU1OV2J
         XsMobr0qH3XqjxTK9G5LygOJh5l+m6hZlvgMz3Krx9vR7jMXTeCM2k3OEJvIJbvBHH
         uIv44U1jo6OFRxQtjIZA2HnU4gHXTj/MUnJtgNkAyIeC6LwlU+KjhW2Mw7AlQNSXzU
         1tmZ0lBowd4NQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 6/7] mt76: introduce single-sku support for mt7663/mt7921
Date:   Sat, 10 Apr 2021 00:51:51 +0200
Message-Id: <a18a09efe0f3c94b73f699846d8437c71f53642d.1618008449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618008449.git.lorenzo@kernel.org>
References: <cover.1618008449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for rate-txpower compensation for mt7663/mt7921 chipsets.
Rate-txpower limit is specified through dts

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 133 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 +++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 +
 6 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e23898365166..d2eb8e9fb7f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -323,8 +323,11 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
 		mt7615_dfs_init_radar_detector(phy);
-	if (mt7615_firmware_offload(phy->dev))
+
+	if (mt7615_firmware_offload(phy->dev)) {
 		mt76_connac_mcu_set_channel_domain(mphy);
+		mt76_connac_mcu_set_rate_txpower(mphy);
+	}
 
 	mt7615_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e30b256784e0..62d9df47a1f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -66,6 +66,10 @@ static int mt7615_start(struct ieee80211_hw *hw)
 		ret = mt76_connac_mcu_set_channel_domain(phy->mt76);
 		if (ret)
 			goto out;
+
+		ret = mt76_connac_mcu_set_rate_txpower(phy->mt76);
+		if (ret)
+			goto out;
 	}
 
 	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4892728ad9bb..fdc64993e531 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1564,6 +1564,139 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
 
+static void
+mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
+			  struct mt76_power_limits *limits,
+			  enum nl80211_band band)
+{
+	int max_power = is_mt7921(dev) ? 127 : 63;
+	int i, offset = sizeof(limits->cck);
+
+	memset(sku, max_power, MT_SKU_POWER_LIMIT);
+
+	if (band == NL80211_BAND_2GHZ) {
+		/* cck */
+		memcpy(sku, limits->cck, sizeof(limits->cck));
+	}
+
+	/* ofdm */
+	memcpy(&sku[offset], limits->ofdm, sizeof(limits->ofdm));
+	offset += sizeof(limits->ofdm);
+
+	/* ht */
+	for (i = 0; i < 2; i++) {
+		memcpy(&sku[offset], limits->mcs[i], 8);
+		offset += 8;
+	}
+	sku[offset++] = limits->mcs[0][0];
+
+	/* vht */
+	for (i = 0; i < ARRAY_SIZE(limits->mcs); i++) {
+		memcpy(&sku[offset], limits->mcs[i],
+		       ARRAY_SIZE(limits->mcs[i]));
+		offset += 12;
+	}
+
+	if (!is_mt7921(dev))
+		return;
+
+	/* he */
+	for (i = 0; i < ARRAY_SIZE(limits->ru); i++) {
+		memcpy(&sku[offset], limits->ru[i], ARRAY_SIZE(limits->ru[i]));
+		offset += ARRAY_SIZE(limits->ru[i]);
+	}
+}
+
+static int
+mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
+				  enum nl80211_band band)
+{
+	struct mt76_dev *dev = phy->dev;
+	int sku_len, batch_len = is_mt7921(dev) ? 8 : 16;
+	static const u8 chan_list_2ghz[] = {
+		1, 2,  3,  4,  5,  6,  7,
+		8, 9, 10, 11, 12, 13, 14
+	};
+	static const u8 chan_list_5ghz[] = {
+		 36,  38,  40,  42,  44,  46,  48,
+		 50,  52,  54,  56,  58,  60,  62,
+		 64, 100, 102, 104, 106, 108, 110,
+		112, 114, 116, 118, 120, 122, 124,
+		126, 128, 132, 134, 136, 138, 140,
+		142, 144, 149, 151, 153, 155, 157,
+		159, 161, 165
+	};
+	struct mt76_connac_sku_tlv sku_tlbv;
+	int i, n_chan, batch_size, idx = 0;
+	struct mt76_power_limits limits;
+	const u8 *ch_list;
+
+	sku_len = is_mt7921(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
+
+	if (band == NL80211_BAND_2GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_2ghz);
+		ch_list = chan_list_2ghz;
+	} else {
+		n_chan = ARRAY_SIZE(chan_list_5ghz);
+		ch_list = chan_list_5ghz;
+	}
+	batch_size = DIV_ROUND_UP(n_chan, batch_len);
+
+	for (i = 0; i < batch_size; i++) {
+		bool last_msg = i == batch_size - 1;
+		int num_ch = last_msg ? n_chan % batch_len : batch_len;
+		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {
+			.band = band == NL80211_BAND_2GHZ ? 1 : 2,
+			.n_chan = num_ch,
+			.last_msg = last_msg,
+		};
+		struct sk_buff *skb;
+		int j, err, msg_len;
+
+		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
+		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
+		if (!skb)
+			return -ENOMEM;
+
+		BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(tx_power_tlv.alpha2));
+		memcpy(tx_power_tlv.alpha2, dev->alpha2, sizeof(dev->alpha2));
+
+		skb_put_data(skb, &tx_power_tlv, sizeof(tx_power_tlv));
+		for (j = 0; j < num_ch; j++, idx++) {
+			struct ieee80211_channel chan = {
+				.hw_value = ch_list[idx],
+				.band = band,
+			};
+
+			mt76_get_rate_power_limits(phy, &chan, &limits, 127);
+
+			sku_tlbv.channel = ch_list[idx];
+			mt76_connac_mcu_build_sku(dev, sku_tlbv.pwr_limit,
+						  &limits, band);
+			skb_put_data(skb, &sku_tlbv, sku_len);
+		}
+
+		err = mt76_mcu_skb_send_msg(dev, skb,
+					    MCU_CMD_SET_RATE_TX_POWER, false);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
+{
+	int err;
+
+	err = mt76_connac_mcu_rate_txpower_band(phy, NL80211_BAND_2GHZ);
+	if (err < 0)
+		return err;
+
+	return mt76_connac_mcu_rate_txpower_band(phy, NL80211_BAND_5GHZ);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
+
 #ifdef CONFIG_PM
 
 const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 6f9b7807305a..01c458e14dc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -895,6 +895,28 @@ struct mt76_sta_cmd_info {
 	u8 rcpi;
 };
 
+#define MT_SKU_POWER_LIMIT	161
+
+struct mt76_connac_sku_tlv {
+	u8 channel;
+	s8 pwr_limit[MT_SKU_POWER_LIMIT];
+} __packed;
+
+struct mt76_connac_tx_power_limit_tlv {
+	/* DW0 - common info*/
+	u8 ver;
+	u8 pad0;
+	__le16 len;
+	/* DW1 - cmd hint */
+	u8 n_chan; /* # channel */
+	u8 band; /* 2.4GHz - 5GHz */
+	u8 last_msg;
+	u8 pad1;
+	/* DW3 */
+	u8 alpha2[4]; /* regulatory_request.alpha2 */
+	u8 pad2[32];
+} __packed;
+
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
 
@@ -997,4 +1019,5 @@ void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 int mt76_connac_mcu_chip_config(struct mt76_dev *dev);
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump);
+int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 9046bbfc0690..fae3aa268eb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -58,12 +58,14 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
 	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt76_connac_mcu_set_rate_txpower(phy->mt76);
 	mt7921_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 32b1cd0bca1f..e4801065a83c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -186,6 +186,10 @@ int __mt7921_start(struct mt7921_phy *phy)
 	if (err)
 		return err;
 
+	err = mt76_connac_mcu_set_rate_txpower(phy->mt76);
+	if (err)
+		return err;
+
 	mt7921_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &mphy->state);
 
-- 
2.30.2

