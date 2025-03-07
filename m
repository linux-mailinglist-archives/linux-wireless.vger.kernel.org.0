Return-Path: <linux-wireless+bounces-19985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CACA562E8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 09:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CF916651A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355919E971;
	Fri,  7 Mar 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NpHydltF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124C1AF4C1
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337301; cv=none; b=DfN8z+v6f43lZx38F4uXpb9FcSo+779lbWHN8GlcBtxbKL9CmF6V6py/JTdxD2QIHvC3Kh8DmJfKFBomQxOvalZXbxqk6FZW/+tmlghisZ0LJ8HlHB4+jhnQP6NWcF6Rs7FB9uPhdDzoXqy0fKw5lWN1t/onJvSVo6DwnB+YmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337301; c=relaxed/simple;
	bh=WzwW0/vLaNZhx0zdXxtd7khyH9VEwnN5oGZlTk96UtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9rG2oP4LPCK2RM3bm5fI3gT1gy3se7A0y5kv3Y1EClYuSw8FL+hJHiSKi+MRt0mlpdgu63cWa3/bsxjSgOr1ic3DtjIM83FGUw1ITykyPMxoObVZeskKpNHlABvM2aPft8kP4rGY2JvX8WlvSiy/I8uJELE+vMkj+BshAMKAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NpHydltF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pFxInlg5fiBe7wmk/wzVCnZqyJhRyw7FN6hzAIrpjHY=;
	t=1741337299; x=1742546899; b=NpHydltF7CpFF12cmAd+MC7U/+Pzmk/BGgyApytKHbSIx4o
	8a61U2vs9ng2I0uMiUCqKdvnonk3zW/nUdjMbgCgkcRjPSZ8kcWcA4jg+kvE5X8rt/Tj43XyFg8H8
	3mnFhTEaCnt4AKtkrVnS5n5QAJNgM4TOyaAPFWTiyPVf4uS2Avp/VzKinpu4bicP00klsbtQ98PZu
	Sw7dIMLMOC6BNxe1IyfjDDsp/vYqDUihydoY86hzxX8OU1cyOouwjn9Z9ltewCHolxGelHhPvvge/
	YMuvVvyUfDBajz8CpDt4w6OWGaEugjjLfFcjT9wEUMQ7ZPrsMh3aUu2K5Aap1IqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqTNP-00000003mcM-0Ix2;
	Fri, 07 Mar 2025 09:48:15 +0100
Message-ID: <2587f323fe19b33d2e9ec49bdc3979f71b9c0ba0.camel@sipsolutions.net>
Subject: Re: Future of mwifiex driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Sascha Hauer
	 <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de
Date: Fri, 07 Mar 2025 09:48:13 +0100
In-Reply-To: <Z8ZbJYmxgnvd7Q1O@google.com>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de> <Z8ZbJYmxgnvd7Q1O@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi all,

Sorry I didn't reply earlier - I was dragging my feet, but also didn't
really know if I can add anything beyond what I already wrote.


On Mon, 2025-03-03 at 17:45 -0800, Brian Norris wrote:
> Hi Sascha,
>=20
> On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> > I am worried about the future of the mwifiex driver. NXP has an ongoing
> > effort of forking the driver to support their new chips, but the forked
> > driver lacks support for the old chips supported by the current mwifiex
> > driver.
> [...]=20
> > I have a series here [1] doing some cleanup work which I'd still like t=
o
> > get forward.
> [...]
> > [1] https://lore.kernel.org/linux-wireless/87ldwyumvq.fsf@kernel.org/
>=20
> I'll apologize for that one stalling out a bit. IIRC, 11 of 12 patches
> looked great, but I got stuck on the "fix MAC address handling" patch,
> because it's a lot tougher to guarantee it doesn't break some use cases
> while fixing things. But really, it's probably mostly a bandwidth thing
> for me, as I really don't have many cycles to spend on things (and
> especially when it gets beyond "obvious cleanup" and requires
> substantial testing and/or reasoning).

I guess that means could also partially resend the series, and get 11 of
the 12 in? I see the MAC address handling is first, but a cursory look
suggests that at least not all of the other would have a hard dependency
on it.

> In no particular order:
>=20
> 1. even if NXP (or you, or anyone) does great work, I'm not going to be
>    a super helpful maintainer. I simply don't have time to review and
>    test substantial contributions.
> 2. I get the feeling linux-wireless may have problems like #1 in
>    general. Johannes can't fill the entire gap Kalle left, for one.
>    (Feel free to correct me if I'm wrong! Or if other excellent people
>    have stepped up on review/maintenance.)

Indeed, obviously still an ongoing issue, and I don't expect it to go
away soon. I see that Jeff has been reviewing some things not just
related to their drivers, but that's about it ...

Generally I'd also say that I'm going to give much more leeway to people
who are actually involved in the community, but I get the feeling that
everyone really would prefer to be in their little driver silo. NXP in
particular.

(The last email from @nxp.com on the list not related to these drivers
is from 2018, excluding ones from other business units that just got
accidentally CC'ed to the wireless list. And that was someone there
testing brcmfmac, it's pretty obvious that nobody there ever cared one
bit about looking beyond the driver.)


> 3. Other drivers may look somewhat similar, and yet fork for good
>    reasons (like, firmware API revisions; or 802.11 generations; or some
>    cross-section of both). I'm looking at rtw88/rtw89 (that I was
>    involved with quite a bit), or ath10k/ath11k/ath12k/(have we made it
>    to 13 yet?). So forking even with quite a bit of similarity isn't
>    necessarily inherently wrong.

Agree. We also just sort of forked iwlmvm to iwlmld, but it was actually
a rewrite, and we've thoroughly modernised it, e.g. removing mutexes and
locks where possible to use the wiphy_lock() stuff, integrating with
wiphy_work, taking different approaches on firmware notification
handling to make things more robust etc. The same is true e.g. of ath12k
over ath11k which got locking updates for wiphy locking, a lot of MLO
work, etc.

> 4. A key difference between #3 and mwifiex is, like you say, that
>    mwifiex has a pretty low quality baseline. If I were maintaining it
>    from the beginning, I probably wouldn't have accepted it.

Indeed, the above is _definitely_ not true for mwifiex/nxpwifi. I've
effectively proven in the other thread that it's just a straight up copy
without any modernisation etc. If there had actually been a real reason
to not work with the same code base, then that might have made sense -
perhaps with some library code split out.

But copying an old crappy driver for the sake of "we don't want to
maintain an old crappy driver" is a really bad argument to make?!

johannes

