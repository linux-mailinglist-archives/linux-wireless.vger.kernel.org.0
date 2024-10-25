Return-Path: <linux-wireless+bounces-14565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A619B118C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 23:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF99281D15
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A857E792;
	Fri, 25 Oct 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rzg0iyvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65F217F30;
	Fri, 25 Oct 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890985; cv=none; b=JKvuMP8jRBTOAWWfJfTjCBu+MISoUapOHtDR9LomuGVJh3HE8AzqM1vx7j4o27R4vYLh08WondOVc9JFpj/Ogr5yHVQWzIvhVwlQ9viPSgribPL2CzCqAzSfZBJLc+fkHFdBqSYBivizJHKeJwmFFqbTTXOGNnbC5jbyUxHCOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890985; c=relaxed/simple;
	bh=8Nn3A+UdrXv0Swkr7BZ4okxDkyB1splEY8faoNaG2sE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeD+jfs486iWDGEk+X+tQqAMUn/jOUxtX5LmjC6CIcvE2nIp8EcBXqVsA+9pC5ARE/NC2vNRJI2VeL0AN7kG9cpszmfWjwqJQxfcbN07nRxIidkGsSTu34wXMyeR9S8hfMXD9X06e1Ulgh+rafHbf3P9B9x1SaOwhMYwRXidI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rzg0iyvz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jgMnw5M7Z+ZY5Nf4QUgXosxnvQKmVFPBeE4lXBGNjVE=;
	t=1729890983; x=1731100583; b=Rzg0iyvzIUN2wZe12yw4kZglZSSdOU4oNk6qFmnqcpOvz0K
	jZ69mpcnAypen+R+f9BxAaBR3vZrMroC3Quwowj396hvfpMdw59BKmUv5yIUeygDiVlBYivMbB7Mr
	X9TAeuHOxA6dp6cZ28s2APcGCW4sc2fyyBRcaFH5jIcuuhJvSQdtH+biXH6nLpGSp9k0kd/6ScCPX
	HH/MYoq432sONiyUvUad6/zshMknPaBx8sejF5d4+H4vNHlF4NiqBZC7+uxIgWAMWJ7mBsv4G5OYh
	BAIiipOqzzXb6zjW4N4g4xjEcrGbNAdSIT/B21N4MDRBQDkT2PmIj2zEt3BqWVQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4RfP-00000004i3l-48CV;
	Fri, 25 Oct 2024 23:16:20 +0200
Message-ID: <49a18a9a482263e9063a0afc8b93de451dbe4d84.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 25 Oct 2024 23:16:19 +0200
In-Reply-To: <7e2745d9-f607-4b9b-87c6-0623708747ef@embeddedor.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
	 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
	 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
	 <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
	 <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
	 <192eb05afffd37bd13ff9bc1fc9b044b347b5dc4.camel@sipsolutions.net>
	 <7e2745d9-f607-4b9b-87c6-0623708747ef@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-25 at 15:10 -0600, Gustavo A. R. Silva wrote:
>=20
> On 25/10/24 14:48, Johannes Berg wrote:
> > On Fri, 2024-10-25 at 14:36 -0600, Gustavo A. R. Silva wrote:
> > > > >=20
> > > > > Yeah, I was actually going to mention this commit, as it's the on=
e that introduced
> > > > > that `bool radar_detected` to the flex struct. However, it wasn't=
 obvious to me
> > > > > how `struct ieee80211_chanctx_conf conf` could overwrite `radar_d=
etected` as I didn't
> > > > > see `conf->drv_priv` being accessed through `struct struct ieee80=
211_chanctx_conf`.
> > > >=20
> > > > You have to look at the drivers, see hwsim_clear_chanctx_magic() fo=
r
> > > > example; I wonder why hwsim_check_chanctx_magic() never caught this=
.
> > >=20
> > > Sorry, I actually meant through `struct ieee80211_chanctx`. Something=
 like:
> > >=20
> > > struct ieee80211_chanctx *foo;
> > > ...
> > >=20
> > > foo->conf.drv_priv[i] =3D something;
> > >=20
> > > or
> > >=20
> > > struct bar *ptr =3D (void *)foo->conf->drv_priv;
> > > then write something into *ptr...
> > >=20
> > > In the above cases the code will indeed overwrite `radar_detected`.
> >=20
> > Right, that's what it does though, no? Except it doesn't have, in the
> > driver, "foo->conf." because mac80211 only gives it a pointer to conf,
> > so it's only "conf->drv_priv" (and it's the "struct bar" example.)
>=20
> OK, so do you mean that pointer to `conf` is actually coming from
> `foo->conf`?

Well depends what code you're looking at? I guess we should get more
concrete now. Let's say hwsim:

struct hwsim_chanctx_priv {
        u32 magic;
};

...

static inline void hwsim_set_chanctx_magic(struct ieee80211_chanctx_conf *c=
)
{
        struct hwsim_chanctx_priv *cp =3D (void *)c->drv_priv;
        cp->magic =3D HWSIM_CHANCTX_MAGIC;
}

probably shouldn't be marked 'inline' now that I look at it :-)

This is being called in hwsim itself, of course:

static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
                                      struct ieee80211_chanctx_conf *ctx)
{
        hwsim_set_chanctx_magic(ctx);
...

which is only referenced as a function pointer in the ops:

static const struct ieee80211_ops mac80211_hwsim_mchan_ops =3D {
...
	.add_chanctx =3D mac80211_hwsim_add_chanctx,

(via some macros)


And that's called by mac80211:

static inline int drv_add_chanctx(struct ieee80211_local *local,
                                  struct ieee80211_chanctx *ctx)
{
        int ret =3D -EOPNOTSUPP;

        might_sleep();
        lockdep_assert_wiphy(local->hw.wiphy);

        trace_drv_add_chanctx(local, ctx);
        if (local->ops->add_chanctx)
                ret =3D local->ops->add_chanctx(&local->hw, &ctx->conf);


so you see that the struct ieee80211_chanctx is never passed to the
driver, but instead &ctx->conf, which is the struct with the flex array
for driver priv.

So in this example, struct hwsim_chanctx_priv::magic overlaps the
radar_detected value.


(The allocation happens via chanctx_data_size.)

johannes

