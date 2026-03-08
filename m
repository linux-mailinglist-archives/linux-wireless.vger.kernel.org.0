Return-Path: <linux-wireless+bounces-32719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HfFjM2d5rWmI3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-32719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 14:28:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDBC2306B7
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 14:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5115300EF89
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01B37F8A0;
	Sun,  8 Mar 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQVTWvEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807337F007
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772976483; cv=none; b=KDGEEQFQg9fTr2M40w7ZJ4cim6Ggg8eDpjbVuztoex8vVXlWmRW/VSdfCqIH73HYA5G+I5VCfatomIIAQv103pLGEkXWdY1SDv6hxHLRC2JZOWuGgGSal9mMoUfTdHWrBnhlFQZU0DTrSaq71Dg9Oq/CNfGGsBXroCyzFq0JlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772976483; c=relaxed/simple;
	bh=kqMXEL+AjqzO9zZs1WrwVKYrFSMYBdQt7xK0a+R1F1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvcHYOOn8A+P3pSdNUZ0P1fiCZNIU4bIqgEGpk8u1fiO/1nKj5qgcdHXAyoCh8lD8RWFi6MnJ/E74r0nUdU4UMCveZPHNiKmexX0GEQNeAs4sUJqrl4bfwpR+rxgUw4NRHvIcXb8mrCaDAmc8FnueRe3P/pCu1MzP5SzFghR4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQVTWvEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04966C116C6;
	Sun,  8 Mar 2026 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772976483;
	bh=kqMXEL+AjqzO9zZs1WrwVKYrFSMYBdQt7xK0a+R1F1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQVTWvEbIbWxVRB+nnQ4THO0nQMH4jhflZI83tL3wT2M8YHSX5Nq1/KPksoVgObh/
	 064FzmJULl8UHxxgLWols5i0WKsbeQi/PduJT+ZcUTHlja3H0Tsfy5JgQ68akhdMIc
	 ey53LGKO0GNmXrarF6SzgGg6/o9VVuj6Jije1ytlqy6xBa95bhyWn6bFvvZnoTmyCU
	 T5t95B2KvaXYmL6+sMBU5x7cMI9iYAcPhPCnR6Y/BDuQBORf3wnF7BJms6uYES5Bea
	 B3ZRk7nrtMy4OnupjjQG7gbULjQlYdd9HnOjs6+nCUfT/0n/at7pJj1Kl2OH3HT57I
	 JAsdWrmPx5+Kg==
Date: Sun, 8 Mar 2026 14:28:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mac80211: Remove deleted sta links
 in ieee80211_ml_reconf_work()
Message-ID: <aa15YDx5G7WN-nsH@lore-desk>
References: <20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org>
 <jv2kdsru66rktkm6bwq3ww5wshubjtv36le5xk4ziedocc72gp@psssohaoamus>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnS7Ya0bgm6rJ7T1"
Content-Disposition: inline
In-Reply-To: <jv2kdsru66rktkm6bwq3ww5wshubjtv36le5xk4ziedocc72gp@psssohaoamus>
X-Rspamd-Queue-Id: 1FDBC2306B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32719-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.958];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--jnS7Ya0bgm6rJ7T1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +	rcu_read_lock();
> > +	sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr);
> > +	if (sta) {
> > +		unsigned long removed_links =3D sdata->u.mgd.removed_links;
> > +		unsigned int link_id;
> > +
> > +		for_each_set_bit(link_id, &removed_links,
> > +				 IEEE80211_MLD_MAX_NUM_LINKS)
> > +			ieee80211_sta_free_link(sta, link_id);
> > +	}
> > +	rcu_read_unlock();
> > +
>=20
> Could use scoped_guard(rcu) instead?

I do not have a strong opinion here.
@Johannes: Which one do you prefer?

Regards,
Lorenzo

>=20
> lachlan

--jnS7Ya0bgm6rJ7T1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaa15YAAKCRA6cBh0uS2t
rJiqAP9RpKiuRbRIYHeTrzE4E92FaZAr6yhgB9orb1VbH+e2igEA87jLRXdNSJ5h
9QWH36csDBB7GlOASJXxnwTQ+ffYJw0=
=6hrI
-----END PGP SIGNATURE-----

--jnS7Ya0bgm6rJ7T1--

