Return-Path: <linux-wireless+bounces-8830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB6904BE0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B711D1C224A0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710E16727B;
	Wed, 12 Jun 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gaWk0xZ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8F13C9DC
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174892; cv=none; b=OHoAsZLR56VnkIjQqxuJjiJWB8sOgVy8nw9t/GrjFOhhaniMxX7MuN3Pacv1lE63HtK3+EAAnS+Eh6z4m37cmUz3JhcFlAP5GmafppMcczz8R3OAZeV8z/00TmjfxB5++J3GcF+JFjktGCKNk8tLj+IS0kcSGyE32/Oi12vXdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174892; c=relaxed/simple;
	bh=sT6MLn7g/+yoJxJM1Vy2AmY8XtQO0nP0Ewpip2byMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIoyPnpB4SCiosZqCNYXJLvCwUMIhXAOpnddW0Y442gDARY+W0G0s5jSxOIoeOi4ZqdMW0Y8490TGk4fk5qotFbhN3jM8tiYVYypUZFfYpH7Yg8bjDRoId0H8JjUlik0f5cUQ53CNhnbZWnRURnb6DFwbJQIjRdPYdyhqkvksXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gaWk0xZ5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AE6B91FAA6;
	Wed, 12 Jun 2024 08:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718174879;
	bh=xWQ2b0LzefD90xJtB1kvzHYc/zIlacWMUpz1BpNh0x0=;
	h=Received:From:To:Subject;
	b=gaWk0xZ5JoGm6TpSgyYnwfXZZcQqy0Xh/ds4o4GRJV1aO3hh+Gm9I+5ZzugtXAFYW
	 3RpE7M/0Y4Mf9+Nl+buiHqhHDr9Ep9AvWSQwfqwh0MSbNQk4lMdmc/kDUXlavmTlYI
	 ZDtagOoQNLI9nTiXpaKqYAWTCOfFxc0fHoWsTE+aDF1F8LUBUnOX8OLbaNmve+i/NT
	 eSwoCUqPvE1t0BD1El0lqkSBwsLV6NK0phVAxOJZghxKzUBE1nTWMFBoYRG1CV53gg
	 YjphZvDVvTn9iVJB52+dNiMecRwflwvy80MpOflfP23UbskaUUL5eSK2fBz5Mg3Wfq
	 S7mtTTh/w6pPw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 56AAF7F93B; Wed, 12 Jun 2024 08:47:59 +0200 (CEST)
Date: Wed, 12 Jun 2024 08:47:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Andreas Kemnade <andreas@kemnade.info>,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	=?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
 firmware git
Message-ID: <ZmlEny2W0nArOf1T@gaggiata.pivistrello.it>
References: <20240605160013.6bea8d4d@aktux>
 <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
 <20240605174709.5043af8f@akair>
 <20240606101839.GA76158@francesco-nb>
 <PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hello David,

On Wed, Jun 12, 2024 at 02:17:46AM +0000, David Lin wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote:
> > > But that is all legalese and I am not a lawyer... Best is of course
> > > something officially added from NXP. No idea if it can be done
> > > otherwise. How to make NXP add something?
> > 
> > Would it be possible for you to get these firmware files added to the official
> > linux-firmware git repo?
> > 
> > I am not using sd8987 myself, from what I read in the thread probably some
> > file name would need to be corrected (I would say in the mwifiex driver).
> 
> I am not responsible for firmware release.
> You can get updated firmware from https://github.com/nxp-imx/imx-firmware/.
Yes, I am aware of both, and most of the people in this thread is aware of the second.

I was wondering if you could facilitate within NXP having these firmware files
added to the linux firmware git repository, where they should be for various
reasons. To whom should I write such a request? Can you help in any way?

Francesco


