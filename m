Return-Path: <linux-wireless+bounces-30253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31243CECB2B
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 01:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B6A30036D2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B91F4631;
	Thu,  1 Jan 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OETg7otX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4D1EF36E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227008; cv=none; b=AOXNCJ6u0OegYPS+Rd4eI7ka3PmVnPNYoVUJvxRNcv5Wm7c+f9FLvkD1jI7rV36Du7cOc0ntK3XVjdMk3U9A6ho0Eqw90MoMiu7M9xQu5g8sWnzYDmjosq021WgUxupDa8xqxse/q0h9BW//4sYvNSqYUbn9DEtkWIQOHO4aYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227008; c=relaxed/simple;
	bh=xM9mcSunKj8kKzgP5fJYrWk5J2CBcNHS1x6sc1SLRY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVkUkpuZf4JAIWpyijg1BIE0yvRWSid5kcYl6vNO4mCGs6QG86Vjndsh9uMg9QbkXSSmFfD9uxNODuHqmar0FIgh0ls33KRx+Cwq7tuol18t+SypBJ1mjuGjjrkXtlxrIDAR38Oq7DXndksTIpTlKvY3vHdL+o+aFAno1LcKvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OETg7otX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso6339868a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767227006; x=1767831806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tGvQJO5+HZJPPO1KqQBIk25B8v7Ymb/OBKhMnfOmuo=;
        b=OETg7otXhAs+/p16lKjP6WySKCS1No08XkDaTCjczKBmW5jLR8CK0oTuZ1aZmnVlNv
         mQjf68GjDNjGWfw4utIe3Nahb0IWsbxDjVM4t9UW+KbI92iZFCZFpsc7KFXqiEz4d4Tx
         l8oTuAUBRAjDjtKoOjGUm9UA8n90cCk+GuXbturaHct6+QINIdddDvJeTG7An609qivx
         HTWGKcJb85Zal4zW+tn/OICZ4NT6py6dnBxMpncRjIW1FOaet1WkOuYh99LkojrzFNXO
         HuNR9cKmfzLS8U1iN03iRkMZOWXuthuJoD80YkObirrqzbdxWvUUikl3VkBjzVZM5nq6
         C03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767227006; x=1767831806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tGvQJO5+HZJPPO1KqQBIk25B8v7Ymb/OBKhMnfOmuo=;
        b=m9MR93Z/Ka4dgYDPrL0SC9vf9Cg5oKv8o5WQfPkDfRt43hedPue2xYLXyUMFaRuCI+
         X0gJ8u/wzHpZahpsod67qFK+IwK8E9HG/DepNtksnaZe+bV2nPIECh2dxVs79hsPs/Q9
         XE5SLWzl/konuyu1WwLu5tXlb/KBrAZ7uQ81p7gsaH1OAYy4gBif0lyQxLpOXl2l9uTy
         A7Ec62H10MfPGB1Tw0+L79NExeB57o+QMs2PDOM2iQ/7c1hCe0DF6DzfWj85ujdeIG8q
         KHuAYunHMKtSKgOPAtaySPI7eP+65P170fEvNUUTQfqeaKLK3InC+hv3/gp/vDTc4TwD
         kA9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqCSI5/NaiTGk+R73O3rKc4d4T2msvceDk7uOL+1uCyCvOKJxdWEh8DzthpLzlDGcUwmQ+SkeYZXSQMRqF4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8Obws00AweZVxSz+ERmjIipdaAR6A+0NhEQm8waREYCHKqy4
	PI//BvJCGGuXS/kUAR+L1Ixg9oXWBbyaSQ3QxPfoHmpcfXdv3PHpXXuF
X-Gm-Gg: AY/fxX6UtPAH4jmWkihXBSZy2stiHRKwZ1cvDzpSi0H3i6vq9N3/iRhm4p0sF9RygGJ
	J58dbV/Gz3fUQXTXng2h0APMvw5VQU611lugnshg4FcUYMpUWt8j3rKTFLKZ9KX1modt2/c4fs3
	8satX+ljHcDxfze3YFYkYPm/4VuDjzqxukJbHF/2WXOfVW2uwuhEClf/41NZpYAlyythOQCB8sc
	oR8VMTW3fu4Fnmzlc1lbgzGeB5q42scLW3ndsOvrsxkS/7fmlgbIlgxRA9cAwLX9Lo2EQiTVDEe
	BGcmfxmNYmjq0+GeVcwbhi5xoUZPBB1ysDkQwY0HaQ1CqF995Fx6VHieqq6Q0Ov+Mc6uNy1r0Ee
	Q/0slunqhQijAvoW5c7ZxhM7qR6iJq8eKb48msOOdIAdBOgTHuz+r/IESri9btp3TP+2tV313Ms
	eJQxpYt+8xIJgp8pq6hm1DCJRX0G2M7Fjfl4JDkgEw1s6YNYTvj1MYWAVv/UuP/28=
X-Google-Smtp-Source: AGHT+IEp/vktO+XgxIsz+HGD/FJGg3RlZ+uFDOzJ5P0vN0KkOMaBT32tzp8lCNQ2kbNN45KfK7ax3Q==
X-Received: by 2002:a05:693c:800e:b0:2a4:3593:dde0 with SMTP id 5a478bee46e88-2b05ebd065dmr25592455eec.13.1767227005665;
        Wed, 31 Dec 2025 16:23:25 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm81206627eec.5.2025.12.31.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 16:23:25 -0800 (PST)
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
	sean.wang@mediatek.com,
	zac@zacbowling.com
Subject: [PATCH 3/3] wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO PM
Date: Wed, 31 Dec 2025 16:23:21 -0800
Message-ID: <20260101002321.19332-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231223702.30957-1-zbowling@gmail.com>
References: <20251231223702.30957-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Two additional code paths were identified that iterate over active
interfaces and call MCU functions without proper mutex protection:

1. mt7925_set_runtime_pm(): Called when runtime PM settings change.
   The callback mt7925_pm_interface_iter() calls mt7925_mcu_set_beacon_filter()
   which in turn calls mt7925_mcu_set_rxfilter(). These MCU functions require
   the device mutex to be held.

2. mt7925_mlo_pm_work(): A workqueue function for MLO power management.
   The callback mt7925_mlo_pm_iter() was acquiring mutex internally, which
   is inconsistent with the rest of the driver where the caller holds the
   mutex during interface iteration. Move the mutex to the caller for
   consistency and to prevent potential race conditions.

The impact of these bugs:
- mt7925_set_runtime_pm(): Can cause deadlocks when power management
  settings are changed while WiFi is active
- mt7925_mlo_pm_work(): Can cause race conditions during MLO power save
  state transitions

Note: Similar bugs exist in the mt7921 driver and should be fixed in a
separate patch series.

Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3001a62a8b67..9f17b21aef1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -751,9 +751,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
@@ -1301,14 +1303,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
 		return;
 
-	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		if (!bss_conf)
 			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
-	mt792x_mutex_release(dev);
 }
 
 void mt7925_mlo_pm_work(struct work_struct *work)
@@ -1317,9 +1317,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					      mlo_pm_work.work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_mlo_pm_iter, dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_scan_work(struct work_struct *work)
-- 
2.51.0


