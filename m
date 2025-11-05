Return-Path: <linux-wireless+bounces-28565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D39C34E40
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30AB564981
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D630AD00;
	Wed,  5 Nov 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MSbQcsvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8423093CB
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335100; cv=none; b=j8L8EBYTmtguorLpMu89Xbt8E2BrUZxRmHyofXFQnin8aqlu3InMHgQHqjfqKusAivPnJyJ7a9/aX3glyshGxQbX1Jb3rOSs/dEXNWF2/jNdrZkIZz8m61LVIjZzypMAb8rCNdLMXHVco6sn15OQ+KEgWVEXk/3RcxD2mvEVm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335100; c=relaxed/simple;
	bh=RZtTdMSYxxeYH5ATbTwvFr6Zo0nP1XaF+S8Ryx32Fdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7Z77RaowavB4uGBpSz6n5ZTiB18t80MBGeDC3KxtcNM735Bd3iGF9OdgshCxJnqx1IUZtyYRuUdt7v50OZSW8Bc8+eyEOthNlXUHfcy0WqzPkPorCWXsjR69CeSNnvcwdQTQbFT0oAlehngoZARm6c6j38yelRNEJyYWmjM31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MSbQcsvY; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36b0600aba2a11f0b33aeb1e7f16c2b6-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RE3oqPKs//xyZmMUoMZ+7RHBJHTXz5keYCyQmdPj6ps=;
	b=MSbQcsvYP8ytPisR5nDE//HZBJ5jz2YI4HIYtMdB8APdO26VKVn+upob48sk9Q0HymyHi6MSzlLKl68PPCFb2xwdAmJmx2TyD3ELfHnsQxmM8HVTHJIpw5gQ5QD6jbwv2cOaLNwA0xtd8n+SlUvtNKtbfF/aYbYqBrBkU3n1yEQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:23db9c74-f12a-49de-bc6c-73b9b44d212e,IP:0,UR
	L:0,TC:0,Content:37,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:37
X-CID-META: VersionHash:a9d874c,CLOUDID:270bf218-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36b0600aba2a11f0b33aeb1e7f16c2b6-20251105
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 66763326; Wed, 05 Nov 2025 17:31:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 17:31:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 17:31:30 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 09/12] wifi: mt76: mt7996: fix MLD group index assignment
Date: Wed, 5 Nov 2025 17:30:57 +0800
Message-ID: <20251105093100.541408-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105093100.541408-1-shayne.chen@mediatek.com>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Fix extender mode and MBSS issues caused by incorrect assignment of the
MLD group and remap indices.

Fixes: ed01c310eca9 ("wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv routine")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 58 +++++++++++++------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3958688d622b..346d650107d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -90,9 +90,11 @@ static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
 {
 }
 
-static inline int get_free_idx(u32 mask, u8 start, u8 end)
+static inline int get_free_idx(u64 mask, u8 start, u8 end)
 {
-	return ffs(~mask & GENMASK(end, start));
+	if (~mask & GENMASK_ULL(end, start))
+		return __ffs64(~mask & GENMASK_ULL(end, start)) + 1;
+	return 0;
 }
 
 static int get_omac_idx(enum nl80211_iftype type, u64 mask)
@@ -308,12 +310,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	if (!dev->mld_idx_mask) { /* first link in the group */
-		mvif->mld_group_idx = get_own_mld_idx(dev->mld_idx_mask, true);
-		mvif->mld_remap_idx = get_free_idx(dev->mld_remap_idx_mask,
-						   0, 15);
-	}
-
 	mld_idx = get_own_mld_idx(dev->mld_idx_mask, false);
 	if (mld_idx < 0)
 		return -ENOSPC;
@@ -331,10 +327,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		return ret;
 
 	dev->mt76.vif_mask |= BIT_ULL(mlink->idx);
-	if (!dev->mld_idx_mask) {
-		dev->mld_idx_mask |= BIT_ULL(mvif->mld_group_idx);
-		dev->mld_remap_idx_mask |= BIT_ULL(mvif->mld_remap_idx);
-	}
 	dev->mld_idx_mask |= BIT_ULL(link->mld_idx);
 	phy->omac_mask |= BIT_ULL(mlink->omac_idx);
 
@@ -424,11 +416,6 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
 	dev->mld_idx_mask &= ~BIT_ULL(link->mld_idx);
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
-	if (!(dev->mld_idx_mask & ~BIT_ULL(mvif->mld_group_idx))) {
-		/* last link */
-		dev->mld_idx_mask &= ~BIT_ULL(mvif->mld_group_idx);
-		dev->mld_remap_idx_mask &= ~BIT_ULL(mvif->mld_remap_idx);
-	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
@@ -2225,7 +2212,42 @@ mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			u16 old_links, u16 new_links,
 			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
-	return 0;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	int ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (!old_links) {
+		int idx;
+
+		idx = get_own_mld_idx(dev->mld_idx_mask, true);
+		if (idx < 0) {
+			ret = -ENOSPC;
+			goto out;
+		}
+		mvif->mld_group_idx = idx;
+		dev->mld_idx_mask |= BIT_ULL(mvif->mld_group_idx);
+
+		idx = get_free_idx(dev->mld_remap_idx_mask, 0, 15) - 1;
+		if (idx < 0) {
+			ret = -ENOSPC;
+			goto out;
+		}
+		mvif->mld_remap_idx = idx;
+		dev->mld_remap_idx_mask |= BIT_ULL(mvif->mld_remap_idx);
+	}
+
+	if (new_links)
+		goto out;
+
+	dev->mld_idx_mask &= ~BIT_ULL(mvif->mld_group_idx);
+	dev->mld_remap_idx_mask &= ~BIT_ULL(mvif->mld_remap_idx);
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
 }
 
 static void
-- 
2.51.0


