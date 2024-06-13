Return-Path: <linux-wireless+bounces-8933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC60906251
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407FC1F2262C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E818028;
	Thu, 13 Jun 2024 03:03:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE412D1F4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247818; cv=none; b=sXyToC2BdfuOrKU/tf/dZ1+40Wodte3pB/psg6Wz/NDz+gp7lHKXb5k3HAdKjDI7yUpgnB4YQq1XJItVRV4j9Qy+nbO1Om8INzMHaAkVgw10yQRiKMkZG9GhSGrKvlK24S6jyw+/BafALDd81ytkg3S8qk4RGHf9h3DFA0lliJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247818; c=relaxed/simple;
	bh=wN3upKJBUWWOxO+5nY8XC1aotIwI8XaJCBue7UGnlyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfXzI2ilWtFbFxMs21dIULzdzYX9JHighNhRXccAXKpZXZ10jrDYYYvPFNd/2sWAX/jI+puloaYRwUy/ykbWnzekqsjhP7B442EM3vcU2wKfPn+N6E7JEqLYOAaGCn5z7f8Szm+h5FP0/4EyGQq9z0MQRYO6TYi1hcsHMKVVcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b97f09cde3so43143eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247816; x=1718852616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biE13+3PSSXUiakyN44C2L8O3X99s+HJgpD9eJi/PQg=;
        b=bIaG0rLp6fYoI/X/dRfrVV10BDHTjCui8qNxCQ4aSnjSckziHhtHmbcTo5PACckKVE
         TIh4f0unLz6lEP7gQD3Pvtwz7G31kzGRKrRrVAwvInLXUjzIt2KTL2oRl/mg2bo6Q8tt
         BRcZzmRTPGpJF3osSa4odhin6pC/Epn46BKQwU1FZovgZAubXPEGLDJkj1BWl4/lhxvF
         /yQkV5ozH6sB4uiQaxdm615u+GkSwiCKTQqzz6BTmSMk6X4afqBhzTNWP3w49hLp4aQf
         kMrysRPc74tqyXxtuihu0APkdMnjPLNR4jUKAZzd85lm5ffXi/CtwQEjhTHboIQsL00K
         9o+A==
X-Forwarded-Encrypted: i=1; AJvYcCXez7abhMCXPgXoDPExbqcnBiYhbckw6kOUizuTEPH3PDC8N4PmjRtO/WTdWLCazz36CEgrlCuOQvVRw0X/sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBov3ndzH7NT83O4IrqTfwx2LP5i1ZKedKZw51odgUaCE7e3Ll
	h/Fr8EZaVj4OfNAhhq7t2rdoj3PVyStGL0VLzMQJR4ZBM5LLF+B3
X-Google-Smtp-Source: AGHT+IFkFw7WYMSBH32cZ5CQVdLeLQ+zq1uxq9mqpQa/H0Fd8SFtYYvVtzEcbAScavH1J1ZMgB2CvA==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3996561eaf.0.1718247815634;
        Wed, 12 Jun 2024 20:03:35 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:34 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 23/47] wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
Date: Wed, 12 Jun 2024 20:02:17 -0700
Message-Id: <20240613030241.5771-24-sean.wang@kernel.org>
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

make mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv to get rid of
the redundant code.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 95 ++++---------------
 1 file changed, 16 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 96b7a9df17d8..9d56013b2f55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1974,85 +1974,6 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 		req->sco = 3; /* SCB */
 }
 
-int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
-			 struct ieee80211_chanctx_conf *ctx)
-{
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
-	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
-	enum nl80211_band band = chandef->chan->band;
-	struct mt76_dev *mdev = phy->dev;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct rlm_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 control_channel;
-			u8 center_chan;
-			u8 center_chan2;
-			u8 bw;
-			u8 tx_streams;
-			u8 rx_streams;
-			u8 ht_op_info;
-			u8 sco;
-			u8 band;
-			u8 pad[3];
-		} __packed rlm;
-	} __packed rlm_req = {
-		.hdr = {
-			.bss_idx = mvif->idx,
-		},
-		.rlm = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
-			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
-			.control_channel = chandef->chan->hw_value,
-			.center_chan = ieee80211_frequency_to_channel(freq1),
-			.center_chan2 = ieee80211_frequency_to_channel(freq2),
-			.tx_streams = hweight8(phy->antenna_mask),
-			.ht_op_info = 4, /* set HT 40M allowed */
-			.rx_streams = hweight8(phy->antenna_mask),
-			.band = band,
-		},
-	};
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_40:
-		rlm_req.rlm.bw = CMD_CBW_40MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		rlm_req.rlm.bw = CMD_CBW_80MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		rlm_req.rlm.bw = CMD_CBW_160MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		rlm_req.rlm.bw = CMD_CBW_5MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		rlm_req.rlm.bw = CMD_CBW_10MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-	default:
-		rlm_req.rlm.bw = CMD_CBW_20MHZ;
-		rlm_req.rlm.ht_op_info = 0;
-		break;
-	}
-
-	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 1; /* SCA */
-	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 3; /* SCB */
-
-	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
-				 sizeof(rlm_req), true);
-}
-
 static struct sk_buff *
 __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
 {
@@ -2070,6 +1991,22 @@ __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
 	return skb;
 }
 
+int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_chanctx_conf *ctx)
+{
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(phy->dev, mvif,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_rlm_tlv(skb, phy, ctx);
+
+	return mt76_mcu_skb_send_msg(phy->dev, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 static u8
 mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			enum nl80211_band band, struct ieee80211_sta *sta)
-- 
2.34.1


