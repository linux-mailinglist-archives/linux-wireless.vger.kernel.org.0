Return-Path: <linux-wireless+bounces-8873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638C905293
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95941C2188C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201F16FF55;
	Wed, 12 Jun 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b="hqddc/9m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from komekko.fuwafuwatime.moe (komekko.fuwafuwatime.moe [65.21.224.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D116D4F6;
	Wed, 12 Jun 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.224.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195713; cv=none; b=K0yKTlAyBXdC7d0JEl3p5hhQMBSO3gj8JrKZfsIpfVsQVA+AEpusBiEi9N171Q4tUS3U9OsQ+jNkVFczrUIX+G3RMoHYahc8bXhvX/hHff617lmaA4mf0n0cN++cTml2e4r7iCE4b5lDX74yH+FZQwbE7AoKS4JMDdlv9TiZ3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195713; c=relaxed/simple;
	bh=TDi4E53eOV070hTG5YTA25MB1lt7gnKyfwnJfREXyYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOH4gEf/bNo5HB3c9CyzMbMH4Id41DxAl/6QcAFtXgMBjxn7VdFAGAtufuZUM1viAXt8FF1zdVrXZ9FFxvAjkPU33sf3SqQ1cZjeGqi4UmbBy/fNtYBGCXrAKcIbsrc0igxirpsmJ+9jaZBER8xpIPicNcHpFCx0V3KOeHaoMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh; spf=pass smtp.mailfrom=concord.sh; dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b=hqddc/9m; arc=none smtp.client-ip=65.21.224.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=concord.sh
Received: from megumin.fuwafuwatime.moe (unknown [71.203.71.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by komekko.fuwafuwatime.moe (Postfix) with ESMTPSA id A03E41145104;
	Wed, 12 Jun 2024 15:29:15 +0300 (EEST)
Received: from localhost (unknown [192.168.1.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by megumin.fuwafuwatime.moe (Postfix) with ESMTPSA id 0C8D010962BC;
	Wed, 12 Jun 2024 08:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=concord.sh; s=dkim;
	t=1718195353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TDi4E53eOV070hTG5YTA25MB1lt7gnKyfwnJfREXyYo=;
	b=hqddc/9maZCsBRJ9ABlmTv6tXq6l0TTb+km1ZM5oOQfADREbo2japdfW2lyZe49Gfba42c
	FGg6yfC+tWIv8FkC1NEeiJW1u2IWOmoK1ekdLLHPz2wkjITKo8UMxF6FQjA+fatksvPNoh
	ncONAKqvg5cXEhxf4WpDBCh1Zvp+ZO7tnfD7xHmBtxGUQ66gWcwuBUYKaMMlPBlhotMEpJ
	VRr1q8LALz50D2LL67N/gpLfA4kinPgTB6RXV+Zc3ggKIJhGf//5CNCHbz8aUOqPBDtSLD
	lje7a8rSySZcGmtCyAB4e2MIXtbYRMgAmcBA5ncaYbDjVawpMgtbxGMCsfqwRQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=me@concord.sh smtp.mailfrom=me@concord.sh
Date: Wed, 12 Jun 2024 08:29:01 -0400
From: Kenton Groombridge <me@concord.sh>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kenton Groombridge <concord@gentoo.org>, 
	Kees Cook <keescook@chromium.org>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <hftvxmqv4wm4l6s4ynkzakvawem4a6mvzvkbvnfgvkuie6ybbw@7pulonpy7q74>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <keescook@chromium.org>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
References: <20240605152218.236061-1-concord@gentoo.org>
 <fd1acc0f69ef9573ff0dced35863949c80c6d5e7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6rphp4l66hp66gv"
Content-Disposition: inline
In-Reply-To: <fd1acc0f69ef9573ff0dced35863949c80c6d5e7.camel@sipsolutions.net>


--m6rphp4l66hp66gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/12 10:20AM, Johannes Berg wrote:
>=20
> Wait ... I don't know what Kees did here, but seems then he should sign-
> off too.
>=20

Very early on I asked Kees to review this patch and he identified a
couple issues with it and offered some suggestions. I wanted to make
sure to credit him appropriately for his help -- I apologize if the
Co-authored-by: tag is not appropriate here.

--m6rphp4l66hp66gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmZplIlfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t57vpA//VHsT66cH6yUOnOb25EOh76FkknUiaDTdDSU90XWIx3SBe2xILR+yeipU
hMpdatBpLtE0lIKnWjp7a9ZxTrIzHtqkKqscNzFRlsPVlZqOw3pOmCyyYi4gsxwY
AL6tn4Jb6iS4msK124/ncdOIkudCMuE3p8ii9SDFn47ubf4oROgsFponQqP1Mjt6
/0a1fPFbUm7pJR/dCVbk+WcEHq65jS3uk60fL1iYttLsPQVjAKjkbsfDzUA7h8Vx
xPTXgbSNgy2uCp78s20z0gkGiJ4RLGJlE9U2msFHbWRUY0MBZDVa67IHMql7JsOl
Y3MCItaZdLbf44bhP2NuFEF5NPdXka2EgrTpS7wUbnX8x9H9nmCVTgWFWOHKGV2y
2roUwfuO/oYSrmQpFH2CTo0wtwnKaA+57e8qD6kQZzRqeGMrLGoc9AwvFPxxXPyy
ZyDfSUXRY9PRJ/TGZAosm1PO1BCMJTd9Qg+0v3usoXeBtsG49E3XJtLfKCq0dK8i
OSpUfNVuPDeZ1MA2YsbmXg/z/WGmj7daCA20Kto502qtuTHYsX4X9SxFx7SZHCEh
MkKjyPpyLxMSMhLTHHD9qIs+LsUxvDbKElZPT+0YmrOaS1xB3SW685sNmoGVOZ8Z
aF037mFI3iIUqGjFZZynBmJPllU2//O9CP9RIfne12m7TrZWc2U=
=0LHB
-----END PGP SIGNATURE-----

--m6rphp4l66hp66gv--

