Return-Path: <linux-wireless+bounces-23840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925EAD1750
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4948A3AA1FB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48E248193;
	Mon,  9 Jun 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq0tVucS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7525246771;
	Mon,  9 Jun 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438550; cv=none; b=noRMwxsDqCl7kOc0VsPpGuXsC3SDCal3KEZFTgqDfM2xnyP5oKR45tGn4nGh83U5mGDWHvdyTuQAmpsAm6jb0utyUzhm/j7w2Jz2brhBHVNYY6kRz4j5Fwz/LIY2oqBsmk3ya+jFUDVJfVd4cfHxg8WgEMsvdZzB6fFgq+evy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438550; c=relaxed/simple;
	bh=FQpBJ6ylyv5OBC6bDhYSClT6QoIzNk32h9Chka8u0NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ9VeSqoQi+11ZBQ4bACw8wa0k3Wq9sincuQcIHu9kfaqJqAVp87VpXY50ORIHSQQ/j3FLDXLvQnCignAayXhWnrsBh5wsYcNmkx0AEWMLVzHz6fqJ/cHDndY9OoJ+vaszwk0siJ0NjAoT7QZrEVnCmblxfzyhlYCoMT3HeDbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq0tVucS; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so325446939f.2;
        Sun, 08 Jun 2025 20:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438548; x=1750043348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r672ECiRe9oiRfMRln147aOj4DFHIta8gOUnsDT+yFo=;
        b=nq0tVucSgbvmcJLMHLSS+FFSkshvE3Kby1y6QN1BrEgx4iJ/20geCCdLSSW2Rt7M5a
         nmq9NHE+U/Y0m+FuVmTRFPu8v6mKakaMMrDc9nUG1YuUK35jJtqjbjbdbdYxZ2y8KZXD
         eYYzJOTyLY75NV9ROtyNY3cdXS5STWopvzGpNWEdK/9LMCq3FR58zTgJ6HMz2W2Da3/2
         SUu+Zgpw16TBPWaUWfZzRwG6q4gPOmPGMLZnr5FGD0w7+kl6j5d5EpmbMDFSaQ1wneE4
         roCvvTCR9d7N7uFrJ0ABf/+rrq24DA0eiKTuU6EkhNnCQcy0aFLMrWLQoDy6aZUPJjXx
         C9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438548; x=1750043348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r672ECiRe9oiRfMRln147aOj4DFHIta8gOUnsDT+yFo=;
        b=vMRip0uOD2xBXJJiPbs+f8M+nzwQ+uZb507pqjJlctvrqi6SODzodpdmFc+ineHLhB
         2gQWRg8fkk/8AuthMmnvv9sptpGRStS+bnDcv1QM0PVbqcMPYJKqXjPbZ4F9MQqDqHpr
         jiPLuJx0g+O5z3zETK6wBhlQUylyI1bMb6/3F7iJtU3txF0XbqjpA8n+l4YrjnGJYH3g
         eMzGIxLbIbcxZyPB8rneh/0HB84Ct9Cv5G0drNpROG04ZR7DVABcCOBebQUhs4jbaex+
         CdQ0pCtl+sm5JuNzOkvFxrRDhICMqiZogH+jQ3rl1ysZ4TcoXdYOw031khaS5/iSYeYW
         jNGw==
X-Forwarded-Encrypted: i=1; AJvYcCUyzPkDdxD1H+F/kFM1I0bcE1v0Rh3z0tX352XXi4z9weNl2LYOM4Ck9uXOyqUo5bluB3NzIE2SkhYLBg==@vger.kernel.org, AJvYcCVuGS1oKIBQsVMWxLiB4rJeIkOSdfjrvWLrKbEJWve1JOKG5Hhs+rmruZOfE2m2A9f7LStKRWoOi+6n@vger.kernel.org, AJvYcCWHVX+KmFLOsG9ftwv4TfUNd3pdcoT1pZmXWk8YEG0Cw+77Qvc1JyiHgLTBL+nFjXHCeNs2DFXPBEdLCXxo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1+xEiw2NMrweI4SFpBtrz25uNpPFvAn/Zxz89w27e59zngtD
	S/ciK4D9m8o2Ytd9gq0BIuy7IoJG1YmsCa+5yBXQWtaCTquLSvoXp7AwpbB62w==
X-Gm-Gg: ASbGncufwjDl1EFLZWdxc8OTWeVfpj9YwWJ/oLQxOLTif/N0t8OdQTL8AKYFdBtm054
	qj8F1pTbSoSqfAqHmSjCjX2nvsBnPY0YDcTEmOxw99xPel+siMaQrv6P/tBHy/SaUKj4ulYjgca
	GZ/9ctJBHcv+kgZ2qjJ9crKQUfl17vwQR8Iuvh12rPqCbrmL9P612PeI4iKV1Z2eUb++egVIUsB
	r3OpTngmKafckhCAtJjZgtGM8q0D7vJFXC4g+XW3rShMPW5rSkdf2MI5DD42Dx1j07brLLL2UbM
	SjtdWjnwX8kC2fcoFsr5zbZc+QUlbSI533PMJA==
X-Google-Smtp-Source: AGHT+IGppOpwIwJJ6iDgNpOoZaqHwwshNfv9R9mKSyT/m5dpK1/AmrJ2oleb8/shEfNMGZkJWj7URw==
X-Received: by 2002:a17:902:dac7:b0:234:b422:7120 with SMTP id d9443c01a7336-23601cf6b7emr167277145ad.9.1749438536018;
        Sun, 08 Jun 2025 20:08:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:08:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 1/5] wifi: ath9k: ahb: reorder declarations
Date: Sun,  8 Jun 2025 20:08:47 -0700
Message-ID: <20250609030851.17739-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Easier to look at. Follows netdev style.

Also remove ret assignment. Because of all of these devm conversions,
ret = 0 is a path that never gets hit. The first time it does it when
request_irq fails, but that ends up reassigning it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 49b7ab26c477..d2a97e74f451 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -71,14 +71,14 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	void __iomem *mem;
-	struct ath_softc *sc;
-	struct ieee80211_hw *hw;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	int irq;
-	int ret = 0;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 	struct ath_hw *ah;
+	void __iomem *mem;
 	char hw_name[64];
+	int irq;
+	int ret;
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-- 
2.49.0


