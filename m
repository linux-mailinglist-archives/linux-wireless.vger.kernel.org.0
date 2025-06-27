Return-Path: <linux-wireless+bounces-24616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496EDAEB9E8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F40561547
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F0146A60;
	Fri, 27 Jun 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Qdq/fjGV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwN1jtOG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91985FBF6;
	Fri, 27 Jun 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034754; cv=none; b=ddkTnFtoU2MU5tSPh8swfm2xwI8ZLUZ+2YTR/sYDTLaOJdeBs2jSbUgXYc73MWzk+XKUU43/ct3k1fSHvh7k6jpGg5RQ8xSHNu/cSuDBZp7Z8iCEMzGFjPs896Z+6EPLEzfCCBFblmwK8H5yO9hIBrGNeM+JXVec9FY8sIGUvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034754; c=relaxed/simple;
	bh=FrVhbkkVKeQtsuNIVg2sLAXrQNn1Hy74XCRKIHnkmJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGhjPh6TFpi9Gy4sGYtUB0YtbpdMFiFrYriabFuQWt0NYoAwyFhoLuopdDIbTY5wIFsRGpSehOGiVmZvPlMbIW5UuttqX85vUE7pKDa5ZJhhQfV/WKmhsXuRJbsWWfts1cRBYyJ6hW6iP8m9hATFiz5IoqTYl7RhB7XozUpzdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Qdq/fjGV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwN1jtOG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D8E6BEC00CE;
	Fri, 27 Jun 2025 10:32:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Jun 2025 10:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751034751;
	 x=1751121151; bh=chbCjC3t9JjOmLOSGQMKEQ3r5t5d3Ytx0IJncZGWBQM=; b=
	Qdq/fjGV5338rPvsM0lAMiBopivn6bYP7Xdh+j3+fYbOzcVHOkIHmbqKIQ3FIgu9
	RiEV7kfiaxik20A+OoupeLKl0CQTMU0GeaIoIE32t4fjISrp8KLcFWAtX02fFrNt
	QyONhwtydqEcotsyBvS0ira/J5/m8Z+GyZY0mIFSs44gOg9MSWXYuwAZmx3bX+Pj
	uTgDOeyM3pg+d0Exzbr3oylcuWSKbDRE2d+pXbH8kafi9Oy062cKQqiHxcaIkTl1
	XgZWCXUnTo3kc/VpWOKJbON7hCy/RyO5jCmiXDlpjr3ag0H7w/M6vpu7vLl89wiV
	b/jVcxpQLmztUmyJLH+/tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751034751; x=1751121151; bh=chbCjC3t9JjOmLOSGQMKEQ3r5t5d3Ytx0IJ
	ncZGWBQM=; b=JwN1jtOG9PxlAdco/5FkbwEpbGr7xouXfDtEINjVbLOA335VEA+
	AancngIM76j0vgLMAWl5ZuuPmei8DI+3aSp0J7C5EBMc7HZj776JCKL8qLJXzmoR
	d/6dorb64lyBhqcqX01Ck00IumFZia4oLb0PCfNYaeZeUfh3q6d6wqAjM2EvkgPJ
	pBy0fWwfikOjElifnGbb0xpgPS9IPN/YSqCGG6Jt8xrHnndEWY6k6Glu+CcXsFa1
	ycDzwPK8MPbUb9kq4lsITqPOkmpgnpWb1Qu1LsVIad4JwGaUn31k+HF3HpM2VBQr
	sSYXCltzI2GkXCi8QZ8t5DDKQldXyJJf1aQ==
X-ME-Sender: <xms:f6teaDUVuMTHaB4DaOxKKuiMrM-I1r2pF0aVTuYo7Rbl15TfIH_XSg>
    <xme:f6teaLnBQPD4CFbf0w-JSYJ_SnD5e0P2UrETuM0UewBmOtqoiFQHyH8Oq14i4aFFN
    gbF0Q52RCxzRg>
X-ME-Received: <xmr:f6teaPYJi3VdOGOYa6leOQb4pcyxNDlFMjwXIRNjIA_AbOS8ltfHLlc-Yom4kQsIkqBDAQX6fNWTMply9GXEtZOzN61lVpBzfXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcuofgr
    rhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepieeluddvkeej
    ueekhfffteegfeeiffefjeejvdeijedvgfejheetuddvkeffudeinecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpd
    hrtghpthhtoheptgholhhinhdrihdrkhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:f6teaOWt0b55a6C0BYUvxye25OwMrLA48TSn15K5igQmIdJKJP_qiA>
    <xmx:f6teaNmM4sKOgJuOw54bQolvNRgst1_3lUAAr8fydJeDvkQu8SvSww>
    <xmx:f6teaLeK8wsC6P61srHNRiVBIPRyfX0sAEmuVL2Y9PRdd9k9QfjQAg>
    <xmx:f6teaHELpOpp0amDhYynDwlKd5-sMErFShPm3ICh1QeCOmGskhz1eQ>
    <xmx:f6teaB80l4ijJQjBi1wti_YKQA05yOm9AdFUNC0MpCSJ4ChszBXmWkhN>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 10:32:30 -0400 (EDT)
Date: Fri, 27 Jun 2025 16:32:28 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: iwlwifi stopped working with AX200 (6.16-rc3 regression)
Message-ID: <aF6rfM-RFrwFyoEw@mail-itl>
References: <aF35FqJAw63NSl63@mail-itl>
 <aF35tbqxHtyj9fJO@mail-itl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4mRJGigGX3Xsa7Rl"
Content-Disposition: inline
In-Reply-To: <aF35tbqxHtyj9fJO@mail-itl>


--4mRJGigGX3Xsa7Rl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jun 2025 16:32:28 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: iwlwifi stopped working with AX200 (6.16-rc3 regression)

On Fri, Jun 27, 2025 at 03:53:57AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Fri, Jun 27, 2025 at 03:51:18AM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > I see the only change there between rc2 and rc3 is fixing that WARN_ON
> > condition. Unfortunately, I don't know what cmd_ver value I have there,
> > but apparently it's outside of that range (and yet, the driver worked
> > fine before).
> >=20
> > The device is:
> > 02:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [808=
6:2723] (rev 1a)
> >     Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]
> >=20
> > #regzbot introduced: v6.16-rc2..v6.16-rc3
>=20
> Oh, I see it might be already fixed by
> https://lore.kernel.org/linux-wireless/20250623111351.1819915-1-miriam.ra=
chel.korenblit@intel.com/,
> I'll test it.

Yes, it does fix the issue.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--4mRJGigGX3Xsa7Rl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmheq30ACgkQ24/THMrX
1yzvlwf/bo+OfRHbn4oHUi9G7NMHLS6YFNOdGC5vN0cgQuodid1A8EwsekXbID12
xxorMjqSx1KzwZO+JLG5ZStXxK5yZ2SIJ6bwA2WS7625jnxxOXaXOuUO/GoJWfd8
e7F1HFxP9eYXvjKA76qwIM5u8jCwWkHtZErGxfBfQrFJ5MVWWH15/VIZav5dQrNi
gO2MIK/EQQU6IIUf16Qr0ZiNc1XUJiRUtDmGdmswEOateUDryUjd3Cz6wKcubk1G
94tq1pBsXA+gtr5ygpDkPuCfx11IENO12gq98BaVFv6PwO2tzzyxaCQon7Gv9k3R
GkV1Tn4GOkHJ9dvvxkqFFcpr3W/0uw==
=OMSN
-----END PGP SIGNATURE-----

--4mRJGigGX3Xsa7Rl--

