Return-Path: <linux-wireless+bounces-36092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJjZH/0D/WmIWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:28:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D623A4EF435
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0163130A3F5A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A012344D90;
	Thu,  7 May 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joFeMxav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D66343D85;
	Thu,  7 May 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189121; cv=none; b=Z/pd3mVyNVYk3lR2kaBicCMomEhF66tac/TPnTDS20ul0oUrSu6abWlBRXiipKBE+nsSESxLPHxBKvbqqx0BQjbgDjqAy8mPLCP4tlVhtsFxzSFXQ/Pe4ObHsU2DEkLKZSIBOIfLm5coiZsHy8BmXOU8IZf8n6gayR850FJ9nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189121; c=relaxed/simple;
	bh=p5t+JM3lfiw9lH48miW27NEkEgOXRNL8J8aC9VfoV+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oeJYxJzUWEuDfbZfvl7Abri2+XFQkteSfI/p9NWv8p5jnn42ElJEKDPVk98Ep2zKeDAzMkGDosWmu0U7FDjArZKzEeYKhBWR1CV/SWzDIOOGSgDSrTWKP3iAubPPUxeNBtiJWEj+poId0sreaZbw7jYI8519+2Nc7RyE6pBwTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joFeMxav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33C5C2BCC7;
	Thu,  7 May 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778189121;
	bh=p5t+JM3lfiw9lH48miW27NEkEgOXRNL8J8aC9VfoV+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joFeMxav2cbvkSjpcFV+IRYIaJZ2ND24vIzjvO3QuFSjLaFxqCoGxKfQr7opRGQc7
	 3lON8Tcxm/tY/jQQgr3mAlmn6rISw1iVq3CtqTN2zspiwkrYBCHl2X4E3If6niEUbb
	 v5Of/tFshr10705WIy83BlgeY430ZebJ5WQ0dF6d66yiYNAGr+vz6xvVGT204UZ4y6
	 ujxpyhzyA5V2HZkjwk2JBMevhQNsuo/gFsEuABM+QSPs9durfV7Gc3zFZa7B6nUmEf
	 pvbm8me+27HgorJskeXs4AWhv6sZKdSgzorQ/HVgsSed7MDUFAWm0PKaqmyNqNmr27
	 bofGuP+yjzxZg==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Aaro Koskinen" <aaro.koskinen@iki.fi>,
	"Andreas Kemnade" <andreas@kemnade.info>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Felipe Balbi" <balbi@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Kevin Hilman" <khilman@baylibre.com>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Linus Walleij" <linusw@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Roger Quadros" <rogerq@kernel.org>,
	"Tony Lindgren" <tony@atomide.com>,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 2/3] [v5 net-next] p54spi: convert to devicetree
Date: Thu,  7 May 2026 23:24:50 +0200
Message-Id: <20260507212451.3333185-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260507212451.3333185-1-arnd@kernel.org>
References: <20260507212451.3333185-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D623A4EF435
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36092-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The Prism54 SPI driver hardcodes GPIO numbers and expects users to
pass them as module parameters, apparently a relic from its life as a
staging driver. This works because there is only one user, the Nokia
N8x0 tablet.

Convert this to the gpio descriptor interface and DT based probing
to improve this and simplify the code at the same time.

Acked-by: Christian Lamparter <chunkeey@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v5:
 - fix irq assignment # https://sashiko.dev/#/patchset/20260430081242.3686993-1-arnd%40kernel.org

v4:
 - make gpio line optional again
 - fix EPROBE_DEFER handling
 - match only st,stlc4560 compatible value, with binding change

v3:
 - rebase an older patch
---
 arch/arm/mach-omap2/board-n8x0.c           | 18 ------
 drivers/net/wireless/intersil/p54/p54spi.c | 67 ++++++++--------------
 drivers/net/wireless/intersil/p54/p54spi.h |  3 +
 3 files changed, 26 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 969265d5d5c6..d9acd32c5457 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -20,7 +20,6 @@
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
 #include <linux/mmc/host.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mmc-omap.h>
 #include <linux/mfd/menelaus.h>
 
@@ -106,21 +105,6 @@ static void __init n8x0_usb_init(void) {}
 
 #endif /*CONFIG_USB_MUSB_TUSB6010 */
 
-
-static struct omap2_mcspi_device_config p54spi_mcspi_config = {
-	.turbo_mode	= 0,
-};
-
-static struct spi_board_info n800_spi_board_info[] __initdata = {
-	{
-		.modalias	= "p54spi",
-		.bus_num	= 2,
-		.chip_select	= 0,
-		.max_speed_hz   = 48000000,
-		.controller_data = &p54spi_mcspi_config,
-	},
-};
-
 #if defined(CONFIG_MENELAUS) && IS_ENABLED(CONFIG_MMC_OMAP)
 
 /*
@@ -524,7 +508,5 @@ omap_late_initcall(n8x0_late_initcall);
 void * __init n8x0_legacy_init(void)
 {
 	board_check_revision();
-	spi_register_board_info(n800_spi_board_info,
-				ARRAY_SIZE(n800_spi_board_info));
 	return &mmc1_data;
 }
diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index 9d66dcae54e0..d18be2545028 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
@@ -15,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/spi/spi.h>
 #include <linux/etherdevice.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include "p54spi.h"
@@ -30,19 +31,6 @@
 MODULE_FIRMWARE("3826.arm");
 MODULE_FIRMWARE("3826.eeprom");
 
-/* gpios should be handled in board files and provided via platform data,
- * but because it's currently impossible for p54spi to have a header file
- * in include/linux, let's use module parameters for now
- */
-
-static int p54spi_gpio_power = 97;
-module_param(p54spi_gpio_power, int, 0444);
-MODULE_PARM_DESC(p54spi_gpio_power, "gpio number for power line");
-
-static int p54spi_gpio_irq = 87;
-module_param(p54spi_gpio_irq, int, 0444);
-MODULE_PARM_DESC(p54spi_gpio_irq, "gpio number for irq line");
-
 static void p54spi_spi_read(struct p54s_priv *priv, u8 address,
 			      void *buf, size_t len)
 {
@@ -262,14 +250,14 @@ static int p54spi_upload_firmware(struct ieee80211_hw *dev)
 
 static void p54spi_power_off(struct p54s_priv *priv)
 {
-	disable_irq(gpio_to_irq(p54spi_gpio_irq));
-	gpio_set_value(p54spi_gpio_power, 0);
+	disable_irq(priv->irq);
+	gpiod_set_value(priv->gpio_powerdown, 1);
 }
 
 static void p54spi_power_on(struct p54s_priv *priv)
 {
-	gpio_set_value(p54spi_gpio_power, 1);
-	enable_irq(gpio_to_irq(p54spi_gpio_irq));
+	gpiod_set_value(priv->gpio_powerdown, 0);
+	enable_irq(priv->irq);
 
 	/* need to wait a while before device can be accessed, the length
 	 * is just a guess
@@ -608,31 +596,20 @@ static int p54spi_probe(struct spi_device *spi)
 		goto err_free;
 	}
 
-	ret = gpio_request(p54spi_gpio_power, "p54spi power");
-	if (ret < 0) {
-		dev_err(&priv->spi->dev, "power GPIO request failed: %d", ret);
+	priv->gpio_powerdown = gpiod_get_optional(&spi->dev, "powerdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpio_powerdown)) {
+		ret = dev_err_probe(&priv->spi->dev, PTR_ERR(priv->gpio_powerdown),
+				    "powerdown GPIO request failed\n");
 		goto err_free;
 	}
 
-	ret = gpio_request(p54spi_gpio_irq, "p54spi irq");
-	if (ret < 0) {
-		dev_err(&priv->spi->dev, "irq GPIO request failed: %d", ret);
-		goto err_free_gpio_power;
-	}
-
-	gpio_direction_output(p54spi_gpio_power, 0);
-	gpio_direction_input(p54spi_gpio_irq);
-
-	ret = request_irq(gpio_to_irq(p54spi_gpio_irq),
-			  p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi",
-			  priv->spi);
+	ret = request_irq(spi->irq, p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi", priv->spi);
 	if (ret < 0) {
 		dev_err(&priv->spi->dev, "request_irq() failed");
-		goto err_free_gpio_irq;
+		goto err_free_gpio_power;
 	}
 
-	irq_set_irq_type(gpio_to_irq(p54spi_gpio_irq), IRQ_TYPE_EDGE_RISING);
-
+	priv->irq = spi->irq;
 	INIT_WORK(&priv->work, p54spi_work);
 	init_completion(&priv->fw_comp);
 	INIT_LIST_HEAD(&priv->tx_pending);
@@ -659,11 +636,9 @@ static int p54spi_probe(struct spi_device *spi)
 
 err_free_common:
 	release_firmware(priv->firmware);
-	free_irq(gpio_to_irq(p54spi_gpio_irq), spi);
-err_free_gpio_irq:
-	gpio_free(p54spi_gpio_irq);
+	free_irq(priv->irq, spi);
 err_free_gpio_power:
-	gpio_free(p54spi_gpio_power);
+	gpiod_put(priv->gpio_powerdown);
 err_free:
 	p54_free_common(priv->hw);
 	return ret;
@@ -675,10 +650,8 @@ static void p54spi_remove(struct spi_device *spi)
 
 	p54_unregister_common(priv->hw);
 
-	free_irq(gpio_to_irq(p54spi_gpio_irq), spi);
-
-	gpio_free(p54spi_gpio_power);
-	gpio_free(p54spi_gpio_irq);
+	free_irq(priv->irq, spi);
+	gpiod_put(priv->gpio_powerdown);
 	release_firmware(priv->firmware);
 
 	mutex_destroy(&priv->mutex);
@@ -686,10 +659,16 @@ static void p54spi_remove(struct spi_device *spi)
 	p54_free_common(priv->hw);
 }
 
+static const struct of_device_id p54spi_of_ids[] = {
+	{ .compatible = "st,stlc4560", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, p54spi_of_ids);
 
 static struct spi_driver p54spi_driver = {
 	.driver = {
 		.name		= "p54spi",
+		.of_match_table = p54spi_of_ids,
 	},
 
 	.probe		= p54spi_probe,
diff --git a/drivers/net/wireless/intersil/p54/p54spi.h b/drivers/net/wireless/intersil/p54/p54spi.h
index e5619a13fd61..118785cc635a 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.h
+++ b/drivers/net/wireless/intersil/p54/p54spi.h
@@ -107,6 +107,9 @@ struct p54s_priv {
 
 	enum fw_state fw_state;
 	const struct firmware *firmware;
+
+	struct gpio_desc *gpio_powerdown;
+	int irq;
 };
 
 #endif /* P54SPI_H */
-- 
2.39.5


