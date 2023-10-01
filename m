Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84DC7B4847
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Oct 2023 17:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjJAPCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Oct 2023 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJAPCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Oct 2023 11:02:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812ADD9
        for <linux-wireless@vger.kernel.org>; Sun,  1 Oct 2023 08:02:37 -0700 (PDT)
X-UUID: 8c36485c606b11eea33bb35ae8d461a2-20231001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4xvXMhEn645NdduosmllxK/n6ctlm3Z6N2Vg1MNZPg0=;
        b=CbX0MbnCF5ENF6jtCV6RZldSmvTMdHHTX8KYyMbh9SG4EF2kd4/vol4WAVLl0zDr+74nqW0PvjVQnokka3vZv7ATlrRGaGZE2n7FpvsLAoZE/gLmVo24SBnnTXr0ke2EOn+2H3G57ORpFLaFS/1UQia0quBEZpZU8GzmjA/GpWM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:24a0d075-33b2-4f52-ab03-f42d3b38c260,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:cb3551f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c36485c606b11eea33bb35ae8d461a2-20231001
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 983621090; Sun, 01 Oct 2023 23:02:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 1 Oct 2023 23:02:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 1 Oct 2023 23:02:30 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Rong Yan <rong.yan@mediatek.com>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH v3] wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi
Date:   Sun, 1 Oct 2023 23:02:05 +0800
Message-ID: <6cfde22e0b44088297f98342147fc8af108e3a6f.1696171289.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.777700-8.000000
X-TMASE-MatchedRID: clfRPwBsujCy9Uh/U28aL/havVZP5tTaGSqdEmeD/nWdCqKtxM6bh79l
        zKzQm5bId0paDT2HaWx+dfwnt/TnE8637+A5hpnFKaMQ6tw7oDJV12TtAZAdp0PL6pqegFS6MkO
        ne4r2fxbObbfp8Bdqbr4tP830vR4A8P7w+kOuIIHuykw7cfAoIIv8pidhVYOUXE5Co/aUb2CjxY
        yRBa/qJcFwgTvxipFa9xS3mVzWUuAojN1lLei7RQtfZqxTW7b5Cg+ktjRaS4balOFEhR+8KeSVl
        xny2FCurX7TAzzz/k05yIDNVQ9lfh0UgksJEjYbxu52HMP5itmQeUSAyN9CmnmVKZusLp922v9O
        jYWA2uMMswg45VMfPXY3pGDmoik6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.777700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0E3AE22A08B15684368F1B371245A5DD77C8852737B9A5BE082E2057A3FC85652000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rong Yan <rong.yan@mediatek.com>

The mtcl table, configured by platform vendor, provides regulatory
information for 5.9/6 GHz channels. mt792x should work on
corresponding channels supported by mtcl. This patch would parse
the settings in mtcl table and apply the result into chip side.

Signed-off-by: Rong Yan <rong.yan@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v3: update the format of author's name to avoid this patch missing in wireless patchwork
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 +++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 53 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.h  |  2 +
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 63f3d4a5c9aa..94fc3eb40234 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1260,12 +1260,14 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 alpha2[2];
 		u8 type[2];
 		u8 env_6g;
-		u8 rsvd[63];
+		u8 mtcl_conf;
+		u8 rsvd[62];
 	} __packed req = {
 		.idx = idx,
 		.env = env_cap,
 		.env_6g = dev->phy.power_type,
 		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
+		.mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
 	};
 	int ret, valid_cnt = 0;
 	u8 i, *pos;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 36fae736dd19..3c897b34aaa7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -382,6 +382,7 @@ int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
 int mt792x_init_acpi_sar(struct mt792x_dev *dev);
 int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
 u8 mt792x_acpi_get_flags(struct mt792x_phy *phy);
+u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2);
 #else
 static inline int mt792x_init_acpi_sar(struct mt792x_dev *dev)
 {
@@ -398,6 +399,11 @@ static inline u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
 {
 	return 0;
 }
+
+static inline u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
+{
+	return 0xf;
+}
 #endif
 
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index 303c0f5c9c66..e7afea87e82e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -348,3 +348,56 @@ u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
 	return flags;
 }
 EXPORT_SYMBOL_GPL(mt792x_acpi_get_flags);
+
+static u8
+mt792x_acpi_get_mtcl_map(int row, int column, struct mt792x_asar_cl *cl)
+{
+	u8 config = 0;
+
+	if (cl->cl6g[row] & BIT(column))
+		config |= (cl->mode_6g & 0x3) << 2;
+	if (cl->version > 1 && cl->cl5g9[row] & BIT(column))
+		config |= (cl->mode_5g9 & 0x3);
+
+	return config;
+}
+
+u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
+{
+	static const char * const cc_list_all[] = {
+		"00", "EU", "AR", "AU", "AZ", "BY", "BO", "BR",
+		"CA", "CL", "CN", "ID", "JP", "MY", "MX", "ME",
+		"MA", "NZ", "NG", "PH", "RU", "RS", "SG", "KR",
+		"TW", "TH", "UA", "GB", "US", "VN", "KH", "PY",
+	};
+	static const char * const cc_list_eu[] = {
+		"AT", "BE", "BG", "CY", "CZ", "HR", "DK", "EE",
+		"FI", "FR", "DE", "GR", "HU", "IS", "IE", "IT",
+		"LV", "LI", "LT", "LU", "MT", "NL", "NO", "PL",
+		"PT", "RO", "MT", "SK", "SI", "ES", "CH",
+	};
+	struct mt792x_acpi_sar *sar = phy->acpisar;
+	struct mt792x_asar_cl *cl;
+	int col, row, i;
+
+	if (!sar)
+		return 0xf;
+
+	cl = sar->countrylist;
+	if (!cl)
+		return 0xc;
+
+	for (i = 0; i < ARRAY_SIZE(cc_list_all); i++) {
+		col = 7 - i % 8;
+		row = i / 8;
+		if (!memcmp(cc_list_all[i], alpha2, 2))
+			return mt792x_acpi_get_mtcl_map(row, col, cl);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cc_list_eu); i++)
+		if (!memcmp(cc_list_eu[i], alpha2, 2))
+			return mt792x_acpi_get_mtcl_map(0, 6, cl);
+
+	return mt792x_acpi_get_mtcl_map(0, 7, cl);
+}
+EXPORT_SYMBOL_GPL(mt792x_acpi_get_mtcl_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
index d6d332e863ba..2298983b6342 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
@@ -77,6 +77,8 @@ struct mt792x_asar_cl {
 	u8 version;
 	u8 mode_6g;
 	u8 cl6g[6];
+	u8 mode_5g9;
+	u8 cl5g9[6];
 } __packed;
 
 struct mt792x_asar_fg {
-- 
2.18.0

