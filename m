Return-Path: <linux-wireless+bounces-25532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83897B0713F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904DF1AA1D50
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712028850E;
	Wed, 16 Jul 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pXJ8oMDb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA52F0C5F
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656906; cv=none; b=TWobNphj7shSdXv80UDCvauS4HojBUbuoM3M2jtSxyf8ywGhnoH/5KqoCtiPd3TG6jtVzJbRq3IFD1ko1IoJ/qeYwKrWBbp1axXcguhEzCZkxu066o1xzu7etaMdZQfWmfIstWhB2m9Uw1iDdgMQ9YDwA6RDy+Kt0SeAQ5Gcy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656906; c=relaxed/simple;
	bh=2AgMZz8+zVAQYsxFA39m0xRpEFpTDOvzt2dddCFIbGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rx+/xFM6ZTKo0cTZCc8dl7HKYA1wG0k+Mm28KqYZT+EXKFpoQ6PYuHU9++JSuBNy9FklgrMg/ntqRJgbHQUeY9JfpBd26iStqphoheq+2q5kPpQVEqd0IUsz3sv2kZz4n0b4vf4VJm0hXO0Re62ZYDVkw+BiDx7zSHkpIKKy3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pXJ8oMDb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kd7zlID236o0mW9tPUvKT8Ai/ovAOBvYU6eLD40GKzU=;
	t=1752656905; x=1753866505; b=pXJ8oMDb6zW13wyzYcGZgkD3VeJrNMY2CkYs+LTx894xOAR
	WPfmOYT47alLfFngi2e0cdqVjnp58h8AO5BctGspNGT9c3YuLMeA1Tr0GrD2MlvgSbRQyABsiQB3B
	oJyCvWcvLZ7MnNgj0xfen5ewChNQqMpkocOQ/mWY2ZES4JzM1ph549zlFtOWuUAV1p6Oc1rLpCUv7
	RcqJnGvwU/DTo8tUcsa/w1KalwHv2x/DkpFzbN09amecJMSA1ch5+uC2ySuiCh0qxLPquFgQbiXbC
	e/xn9E8VY/MO5l/wa5vrpMuaHjZymNDO5EQzYE3nJj3jUsZz7Xk6awuFYayrl5hQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uby7O-000000080ky-25f0;
	Wed, 16 Jul 2025 11:08:04 +0200
Message-ID: <625f49d3963b7b5c17ebbb3c201633befc16a8ad.camel@sipsolutions.net>
Subject: Re: [wireless-next v2 2/4] wifi: mac80211: support initialising an
 S1G short beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 16 Jul 2025 11:08:00 +0200
In-Reply-To: <3rvtczj6c3svz273xdeowocxfx5cln4qsxqatkvtyfdujjwnrb@o3vc3ekryfrj> (sfid-20250716_110122_087167_0F5DB5C1)
References: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
	 <20250716053254.439698-3-lachlan.hodges@morsemicro.com>
	 <d5d5cce69b8300cfe1de7c0b2109403a4735f309.camel@sipsolutions.net>
	 <3rvtczj6c3svz273xdeowocxfx5cln4qsxqatkvtyfdujjwnrb@o3vc3ekryfrj>
	 (sfid-20250716_110122_087167_0F5DB5C1)
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

On Wed, 2025-07-16 at 19:01 +1000, Lachlan Hodges wrote:
> An interface can't be modified such that we can disable short beaconing
> without tearing it down.

OK, that's fair. No objection to that, just wanted to clarify if that
was what you intended.

> > This should probably be on the cfg80211 patch, but now that I'm writing
> > here ... If there is no new short beacon update cannot currently be set
> > to true, I think? And also, right now by the policy you can't set the
> > long_beacon_interval =3D=3D 1 from userspace, but what if you actively =
want
> > to _remove_ the short beacon entirely?
> >=20
>=20
> I initially did think so that this should be in a cfg80211 targetted
> patch but since cfg.c since within mac80211 I did such. Can do either.

Oh, sorry, what I said was confusing. I meant I should be _commenting_
on the cfg80211 patch instead (about the logic of being able to remove
the short beacon or not). But you clarified that above.

> So you are correct, It's not legal to disable short beaconing without
> tearing the interface down (as mentioned above). Thats why within
> ieee80211_change_beacon() we check if we are short beaconing first
> and if theres an update proceed with said update. This function should
> really just be setting the new pointers and discarding the old pointers
> if they exist i.e during an update.=20

Right, makes sense.

> Yea.. this seems to be a case of me stealing the beacon change code...
> :).

OK, I don't know what that code does off-hand, maybe there we have some
other things that don't always need to change.

> static int
> ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
> 			       struct cfg80211_s1g_short_beacon *params,
> 			       struct ieee80211_link_data *link)
> {
...

> 	/* Memory layout: | struct | head | tail | */
> 	new->short_head =3D ((u8 *)new) + sizeof(*new);

You probably don't need the extra () around "(u8 *)new".

> seems more robust, where we simply update the new beacon given
> the parameters and discard the old, else if theres no update
> we do nothing.

Yeah, that looks good to me.

johannes

