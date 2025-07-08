Return-Path: <linux-wireless+bounces-24911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355CEAFC536
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8659A3B22C0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A42BCF45;
	Tue,  8 Jul 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qX+QuzYQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331229DB78
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962550; cv=none; b=Fj7jUmD8F7ey1s5eLASFD/UrLgQv1fqOEqiqg87WBmcB/9jPo9GkBP8YKQXULjZvVRaLMuzgwAHv6K29pAhmLgObq/ZBlnXvKX3oe+j5qJ/nve6apc9ifVQYwpSgmeF5GadQE2m9tx9p+qMvzk9TYfNAbJXPTLXu8ZH1/V56gL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962550; c=relaxed/simple;
	bh=9jNBJl0BrzBSO5Xm2wySYyagOtBVNDbdYmXXP2BKpBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tX9gF6M37Qaalm6fvJnXBqcU1GRvWzYLTmJye+rWDmYyJqepLmG6xy9hNJyIeZmBQZULQ9Rh4z7EIplqX8454jAczlVnntjPcMS0ESpc6B6Hxxu/YHd+gxC/TTRA0G5WCJNfyBtdWSP2yyytgRTnGIW9u+dJziKMlOFl98T9KgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qX+QuzYQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DYFOjsUH93gHO+pHkHitdxRE7OMqsvkBw857jMbfkT0=;
	t=1751962548; x=1753172148; b=qX+QuzYQIJkjQ3OkPTbNgS8C0S0Tsvq3/mU9yWAxyIK7QcS
	ZkjrbXohMV/LL0usqo7KefH+ZBIJ4kQStJEvILbIm7+rSm5gZFu8yfnmgO1TnGLmyh7ElEcplVMmm
	fZsS7yJcj22aRzQrqjVVfNp8r5Q05iqIAPp6ouRukBM5IBXxCf3nzn0DdWzBodEn5JHnjhVAiubsP
	+EYkvFPXRt/spRugA42PdqKvGsDKGSv65w4wYI4MFNmqirHvy+qIuUKW6HiVfUD4a1+q6kcuaWA4B
	sepjUY6O89Rp6gOcmUtNkY8fHS4pGQBQv1Fajl0fv+zZFI0c5VwuVZFCO5fMzMpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ3UC-0000000BjDN-3n9l;
	Tue, 08 Jul 2025 10:15:33 +0200
Message-ID: <da1fb9e42246ef81885f425f439606a1d8801ba6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Nullify freed pointers in
 cfg80211_sinfo_release_content()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sarika Sharma
	 <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>, 
	syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
Date: Tue, 08 Jul 2025 10:15:29 +0200
In-Reply-To: <fc58393d-3f5f-4702-8436-ec117e611245@oss.qualcomm.com>
References: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
	 <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>
	 <fc58393d-3f5f-4702-8436-ec117e611245@oss.qualcomm.com>
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

On Wed, 2025-07-02 at 10:20 -0700, Jeff Johnson wrote:
>=20
> Internally Sarika had a 2-patch series where the first patch attempts to =
make
> sure cfg80211_sinfo_release_content() is only called when needed. However=
 that
> required either separating out the error cases into separate gotos or cal=
ling
> cfg80211_sinfo_release_content() at each error point, and I felt that
> unnecessarily made the code less readable & maintainable, especially give=
n
> that the 2nd patch (which is the one she posted) addresses the underlying
> problem (and is similar to the approach Dan posted where he zeroes sinfo =
at
> the end of cfg80211_sinfo_release_content()).

OK but then the second one isn't really necessary at all?

> In my mind this is no different than the numerous places where we blindly=
 call
> kfree() with a pointer that may or may not be NULL.

It seems a bit different to me - we don't usually write code like

	foo =3D ...;
	kfree(foo);
	foo =3D NULL;

...

	kfree(foo);
	return xyz;

and here we quite explicitly get what looks like double free. And is,
right now, but I don't really think I'd want the code to look like it?

> But if you want the other patch as well, we can continue our internal rev=
iew
> of it.

I think I'd probably prefer only that one? But I guess one could make an
argument that it's safer to NULL it out so it cannot be used at all,
neither to double-free nor to access in any other way.

The one Dan just posted as a sibling to your reply also contains a
_missing_ call, i.e. a fix for a leak.

But we wanted to do some additional work in this area anyway. Maybe the
right thing to do would be to have some kind of context/guard instead?

johannes

