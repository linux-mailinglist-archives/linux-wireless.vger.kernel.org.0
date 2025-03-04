Return-Path: <linux-wireless+bounces-19757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC9A4DCBA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EC83AE957
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF462010F5;
	Tue,  4 Mar 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hSEwW6b8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EB1FF1A2
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088223; cv=none; b=AyrZmRTtDkfjby++uvX3G9b4YBf38lkeBi34a9s2s2yAyUlfl8qJ5p+t+ypOFeHlIVtuSNkabnpemix1X5lxY3pTNYFqYGno7B7CbwlDR4EJGdK8O3PSJ80a2Fr+t7+Nx8O25MqAx24Bgu8xmF3W1svPeCI06JNt9vhfz1gFa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088223; c=relaxed/simple;
	bh=Wi1WQG8glaK+/Xm3iYArQAJf3uo8nUcKAYHXucg5sW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm5XI7G8BfqXYjS7FMak2cZRnuwq9mmF82c3ad2+wG/dwkT9BpdRGJg4sysrerlvxeieZi1uNA/JEzbVXm5GeqaRcoRE34FY9Prvn4V3sinF6w2MmhYF7SHg99vvpWC6VKZCjjV5gsre6IGhgYFiC6Kr3P3xYMVW5SYkpyAgF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hSEwW6b8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f944d11ef8ec11efaae1fd9735fae912-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8CkVOGsViraPUR6VZXEC31lxxEzKLMi8gILVs2eDvk0=;
	b=hSEwW6b8f1PdEsu3O4uqJeESwYbLGO34PGxP18vOL+R9YmCKuZ/peaHJr0Vzij8w1F/KIAO5Sy5z/eO1pHkKTeO2Curba3MVZPrOl+hYi4hBoNvdHzW8sqf5ZjWLXn0NSz6+/V6Lh3/aSPxqBzvSitLo016LlnpwLjpmodbtIpo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:aa51bd78-77ca-4795-af20-001fbaf12b06,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:a823d5b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f944d11ef8ec11efaae1fd9735fae912-20250304
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1253339189; Tue, 04 Mar 2025 19:36:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Mar 2025 19:36:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 4 Mar 2025 19:36:53 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v3 5/6] wifi: mt76: mt792x: extend MTCL of APCI to version3 for EHT control
Date: Tue, 4 Mar 2025 19:36:48 +0800
Message-ID: <20250304113649.867387-5-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304113649.867387-1-mingyen.hsieh@mediatek.com>
References: <20250304113649.867387-1-mingyen.hsieh@mediatek.com>
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
v2: mt792x_acpi_parse_mtcl_tbl_v3 should return the config of
    "depends on driver" when bios support mtcl v2 only
v3: no change
---
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   6 +-
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 101 ++++++++++++++----
 .../wireless/mediatek/mt76/mt792x_acpi_sar.h  |  40 ++++++-
 3 files changed, 120 insertions(+), 27 deletions(-)

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
index 9317f8ff2070..fac53e62687b 100644
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
@@ -368,30 +391,44 @@ mt792x_acpi_get_mtcl_map(int row, int column, struct mt792x_asar_cl *cl)
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
+	if (sar->ver != 3)
+		goto out;
+
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
+out:
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
@@ -406,4 +443,22 @@ u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
 
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
+	config = mt792x_acpi_parse_mtcl_tbl_v3(phy, alpha2);
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


