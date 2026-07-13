Return-Path: <linux-wireless+bounces-38996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZHwOqBfVWoWngAAu9opvQ
	(envelope-from <linux-wireless+bounces-38996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FF74F620
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FLJoZXDs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38996-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38996-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F34D308834D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6862371CE9;
	Mon, 13 Jul 2026 21:58:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8936F8F0
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 21:58:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979911; cv=none; b=oGYxaC4KdTX9T/stGR8b5fWDbqiRI/eH91tIL5H1EgIgadW/JzZ18DnGKlz6SPTiOUsITIHljyh2YpAwZL0km4/Y5AVKhpM4QD/FlzhT8cJixAwHoGepe70tvKOYigtgZJaNrDnwHGgzZuFPTT7xVHzzr9j6qE6pvPg722yHH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979911; c=relaxed/simple;
	bh=YrpLPHBD1J0GQmK89CSL4Gy6M2t6Tszp23YYmEbriXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCD85DWnuw1v84zpmlG/XVGjM2qBMdmZaDQ9zfWQI97VW/a/YwogQmjDaC6C7VxWAP7pXHX4jXB5/rVfenpkXwm8vZvnyX4XcBcTtcHEMYNpfyLsjl79ec7+fyGPDpRNJHtLO+TTsfplPbZ4jy7q0n1AEL71j6+2qO5+52h1N6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLJoZXDs; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2628478a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979910; x=1784584710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTIRIedZIUsEUdvn5iYSlLCj+0D+t4h6dGSrNv3pQhE=;
        b=FLJoZXDsHXormQvcGyNUwHqCd2us6Mc0xgZbuXQzgR04iaGtAX7mC06+dPiq4lYrB2
         s6y2QnIDQarcKFE+B7ttPILoH24AGykVYxsNWtaBlPpz4zlKBwCNP0NrcwuTuFonAONa
         CmgMtlh9lnJfTU+kB7Q7gsRPFbgUNvvucEMzXdTU+dPK+TQi94z1h8gyl4vET0Qrpwbv
         PgDuR2U2yTtbghqNRSpCuvtarln1DPvYE7UOsQd1BGH3UsqPTSydlbvxUR5RrcCsMgTX
         SJTbXkeBIX83U4P8kQYKVwBmobZzdm3NMrxSTpRENylni86CQhNHTm/aDx+AEd+4SZ+c
         LuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979910; x=1784584710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTIRIedZIUsEUdvn5iYSlLCj+0D+t4h6dGSrNv3pQhE=;
        b=dZVHt1PhLOFpg99fe0Eogjjx7WkDMlna4pXLNFIyyOCtdHx4P+soTnie1x2wpLbQlk
         /sg9ipQ0thz2TaD7IB25f8K7iTzUZKMQOZ7grirAMDvNBGuPdvN+7K8WUtyXhTVlgZo/
         BsWPkjFN0wYbfx0T5Hl4gfTvHXFkCHs5Y4IimVb7PLKuCZxDgMMD1jfang10qIZwtozG
         TK5hJhKP+fZwD6mwHo7R5k3zIvRcUbNnpRbOT2egi+u3c8eoIVDNwoFV+Au/dnlOAaBd
         smJsfQkqsTNiRX5t88C1pXxHAGzxJafW8hRZShs244W5CSa64kgm32W3P8NVeldASZII
         Dnhg==
X-Forwarded-Encrypted: i=1; AHgh+RqHtLOI1ria2nV6f+TZ9Hp8VqHqrbBT9/50/ol+zsGX4GJv3l+vS8JcJ9rocwLLh0H6DEYvvTw5WAbEo0x72Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CAm83NTJYAa8bE9JyqeNKLXmWctC+pHo8brO/q2DRwZbvKwB
	DrW3NTwi2U9dHmrC31CarVDSl+t/6f9vxutvzdnmcwmIP/WQBtv9dlxm
X-Gm-Gg: AfdE7clOceOA8CIP8PF6DgzLMgoEK9WbfAzFpfeKxCmS2KoV8qKSDXPFmA0iKnDIaBt
	/o4jDvGXCqvBuVhhIQf086PrzCLlz8+KKibwxVyUO9Z71Vw6OeJWx5e411XKyAiN/QtHpVayyiY
	11mlL6Yi+BI/CdhPdUQPd4sP/NDAIO+S7IlOfQ41tJzBn8Uru4nvSpXB9Rq8jMW/kwyAIH0ICHM
	yFaMWfAm9e9iTJqYQrao1eAEpoX+Puqjd/pnL8p7uBikQmlz1Ab/1A4ctMwWh0Q+GqHzOdHn1Z7
	MttGdpw26ijclcGwRE8f+e5ELep84ednYjF/Z8i62fi57dv/0eBE14mBe0+ZXWm/vlgbDMfMDXD
	HUqqqqWevuvDPmHq4ZD7SXnYIZ8oMkTl0QzhqkR5sU5mw5uIoMs+c2d0lGTWZ/oQrVqVwlFBj3w
	yt3LnXweh638lzaitMB99u/xsEKK7Pu/IqmRfqpFcKHyS4HG0Fwkq4FIJueQPDrPIonbrSfyMBi
	t2l
X-Received: by 2002:a05:6a20:5491:b0:3a0:b781:4c78 with SMTP id adf61e73a8af0-3c11003090dmr14016770637.15.1783979909685;
        Mon, 13 Jul 2026 14:58:29 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm28371487c88.4.2026.07.13.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:58:28 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 14:58:22 -0700
Subject: [PATCH v2 1/3] bcma: gpio: Add and register software node for GPIO
 controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-bcm47xx-swnode-v2-1-2b879f0c193c@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38996-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 916FF74F620

We want to convert the legacy gpio-keys platform device on BCM47XX
boards to use software nodes. To do this properly and allow
referencing the GPIO controller by address rather than relying on
name-based matching (which is being removed from the gpiolib core),
we need to associate the GPIO controller with a software node.

Introduce bcma_gpio_swnode, register it if the device does not
already have a firmware node, and associate it with the gpio_chip.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/bcma/driver_gpio.c | 43 +++++++++++++++++++++++++++++++++++++------
 include/linux/bcma/bcma.h  |  2 ++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 658c7e2ac8bf..ea45222f2fa0 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -19,6 +19,11 @@
 
 #define BCMA_GPIO_MAX_PINS	32
 
+const struct software_node bcma_gpio_swnode = {
+	.name = "bcma-gpio",
+};
+EXPORT_SYMBOL_GPL(bcma_gpio_swnode);
+
 static int bcma_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
 	struct bcma_drv_cc *cc = gpiochip_get_data(chip);
@@ -190,7 +195,20 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
 	chip->parent		= bus->dev;
-	chip->fwnode		= dev_fwnode(&cc->core->dev);
+
+	/*
+	 * Register software node only for the host SoC bus, unless there is
+	 * already a firmware node assigned. There is only one SoC instance
+	 * in the system, so there are no concerns with registration conflicts.
+	 */
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC && !dev_fwnode(&cc->core->dev)) {
+		err = software_node_register(&bcma_gpio_swnode);
+		if (err)
+			return err;
+		chip->fwnode = software_node_fwnode(&bcma_gpio_swnode);
+	} else {
+		chip->fwnode = dev_fwnode(&cc->core->dev);
+	}
 
 	switch (bus->chipinfo.id) {
 	case BCMA_CHIP_ID_BCM4707:
@@ -219,20 +237,33 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 
 	err = bcma_gpio_irq_init(cc);
 	if (err)
-		return err;
+		goto err_unregister_swnode;
 
 	err = gpiochip_add_data(chip, cc);
-	if (err) {
-		bcma_gpio_irq_exit(cc);
-		return err;
-	}
+	if (err)
+		goto err_irq_exit;
 
 	return 0;
+
+err_irq_exit:
+	bcma_gpio_irq_exit(cc);
+err_unregister_swnode:
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC &&
+	    chip->fwnode && is_software_node(chip->fwnode)) {
+		software_node_unregister(&bcma_gpio_swnode);
+		chip->fwnode = NULL;
+	}
+	return err;
 }
 
 int bcma_gpio_unregister(struct bcma_drv_cc *cc)
 {
 	bcma_gpio_irq_exit(cc);
 	gpiochip_remove(&cc->gpio);
+	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC &&
+	    cc->gpio.fwnode && is_software_node(cc->gpio.fwnode)) {
+		software_node_unregister(&bcma_gpio_swnode);
+		cc->gpio.fwnode = NULL;
+	}
 	return 0;
 }
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index f02cb3909375..17fc50190014 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -486,4 +486,6 @@ extern u32 bcma_core_dma_translation(struct bcma_device *core);
 
 extern unsigned int bcma_core_irq(struct bcma_device *core, int num);
 
+extern const struct software_node bcma_gpio_swnode;
+
 #endif /* LINUX_BCMA_H_ */

-- 
2.55.0.795.g602f6c329a-goog


