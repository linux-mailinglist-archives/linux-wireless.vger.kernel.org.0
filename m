Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD73E98AA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 21:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHKTWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 15:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhHKTWy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 15:22:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D392E60F21;
        Wed, 11 Aug 2021 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628709750;
        bh=G2uRZMUVBnB65qXP4NVkE40JGyNsKNLR/ss2Ve51Iz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfQMhn6SlRBoqUWJhfC4FLnUwgmyOsaTe95q9Y8FgHgcwzSviiMZ5Wnjj2In73NRe
         kcUduK20Lvi8/RhIPhZp/kjTvF00XTwtVEFyC76yzeYMWSQKfLP1rFiVJwwx475pg8
         JF/ouIoLEGyYWAtmTqmz7vyxvNOGHo3aIMcJ43MZVHoW1XpntcWUKam1hC5Zs9lCiT
         WKUsBmn5FCWHemWgBZY7FFWGAg5mtlFI2sgg9/Qlo/KSSTro5gvKuBSdt7ouE8CVbn
         +/X+YZCyfS87/HjDtZGfysijqzMchJwoHZ0T6bys3ggQ6OTEcS2hx7iIPU/V8d9Hbm
         J8fRz76zzqEEw==
Date:   Wed, 11 Aug 2021 14:22:28 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     bkil <b.K.il.h.u+tigbuh@gmail.com>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH v2] wireless-regdb: recent FCC report
 and order allows 5850-5895 immediately
Message-ID: <YRQjdJ05h+Vy1gjl@ubuntu-x1>
References: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
 <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
 <YOdVFE51Wbxr80Qf@ubuntu-x1>
 <1f441ba830535161b62086c1fee0d027b36bffc6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f441ba830535161b62086c1fee0d027b36bffc6.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 09, 2021 at 10:06:31PM +0200, Johannes Berg wrote:
> Hi,
> 
> Uh, sorry for the delay.
> > 
> > The first is that it seems I forgot to test build this patch before I
> > pushed it. The PTMP-ONLY flag isn't allowed by db2fw.py. This was done
> > by Johannes for reasons which aren't explained, so maybe he can shed
> > some light on it. The flag doesn't appear to be used by the kernel or
> > hostapd, so maybe it was deprecated long ago. Anyway, I've pushed a
> > change to remove this flag.
> 
> I don't remember, but quite likely we decided it was just not something
> we could implement properly or so, and never supported it? Sorry.
> 
> Clearly the kernel does nothing at all with NL80211_RRF_PTMP_ONLY.
> 
> > The second problem is more serious. I thought that we could allow 160
> > MHz bandwidth across two AUTO-BW ranges too small for this bandwidth,
> > but it turns out that the kernel rejects any rules with a bandwidth
> > greater than the frequency range of the rule. I'm not sure what we can
> > do about this. Even if the kernel were changed to support allowing
> > greater bandwidths across combined ranges, we're going to have a
> > backwards compatibility problem with older kernels.
> 
> OTOH, doesn't AUTO-BW basically ignore the max bandwidth for a given
> range anyway, seeing the code in reg_get_max_bandwidth_from_range()? So
> just keeping it at 80 with AUTO-BW would still result in 160 being
> usable? I think?

Yeah, I think you're right. So I guess the changes we ended up with
should allow 160 Mz across these ranges.

Thanks,
Seth
