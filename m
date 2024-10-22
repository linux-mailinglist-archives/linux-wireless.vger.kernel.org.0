Return-Path: <linux-wireless+bounces-14302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAD9A9E01
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E7D1C21D23
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49019884A;
	Tue, 22 Oct 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DNolxaMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379A195F28;
	Tue, 22 Oct 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588315; cv=none; b=tvWUZfA1jE4JpX5oWasIPZ6FVUXyNmbSD7+osqKZ8Oxc/WlmTgynYFafMtiqQKfA01vcjBRkbXnpXIqKfNypUmOgPvtr9ulJFGke0kla8debv9DSZbBnYXZ4fQFqKah7jH5iwm3Pm/g195v/YfIi+f98wBYSAkcBTEKshEp6R5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588315; c=relaxed/simple;
	bh=nSGECfqzkAGWc3seoDSqFvb1xwTkBP138TLgT6YEaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r99jMlsHrJi6L+060L01TFJEcVI2mZooppthrN4K/VQMFNknHil2Bb4YZrSzbc2plzjZPdUm3ZxAuO2HHA2aJ3vNdqSldLG+BmivIW7j8jvPooQAEPxw6k108ohjw2O5Tri8AOfOi/EzzDa84DGOUpqtHwc6rmCbpmzkMsN6MoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DNolxaMA; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32CBB2000A;
	Tue, 22 Oct 2024 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729588304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BQxHQ54LnPFjeIxYHJU62iL3BisyLDG8bgtN3ZCWt0=;
	b=DNolxaMAooGW3AYhYQq6IHJ4EF8iX36/bg9gYFl54SDf7qMNEO2r96g9yXhNclJq6hJDwB
	mGxKSQSjrVA8xxZdbw9kuAZ64nMgqTkbufPD/IV6zzz/507xkKq07hxjrIX9WspyKTwhTp
	TQH6Yn1Hg6rUk5uPwl6PhYc5KnzCX8JlWhBZaKlzSWbZjPaH85wZN9dRustFjRsjiwym6g
	V1bdi79QsbyrYEdQaWg+gyD3q05qW8+Otyfkij/x2zvE+jd7LJrD2QPeDsHDeK7J4Aspax
	pocbZbrxqx7y6aKULBEm03m6evRQJXLUDgpyRpx6uiC5jRiHn3IwC6IPi5Cn+A==
Message-ID: <a6529da9-6333-4516-923d-01f12c439b33@bootlin.com>
Date: Tue, 22 Oct 2024 11:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Add proper error handling for remaining
 CMD52
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
References: <20241018194244.280322-1-marex@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20241018194244.280322-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com


Hi Marek,

On 10/18/24 21:41, Marek Vasut wrote:
> A few of the CMD52 calls did not have any error handling, add it.
> This prevents odd errors like "Unexpected interrupt (1) int=nnn"
> when the CMD52 fails just above in the IRQ handler and the CMD52
> error code is ignored by the driver. Fill the error handling in.
> Sort the variables in those affected functions while at it. Note
> that the error code itself is already printed in wilc_sdio_cmd52().
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  .../net/wireless/microchip/wilc1000/sdio.c    | 27 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 5262c8846c13d..170470d1c2092 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -769,8 +769,10 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
>  
>  static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>  {
> -	u32 tmp;
> +	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
>  	struct sdio_cmd52 cmd;
> +	u32 tmp;
> +	int ret;
>  
>  	/**
>  	 *      Read DMA count in words
> @@ -780,12 +782,20 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>  	cmd.raw = 0;
>  	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
>  	cmd.data = 0;
> -	wilc_sdio_cmd52(wilc, &cmd);
> +	ret = wilc_sdio_cmd52(wilc, &cmd);
> +	if (ret) {
> +		dev_err(&func->dev, "Fail cmd 52, set DATA_SZ[0] register...\n");

I don't get the log message, why "set" DATA_SZ[0] ? This helper is rather trying
to read it. Same for the other logs added below

> +		return ret;
> +	}
>  	tmp = cmd.data;
>  
>  	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
>  	cmd.data = 0;
> -	wilc_sdio_cmd52(wilc, &cmd);
> +	ret = wilc_sdio_cmd52(wilc, &cmd);
> +	if (ret) {
> +		dev_err(&func->dev, "Fail cmd 52, set DATA_SZ[1] register...\n");
> +		return ret;
> +	}
>  	tmp |= (cmd.data << 8);
>  
>  	*size = tmp;
> @@ -796,9 +806,10 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
>  {
>  	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
>  	struct wilc_sdio *sdio_priv = wilc->bus_data;
> -	u32 tmp;
> -	u8 irq_flags;
>  	struct sdio_cmd52 cmd;
> +	u8 irq_flags;
> +	u32 tmp;
> +	int ret;
>  
>  	wilc_sdio_read_size(wilc, &tmp);
>  
> @@ -817,7 +828,11 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
>  	cmd.raw = 0;
>  	cmd.read_write = 0;
>  	cmd.data = 0;
> -	wilc_sdio_cmd52(wilc, &cmd);
> +	ret = wilc_sdio_cmd52(wilc, &cmd);
> +	if (ret) {
> +		dev_err(&func->dev, "Fail cmd 52, set IRQ_FLAG register...\n");
> +		return ret;
> +	}
>  	irq_flags = cmd.data;
>  
>  	if (sdio_priv->irq_gpio)


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

