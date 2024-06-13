Return-Path: <linux-wireless+bounces-8939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7F906257
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86621F22672
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D912CD9C;
	Thu, 13 Jun 2024 03:03:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A231304BD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247829; cv=none; b=iZJW7WReQtbr6Tk6uBgr9Q1uXdctPDGb+ydVUkTOEdTNGIJ7tVe9idcET9VeHV4kDFr0BMLzv1+4b5nzL86tZAuTVFj8RZzar5BJvophByVuLYw3V/9qRmfFkEYtuwjiiYIoIPp742nOunqRjpJ/DziHNEklHPj4XFFgsfiyONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247829; c=relaxed/simple;
	bh=wZk8NMxm/Ml2xdFIYo5T/Wf8VWWW1N4a/yh9KF7ZBHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uu2mu8iyzddpLvfQwiVkD3y7ksev+Z4wgNGRD/lyrUV9cRw3vm5wlvPtb0vtTe7LUUPX0ln5fR/3gUtHghRwJfLhs603OOL2UkULK7IoUnh0JYyvEOU6oZEnBdjJNsDtQ5nnizouii+WKUo0gbZf5jEqRgU35j5j0Uj27pPA6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d1b8bacf67so76885b6e.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247828; x=1718852628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4rId6s/qmy89OdkA2iSIQ271sV1Ry06U/w402v2yWU=;
        b=MH7pNuoOR9489mWNuPPWW99dfHP15jABLQm499SFJPXnhJvidOEac1qvZp+CO6SGOD
         A9tQkN//cf4YgRqJjzLK0vpN0vNxui49QELaxSg7LKhxMrCDMY5iP8uGBq+90Hn+RcMK
         CsDSDqxTrRLPqxfagMkWrrwg+bIxSiivRoeLf+A9Mh8OcOuvGBGdDCNvvrYJdpYp27cb
         Bt3a65+WnSYqncKo0CHzTv7tjG7pMnhe8i+R7hf3ONW6xLntLHYJzaRL3lxe63VG/XVm
         fvl0BLqmmLslnIrPmMDtmmbmWQ0hS2Xdi8obdmnL4UVN478YIC56Wvd2bO7ErP007PLD
         Nv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUusdOTqovnm396lvXuYNTqhL8pzwnTGPTK7IzStheS4NdzNOgATfk3XU0H1MnZWOumCtlzQ6Rbfyzzr902jQCMYH4Tm5baiURf3ZRuG90=
X-Gm-Message-State: AOJu0YyS1ohAWrf2qLYf3EzfOJTuuvcGKhtaALA4iau5Ndqd3qQxlXBh
	gonc/bHfNdbYZfLTqkmOsC/CGqL/HrtEPrQeSsM+BJdjuay4jjJP
X-Google-Smtp-Source: AGHT+IEpyH6w/EK2iWtAObLb4d3oRuoEuMedN2czPvggkOCgAvhOzzTMDXr5KCZ9o4tV5qlS9hho0Q==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3672524eaf.0.1718247827596;
        Wed, 12 Jun 2024 20:03:47 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:46 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 29/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:23 -0700
Message-Id: <20240613030241.5771-30-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_he_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e1dc8452468c..a57620aed63b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1380,12 +1380,12 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
 }
 
 static void
-mt7925_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7925_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
-	if (!sta->deflink.he_cap.has_he)
+	if (!link_sta->he_cap.has_he)
 		return;
 
-	mt76_connac_mcu_sta_he_tlv_v2(skb, sta);
+	mt76_connac_mcu_sta_he_tlv_v2(skb, link_sta->sta);
 }
 
 static void
@@ -1640,7 +1640,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta->sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_he_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
-- 
2.34.1


