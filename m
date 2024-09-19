Return-Path: <linux-wireless+bounces-13007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23297C5B6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370FA1F2178B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA448198A29;
	Thu, 19 Sep 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uPRdmkOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3473B791
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733844; cv=none; b=YTYSFJ9ZF1k2ti5cVVqzlv1QDXW1QlZtHH26zckucOw77MfB862MiJpj7KpM8BKZrdia/FzRXV+EgBO0ipL/JSuVpGsM0EuVs1ZcZpvYXi66co7nrxBBIADCR3pO1B6/Nk+p/zvkvA1iBK9gDLS3qERwMVqf9QpjM0vaBWeNDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733844; c=relaxed/simple;
	bh=L1s2sDAKqzhuVkCCvBXeJ75czH+Un1V0SEQLFILgFGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dr8S9RVKdMcEPcwIBlwrWtK0/496+gMO0h/RFlCWSGPGOz7VsP5xAqG0uz2tl56k3jgyS+zMB+RuuH9OKupw63hvg3u4ZXVzdagQhI7ntxkdMGdWiQnYw3ojm5rCMQlF9E6txfcTJcXYUB3mnULojA1dKiQxowLfE4AuwansMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uPRdmkOK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 94f4416e765f11efb66947d174671e26-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=a6TusFy2ir91gPNlwrF+20GciCGq3HpbhHGPX9zl1lg=;
	b=uPRdmkOKdYGlQQceGVXt70X5GG5o/kQIVJ+5KAOXBJ3ELed9K7CumuPO8u0qmd6JEmJx0wVCWf/JmUO6EfHS3eo5GVnGqyr+IG+1QEJ/qk06b9Sge5YCFLUkS8iOHzp4jKpOfZlybT4lUW/jQiO0R/7c/VtLKZdTz8EGIVqkOJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:74865e71-fd5b-44cf-81b3-d143ce09d412,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:cc566fd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 94f4416e765f11efb66947d174671e26-20240919
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1396106471; Thu, 19 Sep 2024 16:17:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 16:17:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 16:17:15 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Hao Zhang
	<hao.zhang.mediatek@gmail.com>, "allan . wang" <allan.wang@mediatek.com>,
	Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt792x: add P2P_DEVICE support
Date: Thu, 19 Sep 2024 16:17:13 +0800
Message-ID: <20240919081713.23787-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Hao Zhang <hao.zhang.mediatek@gmail.com>

Regist the NL80211_IFTYPE_P2P_DEVICE to support p2p device
for mt792x chips

Signed-off-by: Hao Zhang <hao.zhang.mediatek@gmail.com>
Signed-off-by: allan.wang <allan.wang@mediatek.com>
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c     | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 864246f94088..77f3e92d581a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1202,6 +1202,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	case NL80211_IFTYPE_STATION:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
 		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_P2P_GO);
+		break;
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 78fe37c2e07b..042aa8d1b6e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -38,6 +38,10 @@ static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 		.max = 1,
 		.types = BIT(NL80211_IFTYPE_AP) |
 			 BIT(NL80211_IFTYPE_P2P_GO)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_P2P_DEVICE)
 	}
 };
 
@@ -45,7 +49,7 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
 	{
 		.limits = if_limits_chanctx,
 		.n_limits = ARRAY_SIZE(if_limits_chanctx),
-		.max_interfaces = 2,
+		.max_interfaces = 3,
 		.num_different_channels = 2,
 		.beacon_int_infra_match = false,
 	}
@@ -614,7 +618,8 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_AP) |
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				 BIT(NL80211_IFTYPE_P2P_GO);
+				 BIT(NL80211_IFTYPE_P2P_GO) |
+				 BIT(NL80211_IFTYPE_P2P_DEVICE);
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-- 
2.45.2


