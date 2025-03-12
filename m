Return-Path: <linux-wireless+bounces-20245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB5A5DB38
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EEB3AA6FE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BA24061F;
	Wed, 12 Mar 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCK43Gr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E789240611
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778090; cv=none; b=Hwvcso0gYNXTXLpdt0OpYtobihWQt2Qxwbsd+j08XcldhnxMpAqkgWwZYHEr+6I9eUz4t5btlcytDuOM3PTApCCI7r7FwTURYxgGH4RPyirveBefQiknV0e835WAkFd+MeitwLwom9d4Rd+aK7cUMdub0OGVrh2TxgUWMKo0FME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778090; c=relaxed/simple;
	bh=39zJVl4unEfcbQLkDsBgo6CNVTE0OqnLRumgLqEDfuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBOMUdNNYqUCYAfC/Ffm8aFcyhy0Q6vWE3S7IgviBUpFjab/hUj/+YVgvBMmFO6RSsSq4Ei60E0ymBf35DjtYf/YV+1fqGkWpt8DvNOMwleGJ3Ed/YY6/Wh9HigNCe5YBsmBpm24LeAy/h5JJkEyLcFTdnqMEqcTbisqM33JzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCK43Gr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A5C4CEE3;
	Wed, 12 Mar 2025 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778089;
	bh=39zJVl4unEfcbQLkDsBgo6CNVTE0OqnLRumgLqEDfuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KCK43Gr8+skZLQcdMTG+/pr4fI5GMn6vsr62lz7kVVqL4gayd8W3K39+JSwzMXidW
	 uFrw+CQfPFZST1INNrrJDJqAlO2qeIZ/NJ4CFM09OyFB8n1eyxmDzcthOldRxwjS8l
	 cDUN00C90EhV7iV69BbB5YIhsgM8W8owdcyAIzPhr2LfGV1rbHkZM5WeQ+uGzpPeU+
	 47aiiR0pBXhindFknEcdl50hfkIOC6bYsd2xIBv8deJTBftTANuWtwndvfAtIQ3RRI
	 LgWA37aQ0VN7GDi/SweigLlYPq4DKDb01dTet9ndsdXcJl4e6S/yzu5/nVQxYJ6a4q
	 9ewg1xyrEr8TQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:14:03 +0100
Subject: [PATCH 19/21] wifi: mt76: mt7996: rework set/get_tsf callabcks to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-19-015b3d6fd928@kernel.org>
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

This is a preliminary patch in order to enable MLO for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 48 ++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 +-
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 6870ee189dca61a989d4b7cfde741588c8f18482..a52b4e71b267e9a72b69cb2ffbc95befb1cca655 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2732,7 +2732,7 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 
 		flow->sched = true;
 		flow->start_tsf = mt7996_mac_twt_sched_list_add(dev, flow);
-		curr_tsf = __mt7996_get_tsf(hw, msta->vif);
+		curr_tsf = __mt7996_get_tsf(hw, &msta->vif->deflink);
 		div_u64_rem(curr_tsf - flow->start_tsf, interval, &rem);
 		flow_tsf = curr_tsf + interval - rem;
 		twt_agrt->twt = cpu_to_le64(flow_tsf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 40efba5bcaac364f8aa1ebf528e283494178616b..8bcb4b8e3ef58c23294c16c10d38384bfba87e30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1336,10 +1336,10 @@ mt7996_get_stats(struct ieee80211_hw *hw,
 	return 0;
 }
 
-u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif)
+u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif_link *link)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
+	struct mt7996_phy *phy = link->phy;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -1351,8 +1351,8 @@ u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif)
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
-	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->deflink.mt76.omac_idx;
+	n = link->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : link->mt76.omac_idx;
 	/* TSF software read */
 	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
 		 MT_LPON_TCR_SW_READ);
@@ -1370,7 +1370,7 @@ mt7996_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	u64 ret;
 
 	mutex_lock(&dev->mt76.mutex);
-	ret = __mt7996_get_tsf(hw, mvif);
+	ret = __mt7996_get_tsf(hw, &mvif->deflink);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
@@ -1382,26 +1382,33 @@ mt7996_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
+	struct mt7996_vif_link *link;
+	struct mt7996_phy *phy;
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
-	if (!phy)
-		return;
-
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->deflink.mt76.omac_idx;
+	link = mt7996_vif_link(dev, vif, mvif->mt76.deflink_id);
+	if (!link)
+		goto unlock;
+
+	n = link->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : link->mt76.omac_idx;
+	phy = link->phy;
+	if (!phy)
+		goto unlock;
+
 	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
 	/* TSF software overwrite */
 	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
 		 MT_LPON_TCR_SW_WRITE);
 
+unlock:
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -1411,26 +1418,33 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
+	struct mt7996_vif_link *link;
+	struct mt7996_phy *phy;
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
-	if (!phy)
-		return;
-
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->deflink.mt76.omac_idx;
+	link = mt7996_vif_link(dev, vif, mvif->mt76.deflink_id);
+	if (!link)
+		goto unlock;
+
+	phy = link->phy;
+	if (!phy)
+		goto unlock;
+
+	n = link->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : link->mt76.omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
 	/* TSF software adjust*/
 	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
 		 MT_LPON_TCR_SW_ADJUST);
 
+unlock:
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 124a48e2706e412afc91af5e1c057fca40fe5e3c..815a3c68b8723469e32e74b85979eaf75c1b176a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -535,7 +535,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 				     void __iomem *mem_base, u32 device_id);
 void mt7996_wfsys_reset(struct mt7996_dev *dev);
 irqreturn_t mt7996_irq_handler(int irq, void *dev_instance);
-u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif);
+u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif_link *link);
 int mt7996_register_device(struct mt7996_dev *dev);
 void mt7996_unregister_device(struct mt7996_dev *dev);
 int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,

-- 
2.48.1


