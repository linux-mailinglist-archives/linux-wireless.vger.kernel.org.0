Return-Path: <linux-wireless+bounces-9957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B4926A9B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7DC284360
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D51940BC;
	Wed,  3 Jul 2024 21:43:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085661946AC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043007; cv=none; b=pB4VPTsljNOV9URBKFb/nN6c2kj0xuKjbpWOE1wKemsY10sbjkvWMbyDA31OYcyoF4nxiDck553aXkLbzmRN4g5yR/Fwa14ejJudnuQobJwJsYgxawoEAwWQIKp5AQk19Fx1nBcvbbBc5WzTS9sTrwMogKwocWd2Id4sHWzDcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043007; c=relaxed/simple;
	bh=Xjbro3Th6KCFnsPtSub/I458ig1ju/qRziVCG4mvsmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKrkF82lgdNp1AOAKlKEJDiVrahlVi4t+6hFTQllf/A+7mckcH0k+3XL4a5sskJXQrnRvhVW2EiVO7ejkjdELur3vhjcf3YxFRPjjsDD+HYESlIgNmFfdgU1ZSFkNkNjDVDK93AWKsZof1Ng984AefqmQslj4n5GTMlp7KN57ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25d0f8d79ebso8155fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043005; x=1720647805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDtWWoGxNXsA+VUrVMlH9NUVtfOdfQhzGFLU7KDEjg4=;
        b=bbXHzpYbazsLBl5WGhVcyDxzL08CFe8+c5STBUjSn5B4Gd7MgXecnagXfQIU/nRMB2
         np8B/JFfYcMKhDXf/s5sHMkA1VRYgk3aEhrdxzkBwmd5mucIf7GsvtYSx2IYcwB6puYO
         tr+dHVEyuuddViaryr+/twgTboWcUXNODgUYGeMCuEfDXbMRd34+09N4KCKZLWNGD0oY
         AvHqtiQmJiwgUFgX1kqlVF+35I/Xsz7nQQGV0HsC9FgqUOSRIBqrEJzP5+SQxPtJSqIx
         P07UEIjkAcB0JVe8u9EQauHbgYuvGA9EmaRVEbkSd6iO9xa9yPIKkbjhx2pwIG3Cd39X
         VtHA==
X-Forwarded-Encrypted: i=1; AJvYcCVLvgOzK3UXnX4455gpydO9vxbIQUBhZvwpXIjm8szOEAOHbLbOHV2jqWkaQAPatZknFz1HkPfc70Xfpo7Yx9tzZ4KVf16ux2dLbgI2JTs=
X-Gm-Message-State: AOJu0YxConXTKjcIhgX3FNby7f6JHJj9XVDEALJjl0JvGcxFF//dyMLm
	VBun7bRw9ceQ5Cp3+95bGbbF2wqehcCImkk/5QpcNZdyZ7Z3bNqZ
X-Google-Smtp-Source: AGHT+IHHL00osxe9L6uV/ZIfVF6TzeBtZZdxa46wI52tc5jjTe51dQO8lcXzLe69OaHVmiNHiz2Wcw==
X-Received: by 2002:a05:6870:55d4:b0:25e:dce:491b with SMTP id 586e51a60fabf-25e0dce4b4amr2524322fac.1.1720043005063;
        Wed, 03 Jul 2024 14:43:25 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:23 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 17/29] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
Date: Wed,  3 Jul 2024 14:42:22 -0700
Message-Id: <b8ba083687b58cc5eae839376f4a0e3cde7a0383.1720042294.git.sean.wang@kernel.org>
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

add links handling in mt7925_mac_sta_assoc

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 90 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 46ce23c7ec27..3a9d526f8085 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -387,6 +387,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->phy = phy;
 	mvif->bss_conf.vif = mvif;
 	mvif->sta.vif = mvif;
+	mvif->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 
 	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
 	if (ret < 0)
@@ -925,6 +926,75 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
+static u16
+mt7925_mac_select_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct  {
+		enum nl80211_band band;
+	} data[IEEE80211_MLD_MAX_NUM_LINKS];
+	u16 sel_links = 0;
+	u8  link_id;
+	int i = -1;
+
+	if (vif->active_links == usable_links)
+		return vif->active_links;
+
+	rcu_read_lock();
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (!link_conf)
+			continue;
+
+		if (!(BIT(link_id) & vif->active_links))
+			continue;
+
+		if (i == -1 || data[i].band != link_conf->chanreq.oper.chan->band) {
+			i = i + 1;
+			data[i].band = link_conf->chanreq.oper.chan->band;
+			sel_links |= link_id;
+		}
+	}
+	rcu_read_unlock();
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
@@ -940,7 +1010,11 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	mt792x_mutex_acquire(dev);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	if (ieee80211_vif_is_mld(vif)) {
+		link_conf = mt792x_vif_to_bss_conf(vif, msta->deflink_id);
+	} else {
+		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
@@ -960,7 +1034,18 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
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
 
@@ -1751,6 +1836,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
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


