Return-Path: <linux-wireless+bounces-9967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD4926AAC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D941C2303D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EB1991B8;
	Wed,  3 Jul 2024 21:43:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC83194A54
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043028; cv=none; b=K7+Y4zTc6455Nj9zPEaqx27rVWTFxLVYT2395fcMMHlQZgcGoLS3YSNN4ClsYHeKpAq+PYpCBFB+VoEmbr9YNRjAJHYOCB2OnItDm35aBM4IAZIj2hSpCFjnS8MN+5MdJvrkidmyWhQH06AB3QM90rzhc1rTX6zX439gbHEHMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043028; c=relaxed/simple;
	bh=M5H6EPOyjRb4OpuF/XTy2Z6gvWVoYnoJc5CSv4U2y3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QU7yqzfoljFDb2W7PBAMdKXbqHV1bh+81ky6eK83v6EkoeIBVU6omOgJ6Wy5VzHShPH9kze6agqnXoQSmQxtZAJpSSRh5zr5zBajYqUoR6GRnWw57jPsWMJAyWv2xx5X8KmxXbZpnzklDi304WdP9yWjGuguktiQH6AFC0JKv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-700cee3c5f6so115696a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043026; x=1720647826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Zm2u2GDuUR87ImOZGiIFmMyIIv/8lErTyscfyIFe+M=;
        b=sJ6QkhYscsYIGKiT7xQDACaAAyWr9bAEYreYRlx2dlgsVBDwr4i6mxibiXXEoGDH86
         XR9BJUZShiM154rVzIhqShGjRP6zhfyEMlZJXm8z9fCBtO6vO8w81F4S7w/NPQfNxuHx
         R7rUNnvnaJygPFwft+K8lDkNQT4XdiB41TjHjr7rJoIIMOyEj5d9pr1ErOhQaD05S28w
         JGBQKPpQLdjq+2i9Wkh7qgL+GdFsWpGUFnPi8/a6Xq8vfMh025hIINo9w63VIdcF34e7
         gVPDqt2/tg0mHTi2CYVV0qEtqw1oOw9YHopoy/0iCuy47THkLh+Yi6KO5j8ZQEJWW9ne
         Z7yw==
X-Forwarded-Encrypted: i=1; AJvYcCXNFP9NU0Z6fi25jNQ44cq3FaWZbuCw8R3RUKmvmnaeTAXYp68aVwYjxjTyZEzjskItkfID+gCl7KjoF3NGGEetwlCD9cUaUT35UfvbPSo=
X-Gm-Message-State: AOJu0Yz/2xcwDSop5sD2PuxfAIInOIhuwjbwKuWojuWBejLSVpYRYM2t
	icPmfaNqzsJdLyku2qi67osy4iea4Pwt56B7O/4TbVHK1Oo3m1eS7F365oGH
X-Google-Smtp-Source: AGHT+IHOSLauwODbtAedsub0S622gbphfmI+pOTqu9GNMm9cAI1Tx7iKjETXO6xlPoYg3paWmDA2LQ==
X-Received: by 2002:a9d:65c5:0:b0:700:ca13:30bc with SMTP id 46e09a7af769-70207763b58mr13703603a34.2.1720043026332;
        Wed, 03 Jul 2024 14:43:46 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:44 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 27/29] wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
Date: Wed,  3 Jul 2024 14:42:32 -0700
Message-Id: <a561004e6894a7b68166c25c0bf4b6ecf48fc2b7.1720042294.git.sean.wang@kernel.org>
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

add mt7925_mcu_sta_eht_mld_tlv for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 42 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 11 +++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9329c959674f..d6882c9fd6bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -820,6 +820,7 @@ enum {
 	STA_REC_HE_6G = 0x17,
 	STA_REC_HE_V2 = 0x19,
 	STA_REC_MLD = 0x20,
+	STA_REC_EHT_MLD = 0x21,
 	STA_REC_EHT = 0x22,
 	STA_REC_MLD_OFF = 0x23,
 	STA_REC_REMOVE = 0x25,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index dcb8c506543b..36ddc64ed7d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1731,6 +1731,42 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 		       HT_MCS_MASK_NUM);
 }
 
+static void
+mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
+			   struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct wiphy *wiphy = mvif->phy->mt76->hw->wiphy;
+	const struct wiphy_iftype_ext_capab *ext_capa;
+	struct sta_rec_eht_mld *eht_mld;
+	struct tlv *tlv;
+	u16 eml_cap;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT_MLD, sizeof(*eht_mld));
+	eht_mld = (struct sta_rec_eht_mld *)tlv;
+	eht_mld->mld_type = 0xff;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return;
+
+	ext_capa = cfg80211_get_iftype_ext_capa(wiphy,
+						ieee80211_vif_type_p2p(vif));
+	if (!ext_capa)
+		return;
+
+	eml_cap = (vif->cfg.eml_cap & (IEEE80211_EML_CAP_EMLSR_SUPP |
+				       IEEE80211_EML_CAP_TRANSITION_TIMEOUT)) |
+		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
+						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY));
+
+	if (eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP) {
+		eht_mld->eml_cap[0] = u16_get_bits(eml_cap, GENMASK(7, 0));
+		eht_mld->eml_cap[1] = u16_get_bits(eml_cap, GENMASK(15, 8));
+	} else {
+		eht_mld->str_cap[0] = BIT(1);
+	}
+}
+
 static void
 mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
@@ -1848,8 +1884,12 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
 					    info->vif, info->rcpi,
 					    info->state);
-		if (info->state != MT76_STA_INFO_STATE_NONE)
+
+		if (info->state != MT76_STA_INFO_STATE_NONE) {
 			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
+		}
+
 		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 8a0196699230..5703176056db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -443,6 +443,17 @@ struct sta_rec_mld {
 	} __packed link[2];
 } __packed;
 
+struct sta_rec_eht_mld {
+	__le16 tag;
+	__le16 len;
+	u8 nsep;
+	u8 mld_type;
+	u8 __rsv1[1];
+	u8 str_cap[3];
+	u8 eml_cap[3];
+	u8 __rsv2[3];
+} __packed;
+
 struct bss_ifs_time_tlv {
 	__le16 tag;
 	__le16 len;
-- 
2.25.1


