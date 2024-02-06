Return-Path: <linux-wireless+bounces-3217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB484B432
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 13:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2C92889A0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975F134723;
	Tue,  6 Feb 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LiISg9e4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9513473B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220068; cv=none; b=HJWklIg0DMYt5E4cPUZpryRSS0ry87Djk5lj+O6qpTWXmw51wF8TNef72u2Cw0YE2fZn94nCjqzjSIvsHMYAb4BfmbrZzNkWvgeIqHQW+sI+55ggMhnYuBzfPOW4VzUdGkGEkyFcvknqdx4xSbFuHpymCL0UmDWpkJzzGkDjM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220068; c=relaxed/simple;
	bh=yBCsgwdzomymvd3uB6DYUfgN1bWrcCMAZ76Bg/r2gPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1uKMhWd8DubH60bAur7KhahHBOsW/OBIGmb9Jl15FZvm47cHmzKfDmeJql9fJcE5uT93POGC2LyVdfHoXm4nenPjZkKkp6pmKWcAqoU04BbDnpmjskPUD3zyHGZ3tAjE4vpOZXAMwNFApILygc+UIV0AoSxKfOWP4NVG31+qKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LiISg9e4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yBCsgwdzomymvd3uB6DYUfgN1bWrcCMAZ76Bg/r2gPE=;
	t=1707220065; x=1708429665; b=LiISg9e4NZUlchRvlLznIG9ljeTV0S8voOLJ4122wIE8qUw
	N8LJfAfnbRpnz/EV+EYPV327/igQ0DuPmqqtD/R2XFTZaGU24dfd75m+mHZ+eXD5yXBiRrTzGI4MJ
	0sqUULFYGJGLGmEB0TBe3C8bJy5yp4YElH3lnzd1xnOfYPjkaUpBFlGB937EynUYr6GLauD+lhFpS
	G35BZNGBXIUYxyKSYxe1FZDzDEnY1idzY05Ril48t2yShAifUxao5Y+lFGmFzkBwUwEIxci6pY+DC
	u59jmIAmtRCxFxR2WzSwVDOUHzNsW/CHhE/vrsOtkyeVPpaIloMfUvakhYNVGdSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXJvM-0000000EgLI-3nq3;
	Tue, 06 Feb 2024 12:47:37 +0100
Message-ID: <455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
Subject: Re: wireless-regdb key change broke crda tests after 37dcea0e6e5
From: Johannes Berg <johannes@sipsolutions.net>
To: Sergei Trofimovich <slyich@gmail.com>, linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>, Seth
	Forshee <sforshee@kernel.org>
Date: Tue, 06 Feb 2024 12:47:35 +0100
In-Reply-To: <ZcIXGjzrZrXPCBcp@nz.home>
References: <ZcIXGjzrZrXPCBcp@nz.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> "wireless-regdb: Update keys and maintainer information".
>=20
> Both `git` `master` version of `crda` and `wireless-regdb` still fail
> `crda`'s `make verify`.
>=20
> Should `crda` key the key update as well?

Maybe?

But perhaps the real question is if you should still be shipping crda?
It was last needed for kernel 4.15, and even the newest stable kernel
based on or before it (4.14) is now EOL ...

After that, we had the regdb loaded like a firmware file including the
signatures, so the whole crda isn't needed any more.

johannes

