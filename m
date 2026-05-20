Return-Path: <linux-wireless+bounces-36721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJLRAqcLDmot5wUAu9opvQ
	(envelope-from <linux-wireless+bounces-36721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:29:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6155985C3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 737E7334643B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0A425CED;
	Wed, 20 May 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu3hqgNX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD663FC5DA;
	Wed, 20 May 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302340; cv=none; b=uSz+uL0b9KPh1Z7SqgP722Wncj2SFa1eh9BXp3hJ+FibtJP972zl5ONGrOwbIWQ+QkjyAKie9NS96GjoyMr8/pPwIUQ4wxD+WyaeciKSHKBR6xuyVjvojibP7gRiCBCMxwPKD0HTmcLyiapau6DLg4w2LPJDSq/Y5+cLtFl69q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302340; c=relaxed/simple;
	bh=E3999r5PntjenilrrxvyJKJ6sUyiktWDefVKeKpvYFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jl+yfH4xh4c5tlDON2RHu8vH2FIBNp/SyjRkFFVVbqhZQI1I6LpdLzaBrtQlGaJCoXuhfrJV6qiZkZOjGgGNN1y2jOPXHwk3v7tpnn8atfNxiOwv5jZ5l/JxgDzJDy/q9LGaTLTGlYvsBI9VN4a99gzS2iqBKWUhIp8+cW5pzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu3hqgNX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C5D1F00897;
	Wed, 20 May 2026 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302339;
	bh=Auptu0K+asnu6CU+7KJoQdTihUUvVzhdRIPr56LBhZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gu3hqgNXSSBWSAzl/z5ypBW6SYI9CfaDgDSK+ol9/yh3aXlQqypeyxw5U0WBnSPdp
	 2iiS8Xhxq8S9lt0lcYHEfu5LP5ONnku5RNmA56DjbtuA9NEblnYvnKQPP+9ev+vn9p
	 bUcoLs3Gx0/qfFzNGjiaz+szHCox6BJoGmac9lWtkK6jpILryIfbPFBRU7BS4PBCLg
	 J81yFkxfiWCP+HCQaY1nrR9iqiguW6REipqVDMOOyry/Gt0/VcQ6teqSz7EfN4HIp1
	 1n6VbeTwTsDVVJBTKewkiBwr7cG7zNyX2VwF7BF/+UJ/DnJbOQh46qHApQCUufqTrt
	 51N8Flosokb+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Date: Wed, 20 May 2026 20:38:07 +0200
Message-Id: <20260520183815.2510387-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260520183815.2510387-1-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36721-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D6155985C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

Most users of gpio-keys and gpio-keys-polled use modern gpiolib
interfaces, but there are still number of ancient sh, arm32 and x86
machines that have never been converted.

Add an #ifdef block for the parts of the driver that are only used on
those legacy machines.

The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
passing an IRQ number instead. In order to keep this working both with
and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
the gpio number if an IRQ is passed.

Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: resend
v2: skip the fake GPIO number passing from mfd

The removal of the arm platforms using this is not yet going to happen
for 7.2, and Dmitry's changes for the Rohm drivers have not yet
made it into linux-next as of 2026-05-20, so for the moment I
would still like to see this patch get merged, even if we are
closing in on completely removing the legacy gpio support in
the gpio_keys driver, so we can make CONFIG_GPIOLIB_LEGACY
default-disabled sooner.
---
 drivers/input/keyboard/gpio_keys.c        | 7 ++++---
 drivers/input/keyboard/gpio_keys_polled.c | 2 ++
 drivers/mfd/rohm-bd71828.c                | 1 -
 drivers/mfd/rohm-bd718x7.c                | 1 -
 include/linux/gpio_keys.h                 | 2 ++
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e19617485679..d748a54dc51c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -528,7 +528,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			 */
 			bdata->gpiod = NULL;
 		}
-	} else if (gpio_is_valid(button->gpio)) {
+#ifdef CONFIG_GPIOLIB_LEGACY
+	} else if (!button->irq && gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
 		 * convert it to descriptor.
@@ -546,6 +547,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		if (button->active_low ^ gpiod_is_active_low(bdata->gpiod))
 			gpiod_toggle_active_low(bdata->gpiod);
+#endif
 	}
 
 	if (bdata->gpiod) {
@@ -583,8 +585,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			if (irq < 0) {
 				error = irq;
 				dev_err_probe(dev, error,
-					      "Unable to get irq number for GPIO %d\n",
-					      button->gpio);
+					      "Unable to get irq number for GPIO\n");
 				return error;
 			}
 			bdata->irq = irq;
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index e6707d72210e..0ae0e53910ea 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -301,6 +301,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 				return dev_err_probe(dev, PTR_ERR(bdata->gpiod),
 						     "failed to get gpio\n");
 			}
+#ifdef CONFIG_GPIOLIB_LEGACY
 		} else if (gpio_is_valid(button->gpio)) {
 			/*
 			 * Legacy GPIO number so request the GPIO here and
@@ -323,6 +324,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 			if (button->active_low ^ gpiod_is_active_low(bdata->gpiod))
 				gpiod_toggle_active_low(bdata->gpiod);
+#endif
 		}
 
 		bdata->last_state = -1;
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index a79f354bf5cb..df6dad762ec9 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -39,7 +39,6 @@
 
 static struct gpio_keys_button button = {
 	.code = KEY_POWER,
-	.gpio = -1,
 	.type = EV_KEY,
 	.wakeup = 1,
 };
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index ff714fd4f54d..dd774aa8828b 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -20,7 +20,6 @@
 
 static struct gpio_keys_button button = {
 	.code = KEY_POWER,
-	.gpio = -1,
 	.type = EV_KEY,
 };
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c6..e8d6dc290efb 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -25,7 +25,9 @@ struct device;
  */
 struct gpio_keys_button {
 	unsigned int code;
+#ifdef CONFIG_GPIOLIB_LEGACY
 	int gpio;
+#endif
 	int active_low;
 	const char *desc;
 	unsigned int type;
-- 
2.39.5


