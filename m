Return-Path: <linux-wireless+bounces-31759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCCIFguYjWkt5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:06:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A949212BB9B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF96B302D5DB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07602DC35A;
	Thu, 12 Feb 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B0iipJlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D52D6E78
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887133; cv=none; b=OZnNSaNe8Xgr6TdfOWJ6Qy//zDwgpW9ToZNPZcLXrQBFw9DtD73AyKOQdnc6xmcCzi96d1nG0AsnxM9sz2aM3Euug5cRjGEx7P+2iTPT/rjX+OmjEmPzBxKsSorylAPJFY2HnFfZOCJzQSD2Nr7ZLRh2ihVmFLvVTCIX5trc62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887133; c=relaxed/simple;
	bh=7xrdYUpMGk/7fw0yMd/pq4IQdLwFS+QBRRzl6xvK+kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfMB09lKqrdOyovOY4Hvn1ka9RDjTFq0CU7MUfBglZ4Sqd9MtPEPNpAtbWg5jCpmlwUyUpBE0JMWu6DUyLMCnntAHX9IIHcC94OK5YgF/6h6uOoeieOgJ6/XwajGWPYgPWSiBsEcs7piNt+mM5kxSbKmEN2W22cqi4CP+x7R/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B0iipJlQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f80f575007f111f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KjTmETYJMhUFu0ND6fypPajx5WjMpMrsjrQAH65vI54=;
	b=B0iipJlQgWUM93xXm8EsRad1i385QlFkxKFG3+QDbJa6ocVuhErmPnjG22mRjfAw8n+p+fpsuu5wW7GyC3D7vi7fOxheDALpL/jvf1xm0NfNtoI1yH9FvBW+H0DUPmD5Cyqrlei5Lhm6gncx/kVJOST4uTX+BAu51CKK87uO4Kw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:3e926c45-eeb1-45b7-b5bc-5f25a95e591d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:489b9ae9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f80f575007f111f185319dbc3099e8fb-20260212
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1760368200; Thu, 12 Feb 2026 17:05:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 17:05:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 17:05:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 3/3] wifi: mt76: mt7996: apply calibration-free data from OTP
Date: Thu, 12 Feb 2026 17:03:10 +0800
Message-ID: <20260212090310.3335392-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260212090310.3335392-1-shayne.chen@mediatek.com>
References: <20260212090310.3335392-1-shayne.chen@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31759-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:mid,mediatek.com:dkim,mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A949212BB9B
X-Rspamd-Action: no action

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Before sending the current EEPROM data to the firmware, read the
calibration-free data (FT data) from the efuse and merge it with
the existing EEPROM data.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 171 ++++++++++++++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   5 +
 2 files changed, 157 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 98db3bcf76f0..4cac1f7dd597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3948,7 +3948,152 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 				 &req, sizeof(req), true);
 }
 
-static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
+static int
+mt7996_mcu_get_cal_free_data(struct mt7996_dev *dev)
+{
+#define MT_EE_7977BN_OFFSET	(0x1200 - 0x500)
+	struct cal_free_data {
+		u16 adie_offs;
+		u16 eep_offs;
+	};
+	static const struct cal_free_data cal_7975[] = {
+		{ 0x5cd, 0x451 }, { 0x5cf, 0x453 }, { 0x5d1, 0x455 },
+		{ 0x5d3, 0x457 }, { 0x6c0, 0x44c }, { 0x6c1, 0x44d },
+		{ 0x6c2, 0x44e }, { 0x6c3, 0x44f }, { 0x7a1, 0xba1 },
+		{ 0x7a6, 0xba6 }, { 0x7a8, 0xba8 }, { 0x7aa, 0xbaa },
+	};
+	static const struct cal_free_data cal_7976[] = {
+		{  0x4c, 0x44c }, {  0x4d, 0x44d }, {  0x4e, 0x44e },
+		{  0x4f, 0x44f }, {  0x50, 0x450 }, {  0x51, 0x451 },
+		{  0x53, 0x453 }, {  0x55, 0x455 }, {  0x57, 0x457 },
+		{  0x59, 0x459 }, {  0x70, 0x470 }, {  0x71, 0x471 },
+		{ 0x790, 0xb90 }, { 0x791, 0xb91 }, { 0x794, 0xb94 },
+		{ 0x795, 0xb95 }, { 0x7a6, 0xba6 }, { 0x7a8, 0xba8 },
+		{ 0x7aa, 0xbaa },
+	};
+	static const struct cal_free_data cal_7977[] = {
+		{ 0x4c, 0x124c }, { 0x4d, 0x124d }, { 0x4e, 0x124e },
+		{ 0x4f, 0x124f }, { 0x50, 0x1250 }, { 0x51, 0x1251 },
+		{ 0x53, 0x1253 }, { 0x55, 0x1255 }, { 0x57, 0x1257 },
+		{ 0x59, 0x1259 }, { 0x69, 0x1269 }, { 0x6a, 0x126a },
+		{ 0x7a, 0x127a }, { 0x7b, 0x127b }, { 0x7c, 0x127c },
+		{ 0x7d, 0x127d }, { 0x7e, 0x127e },
+	};
+	static const struct cal_free_data cal_7978[] = {
+		{  0x91, 0xb91 }, {  0x95, 0xb95 }, { 0x100, 0x480 },
+		{ 0x102, 0x482 }, { 0x104, 0x484 }, { 0x106, 0x486 },
+		{ 0x107, 0x487 }, { 0x108, 0x488 }, { 0x109, 0x489 },
+		{ 0x10a, 0x48a }, { 0x10b, 0x48b }, { 0x10c, 0x48c },
+		{ 0x10e, 0x48e }, { 0x110, 0x490 },
+	};
+	static const struct cal_free_data cal_7979[] = {
+		{ 0x4c, 0x124c }, { 0x4d, 0x124d }, { 0x4e, 0x124e },
+		{ 0x4f, 0x124f }, { 0x50, 0x1250 }, { 0x51, 0x1251 },
+		{ 0x53, 0x1253 }, { 0x55, 0x1255 }, { 0x57, 0x1257 },
+		{ 0x59, 0x1259 }, { 0x69, 0x1269 }, { 0x6a, 0x126a },
+		{ 0x7a, 0x127a }, { 0x7b, 0x127b }, { 0x7c, 0x127c },
+		{ 0x7e, 0x127e }, { 0x80, 0x1280 },
+	};
+	const struct cal_free_data *cal_arr[__MT_MAX_BAND];
+	u16 cal_arr_len[__MT_MAX_BAND] = {};
+	u8 *eeprom = (u8 *)dev->mt76.eeprom.data;
+	int band, i, ret;
+
+#define CAL_ARR(_band, _adie) do {				\
+		cal_arr[_band] = cal_##_adie;			\
+		cal_arr_len[_band] = ARRAY_SIZE(cal_##_adie);	\
+	} while (0)
+
+	switch (mt76_chip(&dev->mt76)) {
+	case MT7996_DEVICE_ID:
+		/* adie 0 */
+		if (dev->var.fem == MT7996_FEM_INT &&
+		    dev->var.type != MT7996_VAR_TYPE_233)
+			CAL_ARR(0, 7975);
+		else
+			CAL_ARR(0, 7976);
+
+		/* adie 1 */
+		if (dev->var.type == MT7996_VAR_TYPE_444)
+			CAL_ARR(1, 7977);
+
+		/* adie 2 */
+		CAL_ARR(2, 7977);
+		break;
+	case MT7992_DEVICE_ID:
+		/* adie 0 */
+		if (dev->var.type == MT7992_VAR_TYPE_44 &&
+		    dev->var.fem != MT7996_FEM_EXT)
+			CAL_ARR(0, 7975);
+		else if (dev->var.type == MT7992_VAR_TYPE_24)
+			CAL_ARR(0, 7978);
+		else
+			CAL_ARR(0, 7976);
+
+		/* adie 1 */
+		if (dev->var.type == MT7992_VAR_TYPE_44 &&
+		    dev->var.fem != MT7996_FEM_INT)
+			CAL_ARR(1, 7977);
+		else if (dev->var.type != MT7992_VAR_TYPE_23)
+			CAL_ARR(1, 7979);
+		break;
+	case MT7990_DEVICE_ID:
+		/* adie 0 */
+		CAL_ARR(0, 7976);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (band = 0; band < __MT_MAX_BAND; band++) {
+		const struct cal_free_data *cal;
+		u16 prev_block_idx = -1;
+		u16 adie_base;
+
+		if (!cal_arr_len[band])
+			continue;
+
+		if (band == MT_BAND0)
+			adie_base = MT7996_EFUSE_BASE_OFFS_ADIE0;
+		else if (band == MT_BAND1 && is_mt7992(&dev->mt76))
+			adie_base = MT7992_EFUSE_BASE_OFFS_ADIE1;
+		else if (band == MT_BAND1)
+			adie_base = MT7996_EFUSE_BASE_OFFS_ADIE1;
+		else
+			adie_base = MT7996_EFUSE_BASE_OFFS_ADIE2;
+
+		cal = cal_arr[band];
+		for (i = 0; i < cal_arr_len[band]; i++) {
+			u16 adie_offset = cal[i].adie_offs + adie_base;
+			u16 eep_offset = cal[i].eep_offs;
+			u16 block_idx = adie_offset / MT7996_EEPROM_BLOCK_SIZE;
+			u16 offset = adie_offset % MT7996_EEPROM_BLOCK_SIZE;
+			u8 buf[MT7996_EEPROM_BLOCK_SIZE];
+
+			if (is_mt7996(&dev->mt76) && band == MT_BAND1 &&
+			    dev->var.type == MT7996_VAR_TYPE_444)
+				eep_offset -= MT_EE_7977BN_OFFSET;
+
+			if (prev_block_idx != block_idx) {
+				ret = mt7996_mcu_get_eeprom(dev, adie_offset, buf,
+							    MT7996_EEPROM_BLOCK_SIZE,
+							    EEPROM_MODE_EFUSE);
+				if (ret) {
+					if (ret != -EINVAL)
+						return ret;
+					prev_block_idx = -1;
+					continue;
+				}
+			}
+			eeprom[eep_offset] = buf[offset];
+			prev_block_idx = block_idx;
+		}
+	}
+
+	return 0;
+}
+
+int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
 {
 #define MAX_PAGE_IDX_MASK	GENMASK(7, 5)
 #define PAGE_IDX_MASK		GENMASK(4, 2)
@@ -3960,11 +4105,15 @@ static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
 	u16 eeprom_size = MT7996_EEPROM_SIZE;
 	u8 total = DIV_ROUND_UP(eeprom_size, PER_PAGE_SIZE);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
-	int eep_len, i;
+	int ret, eep_len, i;
+
+	ret = mt7996_mcu_get_cal_free_data(dev);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < total; i++, eep += eep_len) {
 		struct sk_buff *skb;
-		int ret, msg_len;
+		int msg_len;
 
 		if (i == total - 1 && !!(eeprom_size % PER_PAGE_SIZE))
 			eep_len = eeprom_size % PER_PAGE_SIZE;
@@ -3993,22 +4142,6 @@ static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
 	return 0;
 }
 
-int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
-{
-	struct mt7996_mcu_eeprom_update req = {
-		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
-		.len = cpu_to_le16(sizeof(req) - 4),
-		.buffer_mode = EE_MODE_EFUSE,
-		.format = EE_FORMAT_WHOLE
-	};
-
-	if (dev->eeprom_mode != EEPROM_MODE_EFUSE)
-		return mt7996_mcu_set_eeprom_flash(dev);
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(EFUSE_CTRL),
-				 &req, sizeof(req), true);
-}
-
 int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len,
 			  enum mt7996_eeprom_mode mode)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d36fb5396141..5f574ebe81cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -184,6 +184,11 @@ enum mt7996_eeprom_mode {
 	EEPROM_MODE_EXT,
 };
 
+#define MT7996_EFUSE_BASE_OFFS_ADIE0	0x400
+#define MT7996_EFUSE_BASE_OFFS_ADIE1	0x1e00
+#define MT7996_EFUSE_BASE_OFFS_ADIE2	0x1200
+#define MT7992_EFUSE_BASE_OFFS_ADIE1	0x1200
+
 enum mt7996_txq_id {
 	MT7996_TXQ_FWDL = 16,
 	MT7996_TXQ_MCU_WM,
-- 
2.51.0


