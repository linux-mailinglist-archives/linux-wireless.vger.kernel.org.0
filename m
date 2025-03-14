Return-Path: <linux-wireless+bounces-20374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C47A60CC2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7943AD654
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77217E;
	Fri, 14 Mar 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RoRA6CrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB61DD877;
	Fri, 14 Mar 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943224; cv=none; b=bLDyeQoUtfQztk8EPchN59CSC0q2VV95uvQ/5wWBeCMq/RrOiNCp6h2/GPqUT8nwk8jbju62mfXJ6kTiTOVzdjqzMI4Z+fXT6JUdAogaBDbZGh5dd7mZP8Kqb/dSLSh5BJsUZw4BD1r7mWnJk2Blxu2AzIE3XZGvlTz/QZ/zd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943224; c=relaxed/simple;
	bh=37eHhDWIYH2KFzy4ngjAsSfwtLTRBQ6NSJl/HrZiHyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSozM9qENtP3X5vGJmJ1ZozcHQOr+sr/lEwhlrkfUJ5NZdrf2//KbWoDTwE7E+Xtxivs6i30A+ZU83oOv+9SGCISsRbSKUfPRF+xlCkHTNWus2Vij5SmprGzhqYQ5BOmKQaesJaDtykGfjrUDIG4TGIimEIy0vGzoUhnkh4dZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RoRA6CrU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ae6850d400b311f0aae1fd9735fae912-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=la9wkd5vzRHQ5ec7yJZBYLsKgQribkmSaDdGEv4GlFU=;
	b=RoRA6CrU8VMFWtR6dFP2g4aarnUv94SkhA07LqajCUTk1FpE9TrHjBV/kAqPMKcTCSAXLuP+OV6rtXn3GPDd6qBW/iv/D1p5CKB/yWGBCoD+wmekjkqgO+wocN1N7wfyIIzReQik4Wbyf6pYT7fmvkKqxNNtL4m2d38UzpQVVnU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:87802171-6ce5-4f7b-b132-58aa1391fab1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b9445f8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ae6850d400b311f0aae1fd9735fae912-20250314
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 386278935; Fri, 14 Mar 2025 17:06:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 17:06:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 17:06:56 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] wifi: mt76: mt7925: fix the incomplete revert of [tx,rx]_ba for MLO
Date: Fri, 14 Mar 2025 17:06:54 +0800
Message-ID: <20250314090655.2856153-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Since the `Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"`
was not completely clean, submit this patch to fully clean it up.

Cc: stable@vger.kernel.org
Fixes: 73915469c55a ("Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"")
Change-Id: I2d851e6b79905baae35f691578bf50d56ad0adbf
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: rewrite the subject
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1ecba46d770d..1bdc313844c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -572,10 +572,10 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
-		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -608,13 +608,12 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 	struct mt792x_vif *mvif = msta->vif;
-	struct mt76_wcid *wcid = &mvif->sta.deflink.wcid;
 
 	if (enable && !params->amsdu)
 		msta->deflink.wcid.amsdu = false;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
-				 params, enable, true);
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, true);
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
@@ -623,10 +622,9 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 	struct mt792x_vif *mvif = msta->vif;
-	struct mt76_wcid *wcid = &mvif->sta.deflink.wcid;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
-				 params, enable, false);
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, false);
 }
 
 static int mt7925_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
-- 
2.45.2


