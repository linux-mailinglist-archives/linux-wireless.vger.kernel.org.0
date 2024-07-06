Return-Path: <linux-wireless+bounces-10025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CE9291D6
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B677282FBC
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D146556;
	Sat,  6 Jul 2024 08:28:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36B1C69D
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254514; cv=none; b=sIQzVyPm3L1oxZFCgoSB3K/5G/bLCWtjUcTCqhaEwXHEYeo/xkpJLCq8TXRj3j6jl2lg4CaOE25IGeM/iIu+i15Wy4DYI+5hAJKv5oCdfMirhKYRuR3g65mPcpXFDiDvc85sO7LooSWUFZYxZLU9cAs336kbGl9zvH+TRmir2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254514; c=relaxed/simple;
	bh=znP2Cgt90HO4+JvSLXy7NuID4K1SQoLSxGcP8wDUiwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YA8Diok9abRuiUuB+tOFH/dXokYsuvyRsch4ZkNlW2r4NMpngjF49KVMMAmd95fUyYt8x1pRUJwmpIYdRDsxkHnn7vbU/hCtm0A33WCroiiI0Ud9PjuGdi574GEE3+Q7aUSYIk1Gjpo6VSOyJ0HQkMyV9/4JzVF9KAqQJ56eSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e14bf05e5so95384fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254512; x=1720859312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8HH5g9CrxDDIkevGDqVubZk3Zy2h11RIiM+NpG21nw=;
        b=nmJuMxWPhpnmkgut5aJ7ZPoPMpNOIztfqt3Sw0svndvA+0rPAxlUI5IZ5pJ0vaUYY/
         F8E/Yg5kqyzTzLdqDlwN/61QIglMiJPjAbs9orYw0nXw6mfUFuO7tsq56i4s/TpSkjdh
         X4jP7RDa94ynPK0pCEOTvwc60Xg5jFNarn/HF7S1lz69GC9wZVMAAXHXKEpBE7GB0rxS
         YQF/fc051WJ7NO6oGo8s/xA5d5A/za2LJ+gm3vgHmXEy3cdGYzqnS9orYz1+pAG/m6bV
         Tl2byPV4QdQqvZ0iaT1MT+g56q6T613VUXswu04K0DUgBdzPNJTau5I48grURhnqgF+1
         GyeA==
X-Forwarded-Encrypted: i=1; AJvYcCUDTxMfEu5ZGvcZlY7b4bdkdPNXT53UP+7y0Y2o2tObsEIZM0qwiH8wJ9S2qRBhAHtPkP5mRao3Cr8Z1yZqAHFP/JY0dJco241OAjZKlE4=
X-Gm-Message-State: AOJu0Yy/mQ2FKfOrdnVeIUIs9r/CW8Cuzuo2pi4bWvwAhKdl9U9w4YBB
	ZQXDHIz6qgOvk3H38A/PSUZ46rsZE24chP8bnfzq1G69hihuAqBo
X-Google-Smtp-Source: AGHT+IELUobtU/tVmxvpCBwgfoU9MuC47Dl1sziXTOJx86m3iSk+c4RQTj/vErvNnxbqtl3bSuUB6w==
X-Received: by 2002:a05:6870:d892:b0:254:cae6:a812 with SMTP id 586e51a60fabf-25e2bf101a2mr6994918fac.3.1720254512168;
        Sat, 06 Jul 2024 01:28:32 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:30 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 06/37] wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
Date: Sat,  6 Jul 2024 01:27:46 -0700
Message-Id: <4be7b34904034d521dab147883b898b5402fd29f.1720248331.git.sean.wang@kernel.org>
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
index 1db81cf4d71d..8069b27ce61c 100644
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
index 7750049c42f2..b7f8802b9cd6 100644
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


