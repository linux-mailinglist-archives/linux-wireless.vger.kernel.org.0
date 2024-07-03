Return-Path: <linux-wireless+bounces-9946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42739926A90
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F255E2815B3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169A19409E;
	Wed,  3 Jul 2024 21:43:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC711946B0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042985; cv=none; b=tdPmniI1YDF8ajma9aTBz/Ec5gXw4FjzTOYZpcds0VY4QHUXsksFtq4XN10R6ZSoSfBaPXgCtQaHIMbLiF0VC1ByRn4uNJ2mOzB9ygvFdR0rUWSvyHfpChHCR/PlgfpQJkxwWqJrEksY+woDYXNHMshMX+o8Jby4fk6pZXV9imc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042985; c=relaxed/simple;
	bh=5BCjT8wQktgyZweSNsUONgUbliDraAamanZAVP0gcOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGarYKbzRC7A92T/EsHpoWkA3E4m1eE9q2vTLZ3VdTnf83f5Hm8/FeokGdG+X2fS5t6rH5Ywt4j0OxBcyyLIPGGChTEXPxQwbDEPxqOL1iNxxW+KdG3/NfJfYWksHfjo1cfJrFF+6HXxrJyLrKMat8nHrzlIGhCQ2GUtXqHJL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70218c133adso134073a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042983; x=1720647783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0BFel98EDVIGHnXe5DFOMwxtme8/0IpNqrQiHcZbZk=;
        b=vkR5Qcm/s90dKJ4I705i7EqKJ0ZE3sZRKAzt4aU2mPkfdHG25v7HpmufZ1GTPhWGDv
         jB2OVx9VTwqC2OZDfKY6G1pi4zUWU2WhxZgwKGufxBaG4vClRfH2n4mdMxS9jqVzehin
         SGd+JUFEaoAJVIdKCGir1yAdCTtohg32OpgZFofEQl3KecdKzMAWFnW5UZMSnPkKEO1c
         V/6SQ4P4FI883U7Outy9dmZjFmZUBbuEYK+CbOmvr8GxmLq5oGy35MRtjWq9lyWjzccK
         P9ug2gUxr2aPjYsSVIbmeSUYnOaWRkn5tvswByVOuoMpXCS36MbbdxnYat7zMD8dTMLt
         2kPg==
X-Forwarded-Encrypted: i=1; AJvYcCVcAdrR1OKbLvCdjWx4ULyHlWMT/7ejDRKuUJMe10MVL0aZGRDzLzvxYf5wBBzhkLC3GjBqJcbmP3J2pH8mkgobHZHyrcF56QJM5AfO2Ms=
X-Gm-Message-State: AOJu0Yy1v3eFvzWPo4tqykNg41Le1UQPXil0LFC3/waNI7BXN9YyZyFv
	KJF1KCsjyc3vq5BS+VpLgkoQxOjOUSbfBgyB5gw/al6mrBLtpTw5
X-Google-Smtp-Source: AGHT+IHIBPuhs8S/MmmkZNFJsi7Mj84zI6cdYeuYdxvyA0eRKWGxKSOxqLyhUH0gAs/hnQgh4qCzhw==
X-Received: by 2002:a05:6830:4623:b0:700:ce5f:968c with SMTP id 46e09a7af769-702077496d6mr11309998a34.3.1720042982755;
        Wed, 03 Jul 2024 14:43:02 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:01 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 06/29] wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
Date: Wed,  3 Jul 2024 14:42:11 -0700
Message-Id: <e163127120c03ea1ba60230130e32fa3bc8e747c.1720042294.git.sean.wang@kernel.org>
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

We extended the function to be able multiple pieces of information
in a single event, supporting the future MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 31 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index ba91c8e37dff..5693c21bfb4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -313,16 +313,14 @@ mt7925_mcu_roc_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mvif->band_idx = grant->dbdcband;
 }
 
-static void
-mt7925_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
+static void mt7925_mcu_roc_handle_grant(struct mt792x_dev *dev,
+					struct tlv *tlv)
 {
 	struct ieee80211_hw *hw = dev->mt76.hw;
 	struct mt7925_roc_grant_tlv *grant;
-	struct mt7925_mcu_rxd *rxd;
 	int duration;
 
-	rxd = (struct mt7925_mcu_rxd *)skb->data;
-	grant = (struct mt7925_roc_grant_tlv *)(rxd->tlv + 4);
+	grant = (struct mt7925_roc_grant_tlv *)tlv;
 
 	/* should never happen */
 	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
@@ -340,6 +338,29 @@ mt7925_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
 		  jiffies + msecs_to_jiffies(duration));
 }
 
+static void
+mt7925_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct tlv *tlv;
+	int i = 0;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+
+	while (i < skb->len) {
+		tlv = (struct tlv *)(skb->data + i);
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_ROC_GRANT:
+			mt7925_mcu_roc_handle_grant(dev, tlv);
+			break;
+		case UNI_EVENT_ROC_GRANT_SUB_LINK:
+			break;
+		}
+
+		i += tlv->len;
+	}
+}
+
 static void
 mt7925_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8ec5a3a20202..2de1e38689e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -41,6 +41,7 @@ enum mt7925_roc_req {
 
 enum {
 	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_GRANT_SUB_LINK = 4,
 	UNI_EVENT_ROC_TAG_NUM
 };
 
-- 
2.25.1


