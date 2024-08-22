Return-Path: <linux-wireless+bounces-11795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123295B2E3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EE283DB4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862117E01F;
	Thu, 22 Aug 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ctD7QZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E113AF2;
	Thu, 22 Aug 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322375; cv=none; b=iQqyjG2e+937kTOIS5VHkb93/zucEcJmkHi6gzBNdK+6BSMsbjsQudhq2X0UilKsMWOEf3IqP6+0Q+4RXZhkmUXTgGiJVNaKUfZqbNzTnRPNcSPUVj414hwjzHwCbs8ZmVGScYgFW0dKsIlKqAeMVcm1XutlRLgQ5Um0cGF5cRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322375; c=relaxed/simple;
	bh=UQ9wUzFQJekr02IhbgVN5WzBo844fCCWYXbf9jEIPX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVPV9U+WM7OmjStBZXg5hgXi08UBEZaX2L8qXPyFr4UkobIKtXrbi+b5u8E7kLalRsG2/SC8Nr/P6bgA3gXzqD+opDUfuOnejOBLdVfxghUZM4C6V0Yu1VpG2q65U0kjVoGHmmx7G+pA+QGT8kImw/WwxEn1TLPt3DVs/wtO1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ctD7QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35221C32782;
	Thu, 22 Aug 2024 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724322375;
	bh=UQ9wUzFQJekr02IhbgVN5WzBo844fCCWYXbf9jEIPX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+ctD7QZ+ihqLW20e9tz390nRGt/4kOf9OoTTSC7qlx8d4P2zz6gzUWRhODzMoP4+
	 VqKSSZupUyBY04nu9y/FGwsndAZy2jZ2nDmUrvoBSyrDNKfPAK13N0t4muWz+6xUHR
	 XkvHuPlKnDY4r7Cgw7X0X5TdR5Ru/CmPMbLLmSaBlSkHAMv0xKCdgSH+nC7AOkYY3F
	 Y271inlrUTrEG0sznzQVycNsLAzGtELfqwl2Vu6GJ0ZUekCprAdZPNmmqLsxMo4MMH
	 lA7rDGorncUUKxde3cST0ikdmgyd5vpnJjSZwiPurMdWRm0YGFI0jqNofAvPGpP1lg
	 jqqpcFE4YRqnA==
Date: Thu, 22 Aug 2024 11:26:09 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
Message-ID: <20240822102609.GK2164@kernel.org>
References: <20240821184356.163816-1-marex@denx.de>
 <20240821184356.163816-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821184356.163816-2-marex@denx.de>

On Wed, Aug 21, 2024 at 08:42:33PM +0200, Marek Vasut wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Add support for the WILC3000 chip. The chip is similar to WILC1000,
> except that the register layout is slightly different and it does
> not support WPA3/SAE.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

...

> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 41122199d51eb..7b99fcc450fd3 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -764,9 +764,13 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
>  	 *      make sure can read back chip id correctly
>  	 **/
>  	if (!resume) {
> -		ret = wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
> -		if (ret) {
> -			dev_err(&func->dev, "Fail cmd read chip id...\n");
> +		chipid = wilc_get_chipid(wilc, true);
> +		if (is_wilc3000(chipid)) {
> +			wilc->chip = WILC_3000;
> +		} else if (is_wilc1000(chipid)) {
> +			wilc->chip = WILC_1000;
> +		} else {
> +			dev_err(&func->dev, "Unsupported chipid: %x\n", chipid);
>  			return ret;

Hi Marek and Ajay,

It seems that with this change ret will be 0 here.
Perhaps an negative error code should be returned instead?

Flagged by Smatch.

>  		}
>  		dev_err(&func->dev, "chipid (%08x)\n", chipid);

...

