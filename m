Return-Path: <linux-wireless+bounces-30353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654BCF2F50
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 11:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190AA300C298
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04AE2F60A7;
	Mon,  5 Jan 2026 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OGXWFs+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150252F25EF
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608453; cv=none; b=QGff4S+1EUlZ1MHmGEm3ugrB4O2ngLNU6M2vCDz2lgVXWfuxvRmZxz5j2ydW5HyJJ3koyn/xF6irz8FKQCHXFcO35QO0Lbb6aavezObMU0j70pqRg3/XDd18zoPocLPyBEl63PjtyZpLMPjxbQN71mnD6zJELWpj0uSA8Ttcz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608453; c=relaxed/simple;
	bh=Unfr97mdFpvC/4otDDrSpEXYU/9sIy236FWV41r5M2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9IfXzGeVEy3jV/9CAwS+mm4AgETiAcmLWF4UuSCxlDf3dKfcSq/p4EIrETMTXpFdiUNnyzT5AdR/EjbJFiGSOm7J23EmWUEfq1x1l/fZA37xIotx0WAx87Ryb7cP+FyWkigGE5rYi9WybdsxoWWMxkA7cElvIVcmh5nhvYaqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OGXWFs+e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iLHCM/8ZjIiRZ6ZHylzxwMEr7FEPFYHPjvxBD7+PbU4=;
	t=1767608452; x=1768818052; b=OGXWFs+eLIZTCFV4iPYOGHoR+rOrE90wNohHh1WR/E38T6G
	1ZURIiAmc5H6h1tmfFdTTsNit6E9xq7FrzG+t77Tr2ZWUzMqfrFcTm5TXyQlUhupGTHb5dE6Xd3MY
	QuYZpOewzrZ848goRzXIlHOBOuXFwMsN8aTEDNrfDD0wf0JJNJdm3KfmkrGrmdeLSpyqUq9ZXkmX2
	+/ErqnX/0AICH17T+4fUutB1H3zdlV2fwFOW42LzxW/G4Nib3wdIFy5oeBoU0g6EQzL41M/7F7fcQ
	6wBNtqfssZ4TaymEyfzNKuvazOdGeXbEMBBpJqoDxdVjlB+l5L9h/88kuStYykJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vchhg-00000003m0d-0ZyG;
	Mon, 05 Jan 2026 11:20:48 +0100
Message-ID: <2619e585674f89527f26bb83f2d04064a25fcfa1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 8/9] wifi: mac80211: add support for
 encryption/decryption of (Re)Association frames
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Mon, 05 Jan 2026 11:20:46 +0100
In-Reply-To: <20260105072415.3472165-9-kavita.kavita@oss.qualcomm.com> (sfid-20260105_082528_746983_927CC772)
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
	 <20260105072415.3472165-9-kavita.kavita@oss.qualcomm.com>
	 (sfid-20260105_082528_746983_927CC772)
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

On Mon, 2026-01-05 at 12:54 +0530, Kavita Kavita wrote:
> Currently, mac80211 does not encrypt or decrypt (Re)Association frames
> (Request and Response) because temporal keys are not yet available at
> that stage.
>=20
> With extensions from IEEE P802.11bi, e.g. EPPKE, temporal keys can be
> established before association. This enables the encryption and
> decryption of (Re)Association Request/Response frames.
>=20
> Add support to unset the IEEE80211_TX_INTFL_DONT_ENCRYPT flag when
> the peer is marked as an Enhanced Privacy Protection (EPP) peer and
> encryption keys are available for the connection in non-AP STA mode,
> allowing secure transmission of (Re)Association Request frames.
>=20
> Dropn unprotected (Re)Association Request/Response frames received from

nit:  ^ typo

> +static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
> +						     struct sta_info *sta)
> +{
> +	return (sta && sta->sta.epp_peer &&
> +		(ieee80211_is_assoc_req(fc) || ieee80211_is_reassoc_req(fc) ||
> +		 ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc)));
> +}

That seems much better. Maybe it should be in sta_info.h instead?
Doesn't really matter much though.

> +	bool assoc_encrypt =3D false;
> +	struct sta_info *sta;
>  	void *capab_pos;
>  	size_t size;
>  	int ret;
> @@ -2335,7 +2337,16 @@ static int ieee80211_send_assoc(struct ieee80211_s=
ub_if_data *sdata)
>  	info.link_id =3D assoc_data->assoc_link_id;
>  	drv_mgd_prepare_tx(local, sdata, &info);
> =20
> -	IEEE80211_SKB_CB(skb)->flags |=3D IEEE80211_TX_INTFL_DONT_ENCRYPT;
> +	sta =3D sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
> +
> +	if (sta && sta->sta.epp_peer &&
> +	    wiphy_dereference(sdata->local->hw.wiphy, sta->ptk[sta->ptk_idx])) =
{
> +		assoc_encrypt =3D true;
> +	}

don't need braces, but really also maybe better to just assign it
completely here remove the " =3D false" above:

	assoc_encrypt =3D sta && sta->sta.epp_peer &&
			wiphy_dereference(...);


> +
> +	if (!assoc_encrypt)
> +		IEEE80211_SKB_CB(skb)->flags |=3D IEEE80211_TX_INTFL_DONT_ENCRYPT;
> +
>  	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
>  		IEEE80211_SKB_CB(skb)->flags |=3D IEEE80211_TX_CTL_REQ_TX_STATUS |
>  						IEEE80211_TX_INTFL_MLME_CONN_TX;
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index e0ccd9749853..3fd5885c7f69 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -2609,6 +2609,14 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_r=
x_data *rx)
>  	    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC)))
>  		return RX_DROP_U_UNPROT_ROBUST_ACTION;
> =20
> +	/*
> +	 * Drop unprotected (Re)Association Request/Response frame received fro=
m
> +	 * an EPP Peer.
> +	 */
> +	if (!ieee80211_has_protected(fc) &&
> +	     ieee80211_require_encrypted_assoc(fc, rx->sta))

nit: indentation off by a space

johannes

