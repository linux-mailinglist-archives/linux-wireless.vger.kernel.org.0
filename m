Return-Path: <linux-wireless+bounces-19468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A5A4577C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A721883176
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBD272916;
	Wed, 26 Feb 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PiHE+7fx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946C26D5D4
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556336; cv=none; b=rj1rAApzTxCberLUcbrHZ0Nc+mszCbahhNsRUQ1o5fNnfbadD10oqX21NqDLGrdK5D5l+rMAiA8h2wub+v4fHDXq5z5YfzhXciVu2e+2wLwmsKBYBtM870dxqsg5qjElE23y6/LCnIhiIvpjc58GLjDDPlOvKHzgFqgOfJOaPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556336; c=relaxed/simple;
	bh=tyTiVhmZWdwHlTIY97OWogqyrJB3mMhT+TLVt410evg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lj/ON/AbPGmsYLFjrJ09FQ8DW3HmEZU+1v4ad3EB8XXUWsLfG31yhJVd9fMyDaC6a7CONzOI45IpGRUSVq/tZ4+Uu7PQt3euqxatB+N9F02LgpL/57IUG/ETqSP/9gfbY5pk+m/q3YEWN5Aw1CPXL3w3S2C51emUosdSOw6SIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PiHE+7fx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b7bc1ccf41611ef8eb9c36241bbb6fb-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fnTZ1El0ViezYZhX0y1GgcahNGMvGwSHN3Zs0p9nxeg=;
	b=PiHE+7fxJMjE+n01oG+6gU21kbRI+H3J83UPGg/ABd/+AQR1XDY8eA4L++b207pKL+nFNBdfzhNzDS9YJoZ034oi0qAOOWLQ7IRvxRWVbI7vEF+GwCyryvZGzBLxLPqk3tPHWN6gMQBK72BbLEY8u+z5vuBui32MojFfg/OLZZc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:5e656bac-6829-41db-b5a7-0f61c4738208,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:d3d898b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b7bc1ccf41611ef8eb9c36241bbb6fb-20250226
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2448773; Wed, 26 Feb 2025 15:51:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 15:51:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 15:51:52 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 5/6] wifi: mt76: mt792x: extend MTCL of APCI to version3 for EHT control
Date: Wed, 26 Feb 2025 15:51:22 +0800
Message-ID: <20250226075123.3981253-5-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226075123.3981253-1-mingyen.hsieh@mediatek.com>
References: <20250226075123.3981253-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

This patch introduces version 3 of the MTCL table, which provides
regulatory information for WiFi 7. It also configured by the platform
vender like the version 1 and 2.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 +-
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 98 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt792x_acpi_sar.h  | 40 +++++++-
 3 files changed, 117 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 85f07f936be5..d43e5d93dd85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -525,7 +525,7 @@ int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
 int mt792x_init_acpi_sar(struct mt792x_dev *dev);
 int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
 u8 mt792x_acpi_get_flags(struct mt792x_phy *phy);
-u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2);
+u32 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2);
 #else
 static inline int mt792x_init_acpi_sar(struct mt792x_dev *dev)
 {
@@ -543,9 +543,9 @@ static inline u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
 	return 0;
 }
 
-static inline u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
+static inline u32 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
 {
-	return 0xf;
+	return MT792X_ACPI_MTCL_INVALID;
 }
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index 9317f8ff2070..f76f4633c415 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -66,13 +66,22 @@ mt792x_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 }
 
 /* MTCL : Country List Table for 6G band */
+/* MTCL : Country List Table for 6G band and 11BE */
 static int
 mt792x_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
 {
-	int ret;
+	int len, ret;
 
-	*version = ((ret = mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL)) < 0)
-		   ? 1 : 2;
+	ret = mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, &len);
+	if (ret)
+		return ret;
+
+	if (len == sizeof(struct mt792x_asar_cl))
+		*version = ((struct mt792x_asar_cl *)*table)->version;
+	else if (len == sizeof(struct mt792x_asar_cl_v3))
+		*version = ((struct mt792x_asar_cl_v3 *)*table)->version;
+	else
+		return -EINVAL;
 
 	return ret;
 }
@@ -351,10 +360,24 @@ u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt792x_acpi_get_flags);
 
-static u8
+static u32
+mt792x_acpi_get_mtcl_map_v3(int row, int column, struct mt792x_asar_cl_v3 *cl)
+{
+	u32 config = 0;
+	u8 mode_be = 0;
+
+	mode_be = (cl->mode_be > 0x02) ? 0 : cl->mode_be;
+
+	if (cl->version > 2 && cl->clbe[row] & BIT(column))
+		config |= (mode_be & 0x3) << 4;
+
+	return config;
+}
+
+static u32
 mt792x_acpi_get_mtcl_map(int row, int column, struct mt792x_asar_cl *cl)
 {
-	u8 config = 0;
+	u32 config = 0;
 	u8 mode_6g, mode_5g9;
 
 	mode_6g = (cl->mode_6g > 0x02) ? 0 : cl->mode_6g;
@@ -368,30 +391,40 @@ mt792x_acpi_get_mtcl_map(int row, int column, struct mt792x_asar_cl *cl)
 	return config;
 }
 
-u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
+static u32
+mt792x_acpi_parse_mtcl_tbl_v3(struct mt792x_phy *phy, char *alpha2)
 {
-	static const char * const cc_list_all[] = {
-		"00", "EU", "AR", "AU", "AZ", "BY", "BO", "BR",
-		"CA", "CL", "CN", "ID", "JP", "MY", "MX", "ME",
-		"MA", "NZ", "NG", "PH", "RU", "RS", "SG", "KR",
-		"TW", "TH", "UA", "GB", "US", "VN", "KH", "PY",
-	};
-	static const char * const cc_list_eu[] = {
-		"AT", "BE", "BG", "CY", "CZ", "HR", "DK", "EE",
-		"FI", "FR", "DE", "GR", "HU", "IS", "IE", "IT",
-		"LV", "LI", "LT", "LU", "MT", "NL", "NO", "PL",
-		"PT", "RO", "SK", "SI", "ES", "SE", "CH",
-	};
 	struct mt792x_acpi_sar *sar = phy->acpisar;
-	struct mt792x_asar_cl *cl;
+	struct mt792x_asar_cl_v3 *cl = sar->countrylist_v3;
 	int col, row, i;
 
-	if (!sar)
-		return 0xf;
+	if (!cl)
+		return MT792X_ACPI_MTCL_INVALID;
+
+	for (i = 0; i < ARRAY_SIZE(cc_list_be); i++) {
+		col = 7 - i % 8;
+		row = i / 8;
+		if (!memcmp(cc_list_be[i], alpha2, 2))
+			return mt792x_acpi_get_mtcl_map_v3(row, col, cl);
+	}
+	for (i = 0; i < ARRAY_SIZE(cc_list_eu); i++) {
+		if (!memcmp(cc_list_eu[i], alpha2, 2))
+			return mt792x_acpi_get_mtcl_map_v3(3, 7, cl);
+	}
+
+	/* Depends on driver */
+	return 0x20;
+}
+
+static u32
+mt792x_acpi_parse_mtcl_tbl(struct mt792x_phy *phy, char *alpha2)
+{
+	struct mt792x_acpi_sar *sar = phy->acpisar;
+	struct mt792x_asar_cl *cl = sar->countrylist;
+	int col, row, i;
 
-	cl = sar->countrylist;
 	if (!cl)
-		return 0xc;
+		return MT792X_ACPI_MTCL_INVALID;
 
 	for (i = 0; i < ARRAY_SIZE(cc_list_all); i++) {
 		col = 7 - i % 8;
@@ -406,4 +439,23 @@ u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
 
 	return mt792x_acpi_get_mtcl_map(0, 7, cl);
 }
+
+u32 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
+{
+	struct mt792x_acpi_sar *sar = phy->acpisar;
+	u32 config = 0;
+
+	if (!sar)
+		return MT792X_ACPI_MTCL_INVALID;
+
+	if (sar->ver == 3)
+		config |= mt792x_acpi_parse_mtcl_tbl_v3(phy, alpha2);
+
+	if (config == MT792X_ACPI_MTCL_INVALID)
+		return MT792X_ACPI_MTCL_INVALID;
+
+	config |= mt792x_acpi_parse_mtcl_tbl(phy, alpha2);
+
+	return config;
+}
 EXPORT_SYMBOL_GPL(mt792x_acpi_get_mtcl_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
index 2298983b6342..cf15571dcb82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
@@ -15,6 +15,30 @@
 #define MT792x_ACPI_MTGS		"MTGS"
 #define MT792x_ACPI_MTFG		"MTFG"
 
+#define MT792X_ACPI_MTCL_INVALID	0xffffffff
+
+static const char * const cc_list_all[] = {
+	"00", "EU", "AR", "AU", "AZ", "BY", "BO", "BR",
+	"CA", "CL", "CN", "ID", "JP", "MY", "MX", "ME",
+	"MA", "NZ", "NG", "PH", "RU", "RS", "SG", "KR",
+	"TW", "TH", "UA", "GB", "US", "VN", "KH", "PY",
+};
+
+static const char * const cc_list_eu[] = {
+	"AD", "AT", "BE", "BG", "CY", "CZ", "HR", "DK",
+	"EE", "FI", "FR", "DE", "GR", "HU", "IS", "IE",
+	"IT", "LV", "LI", "LT", "LU", "MC", "MT", "NL",
+	"NO", "PL", "PT", "RO", "SK", "SI", "ES", "SE",
+	"CH",
+};
+
+static const char * const cc_list_be[] = {
+	"AR", "BR", "BY", "CL", "IQ", "MX", "OM", "RU",
+	"RW", "VN", "KR", "UA", "", "", "", "",
+	"EU", "AT", "CN", "CA", "TW", "NZ", "PH", "UK",
+	"US",
+};
+
 struct mt792x_asar_dyn_limit {
 	u8 idx;
 	u8 frp[5];
@@ -72,6 +96,17 @@ struct mt792x_asar_geo_v2 {
 	DECLARE_FLEX_ARRAY(struct mt792x_asar_geo_limit_v2, tbl);
 } __packed;
 
+struct mt792x_asar_cl_v3 {
+	u8 names[4];
+	u8 version;
+	u8 mode_6g;
+	u8 cl6g[6];
+	u8 mode_5g9;
+	u8 cl5g9[6];
+	u8 mode_be;
+	u8 clbe[6];
+} __packed;
+
 struct mt792x_asar_cl {
 	u8 names[4];
 	u8 version;
@@ -100,7 +135,10 @@ struct mt792x_acpi_sar {
 		struct mt792x_asar_geo *geo;
 		struct mt792x_asar_geo_v2 *geo_v2;
 	};
-	struct mt792x_asar_cl *countrylist;
+	union {
+		struct mt792x_asar_cl *countrylist;
+		struct mt792x_asar_cl_v3 *countrylist_v3;
+	};
 	struct mt792x_asar_fg *fg;
 };
 
-- 
2.34.1


