Return-Path: <linux-wireless+bounces-23926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23DAD375A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B693B8939
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B729AB10;
	Tue, 10 Jun 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eJq0kpHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5C2949EA
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559188; cv=none; b=oVEvi+eG8w4XkJwwVzmp+YZR8srx3WhnSMVylqA/JYUDs7xc0SpFlYeGmVn8BQ1Xkr7WJ9MTSPmhH3gUlAJdydNSfIgs7hX0stYIVoGoNqFsK885e9KcqbsL+HQnj+v7bR8N6LJIMMw0VaOD+DUzhWUnvVF+kKls00HXgUvXAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559188; c=relaxed/simple;
	bh=KXTXXP3gmXsNBhYbI2pbPJi+i5iUcrgAC6+iwNI9gfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RTrLCBUIyWw/Rm/iER+EyeyuILlX0PoHSmj1XsXQqJu6cvqR2SuMAoWkTL5LYpBTRLwcL9w9sYsVVahIf5WwKbT81Ix45iR7wHLa++3wdcEKswpjAAmK6VqCCaW1Mtm3D/ao1jfTPxp/izyN1cCl4f7d6g6DcIdSpJH/zD70JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eJq0kpHD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2260309f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749559184; x=1750163984; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPKfuOMVlbRpUw4IXBiIuvItt2oYtJYUzHdFDWi/ifU=;
        b=eJq0kpHDLxVySOglWhoLTtw1bXg0mYNYuBO9ysd8SWZ8Fcu7Uwn2QLv1OVI1hPwLg+
         jV925U8OjcR7LBj4YQye9Yq2yzTSaeTgALrOvDkrGxjEo3f89dvK1iKlgfS/NuLbEcNW
         JEN7ZYa8o2xdbc9znHhNmgwcBGRmZqKsTaL+qXvSD0yz9oVfvDZMG0xVZP0649vJuo6G
         RbK8idyIqrgzWg4FR7shZ+djKi/pGWqUTYhj2Wkh+vIxYrS+YlspQzC1FAW1CvxIpnU/
         4xDjioDVtmQ78W38AojeFcSdI8Y2cMMiHg5CKwyAgUcpsZWH4nJK7sKlFzroyWq7jTSr
         kcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559184; x=1750163984;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPKfuOMVlbRpUw4IXBiIuvItt2oYtJYUzHdFDWi/ifU=;
        b=P5Ej2CNt5R3hUj5knliTQYJgCM+tUr9nh+4OUUzhImMTTFNDX6RTEd3/36sNkmnVrL
         rgeg+Mh/t9LcJa9QOe1WUr+s9+3S3nNML1dR6o+qNB7PiZ3kQn6J4Bzbh0osdPy7XNqs
         6wdS7/bixjQpQdbHZjFjqGUtXv1cqrdw1CsJfZGBrAAejghOKWlsVzRgkGkgkqHxiIYT
         C9wHpZTm+Qs0ox0/fu2M0DVPVHDz3UqCtw28szZ4c91pdd50kw8GNuSVzN+GZyOFOWAW
         oOrStUoJqvTUmMxe1Z6vpubGpcbXy4l5tKTEdbkt400X2g9fJ5XyrDj53eY02zEJGNR8
         evYA==
X-Gm-Message-State: AOJu0YytwxfZrum4QLS4YbjITgTZiHhPc3u0vCEzXkFuhBVRTwAGbIGg
	MZuIxixJCsqsQEIU6TKueyhv9Vs4peqn/9KDto17I9760Z4ZUrDCVw4jTRVQTmScj7zi9Gl1hDi
	i0jAW
X-Gm-Gg: ASbGnctqRvoNl4zPDVMXEtl+Q4j6ISkntCvxNOpF6ZMVVAURZWE9Crub2kuNsfJkSib
	koY34xDoP+a46GXaYdxI8rZce2PnceAUAocUVFjB8Q85MPZ8TQQS67SzG6Ugkrp32491FpDyNKE
	DjDKEi4vCqN6ltD/Y6tDr0G4iFZHwB2bnkzzMQJbzg10F6oyOlODNin2cH4VAdddg4+7XPIVLM6
	HVzHrGzqnrrdX3Ql/D4OyzbptguJm7IGZngFrb9Ik4KLvCiJVpy4/YIVF9U+hh0Jqzssr7pvhsd
	mXVGP3YFM8tX0APjOpftaC9uT4tkUJLjGvAHFECUAJWQqCGZrjve01kEmoOaC8U=
X-Google-Smtp-Source: AGHT+IF1pGVxA2n06a4mUJOaPcUC12E4n2SYkwvR8YbpfWzpR+In3E2l3SO02IrOhVsK0sOOVrY45g==
X-Received: by 2002:a5d:588a:0:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a552270e62mr2300700f8f.14.1749559184285;
        Tue, 10 Jun 2025 05:39:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c66a1sm136875645e9.27.2025.06.10.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:39:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:39:42 +0200
Subject: [PATCH] ssb: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-ssb-v1-1-0bee5b45b411@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI0nSGgC/x3MQQqAIBBA0avErBswTaKuEi3SxppNiRMSSHdPW
 r7F/wWEEpPA1BRIlFn4Oiu6tgF/rOdOyFs1aKWtsnrAPfLlD44odGPKKOKwHx1ZMyrjQoBaxkS
 Bn/86L+/7AWMW25xlAAAA
X-Change-ID: 20250527-gpiochip-set-rv-ssb-49be53903bff
To: Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=x0asc55yG8x1b/JqLeRyMXrXUOrKy+YdFo9YcQyCb6U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCePqJx2yizehDQ4d2fDi4+3GA5zrBrzZlpJv
 r7JcVS2EACJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgnjwAKCRARpy6gFHHX
 cvAJD/9kjEs6DFFeU9UuqOju+HHgkywwjEjXJQD7d2XOk/Aslcrdq4iL3IFcTT0+S5gvjy+M4qB
 +I9Y59j7B2lNRRGVMBXdHt6wnhvo1qPUogiEX4fNKMjMZp7IGp/iQaUsu/SmeEwPPoKBkBEFwt3
 ACQaK5iMMC8uDT0LP/v3BP/YNKJM/FKBi5UjHIpCAWkFA073h8d+2XifBGHDLhYhvR2Jw8JkQ7J
 TIJojQ3uOjnkhuSq0BQ5L8S8rL2adh3wVo5yZqMAETNJS2rdlL4ru/D5jB5oyxyaguvCSPRvxSX
 VppYKUybKedmBY/UqPeiXgT7Htp5+vkJstQnOZPgTvFEdlCRKzeZAImQdUYid7uwx+OEGxrThxd
 Wf/LeQy2+OsvROH+AYnt2RqmHYgqyFcAp6kd/kU3gIAEfHjQzVm2jgnkE+Z94zA6OozWneaoO/7
 gWDjcxh9uXmyl+1YG4dLzGLB9nQOiBvh3HfCeuWA77nYaBRgOMPnEkEETlLH4sZJEJObpJdiXEu
 WC7soYHhkKr+Q8tjnjsRlZfFQPCsOdlVNGtfciN9rXkE0zS3y9kcl9RAB5aCRwfyuQrq8e/FQFj
 gwft6AX6zqTGz9vgoLL8a+q6nFobkfVPR0tfyhEWeLSKp+RqfEHQt3r5fMc3JHrnpMG+YJJtfAT
 Q08UeU0tirxhroQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones
---
 drivers/ssb/driver_gpio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index f9426a58665365e3f85bc6515049f9c551a78589..14ad57954a662383ec0f0741835da55cbd21a44e 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -45,12 +45,14 @@ static int ssb_gpio_chipco_get_value(struct gpio_chip *chip, unsigned int gpio)
 	return !!ssb_chipco_gpio_in(&bus->chipco, 1 << gpio);
 }
 
-static void ssb_gpio_chipco_set_value(struct gpio_chip *chip, unsigned int gpio,
-				      int value)
+static int ssb_gpio_chipco_set_value(struct gpio_chip *chip, unsigned int gpio,
+				     int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
 	ssb_chipco_gpio_out(&bus->chipco, 1 << gpio, value ? 1 << gpio : 0);
+
+	return 0;
 }
 
 static int ssb_gpio_chipco_direction_input(struct gpio_chip *chip,
@@ -223,7 +225,7 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->request		= ssb_gpio_chipco_request;
 	chip->free		= ssb_gpio_chipco_free;
 	chip->get		= ssb_gpio_chipco_get_value;
-	chip->set		= ssb_gpio_chipco_set_value;
+	chip->set_rv		= ssb_gpio_chipco_set_value;
 	chip->direction_input	= ssb_gpio_chipco_direction_input;
 	chip->direction_output	= ssb_gpio_chipco_direction_output;
 #if IS_ENABLED(CONFIG_SSB_EMBEDDED)

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250527-gpiochip-set-rv-ssb-49be53903bff

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


