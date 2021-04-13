Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFAB35DAAE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbhDMJJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236908AbhDMJJU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12119613B7;
        Tue, 13 Apr 2021 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618304940;
        bh=02geVXL34+1q4r/XQW3qNz2g9/t9UyAWHZ/lLPdb03M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiX8TPHsxcT+7MNPjA0YcBN8GvUPTfpAW40x/0qe88a8/Pe4GNYMRWzilhk1pqblt
         eJVrPrDdx5yjhvNGGD2NtH+jhSW+9cCT2QhxC12BEh2hpW+IzdIUqPeF0Jd4UVphrN
         374sbcCWKSYjOYpV7rY9ZJNXvb/5oOmrtI4EVItA8GcsjKuaSrU7W9JbDQbpd7YSX2
         ON7+pvHSdxY0OhAs98PCwbni7MMfBgrbONwRIMPCBru9kFp0QJ3TgfCoPwG3288fuD
         52IVfO+dAMjY5zly8yfB1f70EK0OF6Qyd18+kbT786i55t4fjarFvXW7TH1gsZBuVQ
         qv5A4LY60NmrA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v3 3/7] mt76: extend DT rate power limits to support 11ax devices
Date:   Tue, 13 Apr 2021 11:08:37 +0200
Message-Id: <f4b1d62603a29cf9c12fb8f031880dca03e312c4.1618304559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618304559.git.lorenzo@kernel.org>
References: <cover.1618304559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

Enable parsing per-rate txpower limits from DT for 11ax chipsets.

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 62 +++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76.h   |  1 +
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 874a6d869e5b..e20aa6998e4d 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -228,6 +228,36 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
 	}
 }
 
+static void
+mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
+			     const __be32 *data, size_t len, s8 target_power,
+			     s8 nss_delta, s8 *max_power)
+{
+	int i, cur;
+
+	if (!data)
+		return;
+
+	len /= 4;
+	cur = be32_to_cpu(data[0]);
+	for (i = 0; i < pwr_num; i++) {
+		if (len < pwr_len + 1)
+			break;
+
+		mt76_apply_array_limit(pwr + pwr_len * i, pwr_len, data + 1,
+				       target_power, nss_delta, max_power);
+		if (--cur > 0)
+			continue;
+
+		data += pwr_len + 1;
+		len -= pwr_len + 1;
+		if (!len)
+			break;
+
+		cur = be32_to_cpu(data[0]);
+	}
+}
+
 s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct ieee80211_channel *chan,
 			      struct mt76_power_limits *dest,
@@ -238,9 +268,9 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	const __be32 *val;
 	char name[16];
 	u32 mcs_rates = dev->drv->mcs_rates;
+	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
 	char band;
 	size_t len;
-	int i, cur;
 	s8 max_power = 0;
 	s8 txs_delta;
 
@@ -288,28 +318,14 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			       target_power, txs_delta, &max_power);
 
 	val = mt76_get_of_array(np, "rates-mcs", &len, mcs_rates + 1);
-	if (!val)
-		return max_power;
-
-	len /= 4;
-	cur = be32_to_cpu(val[0]);
-	for (i = 0; i < ARRAY_SIZE(dest->mcs); i++) {
-		if (len < mcs_rates + 1)
-			break;
-
-		mt76_apply_array_limit(dest->mcs[i], ARRAY_SIZE(dest->mcs[i]),
-				       val + 1, target_power, txs_delta,
-				       &max_power);
-		if (--cur > 0)
-			continue;
-
-		val += mcs_rates + 1;
-		len -= mcs_rates + 1;
-		if (!len)
-			break;
-
-		cur = be32_to_cpu(val[0]);
-	}
+	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
+				     ARRAY_SIZE(dest->mcs), val, len,
+				     target_power, txs_delta, &max_power);
+
+	val = mt76_get_of_array(np, "rates-ru", &len, ru_rates + 1);
+	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
+				     ARRAY_SIZE(dest->ru), val, len,
+				     target_power, txs_delta, &max_power);
 
 	return max_power;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ece5b79a50e2..4571f0ed352c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -716,6 +716,7 @@ struct mt76_power_limits {
 	s8 cck[4];
 	s8 ofdm[8];
 	s8 mcs[4][10];
+	s8 ru[7][12];
 };
 
 enum mt76_phy_type {
-- 
2.30.2

