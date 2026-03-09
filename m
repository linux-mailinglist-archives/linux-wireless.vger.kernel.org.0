Return-Path: <linux-wireless+bounces-32755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBzkMcCCrmlfFQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:20:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DE2356DD
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4EF7300AC0F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770836BCE2;
	Mon,  9 Mar 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW02B5Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317636C0A3
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044412; cv=none; b=HBsL34cKg3V7gunnbAytsRcwAgcy2gIYt6f9x7MG278KxXCETy7woS5upJ/9YuyIsOn1+cXpU+3h0MeeINkpVEUxOuidzZA1g3JOU5VdlQM2GEJeM3nunyqns+ybeq2JRNumGRoCQhVB7BhB/dbiLb4rVZcwoupp4XpAkF3uzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044412; c=relaxed/simple;
	bh=qJ4w4qQRmM2ZjqtZa5UjUUiweqrIUMgHTeE5IFVGESM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMx7M4ylI+q8UBXpR8oKd6C+Tds9xe+kG2UU+BW8J43uFlOu30P3FPoBWlnokwergzZwblY3XizDCNzbPiX9DT3bw+3jpFay6EzulXjH2/rtEgVBALBW1O9uvzRLIR/Vh80H+TmcdVCPCrnCMhJIbRIpy5TRqoiVu5d6A5mI3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW02B5Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6051C4CEF7;
	Mon,  9 Mar 2026 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044412;
	bh=qJ4w4qQRmM2ZjqtZa5UjUUiweqrIUMgHTeE5IFVGESM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW02B5SaBqa9ZXjEazsWGqbg8ToSFwGD2OOwTf0qVPUFWlM4RncnhkqKZxxobVRu+
	 lt/VqOxbvBPKJ+WR5B/ANY5vVHwwJg+jGhtFBKpORXrnT6ZlOZV4tr9sZzfcMpXYHj
	 D96tthIqZejhlS++tV4xaQvTq+q9ph4iuXO4qexgnu8VAq/lhE+6lzFF2/yoq5ty35
	 MYdYcVFjvxZPlPmA3CMe5QOkT1ZVXov/YLgPGV5r4xrK1fbbDduoJwLAuXYruv/wnA
	 I75QK78eaHCGm/s4JKS9lJotdO4pA9bvfSC9sNqiaYosdvl/vuEvbdKw+9nz/N7Sb2
	 S/gMD0wqEnIuw==
Date: Mon, 9 Mar 2026 09:20:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mac80211: Remove deleted sta links
 in ieee80211_ml_reconf_work()
Message-ID: <aa6CuVi3BZxLBcPA@lore-desk>
References: <20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org>
 <jv2kdsru66rktkm6bwq3ww5wshubjtv36le5xk4ziedocc72gp@psssohaoamus>
 <aa15YDx5G7WN-nsH@lore-desk>
 <be1c90f6be71f6118590b0add4d657cd79d2ea2b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsTQrGGjvwKiyfIz"
Content-Disposition: inline
In-Reply-To: <be1c90f6be71f6118590b0add4d657cd79d2ea2b.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 4A0DE2356DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32755-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.958];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--XsTQrGGjvwKiyfIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 09, Johannes Berg wrote:
> On Sun, 2026-03-08 at 14:28 +0100, Lorenzo Bianconi wrote:
> > > > +	rcu_read_lock();
> > > > +	sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr);
> > > > +	if (sta) {
> > > > +		unsigned long removed_links =3D sdata->u.mgd.removed_links;
> > > > +		unsigned int link_id;
> > > > +
> > > > +		for_each_set_bit(link_id, &removed_links,
> > > > +				 IEEE80211_MLD_MAX_NUM_LINKS)
> > > > +			ieee80211_sta_free_link(sta, link_id);
> > > > +	}
> > > > +	rcu_read_unlock();
> > > > +
> > >=20
> > > Could use scoped_guard(rcu) instead?
> >=20
> > I do not have a strong opinion here.
> > @Johannes: Which one do you prefer?
> >=20
>=20
> To answer the literal question: No strong preference I guess, given that
> there's no error path here this seems fine, and the scoped version would
> just add another indentation level.
>=20
> But you really should just remove the rcu_read_lock/unlock anyway, it's
> not needed since this holds wiphy mutex, which is sufficient to access
> the STA table etc.

ack, I will fix it in v2.

>=20
> Also, I think you need ieee80211_sta_remove_link() to tell the driver?

I think we already inform the driver running ieee80211_set_active_links() so
ieee80211_sta_remove_link() seems redundant, right?

ieee80211_set_active_links() -> _ieee80211_set_active_links() -> drv_change=
_sta_links()

>=20
> And I realized another thing - this needs to destroy TDLS stations that
> were on the link being removed, but maybe that's a separate commit.

Do you mean ieee80211_teardown_tdls_peers()? Is it done in
_ieee80211_set_active_links() too?

Regards,
Lorenzo

>=20
> johannes

--XsTQrGGjvwKiyfIz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaa6CuQAKCRA6cBh0uS2t
rHmNAQCRm3oVOEAILtxk4altC1bjBCYcdGpz/X36AI2ki2CtwwD/fX7W36SmbCat
AB6rl8QkPD17437chDjHOXTsv5Rm3QE=
=zXBJ
-----END PGP SIGNATURE-----

--XsTQrGGjvwKiyfIz--

