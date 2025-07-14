Return-Path: <linux-wireless+bounces-25401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEC8B047B2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 21:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0640E7A7EA2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969F260565;
	Mon, 14 Jul 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rEW61mXM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EE25E471
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519896; cv=none; b=Utmejw2kdOZqUDVi09x7XqHo6i/lQupmxvE6/y/xenebRNBHau06O1jeGc3KsF6OR5GgqPIEnJLFTvqFKVMTBjK0wjy7yD7rwXQ9StlxYfJAsVApB4j4puoU74xwTVqypmaqBrkQGhUeaR72LRlI9zBI0AWF/wczehvGu+yfnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519896; c=relaxed/simple;
	bh=qda9F19ArQzOMONbH1U4sBHrDFTWPEqr71Yitk6yrpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2rjrZV1BvucyYLUCL+xLe9JDPlOPwGizr8GUNjpHoLZJ3k6P/bl+1CG+8t/Tl/cXccYd2iyrzLaTd0+eQ9G3bqKpLoCvLqoNyiUbf+ud2UUlwkXVMqYhjX28XcRpuORQiJ93d3LzfFzZvkDafddvXJPXkLYC/q71pYNwSZXh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rEW61mXM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zysRmXGl/i/f3Nx386kXnhlHlRWCZVvgC8GQfxNIJeU=;
	t=1752519894; x=1753729494; b=rEW61mXMzaJYspEDY+fLQaqLWjsgjCjl5tJR2kInfLQHfsC
	WUFeOR2kwSgNPRMCurrkn+zybl0uUNxzeFfLRGv8KJXEZlAc2AvbxuJSp3LQNGRyj/WIi/F7/GFJm
	XBShCBxYF12txoOJalHAvt0zOCF32yuPnhQvG7iLLaMaSPeVCrvkBnm4f6oUy4XVd0jg5Q7g2w2d4
	nTeVfgdtgbUqDnd62NSwnyPkTWzOC5m7pgYrzMVDAtWpNPprHwxdZifh2H/5KoDVit1L/hyWVvs8T
	8DOeaM68BBzHJN2W2DoKdXmKFYuLaIqJaNQeWFSPSBUZMmSon6XYRQV2HTOcba1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubOTr-00000004PNE-2X3l;
	Mon, 14 Jul 2025 21:04:51 +0200
Message-ID: <f06ae1061b0dc3f36c3f7cd69393835b57fb5193.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211/mac80211: remove wrong
 scan request n_channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Haoyu Li <lihaoyu499@gmail.com>
Date: Mon, 14 Jul 2025 21:04:50 +0200
In-Reply-To: <87d96834-0b29-4282-8538-fc53551824e8@oss.qualcomm.com>
References: 
	<20250714142405.02beff564ba8.I25dd7af47f5dab3b560dec7b33cdaf49c3a4418f@changeid>
	 <87d96834-0b29-4282-8538-fc53551824e8@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-14 at 11:09 -0700, Jeff Johnson wrote:
> On 7/14/2025 5:24 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > This (partially) reverts commits
> >  - 838c7b8f1f27 ("wifi: nl80211: Avoid address calculations via out of =
bounds array indexing")
> >  - f1d3334d604c ("wifi: cfg80211: sme: init n_channels before channels[=
] access")
> >  - 82bbe02b2500 ("wifi: mac80211: Set n_channels after allocating struc=
t cfg80211_scan_request")
> >=20
> > These commits all set the structure to be in an inconsistent
> > state, setting n_channels to some value before them actually
> > being filled in. That's fine for what the code does now, but
> > with the removal of __counted_by() it's no longer needed and
> > it does leave a bit of a landmine there since breaking out of
> > some code to send the scan or something would leave it wrong.
>=20
> Perhaps also refer to:
> <https://lore.kernel.org/all/20250714142130.9b0bbb7e1f07.I09112ccde72d445=
e11348fc2bef68942cb2ffc94@changeid/>
>=20
> Since (as of now) __counted_by() is still there in wireless-next

Well I can't merge this until the other one comes back to wireless-next.

> > +++ b/net/mac80211/main.c
> > @@ -1359,7 +1359,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw=
)
> >  				      GFP_KERNEL);
> >  	if (!local->int_scan_req)
> >  		return -ENOMEM;
> > -	local->int_scan_req->n_channels =3D channels;
>=20
> so i'm looking at how int_scan_req is used.
> is there ever a possibility that at the time it is used that the underlyi=
ng
> wiphy information may have changed such that the number of channels tryin=
g to
> be filled exceed the number calculated and allocated in this function?
> just want to make sure there isn't a reason to keep track of the allocati=
on
> size somewhere.

I don't think so, the supported bands/channels aren't supposed to change
at runtime, and we can't really scan more channels than we have. Of
course in theory we could always get it wrong somewhere, but ...

johannes

