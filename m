Return-Path: <linux-wireless+bounces-12453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4396B06F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE9C285B02
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0982866;
	Wed,  4 Sep 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WvFo6HRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865358ABC;
	Wed,  4 Sep 2024 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427280; cv=none; b=uK6BHgtttwxTKz6raNevcQDTeCROr61WWQirX/aeeilY7yFRHmN5boTEZNFguYxD2OZupUeF+7sEYedYpPNYkUx0A+GLJtwyJQH6Z/UcCsXn5+WfH34wPoJmzJCNx4+u6TwDdurwMTwxp5BMksRE+buZKdoUR0puRSzwb3E9qWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427280; c=relaxed/simple;
	bh=uaJfOIjYuBmNzxZ+1UBlZdKM/kOwRLXqL994IS8E/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syPwDrv1rJoJAvoeMBBQ2F82fuatGMEgpEuejoA3Pp0bmqezfMCjrqJ5FT3ZN30YUXV5++/woTDU2N6Lp17aGXdtfQvsbUqvWKJmTFyjoB3yLcgoWSAyCdFii3MLNXrbYgd8/hKmYESjmp2SImxadF0p+J3u4I/6PfWSn1kP3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WvFo6HRM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0FiySO0ehAi2iikWHKUB4ZlYAWXZ+o7GoMT2M1CTeSI=; b=Wv
	Fo6HRMDncl5nsiz6wV007AXZL1lu65SAoBmZrWKLc9J1ldZzv6TadWQMvA6MBFguNWhbwtTipQMZV
	gXC5g8CfCXoHjoaD23vl2QXkIeoZP7Wdbs7c+vQa1yMqDvVQZO6j5hHr2pUvVPi/zVQkyKTW9XT1p
	XoF/5XcZwl4NZaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sliRV-006Ujj-0O; Wed, 04 Sep 2024 07:20:33 +0200
Date: Wed, 4 Sep 2024 07:20:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Li Zetao <lizetao1@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, florian.fainelli@broadcom.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, heiko@sntech.de, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, hauke@hauke-m.de,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wellslutw@gmail.com,
	radhey.shyam.pandey@amd.com, michal.simek@amd.com,
	ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev,
	kvalo@kernel.org, u.kleine-koenig@pengutronix.de,
	jacky_chou@aspeedtech.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] net: ethernet: sunplus: Convert using
 devm_clk_get_enabled() in spl2sw_probe()
Message-ID: <65a6fdd6-5afc-47b6-ab24-3ba05007eb48@lunn.ch>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-10-lizetao1@huawei.com>
 <20240903151649.1b466145@kernel.org>
 <b4f6e9ae-bda8-4496-82a7-de70004e2f29@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4f6e9ae-bda8-4496-82a7-de70004e2f29@huawei.com>

On Wed, Sep 04, 2024 at 09:27:06AM +0800, Li Zetao wrote:
> Hi,
> 
> 在 2024/9/4 6:16, Jakub Kicinski 写道:
> > On Sat, 31 Aug 2024 10:13:31 +0800 Li Zetao wrote:
> > > +	comm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > 
> > You can remove clk from the driver struct now.
> I don’t quite understand why clk can be removed from the driver struct,

After you patch, where is it used?

	Andrew

