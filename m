Return-Path: <linux-wireless+bounces-2916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F0844B19
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B3CB26C63
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B139FEB;
	Wed, 31 Jan 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjBzFK95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8E39AF6
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740648; cv=none; b=KvI2WllQPY6pUPZUCuqMHBPnfDgfQdct2n6vStkrOK0iXB7yLTB16/4PfkZQPMU/b1/6/n06qC2ukm5wr98iSfwg5jG/hFM5yZ/hcA14t+ks/+A4MRJz3hDKTgXj2y3TzLgw2J1EetN5qna9tEO77VZYjdlV2gJvfVLd064t2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740648; c=relaxed/simple;
	bh=GHCslkMbeb8cqNbZMhNeG8BDz/DVNH+7BbzW3dVkGy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GZKOiqSZNy8m3xw2TWJL77NqO7P5VLV1U5xj+BnzZgw9malp4NqHzjsJtUOZYxaB23iRenIjviRzE8srTEd00KHVpunh7g2T3+pGWqAnEH042C2FAHDvbNhYKtzqsWrCHaDY5yzrrAy6tUuzFJAwWyZap3H4boEf2KMyMtZgPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjBzFK95; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5112cb6d1e7so281406e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740645; x=1707345445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjqkz5/4fOYK8UlYJhkvBOZbQ3T8J2UbD1rT1LvGIH8=;
        b=AjBzFK95eec1gfYn08jWdljI+JYfhAJpoIkTiIMPnB3UwhvjSNUHTHEZoSbBK4VbU4
         hUz47OrysaFBDxFwE+Ep9aLd53gALGmNDMqeHXyoVxnRMDoRdL3lOiav10k1wJBehvXU
         8jcUvQdESVRBn5nECP074IazmyNJNFUNxxoUp3g1XGPQOnmQyIE3SPrqMbbQuA0dPll3
         g+aGbtPjaHivChS7PXPImqy6NhF00JB2ZVBhIniGwDIk4WeHvmc3LytGzzi1igwDNrga
         dtTlM54RRr4+zo6YH1LFpWZT13TW93bB1Uo+vbLT6JNPny0PreTBuKRKXvBZ0Xv8ioaA
         oEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740645; x=1707345445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjqkz5/4fOYK8UlYJhkvBOZbQ3T8J2UbD1rT1LvGIH8=;
        b=AUvNnko6ea3BVOSnj10bFvDsEA91/b8GEiHNUOkpIVjhcY+t9H14jteC8s5UX9LV68
         BrYvmLa+J6Ikv/J1d4JXdMXc7fgBvH6ABro7TLB5dsVY8k6+JBmTTW6O7+vMANShSkJB
         IYqQ6ODI8uKuty8a5vBU8eVzDBalEgGq5/foEINK2Fz+iRV1/ZmUHOSBtmjjvlE21k8D
         heLcZUCd9h/tQUVwiU6ZFPUnRFcbHORukBBmByRg8/aVp74Zr3Z+Z8mL3Uk59O6eGhXR
         h54FzK5tiC5PwzTXUDbWuIVC+1NXRqF7L0/UOrhnssSwyIIhld+5VjZ1HuJYos9yFl8a
         XgKQ==
X-Gm-Message-State: AOJu0YwStRaePQTZaonr+FA4tAmSfT5lGClOJvuVJaLwrEyUnC64zZx7
	55q8+sVVKxI8AWC8aFLQwZMY6Fjm6dP/5/dWn2vojACeswnvJEkkOY8E+bYpbq4=
X-Google-Smtp-Source: AGHT+IEMIuI5hvAZEuoBTltAZ0X1MJbZczlIpQv+KBqzvjJT96h4zzxFmvPW1XHVD1WAjd36PDy46w==
X-Received: by 2002:a05:6512:3b81:b0:50e:7b9c:3ed5 with SMTP id g1-20020a0565123b8100b0050e7b9c3ed5mr724096lfv.50.1706740644933;
        Wed, 31 Jan 2024 14:37:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzuwlnfDtJNqGCVUREN76vukNns1U1VXlZ0fzehBTrVJu+DHgyhn0h23Etnk6UySO0+66Kv9XbvRT9WC8hrH2TfQWzOfwogz6GZwb/g3264TBFzxCCW8QN6xU/QP7caG2fe8dRqCVpX6kYqj3DpDiFf3krg+fugNquXA/LEcFTSzzrhWl0YQZuOfHfdZTag6Ewh86qRqaV1hDFiYZ5rrhL4x1VMO68vCjCnrvpBg3RMSHsrVQPp/MKqGlRpqAJKQvk5tFgBMG8wOrkdl2Jt6ObkO5lgZSCRHH76QD7GoNbil1cA/71/hFP3gD0nluZWKBmGJbTcqFiutP1grQQOPvrcYdEEL4YSPZcVoquzI8b6AczcWYJOnrg9Q0zxgt2hdqQGP7u1+v0TCIs4flHvjdGFkcrQOc1AoHrGtEPj/FL60hhVpGx3j4jFAOa0qSor6joQO3mMrXzYGN7jA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
Date: Wed, 31 Jan 2024 23:37:19 +0100
Message-Id: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/LumUC/x3M3QpAQBBA4VfRXNti2cKryMX+DKa0NCPU5t1tL
 r+LcxIIMqHAUCRgvEhojxl1WYBfbVxQUcgGXem2qrVWAcUzHefOom5i3FBEuS7Y3gRvXWMgpwf
 jTM+/Haf3/QD/zjAJZgAAAA==
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This converts some Wireless network drivers to use GPIO descriptors,
and some just have unused header inclusions.

The Intersil PL54 driver is intentionally untouched because Arnd
is cleaning it up fully.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (6):
      wifi: ath9k: Obtain system GPIOS from descriptors
      wifi: ti: wlcore: sdio: Drop unused include
      brcm80211: brcmsmac: Drop legacy header
      wifi: mwifiex: Drop unused headers
      wifi: plfxlc: Drop unused include
      wifi: cw1200: Convert to GPIO descriptors

 drivers/net/wireless/ath/ath9k/hw.c                | 29 ++++-----
 drivers/net/wireless/ath/ath9k/hw.h                |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |  1 -
 drivers/net/wireless/marvell/mwifiex/main.h        |  2 -
 drivers/net/wireless/purelifi/plfxlc/mac.c         |  1 -
 drivers/net/wireless/st/cw1200/cw1200_sdio.c       | 42 +++++++------
 drivers/net/wireless/st/cw1200/cw1200_spi.c        | 71 ++++++++++++----------
 drivers/net/wireless/ti/wlcore/sdio.c              |  1 -
 include/linux/platform_data/net-cw1200.h           |  4 --
 9 files changed, 82 insertions(+), 72 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-descriptors-wireless-b8da95dcab35

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


