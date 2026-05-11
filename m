Return-Path: <linux-wireless+bounces-36239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLa1HUUGAmpZnQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:39:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03146512618
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EA593193348
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEF425CC3;
	Mon, 11 May 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEeA/6RZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEC42316C;
	Mon, 11 May 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516066; cv=none; b=uQd/AEkJ2KurZiP741sjHIdWhmm4lXM6VJheeUk27ZvAnrtO2u46F5Iamv1ZLB5aQ+E+zOzN7xT+JfRpcOskvc9JEMWNIe3bjqJNC/BX7RZbSOF/xz5WchYBlPHagYJhPJrQZR25ErBsLkjsEJhYr6EkXP9iDAL72/zuoDCdSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516066; c=relaxed/simple;
	bh=loApl5z4gNMlxHcs5ARDnO2c3Zo1516aXOntv1kkSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xokg7dAWVI1n5+Qjur1mYU80xjdvXd9ZZFEbNb6KRSTasvNzfPnaxKtXH195DRU7xHa5I3njYqDeVB7RROEoSZl7+AIzs1l76dbORnQmbQBFKYK765dcNDo66lcRlDDoSX5VJ2OL5iF1LUoZLWu2vp4f9YIC/LqTav215IOjE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEeA/6RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0977C2BCB0;
	Mon, 11 May 2026 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516066;
	bh=loApl5z4gNMlxHcs5ARDnO2c3Zo1516aXOntv1kkSOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEeA/6RZ7YTpM/mMfohIkUuAPJCtp2QiDJuGU1bgB1m4w8DDqNIsJvjjEdg1yis6w
	 WRBNHSyhHo6FBHW1PFoyBgzmhB543o/db/XweILflbtXmveiTQFmmBR7Y7eIK4qNsq
	 jIjY90qth83Pt21QXi90Ffm3xgQYlnrBz6htplTsPUb94t5K3gJtlyZWyaQpMY/W8D
	 nPq5l4OHunZThPbuUnqwORsQZJMmx2n/MsXXPnhNPcLne9U8Lk2JIMxsdG/l1oOhfw
	 JNLxfqx/ld2gvmmvouQNRubK0Lk+HGJktszx3mEqeMMByX/R3I+vI/xJQqI7ninEbm
	 uL/GzsKtc0pag==
From: Simon Horman <horms@kernel.org>
To: arnd@kernel.org
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	arnd@arndb.de,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	brgl@kernel.org,
	bcousson@baylibre.com,
	davem@davemloft.net,
	dmitry.torokhov@gmail.com,
	edumazet@google.com,
	balbi@kernel.org,
	kuba@kernel.org,
	johannes@sipsolutions.net,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 2/3] [v5 net-next] p54spi: convert to devicetree
Date: Mon, 11 May 2026 17:12:45 +0100
Message-ID: <20260511161243.49098-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507212451.3333185-3-arnd@kernel.org>
References: <20260507212451.3333185-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03146512618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arndb.de,iki.fi,kemnade.info,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36239-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
p54spi: convert to devicetree

This commit converts the Prism54 SPI driver from using hardcoded GPIO
module parameters to using the GPIO descriptor interface and device tree
probing.

> diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
> index 9d66dcae54e02..d18be25450285 100644
> --- a/drivers/net/wireless/intersil/p54/p54spi.c
> +++ b/drivers/net/wireless/intersil/p54/p54spi.c

[ ... ]

> @@ -30,19 +31,6 @@
>  MODULE_FIRMWARE("3826.arm");
>  MODULE_FIRMWARE("3826.eeprom");
>  
> -/* gpios should be handled in board files and provided via platform data,
> - * but because it's currently impossible for p54spi to have a header file
> - * in include/linux, let's use module parameters for now
> - */
> -
> -static int p54spi_gpio_power = 97;
> -module_param(p54spi_gpio_power, int, 0444);
> -MODULE_PARM_DESC(p54spi_gpio_power, "gpio number for power line");
> -
> -static int p54spi_gpio_irq = 87;
> -module_param(p54spi_gpio_irq, int, 0444);
> -MODULE_PARM_DESC(p54spi_gpio_irq, "gpio number for irq line");
> -
>  static void p54spi_spi_read(struct p54s_priv *priv, u8 address,
>  			      void *buf, size_t len)
>  {

Simon says: As a pre-existing issue I don't think we need to be concerned
            about this in the scope of this patch-set. But it may
	    be a potential for follow-up.

This problem wasn't introduced by this patch, but I noticed a pre-existing
issue in the context here. Does the p54spi_spi_read() function perform an SPI
transfer using a stack-allocated buffer?

Looking at p54spi_spi_read(), the addr variable is allocated on the stack and
passed as a transfer buffer to spi_sync(). The SPI framework maps transfer
buffers for DMA. Passing a stack-allocated buffer is illegal, particularly with
CONFIG_VMAP_STACK enabled, because stack memory resides in vmalloc space and
cannot be safely DMA-mapped.

Could this cause memory corruption or a kernel panic during the transfer?

[ ... ]

> @@ -608,31 +596,20 @@ static int p54spi_probe(struct spi_device *spi)
>  		goto err_free;
>  	}
>  
> -	ret = gpio_request(p54spi_gpio_power, "p54spi power");
> -	if (ret < 0) {
> -		dev_err(&priv->spi->dev, "power GPIO request failed: %d", ret);
> +	priv->gpio_powerdown = gpiod_get_optional(&spi->dev, "powerdown", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->gpio_powerdown)) {
> +		ret = dev_err_probe(&priv->spi->dev, PTR_ERR(priv->gpio_powerdown),
> +				    "powerdown GPIO request failed\n");
>  		goto err_free;
>  	}
>  
> -	ret = gpio_request(p54spi_gpio_irq, "p54spi irq");
> -	if (ret < 0) {
> -		dev_err(&priv->spi->dev, "irq GPIO request failed: %d", ret);
> -		goto err_free_gpio_power;
> -	}
> -
> -	gpio_direction_output(p54spi_gpio_power, 0);
> -	gpio_direction_input(p54spi_gpio_irq);
> -
> -	ret = request_irq(gpio_to_irq(p54spi_gpio_irq),
> -			  p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi",
> -			  priv->spi);
> +	ret = request_irq(spi->irq, p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi", priv->spi);

Simon says: This one seems more concerning in the context of this patch-set.

Is there missing validation for spi->irq before calling request_irq()?

If the device tree node lacks an interrupts property, the SPI core may set
spi->irq to 0 or a negative error code.

Passing this directly to request_irq() without validation can successfully
hijack a core system interrupt like the system timer on some architectures,
leading to system instability or deadlocks.

Should there be a check like if (spi->irq <= 0) to fail the probe gracefully?

>  	if (ret < 0) {
>  		dev_err(&priv->spi->dev, "request_irq() failed");
> -		goto err_free_gpio_irq;
> +		goto err_free_gpio_power;
>  	}

