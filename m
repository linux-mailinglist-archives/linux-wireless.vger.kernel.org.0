Return-Path: <linux-wireless+bounces-8941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E3906259
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44091C214BB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3F12CDAF;
	Thu, 13 Jun 2024 03:03:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7316130A68
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247834; cv=none; b=lTyjaomu26ejNQjw9C6Kgtz2IQ5W0jfWbAciP9kdKPyexmlO9Pank/+iTyVQC8nzP6TePiBXqti8CbjUUFVoBxX19CSIRanlTIPCAXR5tG5bbybLjzTzuK3N5yE7dVWyyhvj89SqmveqvKfBuZhvmBa0Go/uc1hw6cqBzqidJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247834; c=relaxed/simple;
	bh=rQmCIZTad6QRoIVkvKJCT6svW2UL6gdTyDb+Z+Ohies=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTDy2WP/iDELiYwCgnMZy6qOdDECW0CWsQmGu75hpe0pmuZrbfC/qIElfVVgKnpj58ku3R+RH2XOnrUSVLFTHZ6cp63c9Docwjb+NxoaXm8HmawX+CUyVtm3Kpes5eanvwWMmdAeV457Q1V8U7SH+NPvwsDu+7z5ckGID+2yb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25075f3f472so76663fac.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247832; x=1718852632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOSh1Koddm2iaRVlRwReJq6F4ShEOJmpd3jAFp1dhAY=;
        b=se/nlIjfuoEmKp7XOZtvUIuzSZJ7vYGqPcWbcDH+yVxtzrrx4Pl5m4Rdlr/wyhVlNQ
         POV2H46xlu/FWM8s7cofPcKKIJD0kk1x+GO93jvr5VhsXkV/n4mI3bjwD86u5PoToYOL
         GWtI3CarN9CQzU8FONUaQXeJd/PVfwh6PRu71CiUxoQmZ3y+T0hVQszIV/FQgw8cvJ8e
         nEXan4Z42xXzIjxEa7GV66WcSQqvUS3PC8yXAUucxjMsvG2L+t1qZ1Lu6OIohxegu2gW
         WIeFR6unE4tpQ8JfV/2/hkf0Hq75bsff55xmPjatbohyRR3UDPZGf9B22d4+IJ0ucx6Q
         AE2w==
X-Forwarded-Encrypted: i=1; AJvYcCWB7WZsfs0ds0dLc5LJmsn+xU/2cZMmFNJ8+CASrjvLlX6jMYYrJLTLCy/VKwb6npMHDvjLm7erPe4q64OmlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyShnH68kxi+eF+FCR8ORT0RdZKki4J0AtX59e3TalbGJRZ8232
	Oca95fXOKlOdB/MemBJmkJRuIcEJ2Ty1bMi5g5zFdp7hUHyuSSko
X-Google-Smtp-Source: AGHT+IGYCITyDhyJlZeMrVfawcG1NciHKDp7xm3y+tBp9yG1rxv/rqOikcaa9EXWVR3TN44OA71leQ==
X-Received: by 2002:a05:6820:b0b:b0:5ba:c4ed:ee98 with SMTP id 006d021491bc7-5bb3b7a4c51mr3590579eaf.0.1718247831716;
        Wed, 12 Jun 2024 20:03:51 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:49 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 31/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:25 -0700
Message-Id: <20240613030241.5771-32-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_vht_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 57b89eca4e21..1b66dd26bd1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1448,21 +1448,21 @@ mt7925_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7925_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7925_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_vht *vht;
 	struct tlv *tlv;
 
 	/* For 6G band, this tlv is necessary to let hw work normally */
-	if (!sta->deflink.he_6ghz_capa.capa && !sta->deflink.vht_cap.vht_supported)
+	if (!link_sta->he_6ghz_capa.capa && !link_sta->vht_cap.vht_supported)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
 
 	vht = (struct sta_rec_vht *)tlv;
-	vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
-	vht->vht_rx_mcs_map = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
-	vht->vht_tx_mcs_map = sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
+	vht->vht_cap = cpu_to_le32(link_sta->vht_cap.cap);
+	vht->vht_rx_mcs_map = link_sta->vht_cap.vht_mcs.rx_mcs_map;
+	vht->vht_tx_mcs_map = link_sta->vht_cap.vht_mcs.tx_mcs_map;
 }
 
 static void
@@ -1641,7 +1641,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	if (info->link_sta && info->enable) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta->sta);
-		mt7925_mcu_sta_vht_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
-- 
2.34.1


