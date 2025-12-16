Return-Path: <linux-wireless+bounces-29769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD9CC0987
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 03:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FC00302262E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C294224B05;
	Tue, 16 Dec 2025 02:20:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161D2E1758
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851624; cv=none; b=AFbZbPyTi9dFqXsM/X4V+pxfzk50kcR+AQVjl8jFY5yiEvb9NinDOn1VjGeUQEMqiUf6SLEIckazDnHG0WjzwkRMvr2fsUM8tYqCZyUtubueYsrnTWfRYLlEHfp6h7jLqxXSU3c+3pgV55JzAqN6CZq1HdigvWNeiowH9pT8z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851624; c=relaxed/simple;
	bh=gl5/sgjlAvAA5PBGYxZl5Ve4hVeO5nmKFmu1f6TOBY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYzVeH+aGgwfX/ufue654nC8VXNoSMud7JlUlayjpI14+5o4zPIN1Ke/AnjTGGLwdKoFr31A2kUULe+MPJmx9pwAVul0g1t3dnNLO7gapLIATW2Qxd+yOpkcyEHSv1oSQrh0z9o2Lb588UHveNYbIfO5WtVH0YrGWDciBIbhyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6cc366884so2298024a34.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 18:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851621; x=1766456421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhtuyS31s0lSv5xn4EwB/1db3Cviy3KjXj67mW+gHKc=;
        b=Nax+Xsa+Tf7lSwzaiKvSetXN1s+gDqc9d91MQ+X6+f9w44kxX1KK/9ug/TF4/KBHg3
         NLRSaPx/ogxcWdjJm0+uI/pNsCXw2Z6e+3WjHiqyG5+Ni20sgwEn8sPg78WLaR+FZu+h
         V2/mYbucw8VWXx/Qt0txhl12QulsI8rB9ft4eLJLti0J6VI5d6el1h14CckRQLisvNc9
         GeXwuwk0hCQjPHkMuaLmY054PYq+/c538AHCYn7IdPhFh4EAv612/rVioyZ012UaxP4u
         Fy024FGyY8aoUmXNOVIBhVSj1MeGiC5xAeF8NLU3Akv/U7zhsTX9uMr2HcrN34cfMzJN
         cenQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjWGsXB4KlgBUb0vjtEoHoInJ9nmG/HwdtZJNWzl9mIQ01h05/fhv6RT7OcSS54asyfF625jHcuJkB1ItWKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5mdmmMZax5NW5INBnRODTgOQ/iEww9FVA1otRpizSCE+8l+B
	ZsRFiOCDTEfoZHeNCrLaBFGUTrYa6zGWttmh023w2wXoJm8gO0hYaRX3
X-Gm-Gg: AY/fxX6crP4ccdQmJjA97Cofoh7Ggd3Mu9qdsaTins+UVkliy0fQCXXGHLW0ehy6odK
	u4dCDe18+i3i7wQz5SCG97z7aJh1GrY2ZB8ET7bWDoeaqcQJfu+dkYsdXYsNuxqZCQ9l697ge82
	VTghcuxMJozqsmxAQRrb2jwKzD93f/gg1G789FNq6+9gMtfl1nEy4zzk9oVZ4k06wMWNnvmZ7os
	xII84NZaYM7EPtzLfAhixtR1qMy7CLcuHuKpMhX/9Pd4wQ8O2liZWJMgAZNWeS5Z1Gga4FASRFG
	Ji5hyHdBJwN2PrDu170V/FUzcLhctl1c+ByHQBXQggRhigZdatzO2+wLaAsHdKwlnahv64q/qGA
	MDCvskyKKcMZgFLAuoUdO0y29t40pD8YmSmbaa5FoTKYMp3oCNgivAd8YgWmgK0OvrtW6pjtjAW
	IEMO8hlH9EEVgOVOzyHAFsy7d+G3+8v7aThT8=
X-Google-Smtp-Source: AGHT+IEPInq7dKU5i3Nd5L9Ji23HRKytxpyOM8YuU0xOHiVpfXXjN5F/WsiOYHiZbg79z4RVoHcVtg==
X-Received: by 2002:a05:6830:3109:b0:7c7:5f6e:f260 with SMTP id 46e09a7af769-7cae82d5f94mr8309902a34.5.1765851619950;
        Mon, 15 Dec 2025 18:20:19 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1d0e22sm10798074a34.1.2025.12.15.18.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:20:19 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: allan.wang@mediatek.com,
	quan.zhou@mediatek.com,
	leon.yen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: drop puncturing handling from BSS change path
Date: Mon, 15 Dec 2025 20:20:17 -0600
Message-ID: <20251216022017.23870-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

IEEE80211_CHANCTX_CHANGE_PUNCTURING is a channel context change
flag and should not be checked in the BSS change handler, where
the changed mask represents enum ieee80211_bss_change.

Remove the puncturing handling from the BSS path and rely on
mt7925_change_chanctx() to update puncturing configuration.

Fixes: cadebdad959b ("wifi: mt76: mt7925: add EHT preamble puncturing")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 05990455ee7d..faed4b236d00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1898,10 +1898,8 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_bss_conf *mconf;
-	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
-	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1943,10 +1941,6 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 		mvif->mlo_pm_state = MT792x_MLO_CHANGED_PS;
 	}
 
-	if (changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
-		mt7925_mcu_set_eht_pp(mvif->phy->mt76, &mconf->mt76,
-				      link_conf, NULL);
-
 	if (changed & BSS_CHANGED_CQM)
 		mt7925_mcu_set_rssimonitor(dev, vif);
 
-- 
2.43.0


