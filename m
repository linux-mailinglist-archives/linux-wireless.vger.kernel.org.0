Return-Path: <linux-wireless+bounces-25943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA438B0F4FB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938741888244
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C122D3723;
	Wed, 23 Jul 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L8jAOD5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185422F755
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279984; cv=none; b=myL8yBtstSXyHUQ4SZcuXxeFUpY8R18wiHIiGmnAXvAki1Nt9tPWgEJ9+pi4kSLIznQ+Y1ge6ma+0ij6jsiQNXivFGQZWZnTfFlkwgMKllMsvvwZOmIRXrdgG+KCC/mim1oKmKUUcbb2xq9Ctr0UgrDgasv03jYvoqiiXJ8xtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279984; c=relaxed/simple;
	bh=fNEjxVqvHUjEyYP7eF81ud6f43OvHX8nmedqPVXjWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdbwqhyRgrZ5ismoe3W1SDWsK1Bv2jAKokC3vrmEnvjbjvIiXpXxxwiX+qpUT2FjymanUt8Tii5YfgdJ13O9v7lirt9kip2cksTFHyx4q6wHGKZqLsQlJTz1xkl/sL6NSFHyuxtPVPoUeuGXuUHtWBt6ig4+iOf9dskn2rHZB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L8jAOD5L; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso6315437f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753279981; x=1753884781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl80Bu6jGD0s+NTfuIcms5WgEbUpaplgB9B6tltiTec=;
        b=L8jAOD5LNo6VW7kg3hpq3IvrzvLtMNkJicUkX5cnMcYdU911GpyBc5oTN6xuZDITtJ
         23S3+ZPoJ9fnqs7oG80KlxywupriB5b3c9qlqk5Fsq/Ad2MJSBHKcm5M+EDHdh0prk20
         BwdcSlCxOtMEN6jo7kvNR7yMbF9zl8xCbiVzZFkjgTGGS0S/WiWTh03o05AOlEv+aSlq
         5yMvJrMhmDGLb41n9Ex1dJQtADMKIom09KpISXt7Q5cq9BhZRRzJgXPh57ifH045HoD/
         zDAb0DX6PKI7xNiUif9PanlTOjmCH1sWxJfNPcao/Obyv42uklr8HmgyaKcbYiaQtNlL
         tXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279981; x=1753884781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl80Bu6jGD0s+NTfuIcms5WgEbUpaplgB9B6tltiTec=;
        b=jUpiq2d603tjwpcvQBLVW0QQJnsIUDPWJOLXJzKCMcsnzfl+mm/3x+W8Ogg8olKD/D
         YHxB1kIwWfTVrcBXrGQev+mvbKmfK57zARPM6odtA5+iNlAI7p47CilClMOR4cLW4TxS
         bJKL4NkHp5fhm+9TdAw/Ra3hiV9xxkvZKVFPk8NZcgArULTgOaWXvzgCupjUFrDWDW7r
         /tmRL7MhUCOQFVt+ildMp+VPuoaNWxhdeZDwIIWP8WEwxSzFPcKW2L0uQ7qzwTy17gB1
         HhHgAr5Tyy3QlHzwlFyP/i8JfPOpQ9SZqbgIAWp4qvIaPzXgsigFjODWCMmxcB+9wbaD
         w9hA==
X-Gm-Message-State: AOJu0Yz1Ix2Rmedb/TAw5UX5zDZ8N3n0HOi5rj4h6XnP54Mi/IyLajxm
	xKKgNpM0gHMuRNzX+nGyVgX+r7o7Aj6mqKUojZUXvgaMqjIuWiqFwqzdgY3SkUhWgjs=
X-Gm-Gg: ASbGncvzE0Ftwm7Dvngiv01JtDdGV/dVf4HQ52C4oD3n0cqBftIBX++EEybqJkuA4j6
	x/E0Ik/kdUAQtU5GJ/pLNhX4er4QyNFjPj8RX6x/YJz5Il8VpzdE9c86bvQbGlx4ftS/Y9WNYkQ
	81elIR41ID71IO561zLmMiRsqo752+5pH1ky79NO218vdxj/ej25Z2w4jSjyKghUcBO34vvn7Hb
	on0Ic2WymdIEI7x5fekb5WMr2usuSsSfrcLWJbuySdKPZOkd0/3+yGRc8/bnS0htX70Yv1pD+0N
	1XU6DFfDGgKvCwIVUjlgK3sD6VpOwcN9J0A6OEkPS2D2VAtOEMPwRFHB/eGscum2i5ZSHQwRZfb
	eI0Gv9U6fdXBMYMHYRx7QBQ==
X-Google-Smtp-Source: AGHT+IG9+1w7YmO5GUnA4vkE6KJTbpONcQ8rqEmd5NJrNB57AzDfuCcgrodqrLbEMSV4zeN39Hktxw==
X-Received: by 2002:a05:6000:310d:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b768ee0463mr3152841f8f.9.1753279980477;
        Wed, 23 Jul 2025 07:13:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:34cd:b1d:d4f9:be03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9edsm16688077f8f.88.2025.07.23.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:13:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Michael Buesch <m@bues.ch>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] ssb: use new GPIO line value setter callbacks for the second GPIO chip
Date: Wed, 23 Jul 2025 16:12:57 +0200
Message-ID: <20250723141257.51412-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Because the other chip is guarded in an unlikely ifdef, I missed it when
converting this driver. Fix it now.

Fixes: 757259db79fc ("ssb: use new GPIO line value setter callbacks")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Johannes, Michael: I only noticed it now when randbuilding mips with a
patch that removed the previous callbacks. I would really appreciate it
if we could queue it for v6.17 as it will allow us to complete the
treewide conversion of GPIO drivers. Any chance you could fast-track it
into your tree?

Thanks,
Bartosz

 drivers/ssb/driver_gpio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 14ad57954a66..e1f5f0a9c8a2 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -267,12 +267,14 @@ static int ssb_gpio_extif_get_value(struct gpio_chip *chip, unsigned int gpio)
 	return !!ssb_extif_gpio_in(&bus->extif, 1 << gpio);
 }
 
-static void ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned int gpio,
-				     int value)
+static int ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned int gpio,
+				    int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
 	ssb_extif_gpio_out(&bus->extif, 1 << gpio, value ? 1 << gpio : 0);
+
+	return 0;
 }
 
 static int ssb_gpio_extif_direction_input(struct gpio_chip *chip,
@@ -420,7 +422,7 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->label		= "ssb_extif_gpio";
 	chip->owner		= THIS_MODULE;
 	chip->get		= ssb_gpio_extif_get_value;
-	chip->set		= ssb_gpio_extif_set_value;
+	chip->set_rv		= ssb_gpio_extif_set_value;
 	chip->direction_input	= ssb_gpio_extif_direction_input;
 	chip->direction_output	= ssb_gpio_extif_direction_output;
 #if IS_ENABLED(CONFIG_SSB_EMBEDDED)
-- 
2.48.1


