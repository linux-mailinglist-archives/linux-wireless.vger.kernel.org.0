Return-Path: <linux-wireless+bounces-13563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FBF991699
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF30B217A3
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C6146592;
	Sat,  5 Oct 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="eN8fdUbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6E82D91;
	Sat,  5 Oct 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129810; cv=none; b=Cww7GmQgwXJHZKGvoC/ftrwoR/1gN76pIsqt1qV093qIyY15ZIi0bZ6tk1o34Wl5OI23Ol1e36jHTVRlbQoqObomrbmy70Ra42gIwrz7uSSeKwt+IGPhOqqccFJIxxAIJrleXr+bC92gktwj/vNNNOk6M2hibCfrqAhPCA4+JXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129810; c=relaxed/simple;
	bh=9mtijN81xJRjYr0gLnpqcXgGoYXvT8lemZSa7MkuvTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJe6pGr0SLiStdJ25h3gog5HzLPY3JVNYeS16ZryP5B8zmYmJwRw5It9k7RPzmZ18eP9meZVTB3iEM77hoqBEHg/0Y2KcwbW1EsVyiGhltGsBiu/LtuMl/FTbsyn/Opv7VGW6t5+P1W13XBtuuz+MO/jDeiXMH4M9hLPEsbb5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=eN8fdUbf; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4146D1C0082; Sat,  5 Oct 2024 14:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1728129805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7NDkyf0iwm2gnyaUpSRGeKfXNBS1rLyuTX2Bw5XG/HM=;
	b=eN8fdUbfXrT0ukxGQt20JBiQdNBQbVfKpXe3HPMnI+KphCsP9/O0cKqsmayTtGH9keWRqh
	nR/u5ZCD4xM6djsWujsDjHvfMDXSJe+6W1hhfFOSgVdZSC92dWK7FW/+HWf2UPLOH4ydG4
	e5qI3NRQB7eaGob8715/ljrgZ8+co0E=
Date: Sat, 5 Oct 2024 14:03:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dmitry Kandybka <d.kandybka@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>, kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 001/139] wifi: ath9k: fix possible integer
 overflow in ath9k_get_et_stats()
Message-ID: <ZwErDNbgsNTXQGVF@duo.ucw.cz>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <ZwD/fw1i0jb4eKGz@duo.ucw.cz>
 <2024100542-chewable-unbent-f099@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDMKIG6KycKKoaMW"
Content-Disposition: inline
In-Reply-To: <2024100542-chewable-unbent-f099@gregkh>


--sDMKIG6KycKKoaMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2024-10-05 11:06:22, Greg KH wrote:
> On Sat, Oct 05, 2024 at 10:57:35AM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > It may be good to introuce cover letters for AUTOSEL series, because
> > otherwise it is hard to reply to series as a whole.
>=20
> Why would you want to respond to an AUTOSEL series as a whole?  They are
> individual patches, the only thing that links them together is the
> kernel version they are being reviewed for.

The part you snipped explained that:

Anyway, were 6.1 and older versions lost somewhere? I only see 6.6,
6.10 and 6.11.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--sDMKIG6KycKKoaMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwErDAAKCRAw5/Bqldv6
8tGQAKDD/Sbku5qv0s3JD1gxdSw4WV5pygCfR7fG2S8J/PLY3xgToGfex7qyJm8=
=stvi
-----END PGP SIGNATURE-----

--sDMKIG6KycKKoaMW--

