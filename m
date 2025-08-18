Return-Path: <linux-wireless+bounces-26423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3EB29731
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 05:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7CC17942B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C72580DD;
	Mon, 18 Aug 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a7CRpque"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4224C06A;
	Mon, 18 Aug 2025 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486138; cv=none; b=Sm26jsfkjOeqFzfFgKHn7f97ja9fz45mXDvVb2nb2hHR9dQXHwrsJephmk0Eb61FLIYFds+L2UiUUAs3cjUicLywpg/2OS1ZmH4I4zoQpiU39OVZzREvKZBdNYWKzu9LPCAMI5rsVcEmZlBIc9kziz0E6maHmKJvmVc4z/KabrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486138; c=relaxed/simple;
	bh=dLR43dYiEJZSodPCTTeC4DftLRxQv/YFZN7dIWXdzQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYNI16aIhnp/njI3m4wplurLKY6ijHiFW8f3Nb+IYqe2SE3SDvuRbE3pZ1rtSxnxIbvidX2fFVF/vm7RGb9N/wob2EXqF9RgNi9L1LuhfnBK/adkrPy74eiSSmXslbfLuWXftedM0dcXdS5oY/JFAd5XrVuRUwAc16zzkm1kUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a7CRpque; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7ee14a27bdf11f0b33aeb1e7f16c2b6-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0+vjVtEU7kNIlyL8VETxpczT/vmL9S8nShv9BwKQngw=;
	b=a7CRpqueaXSMCFVL1W6H1Lp5HwWf5WMEUTMdI49ZdEirtt2hzw9ja9H57emUd0kWkrbn4/bxrVBHC9SW3WgjS1HgAttLHL2ZV103tLGBJGDagx5NGcBXKcqE9YSuYvnTv2Do3npFHmbCjL85W38brmu2B/ZQh03CSQf0AsB1OPI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:f51e2914-38f4-4b21-9ad7-e82728ae1ce4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:a7c2516d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7ee14a27bdf11f0b33aeb1e7f16c2b6-20250818
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 146130983; Mon, 18 Aug 2025 11:02:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 11:02:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 11:02:01 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>, Tal Inbar
	<inbartdev@gmail.com>
Subject: [PATCH] wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass conn_state for sta_cmd
Date: Mon, 18 Aug 2025 11:02:01 +0800
Message-ID: <20250818030201.997940-1-mingyen.hsieh@mediatek.com>
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

Return early in mt7925_mcu_sta_eht_mld_tlv() for non-MLD vifs to avoid bogus
MLD TLVs, and pass the proper connection state to sta_basic TLV.

Cc: stable@vger.kernel.org
Fixes: cb1353ef3473 ("wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd")
Reported-by: Tal Inbar <inbartdev@gmail.com>
Tested-by: Tal Inbar <inbartdev@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 01fee93c0aa9..de8c88cb8081 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2089,13 +2089,13 @@ mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
 	struct tlv *tlv;
 	u16 eml_cap;
 
+	if (!ieee80211_vif_is_mld(vif))
+		return;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT_MLD, sizeof(*eht_mld));
 	eht_mld = (struct sta_rec_eht_mld *)tlv;
 	eht_mld->mld_type = 0xff;
 
-	if (!ieee80211_vif_is_mld(vif))
-		return;
-
 	ext_capa = cfg80211_get_iftype_ext_capa(wiphy,
 						ieee80211_vif_type_p2p(vif));
 	if (!ext_capa)
@@ -2167,6 +2167,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	struct mt76_dev *dev = phy->dev;
 	struct mt792x_bss_conf *mconf;
 	struct sk_buff *skb;
+	int conn_state;
 
 	mconf = mt792x_vif_to_link(mvif, info->wcid->link_id);
 
@@ -2175,10 +2176,13 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
+
 	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
-					      info->enable, info->newly);
+					      conn_state, info->newly);
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
-- 
2.34.1


