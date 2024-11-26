Return-Path: <linux-wireless+bounces-15716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF939D999D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07D2B27629
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AED1D5CD3;
	Tue, 26 Nov 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mteriEdY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961242EAE6;
	Tue, 26 Nov 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630941; cv=none; b=r79GTqAJF5X3Vga6Xb+DFu0DsdQ/nAfrkDaqjYcNqzhXRY4FIricV4jeEYlgdIcS8xivTkiP+fOcr0YfatjBG3fb8AeKNBtLPfACSjxfrgAESpqaLPnMl2h8mV/VfjvYNxkmur6h/eKQRE8oGjSxrrhbM8nw3BvvUmujPNJFVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630941; c=relaxed/simple;
	bh=2EzVIagoNzYPxG998YphblSLiqLt7DInCuQ63KCa+5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5BS462VPm+zowtAtB2wb8TC0caoVgfENOVTyfXbYKVZr3CIfdm8XJWm//sJyXaMnqyUQW+jgebFbvPys3ELGYOobP7eoTPaTgNcnxIm1GUxW8vwBhT9OimsVD0KGISJwyaY+Ec2T+KTPnnOIQd798y1t3hCgVw/cGcYeE4n3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mteriEdY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BU5JzRRyTpmAAxlTSDnePcgW44HdWNZdgnFK5O4fnAs=;
	t=1732630939; x=1733840539; b=mteriEdYfF+uyoN5TUK1DgPRr8ypFC0pWaOjfFLdJ69MNV3
	dc8Zodz1i7GrWNedid9KzAg6A0S4MMiFMNz6iRpK7b9Nwf5e3VfBRHDl0YHTPqEJzC3dCe40c0gwT
	nSCjVAX7KenawSX3lz18omHnGED4nAuJ82sCjUttniAh8/CHKaJAS2/+a7BpdC/sRYIqUkslnIppa
	MzWGPg12KsgSA8MogCWEWK2Mt3SUuhMIJrjZ241eLdHhetOpwSrS2IheUYuFJ/AQo6nud0gcXzAhf
	AohRyplogs6sszzpGe4r0tIHMFUQ1NrhCqCu1Pz11yjxhMymAUH9ST2MREVjta7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tFwSG-0000000FUBG-0mB2;
	Tue, 26 Nov 2024 15:22:16 +0100
Message-ID: <41242bd65b27736f6dc0115d2ad2422d5b157d23.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
Date: Tue, 26 Nov 2024 15:22:15 +0100
In-Reply-To: <CAMuHMdXbCaMBwjrb+ZJj+MMQvOm8Y=xKfaxVhYVb79WyO4Z-4Q@mail.gmail.com>
References: 
	<20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
	 <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
	 <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com>
	 <8221a4a01cb838159828961b6d8d99753ecc31b9.camel@sipsolutions.net>
	 <CAMuHMdXbCaMBwjrb+ZJj+MMQvOm8Y=xKfaxVhYVb79WyO4Z-4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-11-26 at 15:16 +0100, Geert Uytterhoeven wrote:
>=20
> Assuming non-wireless drivers can be converted, too?  As none of the
> classical m68k machines support wireless, so far nothing is gained...

Oh, most debugfs files can be converted, since most don't do anything
beyond simple_open/read/write/seek and those are covered.

> > Unfortunately this requires another set of full file ops,
> > increasing the size by 536 bytes (x86-64), but that's still
>=20
> 226 on m68k.

Not that bad, I guess. So if that's 226 bytes and before you had 447
we'd probably only need to convert 4 instances to have a net win :)

> Thanks, that fixed the issue!
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Great, thanks for testing!

I'll do some more testing of my own and then figure out how to get it
into the tree. Greg, any thoughts on that?

johannes

