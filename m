Return-Path: <linux-wireless+bounces-30670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B8D1074A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B981030559C5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33330BF59;
	Mon, 12 Jan 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJw2fGKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CC30ACF0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187994; cv=none; b=nHlLogAvJzDRmYvmSgu6//d4I/crMEomO98F9RGQFuAk8TPw+NMFaoEVW7sD/2s8VHg/V5yBaSlv0SgabyCm2eo+VT55x92M/yFohdspqUVEVJKWs6CtKg1NF0uF4bxfeEbwbfAKwEHzHvKAvcvxHDCk6+YHOeKt/Rd7kI9HG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187994; c=relaxed/simple;
	bh=RN91yWkWmNRohZ8HHFiKPYzxXK4v+/pvq+4rsJ60dPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lue1l9/lf347CO2+Mvi45cDn8rcC3GIbmL8QV+Si2cggGQh+8O/S6KF8J4VlT68dttxz12Aw/lbtZAgMIi2HL+YlPNTMJnuCJ3maoM5k7JErOMVoADRY/gH52q6ECnhYY6JUppDuA1fT449nTaNowkobTyw9Ed41B48EoNJhDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJw2fGKa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e98a1f55eso1087540b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 19:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768187993; x=1768792793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugu6idDb+e7+lXIGjO+xVcau9gmwlAzHbI8PVEfCb3Y=;
        b=gJw2fGKaW4UcLUnf2bIg+Qh3r/bO+q+eYzMsHD0WsSMUr/TpEbmWmv+0FEeiTS2q3w
         8ZjlMvUe7vQE5Oi5bCkQF+v/sC+BJMiaOUnxIIyfMfbc/A6RsPbMJGMDA0pa/9fywbrY
         o5S2mQvx3Pl5n5OPQ0rppA1/vBq6b+N2HvSdE5w+BN7QKeisfAnQmA5nTF8FuAJlt4Xm
         d1iOV5MSpM9kQOscCn1pn3Tgp5TUwBi80T6Wy5OWGfhmMfJRdN+bULzY2tl2uS2wrGRA
         /0BP3rOzfBvfK+9+LSt9J13kUs9fFgUrAXNUuxA8wHo/ML9VhUJUZSmBtAIXZBrVc9VO
         1Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768187993; x=1768792793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugu6idDb+e7+lXIGjO+xVcau9gmwlAzHbI8PVEfCb3Y=;
        b=rKbcSE2VKOoNJ2pvtb16xrIHCSEHOMwFIc2tfzOfnAORezcKoRJP0jtdV3PBFnLcm/
         yB52YhFFyyPN4CWqfl9mxRJXjOo2lTI2fQol+Pz5n3aXSxQhYuDFW5/fvUiKlbAkNHBc
         LmV9RM/PR0vSMw9szPh66C0/5P1U9WwAWWrMS1lpT46UyKdweN2dfrYqidd0cRd0GHRi
         q17pHABBpps9bTua4VS8nkilPlbSoJSOl1MoBAWpT/1vVmzJeKP93+4wmW+zVPKKpFo6
         R0tkTHobJFN7KGylmG8SnXegk7JQs5hPqIGsHkl6lmJ5x5Wjvo8XMmBFQBXPQMVXBnl3
         urvw==
X-Gm-Message-State: AOJu0YzX4p7u+rHsO/p1eMYI7RsfT5xOarz9ygdUG7FPOsXB1NdAURVL
	/aN7f2YAvWKOdHAW5gTrxrLZ5xxR17Zt3oC8RWryI2pY7c1wTkNETaEkB9C97Q==
X-Gm-Gg: AY/fxX7t51pvHyV9cyr2sZUGOZYJLLxSUtvDWdWzjBwFroqHZffzl3A3yDqDXTRq83z
	IMT9CUGaFhXWF0xZg+TXG93IXKDpNKJqwJPcs+dlu2dKVQBKtUmOTPcJO19832UupOy7YTyJ9hC
	uR7rgEnbG2tStjQB4/VEWzT4pVqn9wijWz75r3ZZfm2c1lz8s4GLFQ2GgOqLQNGBbbB1EQwXxB6
	9jlhGOsCiaCSQjAUEYtKHp88WHNhHWDWmImjVdMAmXdLTwZPNw9XNz9bd6qaSZ5Q8BCzj+3kdw3
	1hcNGD+GWUV2ihrQNz7hSMp9qzMESw4sIBRtGmIeYA10ACt1A5jpIdT0zV9RhB1I0e8WS3v9Q7f
	kmS2cafVFJTCR1OwUuHIRr+nKGPf172TZqJlSmoiT+JiIhGm1iVgR4k/I/T/wXTt5VnE2
X-Google-Smtp-Source: AGHT+IGcZK6mPWA6oDBHPkfLpnwCSTkzQjn9CeOs3lAH6csFM6RCBJa44RzzIl8oz1SRi6hHSNZ66A==
X-Received: by 2002:a05:6a00:2c89:b0:81e:2b7a:bbd8 with SMTP id d2e1a72fcca58-81e2b7abd37mr7896442b3a.6.1768187992741;
        Sun, 11 Jan 2026 19:19:52 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dd5a992f1sm8099649b3a.11.2026.01.11.19.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:19:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next 1/2] wifi: ath5k: ahb: use devm for ioremap
Date: Sun, 11 Jan 2026 19:19:33 -0800
Message-ID: <20260112031934.44839-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112031934.44839-1-rosenp@gmail.com>
References: <20260112031934.44839-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the code by quite a bit in probe.

Also allows removing a goto and returning directly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath5k/ahb.c | 33 ++++++----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index cb3e891ee1bd..f34313568d9c 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -87,7 +87,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	struct ar231x_board_config *bcfg = dev_get_platdata(&pdev->dev);
 	struct ath5k_hw *ah;
 	struct ieee80211_hw *hw;
-	struct resource *res;
 	void __iomem *mem;
 	int irq;
 	int ret = 0;
@@ -95,35 +94,21 @@ static int ath_ahb_probe(struct platform_device *pdev)

 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-		ret = -EINVAL;
-		goto err_out;
+		return -EINVAL;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource found\n");
-		ret = -ENXIO;
-		goto err_out;
-	}
-
-	mem = ioremap(res->start, resource_size(res));
-	if (mem == NULL) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_out;
-	}
+	mem = devm_platform_ioremap_resources(pdev, 0);
+	if (IS_ERR(mem))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mem), "ioremap failed\n");

 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_iounmap;
-	}
+	if (irq < 0)
+		return irq;

 	hw = ieee80211_alloc_hw(sizeof(struct ath5k_hw), &ath5k_hw_ops);
 	if (hw == NULL) {
 		dev_err(&pdev->dev, "no memory for ieee80211_hw\n");
-		ret = -ENOMEM;
-		goto err_iounmap;
+		return -ENOMEM;
 	}

 	ah = hw->priv;
@@ -179,9 +164,6 @@ static int ath_ahb_probe(struct platform_device *pdev)

  err_free_hw:
 	ieee80211_free_hw(hw);
- err_iounmap:
-        iounmap(mem);
- err_out:
 	return ret;
 }

@@ -213,7 +195,6 @@ static void ath_ahb_remove(struct platform_device *pdev)
 	}

 	ath5k_deinit_ah(ah);
-	iounmap(ah->iobase);
 	ieee80211_free_hw(hw);
 }

--
2.52.0


