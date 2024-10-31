Return-Path: <linux-wireless+bounces-14770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A59B7766
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC6028729B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16402AE9A;
	Thu, 31 Oct 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RhZhe9QY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DE1953BB
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366733; cv=none; b=j3DZpVUalYCabSjcYWwzCMlSKdUZp4RO7UFr5Fp9D27uccLWVYkMf2gGqoOOqHU3SCnvjlfmTpbHJFGduWRJnqaxuddMRFxiwStDA9i0Dn4+ULdtDt0nhXYWkuemvGK1Ze3DsPFVzRMdztT7fflWOFnUEzRF1A3BSNTz2cnkCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366733; c=relaxed/simple;
	bh=igU3YD2gTFvL6SRw+zvMfGhyI7kshb+qH0gLKFBFPik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTRD6vH+zOSKu35RkCT6EVcjk7Ub/ht13cmGjjwRDaHhZbE2aJ4C2WFsakanoHqXbvCHim+8+H038uXzu42hFIoH2f3YnFdQdv5f8JCc6JenlR3ooZpcs/FYE7csWnda4MIOG0PvOl+11tuUDGhIgcQ7rCGhp2UA48RCkjQvTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RhZhe9QY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v4XL6NR0MlbeM5C9eez14VUJKm+e/odrQvpRS4cSaz4=;
	t=1730366731; x=1731576331; b=RhZhe9QY93kUvtLIeFFBzX895OtWvtDLFbS8FhwHbtZCNVo
	ZrXZ43qat+W4xEXMpumwD5j9JIa/zTwBJrzHH2JLVrcef9aGQSrPgKLRucaP7GLWEy6y/vGa3ABxD
	PlZxz9Seu1QO5vPon6u+CZevRr46N1TmS50edpAYQ/DB6pysB5DohqZgsuLWN6y3vmmYu0SKrlCiP
	SBZBEzCqTtTOL0/VVvZNjqh+6fqbvv5k/ToIkPY+exGEKVUK/9PBB1OcErXwog0n0EMMXROfwe87g
	FzJh7iAMICMNvYuf7rxZtCmIeDUXZ3SgxsBjJxAL4zVWkCtQmpISk0W08onHNxvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t6RQl-0000000ANPk-1eLJ;
	Thu, 31 Oct 2024 10:25:27 +0100
Message-ID: <b07102047bf2f076c090948b1a06ae4f22a881ff.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Correctly handle Medium Synchronization
 Delay
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 31 Oct 2024 10:25:23 +0100
In-Reply-To: <3a74f2f1-fd9f-46a5-87c1-fdc0235a50e5@quicinc.com>
References: <20241030025515.16004-1-quic_lingbok@quicinc.com>
	 <e56621b7a8b229f726d644ffde7b98ba0c11b06b.camel@sipsolutions.net>
	 <3a74f2f1-fd9f-46a5-87c1-fdc0235a50e5@quicinc.com>
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

On Thu, 2024-10-31 at 13:23 +0800, Lingbo Kong wrote:
> On 2024/10/30 18:23, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Wed, 2024-10-30 at 10:55 +0800, Lingbo Kong wrote:
> > > Currently, when the driver attempts to connect to an AP MLD with mult=
iple
> > > APs, the cfg80211_mlme_check_mlo_compat() function requires the Mediu=
m
> > > Synchronization Delay values from different APs of the same AP MLD to=
 be
> > > equal, which may result in connection failures.
> > >=20
> > > This is because when the driver receives a multi-link probe response =
from
> > > an AP MLD with multiple APs, cfg80211 updates the Elements for each A=
P
> > > based on the multi-link probe response. If the Medium Synchronization=
 Delay
> > > is set in the multi-link probe response, the Elements for each AP bel=
onging
> > > to the same AP MLD will have the Medium Synchronization Delay set
> > > simultaneously. If non-multi-link probe responses are received from
> > > different APs of the same MLD AP, cfg80211 will still update the Elem=
ents
> > > based on the non-multi-link probe response. Since the non-multi-link =
probe
> > > response does not set the Medium Synchronization Delay
> > > (IEEE 802.11be-2024-35.3.4.4), if the Elements from a non-multi-link =
probe
> > > response overwrite those from a multi-link probe response that has se=
t the
> > > Medium Synchronization Delay, the Medium Synchronization Delay values=
 for
> > > APs belonging to the same AP MLD will not be equal. This discrepancy =
causes
> > > the cfg80211_mlme_check_mlo_compat() function to fail, leading to
> > > connection failures. Commit ccb964b4ab16
> > > ("wifi: cfg80211: validate MLO connections better") did not take this=
 into
> > > account.
> >=20
> > The specification confuses me a bit and I am probably missing
> > something.
> >=20
> > > To address this issue, add a u16 type member to the struct cfg80211_b=
ss to
> > > store the Medium Synchronization Delay. When the driver receives a pr=
obe
> > > response with the Medium Synchronization Delay set, update this membe=
r=E2=80=99s
> > > value; otherwise, do not update it. Additionally, modify the paramete=
r list
> > > of cfg80211_mlme_check_mlo_compat() so that this member variable can =
be
> > > directly accessed within the cfg80211_mlme_check_mlo_compat() functio=
n viaq
> > > a pointer to the struct cfg80211_bss. This will allow checking whethe=
r the
> > > Medium Synchronization Delay values from different APs of the same AP=
 MLD
> > > are equal.
> >=20
> > This feels like a recipe for failures. Whether or not an ML-Probe
> > Response is seen should not generally affect the validity of a BSS.
> > Which means that the validity check itself may be incorrect.
> >=20
> > Maybe we should only compare the values if the subfield has been
> > included?
> >=20
> >=20
> > That said, do you understand when exactly the subfield should be
> > included? It seems that it may be carried in the "(Re)Association
> > Response", in which case it would be consistent anyway.
> >=20
> > The ML probe response part seems a bit specific. Could it be that this
> > is intended to be used by NSTR APs only, in which case there would not
> > be a beacon on the secondary AP. If that is the case, then there
> > wouldn't be much of an inconsistency (though we would still need to be
> > a bit careful).
> >=20
> > Benjamin
> >=20
>=20
> hi=EF=BC=8Cbenjamin,
>=20
> regarding your comment, I believe removing this validity check might be=
=20
> the easiest solution. As for the scenarios where this subfield would be=
=20
> included, I referred to the IEEE 802.11be specification. According to
> section 35.3.16.8, it states:
>=20
> A STA shall not start a MediumSyncDelay timer unless the STA is one of=
=20
> the following:
> =E2=80=94 a non-AP STA affiliated with a non-AP MLD operating on an NSTR =
link
> pair or
> =E2=80=94 a non-AP STA affiliated with a non-AP MLD operating on an EMLSR=
 link or
> =E2=80=94 a non-AP STA affiliated with a non-AP MLD operating on an EMLMR=
 link or
> =E2=80=94 an AP affiliated with an NSTR mobile AP MLD operating on the=
=20
> nonprimary link of an NSTR link pair.

Right, which does seem to imply that a non-NSTR AP can very well set a
Medium Delay Synchronization.

> Regarding the statement =E2=80=9CCould it be that this is intended to be =
used by=20
> NSTR APs only,=E2=80=9D I did not find any explicit indication in the spe=
c that=20
> the multi-link probe response carrying the medium sync delay subfield is=
=20
> solely applicable to NSTR APs.
>=20
> Additionally, do you have any suggestions on how to address this issue?=
=F0=9F=99=82

Not really. I don't grasp the intention of the specification here. But
if an AP may include the field in an ML Probe Response, then we
obviously cannot rely on the value to be consistent.

Seems to me that the option to remove the check is still the best way
forward right now.

Benjamin

> > >=20
> > > Fixes: ccb964b4ab16 ("wifi: cfg80211: validate MLO connections better=
")
> > > Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> > > ---
> > > =C2=A0=C2=A0include/net/cfg80211.h |=C2=A0 4 ++++
> > > =C2=A0=C2=A0net/wireless/mlme.c=C2=A0=C2=A0=C2=A0 | 11 +++++++----
> > > =C2=A0=C2=A0net/wireless/scan.c=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++++=
+
> > > =C2=A0=C2=A03 files changed, 26 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > index 27acf1292a5c..ebeb305c1d0c 100644
> > > --- a/include/net/cfg80211.h
> > > +++ b/include/net/cfg80211.h
> > > @@ -2956,6 +2956,8 @@ struct cfg80211_bss_ies {
> > > =C2=A0=C2=A0 * @cannot_use_reasons: the reasons (bitmap) for not bein=
g able to connect,
> > > =C2=A0=C2=A0 *	if @restrict_use is set and @use_for is zero (empty); =
may be 0 for
> > > =C2=A0=C2=A0 *	unspecified reasons; see &enum nl80211_bss_cannot_use_=
reasons
> > > + * @med_sync_delay: Medium Synchronization delay as described in
> > > + *	IEEE 802.11be-2024 Figure 9-1074q.
> > > =C2=A0=C2=A0 * @priv: private area for driver use, has at least wiphy=
->bss_priv_size bytes
> > > =C2=A0=C2=A0 */
> > > =C2=A0=C2=A0struct cfg80211_bss {
> > > @@ -2986,6 +2988,8 @@ struct cfg80211_bss {
> > > =C2=A0=C2=A0	u8 use_for;
> > > =C2=A0=C2=A0	u8 cannot_use_reasons;
> > > =C2=A0=20
> > > +	u16 med_sync_delay;
> > > +
> > > =C2=A0=C2=A0	u8 priv[] __aligned(sizeof(void *));
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > index 4dac81854721..ae00c36779d2 100644
> > > --- a/net/wireless/mlme.c
> > > +++ b/net/wireless/mlme.c
> > > @@ -326,7 +326,9 @@ void cfg80211_oper_and_vht_capa(struct ieee80211_=
vht_cap *vht_capa,
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static int
> > > -cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_ele=
m *mle_a,
> > > +cfg80211_mlme_check_mlo_compat(const struct cfg80211_bss *bss_a,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cfg80211_bss *b=
ss_b,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ieee80211_multi=
_link_elem *mle_a,
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ieee=
80211_multi_link_elem *mle_b,
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct netlink_ex=
t_ack *extack)
> > > =C2=A0=C2=A0{
> > > @@ -340,8 +342,7 @@ cfg80211_mlme_check_mlo_compat(const struct ieee8=
0211_multi_link_elem *mle_a,
> > > =C2=A0=C2=A0		return -EINVAL;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	if (ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_a) !=3D
> > > -	=C2=A0=C2=A0=C2=A0 ieee80211_mle_get_eml_med_sync_delay((const u8 *=
)mle_b)) {
> > > +	if (bss_a->med_sync_delay !=3D bss_b->med_sync_delay) {
> > > =C2=A0=C2=A0		NL_SET_ERR_MSG(extack, "link EML medium sync delay mism=
atch");
> > > =C2=A0=C2=A0		return -EINVAL;
> > > =C2=A0=C2=A0	}
> > > @@ -426,7 +427,9 @@ static int cfg80211_mlme_check_mlo(struct net_dev=
ice *dev,
> > > =C2=A0=C2=A0		if (WARN_ON(!mles[i]))
> > > =C2=A0=C2=A0			goto error;
> > > =C2=A0=20
> > > -		if (cfg80211_mlme_check_mlo_compat(mles[req->link_id], mles[i],
> > > +		if (cfg80211_mlme_check_mlo_compat(req->links[req->link_id].bss,
> > > +						=C2=A0=C2=A0 req->links[i].bss,
> > > +						=C2=A0=C2=A0 mles[req->link_id], mles[i],
> > > =C2=A0=C2=A0						=C2=A0=C2=A0 extack)) {
> > > =C2=A0=C2=A0			req->links[i].error =3D -EINVAL;
> > > =C2=A0=C2=A0			goto error;
> > > diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> > > index 1c6fd45aa809..6ad935475484 100644
> > > --- a/net/wireless/scan.c
> > > +++ b/net/wireless/scan.c
> > > @@ -1899,6 +1899,13 @@ cfg80211_update_known_bss(struct cfg80211_regi=
stered_device *rdev,
> > > =C2=A0=C2=A0	 */
> > > =C2=A0=C2=A0	if (signal_valid)
> > > =C2=A0=C2=A0		known->pub.signal =3D new->pub.signal;
> > > +
> > > +	/* update medium synchronization delay when its value is not
> > > +	 * the default.
> > > +	 */
> > > +	if (new->pub.med_sync_delay !=3D IEEE80211_MED_SYNC_DELAY_DEFAULT)
> > > +		known->pub.med_sync_delay =3D new->pub.med_sync_delay;
> > > +
> > > =C2=A0=C2=A0	known->pub.capability =3D new->pub.capability;
> > > =C2=A0=C2=A0	known->ts =3D new->ts;
> > > =C2=A0=C2=A0	known->ts_boottime =3D new->ts_boottime;
> > > @@ -2224,6 +2231,7 @@ cfg80211_inform_single_bss_data(struct wiphy *w=
iphy,
> > > =C2=A0=C2=A0	int bss_type;
> > > =C2=A0=C2=A0	bool signal_valid;
> > > =C2=A0=C2=A0	unsigned long ts;
> > > +	const struct element *ml;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (WARN_ON(!wiphy))
> > > =C2=A0=C2=A0		return NULL;
> > > @@ -2267,6 +2275,7 @@ cfg80211_inform_single_bss_data(struct wiphy *w=
iphy,
> > > =C2=A0=C2=A0	tmp.pub.use_for =3D data->use_for;
> > > =C2=A0=C2=A0	tmp.pub.cannot_use_reasons =3D data->cannot_use_reasons;
> > > =C2=A0=C2=A0	tmp.bss_source =3D data->bss_source;
> > > +	tmp.pub.med_sync_delay =3D IEEE80211_MED_SYNC_DELAY_DEFAULT;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	switch (data->bss_source) {
> > > =C2=A0=C2=A0	case BSS_SOURCE_MBSSID:
> > > @@ -2321,6 +2330,12 @@ cfg80211_inform_single_bss_data(struct wiphy *=
wiphy,
> > > =C2=A0=C2=A0		break;
> > > =C2=A0=C2=A0	case CFG80211_BSS_FTYPE_PRESP:
> > > =C2=A0=C2=A0		rcu_assign_pointer(tmp.pub.proberesp_ies, ies);
> > > +		ml =3D cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
> > > +					=C2=A0=C2=A0=C2=A0 ies->data, ies->len);
> > > +		if (ml)
> > > +			tmp.pub.med_sync_delay =3D
> > > +				ieee80211_mle_get_eml_med_sync_delay(ml->data + 1);
> > > +
> > > =C2=A0=C2=A0		break;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=C2=A0	rcu_assign_pointer(tmp.pub.ies, ies);
> > >=20
> > > base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44
> >=20
>=20


