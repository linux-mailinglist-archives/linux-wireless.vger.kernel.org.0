Return-Path: <linux-wireless+bounces-1311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F481FC76
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 03:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C0A2860B1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC11FB6;
	Fri, 29 Dec 2023 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KnBdZQR2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB137F
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 02efab60a5ee11eea2298b7352fd921d-20231229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zDWDn9oBv1U+3xvwbXPmm8vBhm6pjyap2Yx2ddY1yCs=;
	b=KnBdZQR2/1Uk7XrXBlcMDyDW8M5gT7ocT9iB91Z3S4RCcfMeLxqbzPfSx7JX6du6mL7lAlZD5hHgdd58GXzahU2aF3WSg7drGgd+xr0vbiedFMZCJu30aiZbWl+1DrXwu20OGH2tMGVCotJpYfs69T4dds+BvZFvM0M5JlbYAvg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5be59129-5075-493b-bf14-e2624805bf26,IP:0,U
	RL:-32768,TC:0,Content:-32768,EDM:-32768,RT:0,SF:-32768,FILE:0,BULK:-32768
	,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5b36c87e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:ni
	l,URL:nil,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02efab60a5ee11eea2298b7352fd921d-20231229
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1939312359; Fri, 29 Dec 2023 10:00:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Dec 2023 10:00:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Dec 2023 10:00:15 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v1 01/10] wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
Date: Fri, 29 Dec 2023 10:00:00 +0800
Message-ID: <20231229020009.12385-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231229020009.12385-1-mingyen.hsieh@mediatek.com>
References: <20231229020009.12385-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Driver should setting correct phy mode to firmware when in legacy mode.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c5fd7116929b..1fc9ecb96bc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1460,12 +1460,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 	struct tlv *tlv;
 	u8 af = 0, mm = 0;
 
-	if (!sta->deflink.ht_cap.ht_supported && !sta->deflink.he_6ghz_capa.capa)
-		return;
-
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
 	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif, chandef->chan->band, sta);
+	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
 	if (sta->deflink.ht_cap.ht_supported) {
 		af = sta->deflink.ht_cap.ampdu_factor;
 		mm = sta->deflink.ht_cap.ampdu_density;
-- 
2.18.0


