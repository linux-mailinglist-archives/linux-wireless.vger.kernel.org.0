Return-Path: <linux-wireless+bounces-8953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FE906265
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34283284409
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64612DD94;
	Thu, 13 Jun 2024 03:04:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0C132135
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247856; cv=none; b=m/O9YQxavFjhBK+1XQpsT8G1z1Q6tvDVaRn//qXLooqjCjbDLVRgAxpTQOHpXN33txKI47EdJiidSgQ8ZPl/DoaglG4kaAohjgOdmNdw+O3XdFVtVCvxmLdcKJHbDeaAU2vIhdTjdm5cwcHCmna9htRdJi6XbU7Dvnv3p+m9DI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247856; c=relaxed/simple;
	bh=yhpkMIYrrA8Cesx7a4+xLw+yb7LcyFCA4OPY69Kju1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6KeMyYYpeMsbJJ9IPy5iT+a5TFpcWsUQxo+lQt4qW5+P0WrTUnLl5FMIe4iqYYDHG0G/eMfA4f/s5sr38OL4voDB8ukNofy549iI0QX4kgMWrjdqcjx0+0POeutN0+2TcUzm2qu4tTFIt/9cRXhs5i5xrKt7REcEaWx3uMhZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bb10cfe7daso36901eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247855; x=1718852655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnZF05g1ossfZRm0FvsZx86VQptBSn3TL85vtMAglhw=;
        b=EtTGaYBrSPFgqyZH/wMEvhLVy5hKJnHyELcM14WfXflgNp0nyRfBAFf89+kVP9od8f
         0CsE4sr6MkMd2LxSGuB04utIfJxXX6ZpwUzZ6bmUJA8FLJQ/hHYp4TygMAmFwruxckB6
         c5kWMZZxWfzDOyRvJcjYjvb4oiXCqx1H8ppp3o5VuPpk5TiVnqTcyQh0OK8wWRiV7MrV
         KWahNzLMmGcRVu0v/aoJGiMVnuY2TRmbG7ypExPoy5D/AuAJkxIO9XTHJPe900KVQDmt
         Xu8h3jF8TWmVX0dR8ojkjaO5BRGXjBdXdGzV3krlTpj0LCVh9ew3PjMwbpcNSj9Na+o/
         ngEg==
X-Forwarded-Encrypted: i=1; AJvYcCWwtnahNNyxW3QazbNwMN6Yey9HPP965mMM/rS7mpg2TC2Xz48TWzq3vGAHit8cy3RDX53NtI3IYwJ/AQpJJkKyW/Pa1pECZY1Boc7dwvA=
X-Gm-Message-State: AOJu0YzVnzIL7AYaZFuzRnELq32hRTqYOHvZz1GZr+wFyfTMOzqMuhFx
	PDjtx+9Qrj37QkJz0rAW0ggyD3z+WuyRYGSilcOLrIVn+0ISDEKi
X-Google-Smtp-Source: AGHT+IHws/ZWXRCtHHewDwSprWC4KLFzfUqKsSexiREanNejKeD2YkRsqQNuGYB5vQ2IxCcXbOwpiQ==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr287086eaf.1.1718247854625;
        Wed, 12 Jun 2024 20:04:14 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:13 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 43/47] wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
Date: Wed, 12 Jun 2024 20:02:37 -0700
Message-Id: <20240613030241.5771-44-sean.wang@kernel.org>
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

The mt7925_mac_link_sta_add function currently associates the per-link STA.
We will extend this function when we implement the MLO functionality.

This patch only includes structural changes and does not involve any
logic changes.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3911cf71462f..b159d26303ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -766,32 +766,43 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
-void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta)
+static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
+
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 
 	mt792x_mutex_acquire(dev);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-					link_conf, &sta->deflink, true);
+					link_conf, link_sta, true);
 
-	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
+	ewma_avg_signal_init(&mlink->avg_ack_signal);
 
-	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
+	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	memset(msta->deflink.airtime_ac, 0, sizeof(msta->deflink.airtime_ac));
+	memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
 
-	mt7925_mcu_sta_update(dev, &sta->deflink, vif, true, MT76_STA_INFO_STATE_ASSOC);
+	mt7925_mcu_sta_update(dev, link_sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
 	mt792x_mutex_release(dev);
 }
+
+void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta)
+{
+	mt7925_mac_link_sta_assoc(mdev, vif, &sta->deflink);
+}
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_assoc);
 
 void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.34.1


