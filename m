Return-Path: <linux-wireless+bounces-10049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8F9291EE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779541C21AB2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303F5381E;
	Sat,  6 Jul 2024 08:29:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915E7A141
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254555; cv=none; b=rkthdDb3+J9KA2WcRt2KrSkecGT3Ixg8Hmr3+y0Mhrn4pvBFJesieq8hnh1amp4zvjU4TJaTbNm/fS3CucM2JA4R3iru4jfTHzqx+L/gWQf2WxP20KLoOm5sPOtwUfa8tlVCsEKEWHrl0X6fqvWW6tvDpu/twa3nsiDDbEi36EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254555; c=relaxed/simple;
	bh=BUII5W1P6rAdTQXNeR9cj+cCq0hOZXuA5e/s3FVl+8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uidalbWg/lrNXf4Q9p4mj6N7AxmqhRyZjETV7iTELq8hTXzxwaiHVSW8nSkR2So62fOwP/ZW8VzioQSMSBjAuCZHCIrGMuKL51VaLVbMzJZQLHRNSEt6qkhZTo+IPasF0OWX+vw6rYz2FRaZB3gi6C+U/yKz6BgCzUAt2lg6hGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25cd49906aeso209426fac.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254553; x=1720859353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hABRQwLJLR6OxmMGgOk958a22tboZU2bLLZXApf8UgE=;
        b=TW0CWhsMvARyOsyvVyHB7OS11mU5r0d5IDfmw1Gk9OEZgCkbpyP0erju4JFdpc2EGc
         OC7toBqTyit6Q2+9WMeNtvGwuMCpRbnmBhkaMRyQuptpLz6LQPRx1qJUCTuYkpnpkZqD
         rjLgqdgMtjNw2bRqNG2JzfxVhw/cg2XwYH7xWQnHOVznf9Y86r2v2Ef1dMdNWwI/EmfH
         Kxjwime9eUImyijbQErMfYNyS03UYqOTaR1ph3I96EuV8Zm7TuQ1P6M140nCmCaZldu9
         whxBTh9sky7NJL3X/iBaZkaVg/tA0oL34pNGFNFYx57uqYxXzv6kRSd67ff6l74pkl/P
         AR7A==
X-Forwarded-Encrypted: i=1; AJvYcCUlte3OlYFk2xq+0ySETUcn+beDJ78DrMhrF7XBUnTEqsgCJDGKyUOYTh8HpYIRQUluA+zDmqPURLXYARFKfYndYMmYOsJRED5sTjdNZUg=
X-Gm-Message-State: AOJu0Yxy/LXQOlFAaKLJ2O3bNDm9eqDClzKj6GAG1vr5Hhv0LqazRb7s
	ClpzIgQlKR0Q1qQE3pI9m7w2742UJ5PTqIV2tCuTtI2Apl76quKO
X-Google-Smtp-Source: AGHT+IFbH1Z2sSHmb2omoEiomfyOO8eR3oNEtCF75T2ElymMwSNPbM/yn0qrjMfkgoAwNd6Jb3/cMA==
X-Received: by 2002:a05:6870:b52a:b0:254:d417:34ff with SMTP id 586e51a60fabf-25e2bfedaafmr5497019fac.4.1720254553490;
        Sat, 06 Jul 2024 01:29:13 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:12 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 30/37] wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:10 -0700
Message-Id: <a1001592eeef4e4ee2c3e15dc94cca0815d64e59.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
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
index 28e974195be7..e6e57d11daf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1738,6 +1738,42 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
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
@@ -1858,8 +1894,12 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
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
index a97e5b539ab9..ac53bdc99332 100644
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


