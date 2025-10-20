Return-Path: <linux-wireless+bounces-28097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BFBF02BF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 11:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFF0189F401
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26C2F5A3F;
	Mon, 20 Oct 2025 09:30:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169C2F60B5;
	Mon, 20 Oct 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952621; cv=none; b=Z96885A6atRhbvsUCX7Czwbj2W6ZiaxsX0c96lz5LZWH1qtNLtSsZg0ZT9uFwQjP/Dv01lzSQFUBIS9uNG/g2Io4B5tUnX2sPWiSyy5PnWqAUfne8mvRKF4uJbHrpKK4+okHPtsdAXEwtjNdAg+rc8PFvFxzr7NJUebpTIlDhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952621; c=relaxed/simple;
	bh=4UgmR2z1wg7yH4cLtO7dxKxxXESpTcWRNrpxYXHV0sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IkNzFoXjjy+0hwDYpeijedH45xsGqzDpsQ8PqtxfCyjUf3lo+Z3Px+0MAgOaeeEdtI/otJT1rfx+8JDIrauBOnqJxI2HQZcZ9xulAAzIT85D5oh4vtmGmnvKNjuu+i+yJ7t/0uADbIK/tl2NSCTu8ICLvUtTpKBJ+cu6Jv5Jews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c59748F6e00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:9748:f6e0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D7EE1FA130;
	Mon, 20 Oct 2025 11:21:42 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Mon, 20 Oct 2025 11:20:53 +0200
Subject: [PATCH mt76 v3] wifi: mt76: Fix DTS power-limits on little endian
 systems
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-fix-power-limits-v3-1-019d2e49239a@simonwunderlich.de>
X-B4-Tracking: v=1; b=H4sIAPX+9WgC/3XNTQ6CMBAF4KuQrq2hJfTHlfcwLqAdZRJoSYtFQ
 7i7TVcucPlm3nyzkQgBIZJLtZEACSN6l0NzqogZOvcEijZnwmve1ppJ+sA3nf0KgY444RJpa6C
 WvdaNUIzkszlA7hTyRqZFCnLP0wHj4sOn/Ems7P6TiVFGBROgWt1ppdg14uTd+nIWwohmOFsoa
 uI/EhcHEs+S4b2RWYFe2ENp3/cvoYyprQkBAAA=
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5253; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=4UgmR2z1wg7yH4cLtO7dxKxxXESpTcWRNrpxYXHV0sI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBlf//3Z/iSYPb+57M51U0YdOdspMxML5OquqIay/WGL7
 b/1dVN0RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiBQqMDGdWLjVbXmwm/TRH
 WiH9DzfzIsmPXFxvvvWfPezwYQL3Fg+G/54tHQmRV5UmxixLSVkrX6Kb+as28P0JZ74tScp7IhJ
 WMgEA
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
Fixes: a9627d992b5e ("mt76: extend DT rate power limits to support 11ax devices")
Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
Changes in v3:
- add "mt76" as addition prefix after "PATCH" as requested by Zhi-Jun You
- Link to v2: https://lore.kernel.org/r/20250926-fix-power-limits-v2-1-c2bc7881eb6d@simonwunderlich.de

Changes in v2:
- Fix second Fixes line, thanks Zhi-Jun You
- Link to v1: https://lore.kernel.org/r/20250917-fix-power-limits-v1-1-616e859a9881@simonwunderlich.de
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 37 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index a987c5e4eff6..6ce8e4af18fe 100644
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


