Return-Path: <linux-wireless+bounces-34542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPZOL/OD12mcPAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 12:48:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935A3C944D
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 12:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF22C300D158
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B48326D51;
	Thu,  9 Apr 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y49/FuF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F72BE641
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731696; cv=none; b=i31brGn7I3pR1vevuwf7nkusGQuz1n9nrrMm5PGpt6skMsC4zqpnOHVNlsHy2kVbdvkEAA/tRUVhlJY3Mj8VfXEFTuu4pKIuQEwpj7GOS5Gvwu2bwnBuCJCcn8br7WreCUpwBa/jggeAXKmm151wbvh7mfs+/FqhlBQehKqSx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731696; c=relaxed/simple;
	bh=dzh3TeeAhmT+JVh97KzgEtwRUNeIAznHOLYaIizNLyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhwO4nYKw5WCUDYFZVXQlJYU1Ylxnw2a6VcHKD5KlFu1vKtdMmvrt7F97cIDODefUjX463stU23hQ0nzOaUxAQ2d/ooQAFr1mogOd9CcKPvLhtKSmXxccdCaiwPwFZXobH1Yd/1qJfcjPRd6a0TE6E90tZdGxVujKvqGwXQbZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y49/FuF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD27C4CEF7;
	Thu,  9 Apr 2026 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775731695;
	bh=dzh3TeeAhmT+JVh97KzgEtwRUNeIAznHOLYaIizNLyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y49/FuF0mQtiN6Ud7GMBwbrcRltrL4GtgCuFQOzF0VBQ0Yi0qvzcTLYjsFWq7i0Z1
	 pUa7dfFKInp7wXwzW3Dk1YcFWu7TKYZOIEUW7oCQfo0+HQ6FpTWROKPH5bFerGL2x4
	 fVehSGMsrMU3HnbNglC4sAW+AEbuc7zCZ+ePDsRH8R+W9X2T8sTN3YDqXhMFnNlC/d
	 hmEMAzRbPBMpiH6EZY+SOp/PWCPLEdcImUGa+bUtA9Rb9YWpO3UvBMHnyKYN+UnUMv
	 dYfYAz3QIKz/xVjqFc+zXFUNfmXgZqKFVxWqyqhL7LoS+394LDuILmc38I7YEOjNpX
	 Meb0UzKKbgHyw==
Date: Thu, 9 Apr 2026 12:48:13 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: dylan.eskew@candelatech.com
Cc: nbd@nbd.name, ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
	shayne.chen@mediatek.com, sean.wang@mediatek.com
Subject: Re: [PATCH mt76 v2] wifi: mt76: mt7996: limit work in
 set_bitrate_mask
Message-ID: <adeD7c1aEXbeANmk@lore-desk>
References: <20260408145057.2356878-2-dylan.eskew@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VI7MSZE1I8SfjjRY"
Content-Disposition: inline
In-Reply-To: <20260408145057.2356878-2-dylan.eskew@candelatech.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34542-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0935A3C944D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--VI7MSZE1I8SfjjRY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Dylan Eskew <dylan.eskew@candelatech.com>
>=20
> Calls to mt7996_set_bitrate_mask() would propagate work for all stations
> on the ieee80211_hw regardless of the vif specified in the call. To
> prevent unnecessary work in FW, limit setting the sta_rate to only the
> specified vif in mt7996_sta_rate_ctrl_update().
>=20
> Fixes: afff4325548f0 ("wifi: mt76: mt7996: Use proper link_id in link_sta=
_rc_update callback")
> Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> v2:
>   - Assign to correct tree
>   - Fix spelling error in commit message
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index a8a6552d49f6..26b8c91db0a8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -1959,7 +1959,11 @@ static void mt7996_sta_rate_ctrl_update(void *data=
, struct ieee80211_sta *sta)
>  {
>  	struct mt7996_sta *msta =3D (struct mt7996_sta *)sta->drv_priv;
>  	struct mt7996_sta_link *msta_link;
> -	u32 *changed =3D data;
> +	struct mt7996_vif *mvif =3D data;
> +	u32 changed =3D IEEE80211_RC_SUPP_RATES_CHANGED;
> +
> +	if (msta->vif !=3D mvif)
> +		return;
> =20
>  	msta_link =3D rcu_dereference(msta->link[msta->deflink_id]);
>  	if (msta_link)
> @@ -1972,7 +1976,6 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif,
>  {
>  	struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
>  	struct mt7996_vif *mvif =3D (struct mt7996_vif *)vif->drv_priv;
> -	u32 changed =3D IEEE80211_RC_SUPP_RATES_CHANGED;
> =20
>  	mvif->deflink.bitrate_mask =3D *mask;
> =20
> @@ -1985,7 +1988,7 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif,
>  	 * then multiple MCS setting (MCS 4,5,6) is not supported.
>  	 */
>  	ieee80211_iterate_stations_atomic(hw, mt7996_sta_rate_ctrl_update,
> -					  &changed);
> +					  mvif);
>  	ieee80211_queue_work(hw, &dev->rc_work);
> =20
>  	return 0;
> --=20
> 2.52.0
>=20

--VI7MSZE1I8SfjjRY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadeD7QAKCRA6cBh0uS2t
rFVSAQCyhBUYQrn9QoUsf8LsP84otIXsgPmCOO/djRxiajsENwEAlyT8t3pU/Cc8
nOx1as+y7TsHQwdDFWzDufhcBqEbkgY=
=2y7N
-----END PGP SIGNATURE-----

--VI7MSZE1I8SfjjRY--

