Return-Path: <linux-wireless+bounces-24933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81FAFC9C7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1235646FF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E92D8768;
	Tue,  8 Jul 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IO4Ps8rv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D2356D9
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974929; cv=none; b=KZOqiI/f4gkbyy/iEFAiUjtlHiAbFSBEF0te4ocFUQJud9+u2XBbgc/NQVVwQHv2Hlzd9F7PryEcA4+O96+7dNBYMnYh1/vlvMNVsLMLEkNB2al5Vf6YDYKFIiZhiiFPYXARBOPfPZPuO1Iac+5PHR10sFCllHVcF7TLDu1Ao9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974929; c=relaxed/simple;
	bh=wCr+2Z37Uszo7dFDoMfqCcCxCL0pyUBujD5G1yHK2h4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8cUblhM2rqhEgrZOCM+BTnJSKS1N08jECfjE0QFog3AxXA96Qa/egNzJ6Jowr8BJLZStPA5raR8Hki9vXQ7uIyyEHyv1pIWeuIoingtgbIk9kgj2v3ZSqXSQaY55G0yL1gmexYUtQV0/7YMtWksU3KcpEIc3vo+bynpfVCP7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IO4Ps8rv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+n7R+zPzayxID7DA4koE4S3/ajlj3CC/2OceRV9B+Qw=;
	t=1751974928; x=1753184528; b=IO4Ps8rv7uimwu4glO9hnYyvq/t3SjcX3lQWiu8PrRnOcGW
	LdS1RrdoY3RLeDGBNaGtZMSvcsLSdscTW6xxchRgIWFl3ogQrwu6O0oU0CSmL+UqTfI3DEMWsRUG6
	kVL4+YnhcPIkw20vhU+ttu5dz0X6nHjk8UajkWd2x/4/mbONVqt+aGntFe3pcX/PwzDr+Dv/+pHr1
	lOcLdmzDhL54TtGRc82nGCpsOaDu6CWGJC+Y8ETt+A1vYIviqAPS9rQiotJ5b43asyb+6v1jjxWdg
	yh3K1b2zyoLC0ddyIGSngyOnv8p7XUzlTXUx+ITzTmgZDe3xmxTb+eQz+UGG6Z7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ6i5-0000000Bqze-3NJJ;
	Tue, 08 Jul 2025 13:42:06 +0200
Message-ID: <abc76a87bf8b5fffcee18d64bfbd6c641c7739c2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: make VHT opmode NSS ignore a debug
 message
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 13:42:05 +0200
In-Reply-To: <00a86131-3258-4a96-b223-4be0d020a126@molgen.mpg.de>
References: <20250708105849.22448-2-johannes@sipsolutions.net>
	 <00a86131-3258-4a96-b223-4be0d020a126@molgen.mpg.de>
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

Hi,

> > There's no need to always print it, it's only useful for
> > debugging specific client issues. Make it a debug message.
>=20
> Excuse my ignorance, but I wonder if it=E2=80=99s a firmware bug (of the =
access=20
> point), if this situation occurs?
>=20
> Also, I do have a problem with that Telekom Speedport 3, that sometimes=
=20
> =E2=80=93 despite still connected Wi-Fi =E2=80=93 no network connection i=
s possible, and=20
> re-connecting fixes it. It happens much later to the message, so I=20
> assume it=E2=80=99s unrelated, but no warnings would give me more confide=
nce=20
> into the Telekom router.

Either way it's a bug on the other side. It's basically saying that it
wants to change the NSS (number of spatial streams) to a higher number
than it ever advertised support for.

If you get it on the client side while connected to an AP then yeah,
that seems like an AP firmware bug.

It doesn't seem that it'd be related in this case. Though I guess with
my patch we'd stop printing the message and erroneously give you more
confidence ;-)

It just doesn't seem useful to print the message - there's nothing you
can do about it, it basically means we ignore it and keep transmitting
with a lower NSS (which is fine anyway, it's subject to rate control and
the AP cannot have any expectation on how many streams we really use),
and so it's not actionable to the user in any way.

> > -			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Noti=
fication from %pM with invalid nss %d",
> > -					    link_sta->pub->addr, nss);
> > +			sdata_dbg(sdata,
> > +				  "Ignore NSS change to invalid %d in VHT opmode notif from %pM",
> > +				  nss, link_sta->pub->addr);
>=20
> As with my original patch, would printing the current =E2=80=9CNSS value=
=E2=80=9D be=20
> useful? At least for me, who does not know how to get that value from a=
=20
> running system.

We could, though I later realized you printed the wrong value (if
anything, should have "link_sta->capa_nss"), but it's easy to tell what
that value is from the association and/or beacon, so it didn't really
seem all that useful. Perhaps more to be said for simply disconnecting
in this case in strict mode, or something, so it's noticeable to people
working on this/testing it.

johannes

