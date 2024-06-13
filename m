Return-Path: <linux-wireless+bounces-8928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFD90624C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD991C213F6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8012CD8C;
	Thu, 13 Jun 2024 03:03:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDE12D76B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247807; cv=none; b=E643dBGoi4RgfguMVbHpYMGCXzr6svi+B5nSbuzjx9OcKzvrWBbBf9xFFgMWTy3FZVjpBnDAMcQDIGcZt80fQfkyFFEgesFG7w0+S3Y4GUnW0Fd45MqLco2qwTIpuHGmjw4yXUY5Km55u5Fu3KkFs9gmQ7T6dg+n7MXpCU5q4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247807; c=relaxed/simple;
	bh=zjHElvgyV9QND7kY/b/1nOf52AI9JME7t8ZM3wM/Xv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X93gphaavgdTTzTuCuU9eGBIQS9dbBuUlCKhwZX8Ow3Uqh23bD05Z0jKZMJljxGFxlmmPNFT9lofOBn06QoJW+Eljk9V+TsjLE5PAOB2IAFQaymhgwhXgH6NWv7J5q3Ftotqr4lwRx3XWY5YaTbUWGSgPYUc3JG1r+TjbjvDviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25496e90cf5so70101fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247805; x=1718852605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0dXcuhqd0lvvqm+NBo7m/RnwTDnBF6gybJXfOPI8oU=;
        b=K6FSW06jouaVGnWk6hKAq7sZMVkPm90P11SUMP9YmZNX2jrpawmZ4Dai2tFPdC2pe4
         h5KGvE1DX/W5QXltbcIL8xU2Orw9PqePpmJXTXzVNy+5OYJIv0zaIG6OYu6N4L/yx2s7
         L/trfbYmZIQTVfGZkMEozW/wshyVfeRbjnpAn9FBV4Ho4rVbJgPv9i92Djsvm88rfRQB
         ZKC3zHxH6dbvpI2liQSEVv85qUGFgukuQ7wBPJZkTENWZ+YoXHyhBGWjSF5WVojKCeEq
         /Yy+Hbof7Uw2zx51TlFuXe13NTJf6eaHd6/9eK6j6fu/YNI1lsXdsgPrdu//nY4v2GV9
         mkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCViZ27t8uPfyhZ0m7d0PWoTEUchVIzyAYUy3CY35aIUSp0LGjrdyKJ2uxzgqlRZMLpgqzfBziySa1Rr9EXQ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEUE+Z1GsRYV/QD10iLs13ZSNDvCdiVnGE7tN5ZUni5jA23V9
	gnWiubrmwSss1MTyWsQipQEJ+MvDRUOzaJxkOHrSStUCObbSZq6l
X-Google-Smtp-Source: AGHT+IHi7rQNTqoSwiFznMBjXn3k3B1PCO5vHCiG3wFDk2jnlRKV9q6PICtm0P8Y3Y5/9BSnjwQ0wQ==
X-Received: by 2002:a05:6820:b0b:b0:5ba:c4ed:ee98 with SMTP id 006d021491bc7-5bb3b7a4c51mr3589757eaf.0.1718247805119;
        Wed, 12 Jun 2024 20:03:25 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:24 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 18/47] wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
Date: Wed, 12 Jun 2024 20:02:12 -0700
Message-Id: <20240613030241.5771-19-sean.wang@kernel.org>
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

Extend mt7925_mcu_set_bss_pm with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c   | 15 ++++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mt7925.h    |  3 ++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 457e1fa2fde1..aeed2c777a20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1263,7 +1263,7 @@ mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	err = mt7925_mcu_set_bss_pm(dev, vif, true);
+	err = mt7925_mcu_set_bss_pm(dev, link_conf, true);
 	if (err)
 		goto out;
 
@@ -1285,7 +1285,7 @@ mt7925_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_mcu_set_bss_pm(dev, vif, false);
+	err = mt7925_mcu_set_bss_pm(dev, link_conf, false);
 	if (err)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 18e19ffdbb7e..0350f0e34690 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1319,10 +1319,11 @@ mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 }
 
 int
-mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
+		      struct ieee80211_bss_conf *link_conf,
 		      bool enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct {
 		struct {
 			u8 bss_idx;
@@ -1339,13 +1340,13 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed enable;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.enable = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
 			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
-			.dtim_period = vif->bss_conf.dtim_period,
-			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = link_conf->dtim_period,
+			.bcn_interval = cpu_to_le16(link_conf->beacon_int),
 		},
 	};
 	struct {
@@ -1359,7 +1360,7 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed disable;
 	} req1 = {
 		.hdr = {
-			.bss_idx = mvif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.disable = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PM_DISABLE),
@@ -1693,7 +1694,7 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 					       MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
 
-	err = mt7925_mcu_set_bss_pm(dev, vif, false);
+	err = mt7925_mcu_set_bss_pm(dev, &vif->bss_conf, false);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index f689f7a359ea..07ea03195e4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -192,7 +192,8 @@ int __mt7925_start(struct mt792x_phy *phy);
 int mt7925_register_device(struct mt792x_dev *dev);
 void mt7925_unregister_device(struct mt792x_dev *dev);
 int mt7925_run_firmware(struct mt792x_dev *dev);
-int mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+int mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
+			  struct ieee80211_bss_conf *link_conf,
 			  bool enable);
 int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
-- 
2.34.1


