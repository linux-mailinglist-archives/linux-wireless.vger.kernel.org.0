Return-Path: <linux-wireless+bounces-31301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD6XKuQae2msBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:31:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE842AD861
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D226D30194B9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5737B400;
	Thu, 29 Jan 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnr0rnbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B3378D8C
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674731; cv=none; b=bKXM4VQs4qRr8BrQEKcKTQzjWVB2Mf3ZTjzGRs83zXyGAwn9W9qJUixx3y6q54WYNI0HN9Qi/GPmbz6M6ZOpNnd4thHqVNOKZaXCfiEjkAWnDvtZGXBw3nh0UCAFb2gwnFdXlaHUJe62j+w4ocgl8S8Q+UjWDaxjSZKnkBj4Dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674731; c=relaxed/simple;
	bh=PVbiPBzKjrcY+30wKeQPbwFap3HDwi340Gx5QUpF0Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOiV8SBvHfnL3SfrzJy0TDhNPHGcD3QPf7dITZQqJfZpRPXLO0zrTy1Wgf2dwNHG0mGegMVOK/461nb9F+eeNOaAbr5ugy70+df1CuT550/69FGX2vRDLr8DhYBXcTgJk8KeDR9KgADk392MDJGHlhajPBJFDkn5mRLYzNB/D1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnr0rnbE; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12460a7caa2so926454c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674729; x=1770279529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naEzUi5T5XiWE+zV5MsLkVzO6TX0wOB54z5FQcjozZA=;
        b=Bnr0rnbEnSbFCf+BmhzDjHZfI/6cZrt/vaSsQ/Gr3uwkIw2qFGsP6DARfQTc8T3Yym
         4l725FsRMwBu5UR6asXNZ/650fBbWoMWJvT4hDmchkZTfQxNDrDx7RQyAmg4gxzmiSkb
         U0+uE6XdLGgVEbT3GrivtqimMFkw8EVRk4Wjrxso14AReiC+7FA7PLgeXLR4XtaPuhoy
         A4QGwWJyXKwgvB1i2C9wlZe+xNQQpW7T+Kt00m4ETfnEEBk4VrZN4RaKz69Kkgsz9u8D
         gyvzxDVbZO+rY2SkTGmsq9GlgEzkcO0bLOxR9qgwzWZlYFJmfIpTk3QLzTM9I4NndtiT
         tUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674729; x=1770279529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naEzUi5T5XiWE+zV5MsLkVzO6TX0wOB54z5FQcjozZA=;
        b=gmNtl04kQfy4Ybm+VHBBkIkw7Qjvzw/MgYSqKNyXYReBkhf+Li6sxkaQV5eEYSTTpa
         x9JfaKAI/TgXnH3WdCTQv+OUVajhCFKEEyoNWNpRPfruBSAXrQ5pncl7qsdqjtBCOwTu
         Lp8CCEfDttRrLnJj3XcFaS8MDyZxH5V8CDV4TyIo3/BpUKf2cqg6B+i+wsXX2KxzCfAT
         4x6ncoRT8UG9fjSp3gjn6M8Ez5EGFdFuC6gQV8w7r0gWaKG/0maQ2hOQSmC/7qI+bGX3
         7ngQSZu10KFfTQL4CvXvQhaQ8siokM/+yYs++pjpwUIybRVR1Aebw/QpcAGlNK4QRQW/
         xTPA==
X-Forwarded-Encrypted: i=1; AJvYcCV2dtWOn+kNAP6rjiP4lafrATn4Itxse/CR3k/G84M3PpK5QNkGenyb+1grTzLSkWeS+C32wkgEIzbE1p5SfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XINVzyJzV5ZKvQgrW8YR+r3dcRjIRpkgRXWdA6cCZdaJHrDE
	hGEyDtUNUt6s0Rx9k5Ou5quhQWJkwc9BI6PLscEbzfWshNQd/MPON/uY
X-Gm-Gg: AZuq6aK3ZNg0JXTjtCCl2EWxT2yTk8Gtfz5ZIhNeSbht6/EJ4zUTAzhd5xLoHxeZHW8
	AgZsrkMO3Utxfw1cSCbvYufWHj9huqD842IFM+eNlpEqilBPfsAYN3u3QkuTwvPoPDhLMgfHbOi
	Jpqm7TmGOESfFwcmRtAo7Y1bARJorkZjRK1bN5iQGWuITxwRF7glbvPvrD45XTmiImsju0Jup/5
	r7T5kWHyOCs7aWnpkQczNAz5R6So9BGOnJqGvVCYjenO/W6gHwu5Y9itYQyrdLTlZTsfAkcZ/LH
	nMLQdg0n5t3cZ/01QxTATTF5H854zsJHya5KILiBxdr28Zd+7Tqrcax8MFo6dc1N29ilNR47tIM
	mJvW9cvvnlGhX1Az6KfZGsa7rBQ5ZTgb7KSCpvrXAf8ffhsPsS+ef9VD7d9sodrh1Lge+9RlF0y
	iMrxvEaUZZb25s7twjIxsUi4kgAX+lo2waTPDeSVKiVEyQP7AA4ms2u+T8D7xl
X-Received: by 2002:a05:7022:628e:b0:124:9e46:82fb with SMTP id a92af1059eb24-124a00d183bmr4844023c88.38.1769674728985;
        Thu, 29 Jan 2026 00:18:48 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:48 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 2/6] wifi: mt76: mt7925: add NULL pointer protection for MLO state transitions
Date: Thu, 29 Jan 2026 00:18:35 -0800
Message-ID: <20260129081839.179709-3-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31301-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:mid,zacbowling.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE842AD861
X-Rspamd-Action: no action

Add NULL pointer checks for functions that return pointers to link-related
structures throughout the mt7925 driver. During MLO state transitions,
these functions can return NULL when link configuration is not synchronized.

Functions protected:
- mt792x_vif_to_bss_conf(): Returns link BSS configuration
- mt792x_vif_to_link(): Returns driver link state
- mt792x_sta_to_link(): Returns station link state

Key changes:

1. mt7925_set_link_key():
   - Check link_conf, mconf, mlink before use
   - During MLO roaming, allow key removal to succeed if link is already gone

2. mt7925_mac_link_sta_add():
   - Check mlink and mconf before WCID allocation
   - Check link_conf before BSS info update
   - Add proper WCID cleanup on error paths (err_wcid label)
   - Check MCU return values and propagate errors

3. mt7925_mac_link_sta_assoc():
   - Check mlink before use
   - Check link_conf and mconf before BSS info update

4. mt7925_mac_link_sta_remove():
   - Check mlink before use
   - Check link_conf and mconf before cleanup operations

Prevents crashes during:
- BSSID roaming transitions
- MLO setup and teardown
- Hardware reset operations

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 66 ++++++++++++++-----
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index fad3b1505f67..88ee90709b75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -612,6 +612,17 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
+		return -EINVAL;
+	}
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -864,12 +875,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
+
+	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
-	mconf = mt792x_vif_to_link(mvif, link_id);
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -888,21 +904,28 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-		return ret;
+		goto err_wcid;
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf) {
+		ret = -EINVAL;
+		goto err_wcid;
+	}
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			goto err_wcid;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -910,28 +933,34 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
 					    true, MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else {
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
+
+err_wcid:
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+	return ret;
 }
 
 static int
@@ -1039,6 +1068,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1048,12 +1079,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
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
@@ -1100,6 +1132,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1113,10 +1147,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1124,7 +1160,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
-
+out:
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
 		list_del_init(&mlink->wcid.poll_list);
-- 
2.52.0


