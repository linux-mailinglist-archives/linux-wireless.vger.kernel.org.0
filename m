Return-Path: <linux-wireless+bounces-22971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0781CAB7C54
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5DD1B65DC5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69414286D5A;
	Thu, 15 May 2025 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sGKNSkLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE43595A
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279975; cv=none; b=ucRgZA+gwpYX6dDoLilDIkfHRWSz9xjADaM0f19gYcbmDpYRmn15jfs1iXmKYASOMz8BFpBD+Sa4TXPGR/eVr2yTyGMbvYaAoMAP+H5/knlwbjin3RkQe1VDm0I73TPO1RFmm3FTw1Ht7TGqCRY2ggFe/XtfcD3olF3XtRFRIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279975; c=relaxed/simple;
	bh=Dbukw6lbcxy72xiq+eNYnafl7T4teOf57mByDwQb2rQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DevApxDlSlvgiv2/We2flDdUJ1ucXisu421pQK4C/lUkGpMjaCJ9PzuvDSIsmuKOyWwbOI8B+TM+/oqbO5cAYW6fCcyI6BsdPJ7qwhkzyMbJlZxTGT1oZsAC0LyPZ7yEgabELWSbP/dFeQfHVj9VP2vZm5u3Vicr+w0Uevzev3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sGKNSkLS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41c7b284313d11f0813e4fe1310efc19-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/LljIS7UIj7Gi1DlWqayTUS0kHg4jXBLeSw+3VLlutk=;
	b=sGKNSkLSDGMXMqOoAB8jYK1MYyaAnhevLbfXsTObmOi4O840CeWXDvnzWs7jwsIuuB0tHR6wshbphBUBpX1nQ0UmcfyrzCQlDSoDFuwJqjDhGUGbMWq0L2qWcqq9EjcILVl/GGjG/uN/tVfmpIg83Yrw2LSg4m4ytet0+hYeacw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d3a0d643-782f-4377-b62e-cd9b731a134e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:feabc773-805e-40ad-809d-9cec088f3bd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41c7b284313d11f0813e4fe1310efc19-20250515
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1928513026; Thu, 15 May 2025 11:32:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 8/9] wifi: mt76: fix available_antennas setting
Date: Thu, 15 May 2025 11:29:51 +0800
Message-ID: <20250515032952.1653494-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515032952.1653494-1-shayne.chen@mediatek.com>
References: <20250515032952.1653494-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Check if available_antennas_tx and available_antennas_rx are already set
during the per-chip initialization phase; otherwise, they could be
overwritten with incorrect values.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index b88d7e10742e..e9605dc22291 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -449,8 +449,10 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AQL);
 
-	wiphy->available_antennas_tx = phy->antenna_mask;
-	wiphy->available_antennas_rx = phy->antenna_mask;
+	if (!wiphy->available_antennas_tx)
+		wiphy->available_antennas_tx = phy->antenna_mask;
+	if (!wiphy->available_antennas_rx)
+		wiphy->available_antennas_rx = phy->antenna_mask;
 
 	wiphy->sar_capa = &mt76_sar_capa;
 	phy->frp = devm_kcalloc(dev->dev, wiphy->sar_capa->num_freq_ranges,
-- 
2.39.2


