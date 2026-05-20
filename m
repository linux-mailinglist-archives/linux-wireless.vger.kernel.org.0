Return-Path: <linux-wireless+bounces-36720-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF6gKjICDmqs5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36720-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:49:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA7597434
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795D030D6780
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638B3FC5BE;
	Wed, 20 May 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXZeHaPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8140912F;
	Wed, 20 May 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302332; cv=none; b=SmA6WK9u3tUlzUjY9CRPRnfHEUJO4jUarrtM7JJWoGSZE9ZQXu1JWBqCI/U6Nl3pZGraBZI3Rhn9YXgRAboXkAUDa/7xQ1pTbCwP8DxRmlY2wz5TqEu2Ytjfcew1mbPwjEBaVAnpDheuXZ3X9FSWBH8yr7Ix9x/dkqZ6xb0xnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302332; c=relaxed/simple;
	bh=1uIYsBlYCCURxvKJdpYbZfhrVZG+Ug+sWEkN8fOwQu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZT0wgcGKyhYVqHOY+UzRRwk2/slmwe6SjBFTRFCJLAZSQzDSq9m/iYtT8ivqzU/VGdSrkji3OXwPCrh4gYM5+RjeVUawtriN4fOR1QIZ+ShZhEoOoq5IShCshOTYvOYBdljzWITaMCDeYnrn48cOn8Nh2iWoH6uico4l65RCxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXZeHaPR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDED81F000E9;
	Wed, 20 May 2026 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302330;
	bh=OihGU8GjnijwcJjYa7+wFrCgBMw2htDhLPLO3V9LDKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXZeHaPRR8PFRf6v3WbMGaE4h2e+phVAjclh6YrbU8/Lh30S1WnQh6D2cAZsKIvx3
	 ooj+c0nJ5zgvzWmRJtXqVxMBBqg9VEHsMzArwyApKImyeWf4TQYfxl+Uo9OuezgSS4
	 gHjbr0aoTi1PDTKJd0y2VdCVlbE/5NcqLEvW7W0Pvet4GQJvAYRxypzeWuWo2SHz0Q
	 20hjYFyodZ8pxrxtrPPKTwGKsDOCTTBMWx68/BeTG134a3OwHTK/ypOJ5GqSXxa9oz
	 cHUc0Iawh0eeXsRkWgBW5jl1dOmZpPBPpo/qu8NUpG6lAJP5it3ASNgYGBDT+qSeAD
	 htUD0N1w+PRRw==
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
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 01/10] [v2] [net-next] net: dsa: b53: hide legacy gpiolib usage on non-mips
Date: Wed, 20 May 2026 20:38:06 +0200
Message-Id: <20260520183815.2510387-2-arnd@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36720-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,arndb.de:email,broadcom.com:email]
X-Rspamd-Queue-Id: 42FA7597434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The MIPS bcm53xx platform still uses the legacy gpiolib interfaces based
on gpio numbers, but other platforms do not.

Hide these interfaces inside of the existing #ifdef block and use the
modern interfaces in the common parts of the driver to allow building
it when the gpio_set_value() is left out of the kernel.

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/b53/b53_common.c | 17 +++++------------
 drivers/net/dsa/b53/b53_priv.h   | 25 +++++++++++++++++++------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2c4131ed7e30..d838511ae674 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -19,7 +19,7 @@
 
 #include <linux/delay.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -965,17 +965,17 @@ EXPORT_SYMBOL(b53_configure_vlan);
 
 static void b53_switch_reset_gpio(struct b53_device *dev)
 {
-	int gpio = dev->reset_gpio;
+	struct gpio_desc *gpio = dev->reset_gpio;
 
-	if (gpio < 0)
+	if (IS_ERR(gpio))
 		return;
 
 	/* Reset sequence: RESET low(50ms)->high(20ms)
 	 */
-	gpio_set_value(gpio, 0);
+	gpiod_set_value(gpio, 0);
 	mdelay(50);
 
-	gpio_set_value(gpio, 1);
+	gpiod_set_value(gpio, 1);
 	mdelay(20);
 
 	dev->current_page = 0xff;
@@ -3092,7 +3092,6 @@ static int b53_switch_init(struct b53_device *dev)
 {
 	u32 chip_id = dev->chip_id;
 	unsigned int i;
-	int ret;
 
 	if (is63xx(dev))
 		chip_id = BCM63XX_DEVICE_ID;
@@ -3173,12 +3172,6 @@ static int b53_switch_init(struct b53_device *dev)
 		return -ENOMEM;
 
 	dev->reset_gpio = b53_switch_get_reset_gpio(dev);
-	if (dev->reset_gpio >= 0) {
-		ret = devm_gpio_request_one(dev->dev, dev->reset_gpio,
-					    GPIOF_OUT_INIT_HIGH, "robo_reset");
-		if (ret)
-			return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index bd6849e5bb93..cd27a7344e89 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -148,7 +148,7 @@ struct b53_device {
 	u8 duplex_reg;
 	u8 jumbo_pm_reg;
 	u8 jumbo_size_reg;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	u8 num_arl_bins;
 	u16 num_arl_buckets;
 	enum dsa_tag_protocol tag_protocol;
@@ -467,23 +467,36 @@ static inline void b53_arl_search_read(struct b53_device *dev, u8 idx,
 #ifdef CONFIG_BCM47XX
 
 #include <linux/bcm47xx_nvram.h>
+#include <linux/gpio.h>
 #include <bcm47xx_board.h>
-static inline int b53_switch_get_reset_gpio(struct b53_device *dev)
+static inline struct gpio_desc *b53_switch_get_reset_gpio(struct b53_device *dev)
 {
 	enum bcm47xx_board board = bcm47xx_board_get();
+	int gpio, ret;
 
 	switch (board) {
 	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
-		return 8;
+		gpio = 8;
+		break;
 	default:
-		return bcm47xx_nvram_gpio_pin("robo_reset");
+		gpio = bcm47xx_nvram_gpio_pin("robo_reset");
 	}
+
+	if (!gpio_is_valid(gpio))
+		return ERR_PTR(-EINVAL);
+
+	ret = devm_gpio_request_one(dev->dev, gpio,
+				    GPIOF_OUT_INIT_HIGH, "robo_reset");
+	if (ret)
+		return ERR_PTR(ret);
+
+	return gpio_to_desc(gpio);
 }
 #else
-static inline int b53_switch_get_reset_gpio(struct b53_device *dev)
+static inline struct gpio_desc *b53_switch_get_reset_gpio(struct b53_device *dev)
 {
-	return -ENOENT;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-- 
2.39.5


