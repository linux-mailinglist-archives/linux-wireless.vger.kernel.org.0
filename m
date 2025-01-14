Return-Path: <linux-wireless+bounces-17466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177FA0FE77
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 03:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC98C3A12E3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9440230243;
	Tue, 14 Jan 2025 02:07:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C6230242
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820449; cv=none; b=oIhJmZbtMggQdSUZBhywFt4DEw+cHQVpDGZ5ntr6Td5iKxCvPE5xvbrjzigA858lG1dE/E8VHTBX9aGQXdlQln/hq5owXQKJ127l6Aj2WBShaBB6yQ/Y+6HMxfPCQfg6c5dmsjj95iq5a41N+w1qJfR7Pon4z01f4UzuNjaMu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820449; c=relaxed/simple;
	bh=C/lG8AqhxqgGve1Znsts+hDisNDVg4gAKWUJro7j/4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDsEA+nuuyZNYUkOrHXQD4zEbnDz4y1cOmd81/Xid6wdpPIbPi9EoJSLKqqeqtC3DBFAdCURv5Vhy1XoFWywXvdSGarfCTAiRklOW4Y/p+wnjSN6ftWXvJMUXjM1gOd7eR43CBcGsqbRScNK9JrSfzmZRFdjcKBtZ5MYs6mI+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb7ca55c3bso2772877b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820447; x=1737425247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z5nZ9Qy6TBKcXoruppicIm/anRrncBfElUKQXmiVQU=;
        b=fXECp5mrrzbPlvp0w3hS4TrWxheWORfELqZijhMQawrHgKsnFsjnXiHcq2nc0y8KSR
         zjWpJ8G6O3V9qViyHFKMPatdHhvHMMXrsp9APXtWJ7OCDfSiK902lx/BqOFfiaLeMnTB
         DwX4DVADP+rdN7/s5jkf1C6AjcEl7cXKHE4NlGb1mi7DKDx9KszMta7puv9tNuz2x3//
         g4Hj90dBzj854jBLVali0TnMwqYGDjLQ4ooQVmL4U6lx/e6y23vHCCFIgQ0TuIkyERXu
         C1+lS8yGUDY1r/puNAXmEKyXZS3dMvSYFGcYhNjwy/qXOXBmuth67ksrmemfzgvvrBmy
         7lhg==
X-Forwarded-Encrypted: i=1; AJvYcCXKX4sKEEmQLq7veGy/Vb/2qRmxoF8Vp7TaOydwvayQm9cTGWkMLkX/GICJvhgOY4D1ZTibInBJXfixgL2OPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDvnWBs14NuR0DBTb7ItY5MB//J9GDkkJFh0pYRGfMIKr1dcr
	0RBo5kVZSblBb2qb5aGm6L93QxgBvNvMrNCNY8rzUjoP3gbBDY3h
X-Gm-Gg: ASbGncvkmR3KeZ/pkWp8fVwjtFFmSAbqujLybE4Fi2Col1qVMeR7VGPuhSlKbz5GNlM
	y1hZttALdWNkMKXJ7hH9WrO8vTnxj/8b9lfrqzoiHqJ/byJmgz93eYBtWpNp4XUvRfs+KIbjQp2
	yK1k29NtFBomuMoEiuV7MXibQzb5kygIIA+Rxwy2e/UW1C+tdkvEKctMxsfeNAjY6nkA1mF1Ghd
	n14uQdupSYQsUP8bKVYbOidZRC+7Yfmg+hw8LH8wDBqcGqwo9icH3OEA9iY/5i3Bnhw0fU/Cw==
X-Google-Smtp-Source: AGHT+IFPnxxgbKjlJbwdgjkdDZ23zr97Zrq/9q+Ux+jFcDA4w58GsYGswXUPdk/KqYG0HgtKz1Q0yw==
X-Received: by 2002:a05:6808:350b:b0:3e8:1f5d:b804 with SMTP id 5614622812f47-3ef2ec96cdcmr12856369b6e.15.1736820447188;
        Mon, 13 Jan 2025 18:07:27 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882755172sm3915340eaf.27.2025.01.13.18.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 18:07:25 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/6] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Mon, 13 Jan 2025 18:07:10 -0800
Message-Id: <20250114020712.704254-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114020712.704254-1-sean.wang@kernel.org>
References: <20250114020712.704254-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Removing BSS without removing STAREC first will cause firmware
abnormal and next connection fail.

Fixes: f8797298565e ("wifi: mt76: mt7925: Cleanup MLO settings post-disconnection")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: generate the patch based on the latest mt76 tree
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 45 +++++++++++++++----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 90a6d62aa816..07e5c1a6d5d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1155,7 +1155,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt792x_mac_link_bss_remove(dev, mconf, mlink);
+
+		if (ieee80211_vif_is_mld(vif))
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+						link_sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1175,6 +1180,31 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 	unsigned int link_id;
 
+	/* clean up bss before starec */
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct ieee80211_bss_conf *link_conf;
+		struct mt792x_bss_conf *mconf;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+		if (!link_conf)
+			continue;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+					link_sta, false);
+	}
+
 	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta;
 		struct mt792x_link_sta *mlink;
@@ -1212,6 +1242,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 omac_idx;
@@ -1242,14 +1273,10 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
-	if (ieee80211_vif_is_mld(vif)) {
-		mt7925_mcu_set_dbdc(&dev->mphy, false);
-
-		/* recovery omac address for the legacy interface */
-		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
-				  &dev_req, sizeof(dev_req), true);
-	}
+	/* recovery omac address for the legacy interface */
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+			  &dev_req, sizeof(dev_req), true);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-- 
2.25.1


