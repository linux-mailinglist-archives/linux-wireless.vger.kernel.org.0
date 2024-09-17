Return-Path: <linux-wireless+bounces-12908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429ED97AD74
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19171F22DBF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D415748F;
	Tue, 17 Sep 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DYd5TVZj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5D158203
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563693; cv=none; b=aq+A+lCbK9y8o2Q1jaAScw4BGaOnggb0oxsUi9yc/AS1VoUrnB+gSILiIp54KqxdGH9OuetBmvV2FA/q5Mr9Pvlw0ac0b3z5//pZVjD28C+9sNublH9rpktffsPgPsZEohMggj+N67xsOO0SM4j7rahZsoM+VH+qK7Jdm2zUBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563693; c=relaxed/simple;
	bh=31CGZpw0k5Vj53jEtmeLDjIVZ+sK7rWkwz6DAgOwXT8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZAFQsnA5BTM4GEumZcRrH4Yu8+I88ndNvvhmz61o+ABNLEj+YT+Hi3bGc792UtOJLmKhoMGm5WAgjuNFeqdpErwxNDAVWFBauHbvQa5H6v9cFldfOEX3Ln9AeoKAU7/Oa2Jyg/KUeAnABmPY1rjgZLAlQzrEFk/mCtyK+m8p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DYd5TVZj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=31CGZpw0k5Vj53jEtmeLDjIVZ+sK7rWkwz6DAgOwXT8=;
	t=1726563691; x=1727773291; b=DYd5TVZj6t0Xr/X6Etd0gV/L3eMALmQfUj8gai6NNjWH8Au
	H4YEZRo8jgvEHLk1ZTDX+jlKnfZCfulAV2+UeuhaPfAg459Srn+CvIS1iQ2FHmlpl4kgIS0HzoYnV
	v1JfKCzX8woFdrb+hR9wEipQ3cUB356Hrh6pkT7OUWJ1HE6cUpHK4g6GPMH9agf2/LJ6mmN9jt2IP
	ljPKVPtQBGhlknjjMTlDgtt+RHXxqQG9fk5Ya6QWPp4yIRbjFlKw2y9cZdzZib3+2Up1K3bPeGG2B
	6z4WVhp5oCMrl+WzVuNu5V0WhvClloUFnIfan/kOiNLM6jPGx8LDWhAO8pjLzYZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sqU5Q-0000000E6NF-3L5V;
	Tue, 17 Sep 2024 11:01:29 +0200
Message-ID: <29b0fe777228cedfa219fc8268b6a7fc8c04164f.camel@sipsolutions.net>
Subject: Re: [RFC 5/6] wifi: mac80211: support per-radio filter flags
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 17 Sep 2024 11:01:27 +0200
In-Reply-To: <4193632b-7eca-4dcb-b40a-982b3bf7705d@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <7a871d4d2ce7adafb14cf971c1fdeb9cd01a4169.1722885720.git-series.nbd@nbd.name>
	 <163ebbf7c79d6aece2744be84d88264555f352e9.camel@sipsolutions.net>
	 <4193632b-7eca-4dcb-b40a-982b3bf7705d@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-08-23 at 18:26 +0200, Felix Fietkau wrote:
> On 23.08.24 12:20, Johannes Berg wrote:
> > On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> > > This allows drivers to improve filtering of unwanted packets when usi=
ng
> > > different combinations of filter/monitor settings on radios.
> > >=20
> >=20
> > Here, it would seem to make more sense to simply give the necessary per=
-
> > interface information to the driver? Drivers likely have more
> > restrictions and will need less complex data structures (or just
> > iteration) to figure out what's eventually needed for each hw etc.
> >=20
> > Some drivers might anyway even have different filters per interface,
> > even if they're operating on the same channel.
>=20
> I can do that as well. However, I do think it makes sense to have=20
> per-radio tracking in mac80211 as well, because I'm pretty sure that not=
=20
> just mt76, but ath12k would also be able to make use of this.

But if you have per-link, deriving per-radio is effectively trivial, so
I don't see why we should do the extra work to track it?

johannes

