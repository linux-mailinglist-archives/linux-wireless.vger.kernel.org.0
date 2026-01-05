Return-Path: <linux-wireless+bounces-30327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F20CF17C1
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D318130080CA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D29140E5F;
	Mon,  5 Jan 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLlPDz6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8A282EB
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572819; cv=none; b=nMWYXQn0ia2T3OS1D+wQ0NBQalDSS7QOlyDaAXC884A32lsR5rckJvtigTD52Qtwmu/ErtgjI+jd4YqMeAVoPBDzhTceCMcI6xafHBWIKmDEOEJDmn4J5zvNIt/shZdXoXn6GeNSavqOMXlUJ0KrATSSYhL5M8x2JeiknsW8elI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572819; c=relaxed/simple;
	bh=RSD9Leh3i2WeCr2It/CLzKSgKmadqV+MfdmnklJ6q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6pCAF4Gq9VcMcVgq5HVcRpcVISvUdlO2Nu+Uu1qjyZTe2ozGZERYnV5zb7JEp0TeM78/JM4dYfJYU0sB3mVSu6ohK0gyc3HyPf22EzL1L6EYIRNrMF+A32z7W2+A1H+731mHYH1izg5Ogwp4IFjnYcuY+eRpBqJSevOAz2YjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLlPDz6G; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0834769f0so132186345ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572816; x=1768177616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgqDXjaM/W6rmb9gEVa1xwOmm1cgdSOfo0YYoA6k0dI=;
        b=QLlPDz6GdOSzqlP1HrZyeZLE8K17CI6TV4gkGr+a1v0f1jWaU4RT0qi9dz4Mp/lEkF
         l2exSX9gZrk32YQbTowm9J/RFoQE1eMPGXzdjQ6uyE7Q9imyukVJ5pG6A79HM6gUAmXv
         C2psh93TVjdamqWbdIYch3LTQiacF5x6fIy09lqJ5ra82QneR7gR/KKxBymZ95jVNU+T
         uiPrj/HRVSfX1/U+pTBzgpqE3iuPUzsUkfvbe49jNJx650I7G19ltxl+b6ASTU1y+3T0
         wSGsFaHbn/JcGnFCMxsR4+AL6+Rvb+5ReY9omh82km4Y6hdftQoZGh6X7EETF0LuURVN
         5xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572816; x=1768177616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgqDXjaM/W6rmb9gEVa1xwOmm1cgdSOfo0YYoA6k0dI=;
        b=X37jXkug3kyOjHTdAR60zTCb2qmA1Mt+9vtBMxoR1cggyGlfKlWAkOktNuNCEsdfaj
         n1t4BSSZsHMLm/3U6YlHAtcM8ZatzEZd3G7nKjmiZua6+8UHeSxB7lq1L7QK0P13lCIj
         I1nCcX0NucjOWS7JGRY1TnFMvbS9o/gNILnYbDqUUtKgFG9J32jVxteeeZzKPFW16Lo6
         O0YRIMUDE1UBM2aPUFTMsbzhtnXF0JG6g0asNwX3r0XUhWxQf9YSqjm1oSkQpJbra1mi
         z7b0dC4wXVsRu+PH1guTlGKsHAWOM5nmRwQ6Lp/idNlv+AfDWrXwW1BVt25QJa/895ve
         2xpw==
X-Forwarded-Encrypted: i=1; AJvYcCUHm6qyL2ZyFPmTvLE0xlQZjWdAm3udHxaMH7+FdvdJB3NhwEeUVzHw5OTNeC8uoIV9yAaAacqtkSOmte7/tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzomhpIdPWfZW6Q2TNxNu6JEfxkr+wCv4XRG1S0Csg1Zj+B9F4g
	fncYfHp7s//ALuSS51r/fh5DiqrYUn5nX/hq1TCzNS05XQg7Jvqdd+Sh
X-Gm-Gg: AY/fxX4L+EoorwRNaJOZt0HqD0l5fZepFR4ZlI48SI3irOJ0DxGqMaEaUwChW8t00Gb
	zmpI75Evjb5z46PFPeVHGcdZHBbI/L4wczAllGfe7GEl/eodgFfJ9/H7AD/+6w82UVGkxSLTOEX
	kDbcuygpD1WLNY8H1tCE8ZbPNTOiLSd4vJCkUiadosMPLqKXmeJ3Xix2eTbY3hIse1mfZ9sYjRM
	lZtO0jAoUJebRDI2ANj5mWJtA3bQR0sPFNaVzYquxbIGct99OuOYtmS4YKqtouUi0/kwwrltTl7
	vf5CZpoaMourCdLID92WnPGKaNYZaPQG18RGzFTWRp91SUJPGnWwwWIsK34StnRJxfqOiIiv2wF
	vLXLgK2TVEHtynU3qudNwZuUB+rApif+uTLoCd/wuBa82aWbTJkksBDDdws29EN8TCgkULmyxcF
	40R35+P1XmnqZ1X1bfIGv/N8RNI5Qnbl6iGZYUyy7A8glIq+aoiTD+8SoypaE0PaU=
X-Google-Smtp-Source: AGHT+IGbpxhkkCFfYLFi2pkEmN+VY/Htmin9lmOYyGyF+HoewIO2bfL2isyMIVIopnCZQfJHgUOXEA==
X-Received: by 2002:a05:701a:ca08:b0:11b:9386:825b with SMTP id a92af1059eb24-12172302a23mr38510813c88.48.1767572815709;
        Sun, 04 Jan 2026 16:26:55 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:55 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 05/17] wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
Date: Sun,  4 Jan 2026 16:26:26 -0800
Message-ID: <20260105002638.668723-6-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks throughout main.c for functions that call
mt792x_vif_to_bss_conf(), mt792x_vif_to_link(), and mt792x_sta_to_link()
without verifying the return value before dereferencing.

Functions fixed:
- mt7925_set_key(): Check link_conf, mconf, and mlink before use
- mt7925_mac_link_sta_add(): Check link_conf before BSS info update
- mt7925_mac_link_sta_assoc(): Check mlink and link_conf before use
- mt7925_mac_link_sta_remove(): Check mlink and link_conf, add goto
  label for proper cleanup path
- mt7925_change_vif_links(): Check link_conf before adding BSS

These functions can receive NULL when the link configuration in mac80211
is not yet synchronized with the driver's link tracking during MLO
operations or state transitions.

Without these checks, the driver crashes during station add/remove/
association operations with NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  Call Trace:
   mt7925_mac_link_sta_add+0x...
   ...

Found through static analysis and triggered during BSSID roaming on
systems with multiple access points.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9f17b21aef1c..7d3322461bcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -604,6 +604,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink)
+		return -EINVAL;
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -889,6 +893,8 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -1034,6 +1040,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1043,12 +1051,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, true);
+		if (mconf)
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, true);
 	}
 
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
@@ -1095,6 +1104,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1108,10 +1119,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1119,6 +1132,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
+out:
 
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
@@ -2031,6 +2045,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mlink = mlinks[link_id];
 		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
+		if (!link_conf) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
 		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
 
-- 
2.51.0


