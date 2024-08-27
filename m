Return-Path: <linux-wireless+bounces-12024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3A960353
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321EE1F2302C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A6155CB0;
	Tue, 27 Aug 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k4f9p3H9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57D153BF6;
	Tue, 27 Aug 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744351; cv=none; b=GBMkfA0g1a1gFnKq61rKCK9Ib5DLeC83h3U99+vOMBf8dNJGp1o+xSy+pOsqCZ4Of48dR63IE2ZybfjUYSzjeHS1h3lxI+XHgeRNHKmornjJFjrdQcRRY2tHvqx8VnsKp368DYh6WEsv8axtI76/ffm4yoLvFVJ/Kw2BxUpBRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744351; c=relaxed/simple;
	bh=ImzuVf95Bocj6jkgM4cI4Tk28E5n2Hx1GlzRLG/8IY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBEURnmXCDJ68APbdPSAxGfB/zRIQYwJq0CUYOgTmyH2RL/Hi1meomYyfbSZAgdo2VznlYDKQnR2qF4CpDO7NKO/LDiTbiz1xfXVRlLmIXe30iLTSJoC1Bb9NjUNJ08zU1VrY7/olmBSa7y2j9a7U94pioiC+rWcHXisZThipYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k4f9p3H9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yPuQJto6HhcFhEBv3siWTsS5wLOUCfRP2SoLejN+VrU=;
	t=1724744349; x=1725953949; b=k4f9p3H9pdl+IBW1YwCUp5eu3E1lv6evOzbegchZQakZW5S
	2SYpLla1X5WCb6K/rbFK65FG5xKe296PMwaMS3qma7vFKCfsYozw4unfYauhQIA0P/EwAhJ3MXh/v
	LerKtM/ZFtgpsdfS0L15JatgwjsC7eAqBW7J44T8URQPJ4Ka6LPU1uV+6Oo6dK9ro6YoYgN/Vb78X
	a1aK67gTr446jL+Y9gOqfkFl4A8UoJmRLWx+k5rwmeNhpysbLiM+M4QSYy3pGNQ2Kd9UmqNCEOz3c
	zP33d9TvkAcYkkmrz9v3QETg10DbAOuPtiWU85qOdQEhGOLbTHDmpBy13e5c7B/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siqn7-00000004QEO-2OdY;
	Tue, 27 Aug 2024 09:39:01 +0200
Message-ID: <4967a09d4c00532148aacd7dc4b5e21902ef7721.camel@sipsolutions.net>
Subject: Re: [PATCH -next v2] wifi: mac80211: use max to simplify the code
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 27 Aug 2024 09:39:00 +0200
In-Reply-To: <82523993-61c8-4c03-8826-61da9081d3ba@huawei.com>
References: <20240827030302.1006179-1-lihongbo22@huawei.com>
	 <d5f495b67fe6bf128e7a51b9fcfe11f70c9b66ae.camel@sipsolutions.net>
	 <82523993-61c8-4c03-8826-61da9081d3ba@huawei.com>
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

On Tue, 2024-08-27 at 15:29 +0800, Hongbo Li wrote:
>=20
> On 2024/8/27 15:25, Johannes Berg wrote:
> > On Tue, 2024-08-27 at 11:03 +0800, Hongbo Li wrote:
> > > The following Coccinelle/coccicheck warning reported by
> > > minmax.cocci:
> > >      WARNING opportunity for max()
> >=20
> > Yeah well, maybe sometimes we shouldn't blindly follow tools ...
> >=20
> > > Let's use max() to simplify the code and fix the warning.
> >=20
> > You should explain why.
> >=20
> > I think only one out of four changes in this patch is correct,
> > semantically.
> >=20
> You mean sometimes we should keep the variable type in comparison?

No, I just don't think these are semantically calculations of a maximum,
even if they look that way.

That's why I asked: Why are you making this change? It looks like you're
making this change just because you want coccicheck to be silent here.
But that's *really* not a good reason! Don't do that, ever, *think*
about the changes you're making too.

We should consider the primary consumer of the code to be *people*, not
the compiler or tools like coccicheck. And for *people*, applying max()
to a link ID makes no sense. It's a link ID, not any kind of value that
applying max() to makes any sense.
In contrast, for the timeout value there that you changed, that _does_
make sense: it clearly wants to take the longer of the two durations.


So then why do we have patterns that look like max(0, link_id)? That's
because we treat -1 as a special value indicating "no link, but for the
whole sta/vif/...", "don't care about the link" or "MLD not used"
(depending on the context). Internally in the code, however, we use 0
for non-MLD to simplify older drivers and internal logic.

That's why we end up with "link_id >=3D 0 ? link_id : 0" in some places.
But it's fundamentally not max() even though it looks like it. Replacing
it with max() does this a disservice.

Now arguably open-coding it often (though three perhaps isn't often, but
I'm surprised it's only three times) maybe isn't a great idea either,
but then that should be solved differently.

So yeah, please think about changes, don't make them blindly.

johannes

