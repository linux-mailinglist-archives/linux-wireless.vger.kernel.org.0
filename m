Return-Path: <linux-wireless+bounces-33421-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IErzJDHhummDcwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33421-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 18:30:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2B2C04C8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 246203011A48
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F412E7180;
	Wed, 18 Mar 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4M9Krik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40571E89C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854674; cv=none; b=gCH+06PbNBSwLxRSG8oeaZN9JYMRdTCDesJWnZCcDH4ZN/ki5eHpmwO36J/Aa4r7Nwfp+b9xif25izNbaZKCIE80bGoxPj5urowj2idYog7BHsSsN3qef7gDjyhp9B/Wv0AYeUyn6UukiVtcxoXv2Pqs+OeBulbHjWDXs3wqkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854674; c=relaxed/simple;
	bh=mle9TPjxbQQB49vWxT239XWJgNhWyzIBF+C7mi5J5bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV7Qixw4H3Kn5m+ZBL46IQYaLzCrCLZUA3yV0nTYEeYKPRO/Q+y/n62aiQ5RKeWlYEX7+9bhgWKO+xrlBgq0hOMYB5ZxbrvvQW/75EReMwRvz3lCnoTO2nPxR914MXW8r+M+a7lMnr1eBmCN9OIO0E87DaedXzxUnO71HAjBVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4M9Krik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B090BC19421;
	Wed, 18 Mar 2026 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854674;
	bh=mle9TPjxbQQB49vWxT239XWJgNhWyzIBF+C7mi5J5bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4M9Krik8gMOdknrZJk4Xla8jczyIpFx9JCJc34L6tecfF/rnaTpiwLCjXchmkn2I
	 QVKN/DJjojZhTvAavTo3TZ6pWm8wHFz83fPT69I1Fd0di0luDAT9YDAYfET7y/7cxb
	 uKFZKE44v5R7NV97jq+0Rqfb7oixhsH6hqP2RSC0F0kR2/j304DVCclc8sfk5qHsRa
	 SAngPbw4IMtlg/r+T1bkzxJBGmnqnvuOSENajpwcMkvckJCct96Ibzt1OE0FTNhfpU
	 AFbpEpXi8i6W16W81NW0cfpaMTClamiQ8Q0P5zW4eXZOTBwXW0lXKnKDSzyOW/gvrW
	 7h7yqclF8t0Bw==
Date: Wed, 18 Mar 2026 18:24:31 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix STA link removal
 during link removal
Message-ID: <abrfz9t3DIu1PDPm@lore-desk>
References: <20260318180622.9240067117e9.I45fb2b7f04d75e48d2f3e9c6650ef9f54a314f5b@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyh8sLobxD/xLVyK"
Content-Disposition: inline
In-Reply-To: <20260318180622.9240067117e9.I45fb2b7f04d75e48d2f3e9c6650ef9f54a314f5b@changeid>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33421-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,w1.fi:email]
X-Rspamd-Queue-Id: 7CA2B2C04C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pyh8sLobxD/xLVyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> ieee80211_sta_free_link() only frees the link and doesn't
> unhash it, so it can't be used here. Instead this needs
> to use ieee80211_sta_remove_link(), which unhashes it. An
> argument against it was that it also calls the driver and
> that already happened, but calls to the driver removing a
> link that's already removed are suppressed, so that's not
> actually an issue. Use it to fix the hashtable.
>=20
> Reported-and-tested-by: Jouni Malinen <j@w1.fi>
> Fixes: 84674b03d8bf ("wifi: mac80211: Remove deleted sta links in ieee802=
11_ml_reconf_work()")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for fixing it.
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  net/mac80211/mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index f279bdb03aca..0cd8d07bf668 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -7119,7 +7119,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *=
wiphy,
> =20
>  		for_each_set_bit(link_id, &removed_links,
>  				 IEEE80211_MLD_MAX_NUM_LINKS)
> -			ieee80211_sta_free_link(sta, link_id);
> +			ieee80211_sta_remove_link(sta, link_id);
>  	}
> =20
>  	new_dormant_links =3D sdata->vif.dormant_links & ~sdata->u.mgd.removed_=
links;
> --=20
> 2.53.0
>=20

--pyh8sLobxD/xLVyK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabrfzwAKCRA6cBh0uS2t
rMlXAP9DSP07iLVqZY2GaUxv0rs9mWTy2CDUveXXgXv7rJlA+wD+LDUxmhL13JP/
0o0X3df2+EFitbrSvqMz5hNQqSRn4QE=
=Pmdl
-----END PGP SIGNATURE-----

--pyh8sLobxD/xLVyK--

