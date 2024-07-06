Return-Path: <linux-wireless+bounces-10048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A829291ED
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02731F2222C
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837C4D5BD;
	Sat,  6 Jul 2024 08:29:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546178C60
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254554; cv=none; b=fSdt5kGLU9iInSJQFLBYbadHk+0bHan4RKUR5SlIN7+RfQNQf0VXJEOAEko5xJl9p1weNXaB7toMoPpKIIDShhno55t7a6XmwvMQI/saAhnmb0MD5uNWMAzO0SkwqvWSTDuoaLPB/tHULDFnUfdkcxqLmkhSwEZvnPXqvPsBnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254554; c=relaxed/simple;
	bh=3H17vSjWaGX7W9O//sYDfqD9dDcSQE8ODm8yZm64QXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zg9WkDTM6seNCjmOJw/dKqb988NQ2y9pnHSWoZXN4PAVmZxCfpUA2KzjcNOMC8RGwA51Ys+duLFCkcM44+KRYuHP8CUtDqHhwWPiglAFO5meAxM03+VpVzhliU6WWupdswoo13l+q9ioBoQC8kFYTGdyJ9c5SntsWHLlwJzk4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e55d0f551so42863fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254552; x=1720859352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+USdL7ArJsY57rZRvrCt0BwNw+zeRk0nzAefn/Xndk=;
        b=tM04OAtBzDI4BuasE53SU79BDZVvvg86la4A1BLuPDZjlCWgtYskeQeyLVHQF4bKag
         qE7ST79J6smeVXQHrutBQKQYRywzzjcU8e/8U+U5y3WkXByJrgihw5YSCQTYR1tWhgSL
         NsKH+Yft0LmgYSp4MebZntMJzIpaqIH433wyAIJHL344xQrXa0JJGYJypXtfInqpYreE
         OcLNsyMxzfy4oUFTftFgdDft4X6EVwBFma1q9NANjBS66hmiyz9Znrvd21nJ+uXLDOb0
         yLZYZhI53RIA/1pAvXkuPrHZvajZYuTfY1e2rYpmo+z1nWGcvyOYgTEHg+qW0McvC+YC
         YLIw==
X-Forwarded-Encrypted: i=1; AJvYcCWsRB+HOT2XFfTdKHFTL3RBbXb84DdSk+gM3GLxNFitEvOlVJ1XYPr5b95JKONVXiz3UWF5m5EwOxvpnEdWM0lSylCrBoqzlIutgRfdjz0=
X-Gm-Message-State: AOJu0YzTn/AdHEdJqzGCGLpTXrq2KgB/XyfLKxDBSVS3GORUDSwh8zys
	KJWk9/5nQ++NgLYuPCHDvSY65YBIkXpwLUlXRMmkUWM4LCjZaAvC
X-Google-Smtp-Source: AGHT+IGP8iOYD5INfWsaL7Vr8mfVbnuHHO04NYvHLKOWfybrC1drsFZxus7lkGSvAzTF3rPmzj+Ipw==
X-Received: by 2002:a05:6871:5229:b0:25e:dce:491b with SMTP id 586e51a60fabf-25e2b8b79abmr6843926fac.1.1720254551753;
        Sat, 06 Jul 2024 01:29:11 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:10 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 29/37] wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
Date: Sat,  6 Jul 2024 01:28:09 -0700
Message-Id: <2e25bfc2d8aa503ecd1ba8099c6e54dce0c27b99.1720248331.git.sean.wang@kernel.org>
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

update mt7925_mcu_sta_update for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  9 +++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 68 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  3 +-
 3 files changed, 78 insertions(+), 2 deletions(-)

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
index 2ffd46f16921..28e974195be7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1812,6 +1812,66 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
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
+	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt792x_bss_conf *mconf;
+	struct sk_buff *skb;
+
+	mconf = mt792x_vif_to_link(mvif, info->wcid->link_id);
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, &mconf->mt76, info->wcid,
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
@@ -1830,6 +1890,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
+	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1838,7 +1899,12 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
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
index 7b0c6937f918..a97e5b539ab9 100644
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


