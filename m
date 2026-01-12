Return-Path: <linux-wireless+bounces-30702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A5D13C89
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C4C230386F9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024630498E;
	Mon, 12 Jan 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0myqGsO2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870562F5A10
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232835; cv=none; b=LNSogGrjjP1MXPqxf2w5X7WS/slkezdjnYAM/aFqcKlSMqojI55uyJqIjJYQLR4Kl0EvRcPmFx9aHcRxvFff/XWGWKvXcmX4jiSg0EDBAXPme/uJfc6drtZTGlxfv1lcWElWojjzhrKv3TJavMtMTMII9W4tPGfgXCKbqppvj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232835; c=relaxed/simple;
	bh=vHWFPBypaVR6QO9yY+NIT52Fwn/AnAUPV0IFF36KmuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGkzxjedJLwpDeJ5mm92MD3huAtAEq6cr+mcoDq4D6OEwh8X1okAnALJmPi37yKSX0RBVY8k8/D7EjqwETAxEznkUIPWlF4+x/gFWW6i4w5uXMwp/xp8a8D/exmPMj87K57IlOXL+19pOnUZoBKSGD2Y3wEle5BF6niJhMgjc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0myqGsO2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775895d69cso32586505e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232831; x=1768837631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QU+wdPQeGIMx2R82MPiKqXDiY8zUt2eXhqlQOcy8HXY=;
        b=0myqGsO2xvaRKfH8bkgIAHGNfjElsxUKLmD+oEQlq0SmO4RtzHus4Vs4d0PL2BtMhL
         dnGnJUW73JCXZBYKkVQjEf2/PNZmtS/dg3dv6UhiJIhaBgc16QQ7lHpqUmYahVzDGWWM
         qW0L+S8RS3qF+NaGLRqdPe57c6WCz8VE6kgvK8eEJMIJP9b11x9ZLBwwIXZ8SPQkrfo3
         FE5la+wW6HHqnFk7VvTUAonELcwi+qNQMOEVkHecLGmlON/gg9sRKyONt2nJ2wFaQ5aR
         wPruFAjv9ksozvnz/JaEXMyyTZoU1q/FWIFR+/g/Wd471DqPwvXMKK25UXF0YTINBc1E
         hVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232831; x=1768837631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU+wdPQeGIMx2R82MPiKqXDiY8zUt2eXhqlQOcy8HXY=;
        b=XGA93s7S7ugm+D6o22amwkSWVna7gStc6sW9j6Naww8j9eBTmOKfa170O51B/oVk5Z
         dF7q+aBk+CDM1qmX9JzWwKFX8N17X0CeSHYNnHMlVu7LAG3wlhWMyn2zd8bOBBRC8AVk
         K+XgBds6nIAFt2MiJG2/UEb7AFHZDZ3+UkL0KBOnGKEqNJY0N2oPE6/i5Q4uTaZm+tI2
         oeIFa1oDo9Px/8QbKy+/jzJH8KKr49eeCQS4X4gD3/sycHZ1DIT3Sh1uyQLyehqnVeyi
         PzBb/Si/DTZ+L6T0OXxfsaS2CwjZTBfIMc2NhEO8YkGBMd5gs/L6PEtkt/xqdKWWWkXu
         DnNw==
X-Gm-Message-State: AOJu0YwQakIdi1sOse2J6FwTUzPs4ZT603GWW256UNYD6Ol38xfu5RyD
	RPJjRgf+G5r1r8FwXqtKchmlOsoTPwzE0fcMmIfEsqpg6JGHTwi338WWrkti8XG9ueo=
X-Gm-Gg: AY/fxX6AH1M2GS9ia7/hzB2PnU9bIh7Y6rkfZI7xKzpXCVtutX0UI/DFroZpVxMKCEv
	sRH+nBuZ7DiAFnW2WSenkiPAxhbB8TvpK16KeV3gfq8xI3UDJIRaHDBH5hZIcRVr4KOTeTRwpbm
	JgpVesUu4n8Azt/Q6fMD0T/D4zBsPjX1FFrE0FqWb+Sj9HRQQPIjEVZJ4PwAbGKJBDpTtPLoF8z
	JjXFUs2aI4FDp13mSh8L/VubvSh45dp2kYMUTlpVjC/dyFlUVmyYLbEaBK7HZ7JnsBKRShXh2EL
	4NV3/4T1PWdVPBFvd4lWXpV+ZHhXB1v6fOrdCS8ECei2kUOKMhW5QPKrZhNFCdqX57Xe7pCZlLO
	bIxsQhRs0MRzpgElgx1ldxVIl6TN/uFPkx8rsynQtbSRpRh3idEgrE6EoeZHaD+34iOFwK6FkHh
	fTe7K6fvrUQ3hXeXKqXVfj29ApjMD6cWdIu+1qJQ/QxuTjTGOLCj1Xn4M9nT6lnRONdJOKz44/
X-Google-Smtp-Source: AGHT+IGBO9eGPmHs6J445wbi3UmFE0FvHJHaxJck1zKJZ9qqr1A5nU0vnmnEQ4zzMoAofUQG+ru4TA==
X-Received: by 2002:a05:600d:41c9:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d84b21250mr200825905e9.15.1768232830771;
        Mon, 12 Jan 2026 07:47:10 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d8662ffaasm132658945e9.6.2026.01.12.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/3] sdio: Use bus type function for shutdown
Date: Mon, 12 Jan 2026 16:46:56 +0100
Message-ID: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vHWFPBypaVR6QO9yY+NIT52Fwn/AnAUPV0IFF36KmuA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZRdxpa+mgz/013rdQO8j6edwGc1OkH+Mw4/kK zqyYkMywumJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWUXcQAKCRCPgPtYfRL+ Tu0eCACAG4l5+26CC1ze23VOiVgBa3fPHJORep2Jda+t4jPg95bAUe4p9gS+vNvJVOfcG2aVPRr FyAV1rHhW2KsTYe5Cq1+o59QCfHLUEqtzninrJGVddD11Q1fxxjRNk02t4EnsM+VF1Yr2J0ESEt 7biNL5m18vKnXOhIgwT3hAjF3b1w/fXvju9KtmxTGHqfaY87xs2sP5OgshyIP4embaIhmlw7WSx Gji5CSpppjxDMFRNYBHBFci2pPQ9wfSpclApLYJ2tvTs1GJrL3GgCNdAivvwcBQ9zu6dC9t+Yds Sn8PQsTAH9oyptg2Humj9sI/TmYe624pn4VsZoZ0S66Qr1IS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series is part of an effort to get rid of the .shutdown() callback
(and .probe() and .remove()) in struct device_driver. Preparing that,
all sdio drivers that up to now use this callback are converted to a new
sdio specific shutdown callback.

v1 is available at https://lore.kernel.org/all/cover.1765968841.git.ukleinek@kernel.org.

Changes since v1:
 - Drop patch 2/4 which resulted in a build failure with CONFIG_PM=n

Patches #2 and #3 depend on the first patch, and with just the first
patch applied there is a runtime warning (emitted by the driver core in
driver_register()) for each unconverted driver. So it would be nice to
get the whole series in during a single merge window to not let users
face the warning.

Given that all drivers are in drivers/net/wireless I suggest to apply
the whole series via the wireless tree.

Best regards
Uwe

Uwe Kleine-König (3):
  sdio: Provide a bustype shutdown function
  wifi: rsi: sdio: Migrate to use sdio specific shutdown function
  wifi: rtw88: sdio: Migrate to use sdio specific shutdown function

 drivers/mmc/core/sdio_bus.c                   | 25 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8723ds.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8821cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822bs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822cs.c    |  2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |  3 +--
 drivers/net/wireless/realtek/rtw88/sdio.h     |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c       |  5 ++--
 include/linux/mmc/sdio_func.h                 |  1 +
 10 files changed, 35 insertions(+), 11 deletions(-)

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

