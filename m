Return-Path: <linux-wireless+bounces-8915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575190623F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6EF1F21597
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358212BE84;
	Thu, 13 Jun 2024 03:03:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260B12D215
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247780; cv=none; b=Iz4PTXjmFfpU++I8vdyJMTzrgBFLTXD1jZ1hVchsmr1jpNu3X/+fVv0FIGkgUtWRAVqtDxBzR0XhEYmaZW/Qjgu+Fnhmiv0xxmbyL9pb2s3LNMV5y08o0HjSBvkHlbvtsvqjlXw3o2rxEsHzk03fIFlYuggIqq6skUgN1+d0zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247780; c=relaxed/simple;
	bh=pau4nEdAGFsujh/aUXRZD1mpIwD8q3g+zm+9/X8MXp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twHzwtfgVKApWnEqs472LnKYsoVzTGKjC9f0RajZTlylmBOoU0gA5WYcquRCRcs9u/B/5kGukfizalwvsmxIbOBViw8/cEeuUKnGDkbv2GVwWaSniFSA5O3TGLekk7IxLrV9NC9j5W4LWHlsFozekRuzICe/R6Nwb5tkn1qX7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b335681e82so46058eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247778; x=1718852578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSypuI4+csB/kfi/nwHBZLhLbLNyIXH/lXGa6Of3zO4=;
        b=tLsS6OCQwbA3YSmxF6Hf5spj1fATpMehoAr1oDImws5pKeWMYN2MGaJFZ47vy79Vqz
         xdYLudDW1IDa4reVQVhNNoAow0qsvWvkkuGFVXDRx8lbBeCrcHwVBLvWydB8bT6a9Tgb
         8uYzY7zLjoP4iC6xR3INnu18K0HHyrnlqPVNsVMzovbAEon6HY/mEAqjzo0tiuebHfAf
         S7GfjbxHyfQbk/r74bCChdCBOo+yd6MpJi6123Q6WUw7TxDMKL7ptpRHlwCUcyAjO+FN
         TCMxXBU2slF2Qkn3pCsng7Bp7VnzYRbYzXyl9DvkG9SoE9d5lpjWd807RJPjoEEQdr/D
         PZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZbqYqaQcmm2yM+Jav753XpTmaDmca7iqqtc0ttjN5ocuPxoVuWVk602Zz39RqCFhNfpcpVcV+W9zl2pGowA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+qUaS4pQUkN+qQTd0EooxOTvpdK+n9OZKzetMSfZtJnEmhxF
	Kl04NeyZdZS18wyb3Hk6D/KQ9eilmmSF8F7kkK1M00K3Y3ax3ZTnJGXnLj12DC4=
X-Google-Smtp-Source: AGHT+IEKah+J8c/h93DZRB0D9q1CdSrxG9zXcATvCRSvT1+vntCbU71Uc6a/3IEC3f2hU2EaOJ8DJw==
X-Received: by 2002:a05:6820:b0b:b0:5ba:c4ed:ee98 with SMTP id 006d021491bc7-5bb3b7a4c51mr3589055eaf.0.1718247778215;
        Wed, 12 Jun 2024 20:02:58 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:56 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 05/47] wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
Date: Wed, 12 Jun 2024 20:01:59 -0700
Message-Id: <20240613030241.5771-6-sean.wang@kernel.org>
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

Extend mt76_connac_mcu_uni_add_dev with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

We also extend link_idx field in mt76_connac_bss_basic_tlv for the firmware
to able to identify the link index in the MLO mode that is not harmful
for the current non-MLO mode.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 12 +++++++-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  2 +-
 8 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c807bd8d928d..792ae41f7c69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1109,8 +1109,8 @@ mt7615_mcu_uni_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	return mt76_connac_mcu_uni_add_dev(phy->mt76, vif, &mvif->sta.wcid,
-					   enable);
+	return mt76_connac_mcu_uni_add_dev(phy->mt76, &vif->bss_conf,
+					   &mvif->sta.wcid, enable);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fb8bd50eb7de..87f918461051 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1125,11 +1125,11 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
 
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
-				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf,
 				struct mt76_wcid *wcid,
 				bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)bss_conf->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -1141,7 +1141,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			__le16 tag;
 			__le16 len;
 			u8 active;
-			u8 pad;
+			u8 link_idx; /* not link_id */
 			u8 omac_addr[ETH_ALEN];
 		} __packed tlv;
 	} dev_req = {
@@ -1153,6 +1153,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
+			.link_idx = mvif->idx,
 		},
 	};
 	struct {
@@ -1175,12 +1176,13 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
 			.sta_idx = cpu_to_le16(wcid->idx),
 			.conn_state = 1,
+			.link_idx = mvif->idx,
 		},
 	};
 	int err, idx, cmd, len;
 	void *data;
 
-	switch (vif->type) {
+	switch (bss_conf->vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP:
@@ -1200,7 +1202,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 
-	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	memcpy(dev_req.tlv.omac_addr, bss_conf->vif->addr, ETH_ALEN);
 
 	cmd = enable ? MCU_UNI_CMD(DEV_INFO_UPDATE) : MCU_UNI_CMD(BSS_INFO_UPDATE);
 	data = enable ? (void *)&dev_req : (void *)&basic_req;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4d83ec2a0f9a..e6e8824c828e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1436,7 +1436,7 @@ struct mt76_connac_bss_basic_tlv {
 	__le16 sta_idx;
 	__le16 nonht_basic_phy;
 	u8 phymode_ext; /* bit(0) AX_6G */
-	u8 pad[1];
+	u8 link_idx;
 } __packed;
 
 struct mt76_connac_bss_qos_tlv {
@@ -1910,7 +1910,7 @@ void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
 				struct ieee80211_ampdu_params *params,
 				bool enable, bool tx);
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
-				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf,
 				struct mt76_wcid *wcid,
 				bool enable);
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5ea01c39e2e1..101cac747f9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -646,7 +646,8 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, true);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+				    &mvif->sta.deflink.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 89d47cce9e8b..c7e71043c257 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -306,8 +306,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.mt76.band_idx = 0;
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid,
-					  true);
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->sta.deflink.wcid, true);
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 88e7b2ff4593..48425fc4e7fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1243,7 +1243,8 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, true);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+				    &mvif->sta.deflink.wcid, true);
 	mt7925_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 397776ddf01a..b0c8b090d2ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -344,8 +344,8 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	else
 		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid,
-					  true);
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->sta.deflink.wcid, true);
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a189ae38f2d0..222204916b73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -124,7 +124,7 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 
 	mt792x_mutex_acquire(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, false);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf, &mvif->sta.deflink.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-- 
2.34.1


