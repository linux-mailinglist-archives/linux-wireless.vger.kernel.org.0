Return-Path: <linux-wireless+bounces-37815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id syuSLRjYL2o7HwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:46:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6D685709
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37815-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37815-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CC8306D0FE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0D33F38A;
	Mon, 15 Jun 2026 10:43:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CB339708;
	Mon, 15 Jun 2026 10:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520233; cv=none; b=Wjx44uOUfGTiO/ScBM2daqEhP2iMZ4U8YWXHWYI//BwUKdeezdBwW8/d1cmpI7cdd8I69+KW6r79F1tfzm7Cp6IaFRBO+yHw3qks733VD6lwMqRu1CxR3GoIDtB00suL3z0HfyutBPnpeJ3NxKeYjmH64rUIxWRAiApUywcraBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520233; c=relaxed/simple;
	bh=oVfd44ufR+op111XMW1UXh0Dk/Avy9DCMpoW+by1up8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6zf9w9OuO0ugr/TjXFDSh5Y4SxKLIEX/GMLUaJEbqkkssPP0Llz++56hJTFP7yDlJWpfxshz4qShW/zG9shhgGixEb+48gGo4W6AzeDw6lLByT4Vzgxz4JmXXSrJJ33iJlUTmm859M9SfQKzZYUV9B+uecB/UN6xGQxZdlp55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1wZ4ey-0000JJ-00; Mon, 15 Jun 2026 12:35:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id C060CC084D; Mon, 15 Jun 2026 12:33:22 +0200 (CEST)
Date: Mon, 15 Jun 2026 12:33:22 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 05/10] [v2] mips: select legacy gpiolib interfaces where
 used
Message-ID: <ai_U8j3uOoIzoYrJ@alpha.franken.de>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520183815.2510387-6-arnd@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37815-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[franken.de];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:linux-gpio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:arnd@arndb.de,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:khilman@baylibre.com,m:rogerq@kernel.org,m:tony@atomide.com,m:glaubitz@physik.fu-berlin.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linusw@kernel.org,m:brgl@kernel.org,m:dmitry.torokhov@gmail.com,m:lee@kernel.org,m:pavel@kernel.org,m:mazziesaccount@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wireless@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mips@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-leds@vger.kernel.org,m:netdev@vger.kernel.org,m:bartosz.golaszewski@oss
 .qualcomm.com,m:chunkeey@gmail.com,m:dmitrytorokhov@gmail.com,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tsbogend@alpha.franken.de,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tsbogend@alpha.franken.de,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,alpha.franken.de:mid,alpha.franken.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AB6D685709

On Wed, May 20, 2026 at 08:38:10PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A few old machines have not been converted away from the old-style
> gpiolib interfaces. Make these select the new CONFIG_GPIOLIB_LEGACY
> symbol so the code still works where it is needed but can be left
> out otherwise.
> 
> This is the list of all gpio_request() calls in mips:
> 
>   arch/mips/alchemy/devboards/db1000.c:           gpio_request(19, "sd0_cd");
>   arch/mips/alchemy/devboards/db1000.c:           gpio_request(20, "sd1_cd");
>   arch/mips/alchemy/devboards/db1200.c:   gpio_request(215, "otg-vbus");
>   arch/mips/bcm47xx/workarounds.c:        err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
>   arch/mips/bcm63xx/boards/board_bcm963xx.c:              gpio_request_one(board.ephy_reset_gpio,
>   arch/mips/txx9/rbtx4927/setup.c:        gpio_request(15, "sio-dtr");
> 
> Most of these should be easy enough to change to modern gpio descriptors
> or remove if they are no longer in use.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: no changes. There was no discussion on this, but the patch
>     has so far not made it into the linux-mips tree, so I'm including
>     it for completeness.
> ---
>  arch/mips/Kconfig         | 5 +++++
>  arch/mips/alchemy/Kconfig | 1 -
>  arch/mips/txx9/Kconfig    | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

