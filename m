Return-Path: <linux-wireless+bounces-13722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A99944BA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC0B2686E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C11CDFA3;
	Tue,  8 Oct 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AVVuJgKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7A1C1AB5;
	Tue,  8 Oct 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380888; cv=none; b=D/gG+D2qwEG5DSt1xZaIIzbrnlSx031DRTSxdnNfePH4q7P0QI/uQvlGbAlyLOqJ5LyiRyuckQGDte1yg9msms7aFE51KlHgvRy+itfXOwB5N5Cp1uPseXZFI9/4SrXzq2Gl47aql32z29QHc0lI9RO7tBz5P4Wtvuo2dx8Q/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380888; c=relaxed/simple;
	bh=xmx20yi3hNZidyw8CTDD5Yq3RehU73nk0sF0D/216v0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVnrMj44A5zvdIsQrfUnWfgMHluIqtXmPCQpeT5im5KWkwqTS1m32scySu9cfVCPFtBwLiGBFJfz/Uk0+JBZdeJRApg/Z6Xa6UrKXJzmUvAxTyPG8l4VQd7qUAaLLDic1tggkJE39zmRXcMTCbVz9VsocaFOrmFqMrN+YeDGWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AVVuJgKw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iBMh4Lf79GRKX+Zc4IiJFYkkvZJgiQk2Qi9gr4KqOA0=;
	t=1728380886; x=1729590486; b=AVVuJgKwZ8MyUbd2BE5lqZibSLFzOYrL+QJWqQUFwdLWKZP
	8nul/gtQOfA3GuZobnNhO9g40cWL8ikIA3j5mRqR8kMdKRKRwBRip+CMHXMQUmhmu2T3TJQ/z+Z3c
	jlyQh0jzUr5kIOcfTve54BHyu4i29uXjzw2XY0GxaNc3F/MMXGcMpG1vd1cfSZQ8OqvBxLj5fmVia
	rUOQPiB7OKYseOgsbkmvZ8eDYQb1ClzgBC6thrHGhIgnbe81OL1h2OFBJokVLhr4K+FD68WqAOXrz
	MY71uywq7/GhDocIXtknjRCA6ylpEbWvQNuC8COQBPq8NNVKjUWrWHBoeDAv5JSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sy6ov-00000004Bph-3oW6;
	Tue, 08 Oct 2024 11:47:58 +0200
Message-ID: <393e713f2f51fe425442028aa874267381667af0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 4/6] staging: rtl8192e: delete the driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Hortmann
	 <philipp.g.hortmann@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Date: Tue, 08 Oct 2024 11:47:57 +0200
In-Reply-To: <2024100810-payback-suds-8c15@gregkh>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
	 <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
	 <b6ff86e3-56a1-43d3-83b2-01818684f076@gmail.com>
	 <2024100810-payback-suds-8c15@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-08 at 08:42 +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 07, 2024 at 11:32:25PM +0200, Philipp Hortmann wrote:
> > On 10/7/24 20:26, Johannes Berg wrote:
> > > From: Johannes Berg<johannes.berg@intel.com>
> > >=20
> > > This driver is using lib80211 and any driver that plans to ever
> > > leave staging should never have done that, so remove the driver
> > > to enable cleaning up lib80211 into libipw inside the old Intel
> > > drivers.
> > >=20
> > > Signed-off-by: Johannes Berg<johannes.berg@intel.com>
> > > ---
> >=20
> > Hi Johannes,
> >=20
> > this driver is not only working, it is also supporting a form factor th=
at is
> > usable and is available on the used hardware market.
> >=20
> > Is it possible to migrate the driver from lib80211 to libipw?
>=20
> I don't think a "migration" is simple or easy,

Indeed. In this case, as you can see in the driver, it already "vendors"
much of what was the ieee80211 softmac stack years ago, and partially
became libipw/lib80211 as "rtllib". I don't know why it even depends on
lib80211 (which does crypto) if it has its own rtllib_crypt_* code, but
I'm not sure I want to know either.

I'm not very inclined to bother finding out, because the thing is,
there's basically no way it will ever "graduate" from staging in this
way. It's been around for just over 15 years (!), and nobody cared, and
in all that time it has already been the case that it should be using
mac80211, not ieee80211/lib80211.

> I only know of one driver
> that ever made that move and it was not easy.  It's simpler to just take
> the existing driver, hack it to pieces out-of-tree and then submit a new
> driver using the correct apis.

Indeed, or integrate with the existing realtek driver frameworks.

> > It does not have to be you who is doing this. How urgent is it to remov=
e
> > this driver?
>=20
> No staging driver should ever get in the way of api changes elsewhere in
> the kernel, that's one of the rules of this part of the tree.  So from
> my opinion, it's fine to delete it now.  It can always come back in a
> new way later on.

Right. It's not per se urgent, we just found that lib80211.h didn't
exist in MAINTAINERS, and then I realized that it didn't need to exist
at all (since we threw out some ancient wifi drivers.)

So no, it doesn't need to happen now, but also as Greg said staging
shouldn't be in the way, and as I wrote above, nothing happened with
this driver in 15 years. I'm not going to wait that long again with
lib80211, and I see no reason why there should suddenly be activity on
it now.

And if suddenly and unexpectedly there is now any development interest
in it, it could even be restored without the lib80211 dependency, as
Greg said, though I doubt that'd be useful - more useful to integrate
with existing code instead.

johannes

