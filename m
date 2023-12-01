Return-Path: <linux-wireless+bounces-305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250628012F6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FEFB20E78
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E84BA8F;
	Fri,  1 Dec 2023 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcqG69kP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED554BD0;
	Fri,  1 Dec 2023 18:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF83C433C7;
	Fri,  1 Dec 2023 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701456307;
	bh=6ayoBSJy6iihyBHwxLrx8Luk1kVUOImElJUsiwGZ0Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcqG69kPysYDU470FPhnMo9aFkTzh5UFfSP+GB7jG1Kq2MgYkKkO9/7xS41/QItmY
	 GKebXgxqnFcpvOyfbJxBjKyr9N5A9UjF5UCcyDgiSAxUIUp9IvwZ+ix+on+62kKSLA
	 F7mloqInbrkRAX4DPZUL3VG/kZayO0kR6UoLgpzcdpDbW+qF62RXqVpn+LTW8v/oW8
	 vpsqubTRa1P6t/SiRDNShl1ShpFTrhT8bF9vrbcOzAIqFCFq6tgs9GLLlbvPi9r6QQ
	 niQ7PdyMU5YSJWJzwrDgR+MFlC8rvJC0pglI1Zk9VSYE7cGdU6bIzoMCDY/dLyS5qS
	 1v1SjukglLfEg==
Date: Fri, 1 Dec 2023 10:45:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, Jeff
 Johnson <quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>, Max
 Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231201104505.44ec5c89@kernel.org>
In-Reply-To: <202312010953.BEDC06111@keescook>
References: <20231130200058.work.520-kees@kernel.org>
	<20231130172520.5a56ae50@kernel.org>
	<202312010953.BEDC06111@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Dec 2023 10:17:02 -0800 Kees Cook wrote:
> > > -static inline int nla_len(const struct nlattr *nla)
> > > +static inline u16 nla_len(const struct nlattr *nla)
> > >  {
> > > -	return nla->nla_len - NLA_HDRLEN;
> > > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> > >  } =20
> >=20
> > Note the the NLA_HDRLEN is the length of struct nlattr.
> > I mean of the @nla object that gets passed in as argument here.
> > So accepting that nla->nla_len may be < NLA_HDRLEN means
> > that we are okay with dereferencing a truncated object...
> >=20
> > We can consider making the return unsinged without the condition maybe?=
 =20
>=20
> Yes, if we did it without the check, it'd do "less" damage on
> wrap-around. (i.e. off by U16_MAX instead off by INT_MAX).
>=20
> But I'd like to understand: what's the harm in adding the clamp? The
> changes to the assembly are tiny:
> https://godbolt.org/z/Ecvbzn1a1

Hm, I wonder if my explanation was unclear or you disagree..

This is the structure:

struct nlattr {
	__u16           nla_len; // attr len, incl. this header
	__u16           nla_type;
};

and (removing no-op wrappers):

#define NLA_HDRLEN	sizeof(struct nlattr)

So going back to the code:

	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN...

We are reading nla->nla_len, which is the first 2 bytes of the structure.
And then we check if the structure is... there?

If we don't trust that struct nlattr which gets passed here is at least
NLA_HDRLEN (4B) then why do we think it's safe to read nla_len (the
first 2B of it)?

That's why I was pointing at nla_ok(). nla_ok() takes the size of the
buffer / message as an arg, so that it can also check if looking at
nla_len itself is not going to be an OOB access. 99% of netlink buffers
we parse come from user space. So it's not like someone could have
mis-initialized the nla_len in the kernel and being graceful is helpful.

The extra conditional is just a minor thing. The major thing is that
unless I'm missing something the check makes me go =F0=9F=A4=A8=EF=B8=8F


