Return-Path: <linux-wireless+bounces-37953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gh6EGhPoN2rrVQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:33:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689536AAEC4
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ll+xIAjH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37953-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37953-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3D303001873
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80ED282F36;
	Sun, 21 Jun 2026 13:33:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E21DDC1B;
	Sun, 21 Jun 2026 13:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048781; cv=none; b=TKRszHGwQgAfZLe5j1Ud/uV7LQ/zDDLSB96er+IQtiO9E05oULIcNrYzAn1bjcZYLdl19XAAmyd1WD9FoQBW3Evy+8AwGSsRlplkIYHSzy7hYdjIAjOBypvsrKlstfxtbet0mT/IS0pg3aSpAlU5vHkajFyhrX6RvWXcfKkJhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048781; c=relaxed/simple;
	bh=RAa+YH3/kuCiIuVm6lv0RNZvnRyhcaQL+iqZpbWcWNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYj72Rg+olY6keftZA1xRS2qxsWEYk7LphWx451tJR6HxY682rOfxHIb7ntrdgLOE68ArtoJtC9IchZsyf70MrEP1GyJcThcP/LcZ+9GN92J+3+BCZSaJ4kL6Hlx3tk7AeoA3tpfB/8Sf7abUopjwoyBKokPQnzrc4kz4BYfi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll+xIAjH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF03D1F000E9;
	Sun, 21 Jun 2026 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048780;
	bh=fGIlWd88BAgOVnBl8Y24/CjXs50BlRCUxmuF5epEu0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ll+xIAjHQA+1NdqglbgoF+aTz1pps/7dD2CGfiWWnDOq8WaL2JIDFnT5DmRoQWjxa
	 Q0mz3UsiAXsfHE8JA6XzJAvTWOAd4X/WEujKuWc2JO+4D3xWZ0Egl5U0WhXT2OdV/Z
	 xjk+N0Z48GiMebsOYShr5bDYUT5jslukVnRXQnfvYOFNrzuIJgO4gPKS8OauKfXwel
	 HgmDFh3kPqHXKSK+DmL47TIZP36ff2JD8ypDvMpCtcHHAMAM8nt7itscqeesiDtYih
	 2NZ5aOJozBm9Xfhj08eWhr/ekiszM1Tq3ES6QZFLsr2z0XIZkhcjJJCNQD6Gw4DRoT
	 FEX5o4RFDWyFw==
Date: Sun, 21 Jun 2026 15:32:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7915: guard HE capability lookups
Message-ID: <ajfoCXu94i-_4LOA@lore-desk>
References: <20260620155332.81120-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQHHFuPkC+H7QMe1"
Content-Disposition: inline
In-Reply-To: <20260620155332.81120-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37953-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 689536AAEC4


--QQHHFuPkC+H7QMe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt7915_mcu_bss_he_tlv() and mt7915_mcu_sta_bfer_tlv() both run after
> checking HE support, then dereference the HE PHY capability returned by
> mt76_connac_get_he_phy_cap(). That helper can return NULL when no
> capability entry matches the vif type.
>=20
> Fetch the capability before appending the TLV and skip the HE-specific
> setup when no matching capability is available.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities=
")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c    | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 318c38149463..391c91675130 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -595,6 +595,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct iee=
e80211_vif *vif,
>  	struct tlv *tlv;
> =20
>  	cap =3D mt76_connac_get_he_phy_cap(phy->mt76, vif);
> +	if (!cap)
> +		return;
> =20
>  	tlv =3D mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
> =20
> @@ -1177,13 +1179,12 @@ mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta=
, struct mt7915_phy *phy,
>  }
> =20
>  static void
> -mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *=
vif,
> -		       struct mt7915_phy *phy, struct sta_rec_bf *bf)
> +mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta,
> +		       const struct ieee80211_sta_he_cap *vc,
> +		       struct sta_rec_bf *bf)
>  {
>  	struct ieee80211_sta_he_cap *pc =3D &sta->deflink.he_cap;
>  	struct ieee80211_he_cap_elem *pe =3D &pc->he_cap_elem;
> -	const struct ieee80211_sta_he_cap *vc =3D
> -		mt76_connac_get_he_phy_cap(phy->mt76, vif);
>  	const struct ieee80211_he_cap_elem *ve =3D &vc->he_cap_elem;
>  	u16 mcs_map =3D le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
>  	u8 nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
> @@ -1242,6 +1243,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, str=
uct sk_buff *skb,
>  {
>  	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
>  	struct mt7915_phy *phy =3D mvif->phy;
> +	const struct ieee80211_sta_he_cap *vc =3D NULL;
>  	int tx_ant =3D hweight8(phy->mt76->chainmask) - 1;
>  	struct sta_rec_bf *bf;
>  	struct tlv *tlv;
> @@ -1260,6 +1262,12 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, st=
ruct sk_buff *skb,
>  	if (!ebf && !dev->ibf)
>  		return;
> =20
> +	if (sta->deflink.he_cap.has_he && ebf) {
> +		vc =3D mt76_connac_get_he_phy_cap(phy->mt76, vif);
> +		if (!vc)
> +			return;
> +	}
> +
>  	tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
>  	bf =3D (struct sta_rec_bf *)tlv;
> =20
> @@ -1268,7 +1276,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, str=
uct sk_buff *skb,
>  	 * ht: iBF only, since mac80211 lacks of eBF support
>  	 */
>  	if (sta->deflink.he_cap.has_he && ebf)
> -		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
> +		mt7915_mcu_sta_bfer_he(sta, vc, bf);
>  	else if (sta->deflink.vht_cap.vht_supported)
>  		mt7915_mcu_sta_bfer_vht(sta, phy, bf, ebf);
>  	else if (sta->deflink.ht_cap.ht_supported)

--QQHHFuPkC+H7QMe1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajfoCQAKCRA6cBh0uS2t
rP2dAQCCcm2BPjD0c1XzPXbhGdoVYFq+ietAOfW9Qkj7OjOtYwEApeG4XvEHCMwJ
Bv8nmWLaNHLR1z3GDHDMTb8/YiUnPA4=
=xV3H
-----END PGP SIGNATURE-----

--QQHHFuPkC+H7QMe1--

