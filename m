Return-Path: <linux-wireless+bounces-36729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJQAJbMcDmro6AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 22:42:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A0599F79
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED55A3387FF2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE947D92F;
	Wed, 20 May 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxJsYXWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55E400E1D;
	Wed, 20 May 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302408; cv=none; b=jISA3eoemvuUIbfeM7cdhnQdmWUBXKTGiBAqGDYb16SwOHaJiLDefYJenj+lWtFfZQ0ZmCWAKo2PHHPD8yz5Jjh2lLqlZHX+EviNVxsNlNhF9z2GVa74uFdVvTI2XCBknprq4WS/7bF3nXwjravE3hqeH/6PCdA2DzW4d+SXdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302408; c=relaxed/simple;
	bh=DkSZfXOAffCCtFwAjz7g6qmQiQIlMDMjpPdApHgp6TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRUFecsEeEN3IRyBst/STNE6jz0/pjXzZ0VUsVFNPlAml3p/3WAUUN/8QzuiwiOAVLEfVyqHdGU7sZxTlA9YBZjd6d+YntRmgytd0/4K0nggH94BAWskBAwzoy5hcs9L8UiQR7VQwi5T/0OyEIe/6dZ+yr5XJbZ+JuS++Q8cmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxJsYXWd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B121F0089A;
	Wed, 20 May 2026 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302406;
	bh=02+6d8dOXhR9E+F29QDQjM2pWkqHo3wDZDJjMa+yUu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TxJsYXWdfmza+UhP3R5pB3RwB3VkdHYGSwnVCeXIfZWjcwPv5hyYy1pozAEtav9zc
	 ST23wnlxbaQNSejo3rEHwIRi3+Vsb+rGxZgXDu6Wg2SRyCm1gKgYG9kyT1s0+eLdMh
	 jLq+3jUpE8uIKfQfhWYcZI1RUu3KhaTsvYTa7fcRh4jeGeHIn1KWH1IQXk1A+GPle+
	 /fk//MJVx/io/TegeiPOyqkC6PuFHo2UABrmL27yz5Omg47Zm8XFMz0oUKynX/ZKE6
	 XwChghHVCC5r3gWZlyQSDgbWCdunVnBYtGrwFl8Zgn+l6bnK9CSl/JfztXE0nTPRKy
	 fbtvXvNZAq/IQ==
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
Subject: [PATCH 10/10] gpiolib: turn off legacy interface by default
Date: Wed, 20 May 2026 20:38:15 +0200
Message-Id: <20260520183815.2510387-11-arnd@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36729-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B9A0599F79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
so it can be turned off by default and only get built on platforms
that still have one unconverted driver.

Allow turning it on manually for compile testing, in order to keep
the build coverage of the legacy drivers in allmodconfig and
randconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

This patch depends on patches 1 through 9 to be applied first.

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 00fcab5d09a4..eec17089eaa6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config GPIOLIB_LEGACY
-	def_bool y
+	bool "Legacy GPIO interfaces" if COMPILE_TEST
+	help
+	  There are a few legacy platforms that use the traditional GPIO
+	  number based interfaces instead of GPIO descriptors.
+	  Say Y here to enable build testing drivers that are specific
+	  to those platforms.
+
+	  If unsure, say N.
 
 config HAVE_SHARED_GPIOS
 	bool
-- 
2.39.5


