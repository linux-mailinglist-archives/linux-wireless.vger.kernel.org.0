Return-Path: <linux-wireless+bounces-36316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNuqFp/1AmqvzAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:40:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 070BD51DEB2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA6D6300F5C3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D33ACA5C;
	Tue, 12 May 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD4r/Q8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E440388374;
	Tue, 12 May 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578840; cv=none; b=usJt5GOHXz6tKcObh0V5+JaUiGa4o1LQ0tqj2e1tIbfUiAlF6eueAyWzQ9EO9uhsSGOIEzAn7lOKYGRuPUy5PWrbXxwDeenF1ta7V+x+9iqx/CmDnKc9MdnXjRlgTmSlNc70Zlfu9oxJeayiwqrK/CztHCJvkojobkGsEuvziU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578840; c=relaxed/simple;
	bh=MQw7xk7AK7vUUFTxVKsaMlXHU3CigVS/H91vrn522b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhUNmc44qX/L3V4LEf8sqa1/BgEhFAmhiv+T4NXAFxitCnea02T9Zw7qYnYESd5eBbcxz6eITJwXPbS4QWq5faODaV3ro2txcwvpln7548Q4SFRLpj80ONheqr05/xUa5/nmfhe/go7XR8CUASa6btzC/SkrXb3J5VjsLXOuJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD4r/Q8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2D3C2BCF5;
	Tue, 12 May 2026 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778578839;
	bh=MQw7xk7AK7vUUFTxVKsaMlXHU3CigVS/H91vrn522b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD4r/Q8SkhsDvHSeevTzvHmw6vz0Z+dZ58YkwWZkda6Ul7/l5f/CCzmlRP0IomKA5
	 aynp0zH103Kmr4Eixzpci+QzROxprbZXnvAw0q4d0E7PC5QHBqpo0cU9PttPlRhM2o
	 Bdw0s7lt2PrsE/IHKalO15/J1qYM4kTagd1v6cpiQ0mKs7DaCXmN0MRyaLV1YrKq8+
	 RJUw/11YbCCJnOd2h1H2WCehjtJquNzS9aYRZboEYm25V81Ez7OhUt59g/Z2oSEvmv
	 vOi0ZyWhaAd7tY1WjTQJ4L1LIQsKnm2wiBFX87ptwvUgcm1pwEg7kA05doboaeXvDK
	 fJfUQXv/NTBTA==
Date: Tue, 12 May 2026 10:40:32 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Bartosz Golaszewski <brgl@kernel.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	"David S . Miller" <davem@davemloft.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Felipe Balbi <balbi@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kevin Hilman <khilman@baylibre.com>, krzk+dt@kernel.org,
	Linus Walleij <linusw@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] [v5 net-next] p54spi: convert to devicetree
Message-ID: <20260512094032.GI27589@horms.kernel.org>
References: <20260507212451.3333185-3-arnd@kernel.org>
 <20260511161243.49098-3-horms@kernel.org>
 <edc4d6d6-7a43-442e-adb5-148e37402924@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc4d6d6-7a43-442e-adb5-148e37402924@app.fastmail.com>
X-Rspamd-Queue-Id: 070BD51DEB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36316-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,kemnade.info,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:45:18PM +0200, Arnd Bergmann wrote:
> On Mon, May 11, 2026, at 18:12, Simon Horman wrote:
> >
> > Simon says: As a pre-existing issue I don't think we need to be concerned
> >             about this in the scope of this patch-set. But it may
> > 	    be a potential for follow-up.
> >
> > This problem wasn't introduced by this patch, but I noticed a pre-existing
> > issue in the context here. Does the p54spi_spi_read() function perform an SPI
> > transfer using a stack-allocated buffer?
> >
> > Looking at p54spi_spi_read(), the addr variable is allocated on the stack and
> > passed as a transfer buffer to spi_sync(). The SPI framework maps transfer
> > buffers for DMA. Passing a stack-allocated buffer is illegal, particularly with
> > CONFIG_VMAP_STACK enabled, because stack memory resides in vmalloc space and
> > cannot be safely DMA-mapped.
> >
> > Could this cause memory corruption or a kernel panic during the transfer?
> 
> I already commented on this earlier: This is indeed a theoretical
> bug, but it works in practice because DMA-capable SPI controllers
> tend to all use MMIO for short transfers instead of DMA.
> 
> SPI is very fragile this way, and I do have some patches to improve
> that overall, but it seems out of scope for this one driver.

Thanks, I agree this is out of scope.

> >> -
> >> -	gpio_direction_output(p54spi_gpio_power, 0);
> >> -	gpio_direction_input(p54spi_gpio_irq);
> >> -
> >> -	ret = request_irq(gpio_to_irq(p54spi_gpio_irq),
> >> -			  p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi",
> >> -			  priv->spi);
> >> +	ret = request_irq(spi->irq, p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi", priv->spi);
> >
> > Simon says: This one seems more concerning in the context of this patch-set.
> >
> > Is there missing validation for spi->irq before calling request_irq()?
> >
> > If the device tree node lacks an interrupts property, the SPI core may set
> > spi->irq to 0 or a negative error code.
> >
> > Passing this directly to request_irq() without validation can successfully
> > hijack a core system interrupt like the system timer on some architectures,
> > leading to system instability or deadlocks.
> >
> > Should there be a check like if (spi->irq <= 0) to fail the probe gracefully?
> 
> I also commented on this: request_irq() already fails gracefully
> with -EINVAL when presented with an invalid IRQ. IRQ 0 is guaranteed
> to be invalid on any target that uses devicetree.

Thanks, and sorry for not seeing your earlier comment.
Or realising it is a false positive.

