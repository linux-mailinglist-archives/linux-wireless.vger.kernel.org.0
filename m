Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2964533B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 06:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGFEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 00:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLGFEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 00:04:32 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E05578F6
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 21:04:24 -0800 (PST)
X-UUID: 6cbae4ca48a640d1b851633008813ecf-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=o7OoWNo8IDDyIkIjBbQ7PqEoKoXgeup3PjLBOTDmnPs=;
        b=WBVK3vTUjvlQQdLnN+zSmUKkRyJwBeEA0fQnvyD3UN3BmQ6muDjka/8LEAaPvc4crTtA4/8lTVk1+skINSd01Q40pLcer2cxLOqrjyFYws+eDrDpAaneqPpmoSaMCgkAah8XCZRSpko+n8AHprh4aS5Wl1EYBZqNvCXQoYyBPW4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0f6696f5-03f1-46f9-97ae-6d58e68dfe56,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:2fceded1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6cbae4ca48a640d1b851633008813ecf-20221207
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1030520855; Wed, 07 Dec 2022 13:04:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:04:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:04:18 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: add support to update fw capability with MTFG table
Date:   Wed, 7 Dec 2022 13:03:41 +0800
Message-ID: <ef603fd5b6aa31e92cd45646d9a4db4fe30bc347.1670389254.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Quan Zhou <quan.zhou@mediatek.com>

In ACPI enabled devices, mt7921 should read MTFG table from platform
hardware. Apply necessary settings for firmware capabilities through CLC
command.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  | 55 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/acpi_sar.h  | 12 ++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  7 +++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
index 47e034a9b003..a98d0fb42d0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -135,6 +135,22 @@ mt7921_asar_acpi_read_mtgs(struct mt7921_dev *dev, u8 **table, u8 version)
 	return ret;
 }
 
+/* MTFG : Flag Table */
+static int
+mt7921_asar_acpi_read_mtfg(struct mt7921_dev *dev, u8 **table)
+{
+	int len, ret;
+
+	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTFG, table, &len);
+	if (ret)
+		return ret;
+
+	if (len < MT7921_ASAR_MIN_FG)
+		ret = -EINVAL;
+
+	return ret;
+}
+
 int mt7921_init_acpi_sar(struct mt7921_dev *dev)
 {
 	struct mt7921_acpi_sar *asar;
@@ -162,6 +178,12 @@ int mt7921_init_acpi_sar(struct mt7921_dev *dev)
 		asar->geo = NULL;
 	}
 
+	/* MTFG is optional */
+	ret = mt7921_asar_acpi_read_mtfg(dev, (u8 **)&asar->fg);
+	if (ret) {
+		devm_kfree(dev->mt76.dev, asar->fg);
+		asar->fg = NULL;
+	}
 	dev->phy.acpisar = asar;
 
 	return 0;
@@ -280,3 +302,36 @@ int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 
 	return 0;
 }
+
+u8 mt7921_acpi_get_flags(struct mt7921_phy *phy)
+{
+	struct mt7921_asar_fg *fg;
+	struct {
+		u8 acpi_idx;
+		u8 chip_idx;
+	} map[] = {
+		{1, 1},
+		{4, 2},
+	};
+	u8 flags = BIT(0);
+	int i, j;
+
+	if (!phy->acpisar)
+		return 0;
+
+	fg = phy->acpisar->fg;
+	if (!fg)
+		return flags;
+
+	/* pickup necessary settings per device and
+	 * translate the index of bitmap for chip command.
+	 */
+	for (i = 0; i < fg->nr_flag; i++)
+		for (j = 0; j < ARRAY_SIZE(map); j++)
+			if (fg->flag[i] == map[j].acpi_idx) {
+				flags |= BIT(map[j].chip_idx);
+				break;
+			}
+
+	return flags;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
index 23f86bfae0c0..35268b0890ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
@@ -8,10 +8,12 @@
 #define MT7921_ASAR_MAX_DYN		8
 #define MT7921_ASAR_MIN_GEO		3
 #define MT7921_ASAR_MAX_GEO		8
+#define MT7921_ASAR_MIN_FG		8
 
 #define MT7921_ACPI_MTCL		"MTCL"
 #define MT7921_ACPI_MTDS		"MTDS"
 #define MT7921_ACPI_MTGS		"MTGS"
+#define MT7921_ACPI_MTFG		"MTFG"
 
 struct mt7921_asar_dyn_limit {
 	u8 idx;
@@ -77,6 +79,15 @@ struct mt7921_asar_cl {
 	u8 cl6g[6];
 } __packed;
 
+struct mt7921_asar_fg {
+	u8 names[4];
+	u8 version;
+	u8 rsvd;
+	u8 nr_flag;
+	u8 rsvd1;
+	u8 flag[0];
+} __packed;
+
 struct mt7921_acpi_sar {
 	u8 ver;
 	union {
@@ -88,6 +99,7 @@ struct mt7921_acpi_sar {
 		struct mt7921_asar_geo_v2 *geo_v2;
 	};
 	struct mt7921_asar_cl *countrylist;
+	struct mt7921_asar_fg *fg;
 };
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index fb9c0f66cb27..8930b5a4467c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1184,13 +1184,15 @@ int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 		__le16 len;
 		u8 idx;
 		u8 env;
-		u8 pad1[2];
+		u8 acpi_conf;
+		u8 pad1;
 		u8 alpha2[2];
 		u8 type[2];
 		u8 rsvd[64];
 	} __packed req = {
 		.idx = idx,
 		.env = env_cap,
+		.acpi_conf = mt7921_acpi_get_flags(&dev->phy),
 	};
 	int ret, valid_cnt = 0;
 	u8 i, *pos;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 15d6b7fe1c6c..efff4d43d796 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -554,6 +554,7 @@ int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 #ifdef CONFIG_ACPI
 int mt7921_init_acpi_sar(struct mt7921_dev *dev);
 int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default);
+u8 mt7921_acpi_get_flags(struct mt7921_phy *phy);
 #else
 static inline int
 mt7921_init_acpi_sar(struct mt7921_dev *dev)
@@ -566,6 +567,12 @@ mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 {
 	return 0;
 }
+
+static inline u8
+mt7921_acpi_get_flags(struct mt7921_phy *phy)
+{
+	return 0;
+}
 #endif
 int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar);
-- 
2.18.0

