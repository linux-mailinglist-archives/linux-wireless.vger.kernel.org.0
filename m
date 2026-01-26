Return-Path: <linux-wireless+bounces-31192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBatDJntd2kVmgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 23:41:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF68DFD8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 23:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EEC30056DE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 22:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348E3016E0;
	Mon, 26 Jan 2026 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLu4CEVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF02F549C
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467281; cv=none; b=o4cq2Weisnf036fIKYZTWyL8SUZFvN6EeUQyHDYyU0GySKaLzWDmsT3AV0Bi8KrJfSJ+Hy9c7XWlnOps3P5IIdwbmbpSsnmEiF77fWfQnlRYh5sNDoQAXeXUYFR8M3DPxFTokEAX8ANvzNwQ7I8PpthBsmqRaH2+b7DNp+kA5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467281; c=relaxed/simple;
	bh=GG68a5Sdfw/2OYhV/QwlBvR+ObFQ6lplVxmghdV94Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy9tKs3Ink+g3MfG8BoA2Td+VfM9DNrYixNTuzC4gtlnWXc/IiwrCUvHSZw4xQqoZdQvgZSlSpcp91jJxg5g+GLqFX53Xn0yMQtiOS6mZERul5MUIWrFI/GAe/+8I+4cl9DYIJDmj8O27v8+pktJtST2RO6+8LBxT3z1FTpW5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLu4CEVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3D7C116C6;
	Mon, 26 Jan 2026 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769467280;
	bh=GG68a5Sdfw/2OYhV/QwlBvR+ObFQ6lplVxmghdV94Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLu4CEVlm4o+fLpIapOoGxYB3DIXMNl3LdZWylEVcULSRdkEVa3kyHIau3bhMdij7
	 A3xnrkxbWDPutWDFb6JE+rj6ZHXFKY3RnxtpR3uCe2Pr0jDCpjdwGAyHI3O4HjRmxD
	 seQKh8P6iQSINNjYCgZwC1dkX3/a5rdgAiab8EkP7V0a8mzRAbZzUpqx1eFJ91UV2L
	 diW2Dg3YEMfHbqPUg+bF+++v/xqbAdEt+NKdjfu3H3gWtQGr6vbJsjUBHOohVDP7Ws
	 0akBcV7UNJTVZ7spWACuh0wGqTOEEqSZ/Wzr0imdjHtP8WHN79fXnmrIaZsWysy/XD
	 8mM1IcvNv9ViQ==
Date: Mon, 26 Jan 2026 23:41:17 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: Add eMLSR/eMLMR
 action frame parsing support
Message-ID: <aXftjdCtqnQk69ys@lore-desk>
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
 <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org>
 <01e62344994a34daae0666b3873aa98e72fb5850.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FyaHzk/0gDfHIB6D"
Content-Disposition: inline
In-Reply-To: <01e62344994a34daae0666b3873aa98e72fb5850.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-31192-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,nbd.name,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89AF68DFD8
X-Rspamd-Action: no action


--FyaHzk/0gDfHIB6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 2026-01-25 at 11:51 +0100, Lorenzo Bianconi wrote:
> >=20
> > +static inline u8 ieee80211_get_emlsr_pad_delay_update(u8 param)
> > +{
> > +	u8 pad_delay =3D FIELD_GET(IEEE80211_EML_EMLSR_PAD_DELAY, param);
>=20
> I generally prefer the typed versions and mac80211 (mostly?) uses those,
> i.e. u8_get_bits() and friends, since they also cover endian conversions
> where needed. Is there any reason you use FIELD_* versions here?

ack, I will fix it in v3.

>=20
> > +	if (pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
> > +		pad_delay =3D 0;
>=20
> Seems that should use a constant, rather than =3D0?
>=20
> Also, is that really the right thing to do (also below) to just silently
> cap it? Maybe that should be up to the caller? In some(/most/all)? cases
> we should probably even just _reject_ frames that carry an invalid
> value, which you can't do with this helper?

I guess we can just move this code in the caller and reject the frame if the
values are not valid. I will fix it in v3.

>=20
> > +static inline u32 ieee80211_get_emlsr_trans_delay_update(u8 param)
> > +{
> > +	u16 trans_delay =3D FIELD_GET(IEEE80211_EML_EMLSR_TRANS_DELAY, param);
> > +
> > +	if (trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
> > +		trans_delay =3D 0;
> > +
> > +	return trans_delay;
>=20
> why does that use _three_ different types? Wouldn't u8 be sufficient?
>=20
> > --- a/include/net/mac80211.h
> > +++ b/include/net/mac80211.h
> > @@ -1902,6 +1902,21 @@ enum ieee80211_offload_flags {
> >  	IEEE80211_OFFLOAD_DECAP_ENABLED		=3D BIT(2),
> >  };
> > =20
> > +struct ieee80211_eml_params {
> > +	u8 control;
> > +	u16 link_bitmap;
> > +	union {
> > +		struct {
> > +			u16 emlsr_pad_delay;
> > +			u16 emlsr_trans_delay;
> > +		};
> > +		struct {
> > +			u8 mcs_map_count;
> > +			u8 mcs_map_bw[9];
> > +		};
> > +	};
> > +};
>=20
> Maybe add kernel-doc? Also not sure the union really is worth it? It's a
> tiny thing. Especially since you don't even label it - maybe if the
> parts were labled emlsr and emlmr, and then you had emlsr.pad_delay?
>=20
> (I'd label them anyway, of course, even if not a union.)

ack, I will add kernel-doc in v3.

>=20
> Also now the emlsr pad/trans delay are duplicated in the station info,
> is that worth doing? You have to and do track them there too, anyway, as
> we discussed on IRC, could just have the driver use them from there?

I agree, I guess we can drop emlsr_pad_delay and emlsr_trans_delay in
ieee80211_eml_params struct and just rely on sta values. I will fix it in v=
3.

>=20
> Per spec I'm also not sure what the MCS map should be when it's not
> included in the frame?

IIUC the mcs map value are supposed to be in Operation mode notification fr=
ame
just for eMLMR. I think the driver should check if the bit is set in
ieee80211_eml_params control field to verify if mcs_map_bw values are valid.

>=20
> > + * @set_eml_op_mode: Configure eMLSR/eMLMR operation mode in the under=
lay
> > + *	driver according to the parameter received in the EML Operating mode
> > + *	notification frame.
>=20
> Maybe describe the link_id here, or move it to the params and describe
> it in kernel-doc there?

ack, I will fix it in v3.

>=20
> > +static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sd=
ata,
> > +				      struct ieee80211_sta *sta,
> > +				      unsigned int link_id,
> > +				      struct ieee80211_eml_params *eml_params)
> > +{
> > +	struct ieee80211_local *local =3D sdata->local;
> > +	int ret =3D 0;
>=20
> Shouldn't that be -EOPNOTSUPP?

ack, I will fix it in v3.

>=20
> > +static void
> > +ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
> > +				 struct ieee80211_mgmt *req, u8 act_len)
> > +{
> > +	int hdr_len =3D offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
> > +	struct ieee80211_local *local =3D sdata->local;
> > +	struct ieee80211_mgmt *mgmt;
> > +	struct sk_buff *skb;
> > +
> > +	skb =3D dev_alloc_skb(local->tx_headroom + hdr_len + act_len);
> > +	if (!skb)
> > +		return;
> > +
> > +	skb_reserve(skb, local->tx_headroom);
> > +	mgmt =3D skb_put_zero(skb, hdr_len);
> > +	mgmt->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT |
> > +					  IEEE80211_STYPE_ACTION);
> > +	memcpy(mgmt->da, req->sa, ETH_ALEN);
> > +	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
> > +	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
> > +
> > +	mgmt->u.action.category =3D WLAN_CATEGORY_PROTECTED_EHT;
> > +	memcpy(&mgmt->u.action.u.eml_omn, &req->u.action.u.eml_omn, act_len);
> > +	mgmt->u.action.u.eml_omn.control &=3D
> > +		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
> > +		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
> > +	ieee80211_tx_skb(sdata, skb);
>=20
> It seems to me that it'd be better to not copy the request, but rather
> build the response. It's not _that_ much data, and from the spec it
> seems to me that e.g. the MCS map should be included in the response,
> but you do that now, I think?

ack for avoiding memcpy().
Reading the standard, it is not clear to me if mcs map values are supposed =
to be
added in the Notification frame sent by the AP. What do you think?

>=20
> > +void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdat=
a,
> > +				    struct sk_buff *skb)
> > +{
> > +	int hdr_len =3D offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
> > +	enum nl80211_iftype type =3D ieee80211_vif_type_p2p(&sdata->vif);
> > +	struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
> > +	const struct wiphy_iftype_ext_capab *ift_ext_capa;
> > +	struct ieee80211_mgmt *mgmt =3D (void *)skb->data;
> > +	struct ieee80211_local *local =3D sdata->local;
> > +	u8 control =3D mgmt->u.action.u.eml_omn.control;
> > +	u8 *ptr =3D mgmt->u.action.u.eml_omn.variable;
> > +	struct ieee80211_eml_params eml_params =3D {};
> > +	struct sta_info *sta;
> > +	u8 act_len =3D 3; /* action_code + dialog_token + control */
> > +
> > +	if (!ieee80211_vif_is_mld(&sdata->vif))
> > +		return;
> > +
> > +	/* eMLSR and eMLMR can't be enabled at the same time */
> > +	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) &&
> > +	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
> > +		return;
> > +
> > +	if ((control & IEEE80211_EML_CTRL_EMLMR_MODE) &&
> > +	    (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE))
> > +		return;
> > +
> > +	ift_ext_capa =3D cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
> > +	if (!ift_ext_capa)
> > +		return;
> > +
> > +	if (!status->link_valid)
> > +		return;
> > +
> > +	sta =3D sta_info_get_bss(sdata, mgmt->sa);
> > +	if (!sta)
> > +		return;
> > +
> > +	if (control & IEEE80211_EML_CTRL_EMLSR_MODE) {
> > +		if (!(ift_ext_capa->eml_capabilities &
> > +		      IEEE80211_EML_CAP_EMLSR_SUPP))
> > +			return;
> > +
> > +		if (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE) {
> > +			u16 eml_cap =3D sta->sta.eml_cap;
> > +			u8 pad_delay, trans_delay;
> > +
> > +			/* Update sta padding and transition delay */
> > +			pad_delay =3D
> > +				ieee80211_get_emlsr_pad_delay_update(ptr[3]);
> > +			trans_delay =3D
> > +				ieee80211_get_emlsr_pad_delay_update(ptr[3]);
>=20
> It seems to me you're missing a bunch of input validation?

ack, I will fix it in v3.

>=20
> > +
> > +			eml_cap &=3D ~(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
> > +				     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
> > +			eml_cap |=3D FIELD_PREP(IEEE80211_EML_EMLSR_PAD_DELAY,
> > +					      pad_delay) |
> > +				   FIELD_PREP(IEEE80211_EML_EMLSR_TRANS_DELAY,
> > +					      trans_delay);
> > +			sta->sta.eml_cap =3D eml_cap;
>=20
> Same comment about typed bitfield accessors, and u8_replace_bits() would
> even shorten that quite a bit.

ack, I will fix it in v3.

>=20
> > +	if (skb->len < hdr_len + act_len)
> > +		return;
>=20
> bit late that :)

ack, I will fix it in v3.

Regards,
Lorenzo

>=20
> johannes

--FyaHzk/0gDfHIB6D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaXftjQAKCRA6cBh0uS2t
rLisAP9om80pHQDOpkvChlQaFlawZ3byFu4csjW1/hk/HojIRgD+LLdCh5Vm2gpA
XN3PnDjwrSF2tiFB0i7hjlpAlocr7gs=
=3ipe
-----END PGP SIGNATURE-----

--FyaHzk/0gDfHIB6D--

