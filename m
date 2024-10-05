Return-Path: <linux-wireless+bounces-13546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F3991570
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5721C217D5
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28E13A24D;
	Sat,  5 Oct 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="JXpf0GwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E97C6E6;
	Sat,  5 Oct 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118668; cv=none; b=KuAQMsY9KqG7j1g5ActspGcEiMIRhQ2U8SXHNDAs2Xc8WNuX0gt2eqZBWICc4B7IeioNptylrxJe8V4vxBU0eDj47Ty7Sm7xi2gmmAC/7Rx3iqfDt9KhBMW7GGbUygohvz1g2DN9ZY562sGLKeAM1LwUofPUkovUJK+DYvTP5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118668; c=relaxed/simple;
	bh=YPdkmCVpQ0UZvyTNBnnURDXvGoeZq5ryETvV2S+8z0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPDjqJR7FshpCXNTx8VuvBOVgRVK13HMk412s0pR2U9PMgGrxa+9Z64iOa0Ir56VvUjkZQN+kAyOpds+tpqby/GxSVQvFK47FzJncWy8DTa7n0qcRFMcbUlARtmu086egO85ZCyUeDQ5A6ZW3fAZ+Ddq+lHL4ZtgDCTlhpmGOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=JXpf0GwN; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E91E31C0082; Sat,  5 Oct 2024 10:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1728118655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8AAgexX2UIvTFew+SLdQRTXiaGWtOWDGi7blnIdzxNM=;
	b=JXpf0GwNGc7jsBcPfUzv87MJBiprUsJ6bUoqfPAklFpme1dYd4MQ+aXSy+iYr+6XOxG2He
	SAcHBtTztKomlhdMlxv3j6tBIM6Zt9EEcZhAlalI/DYthgWAZkeKPIDuxLLCbRbD2svmcV
	yCMYdzlLXMKf3tZk+/S7JoQlrGDobTQ=
Date: Sat, 5 Oct 2024 10:57:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Kandybka <d.kandybka@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>, kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 001/139] wifi: ath9k: fix possible integer
 overflow in ath9k_get_et_stats()
Message-ID: <ZwD/fw1i0jb4eKGz@duo.ucw.cz>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="od4V4d2BMfHmgNgW"
Content-Disposition: inline
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>


--od4V4d2BMfHmgNgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It may be good to introuce cover letters for AUTOSEL series, because
otherwise it is hard to reply to series as a whole.

Anyway, were 6.1 and older versions lost somewhere? I only see 6.6,
6.10 and 6.11.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--od4V4d2BMfHmgNgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwD/fwAKCRAw5/Bqldv6
8tC7AJwJSUSfDbXaRumFQ/tkMcAdNHOHwACfbrGZp2UyTdZ932iNBamevUGJuhU=
=0wTJ
-----END PGP SIGNATURE-----

--od4V4d2BMfHmgNgW--

