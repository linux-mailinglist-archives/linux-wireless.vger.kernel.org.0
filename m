Return-Path: <linux-wireless+bounces-16224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D509EC175
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7445716935D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8DF9EC;
	Wed, 11 Dec 2024 01:20:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382310A3E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880036; cv=none; b=fOa8l1UXh+K05E9TA71Gl8PexlDvsIYgbzJzCaDSOgtbN00t1BHUgKHggYNmE3kwxGyY5iCVT0KHWGkfMilWbZKf2hr8LDK/JjrY80h/6IbmcCS04rplLIG4MWmkkZgWqzhzBZNThgPgoyqU7BIM/HMzalsJLKVp+r7CUMbrOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880036; c=relaxed/simple;
	bh=Z5fxSJKp/mhKCgl0ICjjXv+timoPQ/BNep2XxOOZKV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AETuf06CW3c6hj+uVkxSAdovFqm/kdntAAlMzc6shWraYULkHZBTBxL4Jqwn20snBOCMKVgKkhd3jC7dGtzfHvEiGdJ6eMVlqs/u1vVonJvJNolL64jWzrIPW7AO1lDQQOOSFqBq51DFzaaL+PDRRUeDDCkln7XiBpl+1wCfzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29737adb604so3134323fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880033; x=1734484833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1YpHXYbDA4VM1WpYLpyHXFxdUkmq+2IyIhunuoKdpQ=;
        b=doHHsCpysZgplCosULcu/8bBJO2XXzsj27g9rqYfn8dz8Dba4GyOyx/G4m2cryWKz3
         IVVjPgmGjjg/VPGO8E/aMmx5FZnmEeu2wTBn+3J0fFhl2TL5NFgJpxgbXM1hIRPwuUEy
         p1xFU/GuhfN9JHaifoyCLoeazoT/W3h7qsh3MDYCvjbmEquFKUev1TbfIM8rO9Lfa6vm
         dS40vUde8zhUgvvL5LXP+0j+i2Pj7vpdpGjnqyw37MCw8OvwivBmDVHiy3N/IQw4aKks
         B1hrJtfAPYE9XoxI9nGCAU0VtZQ22v06ccUK02FEkKe1U4/M7MY2ooaBhvd39OlWGIj6
         g76w==
X-Forwarded-Encrypted: i=1; AJvYcCWWcn1+btuRFSQopOWOtFABUbt71P0TcIc91n4UQ1mjSbHx622DMF1TVq1Sdg1gyivqkqbURjCOu1ELfE5nYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGeO38PXhDcLlbqgttpGiK/DEz8Cb0vqrmVAXgKIDii+uMJZs
	/xtxNAjeBJLwQAlypTaxkIgThrFvGkapRyiTjgGig6d4TGkXKwN3kXTbC3b5Tok=
X-Gm-Gg: ASbGncvA1Gvm3u+g0SQEEF3biCLI6cjh+HJL4uurUx1olXJytyexGNXexFAi/157RiV
	BYOaLDVZJT4bCw/0W4MKTXhMwb/778teB8/ECazCzFWnRGcsXGytUqt2z7ZdZhJa1EBZ4vSYhQ5
	sKQXqLjZ9C7+X86dubulhAL2lwuHwcJTZjcg8oBMtVpqzzgbtg8DuUoWHQtiGvwDlTWADB47tHr
	voGqQuIYChmfwOoe3b1S0jbL1xXLDLqcaBaqeobPq4FHWzM6/xBxUel/ucHA+fMM5I+vj4=
X-Google-Smtp-Source: AGHT+IF0gUkHuRCaOh8UGDwrWZiHIizEzdf2Z5358lrfRXUW5B3uSGUMCpL6znNlITwq0TrtI1wC4w==
X-Received: by 2002:a05:6871:430e:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-2a012db1083mr711621fac.11.1733880033574;
        Tue, 10 Dec 2024 17:20:33 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:32 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 16/17] wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
Date: Tue, 10 Dec 2024 17:19:25 -0800
Message-Id: <20241211011926.5002-16-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Clean up MLO settings after disconnection.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 37 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  2 +-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index da7a2a798545..9c43437ad9d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1149,8 +1149,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
-					link_sta, false);
+		mt792x_mac_link_bss_remove(dev, mconf, mlink);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1208,12 +1207,46 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = 0,
+			.band_idx = 0,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
 	unsigned long rem;
 
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
+	if (ieee80211_vif_is_mld(vif)) {
+		mt7925_mcu_set_dbdc(&dev->mphy, false);
+
+		/* recovery omac address for the legacy interface */
+		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+				  &dev_req, sizeof(dev_req), true);
+
+	}
+
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 551b1827bb40..6675492ec9a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2662,7 +2662,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
-int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 {
 	struct mt76_dev *mdev = phy->dev;
 
@@ -2682,7 +2682,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_MBMC_SETTING, sizeof(*conf));
 	conf = (struct mbmc_conf_tlv *)tlv;
 
-	conf->mbmc_en = 1;
+	conf->mbmc_en = enable;
 	conf->band = 0; /* unused */
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SET_DBDC_PARMS),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 31bb8ed2ec51..fe6a613ba008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -616,7 +616,7 @@ mt7925_mcu_get_cipher(int cipher)
 	}
 }
 
-int mt7925_mcu_set_dbdc(struct mt76_phy *phy);
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable);
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
 int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
-- 
2.25.1


