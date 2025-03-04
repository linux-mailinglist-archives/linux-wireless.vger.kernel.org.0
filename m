Return-Path: <linux-wireless+bounces-19755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A68A4DCB8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21F1188BF2E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDD201023;
	Tue,  4 Mar 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gizLMY21"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F6200BBC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088222; cv=none; b=YRRqO7k0z3rsTZH5GmWjNOdCHUwd7dFIgcKPHEdpqXPlpDv5OrMekYOmNlj1ddPThXTUsQIQW42Hyz+dUPzwuyrgKupY3Pz0e5svbENBrwCitXsWShS572c422XDG3me91jdJYo8XxyuXEqQrtH+gB1Lqu0lHT7QgMKuYCKibgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088222; c=relaxed/simple;
	bh=DCnIFB/aDqV3UYyatLiRj7YHrmZ4IS9cTkPMXgiMg3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdAln426Odv+Mo5WRFXVQ+tHiPCaOplh6/BbAVjGHGo4anYUjKC+aR7dGYfPedOBp17uqUfFD7dZeNdc2E4QuEOpkORf+Gal4KYlBRuM6K3oEnlYUjt7RloSUJfUaqSg9cgpcb/g8gG9cHAeF3swa52rbHIBqi/HTnCg/sOXADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gizLMY21; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f8f55a26f8ec11efaae1fd9735fae912-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Rnbdq+8CcJtYWHxqWf2DDyI1KLf3rmu0+Yq/tFB8Ro0=;
	b=gizLMY21O1EnQeA5bpF4/4SGxT+JXVR1NFedaamKs6AhzJmsKdmwI6/hMr4uZe8h1m3FfVGBd50sjnH69PFn+DfnCH6ZkSX4RtSajKM3R3nmvwJaF1AAUmjRUSKN3rQx8Zt6oyPKLN8KXmtohxW4KaC4kWsIYQkcuFtpFrgXh5M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c3c7d237-f405-4b39-a531-e8381e40307a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:42f9cfa4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f8f55a26f8ec11efaae1fd9735fae912-20250304
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1645608290; Tue, 04 Mar 2025 19:36:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH v3 2/6] wifi: mt76: mt7925: add EHT control support based on the CLC data
Date: Tue, 4 Mar 2025 19:36:45 +0800
Message-ID: <20250304113649.867387-2-mingyen.hsieh@mediatek.com>
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

Some countries do not support EHT modulation for now. To prevent violating
regulations, the MT7925 chipset should control the EHT capabilities.
Therefore, when a regulatory domain change is detected during scanning,
the `mt7925_regd_be_ctrl` will process the CLC data to update the EHT
capabilities.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: no change
v3: remove the country code check for updating the BE cap 
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 38 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 10 +++--
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 27 +++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 5 files changed, 71 insertions(+), 7 deletions(-)

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
index cefb9068fa72..7f77864c8f05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1449,6 +1449,8 @@ void mt7925_scan_work(struct work_struct *work)
 				if (!is_valid_alpha2(evt->alpha2))
 					break;
 
+				mt7925_regd_be_ctrl(phy->dev, evt->alpha2);
+
 				if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
 					break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index fe789e7978fc..cc71a6b722f4 100644
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


