Return-Path: <linux-wireless+bounces-14712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07B9B6001
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C641C21468
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97751E231B;
	Wed, 30 Oct 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oigUY+ch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084911990CD
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283823; cv=none; b=pkg5ERMQiIdkbfsznrYILZE5BYQA/NY86a5XjKVE7uuniwu9Si5cJw5KnFHsHEY3HwWUkSkNUYMb00vH5PgsJEkL+g2Dcxpx1t1taulBGFh+XXh1H6j7l+10E1uEa3cchVDoOie8AFIArurAUHP3V+VUSqcAeIH2VM89PygIBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283823; c=relaxed/simple;
	bh=pqLoVbAINGwJlzD3cEC/w1t5NfhSv0whqRsWu4YBJc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooYuDjSoUPQ8CGxjgu0NKJBL88/iPzxfHKCkZfUaHn61oj5CdVXVuBuYUfdbWdPJCrZDUpe+1d/el/USr0MGdiwNZMfybPynIaUtmbo6sYyAUIGj7OVrj7R1tJXaEeAn7QI+K5VK5ZjR+F4ZY2ltZX/+Qfczvx3l9wvKsHr2p6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oigUY+ch; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fjgMZp/MvoYIiuvXXF2zmjIunDCfVbEMvg0oRxBn7Gs=;
	t=1730283821; x=1731493421; b=oigUY+chlBuUd2Hj+LZaCwyS/pGONLRgxV7PWB2EEa7QugR
	RIsz3/yvEQ01WUD3G0PwOyCBkHS1LZy2zTUHPmduCO2O41Sw75YyQnbDQGbHEvTqBhG5e0JOViDHB
	cZiA8DcpgYK94ft/tWbkFxfdffXZYOzwLvRJPLhflq2UkAgAtwnuIfW+Kw9nDen6id+IEuyH7fsNR
	pMKqs5Nnnxs4Onk5fHRpCN0U2rf80kyBr+lN2642xWzvsc0BfZXZKnSNjZgehZZ3K6rqPpXyhE1vU
	YdGhZM2AZ0Ri/IqvDb5QUDtGrYaDDmB/9AcXPhSXfEAxc5uxCxXKXOZxfIw8sJaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t65rP-00000009K9J-08lg;
	Wed, 30 Oct 2024 11:23:31 +0100
Message-ID: <e56621b7a8b229f726d644ffde7b98ba0c11b06b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Correctly handle Medium Synchronization
 Delay
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 30 Oct 2024 11:23:28 +0100
In-Reply-To: <20241030025515.16004-1-quic_lingbok@quicinc.com>
References: <20241030025515.16004-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2024-10-30 at 10:55 +0800, Lingbo Kong wrote:
> Currently, when the driver attempts to connect to an AP MLD with multiple
> APs, the cfg80211_mlme_check_mlo_compat() function requires the Medium
> Synchronization Delay values from different APs of the same AP MLD to be
> equal, which may result in connection failures.
>=20
> This is because when the driver receives a multi-link probe response from
> an AP MLD with multiple APs, cfg80211 updates the Elements for each AP
> based on the multi-link probe response. If the Medium Synchronization Del=
ay
> is set in the multi-link probe response, the Elements for each AP belongi=
ng
> to the same AP MLD will have the Medium Synchronization Delay set
> simultaneously. If non-multi-link probe responses are received from
> different APs of the same MLD AP, cfg80211 will still update the Elements
> based on the non-multi-link probe response. Since the non-multi-link prob=
e
> response does not set the Medium Synchronization Delay
> (IEEE 802.11be-2024-35.3.4.4), if the Elements from a non-multi-link prob=
e
> response overwrite those from a multi-link probe response that has set th=
e
> Medium Synchronization Delay, the Medium Synchronization Delay values for
> APs belonging to the same AP MLD will not be equal. This discrepancy caus=
es
> the cfg80211_mlme_check_mlo_compat() function to fail, leading to
> connection failures. Commit ccb964b4ab16
> ("wifi: cfg80211: validate MLO connections better") did not take this int=
o
> account.

The specification confuses me a bit and I am probably missing
something.

> To address this issue, add a u16 type member to the struct cfg80211_bss t=
o
> store the Medium Synchronization Delay. When the driver receives a probe
> response with the Medium Synchronization Delay set, update this member=E2=
=80=99s
> value; otherwise, do not update it. Additionally, modify the parameter li=
st
> of cfg80211_mlme_check_mlo_compat() so that this member variable can be
> directly accessed within the cfg80211_mlme_check_mlo_compat() function vi=
aq
> a pointer to the struct cfg80211_bss. This will allow checking whether th=
e
> Medium Synchronization Delay values from different APs of the same AP MLD
> are equal.

This feels like a recipe for failures. Whether or not an ML-Probe
Response is seen should not generally affect the validity of a BSS.
Which means that the validity check itself may be incorrect.

Maybe we should only compare the values if the subfield has been
included?


That said, do you understand when exactly the subfield should be
included? It seems that it may be carried in the "(Re)Association
Response", in which case it would be consistent anyway.

The ML probe response part seems a bit specific. Could it be that this
is intended to be used by NSTR APs only, in which case there would not
be a beacon on the secondary AP. If that is the case, then there
wouldn't be much of an inconsistency (though we would still need to be
a bit careful).

Benjamin

>=20
> Fixes: ccb964b4ab16 ("wifi: cfg80211: validate MLO connections better")
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> =C2=A0include/net/cfg80211.h |=C2=A0 4 ++++
> =C2=A0net/wireless/mlme.c=C2=A0=C2=A0=C2=A0 | 11 +++++++----
> =C2=A0net/wireless/scan.c=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++++
> =C2=A03 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 27acf1292a5c..ebeb305c1d0c 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2956,6 +2956,8 @@ struct cfg80211_bss_ies {
> =C2=A0 * @cannot_use_reasons: the reasons (bitmap) for not being able to =
connect,
> =C2=A0 *	if @restrict_use is set and @use_for is zero (empty); may be 0 f=
or
> =C2=A0 *	unspecified reasons; see &enum nl80211_bss_cannot_use_reasons
> + * @med_sync_delay: Medium Synchronization delay as described in
> + *	IEEE 802.11be-2024 Figure 9-1074q.
> =C2=A0 * @priv: private area for driver use, has at least wiphy->bss_priv=
_size bytes
> =C2=A0 */
> =C2=A0struct cfg80211_bss {
> @@ -2986,6 +2988,8 @@ struct cfg80211_bss {
> =C2=A0	u8 use_for;
> =C2=A0	u8 cannot_use_reasons;
> =C2=A0
> +	u16 med_sync_delay;
> +
> =C2=A0	u8 priv[] __aligned(sizeof(void *));
> =C2=A0};
> =C2=A0
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index 4dac81854721..ae00c36779d2 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -326,7 +326,9 @@ void cfg80211_oper_and_vht_capa(struct ieee80211_vht_=
cap *vht_capa,
> =C2=A0}
> =C2=A0
> =C2=A0static int
> -cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *m=
le_a,
> +cfg80211_mlme_check_mlo_compat(const struct cfg80211_bss *bss_a,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cfg80211_bss *bss_b=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ieee80211_multi_lin=
k_elem *mle_a,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ieee80211_mult=
i_link_elem *mle_b,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct netlink_ext_ack *ext=
ack)
> =C2=A0{
> @@ -340,8 +342,7 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211=
_multi_link_elem *mle_a,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	if (ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_a) !=3D
> -	=C2=A0=C2=A0=C2=A0 ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle=
_b)) {
> +	if (bss_a->med_sync_delay !=3D bss_b->med_sync_delay) {
> =C2=A0		NL_SET_ERR_MSG(extack, "link EML medium sync delay mismatch");
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -426,7 +427,9 @@ static int cfg80211_mlme_check_mlo(struct net_device =
*dev,
> =C2=A0		if (WARN_ON(!mles[i]))
> =C2=A0			goto error;
> =C2=A0
> -		if (cfg80211_mlme_check_mlo_compat(mles[req->link_id], mles[i],
> +		if (cfg80211_mlme_check_mlo_compat(req->links[req->link_id].bss,
> +						=C2=A0=C2=A0 req->links[i].bss,
> +						=C2=A0=C2=A0 mles[req->link_id], mles[i],
> =C2=A0						=C2=A0=C2=A0 extack)) {
> =C2=A0			req->links[i].error =3D -EINVAL;
> =C2=A0			goto error;
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 1c6fd45aa809..6ad935475484 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1899,6 +1899,13 @@ cfg80211_update_known_bss(struct cfg80211_register=
ed_device *rdev,
> =C2=A0	 */
> =C2=A0	if (signal_valid)
> =C2=A0		known->pub.signal =3D new->pub.signal;
> +
> +	/* update medium synchronization delay when its value is not
> +	 * the default.
> +	 */
> +	if (new->pub.med_sync_delay !=3D IEEE80211_MED_SYNC_DELAY_DEFAULT)
> +		known->pub.med_sync_delay =3D new->pub.med_sync_delay;
> +
> =C2=A0	known->pub.capability =3D new->pub.capability;
> =C2=A0	known->ts =3D new->ts;
> =C2=A0	known->ts_boottime =3D new->ts_boottime;
> @@ -2224,6 +2231,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy=
,
> =C2=A0	int bss_type;
> =C2=A0	bool signal_valid;
> =C2=A0	unsigned long ts;
> +	const struct element *ml;
> =C2=A0
> =C2=A0	if (WARN_ON(!wiphy))
> =C2=A0		return NULL;
> @@ -2267,6 +2275,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy=
,
> =C2=A0	tmp.pub.use_for =3D data->use_for;
> =C2=A0	tmp.pub.cannot_use_reasons =3D data->cannot_use_reasons;
> =C2=A0	tmp.bss_source =3D data->bss_source;
> +	tmp.pub.med_sync_delay =3D IEEE80211_MED_SYNC_DELAY_DEFAULT;
> =C2=A0
> =C2=A0	switch (data->bss_source) {
> =C2=A0	case BSS_SOURCE_MBSSID:
> @@ -2321,6 +2330,12 @@ cfg80211_inform_single_bss_data(struct wiphy *wiph=
y,
> =C2=A0		break;
> =C2=A0	case CFG80211_BSS_FTYPE_PRESP:
> =C2=A0		rcu_assign_pointer(tmp.pub.proberesp_ies, ies);
> +		ml =3D cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
> +					=C2=A0=C2=A0=C2=A0 ies->data, ies->len);
> +		if (ml)
> +			tmp.pub.med_sync_delay =3D
> +				ieee80211_mle_get_eml_med_sync_delay(ml->data + 1);
> +
> =C2=A0		break;
> =C2=A0	}
> =C2=A0	rcu_assign_pointer(tmp.pub.ies, ies);
>=20
> base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44


