Return-Path: <linux-wireless+bounces-25080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B915AFE166
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8967ACFE0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671322701C3;
	Wed,  9 Jul 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uPHamjPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDD26E703
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046538; cv=none; b=mubaBy0T6SclJYpvtUisQnhDFScxDTdVKoa6Fr/zm9mFNoRWw8ltm0DL6TKgRErueEsIPiVPhJTGAH4gaZPFCio2/jAEr4bBqtYKofHhSHm2tIRAact+jyb6/xnBIahK6b3HuUVYaoHWIgTbrn+QiziDZtdhMbz+IQ43Q3+px8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046538; c=relaxed/simple;
	bh=Na8vZDniEFoMrFDyU3PU41mV44Yb5XOwKD28HtafQ1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvQ2hqqBcxcLcwXMEjkKwIBdl/fhCeiEXPei3kWer0j3Ljehr/rHnBxtRFC4+STsy+kkL33xIoV9h2a6XJtSCXcJN7ikz2Rmp91FxgS27UUrL76kEDW2twKzq9yLJHkE6auuFmsWJhiPgZzKZELcZqa3jsIluODAi0ZY+1eGtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uPHamjPZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LED0uGQgEF5uQkF68tEOE3J2klCHMgxNk+/RECqTiDY=;
	t=1752046536; x=1753256136; b=uPHamjPZtTX1R6Q+/uU9pvW1B4KGtkEtf9TDqypthI1Jsmc
	qZN4fPlmvsKvdXHow60WLTDOTXf2iclKIOlL9CeRhCZzAp/yRiUZyRVesYdBwMNHZq9dXXdMXcQX4
	/3qDrHO4mC7zVV766HathzLowtYWeCb9duefUHzcY4dIgnKMsgdx9r8EiDQ9fYZ7TUZGRTOdIPXHs
	ZmV5gkRNIKST96f8qrQDVQVFu266KUBza2JqsnB9cXjXarJPwGXUt8BaHV6T988GxOTuZQx2tJe/f
	KkK34pwSG+bL/wA1VKmF3YrLbXM0uxvBJZLhR3hf8nBqwL3ahZf6fvFm6OAQZPRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZPKy-0000000D7XO-2KLp;
	Wed, 09 Jul 2025 09:35:29 +0200
Message-ID: <0ef5bed7464aba017f843ed493ca79a9c22688bf.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: make VHT opmode NSS ignore a debug
 message
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 09 Jul 2025 09:35:18 +0200
In-Reply-To: <c0058c94-35c0-40fc-b23f-93864baa9d5c@molgen.mpg.de>
References: <20250708105849.22448-2-johannes@sipsolutions.net>
	 <00a86131-3258-4a96-b223-4be0d020a126@molgen.mpg.de>
	 <abc76a87bf8b5fffcee18d64bfbd6c641c7739c2.camel@sipsolutions.net>
	 <c0058c94-35c0-40fc-b23f-93864baa9d5c@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> > It just doesn't seem useful to print the message - there's nothing you
> > can do about it, it basically means we ignore it and keep transmitting
> > with a lower NSS (which is fine anyway, it's subject to rate control an=
d
> > the AP cannot have any expectation on how many streams we really use),
> > and so it's not actionable to the user in any way.
>=20
> In some cases, people can contact the router manufacturer asking to look=
=20
> into their firmware.

Yeah, maybe? But like I said, it also shouldn't have much consequences -
it's perhaps saying "I now can receive up to 8 streams" but only
supports 4, so that's physically impossible. Maybe we could allow 4 in
that case, but right now we're careful and just ignore that instruction.
And in most cases the client only will have two anyway. Not that I know
the numbers for your case :)

> > but it's easy to tell what that value is from the association and/or
> > beacon, so it didn't really seem all that useful. Perhaps more to be
> > said for simply disconnecting in this case in strict mode, or
> > something, so it's noticeable to people working on this/testing it.
> Maybe. I have never heard of strict mode. ;-)

You probably wouldn't want to use it :) but we want to behave more
strictly when we're testing with APs etc. before they ship to customers,
we can get these kinds of issues fixed.

>  For the ignorant like me,=20
> having more details in the log message would help, as it=E2=80=99s not so=
 easy=20
> for me to capture and interpret the beacon. ;-)

Well, if we made each of these messages tell a story about how to figure
out what could be wrong, that'd probably be too verbose ;-)

You can see the values with just

$ iw wlan0 scan dump

and looking for your AP's data. You'd have to understand that too, but
honestly just knowing say "8 > 4" doesn't really help much either, you
still have to understand where the 4 comes from and that requires
looking at the details like that.


Anyway ... I'll just put in this patch I think :)

johannes

