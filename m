Return-Path: <linux-wireless+bounces-8955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52479906267
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AF91F225CB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAD12D741;
	Thu, 13 Jun 2024 03:04:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7013328E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247860; cv=none; b=NCpEosekj0NqkkVRW1bKeo/v2U8V0zN0zKCiM3EUuug1AYRH9e48c3/q2oOehLebXJ9sQ6emDa65n1dKSIe17tN2T3Uk6OwQRPQ1ShfpLxFHVM1j5GQtAd8OxboBl50hx+L4LHq3DTgfD1X474q8rICrWAEpi6nlsK4A7hQQFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247860; c=relaxed/simple;
	bh=calhk7y5YoRozECN1bzG8vwzQe0jLx4eEbdhS8zeWGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APqFWm0/AQ/0iftJCcBIvbwVMqDxtyaabGghZRb02U3pq1Z6a8XHeyFAbhC7YaOrNCdG4D0Wu+A122LO8hPTt0ECKRXbr1h6S+0TUfVJHJhfgus2NxdJ/N7vBBrrRTLBjX42xzYtX5Z3U2tDnN+upEneDjDX0Rt04htjW+c8Ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254e7bdfac1so83303fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247858; x=1718852658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swP0wzm8P3kzjuujDDrTBhNy4O6CiQrkwdq/UWr+JT4=;
        b=ogVnugsufeTWMAIl8DiTISBO2nc2V1jJIW0sMI+NhGrzpgXH3zBf/XzapOz1lgPW2p
         fIRfKmILe3/0BCTM9qCXDlm6r/pBem8kbZiB8T4bH+lVX+qohK2ZqWCSiWa9+I3cQ5Nd
         ntqrnozcusHzqNHTVwfO0G+yIKrOI6CQp5CIVSHj25o/kL2XmHX142mDPzqqJAlfCiPB
         YCkhSx5SMUQeqaZZ27+mbYpkzzUhnf1zZdDHePRlLNuODPwiu5E9rcOrYTPzpjipVTyv
         M6QqAH3tzcz8fu2Lmy1QEb+obUYcyLkllr5dHNyfOEStI4vN8Cxq89ydq7flBQjFKvoR
         NejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBARKQyf/WY3oLHfbDXi/4C3uhZ7ka21rKlpXZL39dP+DkP7nAV9m8HVb2LWsCz+3CLjGqt1+PZtsSOH/FDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTjHXKy+UJKf0eUyu7WbxDY8anfKA58Z/mlbFGeCSh+R1AW6e
	XzWtggeFbyMFsU+7VVEw2oWHIlSK4GsrIE359dzebjVXo0A9JCcy
X-Google-Smtp-Source: AGHT+IH3wUed9ixLi58tAQqUtbD8UtozGL9FegbZuRRfCfvGNhzx87amQWMcRaq7ZAbMt3fmnTPW1Q==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3998081eaf.0.1718247857771;
        Wed, 12 Jun 2024 20:04:17 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:16 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 45/47] wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
Date: Wed, 12 Jun 2024 20:02:39 -0700
Message-Id: <20240613030241.5771-46-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

The mt7925_mac_link_bss_add function currently creates the per-link BSS.
We will extend this function when we implement the MLO functionality.

This patch only includes structural changes and does not involve any
logic changes.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 80 ++++++++++++-------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ce5379c4d55d..611138acd16d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -317,63 +317,81 @@ static int mt7925_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static int
-mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct mt792x_link_sta *mlink)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_vif *mvif = mconf->vif;
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mt792x_mutex_acquire(dev);
-
-	mvif->bss_conf.mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->bss_conf.mt76.idx >= MT792x_MAX_INTERFACES) {
+	mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
-	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
-	mvif->phy = phy;
-	mvif->bss_conf.mt76.band_idx = 0;
-	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
-	mvif->bss_conf.vif = mvif;
+	mconf->mt76.omac_idx = mconf->mt76.idx;
+	mconf->mt76.band_idx = 0;
+	mconf->mt76.wmm_idx = mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
-	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
+	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
+		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
 	else
-		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
+		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
-					  &mvif->sta.deflink.wcid, true);
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
+					  &mlink->wcid, true);
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT_ULL(mvif->bss_conf.mt76.idx);
-	phy->omac_mask |= BIT_ULL(mvif->bss_conf.mt76.omac_idx);
+	dev->mt76.vif_mask |= BIT_ULL(mconf->mt76.idx);
+	mvif->phy->omac_mask |= BIT_ULL(mconf->mt76.omac_idx);
 
-	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
+	idx = MT792x_WTBL_RESERVED - mconf->mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.deflink.wcid.poll_list);
-	mvif->sta.deflink.wcid.idx = idx;
-	mvif->sta.deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	mvif->sta.deflink.wcid.hw_key_idx = -1;
-	mvif->sta.deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mvif->sta.vif = mvif;
-	mt76_wcid_init(&mvif->sta.deflink.wcid);
+	INIT_LIST_HEAD(&mlink->wcid.poll_list);
+	mlink->wcid.idx = idx;
+	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.hw_key_idx = -1;
+	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&mlink->wcid);
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ewma_rssi_init(&mvif->bss_conf.rssi);
+	ewma_rssi_init(&mconf->rssi);
 
-	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.deflink.wcid);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->wcid);
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
+out:
+	return ret;
+}
+
+static int
+mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	mvif->phy = phy;
+	mvif->bss_conf.vif = mvif;
+	mvif->sta.vif = mvif;
+
+	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
+	if (ret < 0)
+		goto out;
+
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 out:
 	mt792x_mutex_release(dev);
-- 
2.34.1


