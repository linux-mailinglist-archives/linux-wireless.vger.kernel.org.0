Return-Path: <linux-wireless+bounces-8608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D248FE42F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1861C247DE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8A190698;
	Thu,  6 Jun 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CTFIn7Yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DED14A63D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669419; cv=none; b=MRpgGWwTdIeKSIkf0xI5kuk4KbIQylwpRtqWL22wdH5kA9Aq+aduUI+YCweGeKdHJs5gRiKQTq8ti6anIfTH2OZJFbY+a9kT6ayylqXd9aa8wyMMOY3WiJwFlYSsMbexcPl65LAqLwViWhT3ZG915YMPe3GiDdeBz7imTLhZxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669419; c=relaxed/simple;
	bh=1LGkwAY5MSDcCrjYTKHvpsAe+yXau8wwcu6b+Hq4FJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYMHrxtIGRU1GyolTUihpdqCKrztUY0W8CLTlrOu8rqzwbb/1ZYWWFJx7yPAVkyAML172mWBpMNxfzITWZHapT4DCptOyDiYVRjtW74/EhQfV398w2vqwsIXxP+cjJ7tNBmx7XfilXBt6rAYjjEh2ilwHphIeYuTaa6gZwpNqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CTFIn7Yx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1LGk
	wAY5MSDcCrjYTKHvpsAe+yXau8wwcu6b+Hq4FJU=; b=CTFIn7YxxVynJWSRClJo
	zXWkmItE+cdvVXmCX+K9dP3LgGQ/gEdP1A7UC4uND0CtGsymK5x2VopqKH24au7y
	vStlb3K7EDArIqY0iR72TJbQLcNX7T4jYopLuqsTGkM7/Vi0pvPB1BXDn0mMCtHp
	F3oA4VP0yhGxCqgi1yMehvJjYGkc8HanTIsCl/1dFUiHbC8x54fQ64cykXxktAU2
	ObyhGVnllejvgPrNvakf1KUDx8cgqyWgV+x6G3af4qc7FbRQkMIWYSrlPGjiXgIL
	ci+GI/wOBW6O2Vg/l+76FoAdP634+t+6X1OxvFqhEBh1+JIsFqaMYb55RiAWoKaF
	gw==
Received: (qmail 2961115 invoked from network); 6 Jun 2024 12:23:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jun 2024 12:23:35 +0200
X-UD-Smtp-Session: l3s3148p1@ts5TEzYaJuFehhrL
Date: Thu, 6 Jun 2024 12:23:35 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/6] wifi: mac80211: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <20240606102335.fxx3v2w3p5gkftz5@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
References: <20240603091541.8367-4-wsa+renesas@sang-engineering.com>
 <171759206880.1969597.15358870283165767535.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="govr4kkklfyoh4t7"
Content-Disposition: inline
In-Reply-To: <171759206880.1969597.15358870283165767535.kvalo@kernel.org>


--govr4kkklfyoh4t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The title should be:
>=20
> wifi: mwl8k: use 'time_left' variable with wait_for_completion_timeout()

Oh, that escaped my audit. Sorry, and thank you for fixing it!


--govr4kkklfyoh4t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZhjiYACgkQFA3kzBSg
Kbagpg/+IcNrnzhZdVztKRrrLoK5zWsY3z8dZRkaJvXakNIyjK6bxyTdWmdZh4sw
XWsmDAbsXQLtetE7B6sk1wtHTp52i/Tf6JVtcxUVGH2UucYW14pnA22iU0pOkuU4
tx6vA5l/mNURcukRX9rqCD2EzEFV5dmpmlqz5+jYF9xgRxxxnrOLIIErbYUN8B/B
AETfVaD7aCgG1ECAc4WkhY4Rbuv1NJngn7yxb5+GKqI7w/5fr9uI/SYz3WGU0j7I
rAgPkFn0FatsaDKFrB+O6ThrRZyYfQi07gX6MxgTen5ayai0ZUs1eiJdEOJwJAs1
ZPSNoF+gY1whKzKnI4U09CRMg1MVrfEO/WneKAkz45iL3J5Zwy4Nt157+XORlpMt
YU145ETpcoPCgRfzS79rkU9EKRdjwr8XVVeU10UHWrYFMvviOh+kMeQEyf4uaeHr
PV6sVz+l5VPHor6G74YdC8xKbG9VK0c9oozHKd9oSa+tpKGMNYdGvTTOHuWFD82q
LejfVRGIfrtRi32JmFa0x70r6DsnxsB3QKZk3nIqziro9gSSrL/gHJCLOEWmJGoi
2g6Vd/w9txWkTEsTnFB5IXLh2Cq+7JzeoXdDRderIMwq6zqrEqevABz0r8YoNGMm
CUo+BCXMSX095zVmeuOEW9MDfywFM81pceu9i4iNE2dB2nzCizE=
=XDGt
-----END PGP SIGNATURE-----

--govr4kkklfyoh4t7--

