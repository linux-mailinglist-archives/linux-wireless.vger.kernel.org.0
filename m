Return-Path: <linux-wireless+bounces-20413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2B2A639F2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 02:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1018016D5C6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4638FA6;
	Mon, 17 Mar 2025 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l3SlpSEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EFAD4B;
	Mon, 17 Mar 2025 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174261; cv=none; b=rrJWCt86XOjupvj3OX6MUsCuhHbb2pNk6HN2aNGcaWQ8YJbJ4GloVPqL1Ovnb6Z5eD3hWxcfPHxrxUI0DYqesJrGndCSx9ofyPv76iVOgcCjG0u/FRdCXZnYP09q/ObXCjqIZJh1741SYnNG8fGBaxvWGbiPDzINdub9LfBaTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174261; c=relaxed/simple;
	bh=e6RK4KoUNP7en+k0pDkQgCPkGXZ3+R8i/KF4QfXu23M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFo3MV87wmDK/FmvamTPirItq890UNQlIUadf0l4iTcNzpFmQUojah5xfvA4Z0NtECkaVwYpNf0zMC0iCGaNhEulVr3b3S7VbDxgIUYp1FvP3TCAF4pPM+deEKNAOKrf5mRl1uIEmm9VNe3i1aYGkBhexVrbPeT652MiHN1MD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l3SlpSEZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96ce776602cd11f08eb9c36241bbb6fb-20250317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8f3O8+Vo5Qr0rRuYESppba9QH9iD9l4PD8gsXyGmArc=;
	b=l3SlpSEZlbo41hrVem6rlpYpEOhV6GmtUfwqoKTDvjkIRacY8APWyPdOnKdJlWAY3SsV0VqxdIJXo9drYgrpRACMcLqbUerZWFtbdmwkf/fkX9qyi9rz97dKzyaVbYbrx2bbC73Igr7hicQISHiXqNU9JWjWL68M4DQNf/FXU7Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:71bd2487-e775-408f-8456-670dd021e1d8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:e14c3be1-3561-4519-9a12-e2c881788b70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 96ce776602cd11f08eb9c36241bbb6fb-20250317
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1776022791; Mon, 17 Mar 2025 09:17:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 17 Mar 2025 09:17:25 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 17 Mar 2025 09:17:25 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] wifi: mt76: mt7925: fix the incomplete revert of [tx,rx]_ba for MLO
Date: Mon, 17 Mar 2025 09:17:24 +0800
Message-ID: <20250317011724.3326979-1-mingyen.hsieh@mediatek.com>
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

Since the `Revert wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO`
was not completely clean, submit this patch to fully clean it up.

Cc: stable@vger.kernel.org
Fixes: 73915469c55a ("Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: rewrite the subject
v3: remove the change-Id
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


