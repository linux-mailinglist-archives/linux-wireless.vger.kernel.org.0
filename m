Return-Path: <linux-wireless+bounces-10056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC79291F5
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474B31F2239E
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377355888;
	Sat,  6 Jul 2024 08:29:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AB12D214
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254567; cv=none; b=HNCPfYlO28NGFDFmmWG5Ebts+TM2VKvggNiM4kSocwGjpPikQ8G662Q/x3k0IowcsNe7IPocmWBFE9rp0hKXsfVWUqYgPL2YT/hAJOILHBYgdWe90NYwaXsKKTI+XbSkpxKuNrgEOwLmd0A+J85dfu7T/UyiLPsoPNzGmSXv+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254567; c=relaxed/simple;
	bh=7Oj+vcYgy4jW6MATPCVU94v4YbWBTCAYUAmn2MYwjUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y16OIATLdwZZxhjsPHmMp0oS1yHJDZLO8VIsVUKPfFUPX+54J7Fb5Eew+iGgc+yMUxZaYrI036TNdABxcrEtwf9UxiXGBN+Hy+7LWZB7bN99znuG46LbNVl7J3i0So/ZopLUC29whJrCOOjEXl98hKpT3lHR483iv3ed2i6Vwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c5ec50da1so284907fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254565; x=1720859365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjLrFfQCCVnCNReIrv8FgOPJoGhFLKjOF2fw6M5UKFA=;
        b=vaKkDzrEl3nJ2F921zPIHOnltA5wdOS9Hmz9jLqteUs7xcPU9GG9tXOXtq1lKNCyIL
         nX8SOzUim5opYGCp3SIhWclpBsWWKli0KdgGKRYYhzbyVMR4JXO51uULsf1A5m89mxj3
         AaK3DBAmHtaCy4Fm/HbkZIrlzS5Jxa0/Z1l0X+00e4bUalR56wu8JCGt67Zquk/T16tN
         3127iu0smgv6v7pzMip+T/kd3mFICwMo7pFDgVxl/hM32SI1/sgJ9GeZ4nBFyOJq+lPA
         WU+3RJSivbzmNODjWaH8k8j0rnvaQw0LpNoIAwqZcTIqHOjVYsrI2StrKsqDFB/G6XlQ
         26bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3EyTMQUKqRgCYBnGwidbR5RHQd1KqdUAVHh2dI3FEFxu7VLyd2vNSevSgUmKfRZGpQo6LpfWqhOOyiRUEoHb2NP3AZP5Q0rtUEqx0LG4=
X-Gm-Message-State: AOJu0YxfBqSG7BCfMo1N68xIkWGhkQwYc2QOKElRh4PxJ7UndvvLTGRf
	4YjaYAoaGu0LjbUjDe04hErvVEOK/jTkGVAcW4H39SGJSTp4Cihb
X-Google-Smtp-Source: AGHT+IEZYIH1kmad4nC0WoETgsT1zmYli5oIUph3ObeeImE7AAkcePYHQa7IFlYEjWurI4v3OK5eDg==
X-Received: by 2002:a05:6870:a1a0:b0:254:7e18:7e1a with SMTP id 586e51a60fabf-25e2bff9792mr6813517fac.5.1720254565371;
        Sat, 06 Jul 2024 01:29:25 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:24 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 37/37] wifi: mt76: mt7925: enabling MLO when the firmware supports it
Date: Sat,  6 Jul 2024 01:28:17 -0700
Message-Id: <49c796b101e792c84bc2c0d74753022b75fd3355.1720248331.git.sean.wang@kernel.org>
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

Register MLD capability for the firmware supporting MLO.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  6 ++++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 29 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 +++++++++++++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 ++
 6 files changed, 59 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d6882c9fd6bc..4242d436de26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1402,6 +1402,7 @@ enum {
 	MT_NIC_CAP_WFDMA_REALLOC,
 	MT_NIC_CAP_6G,
 	MT_NIC_CAP_CHIP_CAP = 0x20,
+	MT_NIC_CAP_EML_CAP = 0x22,
 };
 
 #define UNI_WOW_DETECT_TYPE_MAGIC		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index c4cbc8976046..039949b344b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -179,6 +179,12 @@ static void mt7925_init_work(struct work_struct *work)
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7925_set_stream_he_eht_caps(&dev->phy);
 
+	ret = mt7925_init_mlo_caps(&dev->phy);
+	if (ret) {
+		dev_err(dev->mt76.dev, "MLO init failed\n");
+		return;
+	}
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0c4e106ae735..b5dd4430f459 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -236,6 +236,35 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
 }
 
+int mt7925_init_mlo_caps(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	static const u8 ext_capa_sta[] = {
+		[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+	};
+	static struct wiphy_iftype_ext_capab ext_capab[] = {
+		{
+			.iftype = NL80211_IFTYPE_STATION,
+			.extended_capabilities = ext_capa_sta,
+			.extended_capabilities_mask = ext_capa_sta,
+			.extended_capabilities_len = sizeof(ext_capa_sta),
+		},
+	};
+
+	if (!(phy->chip_cap & MT792x_CHIP_CAP_MLO_EVT_EN))
+		return 0;
+
+	ext_capab[0].eml_capabilities = phy->eml_cap;
+	ext_capab[0].mld_capa_and_ops =
+		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+	wiphy->iftype_ext_capab = ext_capab;
+	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ext_capab);
+
+	return 0;
+}
+
 static void
 __mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy,
 				struct ieee80211_supported_band *sband,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cb5c607b9260..ccc66c42c16c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -751,6 +751,20 @@ mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
 	dev->has_eht = cap->eht;
 }
 
+static void
+mt7925_mcu_parse_eml_cap(struct mt792x_dev *dev, char *data)
+{
+	struct mt7925_mcu_eml_cap {
+		u8 rsv[4];
+		__le16 eml_cap;
+		u8 rsv2[6];
+	} __packed * cap;
+
+	cap = (struct mt7925_mcu_eml_cap *)data;
+
+	dev->phy.eml_cap = le16_to_cpu(cap->eml_cap);
+}
+
 static int
 mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 {
@@ -805,6 +819,12 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 		case MT_NIC_CAP_PHY:
 			mt7925_mcu_parse_phy_cap(dev, tlv->data);
 			break;
+		case MT_NIC_CAP_CHIP_CAP:
+			memcpy(&dev->phy.chip_cap, (void *)skb->data, sizeof(u64));
+			break;
+		case MT_NIC_CAP_EML_CAP:
+			mt7925_mcu_parse_eml_cap(dev, tlv->data);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 1ae66629e39f..669f3a079d04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -235,6 +235,7 @@ void mt7925_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 void mt7925_stats_work(struct work_struct *work);
 void mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy);
+int mt7925_init_mlo_caps(struct mt792x_phy *phy);
 int mt7925_init_debugfs(struct mt792x_dev *dev);
 
 int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 5ede24116748..30635aeba363 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -27,6 +27,7 @@
 
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
 #define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
+#define MT792x_CHIP_CAP_MLO_EVT_EN BIT(2)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
@@ -163,6 +164,7 @@ struct mt792x_phy {
 #endif
 	void *clc[MT792x_CLC_MAX_NUM];
 	u64 chip_cap;
+	u16 eml_cap;
 
 	struct work_struct roc_work;
 	struct timer_list roc_timer;
-- 
2.25.1


