Return-Path: <linux-wireless+bounces-20241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64423A5DB34
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBEB188559F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC823F36D;
	Wed, 12 Mar 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYR7/iW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC923F36C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778079; cv=none; b=ZXLyWGY7p7d3nRFkMMw7SeJj0xdBcaMUNGySrVgJ+HHJWQ24bN+jClMHTnMEfzn6wbgi1FD1iWongI0q0XLGCxk+/jKjGH9w0AQ5ticc/xTaD2inbwFRYnQjzNUCHZq9knLwSig/OQn1IGVmaeTPEZosD7UZvVEFRvTwLbUe/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778079; c=relaxed/simple;
	bh=1rwqsZtektxFVVacUfzb8PV3XP4ZDGN9CBCejSLdGXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEYc7P6tWwNVfnWH48ndHMp3+v/prmb3lJ5shuXUuEQzjfzI4LyGajjFtfjqAwP4M5qYNrfa/mAI6PpHrfscLbmWxVxwxtsFBG6Ia7ZmnH0KeuIIzh22g38hj+LgDLOovW+FocEkmGrX4RdgL7WnCXFBULiVhpVBtzMpYv0X0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYR7/iW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56206C4CEE3;
	Wed, 12 Mar 2025 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778079;
	bh=1rwqsZtektxFVVacUfzb8PV3XP4ZDGN9CBCejSLdGXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FYR7/iW7zBYxnPVIjw9SP9/GFCYEpDuRVe9/jHNW4Q/RhKVUWY5nBtvTHteyRFnhA
	 57vCXWZ4HbHqdGHWUce6Ow7EubbYPU7Y/wPq/p3kOs2YQKyRoOqc6B9T4VyKVdcGEG
	 Q0s5B9itsy7jPhIlVs9+UeIhGow+uxT5B3FZGCPJg9avVf6kCwnSMLPDcYMeCIiTLW
	 1JoRD8HMdhcKQHqlY0qz8F6uLvPR/LIWi8J0lnT2L0E+lkkbTAOOohfJSHay/5aH1b
	 VjYSaCmxuc1sVyMpwJSv2Rn67kEOpVmsgTBksKZHuBIvkKhQeELkAvPrTQh24mMboY
	 GcntkwWxLMSDQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:59 +0100
Subject: [PATCH 15/21] wifi: mt76: mt7996: rework
 mt7996_net_fill_forward_path to support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-15-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rework mt7996_net_fill_forward_path routine in order to support multi-link
setup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 2bf6453975ae584b2ab7cc9a46cc80ad7d73d05d..4a33979ee8535303fa3d09ec4500546d26f700eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1973,13 +1973,26 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	struct mt7996_vif_link *mlink = &mvif->deflink;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_vif_link *link;
+	struct mt76_vif_link *mlink;
 	struct mt7996_phy *phy;
 
-	phy = mt7996_vif_link_phy(mlink);
+	mlink = rcu_dereference(mvif->mt76.link[msta->deflink_id]);
+	if (!mlink)
+		return -EIO;
+
+	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
+	if (!msta_link)
+		return -EIO;
+
+	if (!msta_link->wcid.sta || msta_link->wcid.idx > MT7996_WTBL_STA)
+		return -EIO;
+
+	link = (struct mt7996_vif_link *)mlink;
+	phy = mt7996_vif_link_phy(link);
 	if (!phy)
 		return -ENODEV;
 
@@ -1989,13 +2002,10 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (!msta_link->wcid.sta || msta_link->wcid.idx > MT7996_WTBL_STA)
-		return -EIO;
-
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
-	path->mtk_wdma.bss = mvif->deflink.mt76.idx;
+	path->mtk_wdma.bss = mlink->idx;
 	path->mtk_wdma.queue = 0;
 	path->mtk_wdma.wcid = msta_link->wcid.idx;
 

-- 
2.48.1


