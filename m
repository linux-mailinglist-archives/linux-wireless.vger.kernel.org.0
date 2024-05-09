Return-Path: <linux-wireless+bounces-7389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB228C0E90
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 12:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9394D2811F9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590712FB1B;
	Thu,  9 May 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UTy4D9Ck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3E12F37C;
	Thu,  9 May 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251985; cv=none; b=QDPe2NL4kOZsCdYHiJXAj9J97Sb9OTyg7SNLjgQBjsoyaXCsmModUwwDpIhH+UyqyV1+W3qW4K+aHouDUVIKxmf5oIzG5k6lR2cQnRTk7a0bRWxxKh7giwwJM+0P5XZOHAZ9UuCS4L6s3u4xG1x8RA1gwjjGaiXUCcWPXLdykVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251985; c=relaxed/simple;
	bh=TkwNWDqoHA+H+7j4DdwcM/R93W1nTiD50C2NF+X+k2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrLIcjmkUXuP6v0TsTKx0l4PJeZDdPawm/SNIrmUQtRnr8oWonZLTMPI0saDk42Nh+la3H/phAT06tLsYp6D6/Vq1ujrvAGczJV1Y9GfDBUxNHQLvl5txw3A8283qSwluKvsG5KLOWrYuQ5SSnQVO63TUBOlFTQ43137jQIeG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UTy4D9Ck; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e7z0v/MhjoIRCMcX4IPYi9XvMRKn+UlhFSRYOf0bl00=;
	t=1715251983; x=1716461583; b=UTy4D9CklN7Fl5pTZwiHsuxnMuRHtTU6HiEDg2yl+RtXZ7B
	2qGmVGdf/YwsdZXsRdvGM2TulwtO2PGwqFxcNdyRGf6vwSFibSpn3m/gCeU+yOkDOuUGhATYUxtXX
	4pCdmknlm7hfYA2fZ2mCB3iKTRqvF5mie7DvxDjdQJ2rpXGCBqrj+PeY/tRG9SCk2oWbHLvCHoJ5Z
	fAJimjXteve3s+7qhed1VqFzkWK4bfbpNpYKOXZmn8zLh9PVbEjuG3o/bNtbTNKv4E9aJXU38HCNW
	Q+MB8DLuBpiw5ObKHBgs0/5R3ROYVWSPzh7bib5NglDT3+aNLJyTQ+vBwqncMWxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s51OT-0000000D1B1-2HJC;
	Thu, 09 May 2024 12:52:57 +0200
Message-ID: <161df39ee89ae640828d3226a8de3d60f786ddd7.camel@sipsolutions.net>
Subject: Re: Fwd: UBSAN: array-index-out-of-bounds in net/wireless/nl80211.c
 and net/mac80211/scan.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Jannik =?ISO-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
 Linux Wireless <linux-wireless@vger.kernel.org>, Jouni Malinen
 <jouni.malinen@atheros.com>, "John W. Linville" <linville@tuxdriver.com>,
 Kalle Valo <kvalo@kernel.org>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Sam James <sam@gentoo.org>
Date: Thu, 09 May 2024 12:52:56 +0200
In-Reply-To: <CAFqe=z+bnNayKaxEnEFar28Q__yZ9Byaxe3YwtMaBEsASG2VwA@mail.gmail.com>
References: <ZjwTyGqcey0HXxTT@archie.me>
	 <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
	 <CAFqe=z+bnNayKaxEnEFar28Q__yZ9Byaxe3YwtMaBEsASG2VwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-05-09 at 12:49 +0200, Jannik Gl=C3=BCckert wrote:
>=20
> > (Seriously. If you're running with bleeding edge toolchains that pretty
> > much nobody has yet, send patches.)
>=20
> I'm not sure what to make of this - this bug has been around ever
> since the code was added, modern toolchains just happen to be one way
> to expose it.

No, that's incorrect. This is perfectly valid code:

 struct x {
   int n;
   int a[] /* __counted_by(n) */;
 };

 x =3D alloc(sizeof(*x) + sizeof(int) * 2);
 x->a[0] =3D 10;
 x->a[1] =3D 20;
 x->n =3D 2;

However, the uncommenting of the __counted_by() annotation will lead to
a complaint.

johannes

