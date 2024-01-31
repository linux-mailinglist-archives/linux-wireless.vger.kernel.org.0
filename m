Return-Path: <linux-wireless+bounces-2918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3273B844B1C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88551F2914D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1A3A8E4;
	Wed, 31 Jan 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi0hhmFC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C839FE0
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740651; cv=none; b=bUW/orM84qnkVtCR47MSJ1yuD1VKiROe9oaN0HwBcKKrwQEfXxHYhnWZJUtRKx36PD7pUwjFbeB/1VjdC7iJPRw3aCyglxB0AXFzoYUiOXB6lvYjR77gAAtPS0HMuy2T+QQxXy6cN/JQY8z6lbmjXffBuN+hrc9yvEuRtQ/x6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740651; c=relaxed/simple;
	bh=ionRqyl3Q5D/E0zHp+ahunwML94VNC0kY+YxXQFZSkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUoBppslRNu9vn87V4TbGjD70egKn1MVImcc6G7dbAMt8jODsm75yQtSE0j+21PdTUs2wzjMCMLe7txmjiey0K/c+5MzOmBAh2vinKf3Uf1riJXW0v7FttyHdWm+tdNrbXHqml+M0TebVzWsAsQWDU8CQLQdTdsras+T8G2NC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qi0hhmFC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-510322d5363so382989e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740647; x=1707345447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qflVRgaLPtLFWdxTtNrz5ppvd0xQoWg+EunwCWy5ijM=;
        b=Qi0hhmFCsNkMp/q47OpcNF4m/IKeKpLiaTFE3uxMVD8NDNEi2MjxFIzCeREc5FT6t9
         7Zcva/+qvRZW7tOLIj272qhPEMA68ZtK8iASx4B2KkcGcRHxjuZREsYZ7fEzB60OkSy4
         4XMVJ1Y9iLq6RwNvun1IRulYFx8AVPydYc62oxAcuEFUEwhPPy8Tqx8oHtYt74to9b4e
         6m1Tgy5TDoqxu4CzlZcG+9IEnIopmig2y3c7FClz2xJHtRyCrQqwxVlp3Wq0sQxSdP3s
         Mb3Iq5qLHpnE5chkoU4wzPNzIqqQzU4rpn3tOC3sq2dDl5TwWPBVgvJwunp1L7NSyUh4
         lgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740647; x=1707345447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qflVRgaLPtLFWdxTtNrz5ppvd0xQoWg+EunwCWy5ijM=;
        b=xLGdQNMcjqMOezazZbW0MTr22mpZyerKVNgkZ4NOY2T7ygwLUDwx4hHbBZamvWQXL1
         vQ8pbdaa/Hbt7j2TBCe2iICirUsQ+wwjFcjBppw8UzoGUz64XbbOsxofmw9wQ6ZgC5Pa
         h05ERK5VhEaKJWw+mdzh/9AevcfJr1xsZFnngbM4l/adyzlZ2pJgVvVshsiD2omo/D8e
         zuD4QFy58tf1hZ0Whn8J1Nk8aFlFs+pV35fzd9kWh4/XOAYSdP8CuuPJTCBba8GGcy42
         9A25HStFsJLo3kNB7yW6V2t4fYzRyH2DSwSPmAE1Q94sok33yzuDtL2URWU7YqBpOyof
         M7Cg==
X-Gm-Message-State: AOJu0Yx4PEOHps9c+nahCLiAXCzJOA8C0DfTSXXEr8eHahGyuIRZcrir
	Tnhl+7y19PuIIsEn25uK12CGFYZhX2vHU44gLSnDvpGq8vF/fx6vcAm+ubUI3DM=
X-Google-Smtp-Source: AGHT+IHP0c4yw2cb1tH3KkasvEXgTEolgi4dREEGX3xay5jvaVY2tiuki6tuV3gEcKIvvbPP+uZjEw==
X-Received: by 2002:ac2:5b05:0:b0:511:24da:ca21 with SMTP id v5-20020ac25b05000000b0051124daca21mr658246lfn.9.1706740646978;
        Wed, 31 Jan 2024 14:37:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7zI291CvMzGbV4tDVdfrqcKTOar2yqyKSFlxpyCD7d45AtujJIIbroRHBkJHsWBnjyHD6BlU8dpKV4N/pA7kM0EzB3ZApSk1Rt22Xv3wQ7nxrcWzbGQAc8/ZyYgeXLD3UiXESHU1q/j9vCWMMHwGW906VzXWk42CMbFZb//wPshMvslQWHCE8lADQEVs311nLGpjkwdmw73TpScJY/5QBf2eOCiFDOuI9TgYAAC3lKhG1c1YtZnmouR5WhO3AhZZ6Kidh/GPd+i8AkA24WYbHNhAYvJTB5v6PFIsFzvfxlA74Kzo1HgaCReCd9ViVglwSxzSEPdBkwqwmBFSUxTxKJirKdN6SQ/jnV+G2qmeCdg7Em8I5SERp5DUDZ7fROS5f5D4Is60LxNoC37mKVOL7ix6wuP8oVg6wLGr5yTOzgmwJZS2N63JvHay5VcY1Hk3AaKkMoBT1Baurdw==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:21 +0100
Subject: [PATCH 2/6] wifi: ti: wlcore: sdio: Drop unused include
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-2-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
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

The file is including the legacy GPIO header <linux/gpio.h> but
is not using any symbols from it, drop the header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index f0686635db46..45dcc7b400c3 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -16,7 +16,6 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/of.h>

-- 
2.34.1


