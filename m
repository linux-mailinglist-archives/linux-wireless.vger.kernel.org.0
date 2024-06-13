Return-Path: <linux-wireless+bounces-8948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8011906260
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65D91C2164D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1C12E1CE;
	Thu, 13 Jun 2024 03:04:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA612D215
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247849; cv=none; b=T9PP77d78nxZgkCNxnz1UDrhY6qSvuMF+n8a/6UZOqVlnquJn5CF0YP5kZ9+iu9Lr4yCoe8SqpC+vXzOTSVWk+JJqFFZysO5EYoqwW7y6NmeTKTmn1mTV31gNmCChlP30Wn/947K1NhUS7xdl9sBbkMqZ7zM1PQzm3fIxbyOq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247849; c=relaxed/simple;
	bh=o2knsyPLw0enm2ZUf4daM4lRbMVLDou8zZin1/FX63A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoyIZ5sthHTS2IaJF8oeAXlSX2tlFufHh/7LoHFfkn6drBbQLeYmiG4h4cNhmZFUVRQaaiHmOnZrgUgDVf2YbKaOmEKBNraVIjSjC2BXSBJBglYJ2DCtny3naVvWKNBkdUwelM3bO0HAy/POtU5WM78T0NzGaZG+e79qP3wwfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-254c411d816so65822fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247847; x=1718852647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqt/BEDIeXN+7dTIp0cSPJgFi4w6MtNYqvkOIFy6ERA=;
        b=bFXaqHmxC6Ar5SyEMZEDco6wriKzYei88PEm8QA74gr4HJ0NxG6iapuGKn/GNX04sr
         9Jd0F6AvI3nY2UyAf5mFX5uUOoJyy2avP5RIc6vCaArl96N3wgcWBaAbNxLB0zfoWZzT
         jf3p5MDwL1jVmbPUDzxORcX5t6Z3e6wYF+BS+Eg0b3Jl32NTZoPLu+NFkD7Vmg9cFKhn
         yzIUmQRJhxjwVQ1/Ksbi/WYIjRvR1fm+++NpxnEPc7+hGmbJk28bogxlicjFnrQRFXxj
         ZFBXMrLPWuHpyTwMLn4Sd8A4B53LTaWM13Y1zd5L+fPSVfy/VSPMupoWm50TJl9DF2aK
         ryCg==
X-Forwarded-Encrypted: i=1; AJvYcCUyBw+HLm1TrmeG1nH0M5ad/S+2UTMDV1mS9mP+nJTmzzBSEkRFDYJwXyxMJHIZ9Ks6APwJrjmF9AqNSu1MrHFo6Egh0js8ng3pdm1gCPM=
X-Gm-Message-State: AOJu0YxeL1SnPxDMawDMoL1bKOc+YVifUiQPek14AzU5pHZ1kj0XZBDZ
	RvVivgjEOy3KgVRBD3PptA873zbRdd4lAsQW1Vdfgj5uhDO0/Pt0cMGxfgrZIpI=
X-Google-Smtp-Source: AGHT+IHw7uKmZJqD7BB5NAXIQv9kZD1ke/Du0CzB7V5wqeMHLqU/91SdPlWac7kB2vk8CgeU5PaNCw==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3908405eaf.0.1718247846756;
        Wed, 12 Jun 2024 20:04:06 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:05 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 38/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:32 -0700
Message-Id: <20240613030241.5771-39-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_hdr_trans_tlv with per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 5a40979c0bba..667ecd44392d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -847,7 +847,7 @@ EXPORT_SYMBOL_GPL(mt7925_run_firmware);
 static void
 mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta)
+			     struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct sta_rec_hdr_trans *hdr_trans;
@@ -863,8 +863,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	if (sta)
-		wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (link_sta)
+		wcid = (struct mt76_wcid *)link_sta->sta->drv_priv;
 	else
 		wcid = &mvif->sta.deflink.wcid;
 
@@ -895,7 +895,7 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 		return PTR_ERR(skb);
 
 	/* starec hdr trans */
-	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, sta);
+	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, &sta->deflink);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
@@ -1664,12 +1664,8 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
 	}
 
-	if (info->enable) {
-		struct ieee80211_sta *sta = info->link_sta ?
-			info->link_sta->sta : NULL;
-
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, sta);
-	}
+	if (info->enable)
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
-- 
2.34.1


