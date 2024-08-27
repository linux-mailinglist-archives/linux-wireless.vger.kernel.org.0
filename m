Return-Path: <linux-wireless+bounces-12027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109DD9603AA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EE5283764
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20A14D29C;
	Tue, 27 Aug 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnb/PUW9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981F10A3E;
	Tue, 27 Aug 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745097; cv=none; b=V+rmY++0fkEaX2kKe+QUvNY+dZnLHVaRhWdsFYrd7jmRr/QjQC3I1pINgkBCjdBHlsd0aGLeXFRl3XTUp9SBdwdxr8dqCb07SxqOybS0cFsYT6FCM8xx+hlprWNsg7U/MH2gC29JdroH4J1DrVHBePmPD95rciao3zk/DOCkWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745097; c=relaxed/simple;
	bh=A8qs4q7GVsI6SJCyqjyFziFlMD2QiJffUEsHEiMiZ6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNGAe8wYVJJrSNKzSZHpX075cEkMePfkc9DGaps0HtFw2D9UXZd0rbsHuW2m0GMo0i6caWZpSCn4CUiNMLQGrU8bizRZoQpCKMEWyqQrvoRdj4QB6qN3amybskANBHdidi4ltd+sWdq2WWGH4RaOM3vu2SQc22u3WDSR2duvQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnb/PUW9; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B483C000A;
	Tue, 27 Aug 2024 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724745092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuza3MZuYeVztk8T9uatzi0SnTQGBdcv8/vSMaUtdhc=;
	b=jnb/PUW9UfKVn0iAjNX2U5SU/ku517IRVUMYgoe4BdpjEwVn4C1kyU6qu585x8Jl3iaSIJ
	KzntmgtnyeOQqM4p0rymAH9fuUoTFpIxzWplsgVC01DHCQyPfNK+eKwmL41tIEp6wpDASe
	y76LnqcWypL7zmvQbII7DFebN0CLvN8LuMutG8uoTA9Q826LeY6p6/wKFkYGPJ5Mt9I29+
	0LcP9ydohXKw48UmlhKhE84RHcHZGaktS948GAJMQmjgdXCus6mBqpOTXIfOX68rYAaGs9
	IO8dxJtjwwn9I5xAV4AFYLmlllANXjzdAJAKlynbOw1/XXlutmJhF63+2HAjbw==
Message-ID: <2b167618-473a-4da1-9c10-cba2b9051381@bootlin.com>
Date: Tue, 27 Aug 2024 09:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
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
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240823161131.94305-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 8/23/24 18:08, Marek Vasut wrote:
> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
> wilc_get_chipid() right after the SDIO/SPI interface has been
> initialized to cache the device chipid, and then use the cached
> chipid throughout the driver. Make wilc_get_chipid() static and
> remove its prototype from wlan.h .
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
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: New patch
> ---

[...]

> +static u32 wilc_get_chipid(struct wilc *wilc)
> +{
> +	u32 chipid = 0;
> +	u32 rfrevid = 0;
> +
> +	if (wilc->chipid == 0) {
> +		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
If we search for WILC_CHIPID in the whole driver, there are still two places
manually reading this register. Shouldn't those places also benefit from
wilc_get_chipid ?

> +		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
> +					     &rfrevid);
> +		if (!is_wilc1000(chipid)) {
> +			wilc->chipid = 0;

While at it, since you have trimmed the update parameter, it would be nice to
also fix this return value (ie make wilc_getchipid() not return 0 but a real
error code if we can not read the chip id.

Thanks,

Alexis
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


