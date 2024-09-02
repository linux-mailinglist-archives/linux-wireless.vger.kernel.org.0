Return-Path: <linux-wireless+bounces-12345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FF969013
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0AF2845B4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F851885B7;
	Mon,  2 Sep 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhJxcwJN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81F187860;
	Mon,  2 Sep 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317744; cv=none; b=f0v+UNXWr6hljtkehkvO5R6Hl/qhhFiBND9+/lwuJmN5SaSa2WglHy4yWInhjuUBQUHbW7tHDhMsvJplm/ivlDOMQAMWLBQAjXakt73HMeiA11LSVANTB8xMfR8y57G80+lkgOvwlQ1vMpGunvPZmsSKLXb62lJTBFWdp/8ChCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317744; c=relaxed/simple;
	bh=pYBUGJchd1hElAj2UWmVYIZx9SyIAUv5x+nT1cqtkEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKo7q7jvm/kzuDYlX0GKWWnWnYLHqoqA6Xf+w2lQwIgJw/9uQukWnRSTVPs0XsU1IC+GDRH+uBQlJ5wTw8DR8jqadNnyYX+4abu0yN5Y2GeIJBs5/sd4jHs/NHlKeh2vVReLFRPa6rxsIc2BgH7MCsZC0S/j7ihRWMvh/yzrcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhJxcwJN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso1363867a12.1;
        Mon, 02 Sep 2024 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317741; x=1725922541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfk/MB9MXj22xilQhLGF/TlMB4MUR+y/O/4pdlAdOYI=;
        b=mhJxcwJNMHPnSqlZWcv4NCUfnrhgIQ30Su6XSAVL/GUTEHpYPwseV2hzLYGINd909m
         /3p6dLPY8O1YU/jSkiebRzt+HiI+M1aie2OlUOivnZpb6f3jk2ZcO/jy7k8Ab7rA0ZNq
         8S+7jh00wXnl8L7rwM9NsAR8+lI92dRI53lzTIGTk50xji6GDdjDa8Z0YYHtkO7uCqog
         64mjfcii/ClQdaTTMzjzU8ec6y037+PMaQR6YK63EVe9XDSFOtVkphG0Xm4Nl+XJenI1
         6B/aR091HyKFgKymDa0KywfjgCqXnsK0gTVKK0rP++uGfagGslUH2OBnL+YyLcyGhOKi
         hFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317741; x=1725922541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfk/MB9MXj22xilQhLGF/TlMB4MUR+y/O/4pdlAdOYI=;
        b=DN/04ujjf72owoeLVZtRheLnzcNUwayAIlY+vJe/5XCilQ+BfsXcK1mQoFBVdjUlgY
         qEQEVEcJfYEyb3Gd9cETJXj/6ftjej3sWqWcP3Je3O3FfBcA02g3RGJAdGAlQHociRy4
         wWP1nzBVjDdRlJOk2xAZ4kgLICX1PEi2TIaXyNMqcLFJjcB9osVLSUOB95m1foUEUL5/
         blggPbAr7vgvlhztzyeb/BxYmZ/+YKalBurjR4BNuDCdhagaI/nxQ8wZwQNaIbddE6FY
         L8a/sSJiaZEOjin01JwkTA5W19c1LNlTgsZNchQYIMwwtlhDqEbpiEBicLSqEt7XX6pO
         kmNg==
X-Forwarded-Encrypted: i=1; AJvYcCVF+lr8cPDsHW9TMlr9pUgTnKZE+vRKjJmqakLQsL0kmXqbudWsenKyCTRHsctbWWVBkCTOD+rD@vger.kernel.org, AJvYcCVgyOXWMKATllNmcL7TKxG3yJ+2JaQS3AmDB4JPf0nYvAXrGQa214ay//dHL246090m7lMApScp2Kk8ty4kWrg=@vger.kernel.org, AJvYcCWeRIl1kqI0PCDK2xi9cZ2+kSvyLnQwpqP56RdVcdsi/X5RynnKZzV6M/KQHDiEQjqwcmFgnbca0CL9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CBcRU3tW8K1/3YJqApew6TzQxJXrUe+5IooUCkzoNR5vXjft
	1YFns4pEvsMirJc305ElJWsQBLWYtidP5KlCmvctTbRxfKLCt92z
X-Google-Smtp-Source: AGHT+IF25SkxSsbO2kbhyGCDxnLoQCX4vYj5bEuTZ8TcvcUvs/vWx/woT8xGJV6bxwP3GllH69+tMw==
X-Received: by 2002:a50:cc4c:0:b0:5c0:c6ab:7c0f with SMTP id 4fb4d7f45d1cf-5c242f21db4mr5673859a12.23.1725317740262;
        Mon, 02 Sep 2024 15:55:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:39 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net,
	arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	devicetree@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 1/7] drm/i2c: tda998x: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:28 +0200
Message-Id: <20240902225534.130383-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902225534.130383-1-vassilisamir@gmail.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 2160f05bbd16..8dfcebec800e 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1911,8 +1911,7 @@ static int tda998x_create(struct device *dev)
 		/* init read EDID waitqueue and HDP work */
 		init_waitqueue_head(&priv->wq_edid);
 
-		irq_flags =
-			irqd_get_trigger_type(irq_get_irq_data(client->irq));
+		irq_flags = irq_get_trigger_type(client->irq);
 
 		priv->cec_glue.irq_flags = irq_flags;
 

base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.25.1


