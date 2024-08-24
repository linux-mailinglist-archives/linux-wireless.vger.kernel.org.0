Return-Path: <linux-wireless+bounces-11886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E595DDDF
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 14:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09258B218C2
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5B158DD4;
	Sat, 24 Aug 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEnYNkxJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4835894;
	Sat, 24 Aug 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724503477; cv=none; b=nbbSMBN1RZ3w2n7rKi0nclOB65cFgIAVif6LYNM0bxyh1p75CAZRp2aS6swEA7XRCySRpEO0H66HsEdemoBq7RzCy1m4QuLRxXi1CURAoT0czUUofM2XP5pJqq1qw9AO5JzdVO3AEpEsFLIP4PyNzqJRnyNwbW0DYg5DgMvTmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724503477; c=relaxed/simple;
	bh=HwGCxWy4npt+HfgezYvNZsi2kj7gEaqEmWDYyQwaltc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dji7bMtvtkcHSM47aVqy4rhEgemor5cAVaWsWb8/FrHM5pYHVS/O9wJMhjONVOZdUHjMiLCOlVhSfNHS78WBvDGl5feVcI6T2KhTSYqTr0reL1LHbQMZi3i0329ggX9mm7fuEkjllOoKOldp3QL+/06gpD3T3pXralkAcVs0ZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEnYNkxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A8C32781;
	Sat, 24 Aug 2024 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724503476;
	bh=HwGCxWy4npt+HfgezYvNZsi2kj7gEaqEmWDYyQwaltc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEnYNkxJUy5bWVypMzGV03seYcNHt9LzFWbg7Xw6cdccqAqngsoQjSHriOfE4CRp5
	 uZlMLg+r47xeMeEIfecQNxpjd7oXmS1nEtw0/bxTCn03CvU9KxAoGawd89sA0nlF8h
	 Ilyd7N4ykBgtqwASitxVwN8EFS5jYExma1sOGw+cqdzMlOByM0bK2aZMyxJWW45PrL
	 e8CKp9tRa9DJ1D0kr4xi/gxk1ZuOGxbtvDNMFiEBkfhmJLtlCivjujwXZ7g03KVjNx
	 ZiT6rZC8OaFQoerHicv0oUhCmu1IvC/MmvTWowbY8rYSe7POp6McyGS0mY2JlKe1JC
	 GGebLkxAvjghA==
Date: Sat, 24 Aug 2024 13:44:30 +0100
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
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
Message-ID: <20240824124430.GI2164@kernel.org>
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de>
 <20240823174630.GD2164@kernel.org>
 <006098a3-efb5-4bf3-a28c-20702597feaa@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006098a3-efb5-4bf3-a28c-20702597feaa@denx.de>

+ Dan

On Fri, Aug 23, 2024 at 10:38:59PM +0200, Marek Vasut wrote:
> On 8/23/24 7:46 PM, Simon Horman wrote:
> > On Fri, Aug 23, 2024 at 06:08:57PM +0200, Marek Vasut wrote:
> > > Do not use wilc_get_chipid() outside of wlan.c . Instead, call
> > > wilc_get_chipid() right after the SDIO/SPI interface has been
> > > initialized to cache the device chipid, and then use the cached
> > > chipid throughout the driver. Make wilc_get_chipid() static and
> > > remove its prototype from wlan.h .
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> > 
> > ...
> > 
> > > @@ -1535,9 +1537,18 @@ int wilc_wlan_init(struct net_device *dev)
> > >   	if (!wilc->hif_func->hif_is_init(wilc)) {
> > >   		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
> > >   		ret = wilc->hif_func->hif_init(wilc, false);
> > > +		if (!ret)
> > > +			chipid = wilc_get_chipid(wilc);
> > >   		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
> > >   		if (ret)
> > >   			goto fail;
> > > +
> > > +		if (!is_wilc1000(chipid)) {
> > > +			netdev_err(dev, "Unsupported chipid: %x\n", chipid);
> > > +			return -EINVAL;
> > 
> > Hi Marek,
> > 
> > Should this unwind as is the case elsewhere in this function?
> 
> It should, will fix in V3, thanks.
> 
> > 			ret = -EINVAL;
> > 			goto fail;
> > 
> > Flagged by Smatch.
> 
> What's the trick here ?

Smatch is here. I don't think there is much of a trick other than running it :)

https://github.com/error27/smatch

