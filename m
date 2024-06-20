Return-Path: <linux-wireless+bounces-9312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDA910D0F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103791F22AE3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056961B47A2;
	Thu, 20 Jun 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpcDoxmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991A1B1500;
	Thu, 20 Jun 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901053; cv=none; b=qL9e0wquftXALdv9DLNwGBaS6RtGd5xDcH7vIh/F0IDEhl3LxETCB034gKqwFmfREnf2KrJhfe8JEZdaeISqgXFutTH40minDsoK7fmEPv7A2HA5OxaNHUkJhAODFfgdz4OvleHkXO7svT3eMT8bsIkwdcu2DmdtGsM74Vrz70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901053; c=relaxed/simple;
	bh=+u20+PzQw0ydTGvhxZkg0M/CZ1MW4ZV07QKlmdkZH9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIeqKThDF5IpxBtQ9qFYV9vN+qx715BvSL2rG4vITxAhrgNHaVSsJfYejCP0aknvQ5ToCX+dvv3WTyAmEzSZ2Q57KXxih55YHKWR4hGNKfK8Uhb2IVUyFV6mWuzsv1giz1JXrlqLdtGn1/byb+yMqhrKYZqREZa7FucU4e4kI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpcDoxmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B15EC2BD10;
	Thu, 20 Jun 2024 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901053;
	bh=+u20+PzQw0ydTGvhxZkg0M/CZ1MW4ZV07QKlmdkZH9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpcDoxmhms7zCAojcmv/RYq8amuLtl7ctEBD7zQhfbjW7+P8jmXqkou3HRrlVlZb7
	 qYze12R0q8VIC64JI2zqHYNHsKkTWq5FDGrl8aZADPgnv4scthWEesv3iVgNjopql8
	 KjHezkm5GuBt5xFg30ugfxRRImANN6sWHEAf0KXygq1ydZmdZ+9rBnbcrFOT6nMOoc
	 j7Pf5kBzBYriCkkIuGAcfwiPeLYN59qvgvCua5fa56a5zX7iDDkL9QGgm+5hsw5yfi
	 QLEqJNvH3RUjLyJcUQAFLiXUZgI9M2wj9DdxqjNPeeZuHj7YMSmhbwHzhh6qWY3Aof
	 NGLV5yR/cROXQ==
Date: Thu, 20 Jun 2024 17:30:48 +0100
From: Simon Horman <horms@kernel.org>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] wifi: cc33xx: Add init.c, init.h
Message-ID: <20240620163048.GK959333@kernel.org>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
 <20240609182102.2950457-12-michael.nemanov@ti.com>
 <20240615085133.GA234885@kernel.org>
 <8dbb30be-3c0c-43c9-8f7a-dbfeeca3837e@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbb30be-3c0c-43c9-8f7a-dbfeeca3837e@ti.com>

On Thu, Jun 20, 2024 at 11:40:31AM +0300, Nemanov, Michael wrote:
> On 6/15/2024 11:51 AM, Simon Horman wrote:
> ...
> 
> > 
> > Hi Michael,
> > 
> > allmodconfig builds on x86_64 with gcc-13 flag the following:
> > 
> > In file included from ./include/linux/string.h:374,
> >                   from ./include/linux/bitmap.h:13,
> >                   from ./include/linux/cpumask.h:13,
> >                   from ./arch/x86/include/asm/paravirt.h:21,
> >                   from ./arch/x86/include/asm/irqflags.h:60,
> >                   from ./include/linux/irqflags.h:18,
> >                   from ./include/linux/spinlock.h:59,
> >                   from ./include/linux/mmzone.h:8,
> >                   from ./include/linux/gfp.h:7,
> >                   from ./include/linux/firmware.h:8,
> >                   from drivers/net/wireless/ti/cc33xx/init.c:6:
> > In function 'fortify_memcpy_chk',
> >      inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:156:2:
> > ./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
> >    580 |                         __read_overflow2_field(q_size_field, size);
> >        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In function 'fortify_memcpy_chk',
> >      inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:157:2:
> > ./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
> >    580 |                         __read_overflow2_field(q_size_field, size);
> >        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    CC [M]  drivers/net/wireless/ti/cc33xx/rx.o
> > 
> > I believe that this is because the destination for each of the two memcpy()
> > calls immediately above is too narrow - 1 structure wide instead of 4 or 8.
> > 
> > I think this can be resolved by either using:
> > 1. struct_group in .../cc33xx/conf.h:struct conf_tx_settings
> >     to wrap ac_conf0 ... ac_conf3, and separately tid_conf0 ... tid_conf7.
> > 2. Using arrays for ac_conf and tid_conf in
> >     .../cc33xx/conf.h:struct conf_tx_settings, in which case perhaps
> >     .../wlcore/conf.h:struct conf_tx_settings can be reused somehow
> >     (I did not check closely)?
> > 
> 
> Thank you for checking. I agree this code should be rewritten so it is more
> clear and w/o any warnings. Will fix.
> 
> I was unsuccessful reproducing the warning on my end. Tried with GCC 13.2.0
> (ARCH=x86_64, allmodconfig) and Arm GNU Toolchain 13.2 (ARCH=arm,
> allmodconfig) and only got errors in scan.c which I assume you refer to
> below (will also be fixed).

Hi Michael,

I tried this again with GCC 13.2.0 on x86_64 with allmodconfig.
And I was able to see this with a W=1 (make W=1) build.

I don't think it is an important detail, but for reference,
I am using the compiler here, on an x86_64 host.
https://mirrors.edge.kernel.org/pub/tools/crosstool/

> > Similar errors are flagged elsewhere in this series.
> > Please take a look at allmodconfig builds and make sure
> > no warnings are introduced.
> > 
> > Lastly, more related to the series as a whole than this patch in
> > particular, please consider running checkpatch.pl --codespell
> 
> Sure, will add checkpatch.pl --codespell to my tests.

Great, thanks.

