Return-Path: <linux-wireless+bounces-31744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH9DGUjVjGm+tgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:15:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E855912719F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADB13027B75
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60F353EC5;
	Wed, 11 Feb 2026 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i7g8RrsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA834575A;
	Wed, 11 Feb 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837286; cv=none; b=OdOsdMEHr6043Y4iMeuhMIFRSIzjT3ELPQt/01288oPW3T2LYMkhiw61eS0wnISvlmh/q4iO7KO6X2Vabla++mJRPzYHOys9fIc/NDyNV8mtDbRr7vMVR/gBYnevI7BhrZorYOk6puTfDtEi5YG/1u5oYPASOC1L4k32/VA1ddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837286; c=relaxed/simple;
	bh=uUm2X/IGp15K/BNRFTwPUj9WbS2m+NewpV5MbPhGvX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0J6+IDKbI0R1+1t2j+aDzJmqEHKdfMguS3DQKJXXPy5Lb+jwiv3aKVdC1mQmQlwSdSpkXedCSn3ru4YHC8CBld3nNID2LyJk9TBC6VAt36la7z7s0MjQL9rC3D96PKmNTWJFAUqVjSbRC+fX3ixTuV4Jy8TLHOaBxGKSad2EsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i7g8RrsE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e69ffffc077d11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YP/GHC5z8MNUHfPhUc8hPRAIZs+5oRZnveGzDkVa110=;
	b=i7g8RrsEzdbQM8RR/5Re34Nlxd8M2xppynAu8jq1QjB+NMCpKot9FdsTm3RQlMN3SkuLBN6cM/lzMBgHjU5qHVVAIlgIdcO6E6Ckn8z/RkhWCoE1KLq1GD9f64a4RKRYgA5X5eK+B7C+RmYNlpSOqszGZ9YbFxWC4GUuQckiWY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:15fe0628-c7ea-490a-a0d0-bef3228488d1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:13e197f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e69ffffc077d11f185319dbc3099e8fb-20260212
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1875600474; Thu, 12 Feb 2026 03:14:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 03:14:33 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 03:14:32 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>, Allen Ye <allen.ye@mediatek.com>, Ryder Lee
	<ryder.lee@mediatek.com>
Subject: [PATCH v4 1/2] wifi: mt76: fix backoff fields and max_power calculation
Date: Wed, 11 Feb 2026 11:14:29 -0800
Message-ID: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770836705.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31744-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: E855912719F
X-Rspamd-Action: no action

From: Allen Ye <allen.ye@mediatek.com>

The maximum power value may exist in either the data or backoff field.
Previously, backoff power limits were not considered in txpower reporting.
This patch ensures mt76 also considers backoff values in the SKU table.

Also, each RU entry (RU26, RU52, RU106, BW20, ...) in the DTS corresponds
to 10 stream combinations (1T1ss, 2T1ss, 3T1ss, 4T1ss, 2T2ss, 3T2ss,
4T2ss, 3T3ss, 4T3ss, 4T4ss).

For beamforming tables:
- In connac2, beamforming entries for BW20~BW160, and OFDM do not include
  1T1ss.
- In connac3 (mt799x), beamforming entries for BW20~BW160, and RU include
  1T1ss, but OFDM beamforming does not include 1T1ss.
Non-beamforming and RU entries for both connac2 and connac3 include 1T1ss.

Fixes: b05ab4be9fd7 ("wifi: mt76: mt7915: add bf backoff limit table support")
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v1:
- Add "wifi:" prefix to the subject.

v2:
- Fix checkpatch errors.
- Remove unnecessary style changes.
- Add explanation for connac2 index adjustment.

v3:
- Fix "case"s for MT76_SKU_BACKOFF_BF_OFFSET and MT76_SKU_BACKOFF.
- add more explanation for connac2/connac3 tables.

v4: none
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 154 ++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h   |   1 -
 2 files changed, 109 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 573400d57..afdb73661 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -9,6 +9,13 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/etherdevice.h>
 #include "mt76.h"
+#include "mt76_connac.h"
+
+enum mt76_sku_type {
+	MT76_SKU_RATE,
+	MT76_SKU_BACKOFF,
+	MT76_SKU_BACKOFF_BF_OFFSET,
+};
 
 static int mt76_get_of_eeprom_data(struct mt76_dev *dev, void *eep, int len)
 {
@@ -292,7 +299,6 @@ mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan)
 }
 EXPORT_SYMBOL_GPL(mt76_find_channel_node);
 
-
 static s8
 mt76_get_txs_delta(struct device_node *np, u8 nss)
 {
@@ -306,9 +312,24 @@ mt76_get_txs_delta(struct device_node *np, u8 nss)
 	return be32_to_cpu(val[nss - 1]);
 }
 
+static inline u8 mt76_backoff_n_chains(struct mt76_dev *dev, u8 idx)
+{
+	/* 0:1T1ss, 1:2T1ss, ..., 14:5T5ss */
+	static const u8 connac3_table[] = {
+		1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4, 5, 5};
+	static const u8 connac2_table[] = {
+		1, 2, 3, 4, 2, 3, 4, 3, 4, 4, 0, 0, 0, 0, 0};
+
+	if (idx >= ARRAY_SIZE(connac3_table))
+		return 0;
+
+	return is_mt799x(dev) ? connac3_table[idx] : connac2_table[idx];
+}
+
 static void
-mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
-		       s8 target_power, s8 nss_delta, s8 *max_power)
+mt76_apply_array_limit(struct mt76_dev *dev, s8 *pwr, size_t pwr_len,
+		       const s8 *data, s8 target_power, s8 nss_delta,
+		       s8 *max_power, int n_chains, enum mt76_sku_type type)
 {
 	int i;
 
@@ -316,18 +337,51 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
 		return;
 
 	for (i = 0; i < pwr_len; i++) {
-		pwr[i] = min_t(s8, target_power, data[i] + nss_delta);
+		u8 backoff_chain_idx = i;
+		int backoff_n_chains;
+		s8 backoff_delta;
+		s8 delta;
+
+		switch (type) {
+		case MT76_SKU_RATE:
+			delta = 0;
+			backoff_delta = 0;
+			backoff_n_chains = 0;
+			break;
+		case MT76_SKU_BACKOFF_BF_OFFSET:
+			backoff_chain_idx += 1;
+			fallthrough;
+		case MT76_SKU_BACKOFF:
+			delta = mt76_tx_power_path_delta(n_chains);
+			backoff_n_chains = mt76_backoff_n_chains(dev, backoff_chain_idx);
+			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
+			break;
+		default:
+			return;
+		}
+
+		pwr[i] = min_t(s8, target_power + delta - backoff_delta, data[i] + nss_delta);
+
+		/* used for padding, doesn't need to be considered */
+		if (data[i] >= S8_MAX - 1)
+			continue;
+
+		/* only consider backoff value for the configured chain number */
+		if (type != MT76_SKU_RATE && n_chains != backoff_n_chains)
+			continue;
+
 		*max_power = max(*max_power, pwr[i]);
 	}
 }
 
 static void
-mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
-			     const s8 *data, size_t len, s8 target_power,
-			     s8 nss_delta)
+mt76_apply_multi_array_limit(struct mt76_dev *dev, s8 *pwr, size_t pwr_len,
+			     s8 pwr_num, const s8 *data, size_t len,
+			     s8 target_power, s8 nss_delta, s8 *max_power,
+			     int n_chains, enum mt76_sku_type type)
 {
+	static const int connac2_backoff_ru_idx = 2;
 	int i, cur;
-	s8 max_power = -128;
 
 	if (!data)
 		return;
@@ -337,8 +391,26 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 		if (len < pwr_len + 1)
 			break;
 
-		mt76_apply_array_limit(pwr + pwr_len * i, pwr_len, data + 1,
-				       target_power, nss_delta, &max_power);
+		/* Each RU entry (RU26, RU52, RU106, BW20, ...) in the DTS
+		 * corresponds to 10 stream combinations (1T1ss, 2T1ss, 3T1ss,
+		 * 4T1ss, 2T2ss, 3T2ss, 4T2ss, 3T3ss, 4T3ss, 4T4ss).
+		 *
+		 * For beamforming tables:
+		 * - In connac2, beamforming entries for BW20~BW160 and OFDM
+		 *   do not include 1T1ss.
+		 * - In connac3, beamforming entries for BW20~BW160 and RU
+		 *   include 1T1ss, but OFDM beamforming does not include 1T1ss.
+		 *
+		 * Non-beamforming and RU entries for both connac2 and connac3
+		 * include 1T1ss.
+		 */
+		if (!is_mt799x(dev) && type == MT76_SKU_BACKOFF &&
+		    i > connac2_backoff_ru_idx)
+			type = MT76_SKU_BACKOFF_BF_OFFSET;
+
+		mt76_apply_array_limit(dev, pwr + pwr_len * i, pwr_len, data + 1,
+				       target_power, nss_delta, max_power,
+				       n_chains, type);
 		if (--cur > 0)
 			continue;
 
@@ -360,18 +432,11 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	struct device_node *np;
 	const s8 *val;
 	char name[16];
-	u32 mcs_rates = dev->drv->mcs_rates;
-	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
 	char band;
 	size_t len;
-	s8 max_power = 0;
-	s8 max_power_backoff = -127;
+	s8 max_power = -127;
 	s8 txs_delta;
 	int n_chains = hweight16(phy->chainmask);
-	s8 target_power_combine = target_power + mt76_tx_power_path_delta(n_chains);
-
-	if (!mcs_rates)
-		mcs_rates = 10;
 
 	memset(dest, target_power, sizeof(*dest) - sizeof(dest->path));
 	memset(&dest->path, 0, sizeof(dest->path));
@@ -409,46 +474,45 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));
 
 	val = mt76_get_of_array_s8(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
-	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
-			       target_power, txs_delta, &max_power);
+	mt76_apply_array_limit(dev, dest->cck, ARRAY_SIZE(dest->cck), val,
+			       target_power, txs_delta, &max_power, n_chains, MT76_SKU_RATE);
 
-	val = mt76_get_of_array_s8(np, "rates-ofdm",
-				   &len, ARRAY_SIZE(dest->ofdm));
-	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
-			       target_power, txs_delta, &max_power);
+	val = mt76_get_of_array_s8(np, "rates-ofdm", &len, ARRAY_SIZE(dest->ofdm));
+	mt76_apply_array_limit(dev, dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
+			       target_power, txs_delta, &max_power, n_chains, MT76_SKU_RATE);
 
-	val = mt76_get_of_array_s8(np, "rates-mcs", &len, mcs_rates + 1);
-	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
-				     ARRAY_SIZE(dest->mcs), val, len,
-				     target_power, txs_delta);
+	val = mt76_get_of_array_s8(np, "rates-mcs", &len, ARRAY_SIZE(dest->mcs[0]) + 1);
+	mt76_apply_multi_array_limit(dev, dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
+				     ARRAY_SIZE(dest->mcs), val, len, target_power,
+				     txs_delta, &max_power, n_chains, MT76_SKU_RATE);
 
-	val = mt76_get_of_array_s8(np, "rates-ru", &len, ru_rates + 1);
-	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
-				     ARRAY_SIZE(dest->ru), val, len,
-				     target_power, txs_delta);
+	val = mt76_get_of_array_s8(np, "rates-ru", &len, ARRAY_SIZE(dest->ru[0]) + 1);
+	mt76_apply_multi_array_limit(dev, dest->ru[0], ARRAY_SIZE(dest->ru[0]),
+				     ARRAY_SIZE(dest->ru), val, len, target_power,
+				     txs_delta, &max_power, n_chains, MT76_SKU_RATE);
 
-	max_power_backoff = max_power;
 	val = mt76_get_of_array_s8(np, "paths-cck", &len, ARRAY_SIZE(dest->path.cck));
-	mt76_apply_array_limit(dest->path.cck, ARRAY_SIZE(dest->path.cck), val,
-			       target_power_combine, txs_delta, &max_power_backoff);
+	mt76_apply_array_limit(dev, dest->path.cck, ARRAY_SIZE(dest->path.cck), val,
+			       target_power, txs_delta, &max_power, n_chains, MT76_SKU_BACKOFF);
 
 	val = mt76_get_of_array_s8(np, "paths-ofdm", &len, ARRAY_SIZE(dest->path.ofdm));
-	mt76_apply_array_limit(dest->path.ofdm, ARRAY_SIZE(dest->path.ofdm), val,
-			       target_power_combine, txs_delta, &max_power_backoff);
+	mt76_apply_array_limit(dev, dest->path.ofdm, ARRAY_SIZE(dest->path.ofdm), val,
+			       target_power, txs_delta, &max_power, n_chains, MT76_SKU_BACKOFF);
 
 	val = mt76_get_of_array_s8(np, "paths-ofdm-bf", &len, ARRAY_SIZE(dest->path.ofdm_bf));
-	mt76_apply_array_limit(dest->path.ofdm_bf, ARRAY_SIZE(dest->path.ofdm_bf), val,
-			       target_power_combine, txs_delta, &max_power_backoff);
+	mt76_apply_array_limit(dev, dest->path.ofdm_bf, ARRAY_SIZE(dest->path.ofdm_bf), val,
+			       target_power, txs_delta, &max_power, n_chains,
+			       MT76_SKU_BACKOFF_BF_OFFSET);
 
 	val = mt76_get_of_array_s8(np, "paths-ru", &len, ARRAY_SIZE(dest->path.ru[0]) + 1);
-	mt76_apply_multi_array_limit(dest->path.ru[0], ARRAY_SIZE(dest->path.ru[0]),
-				     ARRAY_SIZE(dest->path.ru), val, len,
-				     target_power_combine, txs_delta);
+	mt76_apply_multi_array_limit(dev, dest->path.ru[0], ARRAY_SIZE(dest->path.ru[0]),
+				     ARRAY_SIZE(dest->path.ru), val, len, target_power,
+				     txs_delta, &max_power, n_chains, MT76_SKU_BACKOFF);
 
 	val = mt76_get_of_array_s8(np, "paths-ru-bf", &len, ARRAY_SIZE(dest->path.ru_bf[0]) + 1);
-	mt76_apply_multi_array_limit(dest->path.ru_bf[0], ARRAY_SIZE(dest->path.ru_bf[0]),
-				     ARRAY_SIZE(dest->path.ru_bf), val, len,
-				     target_power_combine, txs_delta);
+	mt76_apply_multi_array_limit(dev, dest->path.ru_bf[0], ARRAY_SIZE(dest->path.ru_bf[0]),
+				     ARRAY_SIZE(dest->path.ru_bf), val, len, target_power,
+				     txs_delta, &max_power, n_chains, MT76_SKU_BACKOFF);
 
 	return max_power;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1..32876eab2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -540,7 +540,6 @@ struct mt76_driver_ops {
 	u32 survey_flags;
 	u16 txwi_size;
 	u16 token_size;
-	u8 mcs_rates;
 
 	unsigned int link_data_size;
 
-- 
2.45.2


