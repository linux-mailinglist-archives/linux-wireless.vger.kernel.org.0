Return-Path: <linux-wireless+bounces-9966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A9926AA9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FAB1F23614
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6037198853;
	Wed,  3 Jul 2024 21:43:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D34198836
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043026; cv=none; b=BVAa2FRFPeO2FVcz6PF0kg+qOtUwCNIVFFtAV6/todk5TbP69AJfxiov4ka3inGJw4GZ2F7bmyOQg6yuu+p/yTc17pqtsnAieO1fEcX/U3bxQZMdJFUtH2DfiyKoXuqLmKUENhgmbZuiXDZ9agjDgTZOYilu/T2znM6Rv645SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043026; c=relaxed/simple;
	bh=BsRb2k1kWlxFWNjynAEmcF0M/HqeBIkEDC/5yz/MlMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sq/8433HQcQ/jq9QH800HhuBNf8MeSKMP+NJpd4p8QFCaCfgX2Gm27VlEjcMV+XBgSd2+4YcTdWZ9RSX3NpGafjVkK9H5dynLyHG5k5z6HL9ynaWQvstNd2/2AdQLx/ChNW57LX4HjshYopHflE0cK7d6K4/EsWEEx037iRwCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-254c411d816so3772fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043024; x=1720647824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6qob4+aEz9AnxDvyJPADamvZqFlBJwBhBj073zgKUw=;
        b=Iwp63aoDZtKvcdJEZnj2GAR53OvSQCyLktmg9+RFZ+hc0kR8WTOWtpwYd4XJnfeCMq
         RwjLoWRPyNPyOq6eVhOk2rNeh8SlhCjjgbPj0yVul+EyeC80f+hT3cdC8Rfa1gGSG1Pt
         cNYpsSovi0BDdirBE2Mp5CGg3duwhh/4tU4NS1AVwqfREpKoz+te9hB1XkNiqfrAb5Py
         u5SDnRdDD21xo4Sy/Pb9OHpNn4DG58CkCtslaf5Cwg+5lweVTGc6uLljovjH2DLTpAuO
         qdK6Xp4KWof+ECXu1oimuP7MSVEKXR92PNl0HiYhvrIrMCcS5Rs2k6VUeSSkhk8sEXob
         trzw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ay6peeJdiR6FhhfwGWd5h1xQS2afsKP4FPMwrc2U/vlHnv32R6RQSpbiOTw7OrwGdTQoZsFxsNj5l7b4iiI0Lz0fDujA+vyOIH/j5y8=
X-Gm-Message-State: AOJu0YxrwAs1AoiziScmLn9v+CqRv1f52JbmWtkHI8dCVhPkMt1YLi2d
	166Oyop2l4EX45/rVTTVh8eIbU/q6EWTRXbzSSk4YtxVkY40/OCy
X-Google-Smtp-Source: AGHT+IFRqrqB0oJS3To8CcpUlTALffwBa/HcXjrOdTq70HVTagouqm9arBdBlmJYNrdzs27Y8+RfEA==
X-Received: by 2002:a05:6830:68cd:b0:700:d697:6ca7 with SMTP id 46e09a7af769-70207554355mr12585737a34.0.1720043022162;
        Wed, 03 Jul 2024 14:43:42 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:39 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 26/29] wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
Date: Wed,  3 Jul 2024 14:42:31 -0700
Message-Id: <8b39975133d1c41ff724669562bd340eb2894617.1720042294.git.sean.wang@kernel.org>
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

update mt7925_mcu_sta_update for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  9 +++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 65 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  3 +-
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index e636b033b87e..9329c959674f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -545,6 +545,13 @@ struct sta_rec_muru {
 	} mimo_ul;
 } __packed;
 
+struct sta_rec_remove {
+	__le16 tag;
+	__le16 len;
+	u8 action;
+	u8 pad[3];
+} __packed;
+
 struct sta_phy {
 	u8 type;
 	u8 flag;
@@ -814,6 +821,8 @@ enum {
 	STA_REC_HE_V2 = 0x19,
 	STA_REC_MLD = 0x20,
 	STA_REC_EHT = 0x22,
+	STA_REC_MLD_OFF = 0x23,
+	STA_REC_REMOVE = 0x25,
 	STA_REC_PN_INFO = 0x26,
 	STA_REC_KEY_V3 = 0x27,
 	STA_REC_HDRT = 0x28,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 218efe543dbb..dcb8c506543b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1805,6 +1805,63 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
 
+static void
+mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
+{
+	struct sta_rec_remove *rem;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, 0x25, sizeof(*rem));
+	rem = (struct sta_rec_remove *)tlv;
+	rem->action = 0;
+}
+
+static int
+mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
+		       struct mt76_sta_cmd_info *info)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
+					      MT7925_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	if (info->enable)
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+					      info->link_sta,
+					      info->enable, info->newly);
+
+	if (info->enable && info->link_sta) {
+		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
+		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
+					     info->link_sta);
+		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
+					    info->vif, info->rcpi,
+					    info->state);
+		if (info->state != MT76_STA_INFO_STATE_NONE)
+			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
+	}
+
+	if (!info->enable) {
+		mt7925_mcu_sta_remove_tlv(skb);
+		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
+					sizeof(struct tlv));
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
+}
+
 int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 			  struct ieee80211_link_sta *link_sta,
 			  struct ieee80211_vif *vif, bool enable,
@@ -1823,6 +1880,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
+	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1831,7 +1889,12 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = link_sta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
-	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
+	if (ieee80211_vif_is_mld(vif))
+		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
+	else
+		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
+
+	return err;
 }
 
 int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 545f6b2d524c..8a0196699230 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -492,7 +492,8 @@ struct bss_rlm_tlv {
 					 sizeof(struct sta_rec_eht) +		\
 					 sizeof(struct sta_rec_hdr_trans) +	\
 					 sizeof(struct sta_rec_mld) +		\
-					 sizeof(struct tlv))
+					 sizeof(struct tlv) * 2 +		\
+					 sizeof(struct sta_rec_remove))
 
 #define MT7925_BSS_UPDATE_MAX_SIZE	(sizeof(struct bss_req_hdr) +		\
 					 sizeof(struct mt76_connac_bss_basic_tlv) +	\
-- 
2.25.1


