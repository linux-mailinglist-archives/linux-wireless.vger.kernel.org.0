Return-Path: <linux-wireless+bounces-2919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB0844B1E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DE828CAC3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCD3B185;
	Wed, 31 Jan 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE4m2gYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EC3A8D5
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740652; cv=none; b=HLInxTwYS8O6YA888XmOewCDL/RvicEAW1nxj7O3znoZsJcsgRuR+DFFEbzpFjOsSKt6J5Ksjpl2w2qP6Pk8OnOahf08IvZ/aV6iYzN0QckV0+MuaaxPH878OYq73EbUMdSbfJpMUKhwc3v8dRUz71NdcUEPQccgEwdAIdcy9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740652; c=relaxed/simple;
	bh=qs2IwTXMaVMdAglmU0WRwo3NIfb2WrdCf70I7utlgJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpELgmVWY7pWArQAHr8F5cTUyCqVwC9nRkCfgbiY3AytY4xKRiwPlykgDlA7fdEmkp0Hedq7bM0NtnLS+uNN3WP/g1HGCtu1kwnd/1dsPm7DXD+JiwULauAaqdrWtmsCuZKpkV6tE4Px7d0xRTEaEUyyjiwNAhCl9LiWL7mTfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE4m2gYb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51032e62171so347674e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740648; x=1707345448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DrXHgtRj4uXVnKQSHYAiPmivQLWMpRFu04w8Lw2Uhw=;
        b=hE4m2gYbteTmy+sHgBEvYTf/3i94+39FzSnKtC7MC3Edb1qOEms7VKkvlcPFu+aMPZ
         seJrnYiHtl1qKDHtxzCS5F4zFH6cIMu+UeKZtUX1xpaue9JByhaYkclg5RYuiM5fJKi0
         8skSsGHf+W34cS4fsXDqF3BHpaKW5M5Lp9XJPhgIAQRd9BEuA9iy9BI5FKM2YQqLcp+W
         hSD6ogXPVM4tYdwQOLvSa8Ql6jtnZyVEPcY7S662e3uY9681auDMDnfshDVI4bCh4iP3
         wj0BcacuT0n6OiHw+LEufQYoHJJ9tTYTXvmHL7AGhcoksaH2ONyelbx5uhc2s0UGE63f
         HrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740648; x=1707345448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DrXHgtRj4uXVnKQSHYAiPmivQLWMpRFu04w8Lw2Uhw=;
        b=BIgMvSK8/eMuPsXR6iaVmtCPx9hCDdM8LQNO0OEH50H0SsTssiZ5S2Zpg33NLxn2Iy
         2YaUO21zG4Ko9Pv/R+M5spGqfT7hxPROr0LWqYrAZeu1GxV4vEngHKyVxg6xqxqCXlO5
         AqVRsax8lN5Aag8WyM2iAhxHe3JR3S6wFP1W84GEbIat7E0xVZXUApWSJMApc07zYt3U
         YD1+w2TrlcpvM5pudsOMBx1QTFrwGXB38R2Bhx+4tfq8sWqR7G8QtnWzx42+8WtWDnCL
         W2McY6S/tr9h9fFvsfFjmpKR3S5rIN/0qTv93zhB3g7+1CREvnyW96DXWeaYUsHOcb2M
         7WeQ==
X-Gm-Message-State: AOJu0YwpHJo0jWI+97an++rkiJy6xaDi0RNKyd9KatF1g62d1zeAIIDK
	rxtU0E6Ruj5rUhY+qdsMDFzyfQV6ML6iIalhZaku5vEF0ocz9ejYsJjRHah+LBk=
X-Google-Smtp-Source: AGHT+IHi2rdan0vzvY3WJ53/OhmnsWjwEgrGErJ9PujYvsVhU6yQ5terlMO9S1GY55tz3i4rJ67UrA==
X-Received: by 2002:a05:6512:74f:b0:511:ecf:e5df with SMTP id c15-20020a056512074f00b005110ecfe5dfmr480442lfs.28.1706740648240;
        Wed, 31 Jan 2024 14:37:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMQDd0jdlmjd8LP1gDqtuZnmdtJ/f8Xv3tT40eOqMozES6c/VXBoJuzMJweWxBCFWWaB01StTnH2fi2WG8laVUthcdxf1Bw8IiozdWj7hZ9jT+2Y+Yws4kQLkSLrjQyGJOEVlQ/t2C6tbfe4OIRPi8YzW80V+bEGdDuggS4QBfDI+Uak8OsVWouEQ5+59ICBDHXabvmZlpO2lV48Tl09GF0zlfJmTcZ5vUE+XM7JZp91jHRUlEMUAZqi6QNbebP2SiV9Ke8mHwCRsNlQS7su/EbFOGr9u3bO81mUHA/de45UDIoqi7D7fby3N87oco9+fBgXfgFeJs4SsIfZcYDox0yGL21Y9bwk7WvksU/g6eak5dcKVA8brkgRS+V5Vsz42wEjnbuNI8s7CgcLMhArrB+nDPh8CfJgB0lmgC1/K3Yen6kW3XIrsNkq1uGWgjPMpdUMnPYhQs3OLSMA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:22 +0100
Subject: [PATCH 3/6] brcm80211: brcmsmac: Drop legacy header
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-3-e1c7c5d68746@linaro.org>
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

The driver is using all the modern abstractions to obtain and use
GPIOs and the legacy <linux/gpio.h> header is unused, so drop it.

Fixes: a8e59744e16b ("gpiolib: split linux/gpio/driver.h out of linux/gpio.h")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index 89c8829528c2..9540a05247c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/mac80211.h>
 #include <linux/bcma/bcma_driver_chipcommon.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/consumer.h>

-- 
2.34.1


