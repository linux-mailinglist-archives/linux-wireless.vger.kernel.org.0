Return-Path: <linux-wireless+bounces-18659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33BA2DA1F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 02:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD72D18870C0
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6F819;
	Sun,  9 Feb 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="a9nYADgO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD65C2FA
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064000; cv=none; b=t3Au3EDms63slAJgZ1DDE2X0XC4H7VeW88k7jih4cHX86P2uK1PgkhSbwwtZM2eIL2a819tfiKPVY0oMrgi4YMSo7unAzhPU5f7VKxrJdLgFpFjvMq2sSfgnBkfbosV42+19J1CtrQ3DrcCsMoG+Ievc1n2fDqyLmSZAr0Cwpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064000; c=relaxed/simple;
	bh=t8pRwyb5iqsvgi8w7U/f1jiK1/gjNAJI+lhEKoc8inU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duju+ui7O++0u9TZgUdTwq2T4Avpt1PZs320oBScb427kOMZmdYzvRtDY8jL6b3h0H70y/mh1e2bLnUQV54k0Xt6RQouncwUs+Tn/XcCZl4Tb8LtYD6d/3GO0w4N9f1i5p8PTTcaJuC93vxGqAb5xcV5UL1kCFQI497l1c61Ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=a9nYADgO; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so892121f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Feb 2025 17:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739063996; x=1739668796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZJKFXpmv9049aKXNRWNUIQUMoQOSvys/GDmEYCaXYU=;
        b=a9nYADgOI97a/AQWanFwyMfF7FdOgXsh7qebvJJUw+nEZTxWAvILXGGoRIO2WDtKZw
         LuW/3cSRbRwDCVU2b2/SrC789/QLEf4GC2uu28+8pUNbmPexeU/hbc5cNl0IMBG++5W9
         Xbjde4HV2qrtiXtFCG5GvxWeUFTDlmCNCcmQS9a1vk/tONd8+uM7zFLYY23Z+S1pEkHU
         Suo9D+zIL9bSU2nFSDOIAJAolhJG9F6O4AVElCE9TqgQOjBoAEHZ7Dl+JYfBonX9Xs+h
         M/AQJsW1yIoc2b6ufC7ucbhuXrlKm8k7VrEC0BkWv/gsZj/QmaQVGPtscBP3qkaTjihW
         lKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739063996; x=1739668796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZJKFXpmv9049aKXNRWNUIQUMoQOSvys/GDmEYCaXYU=;
        b=HL7hxG2/GlEMuG1LRexRenjXEfdVzcUfFrKDNOhkTANpeze43Q6bSJlQ0sRSgbY4sf
         jQYLU7gJzK2lEmvN6H/sHmT2/xpjJaudm0fFUV0OkmSs1r80RBO8tmJiTXBomVzNnJvO
         0Ajx4Q/VovyHPEyN4hBevXpYaV2B6lP/v6cPcQ8yX8710wEhBS72K3U8to9QqEz8Kyv4
         aa9XWve6bLWiyS9yv8RFRyRQjPqopKiqq9muE7TpBbwxmu4r58qaOi3G6matnGJb9wNs
         L8l4cVA/k8Yk+jK9AmjR+4GKTCUVq0bioeY4MYiSUNENlJK7Xsh4FZDXM4zRoI5rCuH0
         pvyw==
X-Gm-Message-State: AOJu0Yz248iqLyw2UZAW5SPEzfJnFjSfKC0bSXYEF5T8zQ00/M1U9S0M
	L/oE39+NIOqHjME0Qz5yFwZymh8ZvOAb47lO7noOEFu6k+3fbThqNHQjqOOxXBAV2UtkqILu0KF
	2Oh41dOxYVMS4FLvjZo6EuTtG6ojvbMxiLMFm8eef
X-Gm-Gg: ASbGnctH5sco15/5kesKqxpHH3YQREUoM4FqXoYZ23oiSn7qMpoQxo3G4CPOt1+1pLT
	+1cVj3FSsFAzF084Os8Hp9i318HJ0xgkNU9p8OwS7vmALoIc5Gs9jikJCQFA8gbKv3ZdwyJWJeX
	4L5fZcuu2GrW5sqZEXmNSBV/HFqXve8X7mg910F5AHeI7XfFQpbr3ITdiHZeG/4mZGZvVEvx8sI
	hNsQgEc9+D9LajzigpeRYDyuyfzpQEybS45n2ZEB1kZlhfwoa0B4DGa6mil/NDt2uPl6ZEys3SR
	hoLgauvz59Ao0mzuVGRqTLbTNf6Wzw==
X-Google-Smtp-Source: AGHT+IEY+9+nVTrq70uyLYn+6ztmpfLthD1RUyUHzVRSYm2Rhfe/mJx57VPZvj3Qr7NMmRM/ciGe5cwR0+uy
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id ffacd0b85a97d-38dc9346494mr5769422f8f.32.1739063996430;
        Sat, 08 Feb 2025 17:19:56 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38dd6880056sm149536f8f.16.2025.02.08.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:19:56 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH 4/4] wifi: mt76: mt7915: cleanup mt7915_get_power_bound
Date: Sun,  9 Feb 2025 01:18:56 +0000
Message-Id: <20250209011856.6726-5-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
References: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor for making use of mt76_get_power_bound instead of the specific mt7915_get_power_bound, since we need this for other chipsets as well when calculating txpower

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     | 12 ------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 578013884e43..db8560f7e657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1084,13 +1084,13 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 
 	if (pwr160)
-		pwr160 = mt7915_get_power_bound(phy, pwr160);
+		pwr160 = mt76_get_power_bound(mphy, pwr160);
 	if (pwr80)
-		pwr80 = mt7915_get_power_bound(phy, pwr80);
+		pwr80 = mt76_get_power_bound(mphy, pwr80);
 	if (pwr40)
-		pwr40 = mt7915_get_power_bound(phy, pwr40);
+		pwr40 = mt76_get_power_bound(mphy, pwr40);
 	if (pwr20)
-		pwr20 = mt7915_get_power_bound(phy, pwr20);
+		pwr20 = mt76_get_power_bound(mphy, pwr20);
 
 	if (pwr160 < 0 || pwr80 < 0 || pwr40 < 0 || pwr20 < 0)
 		return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9d790f234e82..3643c72bb68d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3323,7 +3323,7 @@ int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 	if (ret)
 		return ret;
 
-	txpower = mt7915_get_power_bound(phy, txpower);
+	txpower = mt76_get_power_bound(mphy, txpower);
 	if (txpower > mphy->txpower_cur || txpower < 0)
 		return -EINVAL;
 
@@ -3373,7 +3373,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 	int i, idx;
 	int tx_power;
 
-	tx_power = mt7915_get_power_bound(phy, hw->conf.power_level);
+	tx_power = mt76_get_power_bound(mphy, hw->conf.power_level);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &limits_array, tx_power);
 	mphy->txpower_cur = tx_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 49476a4182fd..092ed504a8f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -515,16 +515,4 @@ enum {
 					 sizeof(struct bss_info_bmc_rate) +\
 					 sizeof(struct bss_info_ext_bss))
 
-static inline s8
-mt7915_get_power_bound(struct mt7915_phy *phy, s8 txpower)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	int n_chains = hweight16(mphy->chainmask);
-
-	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
-	txpower -= mt76_tx_power_nss_delta(n_chains);
-
-	return txpower;
-}
-
 #endif
-- 
2.34.1


