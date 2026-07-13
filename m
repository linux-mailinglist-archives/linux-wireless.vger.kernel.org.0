Return-Path: <linux-wireless+bounces-38997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAlmN4xfVWoRngAAu9opvQ
	(envelope-from <linux-wireless+bounces-38997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC3874F609
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WoY2M2oL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38997-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38997-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 111083019FD3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE6370ADA;
	Mon, 13 Jul 2026 21:58:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA9371D13
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 21:58:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979913; cv=none; b=CWVd50fFkN3rElFBRex6IDpLeqxwxUFcYMHSGV0Y6foBJleKou62mJeKs5IHcPmeHHQrM4zVRejz7+IfU++UfefXj6WlaKJC4u09BA57KV+GOIRgaOSXuh4eE0ugcvJH3HjsZe4En1PLRIhAbOhOFL3D9wKWkKaO/HiLk6xDGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979913; c=relaxed/simple;
	bh=29e1zWLx7tR8NGQ6MXjQX3b25i7ejmmUrpbreYdw5K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWGOaCN2okADnVIdgjdlRAmP9WGnyFZusEU+7cCwJTwlB8e+qfkmunAu76JQ1FqCTzEue0YWrw1aIZR8fhc/OCXvgFAsL6iersAsf99XlPXvd/VrAzX7gjuVfKWgOj36KsdA7CaS22AiB7s3x/LQGdxwK6/lix1szN8aPrwkt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoY2M2oL; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca913a601fbso2495910a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979911; x=1784584711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlMUdZeGBVP+uq5JMmWJnIlIlnx5G6dUdNZ/G/e6M0A=;
        b=WoY2M2oL+xzXzZYOLyobN3ZtXeyafQHO/uTae8rIaFGhY0vrj6Q88PO22a3YDops1Y
         OVwk3UaUEd4vbBveo24CRaufEOtxYYM2mbKzJE1mzBdn7Kwrquzjnm7OUyxbSjiLs2Dg
         tVsIlmPuRqwyezR9jwf+xqnAqp4JmZ9NQp7tLFBuy6nBH345gfiGTEssRerdtlYsB6si
         S2ZGUzsO8clsTnQDbV7B1OAimTrDYiiFN9xZxzBsWUvNAGS3XOaDz/sTms9OYX2EITM4
         iG0it9T9OYtWPphWL1RtZzmgE2ZN8hC3U4ZHXDLfD7YgVlFvGdJ4tsXCbqlfgZiSERoN
         2Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979911; x=1784584711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RlMUdZeGBVP+uq5JMmWJnIlIlnx5G6dUdNZ/G/e6M0A=;
        b=QGR1RK90LO1Pn61IctTsz0hLdKuij782mZcq8wgoyR7Uqf6QbedqEKYq0qDOlw5CJg
         7dIABva3zoOnZozGUfyaXcyNBrtQGNpHOpke9Ac8axoVIKg3o/fQF1PF8ePkG2V7KViz
         A9ECPy5HPZ/Y50Et/XiaxR5bHL+Gc9MpXWGUiNy3YdyCQB+OdLiCOx+k++R/y7Vhw1Ha
         fqRanRq8vmIbtf936PFXd9nkDH1IY7Hkm+TZsBx5tHDWPcq8rBYW1Whjxotf9WRawmy7
         zZlR3ho1mOwNbLudpNXuRWycg2QZYx3PuXYaEeA3pthGtLSoVIvQ4GqahhFkMZhn3X+s
         SewQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTlsZdvbygLu9pDL4XqmXqElCvmG5LWMPkvpJWi6XQ/1rNhZ6uF/VESZ0OCzcWuDUXFQ31cO8MeIUCkcRRhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1rH48VqCtyj8llTw0u8nER2BpyEa+p6vh91JdWoppHHVT+vW
	jKDa7FENKTDNuz9NlNF7dxiHLmTPC8o1apFIDXM1lH0PMM4SPIKw1foL
X-Gm-Gg: AfdE7cnlbntjM8EvAxplNrc1lDeYekQJ/jjFdw6Vs5KE+Hy24GDnCZyAMlaDAoo3kLk
	2/cuKmqGnluHKrMxivYc0TQzQUgnruOjaEjz4nUTppSXrWJipkHGPx3HmmXmy7RhNJhKU5ccOTQ
	B+B8joyKxqFaTKTtV3t+nYVYzfHrMGR3wo6NIGvOQnRWcfGKlF7LeGbM/VRAAK+uoJQmJ7oxr+z
	4AowJKWmG3NOj6ZOxqd/NDRVZwcuAVymidqvRJupafIOnaWlP+LqasYUZpzf0Jp/6AdT8Y4OOk1
	hFvE+E6gDpaEWGBZABNmz8ULxAqXucGYDflqr3DRcyF80GNppItOba0nwdTCzNVyX9A4M5pptYg
	zeFwqFyeKJAp+s1BsmvKvecX54ZvJg/CCS5Al4AEkVi0UBxb+aiL586rSzcvy4FAOgVLlR+CTzR
	psg184SAUyyeItB9GU6zhx5hU6EKFZKwX5DCWGYglW+ejRR/q8TN6keCcU6mPr/4MPs82iffQMc
	6UGnrOyTePt0h0=
X-Received: by 2002:a05:6a21:4c08:b0:3bf:d1f9:b1d9 with SMTP id adf61e73a8af0-3c110ba2a1amr10746536637.57.1783979911168;
        Mon, 13 Jul 2026 14:58:31 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm28371487c88.4.2026.07.13.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:58:30 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 14:58:23 -0700
Subject: [PATCH v2 2/3] ssb: gpio: Add and register software node for GPIO
 controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-bcm47xx-swnode-v2-2-2b879f0c193c@gmail.com>
References: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
In-Reply-To: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38997-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAC3874F609

We want to convert the legacy gpio-keys platform device on BCM47XX
boards to use software nodes. To do this properly and allow
referencing the GPIO controller by address rather than relying on
name-based matching (which is being removed from the gpiolib core),
we need to associate the GPIO controller with a software node.

Introduce ssb_gpio_swnode, register it, and associate it with the
gpio_chip.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/ssb/driver_gpio.c | 48 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/ssb/ssb.h   |  2 ++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 905657c925bc..87922479946c 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -15,8 +15,14 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/export.h>
+#include <linux/property.h>
 #include <linux/ssb/ssb.h>
 
+const struct software_node ssb_gpio_swnode = {
+	.name = "ssb-gpio",
+};
+EXPORT_SYMBOL_GPL(ssb_gpio_swnode);
+
 
 /**************************************************
  * Shared
@@ -232,6 +238,8 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->to_irq		= ssb_gpio_to_irq;
 #endif
 	chip->ngpio		= 16;
+	if (bus->bustype == SSB_BUSTYPE_SSB)
+		chip->fwnode	= software_node_fwnode(&ssb_gpio_swnode);
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
 	 * a random base number.
@@ -433,10 +441,12 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	 * deterministic to address them more easily. The other buses could get
 	 * a random base number.
 	 */
-	if (bus->bustype == SSB_BUSTYPE_SSB)
-		chip->base		= 0;
-	else
-		chip->base		= -1;
+	if (bus->bustype == SSB_BUSTYPE_SSB) {
+		chip->base	= 0;
+		chip->fwnode	= software_node_fwnode(&ssb_gpio_swnode);
+	} else {
+		chip->base	= -1;
+	}
 
 	err = ssb_gpio_irq_extif_domain_init(bus);
 	if (err)
@@ -464,11 +474,33 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 
 int ssb_gpio_init(struct ssb_bus *bus)
 {
+	int err = 0;
+
+	/*
+	 * Register software node only for the host SoC bus. There is only
+	 * one SoC instance in the system, so there are no concerns with
+	 * registration conflicts.
+	 */
+	if (bus->bustype == SSB_BUSTYPE_SSB) {
+		err = software_node_register(&ssb_gpio_swnode);
+		if (err)
+			return err;
+	}
+
 	if (ssb_chipco_available(&bus->chipco))
-		return ssb_gpio_chipco_init(bus);
+		err = ssb_gpio_chipco_init(bus);
 	else if (ssb_extif_available(&bus->extif))
-		return ssb_gpio_extif_init(bus);
-	return -1;
+		err = ssb_gpio_extif_init(bus);
+	else
+		err = -ENODEV;
+
+	if (err) {
+		if (bus->bustype == SSB_BUSTYPE_SSB)
+			software_node_unregister(&ssb_gpio_swnode);
+		return err;
+	}
+
+	return 0;
 }
 
 int ssb_gpio_unregister(struct ssb_bus *bus)
@@ -476,6 +508,8 @@ int ssb_gpio_unregister(struct ssb_bus *bus)
 	if (ssb_chipco_available(&bus->chipco) ||
 	    ssb_extif_available(&bus->extif)) {
 		gpiochip_remove(&bus->gpio);
+		if (bus->bustype == SSB_BUSTYPE_SSB)
+			software_node_unregister(&ssb_gpio_swnode);
 		return 0;
 	}
 	return -1;
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 7fee9afa9458..67cb66f6f5ed 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -671,4 +671,6 @@ int ssb_pcibios_plat_dev_init(struct pci_dev *dev);
 int ssb_pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 #endif /* CONFIG_SSB_EMBEDDED */
 
+extern const struct software_node ssb_gpio_swnode;
+
 #endif /* LINUX_SSB_H_ */

-- 
2.55.0.795.g602f6c329a-goog


