Return-Path: <linux-wireless+bounces-16209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBB9EC165
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F76283EAD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407FAF9EC;
	Wed, 11 Dec 2024 01:19:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB52451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879980; cv=none; b=pYrnDpm1nfHAsAmP8z7N++4VY4Fke3L1S9i1zrPkRZJ++qToDqTzm01M+dTXBLM5wzFZQL7INeE09F+gsH2sXfRH6KTaKWISkjjR9oKpHKizsXheF6eMM5/Afcx3CzOWw8tV+Kxt5Fo9mGk5tsat5JejxkHVHsi3hHkNgYCIujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879980; c=relaxed/simple;
	bh=VYGgGm0ULbxa+KBg4Byg/FjyhggivEeLHz/5dEXj3ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jlm3psBdvXuO/e4qTcii+Gn0hjP8Ue5bDbhRkKXS7v26l+VldTqHhtTtYgk6uH/r0WDKUGyqkVWBLX8PGSUA4lF6KNsSx46qJA97FlyWyDyblcctQcJiR84BjpxwpGTRNlFraZPtHG7SVyOi/3S6JlZtRuDvbRDpIXJ+3+fWU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29fb532b668so949933fac.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879977; x=1734484777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R2p//Pqh9wUP2QmrJjZ02D5zzYfEnah5rmAeHm8NgI=;
        b=X6ZgDBandDZfaqiOoLgE773hi/W+ngPHevz7dbKJFacsw9O3444U7i+/VKdNz3r41+
         arM1DAs0oxMHlnCoOWLEpSvFm+KURfPqBt9TTIhWCcptiEl2x9gbLjftkF0d2Yo88agG
         vVWoUgCZTySKkoabedj+wEGVzUREv9XaEoLZuYhq5Tx+u77mLXIAU1546HILDptICeNK
         8K0Cs/nEe8MgzkE+Tgdqsbrfk3zb+EKh9JMbLTZpFUBIOVROq6DMoImyGq6Npmm7XF7h
         yAV6AaaplXPG2nb4iXTwMob7HlaAkR5Avi9jgsBUcf4cA+JWr/mNOAcPzJrWYaIXwBZN
         Jjhg==
X-Forwarded-Encrypted: i=1; AJvYcCVNOohU5j6nmC4oqgxcMGK5j/NVfTV303QU7/S7OCrJdx9sPggD5F1wbKy7Q8sBbM40CO+HwY7MSUetXNJasQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtiJ5WyZFswVLpjK9O60lRCcD34RJAQchWyQF4TxSm+OuTvbM
	BRRopCrtj3ITnfDjla1mJBO6we73S3M6NOqVzTLblc7Zm6q4N2gDEv8MzzBTobM=
X-Gm-Gg: ASbGnctqozSGeg4H4O9dt2JtPPEyhUOO9oAUrGwoTwX0DoK9Zgw5ffVcxchgHbnXDi0
	39UWtaPfaXR6jpTRZ4T62QvMSraFWUZdA/WRCw81L6ieGLkh7PpD+lLtLDsh6VSMjGot/+b97W1
	ecQGuAH2UcHeI8atmu/Tr4d3f0be0v2WXCw8JPfx7nCRTAkQXbmhxS87vISY5MOyNkp9TEnFVPE
	LY6ZsjaJGCZsPD+CH4LUWNSQmkHUsMGH+QNXNiF4Wop1pVK/eJsqEn4M0J9SpW+/yrYrRQ=
X-Google-Smtp-Source: AGHT+IGNuoBK7+mQMrPDJXe8k8x4BCL83y7Gl405d/qpVq9bNdqtQY2pnCr2AcEElpzXFVMS43aLUg==
X-Received: by 2002:a05:6871:6c0f:b0:29d:c5e8:e424 with SMTP id 586e51a60fabf-2a012b4f09cmr706059fac.9.1733879977589;
        Tue, 10 Dec 2024 17:19:37 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:36 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 01/17] wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO
Date: Tue, 10 Dec 2024 17:19:10 -0800
Message-Id: <20241211011926.5002-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

This commit extends the `mt76_connac_mcu_uni_add_dev` function to include
support for Multi-Link Operation (MLO). Additionally, backward
compatibility for MT7921 is preserved, enabling seamless integration with
existing setups.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c      | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c     | 3 ++-
 8 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 804d3f5a5244..5373937b0e04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1113,7 +1113,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	return mt76_connac_mcu_uni_add_dev(phy->mt76, &vif->bss_conf,
+	return mt76_connac_mcu_uni_add_dev(phy->mt76, &vif->bss_conf, &mvif->mt76,
 					   &mvif->sta.wcid, enable);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 77f3e92d581a..4171710d645c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1137,10 +1137,10 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
 
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
+				struct mt76_vif *mvif,
 				struct mt76_wcid *wcid,
 				bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)bss_conf->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1b0e80dfc346..57a8340fa700 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1938,6 +1938,7 @@ void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
 				bool enable, bool tx);
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
+				struct mt76_vif *mvif,
 				struct mt76_wcid *wcid,
 				bool enable);
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 047106b65d2b..bd1455698ebe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -647,6 +647,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 		ieee80211_disconnect(vif, true);
 
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+				    &mvif->bss_conf.mt76,
 				    &mvif->sta.deflink.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 573a2cd7fe45..1542c762e2a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -308,6 +308,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->bss_conf.mt76,
 					  &mvif->sta.deflink.wcid, true);
 	if (ret)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 634c42bbf23f..ddd406969061 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1271,6 +1271,7 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct ieee80211_bss_conf *bss_conf;
+	struct mt792x_bss_conf *mconf;
 	int i;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -1278,8 +1279,9 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		mconf = mt792x_vif_to_link(mvif, i);
 
-		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf,
+		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
 					    &mvif->sta.deflink.wcid, true);
 		mt7925_mcu_set_tx(dev, bss_conf);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 791c8b00e112..22a9437236c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -372,7 +372,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	else
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
 					  &mlink->wcid, true);
 	if (ret)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 042aa8d1b6e7..e6046bfbefe3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -151,7 +151,8 @@ void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, false);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
+				    &mlink->wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-- 
2.25.1


