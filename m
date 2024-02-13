Return-Path: <linux-wireless+bounces-3531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB4853083
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9DC1C23622
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47D3D99C;
	Tue, 13 Feb 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HHEBEYK6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039E249E6;
	Tue, 13 Feb 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827436; cv=none; b=JMD+15ntwLjcLjaGnvVv3edgSsE98dRwpN7eKVEzi2iHH+D3w2yOGSvzJyI2Ah3qEPs8AsCR99tHRQZLSAw8jRmXd2PYpkCqQlYRU8HjKc88mnH6qF+gMSArXysbqNwulWGxIJtM87i6Iv3+H98gkJB21G0Q9YB9PbcNrmmQikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827436; c=relaxed/simple;
	bh=L+EHC8lQsNCgjxPmtkdpGIshFKAqn0+/EipMZbxJYD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsusZwd3ZW6UYVo82x2nWFE2IuJ0rf1WQ2Ox46cR2VkIAyfUDkgkI+DUlVRp3OeVW5YOu+t3vdhMa9p9ffyGRqSx6XlZ9nb9skgYVj/pFf3xQJrdJZrm2rnN13K492/ysrLO5HD3av9eOAs3foXTrPR2Lcvs6k2lNsG1rlD/n3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HHEBEYK6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L+EHC8lQsNCgjxPmtkdpGIshFKAqn0+/EipMZbxJYD4=;
	t=1707827434; x=1709037034; b=HHEBEYK6ZAt2LVwSIN8j/lW/kQ/GMPLPOo3KlWT1s69LzjT
	sgfhD0ttlmahakK09kHeyTiaDJN4+Ts9TrPfpxxfTdWeQQAkRRw9dVNhnre+d6coxmV6qxZwBpUeb
	KNczIetNB8fQ2o5CdOpdjtjgYZOY9P/TuyFdSG7ksG0NuWWKN0oMlC6SeoBdIoyXalWg+5HEVyPMM
	GIWXFEOQjtoOLAJR/AvUbVJRNYcFgEMk3sfDfpDOHz/CSh8mTx+c+7PP20R6xL+Ke26AcDP/P8vjK
	D7e5YJPkU/9qbkAd0LverivJIT97h5HZwjgZvfst0YRRziJqtTqYyV4l8Xsc1Dbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZrvk-00000007gMs-1Mp8;
	Tue, 13 Feb 2024 13:30:32 +0100
Message-ID: <ca517fb19f78e3c507fd315e2f30e5efa4723eb8.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo
	 <kvalo@kernel.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 13 Feb 2024 13:30:31 +0100
In-Reply-To: <6eaab8fa-f62e-4f78-9cbe-9b13e3d77ca7@broadcom.com>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
	 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	 <b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com>
	 <b00c3b53cd740e998163f84511ee05dc3051ce8b.camel@sipsolutions.net>
	 <df8f02b1-25b0-4dae-a935-cee9ba7f3dc4@broadcom.com>
	 <0cb1d7ef63ad1ea1ff4109d85a6bcdcaca16f1c8.camel@sipsolutions.net>
	 <6eaab8fa-f62e-4f78-9cbe-9b13e3d77ca7@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-02-13 at 13:19 +0100, Arend van Spriel wrote:
> On 2/13/2024 12:45 PM, Johannes Berg wrote:
> > On Tue, 2024-02-13 at 12:13 +0100, Arend van Spriel wrote:
> > >=20
> > > I recall the rule was that nl80211 API changes
> > > should also have at least one driver implementing it. Guess we let th=
at
> > > slip a couple of times. I fully agree enforcing this.
> >=20
> > Well, enforcing it strictly never really worked all that well in
> > practice, since you don't necessarily want to have a complex driver
> > implementation while hashing out the API, and the API fundamentally has
> > to come first.
> >=20
> > So in a sense it comes down to trust, and that people will actually
> > follow up with implementations. And yeah, plans can change and you end
> > up not really supporting everything that was defined ... that's life, I
> > guess.
> >=20
> > But the mode here seems to be that there's not even any _intent_ to do
> > that?
> >=20
> > I guess we could hash out the API, review the patches, and then _not_
> > apply them until a driver is ready? So the first round of reviews would
> > still come with API only, but once that settles we don't actually merge
> > it immediately, unlike normally where we merge a patch we've reviewed?
> > And then if whoever did it lost interest, we already have a reviewed
> > version for anyone else who might need it?
>=20
> Sounds like a plan. Maybe they can get a separate state in patchwork and=
=20
> let them sit there for grabs.

I guess I can leave them open as 'under review' or something? Not sure
we can add other states.

johannes

