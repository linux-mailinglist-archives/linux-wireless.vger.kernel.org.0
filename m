Return-Path: <linux-wireless+bounces-8919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A72906243
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC27B22A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083D712D775;
	Thu, 13 Jun 2024 03:03:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB812D741
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247788; cv=none; b=WMII9JVBv3dWy8GQaPkKgA7cvwgWuC3ykIAFXdiS/QrAFLzk13o55TvrY31lDScY69yWJ5DXFhJr8aJ0eBep75Km2ZQVS7FfhFFag5qzHz6gDDpaISkB3+3PWZGi02iojCcVLa3sM82QER7qbozWt1rcoKVYe3qbr4pswlK1Xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247788; c=relaxed/simple;
	bh=yQG/liEzSrt1oNVfTzjEbhr4kIaZc7kMmRKr6z41tYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJal96G18qSVtmS4lR1AvUSVH900EhPQYS6Lazq/C/0DXjPEnbLmIoNRyxOS5g6ZzJzYU28Q6v04HEP4TsrcaXADCWPceZw74dGmayR+JXwEg/XmDNbGbFiz0mI9t6tNICnHac15swQb98HntAvm8ndQwR/+tjpGhWR9bVA5rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24c5ec50da1so91995fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247786; x=1718852586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rafBksQtkYVoC/BWTavX7eiqg0TRwXU04Jibtu1TkE=;
        b=hSJ/SHNYmbiTTSKX3ijaX/3Ki+nXz8VyN4i5gD9SIOPFP+Yvb8AWT6l6ddyb515+wD
         5B+Nvnt1UqHUGEsTSY+dCrIbNavTNNSZo8/b4YsTJCsuMPTTMxf9dVLJcofuBOj3Xhog
         HBJR/A1XB8y3iX7CsYJy/bDf5REfGnx5ExCbD1lgTQPrQ94MVJkujoRjyQzmkjMcwKnV
         d7V0A8S0DhV/PR7BhBXgEzoEzaPSTrg2g91M/Vpgj25LnO/a6y/f8lJf403rNniFzRCL
         rxjZDa2tClfnzjpNB3jQ2I1MuTm++37dFfbnLc058eU8vVBRZOVyyneI1s/Eusbk2fpV
         ej1A==
X-Forwarded-Encrypted: i=1; AJvYcCUTk79/2ZuUydf/XUk8fY2q42EthO+tPtS9ZXSxxkyEY3iOSjNOxeWFC9lrn3HP/bcAZlD1bZ+xpnWVIDFgzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycR7NBjHlYKikhWabE7S4NZzozn40L9v8a+9jYwNvLc2H03tfQ
	/Av9HB20nXT3+n7T6R1vbjyxY0naxbyw9HVmR0WY5C1uA5NoTyD/40R5U9eNsO8=
X-Google-Smtp-Source: AGHT+IGwwyNIftQ14L3NdNPlplOU/t7cE5px2Mk4ncDXYt5dNmPrtoCQqI/UUXuRnSHlTazF+mKdpg==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr285145eaf.1.1718247786634;
        Wed, 12 Jun 2024 20:03:06 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:04 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 09/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:03 -0700
Message-Id: <20240613030241.5771-10-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_ifs_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b82cc1bd09b6..7cde18e273d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2282,9 +2282,10 @@ mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct mt792x_phy *phy = mvif->phy;
 	struct bss_ifs_time_tlv *ifs_time;
 	struct tlv *tlv;
@@ -2307,7 +2308,7 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7925_mcu_bss_ifs_tlv(skb, link_conf->vif);
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
@@ -2337,7 +2338,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf->vif, sta);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf->vif);
 	mt7925_mcu_bss_mld_tlv(skb, link_conf->vif, sta);
-	mt7925_mcu_bss_ifs_tlv(skb, link_conf->vif);
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
 		mt7925_mcu_bss_he_tlv(skb, link_conf->vif, phy);
-- 
2.34.1


