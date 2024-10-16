Return-Path: <linux-wireless+bounces-14067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D638D9A06B6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F33C28823D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F4206054;
	Wed, 16 Oct 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="saoruRIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8C29A0
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073430; cv=none; b=QDdrsOOnN52YcIvCn+S1ldSo5KZEbuEHHiIYeKXk+8VcnCJvzqtyod+RS1EDxKxLUn3dYX/8b3XOp5gsKqva1SrqgpWbeulT0bdpDdOrecHNcG58B/2HA87QZ/pZ9FpD76ZLNatiV1rTtTW3nJqtnf0x2hdg4WcHoCWZ9aLojJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073430; c=relaxed/simple;
	bh=EpddFLSun7fDw+egZk707OQtlEoscZa7kiFPCa/aEZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2Ahj+0WYD4aoKa3y/2V5HQZ5vHedCSztnlZqnw/rYwRCKaq/ISoDS9aqGRjIxTm2LCnf5k3yI60Doccxbh/3e/d8HvXYrD9YM+4m0Rr7sUr4YMOYnUKq6JQmRWwu1ZxLnN22zNMY5mc6gU86n5VWytJRIeBMUXTh7Feb8WdQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=saoruRIz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: db6e1d488ba611ef8b96093e013ec31c-20241016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dw7E25Ax5aPaEi8VvFtVDhiaph6LmLWdS1o3OukH4H8=;
	b=saoruRIzVdNVWNKqmGKzeF08LKmCthKm1cfEldBaDfBnQ3gCgd/5M6B/l1e5ixWTbCA9LAapBUOex0A09y5sx0Rp+wpGkIiDhkotyID+gNIEZq2x7utReqlB2JQLbkqPGOYKstjRAJGChc5RyBx2+kk01CJF+dklic0lLK9v47Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:efffa6cc-40b6-4e06-8b34-72f266614a81,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8add5665-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: db6e1d488ba611ef8b96093e013ec31c-20241016
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1464840681; Wed, 16 Oct 2024 18:10:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 16 Oct 2024 18:10:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 16 Oct 2024 18:10:20 +0800
From: Allan Wang <allan.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>,
	<Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Allan Wang <allan.wang@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>
Subject: [PATCH v3] wifi: mt76: introduce mt792x_config_mac_addr_list routine
Date: Wed, 16 Oct 2024 18:10:17 +0800
Message-ID: <20241016101017.19598-1-allan.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.161600-8.000000
X-TMASE-MatchedRID: mSPDr4jZDFE9S3IiQd+eNULhYg/sa1gs+Vb3woyMZbtUjspoiX02F8+c
	wCLpvDnE01CjbbHk5lBso/8Nu7eWqFIMRaTXK1BMA9lly13c/gFflOpBqBHTtzUsHjosUACSWfD
	0boMRR4Mdp4Txl116a82cSlJJpVq0mHQ8ODC8xrYMH4SsGvRsA+rRJDUyDHkIwsR7A2gTdJmv1j
	/2L7xP1lD3U31Zcw/LTBBYZttKmvw6khM4kbcJpRlckvO1m+JcfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtgUicvJ4MChnqDCGTL5wntxilhxfL6BTVKN0vs4WWTMmmiOBdzYSoWmY7eqLvyw0k
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.161600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A35463E1A97DF16B4076621888CB5B8AA9E0F58099AC491B4A80AEEA2B8E074F2000:8

Add mt792x_config_mac_addr_list routine in order to set
the mac address list supported by the driver. Initialize
wiphy->addresses/n_addresses for mt792x driver

Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
Signed-off-by: Allan Wang <allan.wang@mediatek.com>
---
v2:
 - Remove Change-Id tag

v3:
 - Update commit message after fixing gitconfig username format
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  3 +++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 22 +++++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d1d64fa7d35d..cdcb002b3094 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -227,6 +227,7 @@ static void mt7921_init_work(struct work_struct *work)
 
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7921_set_stream_he_caps(&dev->phy);
+	mt792x_config_mac_addr_list(dev);
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 039949b344b9..ddc654b9ea5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -178,6 +178,7 @@ static void mt7925_init_work(struct work_struct *work)
 
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7925_set_stream_he_eht_caps(&dev->phy);
+	mt792x_config_mac_addr_list(dev);
 
 	ret = mt7925_init_mlo_caps(&dev->phy);
 	if (ret) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ab12616ec2b8..10e1eaa52706 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -206,6 +206,8 @@ struct mt792x_dev {
 		struct mt76_phy mphy;
 	};
 
+	struct mac_address macaddr_list[8];
+
 	const struct mt76_bus_ops *bus_ops;
 	struct mt792x_phy phy;
 
@@ -414,6 +416,7 @@ int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
 void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
 				struct mt792x_bss_conf *mconf,
 				struct mt792x_link_sta *mlink);
+void mt792x_config_mac_addr_list(struct mt792x_dev *dev);
 
 static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 042aa8d1b6e7..868cb97fa2ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -916,6 +916,28 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792x_load_firmware);
 
+void mt792x_config_mac_addr_list(struct mt792x_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct wiphy *wiphy = hw->wiphy;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->macaddr_list); i++) {
+		u8 *addr = dev->macaddr_list[i].addr;
+
+		memcpy(addr, dev->mphy.macaddr, ETH_ALEN);
+
+		if (!i)
+			continue;
+
+		addr[0] |= BIT(1);
+		addr[0] ^= ((i - 1) << 2);
+	}
+	wiphy->addresses = dev->macaddr_list;
+	wiphy->n_addresses = ARRAY_SIZE(dev->macaddr_list);
+}
+EXPORT_SYMBOL_GPL(mt792x_config_mac_addr_list);
+
 MODULE_DESCRIPTION("MediaTek MT792x core driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
-- 
2.45.2


