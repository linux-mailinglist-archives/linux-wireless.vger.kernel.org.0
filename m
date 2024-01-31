Return-Path: <linux-wireless+bounces-2921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE1844B22
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0C29185F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74723B79F;
	Wed, 31 Jan 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDPT9GmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718939FE0
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740654; cv=none; b=u3iiN49DOqjl69yNyy0+sW2djSdUh4WjEQiqWFeLVvc4JUnqxXow8GMJDYFWS4Zx595P3WxnJH8Z8ia0D2yhD/RCOsOAFK6EXJ9BFmWn6tIy1Wd/RZ5IThVnlxP0Sv794Y1UEDWCJ/vK9lB4JezDJvz9QTSbyrJ9DSB87B8J/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740654; c=relaxed/simple;
	bh=5XJc9ghGuRNHdIp0vfzuqM/TEK4kPBeBAS0v6fakgGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1p0nkcFfci1JVo86rFtFqC0p5NhZDT/GG/pPywr5ncmybHtposh/uAIW7Erw22eb4sUGFL9EXt4DbgWdwo9CYXsbpjV7m1orNenGZfQpXPsuuvCMdePIH3r3VXDDqfDOETAlT1qiBMyx3zaoGkMzYrKIX4jNhjLsX/1Uu3VuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDPT9GmH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51124d43943so360910e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740651; x=1707345451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Syf6YeMPz8gpPA3EVgI80juDku+cwPRF2yHgIUcG34U=;
        b=HDPT9GmHUOZD/Yxh3GJWuhrCPWKJLyKNbT46T56qYwQ+t5C19KazrGlqwdkAhYpEhN
         KpkMVoQQlG/7efMR2W00TmnczusNjTZC4pwOEuHwHeK6J3GodI9ohefzpuojTJLiYqiP
         jK3li270zlCFQLl3aRlWfhn12jP/9ZddXGH8Ar/zGBgviUIc/GMbR5CyFES753ea0jOh
         fGqqfCK5QVj53AANaws3osrNz5mr78baCIs7QkxwVA2D89IRCtTntKaJ1tz9Du37P/rk
         NnBQlkQqSTlc2654wYemX6X2VqrqYOsZ9wt0tmZdpVsKclCg+BOyYXm0az4Uxk4cETVm
         CuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740651; x=1707345451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Syf6YeMPz8gpPA3EVgI80juDku+cwPRF2yHgIUcG34U=;
        b=jrG7VBlFlj0ZojOrC4QPir3pOeNpV5thB5C83Y+R4DnsztYo2xhkISwRVeM/t/244M
         WpbC70GSZY8PGwLrm2JTUBlY3DHivgq+gOfjL18C4tmlGTG37qOuLL5Vj/XZMy+RXs5q
         Kn//SAY4lTyoDP4ppPseR20v0JPXPDO3X7zX37zkOOCxmMfKEjaJuhYcUHg3EbvPrwuP
         cbJKgxR4MOun90+x9NKDQ4TKT0Md9E6hiAcRxUxIIvDDPpKxm2a6xzwma1t1zBmIxx01
         GMMooN+ysiqyfh262SdwLUNdmwS51lKI5kqfWfYuR9Xd5wbXMSfVIp2Zx23f/NH2Xbdt
         XWMA==
X-Gm-Message-State: AOJu0Yzoqdf0okFlWpK4Jzbfu3glfz0hzD25uYcoW//Kvw9rRtL2j5XV
	Aqgh+nW/vgEYszbPmzb7yxm/zY2DmK8r/ScUgc+A080LEgMmcHB/n8FGRVM3xWc=
X-Google-Smtp-Source: AGHT+IFabhNFUnvdjOxg++L9fXcb6SseUl3cRggcgn5z5FCEUpUkxPFCH2Fjl+pik3OVtLZSD+aU/g==
X-Received: by 2002:ac2:4286:0:b0:510:1ac1:652a with SMTP id m6-20020ac24286000000b005101ac1652amr516477lfh.53.1706740650892;
        Wed, 31 Jan 2024 14:37:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVU6Xf2k7fLJCsGaXJ48xSGR/ZEOgNNv73JxVK6al6D6h+kwLhNizQIheA/90lTULztjTEEKfX+3/KgEleOjYGyA0TnU1HRdffRBekVLCBsGPdip21OBVuPWgPhsF5aYeXOK5XSNHVbdJSp021SsqUGhnoqYgSPfrxYeh9/dE+OdLwuYbPH0vFGMaaJ4GsBITxAtMMEGDcYt5rqSUNQGygPLeHXkhyrXLZe2QJGfx6rRlsx4SKAgLQF7Q6cCXBl43Pej4mGMa9UqoTubJnXHDbW+qb7nC/BFcLPnEONINAp4qVE75tgiMAeoYuTeE4DZgWSqXVY3hXvwe6QVpoje2IfttB64b1IyRgD3ZWZI5Isv9lPmMjrpLeAYqmgiDfyUYaBCZGGG+KXLAzinIGiFlbNgE33LfOUA3RHGRYBxgdTIPkgqgEUvbH+JrTO/dnKhFM/Ogfi+IIOrD57Jw==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:30 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:24 +0100
Subject: [PATCH 5/6] wifi: plfxlc: Drop unused include
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-5-e1c7c5d68746@linaro.org>
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

The driver includes the legacy GPIO header <linux/gpio.h>
but does not use any symbols from it. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 506d2f31efb5..6f5857d09af0 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -7,7 +7,6 @@
 #include <linux/etherdevice.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
-#include <linux/gpio.h>
 #include <linux/jiffies.h>
 #include <net/ieee80211_radiotap.h>
 

-- 
2.34.1


