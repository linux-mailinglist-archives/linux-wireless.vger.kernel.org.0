Return-Path: <linux-wireless+bounces-26228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7EB1EBC1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAC2D4E4ADC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A1284674;
	Fri,  8 Aug 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p83HcBtP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97182284688;
	Fri,  8 Aug 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666634; cv=none; b=rjUKu2C7DibUr7fpgl85c45on3xWi2r5Kn3Kt3TOtmFfQVzw3IgRBIe1dlzf3ZQlLeXorSLKRO2LLqulbCRnUvQY4fVE8nmK5gXTxZb6GGK5v4LFpvcRxL2TPOx8V2I6rq64IGYh3Xu51zD+vDaLiV6WbthKhDJUPHtm4VzruZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666634; c=relaxed/simple;
	bh=oAFQA9TbeQJ0JUZrMnAe5qsvI2i9waFhIJMusddsYPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJOozUpC5ThoBUv9lrubJXmmgYf6UDnq7kAUmiI6Z3KK19cajiPoal0dn5RGj0vx0VwoLaszrotFNbNh4/3D5WxsjXVBVDOVpUfN0uJH5OQbTaMsPwOFgaDgp040fjcSHO+SNmo6lLOoocgwvL5ZYwtIJYChumQ+ft0FvTFWyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p83HcBtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB95FC4CEED;
	Fri,  8 Aug 2025 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754666634;
	bh=oAFQA9TbeQJ0JUZrMnAe5qsvI2i9waFhIJMusddsYPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p83HcBtPUk2RQWICi6LA+VYl/Qwb8fzNLUGwm4IU4Gotr0D0SkpnN2j3Mf4sE57VS
	 YE1fpMV8MJBc6H+lj44sxARxOBgOo5KWAQo3XaYP8KunAdsE6ZYVwkE4KWD7dIZR4L
	 l3ujmsdw4i4eWjxIAZsZrICO5oL9Ugdt6/LIcKInGAjmL6A0DN7x+GKcI5IzwYK9fN
	 RFyD+iJtozyJW6/4ZBhkDJaReuUCcxBZKGeJwzuiTTM4rDiXvo3RT+trnFAr7N1CQT
	 T0RSKOW2fY443efBYt+EjFY3BAFHE0a3aPIdqOpJ2aGbDmEpkkFOr0T+V2laHpSlvW
	 m7QfkqlYe+8tg==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] ath10k: remove gpio number assignment
Date: Fri,  8 Aug 2025 17:18:00 +0200
Message-Id: <20250808151822.536879-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808151822.536879-1-arnd@kernel.org>
References: <20250808151822.536879-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The leds-gpio traditionally takes a global gpio number in its platform
data, but the number assigned here is not actually such a number but
only meant to be used internally to this driver.

As part of the kernel-wide cleanup of the old gpiolib interfaces, the
'gpio' number field is going away, so to keep ath10k building, move
the assignment into a private structure instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath10k/leds.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/leds.c b/drivers/net/wireless/ath/ath10k/leds.c
index 9b1d04eb4265..3a6c8111e7c6 100644
--- a/drivers/net/wireless/ath/ath10k/leds.c
+++ b/drivers/net/wireless/ath/ath10k/leds.c
@@ -27,7 +27,7 @@ static int ath10k_leds_set_brightness_blocking(struct led_classdev *led_cdev,
 		goto out;
 
 	ar->leds.gpio_state_pin = (brightness != LED_OFF) ^ led->active_low;
-	ath10k_wmi_gpio_output(ar, led->gpio, ar->leds.gpio_state_pin);
+	ath10k_wmi_gpio_output(ar, ar->hw_params.led_pin, ar->leds.gpio_state_pin);
 
 out:
 	mutex_unlock(&ar->conf_mutex);
@@ -64,7 +64,6 @@ int ath10k_leds_register(struct ath10k *ar)
 	snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
 		 wiphy_name(ar->hw->wiphy));
 	ar->leds.wifi_led.active_low = 1;
-	ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
 	ar->leds.wifi_led.name = ar->leds.label;
 	ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
 
-- 
2.39.5


