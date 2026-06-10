Return-Path: <linux-wireless+bounces-37618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XumEH/AKKWr9PAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:57:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9C6666D3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=NBOBELF5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37618-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37618-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDB453007A73
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC42372EE4;
	Wed, 10 Jun 2026 06:57:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9A381B1A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:57:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074627; cv=none; b=PTghMqjJe+UKNEo0QvAtCd9HD0bLmEmZzXKa/2v2j4SSnD9yGebQb3d141JMsBXQ3vUnThao7+y/XnCPlcMaRtgzvke0kjnpmCD++KP2na+suXETd+LNzt22QIo0VODpN0TEI/1DdY/GFVY6SHHx5E7iJ4sM45+TkelN9kQwUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074627; c=relaxed/simple;
	bh=fWcOktgtfx0Q6J9zIlW9lU4wqKS+pLkWZjLqP89SVl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOZocxpI/SMfeO/aHwJdHjIoL100FmD2NqMr/eLKKxd/2GKqloInmub2yCJSU3oermwvj2dly/VD7k86rnI0J92MmesdYAuzKGWhMPQb5uPYNRm1PYIHBTi9/3mFHlej+vcX5TYIgZrrQxvrhjNdKIIZjYveF1sErcBVYiysOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NBOBELF5; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lo/kPl89bGnaK+ygbCPc9TBqqkVvMbYexDfaYLPmadg=;
	t=1781074625; x=1782284225; b=NBOBELF5NPbfkF6z8T1n/OJ+gyAz1tNn1CwYbtOsa5AWwCw
	GMi+y6qPmvb1J1tIGLJQ/EJnq7tLLzFb9UXCSr6NCfAM1BqSI0S+FN+Oib+nLmqhTTw9c2Qb9ImuM
	B9hydAJGIiI7QDVcq8Xy947n4a7/i8f3K7Ga+7YS0BNoLeBNDmaPNJPiksdY3mljNb1v/QrnGZ1dj
	Waf4MBFnfp81X/ehXaVPGTMNezw25b5LCml4SMFEfL31GSvURepbjRVQHX6Q4IDFk42HDH+Oa/A0t
	wEeEIPit1/B7zDdU6vNrJj27kQXWof/va+KQWjWH7wGo/26iIOuJdbNfmTjuKsmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXCs1-00000007mvD-42bR;
	Wed, 10 Jun 2026 08:57:02 +0200
Message-ID: <f2c173f969bb3fd8685fcff9636f7aa6fa078a7f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 3/4] wifi: mac80211: implement STA-mode
 peer probing
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com, 
	veerendranath.jakkam@oss.qualcomm.com
Date: Wed, 10 Jun 2026 08:57:01 +0200
In-Reply-To: <20260608090727.2389161-4-pritiwa@qti.qualcomm.com>
References: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
	 <20260608090727.2389161-4-pritiwa@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:priyansha.tiwari@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37618-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91C9C6666D3

Hi,

> +	const u8 *peer_addr;

That seems vaguely confusing when we already have "peer", maybe you
should call this dst_addr to go with src_addr.

>  	/* the lock is needed to assign the cookie later */
>  	lockdep_assert_wiphy(local->hw.wiphy);
> =20
> -	rcu_read_lock();
> -	sta =3D sta_info_get_bss(sdata, peer);
> -	if (!sta) {
> -		ret =3D -ENOLINK;
> -		goto unlock;
> -	}
> -
> -	qos =3D sta->sta.wme;
> -
> -	if (ieee80211_vif_is_mld(&sdata->vif)) {
> -		if (sta->sta.mlo) {
> -			link_id =3D IEEE80211_LINK_UNSPECIFIED;
> -		} else {
> -			/*
> -			 * For non-MLO clients connected to an AP MLD, band
> -			 * information is not used; instead, sta->deflink is
> -			 * used to send packets.
> -			 */
> -			link_id =3D sta->deflink.link_id;
> +	switch (sdata->vif.type) {
> +	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_P2P_GO:
> +		sta =3D sta_info_get_bss(sdata, peer);
> +		if (!sta)
> +			return -ENOLINK;

I don't really understand why you move a bunch of the per-STA handling
into the switch?

> +		qos =3D sta->sta.wme;

This is definitely in all the branches, and must be there. Why not pull
it out?

> +		fromds =3D true;
> +		break;
> +
> +	case NL80211_IFTYPE_STATION:

(nit: spurious blank line)

> +	case NL80211_IFTYPE_P2P_CLIENT:

Both of the P2P cases aren't needed here and are just confusing.

> +		link_id =3D IEEE80211_LINK_UNSPECIFIED;
> +		peer_addr =3D sdata->vif.cfg.ap_addr;
> +		src_addr =3D sdata->vif.addr;
> +		if (!ieee80211_vif_is_mld(&sdata->vif)) {
> +			chanctx_conf =3D wiphy_dereference(local->hw.wiphy,
> +							 sdata->vif.bss_conf.chanctx_conf);
> +			if (WARN_ON(!chanctx_conf))
> +				return -EINVAL;

(that WARN_ON could perhaps be triggered since you didn't check for the
STA first?)

> +			band =3D chanctx_conf->def.chan->band;
> +		} else {
> +			band =3D 0;
>  		}
> -		band =3D chanctx_conf->def.chan->band;
> -		link_id =3D 0;
> +		sta =3D sta_info_get(sdata, peer_addr);
> +		if (!sta)
> +			return -ENOLINK;
> +		qos =3D sta->sta.wme;

At the very least you could pull out 'qos =3D sta->sta.wme', but I wonder
if you could pull out more of the sta lookup too by just saying

	if (vif.type =3D=3D NL80211_IFTYPE_STATION)
		peer =3D sdata->vif.cfg.ap_addr;

and then leaving more of the current behaviour intact. Even the MLO link
thing could be left since it won't actually be able to be used since the
AP will be MLO/non-MLO with the vif, unlike in AP mode.

IOW, it feels like with that you should get away with far less
difference between AP and client, perhaps no other than this and the DS
bits.

johannes

