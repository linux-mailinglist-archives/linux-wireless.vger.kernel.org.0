Return-Path: <linux-wireless+bounces-12329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C123968299
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DADB1C21C8C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E3186E29;
	Mon,  2 Sep 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGJP6UEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B87185B48
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267667; cv=none; b=iHnbFs4NgLqecVvLFAqsOHOLa9m9SEy0zJPomLzyjGHPKXIksacYnlYiRIBX4e4aRuRTkhHn2IAQVuvlQv6xVp3fJGucjS5Y+MVmOhFJpHrBnOxOI7DS1OL8ql2PdcGYA8GPj/xf0l5+Hzy5w+anKl9hl8TWRihXcKwsylWFckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267667; c=relaxed/simple;
	bh=jzEJ86hlT/OT7ByfqsiF0OBxIzLfZ6g8remFUd3tuZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh/EeGxSTfjTZlq59kr1MACnj3g44DyK6H3KzgmSVOrRMYgj+dEIFoTK20o+GbWJEnnTsdWqszxBNvdgysRrqNWXkSDJSe2B6073uVdNxq2VIRcU6XRZ0NskZ75PGniwvTIhiV386lFzz11Jj1aN6282bpv5vZFugkNRZO6xKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGJP6UEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AF2C4CEC2;
	Mon,  2 Sep 2024 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725267667;
	bh=jzEJ86hlT/OT7ByfqsiF0OBxIzLfZ6g8remFUd3tuZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGJP6UEH+MRJbM/BmHk7c91UYF4nk1R/V/pULZoueIAYT0ceraRvVVZhhWH6hOrUA
	 ipmIc6x/eh9BFJpFtShmf8VaHBdldH4Tz/XDUkmgq0Vm1snCt8Z14b3080QMgeo3SB
	 SaSAiapq3WAA8hFSca9Fvv5PoWFex8DVEth73cUG1TqAhAbSynVTG312sw39+2zuF1
	 jimR8QZXbz6Ym30qKvB3ikSWishVq8lxmtd1dHxVNa6uI1S6UOkUcO2zNy7z+2z6XU
	 4Xk1kyKI1dS5ZYWnjvZouc216y3bBfnlXlLcTBRLmyjBnyr+NUjTVQzsuwM4vFOjfP
	 ulydUfSpy5hZQ==
Date: Mon, 2 Sep 2024 10:01:04 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: wext: Correct spelling in iw_handler.h
Message-ID: <20240902090104.GA77312@kernel.org>
References: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
 <dd8cac71a80e70352f4ce4c4da426721e02ff31d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd8cac71a80e70352f4ce4c4da426721e02ff31d.camel@sipsolutions.net>

On Thu, Aug 29, 2024 at 06:07:00PM +0200, Johannes Berg wrote:
> On Thu, 2024-08-29 at 17:03 +0100, Simon Horman wrote:
> > Correct spelling in iw_handler.h.
> > As reported by codespell.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  include/net/iw_handler.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> > index b2cf243ebe44..f7f4c2a79b9e 100644
> > --- a/include/net/iw_handler.h
> > +++ b/include/net/iw_handler.h
> > @@ -23,7 +23,7 @@
> >   * to handle wireless statistics.
> >   *
> >   * The initial APIs served us well and has proven a reasonably good design.
> > - * However, there is a few shortcommings :
> > + * However, there is a few shortcomings :
> 
> If we're going to touch it, maybe that should also say "there are a few
> shortcomings"? :)

Yes, indeed :)

> But is it worth it at all? This stuff is totally on the way out, so all
> the thing about "proven a reasonably good design", well, didn't really
> pan out in practice...

I think if the text is there it may as well be correct.
But if you prefer to leave it as is, then we can drop this topic.

