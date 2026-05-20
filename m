Return-Path: <linux-wireless+bounces-36719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNRaK8AqDmpq6gUAu9opvQ
	(envelope-from <linux-wireless+bounces-36719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:42:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A459B375
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F94438BDEBE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E89402BA4;
	Wed, 20 May 2026 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYem8I5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB63E2AAD;
	Wed, 20 May 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302325; cv=none; b=H2l701+gQPfjylpw504uhLI/x+HXjdfvS7/FPcaQCtk9CKO3+PVNVdo2579NC66fOWZHTDLcVi7HeWgqF3g6bxSmz3s+iD2wilNWlZjnUcvXOLJD2t4WL+QBSxwBpspnADwpxXvNwCy73G+72OiDUkzquzsajkL48wpnn6iCK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302325; c=relaxed/simple;
	bh=juqmQHTyXVjMADRkqpJ2wNnJxOdoGL5J5ccsiNry1Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lA/kdimj8UVCrbZwFX5UNeLhdKzVtqZHARnRnvrowDSioFsMQt8V8PmARkjAA/G9nrZFbAD+G2Qm8MGwjnbc7RZY6asIlpvI8K055KrtMXGq1OumBv5oACl8BNlTRfKUBDG0uRHn3wdFwu4ll86VZnx1+22Vnyakjhy2C3Trtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYem8I5R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98C11F00894;
	Wed, 20 May 2026 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302322;
	bh=QS0tE1jq32RPknCxarjuiggmHwCM4gop6dVAw2uUqDw=;
	h=From:To:Cc:Subject:Date;
	b=SYem8I5RC86MwvWdXWsQ6Bgp8A0iXFMrU82tSaGTwlAWevRvRw1mI4fgTiw71nwGG
	 TpYCkhihg/FcTxYWvLebVRpcmccAb0QIlJ3Erhm9eoYNL6hgSPDhwpiMfthUWOs+N7
	 uDOqvOlJsj2qn4Mk9FgQR4RHeTbdGZgKjUqsRfrhRpKCLo4wVyWkBbRw7XKIDZNWN3
	 xb+Su0YEq8Wc0mkirG4tIO7DN2LSICbOX1+H4BSK/0RdNlDIcIh6ctwgOUK3qvD3Ui
	 o3sIJMY3PRuZCc3JVv1k5+w+a6JkVb3X+rJGutoWUld3hRXgrt8cUvFy8ei5dLVjx9
	 qD/v5u29/g+eA==
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
Subject: [PATCH v2 00/10] gpiolib: fence off legacy interfaces
Date: Wed, 20 May 2026 20:38:05 +0200
Message-Id: <20260520183815.2510387-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36719-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 484A459B375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

This is an update of all the patches that are still required before
we can actually turn off CONFIG_GPIOLIB_LEGACY for most platforms
in the final patch of this series.

I originally posted this as a series in
https://lore.kernel.org/all/20250808151822.536879-1-arnd@kernel.org/

I added more patches for the p54spi driver that I had originally
sent separately and submitted the remaining ones separately to
the subsystem maintainers, with about two thirds getting picked
up so far.

If possible, please apply the patches to the respective
architecture (mips, sh, x86, soc/omap) or subsystem
(wireless, net-next, led, input) trees.

      Arnd

Arnd Bergmann (10):
  [v2] [net-next] net: dsa: b53: hide legacy gpiolib usage on non-mips
  [v3] input: gpio-keys: make legacy gpiolib optional
  [v2] x86/olpc: select GPIOLIB_LEGACY
  [v2] sh: select legacy gpiolib interface
  [v2] mips: select legacy gpiolib interfaces where used
  [v4] leds: gpio: make legacy gpiolib interface optional
  [v6 net-next] dt-bindings: net: add st,stlc4560/p54spi binding
  [v6 net-next] p54spi: convert to devicetree
  [v6 omap] ARM: dts: omap2: add stlc4560 spi-wireless node
  gpiolib: turn off legacy interface by default

Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: netdev@vger.kernel.org

 .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/ti/omap/omap2.dtsi          |  4 ++
 .../dts/ti/omap/omap2420-n8x0-common.dtsi     | 12 ++++
 arch/arm/mach-omap2/board-n8x0.c              | 18 -----
 arch/mips/Kconfig                             |  5 ++
 arch/mips/alchemy/Kconfig                     |  1 -
 arch/mips/txx9/Kconfig                        |  1 +
 arch/sh/Kconfig                               |  1 +
 arch/sh/boards/Kconfig                        |  8 +++
 arch/sh/boards/mach-highlander/Kconfig        |  1 +
 arch/sh/boards/mach-rsk/Kconfig               |  3 +
 arch/x86/Kconfig                              |  1 +
 drivers/gpio/Kconfig                          |  9 ++-
 drivers/input/keyboard/gpio_keys.c            |  7 +-
 drivers/input/keyboard/gpio_keys_polled.c     |  2 +
 drivers/leds/leds-gpio.c                      | 51 +++++++++-----
 drivers/mfd/rohm-bd71828.c                    |  1 -
 drivers/mfd/rohm-bd718x7.c                    |  1 -
 drivers/net/dsa/b53/b53_common.c              | 17 ++---
 drivers/net/dsa/b53/b53_priv.h                | 25 +++++--
 drivers/net/wireless/intersil/p54/p54spi.c    | 67 +++++++------------
 drivers/net/wireless/intersil/p54/p54spi.h    |  3 +
 include/linux/gpio_keys.h                     |  2 +
 include/linux/leds.h                          |  2 +
 sound/pci/Kconfig                             |  1 +
 26 files changed, 201 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

-- 
2.39.5


