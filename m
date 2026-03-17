Return-Path: <linux-wireless+bounces-33326-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GdyFF8VuWmOpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33326-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:48:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A672D2A5E94
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDCE30783BA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B137DE91;
	Tue, 17 Mar 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ZZFs1P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1411B4257;
	Tue, 17 Mar 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737126; cv=none; b=BFAMdTe8UPQnYuJOUtww+GHKIVXNQ1TJeLKb13qevbbYeygtLEf4AwjI+kdmfyNaT3zCaPNgtSCwjztxhclvR7qJ8adkFhz3rz9iP0ZGm2NiTaKx+fKXNLhCAJicad2jKuKcROHDoZ4BwdA8PHg0daLQM76+gBGfc7jtwH42jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737126; c=relaxed/simple;
	bh=bG2QMyFtCPxrCde+WV94qaWM5BIHp30o0Z4obMH9Imc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b7XP5SMuC5oa5sxJgOlP8tTJInbsfr4VamHQpebwX3CpziwE5pn7N22FSa6/SFbce+8hFHQOoYDxtvYOWruFxRhCBmXIichr8CrWKfyHTex0Bgypfi6bXmvACkEOngIptbExZfaR5Sd/7Y7i+UBZcg/lu/nIxBst8VfyBPpDcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3ZZFs1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC1C2BC9E;
	Tue, 17 Mar 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773737126;
	bh=bG2QMyFtCPxrCde+WV94qaWM5BIHp30o0Z4obMH9Imc=;
	h=From:Date:Subject:To:Cc:From;
	b=I3ZZFs1PQA2sKkHnWY3pAVvPS9jrCHRKVjnVZUGxtGdPQ7sqpOfNftZgTrpXKAG5K
	 fCWwqS09jtLWLBeibXauO8MVGXnJ7unD2dfBP8iGvkaVs5KfCdfmJFwcdD2wuA5C75
	 92ut7V6LMoKRfBX1WPncVgZVAI91Yj0o/eGgDEPsDRdHnG1eFT9/M9vbqrg+vGP9+d
	 y5/jWZ3U8fsv3iFWU5VZg0FXotdqYrzw909SxGsf+N6lLL+PRtf1qJLXVCSy3MGeqD
	 sxRmx7bi8q+McAa/8VCMpvJXp8D+M9gdYITju9L95s01xomv3oY+rHz8odO1RGZfC3
	 97ueyfZ147DeA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Mar 2026 09:45:20 +0100
Subject: [PATCH v6] wifi: ath9k: Obtain system GPIOS from descriptors
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-descriptors-wireless-v6-1-b19ecff9cd2b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPy2rDMBAF0F8JWldlpNHDzir/UbrQY5yIGjtIR
 UkJ/vcqoSUpqZd34J6ZubBCOVFh282FZaqppHlqwbxsWDi4aU88xZaZBKlASMkjlZDT8XPOhZ9
 SppFK4b6LrtcxOI+ateox05DON/btveVDKq3wddtSxXX6A6L4H6yCAycRbNDRdFaZ3Zgml+fXO
 e/ZVazyriiJK4rkgpsoIqBH8IN7UvBXMYBi5bmKTdESgaCzEFDsPihPNN4V9ais3aKaAtZ5ZUP
 Xu757UvSjYlYU3RQcbC+C8RC8+6Msy/INdnaU9dEBAAA=
X-Change-ID: 20240122-descriptors-wireless-b8da95dcab35
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.intel.com,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33326-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,toke.dk:email,kempniu.pl:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A672D2A5E94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ath9k has an odd use of system-wide GPIOs: if the chip
does not have internal GPIO capability, it will try to obtain a
GPIO line from the system GPIO controller:

  if (BIT(gpio) & ah->caps.gpio_mask)
        ath9k_hw_gpio_cfg_wmac(...);
  else if (AR_SREV_SOC(ah))
        ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);

Where ath9k_hw_gpio_cfg_soc() will attempt to issue
gpio_request_one() passing the local GPIO number of the controller
(0..31) to gpio_request_one().

This is somewhat peculiar and possibly even dangerous: there is
nowadays no guarantee of the numbering of these system-wide
GPIOs, and assuming that GPIO 0..31 as used by ath9k would
correspond to GPIOs 0..31 on the system as a whole seems a bit
wild.

Register all 32 GPIOs at index 0..31 directly in the ATH79K
GPIO driver and associate with the NULL device (making them
widely available) if and only if we are probing ATH79K wifi
from the AHB bus (used for SoCs). We obtain these offsets from
the NULL device if necessary.

These GPIOs should ideally be defined in the device tree
instead, but we have no control over that for the legacy
code path.

Testcompiled with the ath79 defconfig.

Reported-by: Michał Kępień <kernel@kempniu.pl>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
This patch set is a long standing attempt to get rid of the global
GPIO numbers from the ath9k Wireless driver.

Maybe Jeff can merge this to the Wireless tree if we agree on this
hack solution.

Michal: can you test this? It would be great.
---
Changes in v6:
- Fix the kernel test robot warning that I missed...
- Link to v5: https://lore.kernel.org/r/20260316-descriptors-wireless-v5-1-3f791c6b0cba@kernel.org

Changes in v5:
- Collect Bartosz ACK
- Switch Kalle->Jeff as maintainer.
- Link to v4: https://lore.kernel.org/r/20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org

Changes in v4:
- Fix review comments from Andy.
- Collect ACKs.
- Link to v3: https://lore.kernel.org/r/20260312-descriptors-wireless-v3-1-5230e0870c31@kernel.org

Changes in v3:
- Rebased on kernel v7.0-rc1
- Fix up issues as pointed out by Michał Kępień
- Link to v2: https://lore.kernel.org/r/20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org

Changes in v2:
- Define all the descriptors directly in the ATH79K
  GPIO driver in case the driver want to request them directly.
- Link to v1: https://lore.kernel.org/r/20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org
---
 drivers/gpio/gpio-ath79.c           | 57 ++++++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath9k/hw.c | 33 ++++++++++++++-------
 drivers/net/wireless/ath/ath9k/hw.h |  3 +-
 3 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 2ad9f6ac6636..85bd994d15d4 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/generic.h>
+#include <linux/gpio/machine.h> /* For WLAN GPIOs */
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
@@ -214,6 +215,56 @@ static const struct of_device_id ath79_gpio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ath79_gpio_of_match);
 
+#if IS_ENABLED(CONFIG_ATH9K_AHB)
+/*
+ * This registers all of the ath79k GPIOs as descriptors to be picked
+ * directly from the ATH79K wifi driver if the two are jitted together
+ * in the same SoC.
+ */
+#define ATH79K_WIFI_DESCS 32
+static int ath79_gpio_register_wifi_descriptors(struct device *dev,
+						const char *label)
+{
+	struct gpiod_lookup_table *lookup;
+	int i;
+
+	/* Create a gpiod lookup using gpiochip-local offsets + 1 for NULL */
+	lookup = devm_kzalloc(dev,
+			      struct_size(lookup, table, ATH79K_WIFI_DESCS + 1),
+			      GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
+	/*
+	 * Ugly system-wide lookup for the NULL device: we know this
+	 * is already NULL but explicitly assign it here for people to
+	 * know what is going on. (Yes this is an ugly legacy hack, live
+	 * with it.)
+	 */
+	lookup->dev_id = NULL;
+
+	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
+		lookup->table[i] =
+			/*
+			 * Set the HW offset on the chip and the lookup
+			 * index to the same value, so looking up index 0
+			 * will get HW offset 0, index 1 HW offset 1 etc.
+			 */
+			GPIO_LOOKUP_IDX(label, i, "ath9k", i, GPIO_ACTIVE_HIGH);
+	}
+
+	gpiod_add_lookup_table(lookup);
+
+	return 0;
+}
+#else
+static int ath79_gpio_register_wifi_descriptors(struct device *dev,
+						const char *label)
+{
+	return 0;
+}
+#endif
+
 static int ath79_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_generic_chip_config config;
@@ -276,7 +327,11 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 		girq->handler = handle_simple_irq;
 	}
 
-	return devm_gpiochip_add_data(dev, &ctrl->chip.gc, ctrl);
+	err = devm_gpiochip_add_data(dev, &ctrl->chip.gc, ctrl);
+	if (err)
+		return err;
+
+	return ath79_gpio_register_wifi_descriptors(dev, ctrl->chip.gc.label);
 }
 
 static struct platform_driver ath79_gpio_driver = {
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index a45351afcf6e..05c95e67a853 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -21,7 +21,7 @@
 #include <linux/time.h>
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/unaligned.h>
 
 #include "hw.h"
@@ -2719,19 +2719,28 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
 static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
 				  const char *label)
 {
+	enum gpiod_flags flags = out ? GPIOD_OUT_LOW : GPIOD_IN;
+	struct gpio_desc *gpiod;
 	int err;
 
-	if (ah->caps.gpio_requested & BIT(gpio))
+	if (ah->gpiods[gpio])
 		return;
 
-	err = devm_gpio_request_one(ah->dev, gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
+	/*
+	 * Obtains a system specific GPIO descriptor from another GPIO controller.
+	 * Ideally this should come from the device tree, this is a legacy code
+	 * path.
+	 */
+	gpiod = gpiod_get_index(NULL, "ath9k", gpio, flags);
+	err = PTR_ERR_OR_ZERO(gpiod);
 	if (err) {
 		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
 			gpio, err);
 		return;
 	}
 
-	ah->caps.gpio_requested |= BIT(gpio);
+	gpiod_set_consumer_name(gpiod, label);
+	ah->gpiods[gpio] = gpiod;
 }
 
 static void ath9k_hw_gpio_cfg_wmac(struct ath_hw *ah, u32 gpio, bool out,
@@ -2791,10 +2800,12 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
 	if (!AR_SREV_SOC(ah))
 		return;
 
-	WARN_ON(gpio >= ah->caps.num_gpio_pins);
+	if (ah->gpiods[gpio]) {
+		gpiod_put(ah->gpiods[gpio]);
+		ah->gpiods[gpio] = NULL;
+	}
 
-	if (ah->caps.gpio_requested & BIT(gpio))
-		ah->caps.gpio_requested &= ~BIT(gpio);
+	WARN_ON(gpio >= ah->caps.num_gpio_pins);
 }
 EXPORT_SYMBOL(ath9k_hw_gpio_free);
 
@@ -2822,8 +2833,8 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
 			val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
 		else
 			val = MS_REG_READ(AR, gpio);
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		val = gpio_get_value(gpio) & BIT(gpio);
+	} else if (ah->gpiods[gpio]) {
+		val = gpiod_get_value(ah->gpiods[gpio]);
 	} else {
 		WARN_ON(1);
 	}
@@ -2846,8 +2857,8 @@ void ath9k_hw_set_gpio(struct ath_hw *ah, u32 gpio, u32 val)
 			AR7010_GPIO_OUT : AR_GPIO_IN_OUT(ah);
 
 		REG_RMW(ah, out_addr, val << gpio, BIT(gpio));
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		gpio_set_value(gpio, val);
+	} else if (ah->gpiods[gpio]) {
+		gpiod_set_value(ah->gpiods[gpio], val);
 	} else {
 		WARN_ON(1);
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index eaa07d6dbde0..d9d2f64c5570 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -19,6 +19,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/firmware.h>
 
@@ -302,7 +303,6 @@ struct ath9k_hw_capabilities {
 	u8 max_rxchains;
 	u8 num_gpio_pins;
 	u32 gpio_mask;
-	u32 gpio_requested;
 	u8 rx_hp_qdepth;
 	u8 rx_lp_qdepth;
 	u8 rx_status_len;
@@ -783,6 +783,7 @@ struct ath_hw {
 	struct ath9k_hw_capabilities caps;
 	struct ath9k_channel channels[ATH9K_NUM_CHANNELS];
 	struct ath9k_channel *curchan;
+	struct gpio_desc *gpiods[32];
 
 	union {
 		struct ar5416_eeprom_def def;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20240122-descriptors-wireless-b8da95dcab35

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


