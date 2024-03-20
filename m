Return-Path: <linux-wireless+bounces-4974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5A88107F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E01C22F12
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FE3F8C3;
	Wed, 20 Mar 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SqsFOFfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01A3D541
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932976; cv=none; b=AousGLTvBMKFJGwKszdjEsiRtwp0bGhjJii7JgPFToHB7QWyluubwllC7kBrmGLgfZy6muB5ALcz6orfBopMFnDWpSeSU7Le3HVNTJ6BshlZ5iemHvbtmuKWfquAq4khqzAPNItdbWJZKeX8grwNnhRGyqc/mIMkBLT3hc8VFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932976; c=relaxed/simple;
	bh=YehnaLQttCIfOJLm51hiUgHalv94ElnBMjUaWXMzyRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOUYQ8aGmxN0tqHv2+thR+ors8vg5BGojbwjbvkPU8B2cjLwl+ErjXdHc6ebkZT2Ig5xaPSjtARRl6oBGWVSE7hGGrhVMzaZNRa4TtR3t7/Qjb3+klFHgP9CTAQybWc+8xY/nuKILipSJmfQReNoujo8xGZD1RWKPYzElUVe9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SqsFOFfK; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f7206cae6aa11ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9ZnYMiMoNgdEOpisQDyFxN4JhpH5dfSFwjD8tpJFcuw=;
	b=SqsFOFfKDlu1qSBtZbT9FTyeYr2ayVW8iIQtrEZ9dO/KYCfMezPcO1WawCiXpbFA6a7/vPF/5sQjP9LigIwZ/DLr5XUlVbPUlmqHBRL99roeJdZ/59VSzw2PuFJWyqYKeYSm038HVX5YsTfMLVIlTH7Jm6VVn5Z4O5I1CV8rHm0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f05fa0f8-69e5-4779-bddb-dfb5b40bfcdc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c405a090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f7206cae6aa11ee935d6952f98a51a9-20240320
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 919650579; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:23 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 02/10] wifi: mt76: mt7996: disable rx header translation for BMC entry
Date: Wed, 20 Mar 2024 19:09:10 +0800
Message-ID: <20240320110918.3488-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

When a BMC wtbl of station interface is correctly set with peer address,
HW will do rx header translation for broadcast data packets, which makes
mac80211 unable to find the corresponding ieee80211_sta and drop the
packets. To fix this, disable HW rx header translation for BMC entry.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index df6be2091615..fd0cc945b22a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1778,10 +1778,10 @@ mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	wcid = (struct mt76_wcid *)sta->drv_priv;
-	if (!wcid)
+	if (!sta)
 		return;
 
+	wcid = (struct mt76_wcid *)sta->drv_priv;
 	hdr_trans->dis_rx_hdr_tran = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		hdr_trans->to_ds = true;
@@ -2154,6 +2154,9 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	if (!enable)
 		goto out;
 
+	/* starec hdr trans */
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+
 	/* tag order is in accordance with firmware dependency. */
 	if (sta) {
 		/* starec hdrt mode */
@@ -2178,8 +2181,6 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		mt7996_mcu_sta_muru_tlv(dev, skb, vif, sta);
 		/* starec bfee */
 		mt7996_mcu_sta_bfee_tlv(dev, skb, vif, sta);
-		/* starec hdr trans */
-		mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
 	}
 
 	ret = mt7996_mcu_add_group(dev, vif, sta);
-- 
2.39.2


