Return-Path: <linux-wireless+bounces-13623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DF9935A3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067151F23D42
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAD1DDA3D;
	Mon,  7 Oct 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yLFCOL6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6F1D7E52;
	Mon,  7 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324211; cv=none; b=bTd2ThyFct3Y+RUxhpzw7N25TnhNcqXWTc0gph4e/35bcxCRG78C3FyoTMLDpw9QqdphUnCp01JWzwHg3rZhWraFPJmsvX5SZr+lkMNJDqnIDwjy73CeJK/xRAIO1aurhRYfsr2+GW6AJfkYiC4ICOER78JkDF6xZuEPdVJTZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324211; c=relaxed/simple;
	bh=B1mZE0N2X/yCAgDrOrhJGdqA0h+LFD87htjVqlJD29A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4WyVEfk/o60vMZnvRVuzsI3yIPSOYZaRftdNW2y+tFiHmD6m7KyIFl/zR36+tQF1qgK3PKrOxpb/69QJP+km/ig/Sc3V1QmECzTc5RQGrDfisSaKmkWVjqJFLMxXI59BGbcu4m54RrUqFo/sLmnb38zwpsrxDcIzq3LGmkIrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yLFCOL6Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WKYte81COsWFAAiRQ+dqjNjWEUCtePdNcsRwDhzDvHw=;
	t=1728324209; x=1729533809; b=yLFCOL6ZXstsCPbf/blVGe7jLCPt9ytNErerLWZy8KO1gvi
	I5jGObbnxLUNPiqG+yZElUmWRX76SKf3AVhGQwkwI/CkNroN0DSWBFvvjuOEOyN/q+zuQ5iChZBFJ
	CAC1MZ6z3NJGAGTt2f/7t8YEonQ5sokn0Yeqe47BxNjF69a+QyeBqry6en+1QA5C/kCDr91oq17Mx
	U9Ctk+2x6Nukgeczey0ChZEPnKQU3Gc0e+d6NkEnHQnuQXfPCU6l7FHBypUNj4h21wCaG774u14s9
	EVd3aPpVYsdlrrfNEnLIJVu1gaAhp7xPxdPa9tSXsgUoR+oykaQQmU2UNeP46CJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxs4p-00000003TZQ-10bS;
	Mon, 07 Oct 2024 20:03:23 +0200
Message-ID: <a36f0fec7c007031f55e220a0ca585b48630f205.camel@sipsolutions.net>
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Oct 2024 20:03:22 +0200
In-Reply-To: <87ed4r4xqn.fsf@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
	 <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
	 <87setb7us5.fsf@kernel.org> <20241007141305.GD32733@kernel.org>
	 <87ed4r4xqn.fsf@kernel.org>
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

On Mon, 2024-10-07 at 20:41 +0300, Kalle Valo wrote:
> Simon Horman <horms@kernel.org> writes:
>=20
> > On Fri, Oct 04, 2024 at 06:27:38PM +0300, Kalle Valo wrote:
> >=20
> > > Simon Horman <horms@kernel.org> writes:
> > >=20
> > > > We already exclude wireless drivers from the netdev@ traffic, to
> > > > delegate it to linux-wireless@, and avoid overwhelming netdev@.
> > > >=20
> > > > Many of the following wireless-related sections MAINTAINERS
> > > > are already not included in the NETWORKING [GENERAL] section.
> > > > For consistency, exclude those that are.
> > > >=20
> > > > * 802.11 (including CFG80211/NL80211)
> > > > * MAC80211
> > > > * RFKILL
> > > >=20
> > > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > > ---
> > > >  MAINTAINERS | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index c27f3190737f..ea3ea2c0d3fa 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -16197,8 +16197,19 @@ F:	lib/random32.c
> > > >  F:	net/
> > > >  F:	tools/net/
> > > >  F:	tools/testing/selftests/net/
> > > > +X:	Documentation/networking/mac80211-injection.rst
> > > > +X:	Documentation/networking/mac80211_hwsim/
> > > > +X:	Documentation/networking/regulatory.rst
> > > > +X:	include/net/cfg80211.h
> > > > +X:	include/net/ieee80211_radiotap.h
> > > > +X:	include/net/iw_handler.h
> > > > +X:	include/net/mac80211.h
> > > > +X:	include/net/wext.h
> > >=20
> > > Should we add also lib80211.h?
> >=20
> > Thanks, I missed that one. Perhaps it should have:
> >=20
> > * An F: entry in the MAC80211
> > * An X: entry in the NETWORKING [GENERAL]
> >=20
> > If so, perhaps I can just add that to a v2 of this patch.
> > Let me know what you think.
>=20
> Like Johannes said, the cfg80211 entry is more approriate but otherwise
> sounds like a good plan, thanks!

Actually scratch that, please just ignore it. I'm going to remove that
header file entirely and move the functionality into libipw in the
ipw2x00 drivers.

johannes

