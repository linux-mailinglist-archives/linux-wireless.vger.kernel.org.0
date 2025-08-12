Return-Path: <linux-wireless+bounces-26304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E3B225B1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845E33B5022
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783CA1FCF7C;
	Tue, 12 Aug 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fakagthI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6C2D9ECC
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997411; cv=none; b=GkCh9R3QALfbXA3kFVMqOHAJu+8RzwxYfsHb0AHojHkT2nZtlMJxoE+HmlPwDsRIH4NAvt1hGbsT7LtANrmIhmybwCOJ0jU0Vs3yUN3nFxM5/7AaBPOzIHjPDAW1hXZT6/jL4+eTYNvvunexScboO8FSJe3lOeloOtk68lLrT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997411; c=relaxed/simple;
	bh=yJ/S+hy1xNXmucsmOQ5iB1YKDU0jM7H5HZeKfEvDYYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3DEWgjU4i+V0Z7mPIe3u/E531MHcUQ3acH9RJhM4v40HPnR6j1q0AKnfOFA5B2+tWpfPHrwP1AUZwQn5S+t+6oPsMY4MIwz8vBauyXaOmG0102nw7S/ZoTf6TrxTBQLHIaUft/YffI0NaGYWkTUwZljhD5N4ecQGmanxRwAipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fakagthI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4d1c1ac776d11f08729452bf625a8b4-20250812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=x6QNjyRecp3DvGgfxenrROB8gOL013ZM4COXNtJ51lo=;
	b=fakagthIp6/URmEYHj0WNGADElVRbsXojjwiRl8LFeZ8EeRDJkmPWPYHMs83ptXVSUYI71Genbi7NF9XHnnerb5zlIc/Ct/1v3Imbs+Cl9xjlYn07IvownUnbx9ds+RRuTQuG7COOr8Urz4JpYJb1c8DTuWvSYDZ+COrVrm+/pE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:4455e6ad-eda6-461e-b2db-a852956cf155,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:c69a5251-d89a-4c27-9e37-f7ccfcbebd5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4d1c1ac776d11f08729452bf625a8b4-20250812
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1217288547; Tue, 12 Aug 2025 19:16:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 12 Aug 2025 19:16:43 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 12 Aug 2025 19:16:43 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: add MBSSID support
Date: Tue, 12 Aug 2025 19:16:42 +0800
Message-ID: <20250812111642.3620845-1-mingyen.hsieh@mediatek.com>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Enable MBSSID support for MT7921 by setting the
appropriate capability to the firmware.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 25 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  5 ++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index b5897bc38d2c..9e03185ce6e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1662,6 +1662,31 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			return err;
 	}
 
+	if (enable && vif->bss_conf.bssid_indicator) {
+		struct {
+			struct {
+				u8 bss_idx;
+				u8 pad[3];
+			} __packed hdr;
+			struct bss_info_uni_mbssid mbssid;
+		} mbssid_req = {
+			.hdr = {
+				.bss_idx = mvif->idx,
+			},
+			.mbssid = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_11V_MBSSID),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_mbssid)),
+				.max_indicator = vif->bss_conf.bssid_indicator,
+				.mbss_idx =  vif->bss_conf.bssid_index,
+			},
+		};
+
+		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+					&mbssid_req, sizeof(mbssid_req), true);
+		if (err < 0)
+			return err;
+	}
+
 	return mt76_connac_mcu_uni_set_chctx(phy, mvif, ctx);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index eb4099021fcb..1be6f6dcce8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -697,12 +697,11 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 
 	if (is_mt7921(&dev->mt76)) {
 		ieee80211_hw_set(hw, CHANCTX_STA_CSA);
-	} else {
-		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
-		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 	}
 
 	if (dev->pm.enable)
-- 
2.34.1


