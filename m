Return-Path: <linux-wireless+bounces-8565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A68FD131
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 16:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CF61C21743
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22027701;
	Wed,  5 Jun 2024 14:52:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3F25774;
	Wed,  5 Jun 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599179; cv=none; b=YuGkl7T5JZQqtgW9ZJXIcZy+yVVbplCK1rEoPSWnEUeimWL5rOD6cWHwoL/Wcb+EchK4/d4lMsy9WHd3W/bYehf1U64B+5U4fS7Yf1Y8ourBIZSDkQePiZT86xsojkUMlxr5k/3935tjmo7tLBSSSvhugGCjgDun+E10U/UtAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599179; c=relaxed/simple;
	bh=yRIHKxkExUCcCNbOOTqd0FldNUHY9LI103BRj3sfAFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JypRuyRDDq5iw/rBC9dBvCOKffB+LBnvKwSB9N4+glqPswQLO2YL1PNcyRmNnHVxZP2+LcQLQIjqy1Jn5vJ9vdU/7c51sRERAilDdA5bSI8oay2O2vBMQrSEHy6d1Iqw9VC5cyXex8Wx5LtuGp7kEJuP1vIkRDcAvQRX2T/Uw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Wed, 5 Jun 2024 10:52:53 -0400
From: Kenton Groombridge <concord@gentoo.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <dbqrrkkitwhvmcpgcpapdw7a7zjgdkidr4cyyjxyr7mwiihygo@pqzstp2nl7zg>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20240517145420.8891-1-concord@gentoo.org>
 <d1fea590e53cb1b00dc64f4f8a4c8aec84610401.camel@sipsolutions.net>
 <cx2oet5b5lavjywcbf7u4c32krtoglvt3xbe2sxac55e36iibw@lrd5iuhtxz2g>
 <ab59089feac4cfbc1d681fcaa4a828ca13088ce1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6uvcipftoi6mlx2a"
Content-Disposition: inline
In-Reply-To: <ab59089feac4cfbc1d681fcaa4a828ca13088ce1.camel@sipsolutions.net>


--6uvcipftoi6mlx2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/04 09:29PM, Johannes Berg wrote:
> Looking at your patch again, this seems wrong?
>=20
> > +				local->hw_scan_req->req.channels[*n_chans++] =3D
> >  							req->channels[i];
> >=20
>=20
> This will increment n_chans rather than *n_chans, no?
>=20

Ah ha! A silly mistake that I missed. V3 to follow soon.

--=20
Kenton Groombridge
Gentoo Linux Developer, SELinux Project

--6uvcipftoi6mlx2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmZge8BfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t57bKhAAynN8R9v+lYN7ApnatMLAGRD244uYlzCDJPmBILAbfKcrg2vgm+qPJusl
4Cwkwho370rRdRtaDqsgC9eWwRGQpJ1UZ/aq55KAI0PPtphAdXx5MqEmX7Od1aUb
m9Nj9LLEZhL+zdIkNIP3bDRomHDCBaywzJ/mZZg+r2Edr2PUEPYsNhBM2zemvQ08
s17K9eQooclY+fMxDGj08Em462cZ6vv5zHO4nEtTvThv+S1dPpCG9vFXreAnEckM
sVzLDGLII97RlXIHgNKyIIN660fuIfc7O6si1W++KaDxd6j+x0NBovGwOkTPA5hM
IDYLIt+1OG2MY4QlG32NQl3UvfsNtCjjraQcwyU5ZhT45r3W/eL6tD7JcBvLRb/4
OKmO+sSzTAiXZ5sXOdTkIWbiqZno6vkLOsLNnxAwofHUcj0JKv8lvIHGdaxxvqhN
yMDmKye1XdDviSggWn2cAyiovXHrcvZYYQP5LPc72DYmtXtbrIRZEKp+HmOksWBN
ncr5VCfbcBjqeTYCUwoWU8dLE5bHR4pMZCDHUtLYAordXEB2YHavhLNKyB+QZ1m+
s1ZyYZoz7mS6jKxphRaVrwLrQZaCn9hm9zbYx2LN6tfz3NCsV1AHoacoOUfLz/ah
j1Av1LZFwOTw+pMmryTt/NI+kJvdGIp4yfEUSB8JCos3+m3zsJk=
=6g5W
-----END PGP SIGNATURE-----

--6uvcipftoi6mlx2a--

