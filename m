Return-Path: <linux-wireless+bounces-268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D38004F5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 08:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94C71C20B47
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 07:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523BF156FC;
	Fri,  1 Dec 2023 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QjecOg2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDB10F3;
	Thu, 30 Nov 2023 23:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Fze+dSazAwvNZzKpBF9Q5uOjyS8ti7UuRJvbkjk9hxY=;
	t=1701416738; x=1702626338; b=QjecOg2FLIWGgodx+Yy28HYl4ITWCTbF7UY37KY2dsMogzv
	d3W4iP/7q/VhxJ6j6B8iOKzEniI+H35k95JG6iwjJRLKz0DMkSEZVPVl3+MDNI7AerH05stwSN6nw
	to7cNqD52F+h26sVMXsVbdYYb9h48KNC4fg1VlvdoVySsRA2dmSmMYFbND5Vqvs7Wp7d6+HQx7ze0
	4A5aFkJmjApNLyEfUy/q8U2Fks7vapRBrw15RXb7gTyKIxVs9zc2riHjlSz/lT3tt2tak2FLXGH/L
	7q1kEWW/syr94aKYmLHei0S3AvcbUbBHNEpGnXyjkdpvjHdf6u2MVnAKd1NwJPtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8yDJ-0000000B6CO-20Qj;
	Fri, 01 Dec 2023 08:45:29 +0100
Message-ID: <313903974b14e94a2fb0dd5962362dba39bb3dea.camel@sipsolutions.net>
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,  Michael
 Walle <mwalle@kernel.org>, Max Schulze <max.schulze@online.de>,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Date: Fri, 01 Dec 2023 08:45:28 +0100
In-Reply-To: <20231130172520.5a56ae50@kernel.org>
References: <20231130200058.work.520-kees@kernel.org>
	 <20231130172520.5a56ae50@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-30 at 17:25 -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 12:01:01 -0800 Kees Cook wrote:
> > This has the additional benefit of being defensive in the face of nlatt=
r
> > corruption or logic errors (i.e. nla_len being set smaller than
> > NLA_HDRLEN).
>=20
> As Johannes predicted I'd rather not :(

:)

> The callers should put the nlattr thru nla_ok() during validation
> (nla_validate()), or walking (nla_for_each_* call nla_ok()).

Which we do, since we have just normal input validation on generic
netlink. Actually nla_validate() only does it via walking either ;-)

The thing is that's something the compiler can't really see, it happens
out-of-line in completely different code (generic netlink) before you
even get into nl80211.

> > -static inline int nla_len(const struct nlattr *nla)
> > +static inline u16 nla_len(const struct nlattr *nla)
> >  {
> > -	return nla->nla_len - NLA_HDRLEN;
> > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> >  }
>=20
> Note the the NLA_HDRLEN is the length of struct nlattr.
> I mean of the @nla object that gets passed in as argument here.
> So accepting that nla->nla_len may be < NLA_HDRLEN means
> that we are okay with dereferencing a truncated object...
>=20
> We can consider making the return unsinged without the condition maybe?

That seems problematic too though - better for an (unvalidated)
attribute with a bad size to actually show up with a negative payload
length rather than an underflow to a really big size.

Anyway I really don't mind the workaround in nl80211 (which was to make
the variables holding this unsigned), since we *do* know that we
validated there, that's not an issue wrt. the length.

johannes

