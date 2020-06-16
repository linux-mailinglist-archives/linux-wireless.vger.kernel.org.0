Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3042F1FBEF3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgFPTZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 15:25:46 -0400
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140]:51982 "EHLO
        maeck.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730691AbgFPTZp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 15:25:45 -0400
Received: by maeck.local (Postfix, from userid 501)
        id B1F518E50DD4; Tue, 16 Jun 2020 21:25:44 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     shayne.chen@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH v2 3/4] mt76: extend DT rate power limits to support 11ax devices
Date:   Tue, 16 Jun 2020 21:25:43 +0200
Message-Id: <20200616192544.97938-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200616192544.97938-1-nbd@nbd.name>
References: <20200616192544.97938-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

Enable parsing per-rate txpower limits from DT for 11ax chipsets.

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: clean up rate array handling, simplify
 drivers/net/wireless/mediatek/mt76/eeprom.c | 62 +++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76.h   |  1 +
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 7deb3c90c113..17a1a3ccc9dd 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -221,6 +221,36 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
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
@@ -231,9 +261,9 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	const __be32 *val;
 	char name[16];
 	u32 mcs_rates = dev->drv->mcs_rates;
+	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
 	char band;
 	size_t len;
-	int i, cur;
 	s8 max_power = 0;
 	s8 txs_delta;
 
@@ -280,28 +310,14 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			       target_power, txs_delta, &max_power);
 
 	val = mt76_get_of_array(np, "mcs", &len, mcs_rates + 1);
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
+	val = mt76_get_of_array(np, "ru", &len, ru_rates + 1);
+	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
+				     ARRAY_SIZE(dest->ru), val, len,
+				     target_power, txs_delta, &max_power);
 
 	return max_power;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9c5488ffbe5e..d50871653de1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -584,6 +584,7 @@ struct mt76_power_limits {
 	s8 cck[4];
 	s8 ofdm[8];
 	s8 mcs[4][10];
+	s8 ru[7][12];
 };
 
 enum mt76_phy_type {
-- 
2.24.0

