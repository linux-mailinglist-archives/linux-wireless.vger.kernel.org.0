Return-Path: <linux-wireless+bounces-27443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716CB807AF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B8446624D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD927934B;
	Wed, 17 Sep 2025 15:19:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929052D97B5;
	Wed, 17 Sep 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122370; cv=none; b=btgD7b1cKcXdKwW5JKlDh61r9iDo7h1VKd115K2+YWG/lmh196UXsTXNOLTNc/eFO7eDk4dy9HzQjCBnnfCBOE5T2M/UJ1WhwwsR+gH/4ZHZVRS7z3TpAsnvIARrVfv388lAUOxTIUf25xAxz3scVIspTR8dytE7HnwimvEQLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122370; c=relaxed/simple;
	bh=ec3UcGcmns+1WED33m/nQgJBe8h/K7vnYvuHF6DPz3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rm4ShOF1HyIERnEIvHISj1m566wGr2MGLxU9gDo1EkDClkpXhcnkqZ8e1OOTGWGxx2lsKo2kasQwEzZJmh/y6/rRuQMLNKxvpWf1LjpU8cZ2YAVKQhtU9pocQUvwdyBBrnXqAz5xuZIuSQCovlueZEoy87OsAQzfsSsXIro/s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c5971bEfE00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:971b:efe0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id AF95AFA12C;
	Wed, 17 Sep 2025 17:19:19 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Wed, 17 Sep 2025 17:18:22 +0200
Subject: [PATCH] wifi: mt76: Fix DTS power-limits on little endian systems
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-fix-power-limits-v1-1-616e859a9881@simonwunderlich.de>
X-B4-Tracking: v=1; b=H4sIAD3RymgC/x2M0QpAMBRAf0X32a2NZuZX5IG5uMVoE2r5d8vjq
 XNOhECeKUCTRfB0ceDdJZB5Bnbp3UzIY2IoRKGEkRonfvDYb/K48sZnQGVJ6MGYsqolpOzwlJx
 /2Xbv+wFkAL5+YgAAAA==
X-Change-ID: 20250917-fix-power-limits-5ce07b993681
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, 
 "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4942; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=ec3UcGcmns+1WED33m/nQgJBe8h/K7vnYvuHF6DPz3A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBmnLobVprIoe6yMlV3be/1Dd59l89vWxv7yudOeLuvsd
 WoqDWnsKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkARfD/3B++1MMO6NOlM8Q
 O6fAHvLVKCckcaXHfY307MpdTn1ybYwMSwvv8Um4yXr8rTslfJSpsu9VXHt1nKTEkT3mOhdevp7
 MDgA=
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

The power-limits for ru and mcs and stored in the devicetree as bytewise
array (often with sizes which are not a multiple of 4). These arrays have a
prefix which defines for how many modes a line is applied. This prefix is
also only a byte - but the code still tried to fix the endianness of this
byte with a be32 operation. As result, loading was mostly failing or was
sending completely unexpected values to the firmware.

Since the other rates are also stored in the devicetree as bytewise arrays,
just drop the u32 access + be32_to_cpu conversion and directly access them
as bytes arrays.

Cc: stable@vger.kernel.org
Fixes: 22b980badc0f ("mt76: add functions for parsing rate power limits from DT")
Fixes: 273943f4abd4 ("wifi: mt76: Fix DTS power-limits on little endian systems")
Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 37 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index a987c5e4eff6c6b0a014b4b069dc1259ffa82d31..6ce8e4af18fe53c10a0cb7290bf65962ce9cdde4 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -253,6 +253,19 @@ mt76_get_of_array(struct device_node *np, char *name, size_t *len, int min)
 	return prop->value;
 }
 
+static const s8 *
+mt76_get_of_array_s8(struct device_node *np, char *name, size_t *len, int min)
+{
+	struct property *prop = of_find_property(np, name, NULL);
+
+	if (!prop || !prop->value || prop->length < min)
+		return NULL;
+
+	*len = prop->length;
+
+	return prop->value;
+}
+
 struct device_node *
 mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan)
 {
@@ -294,7 +307,7 @@ mt76_get_txs_delta(struct device_node *np, u8 nss)
 }
 
 static void
-mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
+mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
 		       s8 target_power, s8 nss_delta, s8 *max_power)
 {
 	int i;
@@ -303,15 +316,14 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
 		return;
 
 	for (i = 0; i < pwr_len; i++) {
-		pwr[i] = min_t(s8, target_power,
-			       be32_to_cpu(data[i]) + nss_delta);
+		pwr[i] = min_t(s8, target_power, data[i] + nss_delta);
 		*max_power = max(*max_power, pwr[i]);
 	}
 }
 
 static void
 mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
-			     const __be32 *data, size_t len, s8 target_power,
+			     const s8 *data, size_t len, s8 target_power,
 			     s8 nss_delta, s8 *max_power)
 {
 	int i, cur;
@@ -319,8 +331,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 	if (!data)
 		return;
 
-	len /= 4;
-	cur = be32_to_cpu(data[0]);
+	cur = data[0];
 	for (i = 0; i < pwr_num; i++) {
 		if (len < pwr_len + 1)
 			break;
@@ -335,7 +346,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 		if (!len)
 			break;
 
-		cur = be32_to_cpu(data[0]);
+		cur = data[0];
 	}
 }
 
@@ -346,7 +357,7 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 	struct device_node *np;
-	const __be32 *val;
+	const s8 *val;
 	char name[16];
 	u32 mcs_rates = dev->drv->mcs_rates;
 	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
@@ -392,21 +403,21 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 
 	txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));
 
-	val = mt76_get_of_array(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
+	val = mt76_get_of_array_s8(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
 	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
 			       target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-ofdm",
-				&len, ARRAY_SIZE(dest->ofdm));
+	val = mt76_get_of_array_s8(np, "rates-ofdm",
+				   &len, ARRAY_SIZE(dest->ofdm));
 	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
 			       target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-mcs", &len, mcs_rates + 1);
+	val = mt76_get_of_array_s8(np, "rates-mcs", &len, mcs_rates + 1);
 	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
 				     ARRAY_SIZE(dest->mcs), val, len,
 				     target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-ru", &len, ru_rates + 1);
+	val = mt76_get_of_array_s8(np, "rates-ru", &len, ru_rates + 1);
 	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
 				     ARRAY_SIZE(dest->ru), val, len,
 				     target_power, txs_delta, &max_power);

---
base-commit: b36d55610215a976267197ddc914902c494705d7
change-id: 20250917-fix-power-limits-5ce07b993681

Best regards,
-- 
Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>


