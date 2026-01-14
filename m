Return-Path: <linux-wireless+bounces-30827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD7D206AB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 18:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB98830021C5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FB2E0914;
	Wed, 14 Jan 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pc7Gf6MZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D22E2679
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410511; cv=none; b=tRB5cjTZrfMDGfuqverIHOAgXlHAkYX/zMlK4IM6Aspod7Gh8ZQZ67yvL3FcEALHGUVRcJs0wV932hpJytIMjlzWY3xTvFaYLN61L8HhdWj8OlOR4v8MwE4j96/SdLgMBTcir5bjhFQ6e+QVjyfLtEkpc2GZQh4y8HMdS5a42l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410511; c=relaxed/simple;
	bh=HNnp/CaZgp6m72jY/3vSQxfduj8evozXNkqRDUMz+cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nINVo6nlED+IjdXKUMU+I6nDDHpHfZFcFsVIAiD+sFYPfG7uH55xgQB329US0mFExMrbytaVLC0PxRz1EjgjpNdWydDnjJEGzEig476Gns4IuMibfI5KextTV+HVHuz/Zp+EwxFoYgO5gcX8tVyKgQcl+OjKBhL5dxSc5/v+QWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pc7Gf6MZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HNnp/CaZgp6m72jY/3vSQxfduj8evozXNkqRDUMz+cs=;
	t=1768410509; x=1769620109; b=pc7Gf6MZ5nPrItskaREdmcVzTuWr7B6F2K4UD+/zIwpqqsT
	xoYAByRIWCwFmREgcjSVhikc8zEupSgBHHrIfdefq+F13FLJ50d3x8K/D++oH9z4pSO/CHxa67ozE
	x5Udp1qR6FnjExmPrheSi1W8mCY6bNwPQOzYR0i2aSGkP78e3roX/S0TGhpdU1bOC4baYU5fdYTqI
	wOW2+DIVp5xZlsRR/gI1DxjXpI00GJblv5WFvAe1k6Mr7DK/FPY9H4c4G8uVJaxDi1NCqWGdbLkF+
	rL3JveKxIDnktsx/uGTIzCAzUV2K3LECxIoNrm0fjAypNbkofwYWCuATuzxJ4E1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vg4M4-0000000Bk8g-4Auu;
	Wed, 14 Jan 2026 18:08:25 +0100
Message-ID: <22746c254c4c43561e2e3deaf49dadf7c57dae17.camel@sipsolutions.net>
Subject: Re: pull-request: ath-current-20260113
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Date: Wed, 14 Jan 2026 18:08:24 +0100
In-Reply-To: <f12c186c-c76a-4d39-8591-4c8d7d04d307@oss.qualcomm.com> (sfid-20260114_161351_637731_0A0B26C6)
References: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com>
	 <33d998cc225a7aeef4731ebc53c28a32b241ca7e.camel@sipsolutions.net>
	 <f12c186c-c76a-4d39-8591-4c8d7d04d307@oss.qualcomm.com>
	 (sfid-20260114_161351_637731_0A0B26C6)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-01-14 at 07:13 -0800, Jeff Johnson wrote:
> On 1/14/2026 1:47 AM, Johannes Berg wrote:
> > On Tue, 2026-01-13 at 09:33 -0800, Jeff Johnson wrote:
> > >=20
> > > Note to maintainers:
> > >=20
> > > This tag includes:
> > > 31707572108d ("wifi: ath12k: Fix wrong P2P device link id issue")
> > >=20
> > > That commit contains the following:
> > >=20
> > > Note to linux-next and netdev maintainers:
> >=20
> > I'm a bit on the fence about this, I hadn't thought about it on the
> > prior -next PR much, but I feel like this is a process thing that
> > shouldn't get recorded in the tag for posterity?
> >=20
> > I do appreciate the inclusion of this (*especially* when I won't notice
> > the merge conflict myself), but I tend to think it should be in the
> > email rather than the tag message, since the latter is something I use
> > for the merge commit message and it gets recorded.
> >=20
> > Either way I have to preserve it manually to the next level, so it
> > doesn't really help all that much, although I guess in the tag there's =
a
> > chance I could see it again when preparing my PR.
> >=20
> > I'll just edit it out this time I think since it's so long, but you can
> > complain and convince me otherwise for the next time ;-)
>=20
> In retrospect I made one bad decision.

FTR, I didn't meant to imply that you made a bad choice here - including
this information was valuable. I just didn't think it needs to be in the
tag message, as outlined.

And I was scratching my head over what you said below when I read your
mail earlier, and again now, until I looked back at git ...

> I modified the commit text of that
> patch in my "pending" branch to add the conflict resolution information.

I hadn't even noticed _that_! I only noticed it in the merge / tag
message, not in the individual commit.

> Instead of that, I should have reposted the "pending" version with that
> conflict resolution embedded in the "basement" of the patch so that then =
it
> would be part of the email record on lore but not part of the patch recor=
d in
> git. And then for the tag I could have referred to that lore link in the =
PR
> email. So this was a good learning lesson for me.

Makes sense.

Do you just want to redo it? I don't mind backing it out, nobody pulled
my tree yet I'd think?

> Hopefully these merge conflicts will be much fewer once the refactored at=
h12k
> lands in Linus' tree in the next merge window.

Right.

johannes

