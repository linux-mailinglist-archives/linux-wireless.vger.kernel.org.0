Return-Path: <linux-wireless+bounces-19463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E5A45753
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719A71701E5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A83258CFF;
	Wed, 26 Feb 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d8VGNFPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BE258CFC
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556322; cv=none; b=TocP86wr6CP5xO1sTT56a/wddKP1s3XdxIqDfMXaJU7RTBoGCWquVkCwP/WwYBE/VRQY09C0F62fSl+bS//9qfrM19rI73ub6Fy0b4W5q9Y9hx51krSxZfRfT4xY0iCrEfptvuns9VaJrUb0a6rF5B1K4ghhE9XBkLPvhqqDt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556322; c=relaxed/simple;
	bh=Eepca2P06xBJBv3Qt7cEVHdGXMSQvL6Mb7jHOk4A2dY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raewDGVJmK+q5PHNnJia8tIfwoqRo9iTUZTMYmFEb6Yr/5O61iHYxUJmaxptgSEAjF4jHeI+JX/clW0hsJJckeRv9myibAOB4KIVwz/hek+mdeXx0W1Yu318iN3qjbFGpEl8YhzjCuejJOFnSOLE1H8ar8RzajpsnrJmosR/Dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d8VGNFPa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b211560f41611efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OAU9acRw7UU8O8CH8C3J5uw+2DS0q96HbbH+dTRr45U=;
	b=d8VGNFPaRS83VAkQU8TXDFXWeYYCwsPUNYVCtJ/aGC3IHzHm1s7u2eKbUysiW70z7/UksxmSVWbIUaWyYjkRyU7rOrbn1kPtPZ9cgu+qX7bCoeQUq/lAoFIrybcu3pS4RjCrxXFRNvK4SgGfR2as946kn6/PgSFqu3bX0Yjy2ic=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2a80e1f7-748d-4a09-9fb2-d2646fd4d5c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:21af93a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b211560f41611efaae1fd9735fae912-20250226
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1134938218; Wed, 26 Feb 2025 15:51:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH 2/6] wifi: mt76: mt7925: add EHT control support based on the CLC data
Date: Wed, 26 Feb 2025 15:51:19 +0800
Message-ID: <20250226075123.3981253-2-mingyen.hsieh@mediatek.com>
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

Some countries do not support EHT modulation for now. To prevent violating
regulations, the MT7925 chipset should control the EHT capabilities.
Therefore, when a regulatory domain change is detected during scanning,
the `mt7925_regd_be_ctrl` will process the CLC data to update the EHT
capabilities.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 38 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 10 +++--
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 27 +++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 5 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index b40d979f1b65..94d7b762fe40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -58,6 +58,44 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
 	return PTR_ERR_OR_ZERO(hwmon);
 }
 
+void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
+{
+	struct mt792x_phy *phy = &dev->phy;
+	struct mt7925_clc_rule_v2 *rule;
+	struct mt7925_clc *clc;
+	bool old = dev->has_eht, new = true;
+	u8 *pos;
+
+	if (!phy->clc[MT792x_CLC_BE_CTRL])
+		goto out;
+
+	clc = (struct mt7925_clc *)phy->clc[MT792x_CLC_BE_CTRL];
+	pos = clc->data;
+
+	while (1) {
+		rule = (struct mt7925_clc_rule_v2 *)pos;
+
+		if (rule->alpha2[0] == alpha2[0] &&
+		    rule->alpha2[1] == alpha2[1]) {
+			new = false;
+			break;
+		}
+
+		/* Check the last one */
+		if (rule->flag && BIT(0))
+			break;
+
+		pos += sizeof(*rule);
+	}
+
+out:
+	if (old == new)
+		return;
+
+	dev->has_eht = new;
+	mt7925_set_stream_he_eht_caps(phy);
+}
+
 void mt7925_regd_update(struct mt792x_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index cefb9068fa72..80aa7f329cf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1449,6 +1449,9 @@ void mt7925_scan_work(struct work_struct *work)
 				if (!is_valid_alpha2(evt->alpha2))
 					break;
 
+				if (memcmp(evt->alpha2, mdev->alpha2, 2))
+					mt7925_regd_be_ctrl(phy->dev, evt->alpha2);
+
 				if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
 					break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 505a6467f147..e73320c5d8c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -915,7 +915,9 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 			continue;
 
 		/* header content sanity */
-		if (u8_get_bits(clc->type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
+		if ((clc->idx == MT792x_CLC_BE_CTRL &&
+		     u8_get_bits(clc->t2.type, MT_EE_HW_TYPE_ENCAP) != hw_encap) ||
+		    u8_get_bits(clc->t0.type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
 			continue;
 
 		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
@@ -1024,7 +1026,6 @@ mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
 	mdev->phy.chainmask = mdev->phy.antenna_mask;
 	mdev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
 	mdev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
-	dev->has_eht = cap->eht;
 }
 
 static void
@@ -3427,7 +3428,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (!clc)
 		return 0;
 
-	pos = clc->data + sizeof(*seg) * clc->nr_seg;
+	pos = clc->data + sizeof(*seg) * clc->t0.nr_seg;
 	last_pos = clc->data + le32_to_cpu(*(__le32 *)(clc->data + 4));
 	while (pos < last_pos) {
 		struct mt7925_clc_rule *rule = (struct mt7925_clc_rule *)pos;
@@ -3473,6 +3474,9 @@ int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 
 	/* submit all clc config */
 	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		if (i == MT792x_CLC_BE_CTRL)
+			continue;
+
 		ret = __mt7925_mcu_set_clc(dev, alpha2, env_cap,
 					   phy->clc[i], i);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index abecaf897159..e6ca9021f487 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -137,6 +137,12 @@ enum {
 	MT7925_CLC_MAX_NUM,
 };
 
+struct mt7925_clc_rule_v2 {
+	u32 flag;
+	u8 alpha2[2];
+	u8 rsv[10];
+} __packed;
+
 struct mt7925_clc_rule {
 	u8 alpha2[2];
 	u8 type[2];
@@ -152,14 +158,26 @@ struct mt7925_clc_segment {
 	u8 rsv2[4];
 } __packed;
 
-struct mt7925_clc {
-	__le32 len;
-	u8 idx;
-	u8 ver;
+struct mt7925_clc_type0 {
 	u8 nr_country;
 	u8 type;
 	u8 nr_seg;
 	u8 rsv[7];
+} __packed;
+
+struct mt7925_clc_type2 {
+	u8 type;
+	u8 rsv[9];
+} __packed;
+
+struct mt7925_clc {
+	__le32 len;
+	u8 idx;
+	u8 ver;
+	union {
+		struct mt7925_clc_type0 t0;
+		struct mt7925_clc_type2 t2;
+	};
 	u8 data[];
 } __packed;
 
@@ -239,6 +257,7 @@ int mt7925_mcu_chip_configv2(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
+void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
 void mt7925_regd_update(struct mt792x_dev *dev);
 int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 281df43d9060..85f07f936be5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -71,6 +71,7 @@ struct mt792x_fw_features {
 enum {
 	MT792x_CLC_POWER,
 	MT792x_CLC_POWER_EXT,
+	MT792x_CLC_BE_CTRL,
 	MT792x_CLC_MAX_NUM,
 };
 
-- 
2.34.1


