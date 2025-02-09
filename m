Return-Path: <linux-wireless+bounces-18658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72905A2DA1E
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 02:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE44F1886900
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D735243379;
	Sun,  9 Feb 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="i3oqIRYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACF8467
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063997; cv=none; b=iC8xX8WATTEBLa2bUS1Ah6DSUpRv43t457odyLXChe5PKdcLymYPGiikCbC2oT4Oa9xdRYTVXHSW+ptWxiDqPS6OqkZP91x0nD4KwS55NzskwgdITn9tdxsiauhg8g7+ujZgRG0cj2yrJSW1YqjZdxAb/9tQu9+OVNLERyjptzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063997; c=relaxed/simple;
	bh=aJVzLIVlswT72PYcwwWsvPPYuG1mhAmn1IlVBp8O61k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cknl0IwuyGTy0Q/mBk++PO2aPpcvCJefzqwGS/p1f7Eo3fBKLCxJ/C1ykq86OgsXz8d4A3Tg9dsM+wGRjXqILdkZFU5/AkgiiMXegfE4SuSQbG4rbKMtK36kKR6+VNKRSHqABe8zBv3aemVSDIvC9bVu2fTtukMe61QK2uLWudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=i3oqIRYG; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so36397845e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Feb 2025 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739063994; x=1739668794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DtBQi3EvMzJm8DJY2Hn0bkfuTjo/bqg1QW1G8D+G/c=;
        b=i3oqIRYGjdCRhsy+885zhfAyNHV/jhV0cZr9hlV0RDOU15C0wJfOvM8Rq8rx3UhfEx
         vic6ZyNv60EWtN0ercnx3nCW/umbXgjQ9Hci+SI0s4XzLXoyuPTyterSNoYTFk1/d1QP
         RrLuvquOfhSfqqa2GeOCMWEuH2CnFJPUrWgXPFrBuugnnFEAlasoo6sPZO8BfQ0dN+qv
         MNpF7izdNscGmO8RBmUfOxwK3GjYO1ltXFCtVIGNA9Yap3dTC1o6N0m2T01t8feDUuBw
         DmcoYDLCpxcseCmSHZPGEwEHDvU+niRvhhcxE4HzeRNt1/ZkHpEUBhBCJzcD3n7qCaGz
         9E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739063994; x=1739668794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DtBQi3EvMzJm8DJY2Hn0bkfuTjo/bqg1QW1G8D+G/c=;
        b=F1aSWu+VNlWWI5V2P2RuT2uBG7wyd1IhoRHdfQ4Z39UlP/AFy/CfZDKNOaLhSHybmb
         lsl+Dj/zQJc0QErDgb9JufeeG/pYXn5o82mdNmvR0eQhjHYYqqOmFSCO26FIDMzfaVfB
         TNhwQhD910V2WBpqo5wsqz6eucj2hrmRZ6FUCplfD6q+6xkLhpiLWHVR21y94WoNAfMv
         064Z+kM93BxhupTPp3O7/Gqdg4LJuyBOIDc+6MA4G5qJf7wrIMpKSzNRpWkNQeFisy04
         8Mz+zTZqQIcUBKUOg2pHHp3umfBztt6WqCQ2pL4dypb5W3KnTebIMQTSnyR9DJMXB2Nx
         8ksQ==
X-Gm-Message-State: AOJu0YxM7IPHZMRK07KCtFrfm3+biVlVBdjFbIhir2yc1qeum73addAc
	0bE0PhCzIkYJ64da85oByy8+gDXTpwDscHG+jhyHKiUoM5BptJF4GwzJ7i6ik0BIrosk52ITlMQ
	Xn6EdnNaGJaCvYVewUzQebvXSVB/19faeDTuFIEck
X-Gm-Gg: ASbGncsfdpy8ycyz9z2RKru9Gzh4ybybVB0p6NIDuLQJqFMNJytKRQRYrsGlG8JjXUJ
	8WRM6YTH2aJjcSvisKBg2jhNl5afarm5nTCpvfTSBiswqevhkmpWCNgBCMCDxRbQVkGuaVg3C8i
	1m2ltG63k2KM6zz7OBwD2cqfjhSEWMkyCxq7AAhONuKpYR60StbmShk9f1qyOzMj7t3Py/FoecQ
	BiEArqJZ2i6LIgJfEsj6KVmApqtT70r8yzr43ksYmu7YtDFgkTQNcmkfg1r8heNyKDpde7V+OzS
	VaUvy3a8G4dqzuZ+xrjFQsvU7rU6WQ==
X-Google-Smtp-Source: AGHT+IEY/DxaLC5DqptHxyKKI2NCtaq1VN7ZPhBpMsACsOMasP84fUMO+tdq31IU5ntQCPnGXuBUQ9R+zoWL
X-Received: by 2002:a05:6000:400f:b0:38c:5bfa:a961 with SMTP id ffacd0b85a97d-38dc8d9840fmr4966400f8f.4.1739063993656;
        Sat, 08 Feb 2025 17:19:53 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38dd6880056sm149536f8f.16.2025.02.08.17.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:19:53 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH 3/4] wifi: mt76: mt7925: fix returned txpower
Date: Sun,  9 Feb 2025 01:18:55 +0000
Message-Id: <20250209011856.6726-4-razvan.grigore@vampirebyte.ro>
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

Similar to the mt7921, seems the code was copy-paste from there. This bug was noticed by me and confirmed by many more people using this chipset with openwrt: https://github.com/openwrt/mt76/issues/783

It seems that for this particular chipset the mt76_phy->txpower_cur is never set, like in the case of other chipsets like mt7603, mt7615, etc. The driver is correctly calculating the TX power adjustment based on the number of antennas. However, the base TX power (phy->txpower_cur) is not being properly initialized or set to a meaningful value. It's starting at 0, so the final result is just the antenna gain compensation divided by 2.

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131..9da7897c0267 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1656,6 +1656,8 @@ int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar)
 {
 	struct mt76_phy *mphy = hw->priv;
+	int tx_power;
+	struct mt76_power_limits limits_array;
 
 	if (sar) {
 		int err = mt76_init_sar_power(hw, sar);
@@ -1665,6 +1667,11 @@ int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
 	}
 	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
 
+	tx_power = mt76_get_power_bound(mphy, hw->conf.power_level);
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &limits_array, tx_power);
+	mphy->txpower_cur = tx_power;
+
 	return mt7925_mcu_set_rate_txpower(mphy);
 }
 
-- 
2.34.1


