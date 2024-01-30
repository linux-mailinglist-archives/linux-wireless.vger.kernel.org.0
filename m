Return-Path: <linux-wireless+bounces-2805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872378421F7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1CB1C20F44
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8565BC9;
	Tue, 30 Jan 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uyt01WU5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE65BA9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611891; cv=none; b=IkxK7T8y7+mCrIRHb0AwD1IpW6G5IcWZ/tqb7Jc1PGjfGfGAS2KFSTmmrMw3k6O5FU6zsN/RdfS2vJyBawKrAEwjsyMaB3wwXylJf3msqBqdDs7gaKPhyhPeinvXMiGjWvNl7wSKHCiHTf/ws70fSe+gdooBy7htlHb9GGNrgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611891; c=relaxed/simple;
	bh=/3Uix+JaPfK2otPrrpKfccKgdDveq6CyUGuhxKK/sHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRoGy1I1UJ+y4wKGj4KGo1TNff/Qw+YayMDY1dMiXPPbP7SxD+QLwulnd7yT5Gt+uP63EpButqP+DfDJUKe4qqTs3ETf/iscRbNZ0k07MTALCZrAfL1tiF6/xn1q9WOhNEFNchHNUQ2HJx1Tprgk3rRBUHMhHZLDurum+txYGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uyt01WU5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5RsGsoiuI41+sE2YILWCtSBAUFDL5i/E2SCX0c5J/88=;
	t=1706611890; x=1707821490; b=uyt01WU5SW1w119GJTqwSSWtZPLXpjpBh/QAm7DVCYfHHTs
	Ai7dbcwRKyRWwYtjRW89u36F+cOna1h47rsOUJjon0IEN56ihLvV1iryx7LyPgxchofzsMRuNEY3D
	tV5Cppk3qUpmOtNYyXEn0SNfEM6HLzMBWXq87Ad2P8TIQRANR7AVP1huE8Pfv5On/nkkfgDvHiu+B
	qJ1KndtqMdTKp80dhPek9CouUKMRyu6BSrBRByq9vyVwyuVdr9ZGNNUZEmA/SfdhUQx8BOePkmKCI
	AIZARhP9HrwtrVfTM8+TdpGDloV9n5a9oITRnysFPZzqnUhpUztab2NZ/Gb+HIXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUli8-00000005zwI-1Klh;
	Tue, 30 Jan 2024 11:51:24 +0100
Message-ID: <7e342de34398b844226ea53851cd2b081d8131ce.camel@sipsolutions.net>
Subject: Re: [PATCH v5 2/3] wifi: mac80211: add support for AP channel
 switch with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:51:23 +0100
In-Reply-To: <033151e5-7857-4c44-9b12-d8d8317a4139@quicinc.com>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
	 <20240125130410.827701-3-quic_adisi@quicinc.com>
	 <d4e77541479560147d453b7b5c06de3f940bad35.camel@sipsolutions.net>
	 <033151e5-7857-4c44-9b12-d8d8317a4139@quicinc.com>
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

On Sat, 2024-01-27 at 10:28 +0530, Aditya Kumar Singh wrote:
> >=20
> > Hm. I'm going to send some patches soon that remove the puncturing stuf=
f
> > and move it into the chandef (as we discussed elsewhere), but just
> > noting that - doesn't need to concern you here, I think.
> >=20
>=20
> Oh okay! Let's see if at all it conflicts, will send a re-based once=20
> those gets merged.

I did send my patches now, so you're very much welcome to take a look at
all that I've posted (and provide comments, I'd appreciate it!), but
*please* don't rebase right now or anything, was just noting this in
passing.

If we're happy with both sets of patches surely I can also deal with the
conflicts, that will not be hard.

> > > +	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chande=
f))
> > >   		return -EINVAL;
> >=20
> > Also another thing unrelated to your patch - I'm thinking about removin=
g
> > that identical() check entirely - you might want to switch to the same
> > channel with quiet=3D1. At least for testing that'd be really useful, a=
nd
> > I don't think it really serves any purpose to forbid it.
> >=20
> Yeah, we can do. But is there any actual use case? Also, what if some=20
> notorious user space application simply sends NL command without even=20
> quiet=3D1? There should be some check I guess?

I did post that patch too, and we're probably better off discussing it
there, but ... I'm not sure we care much about a broken userspace
application running with root privileges breaking something here? :-)

And at least for testing it's very useful to be able to do that. Agree
that identical channel and quiet=3D=3D0 doesn't make _sense_, but even then
I'm not sure there's a lot of value in not permitting it. With quiet=3D=3D1
at least it does make some sense still though, and we're currently not
allowing it, hence my patch (to be able to test scenarios like that we
saw elsewhere.)

Anyway, again, don't bother about rebase or anything!

johannes

