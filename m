Return-Path: <linux-wireless+bounces-3527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3395852FCC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8564E1F25824
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358C376FA;
	Tue, 13 Feb 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GWAL/zXk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637138DD5;
	Tue, 13 Feb 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824735; cv=none; b=Wk5DJqZvh0+kioKDkheQ6fESHGzzKU+ymkhpqL3Nr3x97FGWauicOVfRoA2VsCFg39c90YQ/bTG5jmDKLK7W5ZrLfR/ObbqOt+HiRu0BDE/JtobRZ+/ABCA9eq4eL/5NEM14ut0wUbPKpO2ppnD8Yah9ulMsusHFf5aEEbX9R2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824735; c=relaxed/simple;
	bh=nUCaYtxHdFB7BsZxrrtCEekTv3bK5CO8RmQpic8P8KA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZICm0lltNWPQ2cvjaCEJi8h+m8YjfyVS2nG/SqdEpGysH/4wYaoh+XfE8RI+jXfoQQ16ZESo2ScUNkmM/CVmow+bxppCYBV/y1Q65fxZ75h10th2hbJEoZ+RpeiMLKfex4YZ35yck8BPtMYuRvAXydo4BWiJBx9QEPPxP/x2eMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GWAL/zXk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nUCaYtxHdFB7BsZxrrtCEekTv3bK5CO8RmQpic8P8KA=;
	t=1707824734; x=1709034334; b=GWAL/zXkPsF3SOP/4W8VKXIda7+9YkAZ+GTwrpxTH1Yz/KE
	9MJCnqrvL5qg8IMUJJQO2CbaLcrdJy6lVA6yMRB3FZ0ggBcKW6u28t5nezar9i8h5fU0chQzRZSbY
	24g9OOpy6MXCO7/7SbIf9VjMWnC6VxiJK068KnpytViNGeK39MRCf+vsT7yBNLWuzOs4lrvSKhl2t
	qw9nix6W3o7bfc5dpfl4bI4VLxjhWLi3+D6XK3zQ9fLcU6zUgA6MgNwcgXcFFuuhC4jSY0+ApMJor
	ArcmHP6KNG/UO86OW/+Rej06/My3ly2uaqMCiMjKKw0h1+sXwP3JA1q8FX5rDRGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZrEB-00000007en6-2Lnp;
	Tue, 13 Feb 2024 12:45:31 +0100
Message-ID: <0cb1d7ef63ad1ea1ff4109d85a6bcdcaca16f1c8.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo
	 <kvalo@kernel.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 13 Feb 2024 12:45:30 +0100
In-Reply-To: <df8f02b1-25b0-4dae-a935-cee9ba7f3dc4@broadcom.com>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
	 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	 <b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com>
	 <b00c3b53cd740e998163f84511ee05dc3051ce8b.camel@sipsolutions.net>
	 <df8f02b1-25b0-4dae-a935-cee9ba7f3dc4@broadcom.com>
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

On Tue, 2024-02-13 at 12:13 +0100, Arend van Spriel wrote:
>=20
> I recall the rule was that nl80211 API changes=20
> should also have at least one driver implementing it. Guess we let that=
=20
> slip a couple of times. I fully agree enforcing this.=C2=A0

Well, enforcing it strictly never really worked all that well in
practice, since you don't necessarily want to have a complex driver
implementation while hashing out the API, and the API fundamentally has
to come first.

So in a sense it comes down to trust, and that people will actually
follow up with implementations. And yeah, plans can change and you end
up not really supporting everything that was defined ... that's life, I
guess.

But the mode here seems to be that there's not even any _intent_ to do
that?

I guess we could hash out the API, review the patches, and then _not_
apply them until a driver is ready? So the first round of reviews would
still come with API only, but once that settles we don't actually merge
it immediately, unlike normally where we merge a patch we've reviewed?
And then if whoever did it lost interest, we already have a reviewed
version for anyone else who might need it?

> FWIW I am actually=20
> planning on submitting brcmfmac patches to support=20
> NL80211_CMD_EXTERNAL_AUTH.

Cool :)

johannes

