Return-Path: <linux-wireless+bounces-17476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B86A103B6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B964166B92
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF927284A71;
	Tue, 14 Jan 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LmiGfj2G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29F22DC56
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849511; cv=none; b=nHcUjqdkPUl7SKMg7940cEKrDIhUAEbdHseEzRbe69GU0LN36sU4l0gyVPTG/b8aXFqsp9iXYhXilh8EWRt1HaujA/ipDyZ0DwWoUEAn9tczbViSZAlRHdqCi9RvPsG9Xxt/AErw6hYNj5lBBvpaF/pfKuRwU4E0dEbxtVYyLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849511; c=relaxed/simple;
	bh=Z/02pLS7f2plpWke29jgHNSgaHBB17AQNGUerNU6EzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1qSTpuPUFy0B8SWXy0+5Ehz7wKJmHVgXhCYmTtuEmCkfT5kn43W3rVYDeAIeu7mctAuXYEQuqWZxtAhfvUOv8fzHO8iirhjVbsXx7AKpTkTEOge+JRcYAYK7D1gIVcOxu8hgIPJE5Z5ovttV1CD7GWWbI7VJkNtX7Jgf3AcWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LmiGfj2G; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2f34dd0d25f11ef99858b75a2457dd9-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UHzbOEmiqnQIkKhhSqNXU6yfTUCIaRQzxl1hYiaXUpA=;
	b=LmiGfj2GYIDI3BSjHz5+EDyQS+LhhmmrFPt9FO45RLWN23nU4ygrioob20ynrAHPGNnd0XQhXlWIWzaf1gLZsZtsQNoVqYEgalCRFz+8uVc7m49rAvwY0DRATqhTukJgA/B0V/lE+OvGcmynr5s16zcC7kdfsiBHsYSCTpoeuK4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b49422c9-742c-4ae2-b579-1c68351f94c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:a4d4dc37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f2f34dd0d25f11ef99858b75a2457dd9-20250114
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 647262749; Tue, 14 Jan 2025 18:11:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 Jan 2025 18:11:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 14 Jan 2025 18:11:40 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 8/9] wifi: mt76: mt7996: fix beacon command during disabling
Date: Tue, 14 Jan 2025 18:10:25 +0800
Message-ID: <20250114101026.3587702-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250114101026.3587702-1-shayne.chen@mediatek.com>
References: <20250114101026.3587702-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

When stopping AP, mac80211 frees beacon template before it calls
driver's stop_ap operation. In other words, on the path of stopping
AP, ieee80211_beacon_get_template() must returns NULL in
mt7996_mcu_add_beacon(). In such case mt7996 immediately returns
-EINVAL without telling FW to disable the beacon.

This commit refactors mt7996_mcu_add_beacon() so that FW can be
correctly informed when disabling AP interface.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 9879c108cd0e..dcca8b931237 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2520,7 +2520,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
-	int len;
+	int len, extra_len = 0;
 
 	if (link_conf->nontransmitted)
 		return 0;
@@ -2534,28 +2534,32 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return PTR_ERR(rskb);
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, link_conf->link_id);
-	if (!skb) {
+	if (link_conf->enable_beacon && !skb) {
 		dev_kfree_skb(rskb);
 		return -EINVAL;
 	}
 
-	if (skb->len > MT7996_MAX_BEACON_SIZE) {
-		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
-		dev_kfree_skb(rskb);
-		dev_kfree_skb(skb);
-		return -EINVAL;
-	}
+	if (skb) {
+		if (skb->len > MT7996_MAX_BEACON_SIZE) {
+			dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+			dev_kfree_skb(rskb);
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
 
-	info = IEEE80211_SKB_CB(skb);
-	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mlink->band_idx);
+		extra_len = skb->len;
+	}
 
-	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + skb->len, 4);
+	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + extra_len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
 	bcn = (struct bss_bcn_content_tlv *)tlv;
 	bcn->enable = link_conf->enable_beacon;
 	if (!bcn->enable)
 		goto out;
 
+	info = IEEE80211_SKB_CB(skb);
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mlink->band_idx);
+
 	mt7996_mcu_beacon_cont(dev, link_conf, rskb, skb, bcn, &offs);
 	if (link_conf->bssid_indicator)
 		mt7996_mcu_beacon_mbss(rskb, skb, bcn, &offs);
-- 
2.39.2


