Return-Path: <linux-wireless+bounces-18748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D019CA3056C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB827A2572
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F91EEA2F;
	Tue, 11 Feb 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="ZW7Te1Uk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B81EEA4B
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261655; cv=none; b=kVG9efEnYgI+ZfmGhbiyvegvtCvcZ5mJRx0dpFKRDR7uP5GW1oADXZHXOPP8qti2IaxhXJsxPvadsHKvloSM9UzADrW8f18gEoLkCKsjFY69BzPiapNfrziocq8HjH7sBav8E45fe7x6gVfbgKtD7u2HKZz8aHzHdnVhvDxvO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261655; c=relaxed/simple;
	bh=8Fx2o4/9alx0ubq/qGXg/mIOFiDYHtkRblyGfprneQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfyxHD/00mVCt+82TGQB2mztofBxSxHRi5pM4JIF2TBDs9u4/5NJhueQ1XnSiAnZeEhjP+e33bay1O9oxYtzEwOBTgh08Bti9pYQnHi7AxasxPnFMySwgJbJUyueNmroi/Mz3aROYCd0icskKxFSSOEh7SvbLYb7F6fBvyYLiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=ZW7Te1Uk; arc=none smtp.client-ip=209.85.208.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7259348a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261652; x=1739866452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVqpV2jN8bN/XpUbb3eWYROCnA/6Dk6ns0d+BlR50c8=;
        b=ZW7Te1Uk5e/dJ3SlRoVKWOF2AmfBqRj6z5dr/scDm60GgVYIcivwI1j3umqav+QQ12
         S98ookswlMb5YQAT4jfM+rGzmQYk9+CEbajDm+3J/H0Tkajkh5ZCktHjedQnYaJq2JmD
         eG7PRvn1nZVmytgShVdi+rf8cBd6cAyZrS9WV3uQjCQJEgirLyMZKKXq2unamz8r8x3q
         4g1kToRUi5dHfUwxNdP6zukRRZqwkprIPz2rhuCmaKY3vGSKOQP0SaIxLK035BYeCKaI
         8yTOivywLb8m+upGAMS+tvpVXjzzj9oUWJPqEEMKn2uOhdO08pqaq5lHXiDxe5Uu6Ars
         3yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261652; x=1739866452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVqpV2jN8bN/XpUbb3eWYROCnA/6Dk6ns0d+BlR50c8=;
        b=mDhcGQbL6S9Q0GEYcw0s9V2wGSQh824qFAvLfnWIhH9fHCtn8WUXqNRxNZ98OHCtCF
         ELqMKlyD0K+feP6I6iYBcDBqX8IVyDGWMJ2Z/Bh1CPc6Api8U/j47d7PiT3vFf6Dneaa
         +9fQSvEZ8h4avwR5+IOTBHQiDXR2PNPRVZbssn13+OPnXeJmVemJmOTkQhQ9tM3yvwW5
         mFWm6muCzxPWRgZE0ATTLWNHp7xeIy3Z+G4jscQX0ZEMlX5cmhykCFKzzft33n2gLn/N
         ctLRIX/qW/WNx+lyXbF4lg5XKmXKFbU7K6NRU5HxczyTFz7/zn2KOluMEb2KN+CbOhql
         uCqQ==
X-Gm-Message-State: AOJu0YzJW8N8FxQp2Wctto12XyHHnGB+jUanzT3OFp9qmbagOs/aiAy2
	oRIYpBPwcgPwlSpFv4JqEtfAxRRH/R6/kxQFjTQTPvDWF4/mUp9u01vjS6rsN3bVmVejeCpRwU8
	HmBoaTzfOIy0EqwCwU1ZaAqxLA7guQG5PibNxhm2D
X-Gm-Gg: ASbGncuF3s8whJa2F0rS9oRnBVL3c5IB7ew4cDo1sehIVDvwPDzVEqq5YoAUK2hx7E3
	W5KwduRHPZsOGJobjPHU8RRJRfkQgCfkCFwh2AHRdXudRB1UY1iw0OjZLp3rFyA1dSNJFUP84A9
	6CqB+iywDQ2qUgMIxX5KOQDsc9aasv5+wjefKXUkVoLyIzw/k1U8zKNc4MWjm1Jzk/NEsjzA6/V
	anWmsnCwSg4RV54iYRTnBjcMzhKOWgV1Kg3XXVJV9pcAaseYC0rfzDwyFp8ZWVxBUQ+8wmApwBF
	IGUemKess+iNDXdwrnrb5nVuysBH4g==
X-Google-Smtp-Source: AGHT+IExf794mWe/YHEDaIlMY5Ff6L1p/GFpIb4fyat0himzsY80j/8mUZWg7g38WgBJiFXgqNvSC2NYt+Hp
X-Received: by 2002:a05:6402:4416:b0:5dc:c9ce:b022 with SMTP id 4fb4d7f45d1cf-5de45005a55mr17506930a12.9.1739261651781;
        Tue, 11 Feb 2025 00:14:11 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:14:11 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 2/5] wifi: mt76: mt7921: fix returned txpower
Date: Tue, 11 Feb 2025 08:12:44 +0000
Message-Id: <20250211081247.5892-3-razvan.grigore@vampirebyte.ro>
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

This bug was noticed by me and confirmed by many more people using this
chipset with openwrt: https://github.com/openwrt/mt76/issues/783

It seems that for this particular chipset the mt76_phy->txpower_cur is
never set, like in the case of other chipsets like mt7603, mt7615, etc.

The driver is correctly calculating the TX power adjustment based on the
number of antennas. However, the base TX power (phy->txpower_cur) is not
being properly initialized or set to a meaningful value. It's starting
at 0, so the final result is just the antenna gain compensation divided
by 2.

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff..9e8961533fd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1251,6 +1251,8 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar)
 {
 	struct mt76_phy *mphy = hw->priv;
+	int tx_power;
+	struct mt76_power_limits limits_array;
 
 	if (sar) {
 		int err = mt76_init_sar_power(hw, sar);
@@ -1260,6 +1262,11 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 	}
 	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
 
+	tx_power = mt76_get_power_bound(mphy, hw->conf.power_level);
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &limits_array, tx_power);
+	mphy->txpower_cur = tx_power;
+
 	return mt76_connac_mcu_set_rate_txpower(mphy);
 }
 
-- 
2.34.1


