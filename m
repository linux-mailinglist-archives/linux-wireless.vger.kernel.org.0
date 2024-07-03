Return-Path: <linux-wireless+bounces-9964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FB926AA5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C528576E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E41849FF;
	Wed,  3 Jul 2024 21:43:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CC1957F5
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043019; cv=none; b=JsD+8IO+LAU75dY0GxU3GqlBy9EEoHNFrIu+aaBv4DhG3ecEhJRQWvNnUhpz0o3zeE4/vSf7be+KQu26nURZPjkh/lUXDMBycjHscdLYaLxbwmg4bzbhG1ZSv8ERvrDctycAfwaQseKcCphAq8q1vpfVgSwFKj4oOqce5AsGgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043019; c=relaxed/simple;
	bh=XQIwFXJfarn/tZxiFN9JwHtsZDPrVdRaFY2it+P0FmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR9IRIOqyzo1ilx3lIS6fOaM5fzOHIbaauC+Qym5SYE0NP0IBn0Ht6EjytkInR6p/KdSYDYsC0wF9Y5AJcTlIfvjqh8RfXIZQT2e9vRIAoTP0QHzE7Gg+xALK2cnrYSfdkS6pda24dq1tIl5O2iMNpfhAGXLZGAdrTJwOLSvfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c5ec50da1so3622fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043017; x=1720647817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW7nAYSBD4glkIK9OSU6ZgZqDA0uvjteIHLwvRqU2zg=;
        b=MSLlpj/v2Rdt5PNhtXyWXIVQhlyYn8fjs9oOqVWe7nPaUhvXYEAadlhDrPHyl4ZU69
         NCVBPwMErBhxdCWF8+UwJ5t1p9Lx294FkkXkx+CCLHGZWzRLdlA332C+eUUBpltl7rIS
         F2ilr9Wk4+lNRXkxmDgm+KhdnVRqB12OrVmRfIYLVk4hlk3eN0R7hLiibGLtXgfZ9rLs
         MEgXgsz8Aei6AKwwwa+o1Ti9M6velTFBZp3+05wQDvZE/jRZJGuJoYVQ3ZgDD2jCsugu
         O3681tv+/A+HIHCvGU3N55vSALC5W6yGonb2+rAFVJrr22nMgHo53VCNwLk5kfgq5E5m
         U3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8m4zB3pI9yhY8bkLQsaqy2cLuxXp5g8/P5WDL1e4+sAzX5iR+89mdBKsIMK30obV35O1Zgi/LsmJXL6y2k9bzJqXretfGkF6aIKXo7gs=
X-Gm-Message-State: AOJu0YzCid1GpPIzX+m0lFvKkhYMs9yRa4fJf9saLC5Y4FFS3aEPAX6n
	jbel2X6F22Opy1P47HyIcXBz2U+350xagsm16QerngJTstg+QeIt
X-Google-Smtp-Source: AGHT+IH4XOZT62iIvZhEGPj3+iU/gi4uuYHksxIRuTmMEG197w45CPTYhpsRRPAJv8JVvFwYI78Ckg==
X-Received: by 2002:a9d:6b12:0:b0:701:f9f0:73d8 with SMTP id 46e09a7af769-7020772bb17mr13165353a34.2.1720043017154;
        Wed, 03 Jul 2024 14:43:37 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:35 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 24/29] wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
Date: Wed,  3 Jul 2024 14:42:29 -0700
Message-Id: <a1385a919fde52db93bdab67535d2ed4a95c82c3.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

update mt7925_mcu_bss_mld_tlv for the MLO-enabled firmware,
the change remains compatible with the non-MLO mode and the
older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 19 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  5 ++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 71f1fb9fbe2f..8e36fb211dcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2384,24 +2384,28 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 
 static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
-		       struct ieee80211_bss_conf *link_conf,
-		       struct ieee80211_link_sta *link_sta)
+		       struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	bool is_mld = ieee80211_vif_is_mld(link_conf->vif);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
+	bool is_mld;
+
+	is_mld = ieee80211_vif_is_mld(link_conf->vif) ||
+		 (hweight16(mvif->valid_links) > 1);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
 	mld = (struct bss_mld_tlv *)tlv;
 
-	mld->link_id = link_sta ? (is_mld ? link_conf->link_id : 0) : 0xff;
+	mld->link_id = is_mld ? link_conf->link_id : 0xff;
 	mld->group_mld_id = is_mld ? mconf->mt76.idx : 0xff;
 	mld->own_mld_id = mconf->mt76.idx + 32;
 	mld->remap_idx = 0xff;
+	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
+			     IEEE80211_EML_CAP_EMLSR_SUPP);
 
-	if (link_sta)
-		memcpy(mld->mac_addr, link_sta->addr, ETH_ALEN);
+	memcpy(mld->mac_addr, link_conf->addr, ETH_ALEN);
 }
 
 static void
@@ -2511,10 +2515,9 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
-
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-	mt7925_mcu_bss_mld_tlv(skb, link_conf, link_sta);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index f0b890ad43e7..545f6b2d524c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -366,7 +366,10 @@ struct bss_mld_tlv {
 	u8 mac_addr[ETH_ALEN];
 	u8 remap_idx;
 	u8 link_id;
-	u8 __rsv[2];
+	u8 eml_enable;
+	u8 max_link_num;
+	u8 hybrid_mode;
+	u8 __rsv[3];
 } __packed;
 
 struct sta_rec_ba_uni {
-- 
2.25.1


