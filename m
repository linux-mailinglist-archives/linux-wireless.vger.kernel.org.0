Return-Path: <linux-wireless+bounces-20242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2171A5DB35
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3CC3ABBE3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7123F39B;
	Wed, 12 Mar 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FExmkP1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1123F39A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778082; cv=none; b=opS5ML3sdVNS/UykyQt14EVha0gxmSQwHFMPhyPK+DXSVk9Tc9lEojEG28VfYvn4T4QNucnymI0tYUmiHzXDFo9Xn2hA6tdrjwzNrV5BIfcazFuPgIqA8ZADMUXDcguxr/xPaLKmFunsNRSZJpLpr8ANY0JzNBsDrz+0LgVdvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778082; c=relaxed/simple;
	bh=goqirt3ne0YBLw9g5DlQYNOmTv0nq7Z+NH2LHivrQCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ri22IpIUl/8dR1wmhhouXrp2kAdY1h10s3aOxoyRuu0PDAVY0UrhL7nOY8tC0UwQ5Enz0ylw5MaNafsYgokQdXVPZ6XZy7Qb34+hYbDfszO2UOQVIrI55sgnStvmCGhpUIA1LvJ3xPylsCcmupzVu6kSe8lJT7IOeCAKBEx/giQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FExmkP1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D8C4CEE3;
	Wed, 12 Mar 2025 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778082;
	bh=goqirt3ne0YBLw9g5DlQYNOmTv0nq7Z+NH2LHivrQCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FExmkP1WMmO5+7CyR9+dkdJc/RFvUa92Bbn+nvfCIUEbussK7GdCLQktDXr0Q6d4t
	 Y2JvzZyvDuCxmvheqPxuAAaszz11xG89s/l/RJB30KpdeOIN6GQbA4MSFSWKPMvwdT
	 XVRtdgyW/Aq8YT9VeaGGjm8G9PdNbcETf0kb6h2sE7Xamx8cZuR4fQduA2K6i3HrdD
	 GeFEnTKv6ZPE7CIbhbRFni7p4XUssuSSAGvRctJ28kEp9LrZ62jCsIq3Sh0fh9MYKs
	 1SdA+yZNYQb/tfUKeo8UJLjYvG3vNwsVuV2XKoa05+jbqxaxfvbwOBrRMh7uih07uD
	 I12jMNNqHwP2A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:14:00 +0100
Subject: [PATCH 16/21] wifi: mt76: mt7996: rework mt7996_mcu_add_obss_spr
 to support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-16-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Rework mt7996_mcu_add_obss_spr routine in order to support multi-link
setup.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 4a33979ee8535303fa3d09ec4500546d26f700eb..eeb856984298c1e07396c0338e0858afbdb21501 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -807,7 +807,7 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7996_mcu_set_tx(dev, vif, info);
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
-		mt7996_mcu_add_obss_spr(phy, vif, &info->he_obss_pd);
+		mt7996_mcu_add_obss_spr(phy, link, &info->he_obss_pd);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
 		if ((vif->type == NL80211_IFTYPE_AP &&
@@ -1254,6 +1254,7 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mtxq = (struct mt76_txq *)txq->drv_priv;
 
 	mutex_lock(&dev->mt76.mutex);
+
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta_link->wcid, tid, ssn,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b9f689436bfd3859e01ff7025a1f77cec8348824..318ab7c2baa22861637137edfb666e779e662557 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4193,12 +4193,12 @@ mt7996_mcu_set_obss_spr_pd(struct mt7996_phy *phy,
 }
 
 static int
-mt7996_mcu_set_obss_spr_siga(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+mt7996_mcu_set_obss_spr_siga(struct mt7996_phy *phy,
+			     struct mt7996_vif_link *link,
 			     struct ieee80211_he_obss_pd *he_obss_pd)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = phy->dev;
-	u8 omac = mvif->deflink.mt76.omac_idx;
+	u8 omac = link->mt76.omac_idx;
 	struct {
 		u8 band_idx;
 		u8 __rsv[3];
@@ -4270,7 +4270,8 @@ mt7996_mcu_set_obss_spr_bitmap(struct mt7996_phy *phy,
 				 sizeof(req), true);
 }
 
-int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy,
+			    struct mt7996_vif_link *link,
 			    struct ieee80211_he_obss_pd *he_obss_pd)
 {
 	int ret;
@@ -4304,7 +4305,7 @@ int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 		return ret;
 
 	/* Set SR prohibit */
-	ret = mt7996_mcu_set_obss_spr_siga(phy, vif, he_obss_pd);
+	ret = mt7996_mcu_set_obss_spr_siga(phy, link, he_obss_pd);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 8a347dd8e648a43250e7dd717cb65f77cb4a61dd..45280f8f34fc4a56dddb3944232c17fdf4b61f69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -595,7 +595,8 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 				    struct ieee80211_vif *vif, u32 changed);
-int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy,
+			    struct mt7996_vif_link *link,
 			    struct ieee80211_he_obss_pd *he_obss_pd);
 int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 			     struct ieee80211_vif *vif,

-- 
2.48.1


