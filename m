Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7335DAAC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhDMJJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236908AbhDMJJR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE9A60FEF;
        Tue, 13 Apr 2021 09:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618304938;
        bh=2W5DzsIkPbyTP6BAsOxaDthMOXAUKeVxYI1G2wJSsxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkOmJYzZpPbAnjdanaZ3H/Gl7WFM1+3HHsqa7NTEGVVgiXBXJ2iPQdNrFKeXdMSAI
         72AWI8i3Pk+MeoYASZtHQ4GfnPyJmIExk8ATM79oql1Tv35Tlst3q24hjNQFK4A97r
         9WZNLYxTEJWzmlONhcV8i4gYKz2GXHPRvJtJfdwMZe2CqZD314ZfqZMGy4V0YOfqcT
         rAWc7JNEab24NRe3nsxrJTiM0PvDi+bK6rx2OTEq3acn5OfTgKAkIhndm4M9kb5WIU
         wyjatMA/E9SyODqFQOHhKU+th28I0FcOp2GbMfcyvPkGy3LIK+EtAklM3KHeHEswsA
         Ta7MEDNS3LnEg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v3 2/7] mt76: add functions for parsing rate power limits from DT
Date:   Tue, 13 Apr 2021 11:08:36 +0200
Message-Id: <4dceab9e4a94915eeefde34e6e23945bc18f72c0.1618304559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618304559.git.lorenzo@kernel.org>
References: <cover.1618304559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

This subnode can be used to set per-rate tx power limits either per
country code / regdomain or globally.
These limits are typically provided by the device manufacturers and are
used to limit sideband emissions and stay within regulatory limits

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 204 ++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h   |  12 ++
 2 files changed, 216 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 665b54c5c8ae..874a6d869e5b 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -111,6 +111,210 @@ mt76_eeprom_override(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_eeprom_override);
 
+static bool mt76_string_prop_find(struct property *prop, const char *str)
+{
+	const char *cp = NULL;
+
+	if (!prop || !str || !str[0])
+		return false;
+
+	while ((cp = of_prop_next_string(prop, cp)) != NULL)
+		if (!strcasecmp(cp, str))
+			return true;
+
+	return false;
+}
+
+static struct device_node *
+mt76_find_power_limits_node(struct mt76_dev *dev)
+{
+	struct device_node *np = dev->dev->of_node;
+	const char *const region_names[] = {
+		[NL80211_DFS_ETSI] = "etsi",
+		[NL80211_DFS_FCC] = "fcc",
+		[NL80211_DFS_JP] = "jp",
+	};
+	struct device_node *cur, *fallback = NULL;
+	const char *region_name = NULL;
+
+	if (dev->region < ARRAY_SIZE(region_names))
+		region_name = region_names[dev->region];
+
+	np = of_get_child_by_name(np, "power-limits");
+	if (!np)
+		return NULL;
+
+	for_each_child_of_node(np, cur) {
+		struct property *country = of_find_property(cur, "country", NULL);
+		struct property *regd = of_find_property(cur, "regdomain", NULL);
+
+		if (!country && !regd) {
+			fallback = cur;
+			continue;
+		}
+
+		if (mt76_string_prop_find(country, dev->alpha2) ||
+		    mt76_string_prop_find(regd, region_name))
+			return cur;
+	}
+
+	return fallback;
+}
+
+static const __be32 *
+mt76_get_of_array(struct device_node *np, char *name, size_t *len, int min)
+{
+	struct property *prop = of_find_property(np, name, NULL);
+
+	if (!prop || !prop->value || prop->length < min * 4)
+		return NULL;
+
+	*len = prop->length;
+
+	return prop->value;
+}
+
+static struct device_node *
+mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan)
+{
+	struct device_node *cur;
+	const __be32 *val;
+	size_t len;
+
+	for_each_child_of_node(np, cur) {
+		val = mt76_get_of_array(cur, "channels", &len, 2);
+		if (!val)
+			continue;
+
+		while (len >= 2 * sizeof(*val)) {
+			if (chan->hw_value >= be32_to_cpu(val[0]) &&
+			    chan->hw_value <= be32_to_cpu(val[1]))
+				return cur;
+
+			val += 2;
+			len -= 2 * sizeof(*val);
+		}
+	}
+
+	return NULL;
+}
+
+static s8
+mt76_get_txs_delta(struct device_node *np, u8 nss)
+{
+	const __be32 *val;
+	size_t len;
+
+	val = mt76_get_of_array(np, "txs-delta", &len, nss);
+	if (!val)
+		return 0;
+
+	return be32_to_cpu(val[nss - 1]);
+}
+
+static void
+mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
+		       s8 target_power, s8 nss_delta, s8 *max_power)
+{
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < pwr_len; i++) {
+		pwr[i] = min_t(s8, target_power,
+			       be32_to_cpu(data[i]) + nss_delta);
+		*max_power = max(*max_power, pwr[i]);
+	}
+}
+
+s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
+			      struct ieee80211_channel *chan,
+			      struct mt76_power_limits *dest,
+			      s8 target_power)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct device_node *np;
+	const __be32 *val;
+	char name[16];
+	u32 mcs_rates = dev->drv->mcs_rates;
+	char band;
+	size_t len;
+	int i, cur;
+	s8 max_power = 0;
+	s8 txs_delta;
+
+	if (!mcs_rates)
+		mcs_rates = 10;
+
+	memset(dest, target_power, sizeof(*dest));
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return target_power;
+
+	np = mt76_find_power_limits_node(dev);
+	if (!np)
+		return target_power;
+
+	switch (chan->band) {
+	case NL80211_BAND_2GHZ:
+		band = '2';
+		break;
+	case NL80211_BAND_5GHZ:
+		band = '5';
+		break;
+	default:
+		return target_power;
+	}
+
+	snprintf(name, sizeof(name), "txpower-%cg", band);
+	np = of_get_child_by_name(np, name);
+	if (!np)
+		return target_power;
+
+	np = mt76_find_channel_node(np, chan);
+	if (!np)
+		return target_power;
+
+	txs_delta = mt76_get_txs_delta(np, hweight8(phy->antenna_mask));
+
+	val = mt76_get_of_array(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
+	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
+			       target_power, txs_delta, &max_power);
+
+	val = mt76_get_of_array(np, "rates-ofdm",
+				&len, ARRAY_SIZE(dest->ofdm));
+	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
+			       target_power, txs_delta, &max_power);
+
+	val = mt76_get_of_array(np, "rates-mcs", &len, mcs_rates + 1);
+	if (!val)
+		return max_power;
+
+	len /= 4;
+	cur = be32_to_cpu(val[0]);
+	for (i = 0; i < ARRAY_SIZE(dest->mcs); i++) {
+		if (len < mcs_rates + 1)
+			break;
+
+		mt76_apply_array_limit(dest->mcs[i], ARRAY_SIZE(dest->mcs[i]),
+				       val + 1, target_power, txs_delta,
+				       &max_power);
+		if (--cur > 0)
+			continue;
+
+		val += mcs_rates + 1;
+		len -= mcs_rates + 1;
+		if (!len)
+			break;
+
+		cur = be32_to_cpu(val[0]);
+	}
+
+	return max_power;
+}
+EXPORT_SYMBOL_GPL(mt76_get_rate_power_limits);
+
 int
 mt76_eeprom_init(struct mt76_dev *dev, int len)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d121c176c37c..ece5b79a50e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -331,6 +331,7 @@ struct mt76_driver_ops {
 	u32 drv_flags;
 	u32 survey_flags;
 	u16 txwi_size;
+	u8 mcs_rates;
 
 	void (*update_survey)(struct mt76_dev *dev);
 
@@ -711,6 +712,12 @@ struct mt76_dev {
 	};
 };
 
+struct mt76_power_limits {
+	s8 cck[4];
+	s8 ofdm[8];
+	s8 mcs[4][10];
+};
+
 enum mt76_phy_type {
 	MT_PHY_TYPE_CCK,
 	MT_PHY_TYPE_OFDM,
@@ -1194,4 +1201,9 @@ mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb, int cmd,
 
 void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
 
+s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
+			      struct ieee80211_channel *chan,
+			      struct mt76_power_limits *dest,
+			      s8 target_power);
+
 #endif
-- 
2.30.2

