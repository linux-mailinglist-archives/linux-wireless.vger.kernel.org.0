Return-Path: <linux-wireless+bounces-36722-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAXeH20CDmra5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36722-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:50:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B835974AE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADC2B314B8A5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F343CEF2;
	Wed, 20 May 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKpc212v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAC43C047;
	Wed, 20 May 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302349; cv=none; b=DEizNhStvKOXNRK0UDwPxb+dwUdTae6pwAvSOI5OQ3MvSDPTTVhs50z2+isFJBARecHWNLySDn9Qf9+iqrjIXF6glxRIaQ5e9ufv2H65Dnyhni1QnS+DfPv4WoJOPKOXH4tx59o78D5ovgPzD3TMTTZhopPSOFO2I8716ky1U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302349; c=relaxed/simple;
	bh=967F8hrVOnB4Hww9rm86dUaEzAI2OE1eBN0raABGfak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RME38Zf2WqUoytN5Ilc5Ejw4iS9+sT4glo/CbC4b0mqewv2BSQfdxUhuwWgnOt7bQMblDgks48W3cTq8ID/hXcidONRYFrj7SJMtQ60e/7fksqJcuOA/iZWGUAboftlFwR2hSWQifq9jz/4nQW0wZz+t9ixqoaQWpmD8NzbMeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKpc212v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A241F0089A;
	Wed, 20 May 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302347;
	bh=zBKnbJ1ea1Z90t+GzmUXY9pAo9IwWEqoCQVtXT4GR4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HKpc212v1htgkd2muuhHOLKo7sEU0dSVAxRvPcXa/MBPcSliJPv7GUDyfwo3U4Htk
	 GvzDJofIJw75L/nBdmuwi+uS/dbsuBQR3R4HdtjmjO3FoDWGtsSw+U61bhyFu4n2qE
	 bUVMbBgBCE1iEh6PuFZs1CxOT4IN6AdO39k2B9JrXaJmTJCdv46yqqkKaSqimAy29e
	 MmP3HotLS6MdZBB6cczDXlQlmIiPhXZAx74SWcH8Vx5+YlJPWXbzN2eYRBMpiZLOOH
	 ajeAbHFeh9chkBiAAl/RN+Uqx7xvkaCRP/WKdkZ3pJVCEsw9jt/eEtbzXQaVE2aX58
	 e5h/8CVaLx9lA==
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
	Takashi Iwai <tiwai@suse.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 03/10] [v2] x86/olpc: select GPIOLIB_LEGACY
Date: Wed, 20 May 2026 20:38:08 +0200
Message-Id: <20260520183815.2510387-4-arnd@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-36722-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org,suse.de,oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,arndb.de:email,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 40B835974AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The OLPC GPIO controller sets up a fixed number space that is used
by at least two drivers:

arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'setup_ec_sci':
arch/x86/platform/olpc/olpc-xo1-sci.c:358:13: error: implicit declaration of function 'gpio_request' [-Wimplicit-function-declaration]
  358 |         r = gpio_request(OLPC_GPIO_ECSCI, "OLPC-ECSCI");
      |             ^~~~~~~~~~~~
sound/pci/cs5535audio/cs5535audio_olpc.c: In function 'olpc_analog_input':
sound/pci/cs5535audio/cs5535audio_olpc.c:41:9: error: implicit declaration of function 'gpio_set_value'; did you mean 'gpiod_set_value'? [-Wimplicit-function-declaration]
   41 |         gpio_set_value(OLPC_GPIO_MIC_AC, on);

The AMD Geode platform that this is based on is now marked as
'Orphaned' in Kconfig, and it is likely that there are no XO1
users on modern kernels, but so far there is no consensus on
removing it entirely.

Select CONFIG_GPIOLIB_LEGACY for this platform and make sure the
sound driver portion cannot be compiled without this.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: update changelog text
---
 arch/x86/Kconfig  | 1 +
 sound/pci/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f24810015234..69089d2f5dad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2978,6 +2978,7 @@ config OLPC
 	bool "One Laptop Per Child support"
 	depends on !X86_PAE
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select OF
 	select OF_PROMTREE
 	select IRQ_DOMAIN
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index e0996a9d90b0..6366f72b3667 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -300,6 +300,7 @@ config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
 	depends on X86_32 || MIPS || COMPILE_TEST
 	depends on HAS_IOPORT
+	depends on GPIOLIB_LEGACY || !OLPC
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
-- 
2.39.5


