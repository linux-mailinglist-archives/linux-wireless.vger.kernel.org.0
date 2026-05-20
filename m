Return-Path: <linux-wireless+bounces-36724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJMyEHMDDmqs5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:54:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D91597616
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B8623236E89
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6B3FE646;
	Wed, 20 May 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLCEdIhj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483E3D1CA0;
	Wed, 20 May 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302365; cv=none; b=Q9IVCFAaT4vPnB70IQPB7NZecvAY/NeREe70i7T/tGqTS1uyzcIH7bKOankTGAU1FJC8dcjKfOQxy8/z+Ey5k5FUlBOkGtW1uTm6vCDDGcnwYt1AopIj8+1F5FefXP560HIWx9g5WK4L6Ns7uUYPApG09hP9hRV2lzcNj1+P/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302365; c=relaxed/simple;
	bh=1rBsdHO5ii6LAwx4TaDAiy+62lktJt4MM8CtSkPPwkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmZasYugYRtPqcm7WisfjcXjPofjV8s8RrlLzgNi6m6C90EccMbpYNMRDF9nyQBfDhhTizofZKQuYg9uS/58Q546o9lQisrVjib80tRp/1RsKOp/DNy+nXvNf+no42syvOAwjycOgK1WCUZR09xmzQkRh5ICKKas7yx31bcSSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLCEdIhj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8921F0089D;
	Wed, 20 May 2026 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302364;
	bh=TV0+qdcdmk/5gJ3OGKgI5SQDH91h3lWhZ4d8lGRbL9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLCEdIhj+ggOrppkcYTTrQNTM5KqIoCtxO1KENxrD+9U8PWht6Vy6TAMPqqiknlxb
	 6a1MobDRSDwonLHkb8k6hipwd6d7okdssLui9BmALeqBm36GRhcBjxVXezpAYhtc3P
	 nMTGo+V4DYSSFLuRGdYBj4xSWfM8HAPTM0kpSBxtn78GbWehT1cK1V9zzYmqM/FNKE
	 Or49PD8deMVtSMSljqB0Zu+RaI7Rj2FQRkH4sZHZtZ/lBsn3Z0sAfD84FsIflSjV5l
	 nTzEA0Jh7v/sS3RlFlLhW2mz5htjnN1eTc3joHVAhGl7tXJh8xU5n1O9t7dhqWVbHO
	 MfjrowIjjlgwg==
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
Subject: [PATCH 05/10] [v2] mips: select legacy gpiolib interfaces where used
Date: Wed, 20 May 2026 20:38:10 +0200
Message-Id: <20260520183815.2510387-6-arnd@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36724-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,arndb.de:email]
X-Rspamd-Queue-Id: F3D91597616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

A few old machines have not been converted away from the old-style
gpiolib interfaces. Make these select the new CONFIG_GPIOLIB_LEGACY
symbol so the code still works where it is needed but can be left
out otherwise.

This is the list of all gpio_request() calls in mips:

  arch/mips/alchemy/devboards/db1000.c:           gpio_request(19, "sd0_cd");
  arch/mips/alchemy/devboards/db1000.c:           gpio_request(20, "sd1_cd");
  arch/mips/alchemy/devboards/db1200.c:   gpio_request(215, "otg-vbus");
  arch/mips/bcm47xx/workarounds.c:        err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
  arch/mips/bcm63xx/boards/board_bcm963xx.c:              gpio_request_one(board.ephy_reset_gpio,
  arch/mips/txx9/rbtx4927/setup.c:        gpio_request(15, "sio-dtr");

Most of these should be easy enough to change to modern gpio descriptors
or remove if they are no longer in use.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: no changes. There was no discussion on this, but the patch
    has so far not made it into the linux-mips tree, so I'm including
    it for completeness.
---
 arch/mips/Kconfig         | 5 +++++
 arch/mips/alchemy/Kconfig | 1 -
 arch/mips/txx9/Kconfig    | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4364f3dba688..b91e62d69a5d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -206,6 +206,8 @@ config MIPS_ALCHEMY
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
 	select DMA_NONCOHERENT		# Au1000,1500,1100 aren't, rest is
+	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select MIPS_FIXUP_BIGPHYS_ADDR if PCI
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -307,6 +309,7 @@ config BCM47XX
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select LEDS_GPIO_REGISTER
 	select BCM47XX_NVRAM
 	select BCM47XX_SPROM
@@ -330,6 +333,7 @@ config BCM63XX
 	select SYS_HAS_CPU_BMIPS4380
 	select SWAP_IO_SPACE
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select MIPS_L1_CACHE_SHIFT_4
 	select HAVE_LEGACY_CLK
 	help
@@ -999,6 +1003,7 @@ config MIKROTIK_RB532
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select MIPS_L1_CACHE_SHIFT_4
 	help
 	  Support the Mikrotik(tm) RouterBoard 532 series,
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 6ca81e1bd35c..cf5ad52c0a0f 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -12,7 +12,6 @@ config MIPS_MTX1
 
 config MIPS_DB1XXX
 	bool "Alchemy DB1XXX / PB1XXX boards"
-	select GPIOLIB
 	select HAVE_PCI
 	select HAVE_PATA_PLATFORM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 7335efa4d528..92b759a434c0 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -37,6 +37,7 @@ config SOC_TX4927
 	select IRQ_TXX9
 	select PCI_TX4927
 	select GPIO_TXX9
+	select GPIOLIB_LEGACY
 
 config SOC_TX4938
 	bool
-- 
2.39.5


