Return-Path: <linux-wireless+bounces-9969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD2926AAE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6351F237D7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EA190694;
	Wed,  3 Jul 2024 21:43:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796B199225
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043033; cv=none; b=UXXdsqQYp6RZYEEe1OSqMAj9KvJ3/nxeaIrHCrCH+dhLlDSdl3LqIYSKa3bB8gy96pqgSgpqC4zuI+F2TYlDQnfR27nzMVkHXfo+/9352MzvX9DJpQhcz/HFn28zghmR2FMveGBrU13ntBajRWw/f7I05w7AjxA7hmSE4Au0abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043033; c=relaxed/simple;
	bh=E27SgwsGh71v1USUawd1DzvMoHzMVVfw44uNpuWdDNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5r1Vp4BU9HlT9OD+ZTGy/LfMaWT3GvvzcgmQMKHHJ3fWEbkNyLoqvYtl5cQiaEnvJOhLGWjzeVpVo//vF8E6+tcYaXHj+tvOBJInH+8d6rz3SI9SxVkfdVLNLmW4ob7Nyj2cFq8ZIOkdwg5+mcutBAmV9z8rkViEHFJZ+B3Rfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-700cee3c5f6so115698a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043030; x=1720647830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/n7VZ7fj0o/3ai4SZ3SKcdBS97sLOgxIRvgNtfo2Zc=;
        b=mzw0jYA8CGouKxzuR/ifMymRU25LhZExEZyNhW+c1wSH2AZZCxQ/ro5tJdvrv7kKNO
         gAkPpcC3+9SiGF/OX+glNh+aZGJmUquUxxY7d2RiLqUoVNf3uvdrnNvCqLFK3TwKg4hb
         WUGPVI8VP7y/CaXlm24I4r6/ZTaHFC16ujQJNXgLL63XFxyGID2FQAeZAaj8ZLlflMqR
         QKW/UX+1xZVOq4eFetC8glBWnwt2RC1iUdgwsXm+ftr4TxKwRI6sDe5DViaWGG8djjC5
         2CQGA+tYIxkfXiywQHE6s6IXhur0ApFO6miCxs1Is4f+Adce5i1DEWmdnWMXc11MqZ+m
         re8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJN76VqnPNWNbEXAw0TimF9458yG5kh4uM2nI0XVh5QnzNDmGR+xVBW7VMG1Ap7+Aw0/k/ApDyItGG0HW2CSqBmCxsYiZUUrhf/NTx17c=
X-Gm-Message-State: AOJu0YwjRYTbx0GR0caWylttrKHFeo14Z4PiM9TUSeLxySD8wab/+1ac
	XPKTItSd799fYlOLfWctffr99b7+ouXZKo91wZIeLWY5B25Wlr5g
X-Google-Smtp-Source: AGHT+IE4LsxQwXh0EZDYiJMTt6PW30ChD/EOSWZ2xrYLO5k/bhg54hR3h6oqAdq7s9sb9spqCpytDg==
X-Received: by 2002:a9d:65c5:0:b0:700:ca13:30bc with SMTP id 46e09a7af769-70207763b58mr13703746a34.2.1720043030407;
        Wed, 03 Jul 2024 14:43:50 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:48 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 29/29] wifi: mt76: mt7925: enabling MLO when the firmware supports it
Date: Wed,  3 Jul 2024 14:42:34 -0700
Message-Id: <fb549a3b3a20995c64d227fb3db75a2fe6f318b1.1720042294.git.sean.wang@kernel.org>
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
index 13b40032cd72..213331a92166 100644
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
index 829d87d4eb95..d4b020b50be1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -749,6 +749,20 @@ mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
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
@@ -803,6 +817,12 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
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
index 4c0ecae8e49b..d51cc8a02b9e 100644
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


