Return-Path: <linux-wireless+bounces-8931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675F90624F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2B51C214D3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065D12DD94;
	Thu, 13 Jun 2024 03:03:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EC12D1F4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247813; cv=none; b=MfjLpAFxGA5KAB8ALKlKjLkd5kK4672okY9nEPTMbeO7vawaSQnpO4lZOedLWL263lVO78QZuqkfUcSml3mEuD7f/jzSB5I0dBwaYAp959jG/CA8uoqJuPk6e9X2DB/ZKbiblLm+QhK38+bphIkUvQG1Fd0DGfCPRr3vYqd8W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247813; c=relaxed/simple;
	bh=BPWfSG0Fc88rFy2BLjn3kbtRem2M1ENiDGVVhFhyye4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idGsd/dKMThsYO6MLdGd8s/7WfQbgUYK8pEqSbRfFdVx3LO2WuKMcDVaUAQGwpGQy0R72SoEKDVKhnW02NyYczaEhrLo+/CFzuP7UO+MVOj32E9WwRcUjMky1YhG20ZyGfohojo+nWHBLCMYIxNmoTDce+wfF2YFZAaDa2Ko118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d21b50f8b4so68946b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247811; x=1718852611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m5poBoCf/FKm4KBPm6gYtwcp9bMCiSU6fa4NfX9MgI=;
        b=mmutNZsV9dfWY45W8+pibT2+bxz8DekQV7UqXBHJ6ApnN5zK9+7OrylFm3N3HtoZuR
         FDBTkKOXCVX+Jhdi1ameiWEw07iNTRruJeoc02pGrKOPbHDNfY7qD1Tm/bVqHdx0jt0U
         z7t1jsV7r6eMAoATG7XguYJx5LWTF/+WA7LwYl/CZGCzgH84egtPXnDTjJR5PKgjWiBs
         C0xIn2WGAzhbRKOSZvNzO1e7IfXVS32xggRo5oh2j1tkprQmxDMOFwN9cfJ0fszMzZqo
         eAn9ex1yDDa+eHL/Pe/MYMDJYLQC2ADq65zDs5Zs82ZrRpraSPW38CGlH67SFBsBASZg
         NB/g==
X-Forwarded-Encrypted: i=1; AJvYcCUh+E9vpJd+OMbikS3FHCGCjOw4b+eoSlX1InFLvkLvJkz5zIQA+wKi9y8pqQMhWwswMCvD91gKK7TeDP6KL3BHSD7eF17j5TdQwhPqXF0=
X-Gm-Message-State: AOJu0YyXGZhQ+QJkOWfzcIBQPd6fxKODoCXUJHj75KziUs9Uk2MmTySA
	wB62DPEUw1yuAvg0DWZP8uZh5HGVsvBiZYGWFhqay5aX8q5T7/8Q
X-Google-Smtp-Source: AGHT+IH3VdcAKYywuUVd8RSqNF5vSLpmMq9sWAa41UhcYYob9I0jkUAqyH169yOPlWKe5BmMi2s3rQ==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3671830eaf.0.1718247811382;
        Wed, 12 Jun 2024 20:03:31 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:29 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 21/47] wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
Date: Wed, 12 Jun 2024 20:02:15 -0700
Message-Id: <20240613030241.5771-22-sean.wang@kernel.org>
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

Extend mt7925_mcu_uni_bss_ps with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index bba17e51a023..cd20b85109b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1383,7 +1383,7 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_PS)
-		mt7925_mcu_uni_bss_ps(dev, vif);
+		mt7925_mcu_uni_bss_ps(dev, &vif->bss_conf);
 
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8950df09a025..7624ec23e064 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1243,9 +1243,10 @@ int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_eeprom);
 
-int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
+			  struct ieee80211_bss_conf *link_conf)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct {
 		struct {
 			u8 bss_idx;
@@ -1264,16 +1265,16 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		} __packed ps;
 	} __packed ps_req = {
 		.hdr = {
-			.bss_idx = mvif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.ps = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
 			.len = cpu_to_le16(sizeof(struct ps_tlv)),
-			.ps_state = vif->cfg.ps ? 2 : 0,
+			.ps_state = link_conf->vif->cfg.ps ? 2 : 0,
 		},
 	};
 
-	if (vif->type != NL80211_IFTYPE_STATION)
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8ab2bb01ba73..ef37951f69d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -242,7 +242,8 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);
 void mt7925_roc_work(struct work_struct *work);
-int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
+			  struct ieee80211_bss_conf *link_conf);
 void mt7925_coredump_work(struct work_struct *work);
 int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx,
 			  struct mt7925_txpwr *txpwr);
-- 
2.34.1


