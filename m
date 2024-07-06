Return-Path: <linux-wireless+bounces-10047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862889291EC
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F5B21E21
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8D4C3D0;
	Sat,  6 Jul 2024 08:29:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042997764E
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254552; cv=none; b=pRGxO+5yg1ciOYAWu1Qr6DJ/U24g6DaOYN65FlfJ9vZKeyB1NqAPZ3Fs8IeQp9NUcWHvYkcSyyNH6to8I+VvZrCuSAEG7LxCGc1D7dkpphg+0aTVkIcM/18hq7SyB4/XyFsxKgx5iLMHJkGEmca0UUkMji/PEbcZXhSDlhwS6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254552; c=relaxed/simple;
	bh=3VlftakvgxRKM2V+gcMcYqT2gYDMvc5EjqtcVotd3Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V11jdvahNnMzXEFwP4iWTxpYnE3ttIS8A+DnqJ3g8KwQoSrgtVpeVbIn219nsWkH31v3eZn3Q7G9V+EG7FIFBK/UPIbYE7PWWjwRJdA5jcGd8czRAIIDTW5ZCy/RMpWQZwOM8v8sgoXkyGYVL+ECeEzEkN6mA/NJT2o+kZViA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c5ec50da1so284898fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254550; x=1720859350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eCwn1bKaG54UOwYd5vhXMu34lcPREipp2grTwGDk8E=;
        b=RPg88mZ8V+wh7/9XL0wakIFOFQS5kVKf0Y/leiDQfLmo6XBbQTfw47oO2ubJMiGJ31
         hRDC3jhhM84G/fKC1LqJQboZ+GLvPLXzfBuIKEVN1RCHUpVSiTwg5LyZb7TPBdpPSYzn
         5EhXGZGCQM/NZC9vlwwZ9XrsntMSy35Vuz3cTEo4yBDv/5mKovyK9OOMzs3ccrSQkRUk
         u8UZbd0WBRopUgdRO35dbONKh60Lc2w64naufcTV01t5hqWjGoLOBm6WpxfU71qr1suM
         c4mqdVrBjq6rDwzaUUwCMv1ab12zTy3QtPG6xN8x5inC8AAFbf2zN54NGfIZWKbS1skC
         gH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAUlbdv4PaVZloeuysSc4tY0uUK3PZazMGNQI21OdGvP/MUkgwkIhBXgLLDr+2MrhnHxZ3WgGRCMa71LnKyPiDvNPF6XgCTZNQwXyR3a8=
X-Gm-Message-State: AOJu0Yy2CIxceND7xgUTgkGiPId0k6PZG7siLeD0DWvhOSB/EkxpXXqy
	tyO1skzShMFWwst9JvvWpz+DNEy1JsqPUs1qRYwy5QlHbgMnzlxEOPglAHIV
X-Google-Smtp-Source: AGHT+IFjkMIRk44IPW3cpLBvfOzwB/4c0UZ9v+0ZttSy9bIgMJdTO7220vFTAdeo69k/NcKoPjt8vA==
X-Received: by 2002:a05:6871:54a:b0:25d:f237:e108 with SMTP id 586e51a60fabf-25e2b5a1bfcmr6904305fac.0.1720254549966;
        Sat, 06 Jul 2024 01:29:09 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:08 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 28/37] wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
Date: Sat,  6 Jul 2024 01:28:08 -0700
Message-Id: <a3d03b0a1ca916b2b8b2e7c0afcdcd7e258d97c3.1720248331.git.sean.wang@kernel.org>
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

Update mt7925_mcu_bss_mld_tlv for the MLO-enabled firmware

The change remains compatible with the non-MLO mode and the
older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 53228bbed2c6..2ffd46f16921 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2513,17 +2513,21 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    int enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_dev *dev = phy->dev;
+	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
-	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->bss_conf.mt76,
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
+
 	/* bss_basic must be first */
 	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
-				 mvif->sta.deflink.wcid.idx, enable);
+				 mlink_bc->wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
@@ -2535,7 +2539,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
+	if (enable)
+		mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
-- 
2.25.1


