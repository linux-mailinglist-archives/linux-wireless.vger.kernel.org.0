Return-Path: <linux-wireless+bounces-3772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E885A082
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57201F24513
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC114210FA;
	Mon, 19 Feb 2024 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="izgw1X/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1C2556D
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337173; cv=none; b=TiXfNMUJLXAe95IZ9Oqtkpi7PGskt3CGADvRuDERkCdH755uiFjS/PxMnyZURiAGXHbrlZWBEzgyZLtjqzEgIAFqRKdrpnyyZ15yRP6jXHFFvErxd1cutIM5y5rQoHS970fxpBR5ttaMSQUf1l2gmJd6TczNoCD6NBcJQHrDJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337173; c=relaxed/simple;
	bh=HO2qG5bxXyBnRnELqPKXj8gGN33xRt+6fa/vSUPQR44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKZCwZXxzcZ1aaeybAbepM2PdDBrMiSa19zwmgwF49MjflP7K+PlCpYBas66fud38uxRneVNsHmQ9ty2+UCvP/0Mm3K278307ohk4eVSjS+p1i6+1r8gFqFZc4R7OoY2FWx0MB7yvZSUJ1NoHFisqLK5NMvFMqFe4JuZD1VxNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=izgw1X/k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HO2qG5bxXyBnRnELqPKXj8gGN33xRt+6fa/vSUPQR44=;
	t=1708337171; x=1709546771; b=izgw1X/kzRjnscTj8gQP4/JzjHsBZpczLKukNuqxEN/mmKx
	GHmXCMuh0z3o4njS187x6MNqFXKWa5unGSgS6KacJMBnUsjwF7qxHbG0/opT5RvhbLEnOjGDWW1wS
	Q/ODX5Awein8KT/RCbTTN1zX04o2VYS3pSNlIV7i3Ctj22EKb2Zx8BieQJ26Ocb7bbZKxoFxyxOb1
	gZkv7oCjxKsesu643FLI15fjOoFOVpoyvg1+DHEmgk+Ul54TqVoLFP44/sltDw5qsA3w3KLawNJ37
	IKr/r5Usc67c+pimlOb+QnwtfjuE3FnUstxdVIK6SwJiiZJ92qfhcpaYiVGuFIug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rc0XH-0000000H1u2-2Kmi;
	Mon, 19 Feb 2024 11:06:07 +0100
Message-ID: <3a6f90ceb86013782329ba0054995aef225a53b1.camel@sipsolutions.net>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?=
	 <Michael-cy.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "nbd@nbd.name" <nbd@nbd.name>,
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
 <Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
 <Money.Wang@mediatek.com>
Date: Mon, 19 Feb 2024 11:06:06 +0100
In-Reply-To: <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
	 <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
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

Hi,

> The rebase seems good. We will conduct a full channel-switch test,
> including hwsim tests in hostap. If there are any problems, we will
> send another patch to fix them.

OK, thanks for checking. The tests from hostap are passing, I make sure
of that anyway, but ... who knows what they miss :)

> > Shouldn't that have (had!) an 80 MHz handling case? Or maybe a loop a
> > la
> > the one in ieee80211_config_bw():
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Downgrade the n=
ew channel if we associated with restricted
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* bandwidth capab=
ilities. For example, if we associated as a
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* 20 MHz STA to a=
 40 MHz AP (due to regulatory, capabilities
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* or config reaso=
ns) then switching to a 40 MHz channel now
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* won't do us any=
 good -- we couldn't use it with the AP.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (link->u.mgd.conn=
.bw_limit <
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ieee80211_min_bw_limit_from_chandef(&chanreq.
> > oper))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ieee80211_chandef_downgrade(&chanreq.oper, NULL)=
;
> >=20
> >=20
> > Feels like this should be the same here.
>=20
> Yes, a loop to validate the operating bandwidth is necessary. We'll
> send another patch that makes this change.

Sounds good, thanks!

> > Also note how this uses ieee80211_chandef_downgrade() - we really
> > need
> > to track the "chanreq.oper" vs. "chanreq.ap" in this code as well for
> > puncturing - can I ask you to take a brief look at that? I'll anyway
> > probably have to look at that soon though.
>=20
> Of course.
> In fact, we have plans to study and implement puncturing on our MT76
> driver. We're currently working on the AP side, and we expect to start
> the STA side maybe three months later.

OK, let's see. I probably have plans earlier than 3 months from now for
this, but not sure yet. Let me know when/if you start working on it so
we can sync up again then?

johannes

