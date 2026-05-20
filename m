Return-Path: <linux-wireless+bounces-36734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FJ4EA4sDmr87gUAu9opvQ
	(envelope-from <linux-wireless+bounces-36734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:47:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A259B4E9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37FEC304508D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A72390991;
	Wed, 20 May 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Nye50udS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F209376475;
	Wed, 20 May 2026 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313628; cv=none; b=UCOrq2EEHSCJegpTcTO9Fy8omvvZle2ZRS1+YnlUQeVQdmCqrMiuHgrbR4cHOLerXprNj29lHVe1n06xIhbIKKC2tAr7ky7kRIooHyKql386WICdz5BLVev1Hd36Y4snAPaAsN9Fa81rCMn4Nn1vhUT92fLOvASTNF7UHnagj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313628; c=relaxed/simple;
	bh=hfnRN4d9KM/XNVO/xJ/N5pb00q0Pfa7q5hAv9ek8wx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYeaDI5DG5FSOjDQilbMUeblMk3dhInyyx0V2nbu2kgUkFDf/8YFkrRlCXtGR93G/ThaPRoQDM7yXNKpKLvc/W1g++ddmU9saqCgW1qtjnKfIzV7PEfYHsjnW4axyRgaXIvZpJi1Dr4Y3/8Abc2OE+oVzctYmDGpZVi44Nmy7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Nye50udS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lqFsUI2+he6aDFO+JHJcddqbluM1re8BxjczmtcwsYU=; b=Nye50udS3+S16QKqPmqjLGkZGZ
	P4ZC1dR5vf/b552eDSWCdh4s9yL7Rw+8GDSV4Gh/udyebqupg0yQ3qLFBf0k9XEKrIwqpOiCsFhl3
	AUfegZ5TlKFTS8fRpdxUsujDU5EIHFm/G7dJ7pJu1mCbwciR5F+PsWhHDb4K2XIhQdCNix284xznX
	uSo1zfxQm9vlncrXn/3FCVQeMz1yOkKvjR8bqWsxT0G3Hd7rb9YYRis1nRnQ97VIPBMSmqAeCUvd3
	+xuG1xxOa8rIYmDapZZtncXV7MQj3u9KWslfjrZDA11t01cHCCOSuVNfRQeb3nvWEoJVzVBAWth/r
	SdoFPTMA==;
Date: Wed, 20 May 2026 23:46:27 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Christian Lamparter <chunkeey@googlemail.com>, Johannes
 Berg <johannes@sipsolutions.net>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>
Subject: Re: [PATCH 09/10] [v6 omap] ARM: dts: omap2: add stlc4560
 spi-wireless node
Message-ID: <20260520234627.3cd83158@kemnade.info>
In-Reply-To: <20260520183815.2510387-10-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
	<20260520183815.2510387-10-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36734-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kemnade.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 022A259B4E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 20:38:14 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Converted from the platform_device creation in board-n8x0.c.
> 
> Link: https://lore.kernel.org/all/20230314163201.955689-1-arnd@kernel.org/
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v6: no changes
> v1 through v5: adaptations that correspond to the binding updates
> ---
>  arch/arm/boot/dts/ti/omap/omap2.dtsi                |  4 ++++
>  arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
> 
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

