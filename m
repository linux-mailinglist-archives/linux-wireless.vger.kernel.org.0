Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756911ADBD1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgDQLD0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 07:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgDQLDZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 07:03:25 -0400
Received: from lore-desk.lan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D878A208E4;
        Fri, 17 Apr 2020 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587121405;
        bh=g131sdxGELd+to0cnBhEzCSMV+tAOa02n/mJ9gSdMWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVZ1HujgIHgPO0n5NhtPCSvqQRjnKXf814NPxixDRHrGfyHDJeWVUsC1fagiUrJBF
         9hr2uqhE6rFPAfRM99OmLceGZPPxIaW3+wI6rM0S1P8WPInhQ4e4mrvZad3r2FStm6
         jkmv03i7Vb210PyetDe1IaahcOptnrjHR/pOfeyY=
Date:   Fri, 17 Apr 2020 13:03:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v2] mac80211: mlme: remove duplicate AID bookkeeping
Message-ID: <20200417110320.GA10962@lore-desk.lan>
References: <20200417123802.085d4a322b0c.I2e7a2ceceea8c6880219f9e9ee4d4ac985fd295a@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20200417123802.085d4a322b0c.I2e7a2ceceea8c6880219f9e9ee4d4ac985fd295a@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Maintain the connection AID only in sdata->vif.bss_conf.aid, not
> also in sdata->u.mgd.aid.
>=20
> Keep setting that where we set ifmgd->aid before, which has the
> side effect of exposing the AID to the driver before the station
> entry (AP) is marked associated, in case it needs it then.
>=20

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Requested-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/debugfs_netdev.c | 2 +-
>  net/mac80211/ieee80211_i.h    | 2 --
>  net/mac80211/mlme.c           | 7 +++----
>  net/mac80211/tdls.c           | 3 +--
>  net/mac80211/tx.c             | 2 +-
>  5 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
> index 3dbe7c5cefd1..d7e955127d5c 100644
> --- a/net/mac80211/debugfs_netdev.c
> +++ b/net/mac80211/debugfs_netdev.c
> @@ -236,7 +236,7 @@ IEEE80211_IF_FILE_R(hw_queues);
> =20
>  /* STA attributes */
>  IEEE80211_IF_FILE(bssid, u.mgd.bssid, MAC);
> -IEEE80211_IF_FILE(aid, u.mgd.aid, DEC);
> +IEEE80211_IF_FILE(aid, vif.bss_conf.aid, DEC);
>  IEEE80211_IF_FILE(beacon_timeout, u.mgd.beacon_timeout, JIFFIES_TO_MS);
> =20
>  static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index f8ed4f621f7f..934a91bef575 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -450,8 +450,6 @@ struct ieee80211_if_managed {
> =20
>  	u8 bssid[ETH_ALEN] __aligned(2);
> =20
> -	u16 aid;
> -
>  	bool powersave; /* powersave requested for this iface */
>  	bool broken_ap; /* AP is broken -- turn off powersave */
>  	bool have_beacon;
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 16d75da0996a..7139335f29c0 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -3249,7 +3249,7 @@ static bool ieee80211_assoc_success(struct ieee8021=
1_sub_if_data *sdata,
>  		return false;
>  	}
> =20
> -	ifmgd->aid =3D aid;
> +	sdata->vif.bss_conf.aid =3D aid;
>  	ifmgd->tdls_chan_switch_prohibited =3D
>  		elems->ext_capab && elems->ext_capab_len >=3D 5 &&
>  		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
> @@ -3521,9 +3521,8 @@ static bool ieee80211_assoc_success(struct ieee8021=
1_sub_if_data *sdata,
>  		bss_conf->protected_keep_alive =3D false;
>  	}
> =20
> -	/* set AID and assoc capability,
> +	/* set assoc capability (AID was already set earlier),
>  	 * ieee80211_set_associated() will tell the driver */
> -	bss_conf->aid =3D aid;
>  	bss_conf->assoc_capability =3D capab_info;
>  	ieee80211_set_associated(sdata, cbss, changed);
> =20
> @@ -3948,7 +3947,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee802=
11_sub_if_data *sdata,
>  					  mgmt->bssid, bssid);
> =20
>  	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
> -	    ieee80211_check_tim(elems.tim, elems.tim_len, ifmgd->aid)) {
> +	    ieee80211_check_tim(elems.tim, elems.tim_len, bss_conf->aid)) {
>  		if (local->hw.conf.dynamic_ps_timeout > 0) {
>  			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
>  				local->hw.conf.flags &=3D ~IEEE80211_CONF_PS;
> diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
> index fca1f5477396..7ff22f9d6e80 100644
> --- a/net/mac80211/tdls.c
> +++ b/net/mac80211/tdls.c
> @@ -226,12 +226,11 @@ static void ieee80211_tdls_add_link_ie(struct ieee8=
0211_sub_if_data *sdata,
>  static void
>  ieee80211_tdls_add_aid(struct ieee80211_sub_if_data *sdata, struct sk_bu=
ff *skb)
>  {
> -	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
>  	u8 *pos =3D skb_put(skb, 4);
> =20
>  	*pos++ =3D WLAN_EID_AID;
>  	*pos++ =3D 2; /* len */
> -	put_unaligned_le16(ifmgd->aid, pos);
> +	put_unaligned_le16(sdata->vif.bss_conf.aid, pos);
>  }
> =20
>  /* translate numbering in the WMM parameter IE to the mac80211 notation =
*/
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 82846aca86d9..3dc1990e15c5 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -5006,7 +5006,7 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee802=
11_hw *hw,
>  	pspoll =3D skb_put_zero(skb, sizeof(*pspoll));
>  	pspoll->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_CTL |
>  					    IEEE80211_STYPE_PSPOLL);
> -	pspoll->aid =3D cpu_to_le16(ifmgd->aid);
> +	pspoll->aid =3D cpu_to_le16(sdata->vif.bss_conf.aid);
> =20
>  	/* aid in PS-Poll has its two MSBs each set to 1 */
>  	pspoll->aid |=3D cpu_to_le16(1 << 15 | 1 << 14);
> --=20
> 2.25.1
>=20

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXpmM9AAKCRA6cBh0uS2t
rN5HAQDvqpzNixmvZTU99h2PfNpSawiqcrefz+0kNb45mH/LCAEAy8Zu3gCTkJue
b0i1aRgOLKuXNl/mvro42a2Mrr+eeg8=
=IYST
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
