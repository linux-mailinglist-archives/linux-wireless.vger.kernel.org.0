Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91861E837B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgE2QTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgE2QTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 12:19:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A805C08C5C8
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ujW2yFWEvnbjg5knASlzyTc/31L4MgCnIkkckh4fBrw=; b=fNCUJNJnCHWXzUWHs30blbFQ23
        wtYBC04kVF8bLJZerByALMofgmqxrgW6XQ1wjRk8DEfwti4nduEy1Wua1Lek+JSi2Hn21vdKaIsW7
        RWmswZLfBLUl8dNAF64xTvF8LETfpWWZ9+H0bgPC6p49QrOjW/MSaHVdz2hq5Ljo9qyM=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jehjH-0007eJ-1l
        for linux-wireless@vger.kernel.org; Fri, 29 May 2020 18:19:31 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id C248E8917449; Fri, 29 May 2020 18:19:29 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: add functions for parsing rate power limits from DT
Date:   Fri, 29 May 2020 18:19:28 +0200
Message-Id: <20200529161929.24751-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200529161929.24751-1-nbd@nbd.name>
References: <20200529161929.24751-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This subnode can be used to set per-rate tx power limits either per
country code / regdomain or globally.
These limits are typically provided by the device manufacturers and are
used to limit sideband emissions and stay within regulatory limits

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 203 ++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h   |  13 ++
 2 files changed, 216 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index c236e303ccfd..334606b07693 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -104,6 +104,209 @@ mt76_eeprom_override(struct mt76_dev *dev)
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
+	if (nss >= 4)
+		return 0;
+
+	val = mt76_get_of_array(np, "txs_delta", &len, 3);
+	return be32_to_cpu(val[3 - nss]);
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
+	val = mt76_get_of_array(np, "cck", &len, ARRAY_SIZE(dest->cck));
+	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
+			       target_power, txs_delta, &max_power);
+
+	val = mt76_get_of_array(np, "ofdm", &len, ARRAY_SIZE(dest->ofdm));
+	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
+			       target_power, txs_delta, &max_power);
+
+	val = mt76_get_of_array(np, "mcs", &len, mcs_rates + 1);
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
index dfe625a53c63..64cafc0caa33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -306,6 +306,7 @@ struct mt76_driver_ops {
 	u32 drv_flags;
 	u32 survey_flags;
 	u16 txwi_size;
+	u8 mcs_rates;
 
 	void (*update_survey)(struct mt76_dev *dev);
 
@@ -558,6 +559,7 @@ struct mt76_dev {
 
 	struct mt76_rate_power rate_power;
 
+	char alpha2[3];
 	enum nl80211_dfs_regions region;
 
 	u32 debugfs_reg;
@@ -577,6 +579,12 @@ struct mt76_dev {
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
@@ -959,4 +967,9 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 
 void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
 
+s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
+			      struct ieee80211_channel *chan,
+			      struct mt76_power_limits *dest,
+			      s8 target_power);
+
 #endif
-- 
2.24.0

