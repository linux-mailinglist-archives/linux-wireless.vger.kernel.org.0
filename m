Return-Path: <linux-wireless+bounces-13479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834B98F53C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47B7283754
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FE1A725A;
	Thu,  3 Oct 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fSkJdEwK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D745945;
	Thu,  3 Oct 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976819; cv=none; b=S20WbalGBqaqlIRQRJ5S0vGYgK98FBKlmUpYrK6FrDXLMpD9NaicxXSryi4TUOL4dsNBeZiFbWAMM/J9upDeOnEP7IkuVhq3hUXqXlGl8wUto5y3N5faiLQDLEjmnyX8d1Yx+dwIv/XnZqUCP+Jm3Ldx5Gy0FFVclnZz35OKhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976819; c=relaxed/simple;
	bh=0NNvTSrbNAAkdgwmSG2JOqI7Krrq1v9gjZLERXYS2co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcokc6C58ruNZXcu58O31MZREu+2pp+DCMUdxyqwqIMn1o8fh4nPyuiRKA8heQFM49wK+Yuvqb63lrcx95g1ArWjMrkK2+d7zd5iD3IlZtSFlCLr9KOxX4rd4RozMcfOglrrW/+40WkmwkzAOyZAQtF8rEnvIqVFIJMvAXciI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fSkJdEwK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5401D60003;
	Thu,  3 Oct 2024 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727976807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxPTzSsGuAXr7N6t4guqH3YrYjttQBqVYPPWHqe0kx0=;
	b=fSkJdEwKCPCMXR0OHyxcogitX1fHGj1ulyy4vTTPh6loBlHElMC8cLY0Ocq0BFhSAvKMRX
	7pC9CtCMS8W70fNCgkkc9SS3Wt/G5ZosN/WwSYk3qyUiE+y9vl3DFkNoKvkBY/mMYtvv79
	uoHV0RGl+JwgjyUYEoLHuVlQSmRlpq6UHGhzv0BuxZb2xwx6gq2WOBQ+/cLbQfkk/CIkun
	BX/NK+1xrA/gddTS6s0twajAeS6QGu3B0t+D97DIdbdXN05uQkjU1EgznPsJR29EM1CuzV
	V9cUS2A0jsMWACY1jwASYRU/dxOQmxn66SPZqpbNR5ZstD+vzRaU2eHUHE7BgQ==
Message-ID: <2d9d4896-a81a-4393-8cf3-8e42b36aaae2@bootlin.com>
Date: Thu, 3 Oct 2024 19:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] wifi: wilc1000: Clean up usage of
 wilc_get_chipid()
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
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-2-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241003111529.41232-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/3/24 13:14, Marek Vasut wrote:
> Reduce the use of wilc_get_chipid(), use cached chip ID wherever
> possible. Remove duplicated partial chip ID read implementations
> from the driver. Update wilc_get_chipid() to always read the chip
> ID out of the hardware and update the cached chip ID, and make it
> return a proper return value instead of a chipid. Call wilc_get_chipid()
> early to make the cached chip ID available to various sites using
> is_wilc1000() to access the cached chip ID.
> 
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

> +int wilc_get_chipid(struct wilc *wilc)
> +{
> +	u32 chipid = 0;
> +	u32 rfrevid = 0;
> +
> +	if (wilc->chipid == 0) {
> +		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
> +		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
> +					     &rfrevid);
> +		if (!is_wilc1000(chipid)) {
> +			wilc->chipid = 0;
> +			return -EINVAL;
> +		}
> +		if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
> +			if (rfrevid != 0x1)
> +				chipid = WILC_1000_BASE_ID_2A_REV1;
> +		} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
> +			if (rfrevid == 0x4)
> +				chipid = WILC_1000_BASE_ID_2B_REV1;
> +			else if (rfrevid != 0x3)
> +				chipid = WILC_1000_BASE_ID_2B_REV2;
> +		}
> +
> +		wilc->chipid = chipid;
> +	}
> +
> +	return 0;
> +}

My bad for not having spotted it in v6, but you are still missing an
EXPORT_SYMBOL_GPL(wilc_get_chipid) here, making the build fail if wilc support
is built as module:

ERROR: modpost: "wilc_get_chipid"
[drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
ERROR: modpost: "wilc_get_chipid"
[drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/alexis/src/microchip/linux/Makefile:1878: modpost] Error 2
make: *** [Makefile:224: __sub-make] Error 2


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

