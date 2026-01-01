Return-Path: <linux-wireless+bounces-30258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD6CECD7F
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880DA300DA50
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27B21638D;
	Thu,  1 Jan 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLNhwuqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535921CC62
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248719; cv=none; b=WK31XYw5sk/uJSgVcQRUOhzViClHGU3eY9CBB3+uSPj2J+rMARxfb2lHeqPYaFPMqQ8fVSjpYjcbJ18NOVEeQfznMoKzKHz1Mr33tGlR3XwI+5M2bXybBH5HDv5WIKOkb4tXWlGb1kCmvsITgLlzZvgEE7Ku2v9DGqETCEUL9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248719; c=relaxed/simple;
	bh=khNV5aB+o9A8jl+FGzbHU4fG4yVNjom9idU80qJGfUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDwuvpNMlJ1zHSPYjkZXZzjFuuSyYDoE7WgHeQD9ipMTDUWtKHJMXwozRt19GAqYvNe2X7XF8BITHiKwLi972Ka7I5OsscSxoT4zu/fZUt/REijjxAtQoJzL9QR9dqtQylEMQr6cScdXaNZYDuM2ZdGgKz1JXljXEct1mUSFxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLNhwuqJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c718c5481so10776364a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248717; x=1767853517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE0rI5P7eKNbejouiqbb/lEDUIGRekIUepADcT1rcR4=;
        b=aLNhwuqJ0lJlivlWDjwK38jqRJOWnZX074EjxLEd1LY41Z7Utdh9MP45vnGocCqZ/i
         Cckk8+4qxEpxkJv+tJCLQFR1RJlJ+QRhOr40Q+VRm54BUg2NwwXaYtKRdPzbnOo3Q117
         lN6rl6UdN6pex7f/D6pWMod6/3bh8oaVC7+mumOnZBUlEZB81WEXA9hkVXRn0xfaL/GL
         3S23gp6LnkbkN4zvl6cVFruMSJLh9ABzfi/y9Lt1G8vRUNGJyZUTfhEXGI+rAG/8BRea
         OwsWu225Bda6jlR11J3k+G394tJZWIZVhY3Fvvy2/fEJxtVxorTgJQSo9xVGyGSosMyH
         ewZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248717; x=1767853517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SE0rI5P7eKNbejouiqbb/lEDUIGRekIUepADcT1rcR4=;
        b=Fp7kc0esy5yczrAG6gRMnLjVrAo2DAJz3lakSQT4NLSkWFWmcLWYgypaXipLpMMBq0
         JmWqCZadgDd3SHzOA/cYVXvmHEwVv6eieKyqf6nAPQ5u4tFCB8vmSOapk/W593ZbMNA/
         Ap/1K9r6nNsJ6dCYAUQnSGgylu0OKvPz6UWMxqqnEic9ufzlqYbeSM9WGqUXTNQJkJAj
         bf6xBbjznnOV2Civ1WykbMrtK+UtxxgVydWrI5K+XiQbMQiV38AFU2VifdtKu5r6Ulz/
         Xa/d+MfMteRyW8fRh668CKcPhHIGYJNm5V57IYwttx+qBtHD1EU6eD9wU8Vio+aVo+TT
         zgiw==
X-Gm-Message-State: AOJu0YzjWTL3/ytBTfPWZtyq8327VLNQO9R0pM+ErUjyOcIBnMEJfjYR
	5T8eUMQ4cxEMykoPPSK5db4NVQ1HbPbUlLTXFtJ+Vo41IjDEYCVdcvu/Km9aq7a0
X-Gm-Gg: AY/fxX4VtBmDhXamS7cBIsqlutUtc+M+VeH/hfyhmPEASYC5Nw6mqqnUFqSirXgmZsi
	z6E6rlxah2fshguH4opAXHAz9J+etY0UdZI+uZfJM2HTjnC3rmRMXnQ8uTQIw5z5hd8ifThHQLY
	6EX9M+JCPpA4ngsvyxmrzwj0NjUrIcwLjLl6BK0tIczKn/vvZxEPDaCcAhtIm/C4tL61A7ATwvj
	OXQN1UBYLor+RMA7SPudGNjssAqet3wtsPl1PsnIIf8lyP0zZ/Gwo+2aJZceDv27s++TNgqnS1w
	Kz06e2wLkqpe5+lISbJk++2jNtVtoMb00wtp0jLC5GiDnpYl5/1nAr+LPUV2nB7SE2QCg2WAog4
	Yb2RtqrquGxKVQ8NZNDjumsdgpbbaVR8JrlgdBNDQ9tTvMjsOz2UQh+dugGmjkwuEVw6gDZ67Y9
	b92o63bWU5wvFDezjUJUWGQBpJsDNBF6+I/RqOocAaZ9QrF4j5blcNgodlTNzlSg==
X-Google-Smtp-Source: AGHT+IGRnYMQUKgIm6YN48+hICeeanP0w+GQDI9J6UXpl+np4+nuvCPHeQpD6aFl/O7XmVnhvN3Beg==
X-Received: by 2002:a05:7022:3c06:b0:119:e569:f258 with SMTP id a92af1059eb24-121721acc08mr31579034c88.1.1767248716890;
        Wed, 31 Dec 2025 22:25:16 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm147035158c88.17.2025.12.31.22.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:16 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
Date: Wed, 31 Dec 2025 22:25:13 -0800
Message-ID: <20260101062514.186040-2-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101062514.186040-1-zbowling@gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
 <20260101062514.186040-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

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

Without these checks, the driver will crash with NULL pointer
dereferences during station add/remove/association operations.

Reported-by: Zac Bowling <zac@zacbowling.com>
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


