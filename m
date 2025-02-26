Return-Path: <linux-wireless+bounces-19456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A8A4537B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC41F3AB502
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC721C183;
	Wed, 26 Feb 2025 02:57:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375592AE7F;
	Wed, 26 Feb 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538625; cv=none; b=iTus9E4oWqTB3pEDOvjwRp+0+5StwX8WaTLha0BaaA2hY7e0yWCrqU38ZpS4dndxLyACQndrl1GNwj0AYbPho8ULqEq5njaiyfWQzX0UVVq35ujBw1YaYKtU8GHwY3XXpmr28xWoSvwmObT4OX7eMrtHBuvgtOJnb7gqLjAgEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538625; c=relaxed/simple;
	bh=2MpSsTcl+qQB4fca4ia9+Qrg9K12jCYxNhWYkIhsmWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmpyVM4npFimBPxfh4B1zJfgUAsITBIVx/3hJuTQf5gj+6DXw+pjsU2oZaZAgJxz+jmsrIV5sgfBqPIEy86OU3HJ5Uy5vLfsLNc3p7Q1TZqOCB9eTVu4ato8eoRqPYrarSZ9fVJZLV2kVvwBHRFqLUDslMXYD05IxG+R/Q38siE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b199bb8af9so288230fac.1;
        Tue, 25 Feb 2025 18:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538623; x=1741143423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vXi58LyDy1GWYlC/u6cuTmKczjfEVwi6s+UDBBfxoY=;
        b=C6v04v/4MrSDzdfTjbnvu6jyVYA9SK19GDrlA+MUBgZUTd1Eyxt7oz/FOOJe5Vz+9f
         pLEffFdLJPKY0QPltgGGV9Q9nOAjnRxfHdMITemk5Q/R3x6XBqGSkxCvsjjUQroDIbo9
         4Mv/VtzR9ilAUY9C/eKedGNMnLJOsZ/N3r1QYDYTX07iYI7ZfMbOHo35oJ/N8eJy32si
         jLpTF0LrCPWSp+xDMrj/WMXe4tia6UpA1xwv6jVRsD9NWoyN+L3/YJ9NnJF8zFDJkGM3
         WdvtYODp5uwvS7/xt4/YhkG1/aGCZtmUIx8Ee0yqsU31d1MuTnBPFjdSOUWKI7ODMjbK
         AtQw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsJzFzXuy5Ude688f4XbcJOO+0p8Yl1HIdcX2J5+BBvAWi9lb8mMZPMDlaGl0qw5bE0Gf0NUrrMADOJ/E9A==@vger.kernel.org, AJvYcCUrry3wVZNFUNk72/DsDf/PnLLkzdXD6G1JXulE8P9fT/k0wWQ0sKoK/sIVPp0p7UialvfCuVH1@vger.kernel.org
X-Gm-Message-State: AOJu0YzumSjt6b2Hjl2FPmOIh+sOnqAhNqe/rlm8vnbHcB5eWSUliznt
	ppz207a5nZn+aeZBVoxc7/dF0St3NL54ZBNaWND8RSwRVeBezaVwB48EVPK8
X-Gm-Gg: ASbGnctBZSB+RA/inXLIarQmVCDcu20sD4rKlyL1qpFwaVuZVPWmGtIdqIVo+42Ow4k
	zCbrshNQoq5cngK83uSyTtU4cmFBNc4QzDtdxE7LL4IH4AwqEMRx4m+G2JcQDrszDSVt80KyiFh
	VQl8AY8spspf58rKQ2IpiZYlW/w7bXUru5c4REBwTU7OC/cBRchi0N52UDgV7K1QS0bf4swiaMT
	MwtwiNIAtz947z5JFqIayiOj5DOqWaZKq+D4g/2cJUMo1KNNkkzSpNQFdApy8WfX4mQlWO5lSkf
	l+DG1Qby62pG8xobxTQhUhwRbUZWkoo6NZGvEPQIP2Q=
X-Google-Smtp-Source: AGHT+IEIugqduV+RGP3uvFWYUDXl+R6/9G+jIQ080D5wrSR6I8qtMlDHw/vEuMSZFevfVt5/TORrow==
X-Received: by 2002:a05:6871:6a7:b0:297:281b:fb6d with SMTP id 586e51a60fabf-2bd500303f0mr14238536fac.3.1740538623206;
        Tue, 25 Feb 2025 18:57:03 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f0135sm676360fac.27.2025.02.25.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:57:01 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v4 4/6] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Tue, 25 Feb 2025 18:56:45 -0800
Message-Id: <20250226025647.102904-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1)  add tested-by tag
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 45 +++++++++++++++----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 604f771af68e..4a9f393b45ba 100644
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


