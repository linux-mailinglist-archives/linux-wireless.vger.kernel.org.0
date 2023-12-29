Return-Path: <linux-wireless+bounces-1329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBD81FCB4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19D11C213E0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C579CD;
	Fri, 29 Dec 2023 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OOzKPl+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DD6AA8
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b5c251f8a5f711ee9e680517dc993faa-20231229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m9h0PdlfNLTm8svOr/KLUcDyqUtp0frCDbPlRXvxZzQ=;
	b=OOzKPl+n/DEZCR/4abH3M22xIUWCPFFy2dTVNvOc/Cuo8vRK7r86a6h9xmUloPlfu5PUW/rvOk3iiBmuLFEFyo4/+VHPfBDrRZsQo7WBZxibGnjSAwzoxPw/gRHGKfbIWXlM3WDt6uzmXUBmIA/stRbU4esPXR2v1Ea3JT6wVdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ae56f55b-5e18-4a94-8304-a3f8c350f690,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:49ebaf8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5c251f8a5f711ee9e680517dc993faa-20231229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1999773341; Fri, 29 Dec 2023 11:09:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Dec 2023 11:09:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Dec 2023 11:09:40 +0800
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
Subject: [PATCH v2 04/10] wifi: mt76: mt7925: fix wmm queue mapping
Date: Fri, 29 Dec 2023 11:09:31 +0800
Message-ID: <20231229030937.22605-5-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231229030937.22605-1-mingyen.hsieh@mediatek.com>
References: <20231229030937.22605-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Firmware uses access class index (ACI) for wmm parameters update,
so convert mac80211 queue to ACI in mt7925_conf_tx().

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
 change mq_to_aci[] definition from "static" to "static const".

 .../net/wireless/mediatek/mt76/mt7925/main.c  | 21 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a080df58120f..813136223b57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1273,6 +1273,25 @@ mt7925_channel_switch_beacon(struct ieee80211_hw *hw,
 	mt792x_mutex_release(dev);
 }
 
+static int
+mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	static const u8 mq_to_aci[] = {
+		    [IEEE80211_AC_VO] = 3,
+		    [IEEE80211_AC_VI] = 2,
+		    [IEEE80211_AC_BE] = 0,
+		    [IEEE80211_AC_BK] = 1,
+	};
+
+	/* firmware uses access class index */
+	mvif->queue_params[mq_to_aci[queue]] = *params;
+
+	return 0;
+}
+
 static int
 mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
@@ -1396,7 +1415,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.add_interface = mt7925_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7925_config,
-	.conf_tx = mt792x_conf_tx,
+	.conf_tx = mt7925_conf_tx,
 	.configure_filter = mt7925_configure_filter,
 	.bss_info_changed = mt7925_bss_info_changed,
 	.start_ap = mt7925_start_ap,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 4811fccbe30e..0299045b4b83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -895,7 +895,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 
 		e = (struct edca *)tlv;
 		e->set = WMM_PARAM_SET;
-		e->queue = ac + mvif->mt76.wmm_idx * MT76_CONNAC_MAX_WMM_SETS;
+		e->queue = ac;
 		e->aifs = q->aifs;
 		e->txop = cpu_to_le16(q->txop);
 
-- 
2.18.0


