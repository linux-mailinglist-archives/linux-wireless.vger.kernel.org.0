Return-Path: <linux-wireless+bounces-25695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BDB0B987
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181911896B8E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EB38DE1;
	Mon, 21 Jul 2025 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IguS2frK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FA1442E8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057221; cv=none; b=Aa8Tyux28U137bcsa1RUePEbX0Q27oLWln3M9O+8Qumtmi90gE4MjNaVbXyXolk1td5WjvxnLen7FQ+eMRn1jyfhM6kddsnRSJNZ5xprLtIspLqNROsnPOog4RHKHi4V5cojb5bJt4qaV57rHiEJrYz0nlmlwht2+AS2p7Pb3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057221; c=relaxed/simple;
	bh=jQPox0ZCbOjVsC+CxGE75JSUdmvEbzjD2OsTi8jUhHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAXwYdJSFL9H/2/eftpLyKB6/jEcRpkaWvz9bJHptSPudZPl+c9ScsCQOimZPwCGoHeOyQr8u6fma5VHJjqcmYyjXGtHi+Ji9TXPzEzvL/PnffdlsUcmnBiOIVreM+gzrAxXxsKkBdwERzxhLInfrXPSTdi6xPkbCAcfEF41xOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IguS2frK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fba9f962so3318034b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057219; x=1753662019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftABiFlXeHTBBY49TZEf7354wK0WmIJ/d1x1S9G0CW0=;
        b=IguS2frKbnL45ycq+nCSgreN2zWZBLUGQ2gyVzJx1j+zM5/blaYcdJLdK/Emy6Uu4H
         QnUGrqPcTXAmsioSyxCN2SMJlU8I1HD2d9lii5aWUhvQodSPsKL/L5ILgqQLIAfFjv15
         017HkmNyZN/EhOFVz3lFZ15Hjf3L2uEb1ATP7uUUpOfj8rPwngmuFAg3vfDSbhllzbD8
         VvHL+qYFHH619BWp0uenNnZTFX0pay0lvBi+VGDInTs9ARf9Q6mhW6GCX1DUpiv70dHR
         hOJn/OxXPgQvT/h3a2G9uFyHHhZsRKcixSWeupB9IpjvsMFnSIXUY1AAgAJjFXZFWwA+
         vsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057219; x=1753662019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftABiFlXeHTBBY49TZEf7354wK0WmIJ/d1x1S9G0CW0=;
        b=bsh34RgV9Zpk8Du18jFEhhgP0R6HvxMO17ozIwFFooSnCrzoWxM3ZLToclI3Fv4KJG
         K2ENBzDjMcSOm/48k3ClJ2ZOWvJrYUyNe3o3yY19vADbR4S30l2qQQHGS51yDRLJSDAn
         gc83/DYjgd0ZCXfoTo5GejHISFOYcrZbFL48YgNChQqsvy+YPosjeEGx3dP2l3zQe08J
         a0DEjWcJqXIwhVSy0tOrvm7VAScy7bgh5xyD1cckoeyU2605+lbJU7JbTQzvL95a6n1o
         c0fez66OCwZp9n+nHqsb339/fBuxoXkn5ZRGgry1ytvGl9HtwCiKFxTthKIgcGvOQ2wN
         B2FA==
X-Gm-Message-State: AOJu0Yw2WTi60KPKEKgJuM8XpIp6F+e1XLC0FJmLcBac4M0ZCA3NJ/h7
	E0/1iXuPP1z7F47HYnI4kNH86NYmN4uCqW4oZGyGzeWZ9ldfHU+PJTTX+yZqxB0F
X-Gm-Gg: ASbGnctHoBn307L3cs8ZZfud1pl/5euCK3d71m0XiEgHvMPdYRFhynn9iqJhAFV/Td2
	dnjpP+cDZiaykE7MVJQfDkl0AVum3IWfcyD39MvcuCpRB2o22C9a7I44WX+sya5VsgB1wBYYLM2
	Zglc14aPcZNuAKmjJkqR7g4FYqlKha45WN31uVP52GjSsHL9dm72b4/eU51Mn8i53rZQ6GQdIUo
	04KjxqH8ChlDvq50q5JP6ljJoBhrdMyO1tJBEsWtkvGU3abWQlsgQGTOlNBcoy4uEpFtftMeRU/
	wbHHMUs0khVjMVKRmCTNCdvJgqjA2ZcQ0UkSpkEiHYtfL+lk5tc1CyI0l0OCwhna9dav8jDoTJJ
	u2HTd9wIFiIw6Uu6D0vTnB++WawXedRfn+6r9QsFpZ6uT034FHGz97h08XJZQaMl2cJ1B+GZ2Xp
	5k2A++Iq8MSg==
X-Google-Smtp-Source: AGHT+IEHlP7lmnlQ3jQyw+IYNpy/BBs37yRGwsJHOsyGJ7jiHAl7dpDWl1KS2AOQD6CXCCN74b5cHA==
X-Received: by 2002:a05:6a00:801a:b0:748:a0b9:f873 with SMTP id d2e1a72fcca58-75837b80c84mr17977540b3a.9.1753057219420;
        Sun, 20 Jul 2025 17:20:19 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:19 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [PATCH 5/5] replace UNI add dev with EXT cmd
Date: Sun, 20 Jul 2025 17:19:05 -0700
Message-Id: <20250721001905.11614-6-tnguy3333@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721001905.11614-1-tnguy3333@gmail.com>
References: <20250721001905.11614-1-tnguy3333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

change add_dev_info from a UNI cmd to an EXT cmd. This fixed the timeout from the UNI cmd and allowed the card to scan networks. But I am not sure if this is the correct solution.

Signed-off-by: tnguy3333 <tnguy3333@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7902/mac.c   |  5 +--
 .../net/wireless/mediatek/mt76/mt7902/main.c  |  5 +--
 .../net/wireless/mediatek/mt76/mt7902/mcu.c   | 41 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7902/mt7902.h    |  3 ++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mac.c b/drivers/net/wireless/mediatek/mt76/mt7902/mac.c
index d36b3c480..eca1d314d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mac.c
@@ -635,9 +635,8 @@ mt7902_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
-				    &mvif->bss_conf.mt76,
-				    &mvif->sta.deflink.wcid, true);
+	mt7902_mcu_add_dev_info(&dev->mphy, &vif->bss_conf, &mvif->bss_conf.mt76, true);
+
 	mt7902_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/main.c b/drivers/net/wireless/mediatek/mt76/mt7902/main.c
index 841b3309a..bea0c6d85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/main.c
@@ -317,9 +317,8 @@ mt7902_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.mt76.band_idx = 0;
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
-					  &mvif->bss_conf.mt76,
-					  &mvif->sta.deflink.wcid, true);
+	ret = mt7902_mcu_add_dev_info(&dev->mphy, &vif->bss_conf, &mvif->bss_conf.mt76, true);
+
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
index 677c2c165..8b49834e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
@@ -1550,3 +1550,44 @@ int mt7902_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(RSSI_MONITOR),
 				 &data, sizeof(data), false);
 }
+
+int mt7902_mcu_add_dev_info(struct mt76_phy *phy,
+			    struct ieee80211_bss_conf *bss_conf,
+                struct mt76_vif_link *mvif, bool enable)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct req_hdr { 
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 tlv_num;
+			u8 is_tlv_append;
+			u8 rsv[3];
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 band_idx;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} data = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+			.band_idx = mvif->band_idx,
+		},
+	};
+	
+    memcpy(data.tlv.omac_addr, bss_conf->addr, ETH_ALEN);
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(DEV_INFO_UPDATE),
+				 &data, sizeof(data), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
index debd18034..f93d7c14b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
@@ -337,4 +337,7 @@ int mt7902_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
 void mt7902_roc_abort_sync(struct mt792x_dev *dev);
 int mt7902_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7902_mcu_add_dev_info(struct mt76_phy *phy,
+			    struct ieee80211_bss_conf *bss_conf,
+                struct mt76_vif_link *mvif, bool enable);
 #endif
-- 
2.39.5


