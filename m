Return-Path: <linux-wireless+bounces-14309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCD9AA03B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF63F282DF3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0319AA53;
	Tue, 22 Oct 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZ3ybE8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DE16DECB;
	Tue, 22 Oct 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593836; cv=none; b=QzrvBavePwxYQN3Mrrsof5NwNSnxARDZGhTsKYk7xEo+cYG4tQPxEfUZB9AG4DXIIppAx6mU03wypxplYNqKEWYd5RfQC03TWemHRG9HheaUcQHqUJcDv9uN3Y09ZsuRBDEe+Cx5hH42bHi1MeY/0+IaHp8Up86SNQtZKtJ62/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593836; c=relaxed/simple;
	bh=3L/mfArSh02i4CZyNQjoKh10X4Lo25gJRXejPnC009o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqvV6cRHax8USWv/7Z/ESqeN8KFaRh4JxUsrNeo4aAh9u78I3QSpetUf+p+XJ4Ji7tN8uwY/4Z4iu3hRYcplLM1ygZhVv9tWqum4gLb9IWhbLOYsmZTDy1NbkvTHMjYuCV1M5T2O5D2xgVJRINJ0rSHP+BSEgQEEXX1Z2KrfaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SZ3ybE8w; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D096B40002;
	Tue, 22 Oct 2024 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729593825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4qsrG6uruQTTTq/+4Xc9VuG+K4ys0k5jHgZ1t4x9E0=;
	b=SZ3ybE8wllmqN+BvxV9heeYAnisb5Zp9aRtSqWEpYyBD+7i/vk+39TSmXk0gvfEEE8eaQn
	3kdpvnsC8+o0sEVquJ5nuQUY18YYGVGM1d2vplYckrd1sRWsN9J6TNgWxjsufyIikKo0bw
	V8gcdM0G3Lmpx3GvFWf0Ysv+b0qAJa3ph33r/hQ4NvJlqJlx9Wh56mXJm82WBrPzrc6Vof
	cRhevYdxHFnBCvCYUS3hdqkuDu/6kQ8UVFVAKQb460nY2L2HZB1cK0BauIS7w2xjzC8k4V
	/73GdVHpiKKWdKTS9jx27hJRl0vIGzLKoYXGgaBw678kvkeHXnPNXEMI1ffarA==
Message-ID: <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
Date: Tue, 22 Oct 2024 12:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241022013855.284783-1-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241022013855.284783-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Marek,

On 10/22/24 03:38, Marek Vasut wrote:
> The bus locking in this driver is broken and produces subtle race
> condition with ksdioirqd and its mmc_claim_host()/mmc_release_host()
> usage in case of SDIO bus. Rework the locking to avoid this race
> condition.
> 
> The problem is the hif_cs mutex used in acquire_bus()/release_bus(),
> which makes it look like calling acquire_bus() results in exclusive
> access to the bus, but that is not true for SDIO bus. For SDIO bus,
> to obtain exclusive access (any access, really), it is necessary to
> call sdio_claim_host(), which is a wrapper around mmc_claim_host(),
> which does its own locking. The acquire_bus() does not do that, but
> the SDIO interface implementation does call sdio_claim_host() and
> sdio_release_host() every single command, which is problematic. To
> make things worse, wilc_sdio_interrupt() implementation called from
> ksdioirqd first calls sdio_release_host(), then interrupt handling
> and finally sdio_claim_host().
> 
> The core problem is that sdio_claim_host() cannot be done per command,
> but has to be done per register/data IO which consists of multiple
> commands.

Is it really true ? What makes you say that we can not perform multiple
operations under the same exclusive sdio section ?

Usually the WILC register read/write consists of 3x CMD52
> to push in CSA pointer address and 1x CMD53 to read/write data to that
> address. Most other accesses are also composed of multiple commands.
> 
> Currently, if ksdioirqd wakes up and attempts to read SDIO_CCCR_INTx
> to get pending SDIO IRQs in sdio_get_pending_irqs(), it can easily
> perform that transfer between two consecutive CMD52 which are pushing
> in the CSA pointer address and possibly disrupt the WILC operation.
> This is undesired behavior.

I agree about the observation, and then I disagree about the statement above on
sdio_claim_host/sdio_release_host not meant to be used for multiple commands.
I see plenty of sdio wireless drivers performing multiple sdio operations under
the same sdio exclusive bus access section, either explicitely in their code, or
through a sdio dedicated helper (eg: sdio_enable_func, sdio_disable_func).

But more concerns below
> 
> Rework the locking.
> 
> Introduce new .hif_claim/.hif_release callbacks which implement bus
> specific locking. Lock/unlock SDIO bus access using sdio_claim_host()
> and sdio_release_host(), lock/unlock SPI bus access using the current
> hif_cs mutex moved purely into the spi.c interface. Make acquire_bus()
> and release_bus() call the .hif_claim/.hif_release() callbacks and do
> not access the hif_cs mutex from there at all.
> 
> Remove any SDIO bus locking used directly in commands and the broken
> SDIO bus unlocking in wilc_sdio_interrupt(), this is no longer needed.
> Fix up SDIO initialization code which newly needs sdio_claim_host()
> and sdio_release_host(), since it cannot depend on the locking being
> done per-command anymore.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

>  
> -static void wilc_sdio_interrupt(struct sdio_func *func)
> +static void wilc_sdio_claim(struct wilc *wilc)
> +{
> +	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
> +
> +	sdio_claim_host(func);
> +}
> +
> +static void wilc_sdio_release(struct wilc *wilc)
>  {
> +	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
> +
>  	sdio_release_host(func);
> +}

So with this series, we end up with some bus-specific operations needing some
locking, but is now up to the upper layer to control this locking. This feels
wrong. The driver has a dedicated sdio layer, so if we need some locking for
sdio-specific operations, it should be handled autonomously by the sdio layer,
right ?

[...]

>  static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
> index b9e7f9222eadd..ade2db95e8a0f 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> @@ -403,6 +403,8 @@ struct wilc_hif_func {
>  	void (*disable_interrupt)(struct wilc *nic);
>  	int (*hif_reset)(struct wilc *wilc);
>  	bool (*hif_is_init)(struct wilc *wilc);
> +	void (*hif_claim)(struct wilc *wilc);
> +	void (*hif_release)(struct wilc *wilc);

So IIUC, your series push the hif_cs lock into each bus layer of the driver,
remove any explicit call to bus-specific locking mechanism from those layers,
and makes the upper layer control the locking. As mentioned above, I don't
understand why those layers can not manage the bus-specific locking by
themselves (which would be a big win for the upper layer).
For SDIO specifically, I feel like letting the layer handle those claim/release
would even allow to remove this hif_cs mutex (but we may still need a lock for
SPI side)

But I may be missing something, so feel free to prove me wrong.


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

