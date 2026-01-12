Return-Path: <linux-wireless+bounces-30703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C96D13D62
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C00D3036CAD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF8322B7F;
	Mon, 12 Jan 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DxDppMfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF9266581
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232836; cv=none; b=A8bJbha79LsDk+CdB4gt1pbeGrMkFqNr8pdL3nfw9mXK2dG2O5XpMuLNjAT3/brcjbZaQ1aVzHjB+TzZRRRfkPJ9OGPKytk38xcWwk80C066waFLiOGIH76vd487uYRsZ51HN22rJQWJLHVd+auo5KhwpaA4UZ4LxBADhF8Ucgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232836; c=relaxed/simple;
	bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq+L8NAg8C3kmOkF13vGAmVY7s3Qrc8q3XdC7ihqB1/u++Lv9ghzr2fWc3zIMbK2z8JIK616G34OQAFen+Xof9w0Ie9GFOqst4IiouG7pij3bbhEjVbPpuWukUmJhEMZH1tNiFc5JW2sJ+IB68rVnZu6vVYzTNHq/s3WfvUeo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DxDppMfm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso70715005e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232832; x=1768837632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=DxDppMfmu7v1ZUTXUkl1nzzWHhbVGp6EMe/36fZFsPk3SMDIrr3ytHmej65yHmEKQG
         0tP2BxbOfQMhQLVJFTvV0Xxc/hZkc8tZ0/Z2KmP63h13LYFJHYgj3khcqJmjoE+uxgSp
         Gh5iNG0331tk086F1GUPzfpZ8hI33qD0sfPNxw1EPBNhiRb746OFQvai61v3L+BNH90Z
         hVh5Z8Nbettdp1A4YqiZj0zZrASoiTdn5yOxSOQOgTW+MXdLdBShxYPonXspKyzAC+5d
         xQzfNyb8TLuIiQF18WYcRoW2e3QOzi+lVdcho0VBWFioNzXntsYLnp2QN5+tA2FiZ5z8
         nmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232832; x=1768837632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=XAmjuzDJGGAe1oTK9BsQ82JwMaaozr3w7Z4T8UUIUV7ffBJg09A/Mf4hJiR2VCjvtC
         SLRbBedeOav4PPTOdbkNz/1PCc4VHTxjj7YGlyEO4skhx5/8E3rT96TDlSvS6vo9hLbM
         6wrvBD/qYF2lCrwTpPaPTMmEhHQTEnwe7u2JUfANQaGlPjrkOlS4cx9337MYqAKT3jmM
         +f3FOYrihvvkr98JJDm2FtmmTa07a+BxnRNfEfF49ea+fkKZ+VXHktvieV47pP4mwPch
         a5Fvfn0cwdQew8mDKgLPwaqrnNatZRgeUzB7xDwnDxRmj4Q86ToHc26FCOEYjvskFDdf
         x9Ag==
X-Gm-Message-State: AOJu0YyhMTQDBYvhpAKuT3ZByLWq06e7Ov7pfSZ2IzcZk2BbaiquG2fQ
	yCwPpPfTUqIAhKq5T+aRwunwGdX4hJebFG1o0b2VwErzVg74XeoxK1wVZQcNlgqWkbc=
X-Gm-Gg: AY/fxX4C5NP39g2UFK7AE5zN92L4VhcY1kjPMIA6SZOKywazk3FWah/mUwgMJwhl4hI
	R4ykQMu1TEoehjA8Of8m+07HNH1lS80dyrs96ltJi+XrKvThEfs7Yv881BAW/cfrMUrWiMt81mS
	LMbalfOOEbqIPDfuhE9SJsYxw+yIfy6hcwyMhsU0N/B9qdtLFA+ZphmtSjE1KwB77C6PHLCs9bP
	ofuzgNXuOBSVhVSW5iFw9SBeMETrTImhhBG7AXOqehQDH3OlRrvpDfNWXeuiIX2ztNCdlza27bV
	RxTZJGmr4hZHuwxxGyZmTbDDgXaDlqPB9r0NFqp5havzak1Dp5765B47dZIId34jfqdHGbgDlJa
	Wwalp1z12XnxUR6sXhxmXMWvABuyoG/Q1gtx4s/URDpaI/aybcr64NtaYO0PxGfkocuA1hCSkC+
	/ITkD7NYZZDHkj+szlN+YCVHMNeMiiZCDx8TRqoo2V3fHbj7S1KfL8UQmMZLblXBzUtql2ADWf
X-Google-Smtp-Source: AGHT+IFGY3WIybFukjEnPQTkxRYatH3BAcQKn6aQe/w3mmQye7zIiF4J3pVH+tGK00tq4SSxhSzDGg==
X-Received: by 2002:a05:600c:840f:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d84b1895fmr223043065e9.13.1768232832566;
        Mon, 12 Jan 2026 07:47:12 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d7f410c6csm373106935e9.1.2026.01.12.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
Date: Mon, 12 Jan 2026 16:46:57 +0100
Message-ID:  <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=; b=owGbwMvMwMXY3/A7olbonx/jabUkhsxU8ZLt5TUqVs7H5utvntW9QOHFe69wBvVzGcukDKyco 3NnWst2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARg7Xsfzjt5Vb8SPhxk2vX 4eXvnp5dxJn1q+v88UNRPq5FDnWddr3nfy56pszEqKq53GNf8Iq3f2Y/s2rb7TC/OkS6qSfHLEi nzDfw/2utC/4XuAuXn1z0VcfDRMJaZuc9tz/fZlnYuafyxchf7mp+UmDf58YvszG0+/ulJcskfe tFO5fFdu7YJiCwl+kNx8wz5hFLnnQYHVjIZCM8fVvWCv/JKSst/6Vnbvp8UoXRagbz8Z67L1Jup 5umb+Sbelj7xbmYg97cG1lKalLXXJQS6+JsMvf/aOTDZRW9SiHCK7zqld8/E4u0Io95b4MKXALS uG5qnbolqLFOaNojpspcl1qhJct4I/7M2XZLdarrqsRCAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

To prepare sdio drivers to migrate away from struct device_driver::shutdown
(and then eventually remove that callback) create a serdev driver shutdown
callback and migration code to keep the existing behaviour. Note this
introduces a warning for each driver that isn't converted yet to that
callback at register time.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 10799772494a..6e5bdc2f0cc8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
 		pm_runtime_put_sync(dev);
 }
 
+static void sdio_bus_shutdown(struct device *dev)
+{
+	struct sdio_driver *drv = to_sdio_driver(dev->driver);
+	struct sdio_func *func = dev_to_sdio_func(dev);
+
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(func);
+}
+
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
 	SET_RUNTIME_PM_OPS(
@@ -248,6 +257,7 @@ static const struct bus_type sdio_bus_type = {
 	.uevent		= sdio_bus_uevent,
 	.probe		= sdio_bus_probe,
 	.remove		= sdio_bus_remove,
+	.shutdown	= sdio_bus_shutdown,
 	.pm		= &sdio_bus_pm_ops,
 };
 
@@ -261,6 +271,14 @@ void sdio_unregister_bus(void)
 	bus_unregister(&sdio_bus_type);
 }
 
+static void sdio_legacy_shutdown(struct sdio_func *func)
+{
+	struct device *dev = &func->dev;
+	struct device_driver *driver = dev->driver;
+
+	driver->shutdown(dev);
+}
+
 /**
  *	__sdio_register_driver - register a function driver
  *	@drv: SDIO function driver
@@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv, struct module *owner)
 	drv->drv.bus = &sdio_bus_type;
 	drv->drv.owner = owner;
 
+	/*
+	 * This driver needs updating. Note that driver_register() warns about
+	 * this, so we're not adding another warning here.
+	 */
+	if (!drv->shutdown && drv->drv.shutdown)
+		drv->shutdown = sdio_legacy_shutdown;
+
 	return driver_register(&drv->drv);
 }
 EXPORT_SYMBOL_GPL(__sdio_register_driver);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index fed1f5f4a8d3..4534bf462aac 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -78,6 +78,7 @@ struct sdio_driver {
 
 	int (*probe)(struct sdio_func *, const struct sdio_device_id *);
 	void (*remove)(struct sdio_func *);
+	void (*shutdown)(struct sdio_func *);
 
 	struct device_driver drv;
 };
-- 
2.47.3


