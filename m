Return-Path: <linux-wireless+bounces-24412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4038AE5EC7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C517F6F1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DB248F64;
	Tue, 24 Jun 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P/sVLFHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE1256D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752627; cv=none; b=FIerZCLBBFmhk+iOiOrFW1O0wmLmbCllNmQm2me6FkcbRHkzE6pCZRHA2HWWdqMU8ObUwo9Nl4S1y0mjQ2HZ+6/hsQRwq1CMe1KrWszIhAHMl0JFFVkiJA8SH0zOOFYXGU/mI0cTO6e8USHcXk74G5yEqJcxKYMi1hyxxHs2qEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752627; c=relaxed/simple;
	bh=gytexTXFaOSlQQT7zXl6qSlR3RLWcMkXSgro0iFWjuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+3QfXmtOh7V4KrN8epFbu6BS8nh+4iSFo3w4iKoBOtC9nwF/FBSVGH9D/wsm3goX9adVpcEsWdZk9RsTFOnL4xmnPv2h/TdFF3jwxIn8bcvHZmgXPFrWM7cgUVjdZm+NIpzxIvYLHh+23v7NLe7mFiRI1SxN1EcJKQKlBSA07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P/sVLFHw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LWu+k93yxk6gEtldOX6TeWwaly1/WuywKyupqCX6AcQ=;
	t=1750752625; x=1751962225; b=P/sVLFHwy25XXVQff6ww9mw3mhplORJCOBlWes7c++e5rCU
	7mmhLYu0Q9NLICUBniG3KAwSUjLH4JKLaW//t981gGlT8V98TyW0ZLlHebmHiZ0kfpt8jdlAxwzO4
	CgRj65DvSNJX28D03pfURba+Bot8AYZPrfYzIfB5lH47H+StasxHKR2wWpbSuppa0sXBiw/vUM8gm
	LtW6rJrXLbtbXqfBMHIFI6YUsfLNaKtd09Gt1/uQGdiUNNkITj2zGyIHbXhgft3XXNZsSxE5St4V/
	L99nzpoMABV4CpyFyQ+H0ZJHxwBdHh+iqQdtEaxKRj+FTcWoDL0cxKR50TMT9ddg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uTyjQ-00000008gHe-2irE;
	Tue, 24 Jun 2025 10:10:17 +0200
Message-ID: <fec2006bf674b7be32e98acfccea295c581e079e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
From: Johannes Berg <johannes@sipsolutions.net>
To: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date: Tue, 24 Jun 2025 10:10:11 +0200
In-Reply-To: <f7729305-1345-405b-a5f9-671213057a16@kuleuven.be>
References: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
	 <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
	 <f7729305-1345-405b-a5f9-671213057a16@kuleuven.be>
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

Hi,

Uh, sorry, looks like I dropped the ball on this.

On Mon, 2025-06-16 at 18:19 +0200, Mathy Vanhoef wrote:
> On 6/16/25 13:27, Johannes Berg wrote:
> >=20
> > > +static bool
> > > +is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
> > > +			    enum nl80211_iftype iftype)
> > > +{
> > > +	int offset;
> > > +
> > > +	/* Non-mesh case can be directly compared */
> > > +	if (iftype !=3D NL80211_IFTYPE_MESH_POINT)
> > > +		return ether_addr_equal(eth->h_dest, rfc1042_header);
> > > +
> > > +	offset =3D __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
> >=20
> > This seems awkward? Not only was this calculated by the caller before:
> >=20
> >                  if (iftype =3D=3D NL80211_IFTYPE_MESH_POINT)
> >                          mesh_len =3D __ieee80211_get_mesh_hdrlen(hdr.f=
lags);
> >=20
> > but also h_dest[0] is just taking advantage of the aliasing when we
> > already had a union in the caller to avoid exactly that.
>=20
> Here hdr.flags is not an alias of h_dest[0].

Huh, indeed, I misread the struct as a union.

> The caller is parsing the frame as an A-MSDU, and because of that, the=
=20
> caller assumes that the Mesh Control header starts after the A-MSDU=20
> subframe header, i.e., after the `struct ethhdr`.
>=20
> The added function is_amsdu_aggregation_attack is instead treating the=
=20
> frame as if it were an MSDU, to detect if an attacker flipped the=20
> "is-AMSDU" flag of an MSDU frame. For mesh networks, the MSDU=20
> immediately starts with the Mesh Control header.
>=20
> So the caller is passing the byte at offset 14 as argument to=20
> __ieee80211_get_mesh_hdrlen while the added function is passing the byte=
=20
> at offset 0 as an argument to __ieee80211_get_mesh_hdrlen.

Right.

> > We could just pass 'mesh_len' or hdr.flags from the caller? I'd prefer
> > mesh_len, and perhaps also changing the code to pass mesh_len to
> > ieee80211_amsdu_subframe_length() instead of recalculating it, since
> > it's not obvious (without looking into that) right now that we even
> > check for the necessary length of the frame.
> >=20
> > > +	if (offset =3D=3D 6) {
> > > +		/* Mesh case with empty address extension field */
> > > +		return ether_addr_equal(eth->h_source, rfc1042_header);
> > > +	} else if (offset + ETH_ALEN <=3D skb->len) {
> >=20
> > And it looks like you didn't really understand that either, or am I
> > completely confused? I don't see how this test could ever fail:
>=20
> Those checks are largely irrelevant. The caller performs those length=20
> checks based on an A-MSDU while the added function parses the frame as=
=20
> an MSDU. This means the caller is checking a different (optional) Mesh=
=20
> Address Extension header length.

Ah, so the caller check could've resulted in no AE flags (6 bytes) and
the other one 18 bytes, which is a large enough difference that we _do_
need to check explicitly I guess.

> > We previously have
> >=20
> >                  len =3D ieee80211_amsdu_subframe_length(&hdr.eth.h_pro=
to, hdr.flags,
> >                                                        mesh_control);
> >                  subframe_len =3D sizeof(struct ethhdr) + len;
> >                  padding =3D (4 - subframe_len) & 0x3;
> >=20
> >                  /* the last MSDU has no padding */
> >                  if (subframe_len > remaining)
> >                          goto purge;
> >=20
> > where 'len' includes __ieee80211_get_mesh_hdrlen() if the mesh_control
> > is non-zero (where admittedly it's a bit messy to have different kinds
> > of checks for mesh - iftype and mesh_control), so we definitely have a
> > full ethhdr after the 'offset' you calculated?
>=20
> Is there really a *guarantee* that mesh_control is non-zero? A=20
> misbehaving mesh client could still be sending frames such that
> __ieee80211_rx_h_amsdu will set amsdu_mesh_control to zero, even though=
=20
> its iftype is a mesh client.

Yeah, there should be, but I agree it's a mess now.

>  From what I see, this code in the caller guarantees space for the=20
> following bytes:
> - sizeof(struct ethhdr): 6+6+2 bytes A-MSDU subframe header
> - ieee80211_amsdu_subframe_length: can return zero
> - padding: presence of enough padding is not yet checked
> That's 14 bytes that are guaranteed to be there when calling the=20
> function is_amsdu_aggregation_attack.
>=20
> Note that the earlier check `if (copy_len > remaining)` actually=20
> guarantees 15 bytes to be present.
>=20
> Then is_amsdu_aggregation_attack needs the following to be present:
> - Mesh Control field and Mesh Address Extension field with a combined=20
> length equal to 'offset'
> - The first 6 bytes of the LCC/SNAP header (when treating the frame as=
=20
> an MSDU)
> When 'offset' is 6 this means we know there is enough space. But when=20
> offset > 6 there has to be a length check.

Right.

> I'd actually be inclined to just always perform this length check for=20
> mesh clients in is_amsdu_aggregation_attack, since this function is=20
> parsing the frame as an MSDU instead, and because it's too easy to make=
=20
> a mistake in these length checks (either now or in the future, e.g., if=
=20
> the caller code ever changes).

Makes sense.

> > Or maybe it should just not be separated out into a new function, then
> > it might be easier to see that indeed the length check isn't necessary,
> > and also easier to reuse the mesh_len.
>=20
> I'd still be inclined to keep it a different function. The new function=
=20
> is parsing the frame as an MSDU instead, to detect a possible attack.=20
> Perhaps a comment can be added that this function is now treating the=20
> frame as an MSDU instead.

Yeah, I'll add something.

> > In fact, given that mesh_len=3D=3D0 for non-mesh, doesn't that make the
> > change at least theoretically simply collapse down to pulling 6 bytes a=
t
> > mesh_len offset and comparing those? In practice probably better to
> > compare against the already-pulled bytes if mesh_len=3D=3D0, but that'd=
 also
> > be simpler to understand as a check?
>=20
> In non-mesh networks the check is indeed much easier. The existing code=
=20
> always assumed non-mesh networks and did a comparison against the=20
> already-pulled bytes. This comparison against the already-pulled bytes=
=20
> is still present at the start of is_amsdu_aggregation_attack
>=20

Right.

johannes

