Return-Path: <linux-wireless+bounces-11867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545595D4A5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96241F22D14
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CD190482;
	Fri, 23 Aug 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGCBiOZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE0746E;
	Fri, 23 Aug 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435196; cv=none; b=pVetbcQqlPW9zIoIBTau9sVFoCKVAjO9+wN2gfLZuu29HEVvHgamQchJRs3sGfuHUmeYuA37meU/aGCnJ1up/7tOmmAKBpqo3ivq1SsfbtR7881c4pxIOfshLUc+Yk4da6U3zKnlfIFseGI6SLJGhXPceDvhM77lbdXbXrl+Flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435196; c=relaxed/simple;
	bh=twydL7XL81AtKkNsurQ3vsSKjYtEfts6TqUfnqixz08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvR6mAHfBZbQyP/PV4sGdXPmKyx5YblYXZ7CwmUsAJUQvSly6skz7VDNXJwjyzGKKWFtPAS6bd1n3khDlCBFyF5BtkPC6d1lp1L+Laiglsp5hAoRfLC25dFJF4O+fgq7TJZ+aRRUqwZkyZ4r2VNUm/EoNdQSnUeYg18R8JP2iDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGCBiOZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB245C32786;
	Fri, 23 Aug 2024 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724435195;
	bh=twydL7XL81AtKkNsurQ3vsSKjYtEfts6TqUfnqixz08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGCBiOZLSAyRCwcyKsEQ5fmPLde51GnLuomXbdwviy00GL6RwGC/NYmUcoYeNsKa/
	 mYV/cZIT5ZchFcbK06H6X0vvcuZ8c8gog8/xkikxk6AkQxm66PO7xNfNVNlT1N6cw4
	 4Fv6Bbqh3eB5d7xCaLGM+wy8cM7HXuTj/ZWIKDcLHdJMioR/Gy9+g8/yv/AEAWEZ7Y
	 4+xaAVn1X4G/Yari+aG0OnLmsbN//BntM5OLgu0ZeBl6I24cpjy+ahfd7U/jWnu4Xi
	 WW/JZrX6BN13g6aXmUjRVw5h2sCpHrIXpL948YRCi2/wuMjMp8RmPaOWiITFhYEXYb
	 Y9Fj4WyaYGYRA==
Date: Fri, 23 Aug 2024 18:46:30 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
Message-ID: <20240823174630.GD2164@kernel.org>
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823161131.94305-2-marex@denx.de>

On Fri, Aug 23, 2024 at 06:08:57PM +0200, Marek Vasut wrote:
> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
> wilc_get_chipid() right after the SDIO/SPI interface has been
> initialized to cache the device chipid, and then use the cached
> chipid throughout the driver. Make wilc_get_chipid() static and
> remove its prototype from wlan.h .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

...

> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c

...

> @@ -1535,9 +1537,18 @@ int wilc_wlan_init(struct net_device *dev)
>  	if (!wilc->hif_func->hif_is_init(wilc)) {
>  		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
>  		ret = wilc->hif_func->hif_init(wilc, false);
> +		if (!ret)
> +			chipid = wilc_get_chipid(wilc);
>  		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
>  		if (ret)
>  			goto fail;
> +
> +		if (!is_wilc1000(chipid)) {
> +			netdev_err(dev, "Unsupported chipid: %x\n", chipid);
> +			return -EINVAL;

Hi Marek,

Should this unwind as is the case elsewhere in this function?

			ret = -EINVAL;
			goto fail;

Flagged by Smatch.

> +		}
> +
> +		netdev_dbg(dev, "chipid (%08x)\n", chipid);
>  	}
>  
>  	if (!wilc->vmm_table)

...

