Return-Path: <linux-wireless+bounces-8496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DA8FBBEC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 20:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ED61F238C3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3001482E7;
	Tue,  4 Jun 2024 18:54:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956944A11;
	Tue,  4 Jun 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527245; cv=none; b=PI1LDy52VkCJWy/T/4IYvtulbj9cXR05wY3uFIs8bE9XTzCYS4wMM/AsBhOGSV5xYv/Oki7oz9RzJMzD+GaYQw6X+JcXdJfiUMzYNS4ZmygMnCzf9PhQzPR3/V6HvDwYsxjBWmbN9t8aXYj6YEbnN/WZHmtU4dxU6xt5eMbW3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527245; c=relaxed/simple;
	bh=ilQQc4mZ1DUA8/7nK9hi/MsoR1Q7Eqgf7H5UYNlCkFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwHMyljYm7f2NlTclDqjpES2tSA4wxh0mDUF7jihvE+PPD7aI6IL8xmaGZRQfujiSYDs4nou4J7xUlcKUe6ZMkTvU221xoUHZkKk6XKU1RTr6JVPMWjqJoyT0+ZR4igajig546mPZjdV4j80UZYPSOSPMiUxUyB6QyFoeWytCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Tue, 4 Jun 2024 14:53:58 -0400
From: Kenton Groombridge <concord@gentoo.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <cx2oet5b5lavjywcbf7u4c32krtoglvt3xbe2sxac55e36iibw@lrd5iuhtxz2g>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20240517145420.8891-1-concord@gentoo.org>
 <d1fea590e53cb1b00dc64f4f8a4c8aec84610401.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4dunbaywfh6hyso"
Content-Disposition: inline
In-Reply-To: <d1fea590e53cb1b00dc64f4f8a4c8aec84610401.camel@sipsolutions.net>


--u4dunbaywfh6hyso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/29 04:54PM, Johannes Berg wrote:
> On Fri, 2024-05-17 at 10:54 -0400, Kenton Groombridge wrote:
> > req->n_channels must be set before req->channels[] can be used.
> >=20
>=20
> I don't know why, but this patch breaks a number of hwsim test cases.
>=20
> https://w1.fi/cgit/hostap/tree/tests/hwsim/
>=20
> johannes

Pardon my absence.

I'm also not sure why these tests are failing. Unless I'm missing
something, the runtime behavior of these code paths shouldn't have
changed significantly.

FWIW, I have been running this patch on real hardware and connecting to
Wi-Fi networks with it for the past couple weeks without problems.
Though, I see that these tests are probably testing Wi-Fi modes that I
am not using.

--=20
Kenton Groombridge
Gentoo Linux Developer, SELinux Project

--u4dunbaywfh6hyso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmZfYsNfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t54qNw//YhiRFppe9p3LZ2rWSH2ANit9/KoWnRDidGoCAiVwfzWshSxXBhSt51pg
HFF6TbdPnpbRE80APNY/PHmbDm0U+kRq8+6B/OCHcop2Yl3DktBc3Yn4uhUCosl7
r9lwUAOtUB4npMM1r+FeXkHxWgW8cZRn8T50DlpVeQN+23f0g5uzIbrZqYKCFucb
mmxVXrSpkB4qgSGOUiMpsGBk73yyrsGSujH1df5eaclp4uvebGys7lhApdRmJg0u
A0T42vwe7Uf+snt35W6BdAD+jiY/2WnEUCPnesPbde3maYYnCPZyzPUtPshScHk0
WJA2LtDk9bSAE/OTwV2GfHdvensMp+ck7CEac1Ub1/INtZU+DJTv4Pa8wFGyUOvt
edcXsvu4IOYx6ZtGc26z+IqnbLH2XNwNN3LvsabV3fUOtKLfQ7P47cg0C12AcEMZ
MX8Qdy0yhZnYfdlaSNDUlKgiy7V0v0j8xc0lqXrlmy1b3R2Nor72SolyKUSmd8+a
+BC3FvzE5H6U7alhW5QpbdZvBaPUThwxDa/8IaIMNjHrh+BWaTEJ9dv7VAerGB6H
OONq7eX4lsut95clnch6wf3CSYAgkDZFqKh0oLKv+vh+GxkgPNMp9Rt6UOUkcR7T
9DIDzMVcV/ZNopIHznAP8rLKNf9DEOZ7mdJiW8n0anc7leMoTBo=
=Do6D
-----END PGP SIGNATURE-----

--u4dunbaywfh6hyso--

