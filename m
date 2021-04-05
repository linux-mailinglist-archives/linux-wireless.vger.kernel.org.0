Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381C2354219
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhDEMk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235571AbhDEMk7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:40:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86D666138A;
        Mon,  5 Apr 2021 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626453;
        bh=A1AV/GITF4BxzEDJLzlJcRYg3vsn0gWnsgCgm5qngMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8Zfl3yF7a429f6JEanmIrZOaRTuwtFhbXKhvrFiyQVZNtnXpBJQnisVJ1NnJOUdx
         1HTqQSF21J6PIr3ke0rxEsbBtmJQPvZ91oVsexwmNuQXOkKLSnH/OUNupdJOrk/4dF
         +oh2YDCZw3cYHAIO/1EHxeZvc6XhG3NkHcnYGFVfzEJS1laDMuqpJdv2eaq/yB5CMg
         4ZmV4Isxy5s5ClFZ6J0WpY9B963eaY0auc58N/aBBweliPXbjvzpwrhmgTxDP622vQ
         h48WWqeNi4huLCwkd2FpS8Hj0QW3r39fl1z5o6LwgnXFljnQM/3y2VxzwbE7Tg5jQk
         DNk/cWQfpjbpA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 4/8] mt76: extend DT rate power limits to support 11ax devices
Date:   Mon,  5 Apr 2021 14:40:28 +0200
Message-Id: <0452c805cd1108a3f32780f31b1d028d78991ded.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617625912.git.lorenzo@kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
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
index 9e2f4a11493b..65813f19e2ee 100644
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
 
@@ -287,28 +317,14 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
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
index 0d2eeb37129c..2cfe5584f33f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -715,6 +715,7 @@ struct mt76_power_limits {
 	s8 cck[4];
 	s8 ofdm[8];
 	s8 mcs[4][10];
+	s8 ru[7][12];
 };
 
 enum mt76_phy_type {
-- 
2.30.2

