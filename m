Return-Path: <linux-wireless+bounces-21186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB2A7D517
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946151721CA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 07:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F4225779;
	Mon,  7 Apr 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ncAkilTQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0814B950
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009855; cv=none; b=JjyaqY+3uRTsjUiU2Af6JAp7Iu1r11Gq4y5LVgKKLyyi7TMYLvRk4jABo67Sk99dyf6rhC6kt7tKWU2bpKhu2nHOEja2YY7+TkIgM2uvJeszB1Y13IX8f99ZFG4EfCJkjShx76ozwTgDefTg7BlT9HEVQvG60QYIPNXAO3aJqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009855; c=relaxed/simple;
	bh=Gn/9poI96RQZEB4BdTG2EIlVnj5fIffZbi0kjF65Z3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oiUzWz0BLjFHT/xbiy02GRWYGyPOIyqPZz4xaGN+0dz+NQhSQvh3BxrRaAYoPyJreV3XHD300cPdI62c/pooLPHc4gUZtKvLxG5H+zKG1M3gqdlZfHemUU+VggQuoZlst3FjnxNsZzkP7fu4aeIPtSQJF/mXyKvIIzEX7XIuShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ncAkilTQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c30d9085aso2256648f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744009851; x=1744614651; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S09RcVQv3bFd4mzFCRVHGkaFyCuRf84i2/SgMcqwsV4=;
        b=ncAkilTQpIMAcVkgc5BIs7BeO14i9pCho8HmylyiCZ5JDErSV+DoTErDjmw6PXAt4f
         VxqiryK5/pczyOySPGim8k1HsjXP0pqF4AD4D4k/7DGgZl7DPXbryeLNv/jGLm9PTeO4
         cCqg9L3j3aDfTDVQvWhfujtKXYV2wQ91CRLRzCRyCMgqxBQ06H4+q9HL91BTxDICYHQG
         DmeDGzNYy3uHcNa74JNqxdORvmepk8BIY8YEsve0E+2kEGQfNxzCw7t686STRTcVpjYC
         UYkDFZx9VwR9u8NG3fpa7yR/DC2gu3Msl1ttsArLwVd0N+KXqKZ31fSQWkhvYI56wDeD
         fLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744009851; x=1744614651;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S09RcVQv3bFd4mzFCRVHGkaFyCuRf84i2/SgMcqwsV4=;
        b=XboDOgKWK/mkUu5U5bg35D1znI45rViUTpC71w71yg3a20Bj2cXlo+2Qa1X/KwctFv
         O9jCP+lG/UjpUyPZDNkL5aKQBRvzVnOt68pe4eZvHqxtrFU7wLHIispxbMIb3To69r3n
         6HmTwAsFPWx+Hd/siHp6BZ88cZ4bqqlRo+wUikmrRjyBuBBWFnpRwynv02Nkypx+OCDn
         Ledf7iZyk3+wuQSljMUv71fmzZuO2Wks5E5RwJMe8ualUWz87vNnctKa7/ZNRTBngMI+
         DfYzOC2DSBINOZyXSEBWx5zvF9mIBaxFwQ0ZJl9oWsuY8Yd7lOOHdouWBhczUY8t2xox
         pGvw==
X-Gm-Message-State: AOJu0Yxb3AZ0ZIPIKMCIDe1AKvtX+aVGlT/WMdi/3A9DMNQhzzhIoOjq
	b/d3L7wVkix0biY/3nApahDlRGe1+zwjHQcAWkEFzLyOXEEmxWOhBYtpDizrLa0=
X-Gm-Gg: ASbGncvMEej4wzK283Y2rIkmYUrgZR4+yqGXNzv9/uIFwl7Z/zcOUwuYPd+0s0dG96l
	UxTq0kLoLkhB9vZMG67BiVkOpN4R/3Sawz20/bkdFvA/l9+I++08wXcwAWmdAl4dw2WvvAB2gel
	E2X//zchVQeoVBYHXmiWkoBcKJzhmM19POPlyBzdhcVD8/V7RkybXFlh9A/FzHVv/1M0ONjBEIT
	GHDoZRgh+jztZoFMVwsH8ozGzUKAZUr3jUWKM4TORWt3nQFQT9XbNjNKFedNLBLt7CfF83CJQDt
	SILaAlNVpOVtxNU7Hqj7H4pfjKNrdNzrSPEy3w==
X-Google-Smtp-Source: AGHT+IHV0AysUoJ50GBhtdS1U93v5S2aO1jvgA/LrlpNVHs6oeC/W37GOR8YbQv8vBRtvRtnfI1+Xw==
X-Received: by 2002:a05:6000:4021:b0:391:2df9:772d with SMTP id ffacd0b85a97d-39cb3596914mr9392893f8f.13.1744009851078;
        Mon, 07 Apr 2025 00:10:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8c64:734d:705a:39a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm120476845e9.18.2025.04.07.00.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:10:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Apr 2025 09:10:49 +0200
Subject: [PATCH] bcma: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-gpiochip-set-rv-bcma-v1-1-fa403ad76966@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHh682cC/x3MQQqAIBBA0avIrBswJYOuEi1KR51FKRoRRHdPW
 r7F/w9UKkwVJvFAoYsrp6Oh7wTYuB6BkF0zKKkGqZXBkDnZyBkrnVgu3Oy+4mi0HY2RznkHLc2
 FPN//dl7e9wNlTrGoZgAAAA==
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3QgGWzq7NIFxjepgO+EmxIwBZ5R8mEbO5nAStbsHTAI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn83p6dQ6MBr5EP50kHnerEPZb674bB0ty/mPpO
 AkT5Lt41qGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/N6egAKCRARpy6gFHHX
 ctY6D/9ShTLBL9Z6nPznwrvX8KbisGsXZDGio4APnrq6sv+eyzWEIUuQpVj6hLiAGofpngsZN8z
 7KYIk7x2nqmWhksXtzbemhiSaYduVaLICb5vPhyyxX7uJM2HxRsTEGUEKhUeY3l91g8RtxCIW5h
 W4iE3Pm/DcoM2xk4V+fdPicW/a6PrpDcBj0G1tHY5zVqZC0X9MqsK78V6jjCOu0yIdPv18TQS8P
 NQmsN0OdbUprYBS327ua3WUzvDVKzcYdlTT22L6MAI1psZ5KEp2kNyUmQmQXe9Ze0VS28ZMSTLQ
 XbzCYNWwwc9dhc+ef/U0NmXafZg7ui0RQ8FU8u3j1hHYsk0aYner35bWObVd1R5+qbC/J0T6nr9
 JWAefuvYfggMY2dML7OcIFxw+eAqNnxaRG/wGPFNsI8xgODcFtiH2eHvA9RwA+xfDtOM0hCCYtW
 MEwEUXI1Dhw4EB7oANpCc8ucg55yMHcwGEuiFV9RdUn7MNx4+PrwzAbyGwisOxUpI5F12NDOKjc
 +pNDSM2+5oEeYRjchK6VCHFzGi37+Wth8gQEiW5sjB6kdwFn1NdshhNZ3gfLIUW3I0Dql/A7yYH
 sQbPbiYKtBRFxArph9hk3Kb5yBP0cvawSFe48bZvU3KBGAungIK97nxtzc6geL8B9i+f/gPtcaf
 0C6BVMj5zCpFTUg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bcma/driver_gpio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 5f90bac6bb09..f021e27644e0 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -26,12 +26,14 @@ static int bcma_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 	return !!bcma_chipco_gpio_in(cc, 1 << gpio);
 }
 
-static void bcma_gpio_set_value(struct gpio_chip *chip, unsigned gpio,
-				int value)
+static int bcma_gpio_set_value(struct gpio_chip *chip, unsigned int gpio,
+			       int value)
 {
 	struct bcma_drv_cc *cc = gpiochip_get_data(chip);
 
 	bcma_chipco_gpio_out(cc, 1 << gpio, value ? 1 << gpio : 0);
+
+	return 0;
 }
 
 static int bcma_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
@@ -184,7 +186,7 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->request		= bcma_gpio_request;
 	chip->free		= bcma_gpio_free;
 	chip->get		= bcma_gpio_get_value;
-	chip->set		= bcma_gpio_set_value;
+	chip->set_rv		= bcma_gpio_set_value;
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
 	chip->parent		= bus->dev;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250326-gpiochip-set-rv-bcma-763c7660ddfd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


