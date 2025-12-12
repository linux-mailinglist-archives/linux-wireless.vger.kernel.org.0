Return-Path: <linux-wireless+bounces-29717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B0CB8D20
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9948030125C8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B9322B93;
	Fri, 12 Dec 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eSmnm5GP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B83242A3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543461; cv=none; b=Fnm4zNsDnpSA4KomZLrWGptEIrRYUHjOLmTavJ6h7l6uhvJzIfi9WzZy3gWtipiAVDcFMcBltcp1JY6+9RkExZHMfAihlYV6t8pazeEXl2492tXVrQGeI+lijPGnKfpDc2WwKIjklddjj/J0VeonyKhnlsWD22w3AKU9ExdDqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543461; c=relaxed/simple;
	bh=nQah31ZEoLuZ63IB4qh3nB8nyHHNWv3YuSGYSQZoJNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUlN2VcexULk3aApVqRIZh4jMyE55/IvmhCHn8B99sfwiVlWnd0mMdtuTxV92hcGeMDft9g74CC0hImXmW/UiRNjXDvTvrcIhyge2lpEv4cQfmABQYwSAxco0SZBMeftSpQF0CMqjCXqh5481MdtP/tP5MmaeO6D1keX37LfCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eSmnm5GP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KSj9a0s2TaSxCv+ls4zj3kvDkfHHIuAjkxlJSvTMZKY=;
	t=1765543460; x=1766753060; b=eSmnm5GPs+qmBSWwF7a82RI61UfHVBtoP++hTbqmmDFvaui
	C2MyDIAQtC199CIoPkZC7zIzUXAD4ksUtPl03Gr5SqkNMuF9mSJCm1Ea3BH3ypgyoMofRsG/Ovfb/
	gOqexVN5Cp7cd2Q+8z/oTxyVX3Cs2w+bCPrDEztiPRrF20Gl4AwtPb0v+QLmn83lJaNPJ1j+gvPUT
	BvsIwFzk8BsPJRtIyvbw23YXVvlPtPVhxVHTRuIM7UaG7GJw6HUSt0eVYsRwW2/XcdNZsTtZq5X4b
	AR9tmG5JIb0BYDS0MVYFHaFy/6W0xw4fr+MmxLHU4agaWDPhDZS4J6yPN1AnCHTQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2VM-00000003UbQ-2G0A;
	Fri, 12 Dec 2025 13:44:16 +0100
Message-ID: <6234932474d27f27924e5ee8527f717af3d390e4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 10/14] wifi: mac80211: add support for
 encryption/decryption of (Re)Association frames in non-AP STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:44:15 +0100
In-Reply-To: <20251211124051.3094878-11-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-11-kavita.kavita@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>=20
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2397,6 +2397,26 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_=
sub_if_data *sdata,
>  				 struct sk_buff *skb, int tid, int link_id,
>  				 enum nl80211_band band);
> =20
> +static inline bool ieee80211_epp_assoc_resp(__le16 fc, struct sta_info *=
sta)
> +{
> +	return sta && sta->sta.epp_peer && ieee80211_is_assoc_resp(fc);
> +}
> +
> +static inline bool ieee80211_epp_assoc_req(__le16 fc, struct sta_info *s=
ta)
> +{
> +	return sta && sta->sta.epp_peer && ieee80211_is_assoc_req(fc);
> +}
> +
> +static inline bool ieee80211_epp_reassoc_resp(__le16 fc, struct sta_info=
 *sta)
> +{
> +	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_resp(fc);
> +}
> +
> +static inline bool ieee80211_epp_reassoc_req(__le16 fc, struct sta_info =
*sta)
> +{
> +	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_req(fc);
> +}

I think these names ought to be improved, from just the name I'd never
guess that the implementation should be that.

> +	if (!is_zero_ether_addr(sdata->vif.cfg.ap_addr)) {

What? Is that checking something that's never the case (zero address),
trying to handle some kind of re-assoc situation in a bad way, or
something else that nobody will ever understand? :)

> @@ -8965,6 +8977,10 @@ static int ieee80211_prep_connection(struct ieee80=
211_sub_if_data *sdata,
>  			goto out_err;
>  		}
> =20
> +		if (ifmgd->auth_data &&
> +		    ifmgd->auth_data->algorithm =3D=3D WLAN_AUTH_EPPKE)
> +			new_sta->sta.epp_peer =3D true;


And you _do_ even set this, so you don't need the whole patch 5 vs. 12
difference?

> +	/*
> +	 * Drop unprotected (Re)Association Response frame received from
> +	 * an EPP Peer.
> +	 */
> +	if (!ieee80211_has_protected(fc) &&
> +	    (ieee80211_epp_assoc_resp(fc, rx->sta) ||
> +	     ieee80211_epp_reassoc_resp(fc, rx->sta)))
> +		return RX_DROP_U_UNPROT_UCAST_MGMT;

Even the use of them is rather non-obvious.

I'm not convinced the individual ones add much at all really, might be
better to just add a single ieee80211_require_encrypted_assoc() function
that checks the station and all four frame types? Eventually you add all
four here and in all other places anyway (patch 13.)

johannes

