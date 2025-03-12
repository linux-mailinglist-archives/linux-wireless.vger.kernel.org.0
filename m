Return-Path: <linux-wireless+bounces-20237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCEA5DB2E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692861773EE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932623F28A;
	Wed, 12 Mar 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syw4jIN/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519322E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778070; cv=none; b=eXcc7yQrNyeKixvd3BWdB/bRqUWAeNKRlqrC5Mu0rFMPa8wYF+c+ncqh2henpMRKMonA6oWvL0A63wf/to8kb+634DXksNpKBzAhFDDXsdAp/z+ItGA8VPoUwsnBDBLWawz7abmH6Ov5U/NQ7zPehMY5s5O4NBJJx9tl0ykcvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778070; c=relaxed/simple;
	bh=8bdOOIA+g5woZVfBzNuz6crv+Ldk1aebuEmLn1pwko8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBx/AttL1emLHfxdxfXKcuWdvgfIT5iSJ6jdL4tXU+bsMpLpKFqT3TP+hr7d29vJNCV0cJ894hLbUaSLBxdi4C6Xrcc6+yOOn7asseUm2oX9NKLGgW+WJ7gYrnq9qbM4BIACIwMR3Wh6ex3GcFInwLfcgb9GmarDJzXsPYhncg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syw4jIN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D97C4CEEC;
	Wed, 12 Mar 2025 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778069;
	bh=8bdOOIA+g5woZVfBzNuz6crv+Ldk1aebuEmLn1pwko8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=syw4jIN/oQolTdBHgcpGrdCv+CKQ3H59VhF8Ffe0e1E5PDMByv4Xr3bcXpRX9CeKf
	 ilexGL1NotHnn0YDHnW1vQ8G4c8TzmGMXuD/CFPsnvXqwc7vyHsUELpy50S8RiwKIX
	 GQjMmvkgztr/0XcYQHbAciuYh6d8RQKuo1luFdotHTlSRTrLPDoURw5b/qHHvM4vCY
	 K6tTrt9y5Ir7kBQCac46D1EasE082N3GSlYxULF4uS5HsPsFqykGFDXq4IksapKPDL
	 SgvTbmU0NGUvhVQZ8qiQT2mzS44GfHg6aIxAI7sQup/mmrEdZriZss4cf6ACUrsaft
	 UL8edFNHJwDUA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:55 +0100
Subject: [PATCH 11/21] wifi: mt76: mt7996: remove
 mt7996_mac_enable_rtscts()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-11-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

It is controlled by FW, also, driver should not directly write WTBL to
prevent WTBL overwritten issues.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 14 --------------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  3 ---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 --
 3 files changed, 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index b8d88fdee97a3567b57a20d0322859b7ae8ce88a..c1c7638e29a1205629f4eb126e15163981109557 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -217,20 +217,6 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 	rcu_read_unlock();
 }
 
-void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
-			      struct ieee80211_vif *vif, bool enable)
-{
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link = &mvif->deflink.msta_link;
-	u32 addr;
-
-	addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 5);
-	if (enable)
-		mt76_set(dev, addr, BIT(5));
-	else
-		mt76_clear(dev, addr, BIT(5));
-}
-
 /* The HW does not translate the mac header to 802.3 for mesh point */
 static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a845c3e758adcc4802f704a99ac39aa9ca670c88..8d7ad2dc2d7bccf6c8f5fe4862828b61145a0c85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -785,9 +785,6 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				   !!(changed & BSS_CHANGED_BSSID));
 	}
 
-	if (changed & BSS_CHANGED_ERP_CTS_PROT)
-		mt7996_mac_enable_rtscts(dev, vif, info->use_cts_prot);
-
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1e79757b7a5197426438532a2f0c39e54d6ebae5..8a347dd8e648a43250e7dd717cb65f77cb4a61dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -707,8 +707,6 @@ bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
 void mt7996_mac_reset_counters(struct mt7996_phy *phy);
 void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy);
 void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
-void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
-			      struct ieee80211_vif *vif, bool enable);
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,

-- 
2.48.1


