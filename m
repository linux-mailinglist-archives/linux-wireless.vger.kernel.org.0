Return-Path: <linux-wireless+bounces-18750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571BA3056E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EC97A2460
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E561EEA2B;
	Tue, 11 Feb 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="utrN/Xpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EB1EF09C
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261659; cv=none; b=hz81NSW8giQ62Pvm6NuCOPqk3EiHIp75qrp46eY3NI5hOSY4jxcVPmF47vtIr00cy7vn+WKmZp4eltIe++0WxrwetiZ+FF+Q+eGzopk1tYAP6fHULxtqJHs54RYXSu9C4QfK+gxTMfhV0Fwlr1EOhq7+SyOsq5/8VujQpN1H7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261659; c=relaxed/simple;
	bh=u/RYyACzzXZRV3vYaG3cHQ0vShvo+X5H5SvWaUMYYZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6gBgnpTDS1YTVSgOC5dj9XdTvSKPSS7gYLefmYCyinLudcybp2x0Ir+SMsKTnyKHxqxxld/+ADBGKm04n7erkDM3BqySQGg38CynhTvQS2fuPwWpLe4ZzZWaaYfiDSsERDmBFt500Ht69+d76ARcEQiksnjaCo2PkfoB+LGGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=utrN/Xpt; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso6147408a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261656; x=1739866456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0oOsSFRp5Fuzl3plV3ATb2jSNL46+1qwCPfmbsTCKA=;
        b=utrN/XptfWXZcw5lOu5h996JMapGxK87eXDcSkszgCy2yUsisStR8nig75Ma/PufHV
         v6ktKxM1LVZ88ULgLYiQhpt9Ru5Vy8RKOrqhexmQFEkMNGmmow82GFKr/seMHMCXT0wH
         J7iCfvGqkmxuU1E3/KfS7oejUBcm0uwTFUbn2Boa5anFvA1wGT1wIadDmNAX00Unoq5z
         CZa/lpvyFxkMs6Buht9dSwqad2Ir+a4HgVVfCa+L1YFBmun/CeljZrU3LEFetdQf7WZJ
         P8tL4ICtKwJqa477hdvt0r/ju9a/QODkTtynVHHXYQ22f1bWbTThwYnz3QYBNGx7SiYV
         69sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261656; x=1739866456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0oOsSFRp5Fuzl3plV3ATb2jSNL46+1qwCPfmbsTCKA=;
        b=gAGr9emHLQvQPiKQmuzSwQ+YoptpbYAZ1aOmBfN5eDkcllyNdZvmN8jFnU2gbq6Ub5
         o2xoWw6/zxjDvnCv0Q0CzauetfXlIrPTWOV9t+wyYvRhBzIf2rxkS5pqVU+uyfckf0BR
         r9gNRyswmGuVU/z8bxLuNaoVU2J5MyC4+D+emIyinwRgqfzQ4BG4SbNsS3viev3b8Xvc
         L1AkX3Xm423aBHMAih4zejEI1BkzOcXLxu3sMTllnVbojWfX17UyCrH67KnYMYa2pSQI
         EH0oUOR1BKF+voL86m99REYSmCXNVs7IHpxu8XUbKVnDYY5JtrSwf/6EK/UOQDAGtwVa
         DEvA==
X-Gm-Message-State: AOJu0YzM0pB49LetfZ1sm6XbPkdlk3FZkDquxsPaBHX4FCjM/GNBfgGO
	J8wFghLmPKyUXu3/b/ak38WH7GshHw1vNkRCuLyXnyij/xggVKk2Cpl+XQhgflzGYzyo4VhcQia
	vv3hi4Jue87wvhJWMIZXRTIoF4vWdgn3AY/AQPXt/
X-Gm-Gg: ASbGnctcjatXRH6STED5XTwbDQvX3xovo3OP62g7tT5yp3qVW9AmX8AuCqI1Po/Vh8N
	PV8as4mDxW/9P/srVGxwqVaKUIlJ0aJj05LOtDMf/64ek1Njge0l3bGwy63IZWrPbeFyyuPjHX9
	eBICfsR/Iimf3saFRA93DaJNi8L86AE9rEaruaa20Pm6cb71THETYA7hcaQmHS8Xxd1OFpwVuQO
	5qyxmrD6PiLCbblzUzR4a/s10jpq4Tl7VdWg551RYMymippce2iiYTBRJHOvGpLaTerHzMWXpOL
	nqu3jnjyg3+suVxvgyDVrg75ccxijw==
X-Google-Smtp-Source: AGHT+IFZ0nKlcGqOHVUKBsDBI9T1XXxwWfg67PRNLHB4E9LkCFGo5R0HK2XymCQf8TLQZQ+vtsJBenMBqyQT
X-Received: by 2002:a05:6402:3483:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5de450734c8mr14633402a12.23.1739261655805;
        Tue, 11 Feb 2025 00:14:15 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:14:15 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 4/5] wifi: mt76: mt7915: cleanup mt7915_get_power_bound
Date: Tue, 11 Feb 2025 08:12:46 +0000
Message-Id: <20250211081247.5892-5-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
References: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor for making use of mt76_get_power_bound instead of the specific
mt7915_get_power_bound, since we need this for other chipsets as well
when calculating txpower

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


