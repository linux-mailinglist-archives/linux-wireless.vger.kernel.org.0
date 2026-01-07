Return-Path: <linux-wireless+bounces-30417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB22CFBC94
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 03:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C693020CEC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13C21323C;
	Wed,  7 Jan 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="klStt1cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBKDCPsv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44980800
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754653; cv=none; b=f5oZVfgv0GyauVIUKBkeANpFZ+zfWVN8HuYz1RLFqpNffwjreUDk67GJ+IscA0w8Rk4qPXc88OqEZlDpTL/6aDfYXiDc0I4uk6rJ8pRjnaD0FVpTt5T4LAUWwc+1K0fNVBpxE1hYqZorPwFJ/SGuS4vTDjUi2JxesqOe3RzCui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754653; c=relaxed/simple;
	bh=6IC0KqfjL6DuGVRuhP8dTyUTfDwMrkHlEAOYovDMF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLAhaqIQKeeT7/VBnAHgSE0N8qk4BL//71CSk2pBUYtVimlAwmLdurD9SDys0f1yQrUhNT8q4srxFjxPiXMx8LXmgZHqmDlcHKGLaDJeLVu/r7F/psHyzmcmxyE1sHMwRQoWneeeOrDNQsr8rlg6G17hDsWlHXITq29fWcyn8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=klStt1cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBKDCPsv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73D657A00D0;
	Tue,  6 Jan 2026 21:57:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 21:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767754650;
	 x=1767841050; bh=wYIkvz3pRlHzabcujWopBL2r96dnBGp9F8c9D5faYQw=; b=
	klStt1cbL9GHKvu9olF/78L3svkJ/pIzkb7OCL8RTTfFynJ+K0UqKq9svbbovl35
	uxkZCpWKJzGGLwr59KSFSEicoMhtG/jZAhB3Q540QpVmzazJ9owTvXu/Vdi/WHm6
	4x5FjvBtljWPFKd69ia/lfxHgPsFlPhMTbMvnWhjrNf2QI1WZEvGAkAi6fAfGHGD
	3o6dNr1cuPeCVrjl0DYbIr68Q/Em1H+oUHBKnydzzCO90m20TpXStoG2ML/FsPy2
	J3XjeeNaUfWZjE2wgHI7Dt4/ZaZ78O/YyRGwCSwiVY0hSwiINZNlunaRJzw0Y4vI
	pC5bFzOeLFuhfG+xi6w1zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767754650; x=1767841050; bh=wYIkvz3pRlHzabcujWopBL2r96dnBGp9F8c
	9D5faYQw=; b=nBKDCPsvKyPEDySV1A2QqBDwRk+dhDKGl74TXrpzpjiA1pgtJGh
	MMM5Zjh0//v9qpPNrpqwqBuCH1OXdJ08fV635xLVZIL4M1U+zceZu1qYrqHzT5Ht
	RaYLu5sZD9SC0PG47zZcQaXUEJmy56Tr8zpFRtgaMezPsd1MG85DdpAd263hrlww
	6Ze1Zp6lRy+UTIbuSlqvyVdTNX75J5D3Kr61arsDSSzZvlBxa3FViylzn5HULkFU
	+dQQ+SeZ/9Kyx6ZRLY53Jp4plAwl7fppopR0vW05VDd654ptsUzJClb5Jryfw2vA
	JOsivpevuixEAmzjuHlBdHbAypkRa7Nl2xA==
X-ME-Sender: <xms:mctdaQXFMVbiT2HofQVBccYhXMvJzQFbWF7p098qH1hS2wGNywbsTg>
    <xme:mctdaVAXcXJcQ-RDkBChU7M2dMkUoE3fkXRWF5GyTSGZf9EqfG6yma9YpbaCFmkDG
    ZPx6TjtVngiOliQDAsjKJ8DdWQwjdrz4YCvNxxIaKhTLGAY>
X-ME-Received: <xmr:mctdaVHJ3_txXorwGkYJyb1eP372Z3vmJjfXdv3biGjsuuHg0wxdpA6JTXbtqnEqYjoJPFkrQJ3Dw0MKPQb8sT2mR7SVQCzjWuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfduleet
    feevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepledpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghm
    hhhuihhsrdhinhhfohdprhgtphhtthhopehnsggusehnsggurdhnrghmvgdprhgtphhtth
    hopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhiguvghrrdhl
    vggvsehmvgguihgrthgvkhdrtghomhdprhgtphhtthhopehshhgrhihnvgdrtghhvghnse
    hmvgguihgrthgvkhdrtghomhdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguihgr
    thgvkhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgvkheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonh
    hssehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:mctdaW5kn5nxiLZNMQ44XBUgfZ_TWzEr2OuFvveY1HdBJtqxiiJyjw>
    <xmx:mctdabnPJgqiD-PWQ4BMl0vIdqzv0wJVVj3IsPzTz-fDCwDwzR66fw>
    <xmx:mctdaR6pJ07kZ4P4adPCWqE_niV1tfkXW7Phcp21usDQChe1wN8Ctw>
    <xmx:mctdacTNmTCaC5htjVIrE2PWw1-CwdB3CUr6VIAN5cG2IS72mOhzEg>
    <xmx:mstdaeLInjIDnLMWkDfLU8-lPszkrmwqe9B0aXkRLPw-A8ad78YfN1CP>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 21:57:28 -0500 (EST)
Date: Wed, 7 Jan 2026 03:57:26 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	regressions@lists.linux.dev
Subject: Re: strnlen buffer overflow in mt76_connac2_load_patch - 6.19-rc2
Message-ID: <aV3LlrckZUqdvJMG@mail-itl>
References: <aVBCFKub6vCFsFVB@mail-itl>
 <6beab0bb-ed51-491a-bd64-15f3455ea628@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCMpHQ2JrlxTEmeZ"
Content-Disposition: inline
In-Reply-To: <6beab0bb-ed51-491a-bd64-15f3455ea628@leemhuis.info>


--tCMpHQ2JrlxTEmeZ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jan 2026 03:57:26 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	regressions@lists.linux.dev
Subject: Re: strnlen buffer overflow in mt76_connac2_load_patch - 6.19-rc2

On Mon, Jan 05, 2026 at 02:44:28PM +0100, Thorsten Leemhuis wrote:
> On 12/27/25 21:31, Marek Marczykowski-G=C3=B3recki wrote:
> > Hi,
> >=20
> > After updating to 6.19-rc2 I'm hitting the following panic on boot. It
> > worked in 6.18.2. It is a Xen HVM domU with PCI device attached, this
> > one specifically:
> >=20
> > 02:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi=
 6E 80MHz [14c3:0608]
> >
> > And the crash is:
>=20
> This looks somewhat similar to a report from Shuah Khan and likely was
> fixed with af7809f037e6e5 ("Revert "wifi: mt76: Strip whitespace from
> build ddate"") in v6.19-rc4. Please let us known if that is not the case.

Thanks, I confirm it's fixed in 6.19-rc4.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--tCMpHQ2JrlxTEmeZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmldy5YACgkQ24/THMrX
1yy43gf+N+KfA0eFcvyuCW6TxxHbai0PBuoloCzovpmVTs2+cVf382Rxcz3alc4J
NBZQKQYz+Vir7vg5l+lV2hjOPJ1B2JsUrMcIwg8LvBNy8NnhIEOPBJUiNxlbA3kd
0jCSo/A8OSVkgKKLbgMl9LcLssSCAxdDhooCq/kUermusiaROIVNq68wxCEH7NUW
Tvi2q0WXhJN8NSu/tW18kjh+O5b3U92E8SYkBP5ZJjEP7+5M1Qs+LZQ/CTnHahRK
IakrRWZpBUmJpdglbepWVLi+6/zJDJEYTWUBUonQCiSmRDNM81iltJ0gLht+GFkI
mG13MaqJI304QAVi76WhharbXrKEiQ==
=UUKT
-----END PGP SIGNATURE-----

--tCMpHQ2JrlxTEmeZ--

