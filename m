Return-Path: <linux-wireless+bounces-8932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74C906250
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9CB22D0C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE212D741;
	Thu, 13 Jun 2024 03:03:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6912D1F4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247815; cv=none; b=c9ROhkF+sPc3+0CwqFKlfVY54lvNZIoarEydB+Zna9c4h0X8CUxID36T+Idfm8xZ0en/dG9ma/ghObACkfjotnjBNwOy1p8HkWGBbaDih/Icmv0qdi87WOSh3w3hMbT0b1plyfGLtYb1sPix0M58zdsNwlXknhibLVUAWb/4cZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247815; c=relaxed/simple;
	bh=NjZhF+cyVqimbqu2LdInjBEP1ItVL1rvNEJ1I2W9sAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeqFPOxcKQoiXRrG14bH6BYUEiQkW54YMZYnjkxwrIqK1ShkqjlvdFAfpKg4btMCw4Hg6wk1kmdLvS6rll6w1pnOAyToBpII6hJkiIJqmSqCz5kJjo7F7u2dBJDWW49INLCZxPpijMAi2ZkCeIfxG4DqxzChcZXqpUWr0KVTrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d21b50f8b4so68949b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247813; x=1718852613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGRn4/Wgu/vGKDWZbS0IzrBOwXTYDZC60PiS/4b5DP4=;
        b=hnd52Ofg2LBHlEJzQnlp33Ch1lSOCp5jeaLn/lqcA9JPqAWJ0LvznA6sE+sL1dAFY+
         IDeqzt4izMw2u4+KjytBZwggEPm91OQfPqzW6i2us4iEkbokC4YK4KkPh9nYG3D6nAH/
         JbEe+uSLTsthhZAs2RGsNl9oWXxuRPTCAerO46q/I9VplWADL2ZuJ+Z7TZXec63WkXc2
         9aWYNfbuJEmyFMBwK2w7TxdMJEF1sehkOJDkNh0FUOWCCM5vOuGK2zHzGBTobxuZyyA7
         A+Xrsq6NOO3jUWx5vhBJfFOwEBtkcnZSMrV5EENPRbAponq/3H4VE5JI7RCasM5B9RMk
         ta6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXp1q+vJjJgNQ4HnnvrwiCAUli53F5+3GVN1O2Z+HdFiaJGiV0CuVUuIMOcZ0etG3gnsxnBf02qW8dEkplMR1MGIi4asf6dqgD6EvLyMU=
X-Gm-Message-State: AOJu0YxnFkhO5yAd8bs9Vg/TReDA8BLoGSDpthaob+wVxo8cTpbBj5uF
	rWLJSOZlpQ7GQ98qN8+OL5BRvc7RXnQsPiSPsxnO3oNYR9SyT/ntFDoJM+IORhE=
X-Google-Smtp-Source: AGHT+IGZZIXSuAtLjTNDDqH8OylfxsZpnDgIc8G0PeqfW+LZ2/hJmFbjT3WLNdavwiiSKTjmqDC1FA==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3671924eaf.0.1718247813511;
        Wed, 12 Jun 2024 20:03:33 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:31 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 22/47] wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
Date: Wed, 12 Jun 2024 20:02:16 -0700
Message-Id: <20240613030241.5771-23-sean.wang@kernel.org>
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

add mt7925_mcu_bss_rlm_tlv to maintain consistency with the other TLVs that
constitute the command for creating the per-link BSS.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 64 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 16 +++++
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7624ec23e064..96b7a9df17d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1921,6 +1921,59 @@ mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 				 &req, sizeof(req), true);
 }
 
+static
+void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+			    struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	enum nl80211_band band = chandef->chan->band;
+	struct bss_rlm_tlv *req;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
+	req = (struct bss_rlm_tlv *)tlv;
+	req->control_channel = chandef->chan->hw_value,
+	req->center_chan = ieee80211_frequency_to_channel(freq1),
+	req->center_chan2 = ieee80211_frequency_to_channel(freq2),
+	req->tx_streams = hweight8(phy->antenna_mask),
+	req->ht_op_info = 4, /* set HT 40M allowed */
+	req->rx_streams = hweight8(phy->antenna_mask),
+	req->band = band;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		req->bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		req->bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		req->bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		req->bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		req->bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		req->bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		req->bw = CMD_CBW_20MHZ;
+		req->ht_op_info = 0;
+		break;
+	}
+
+	if (req->control_channel < req->center_chan)
+		req->sco = 1; /* SCA */
+	else if (req->control_channel > req->center_chan)
+		req->sco = 3; /* SCB */
+}
+
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 			 struct ieee80211_chanctx_conf *ctx)
 {
@@ -2326,9 +2379,10 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    int enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif,
+							   link_conf->link_id);
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
-	int err;
 
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->bss_conf.mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
@@ -2350,12 +2404,10 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				    MCU_UNI_CMD(BSS_INFO_UPDATE), true);
-	if (err < 0)
-		return err;
+	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, mconf->mt76.ctx);
 
-	return mt7925_mcu_set_chctx(phy->mt76, &mvif->bss_conf.mt76, ctx);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index d3584743c266..c5197577cdc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -456,6 +456,21 @@ struct bss_ifs_time_tlv {
 	__le16 eifs_cck_time;
 } __packed;
 
+struct bss_rlm_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 control_channel;
+	u8 center_chan;
+	u8 center_chan2;
+	u8 bw;
+	u8 tx_streams;
+	u8 rx_streams;
+	u8 ht_op_info;
+	u8 sco;
+	u8 band;
+	u8 pad[3];
+} __packed;
+
 #define MT7925_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
 					 sizeof(struct sta_rec_basic) +		\
 					 sizeof(struct sta_rec_bf) +		\
@@ -484,6 +499,7 @@ struct bss_ifs_time_tlv {
 					 sizeof(struct bss_info_uni_he) +		\
 					 sizeof(struct bss_info_uni_bss_color) +	\
 					 sizeof(struct bss_ifs_time_tlv) +		\
+					 sizeof(struct bss_rlm_tlv) +		\
 					 sizeof(struct tlv))
 
 #define MT_CONNAC3_SKU_POWER_LIMIT      449
-- 
2.34.1


