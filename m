Return-Path: <linux-wireless+bounces-19466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A81A45756
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D741735C7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF4224249;
	Wed, 26 Feb 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uf72j6Cd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A818272906
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556328; cv=none; b=QQDhSTeIZcxEnHcmAdMME17n7HoTB464i/DCmhBij1kjzRP9vCV+Sy8bv1nFs3OZIv3vRVN9hVjlIPnQ7Dd7XVfzYhn7KYL/tR4bvFAu9QCYydFritFc9NcGft+Pj9W7YdrviTo/zUro9jyYdu6B8iwgliz38rk2wud1rTVV2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556328; c=relaxed/simple;
	bh=8q1jvqSZE10xA0/k7HkFfMVi5DJEmclN4Xd07HajAiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp5cPIXjamzL+pr4ADA25QTA1GQvP2TikibmLysnYVXE5/XIkxqLqTQReVDc5nYD8mlqNUmeJxSOQOliDRIVcBdyiNiyRFrDRtW6e1ZCf2wLkM1Zr9U1621yN8d307Xp+BsLXBWj3gSFoENEbv0SKl7f3WZAzGPOTz/3eiMMk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Uf72j6Cd; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b995ec6f41611ef8eb9c36241bbb6fb-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D0LubxO8PuasDsqF+Jzui2u+PCebgr1V/Ea3bk4B4q0=;
	b=Uf72j6CdHblN80jwVRnUqdety3C1dkzNxWOACe5uvK9kNpmMkhatZM6jUSwq2Ulm4tMKcfWYLgGi3xwbjncNSjerZCM6mhUrd7WjQ03FCFz4r8ue5QIFV4BfOUXFeUdEIJMPK6VYJHF454eKWw3kcGoc7WCJhafArVwD/hNR/Fc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:63b61f69-62be-449f-b184-9489fc2f1f84,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:10af93a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b995ec6f41611ef8eb9c36241bbb6fb-20250226
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1623184083; Wed, 26 Feb 2025 15:51:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH 6/6] wifi: mt76: mt7925: add MTCL support to enhance the reulatory compliance
Date: Wed, 26 Feb 2025 15:51:23 +0800
Message-ID: <20250226075123.3981253-6-mingyen.hsieh@mediatek.com>
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

Apply the MTCL configuration to improving channel availability and
regulatory compliance if MTCL table is supported.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 8561ab310f16..1bd30a857be5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -64,8 +64,15 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
 	struct mt7925_clc_rule_v2 *rule;
 	struct mt7925_clc *clc;
 	bool old = dev->has_eht, new = true;
+	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2);
 	u8 *pos;
 
+	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID &&
+	    (((mtcl_conf >> 4) & 0x3) == 0)) {
+		new = false;
+		goto out;
+	}
+
 	if (!phy->clc[MT792x_CLC_BE_CTRL])
 		goto out;
 
@@ -101,11 +108,21 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 {
 #define IS_UNII_INVALID(idx, sfreq, efreq) \
 	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+#define MT7925_UNII_59G_IS_VALID	0x1
+#define MT7925_UNII_6G_IS_VALID	0x1e
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_channel *ch;
+	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, mdev->alpha2);
 	int i, cfreq;
 
+	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID) {
+		if ((mtcl_conf & 0x3) == 0)
+			dev->phy.clc_chan_conf &= ~MT7925_UNII_59G_IS_VALID;
+		if (((mtcl_conf >> 2) & 0x3) == 0)
+			dev->phy.clc_chan_conf &= ~MT7925_UNII_6G_IS_VALID;
+	}
+
 	sband = wiphy->bands[NL80211_BAND_5GHZ];
 	if (!sband)
 		return;
-- 
2.34.1


