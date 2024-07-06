Return-Path: <linux-wireless+bounces-10036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61169291E1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE1283CD7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472F4D8CC;
	Sat,  6 Jul 2024 08:28:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145616BFB0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254533; cv=none; b=YV4rwCLPrxZoUW3lnOH1dcnqGKO0ra1E8tl1evpOSp6Ppaw4r/RjGImyWDhg65a6P/RkWjUHaSx8jAlL7N48RqBQRKYbTMbmbUZ+OaJzWdxv7XVtI08M/mFBzuVzlPOgXJ/hCTJ4NM00/xz49VqYRVe+AjxMoOF81i47SwYaHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254533; c=relaxed/simple;
	bh=X6j1mZyWwEK9n+XYNe2ROp77tumubk8MaZhhvqcr/Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7LQbl0YK4OQa6/abszK7OlOVduPR/wTAectxIu5ABb5UXQPEDKbXg/KAYkXi71GEKpLxli5D1Oaigdk+xzizqvNE2gKrju/HdE+n6TkEcn3kRy2rttmw2Aji6Mctka6n7otpOsg3DanEGmSbNidAXhlQ8fMj7GRKgkgyjPqM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e14bf05e5so95398fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254531; x=1720859331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF7dbw9hjOaq/kQruIH9Yh9VX6vhhlm/7O8Px4OouLw=;
        b=YRkMv/Q474ybpYnbMf+H0rcgylCgX8F7hAFA2ABUmxneXAqyeQpUrd51f+UlY0FHfW
         9Wp88yMmVOC6xVO/tsMlfXQUI2Ivs0h8eIg5myjGL+mjAmj/YCC/7xLSUZsi1lePD8Wn
         jmDEC1XAKBbcVfLQ8Ym/e6IbzLyBTU6npJ3ocUWKJzQht8iZzTelkV2nJSnmsI6N9q4P
         x9tx6PiMGivGnCBx8dHr1SZdyiOVR3W1iQI4LZtiwaNaR/wglF7Rm/SLtNcxOCOIVUcA
         oMWMVARpthSZ7ecb+2/vQ4EShk79y2JfR3rnR5cZuO6xzNq7DA+IyxFDsrLiGDwxUKGH
         WM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXPob9lmnMHGO16aviWFicF2VzLap0wF5fHmvYER+ZK+j4cwlQCpYJ0xXUZr7jr8det0siLd/Id9wmsXtvzEkRgI8mrYX88DPMLdNf2SXQ=
X-Gm-Message-State: AOJu0YzuRncXB3zlO9fNtUL8nMoh/JBtzX9RhuRgi0NJWbmI8U0zUrU5
	L0GCbB8LJwWzjYRNTR3O6sIllR+AWyoA7XYMA1IpIjIFZTblSJKF
X-Google-Smtp-Source: AGHT+IGew+8eYSM7buBCgaK0V/uYFNLE8/3ep31gfldrh3EPHm/63YOfwRDMIgjls83fwJRHMNMVmA==
X-Received: by 2002:a05:6870:5590:b0:259:f03c:4e90 with SMTP id 586e51a60fabf-25e2bf93f31mr7368525fac.4.1720254531236;
        Sat, 06 Jul 2024 01:28:51 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:49 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 17/37] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
Date: Sat,  6 Jul 2024 01:27:57 -0700
Message-Id: <0ddf1834783b111d626b05d298478f520d7c0caa.1720248331.git.sean.wang@kernel.org>
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

add links handling in mt7925_mac_sta_assoc

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 104 +++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   1 +
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 938909ab8d1c..669f28a916c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -387,6 +387,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->phy = phy;
 	mvif->bss_conf.vif = mvif;
 	mvif->sta.vif = mvif;
+	mvif->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 
 	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
 	if (ret < 0)
@@ -923,6 +924,89 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
+static u16
+mt7925_mac_select_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct  {
+		u8 link_id;
+		enum nl80211_band band;
+	} data[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 link_id, i, j, n_data = 0;
+	u16 sel_links;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return 0;
+
+	if (vif->active_links == usable_links)
+		return vif->active_links;
+
+	rcu_read_lock();
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		n_data++;
+	}
+	rcu_read_unlock();
+
+	for (i = 0; i < n_data; i++) {
+		if (!(BIT(data[i].link_id) & vif->active_links))
+			continue;
+
+		sel_links = BIT(data[i].link_id);
+
+		for (j = 0; j < n_data; j++) {
+			if (data[i].band != data[j].band) {
+				sel_links |= BIT(data[j].link_id);
+				break;
+			}
+		}
+
+		break;
+	}
+
+	return sel_links;
+}
+
+static void
+mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf =
+		mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
+	enum nl80211_band band = chandef->chan->band, secondary_band;
+
+	u16 sel_links = mt7925_mac_select_links(mdev, vif);
+	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+
+	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
+		return;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, secondary_link_id);
+	secondary_band = link_conf->chanreq.oper.chan->band;
+
+	if (band == NL80211_BAND_2GHZ ||
+	    (band == NL80211_BAND_5GHZ && secondary_band == NL80211_BAND_6GHZ)) {
+		mt7925_abort_roc(mvif->phy, &mvif->bss_conf);
+
+		mt792x_mutex_acquire(dev);
+
+		mt7925_set_mlo_roc(mvif->phy, &mvif->bss_conf, sel_links);
+
+		mt792x_mutex_release(dev);
+	}
+
+	ieee80211_set_active_links_async(vif, sel_links);
+}
+
 static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_link_sta *link_sta)
@@ -937,7 +1021,11 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	mt792x_mutex_acquire(dev);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	if (ieee80211_vif_is_mld(vif)) {
+		link_conf = mt792x_vif_to_bss_conf(vif, msta->deflink_id);
+	} else {
+		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
@@ -961,7 +1049,18 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta)
 {
-	mt7925_mac_link_sta_assoc(mdev, vif, &sta->deflink);
+	if (ieee80211_vif_is_mld(vif)) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+		struct ieee80211_link_sta *link_sta;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, msta->deflink_id);
+
+		mt7925_mac_set_links(mdev, vif);
+
+		mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
+	} else {
+		mt7925_mac_link_sta_assoc(mdev, vif, &sta->deflink);
+	}
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_assoc);
 
@@ -1753,6 +1852,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		if (!old_links) {
+			mvif->deflink_id = link_id;
 			mconf = &mvif->bss_conf;
 			mlink = &mvif->sta.deflink;
 		} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index af9a103dc7f4..5ede24116748 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -131,6 +131,7 @@ struct mt792x_vif {
 
 	struct mt792x_phy *phy;
 	u16 valid_links;
+	u8 deflink_id;
 };
 
 struct mt792x_phy {
-- 
2.25.1


