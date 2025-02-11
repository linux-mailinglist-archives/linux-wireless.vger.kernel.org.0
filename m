Return-Path: <linux-wireless+bounces-18749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905AA3056D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5583161385
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C721EEA3D;
	Tue, 11 Feb 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="TdTKu416"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A01EEA2B
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261657; cv=none; b=ZyqC3+/gDlVobx4saF5zCwfR6NkNy6Y4mUpPts5J8vV7nCvPRCauXeWgHYaxfFoRDnfYldKMv6NFmHQSgJF+EXNrURv+ohXi64wo74gjTjicJ5PySGN4kQt40ewg86qrRzyolwHIpQyhsKfLA29jugGRXg8Psp9w5680cNMV2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261657; c=relaxed/simple;
	bh=qNI8OLXVeDqt1gyYx5pfuOMsjmr22eZFqfci05wJLw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJ6V+7JTPNA8egapAdbGkgL8LZNHFQicA7avnAMo/UFRZ+ACm34tAdS38p4oUWK8JtgYlSfda7OFp05m7cInfRkeybhRFFQQE4bGSkGqJxyQ2wvw4CUzIl15Ium5kMyuLnXoc1S0iA/sV1huGihb/P6Pg6tfU20gz44homEGyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=TdTKu416; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so6242006a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261654; x=1739866454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4+/vDyLCe7EoIgVDWjJFYHuahtKhnzcPZ7kYVb/9us=;
        b=TdTKu416PB8JEoujw94ocnxFpxo+S3CNT6ny3lgn/YaoON0KaZiL0DFV3AwWSw7AvO
         GkmKaRSl3cRP0K8hRLEqst3QrWnKnRFYlWpSEMv6G9+J9NdGvULXukPjtS+9u+W5qpVl
         nyyqWrC+NrYASirOkUONK2/yqkuynQ4DuZEqxvFGgldbb8HtGE3Hh49rQ0VKo+xpF4q0
         fZj0hotev5K4YmS3+C1yeAHFCuCFTrPZT5UUr5vvksZ696fWAWzlSJWU0QEzwbfZlO5J
         5gaafqZiqpgJozDaJUQx9VFnBA4Q7zgkELa39ya45BZ3YgelVsgnOirqfuAU32F6935r
         ZzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261654; x=1739866454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4+/vDyLCe7EoIgVDWjJFYHuahtKhnzcPZ7kYVb/9us=;
        b=lHgOQ8ydm0AmN3OnQilV4JBvcPLNMKTw71pzfUb2QD9sMDdRKJmuNUxrGj1qCZwhcV
         nil+o98qBx3j2rN2uzvzEtvg22xA6aMR4QZROHohnvcZBVRrSWXoRcUBs9mIw8JBwAXJ
         +yMElpf/32/f5BQ0c3QqS2Q79a4XWKMdb9u56PY/LSAZ7jgmh/tZhmKxMoigpZZraPOp
         dw3EgFLE7VMM676gKJtwvIWe3tfece1Sk1ObeAuB8pkuDis9oqbRhwLi2Q5kuL6z6jSl
         xhRYxf38aiDjGHx+ACbYB9b04HvGQUD8EjI2qIyel7u31AidWirsy0G02L0CbNzwbwSM
         EOaQ==
X-Gm-Message-State: AOJu0YxaJ0+qYSb0k+GZHtr9R8BKvJ/r+T4YkFbmxw+FlKds/oBASOEt
	YRt+cp6z9uNDahyJ3tIiF3qWxB2jumv28pWxNw1Pmjdd8cK3NQRsJiUgWP9QanG4qj0IMbVMpZz
	e98K7sozuWL1+ZVsjT+4ymixhnqOQVa3l7YhoiP4d
X-Gm-Gg: ASbGncuSvfSHyBo/qeRegCl1v+tXYhKB/4GUOl8ohEDQb6jwk/MaXi2OkQDmtGW+PKW
	mN7TqFIiSt0uAViUUIl4YozCjKfWTnLbshUCzDJXVXhZyZOB0ERlrLL6rkfRXQDKt7LQfUj0Aur
	p15G81eo7yGjqvyDyiJKmaRJSCETv/RKjuGSvI62Z+CITFOWmmbrsRBC7i38qWCMB3juYDo8DwN
	de7UJehHmLAc4friZwJVCnmvB++UurdLUe5OERx2LJJxYYdBFymC0b8Ns4PmUc0bu98lmW2YXK0
	Ms+DWEaw+Mz4kD4SIDCKVdj0BafesA==
X-Google-Smtp-Source: AGHT+IHGunfPId/rPn3vaGQJl34+jvybTYLPHDoqQdFIPiSQxqsRgWP0f9/dqnur6uXVzxihzV6zHoJ7MnVC
X-Received: by 2002:a05:6402:3589:b0:5de:5d4a:9f56 with SMTP id 4fb4d7f45d1cf-5de5d4aa093mr12317793a12.31.1739261653956;
        Tue, 11 Feb 2025 00:14:13 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:14:13 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 3/5] wifi: mt76: mt7925: fix returned txpower
Date: Tue, 11 Feb 2025 08:12:45 +0000
Message-Id: <20250211081247.5892-4-razvan.grigore@vampirebyte.ro>
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

Similar to the mt7921, seems the code was copy-paste from there. This
bug was noticed by me and confirmed by many more people using this
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


