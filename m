Return-Path: <linux-wireless+bounces-37667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y431ElylKmpCuQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:09:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0C671AD8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=HiJ36jWV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37667-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37667-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 734733074EFC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563923D5226;
	Thu, 11 Jun 2026 12:03:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129A3C3440;
	Thu, 11 Jun 2026 12:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179395; cv=none; b=VP9w7/vrjlB6p/yWupIjfaHVO+21pJciM1BTEhh3UxlNUNqvHFwM9EyLU4H0bM8PauijtEo5977tMvRJl339GrbTtkOc+SOc4qXUf0vDErTzfb6lmjKBD12p7RTBgDsKRk1LvkmrLZg/Rme2YxmwgvroT0eS/oSriwKN36Jsmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179395; c=relaxed/simple;
	bh=/fUpixw+/gkwEfyiVOnxj2mfAUO/8ScqgNcaMofLPJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhXyXm0jHEwzMPHnFbXRR9b5tL3TuuS0gYkkrAMNfXDFRi1pBbGrZeRyMYE8BEP/lK87qE0EiH1WOITyJoU68OYIPMOviXCZ3XKv50W6JmYCBZkVMLNaxr/DPc5b2agfI4dVtHHJ81j47R1BEdIekjCSvSgIvmJMqTslYduFkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HiJ36jWV; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h9MY53Lx0odhbNmI7hrmapkJ6J6ieLYo16xN5ivxFd0=;
	t=1781179393; x=1782388993; b=HiJ36jWVL9vbmcsEzS5CGg7u5rVcdcxl8heQTYx/qQN6MLS
	uqsJjvnAIOGVN5XSqAR8p0OorAoya3GM5GPyhjEjZGWzHl3Lnw9QG2UV27mx4y5Qt/Q8YZV7/32mU
	TxawfFyKycCdJWWr7EiOa36if/t7IiY8h1cUcEV4NGyd8wYtVEf7D9hkEV9VXl/1iKZMFXaOiG8cj
	/ZthIxTRlttnp4sUOFoYDi2T9ccv1UIwxIbRLSpbt8DJApm131QkpPp0ZGzQRoXvceLuFtgC7xFIj
	1+0uVS1E2ZGqgXKtytjhHY5ESi2HkxwRUIx2hxvMrzERv38U2GHd3+Lt2kluPOYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXe7j-00000008zDV-3g96;
	Thu, 11 Jun 2026 14:03:04 +0200
Message-ID: <2dbb5e703e5d7fa787c9f0debcedb3dc73c1643d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: validate S1G beacon length before RX
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Thomas Pedersen <thomas@adapt-ip.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jun 2026 14:03:03 +0200
In-Reply-To: <20260610162700.58722-1-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37667-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1D0C671AD8

On Thu, 2026-06-11 at 00:27 +0800, Zhao Li wrote:
> S1G beacons are extension frames, so ieee80211_hdrlen() only guarantees
> the extension header before the generic RX path starts dispatching the
> frame.
>=20
> The RX path can then reach helpers and interface handling code that read
> regular 802.11 header address fields, which are not present at those
> offsets in an S1G beacon.
>=20
> Pull the complete S1G beacon fixed header, including optional fixed
> fields indicated by frame control, before generic RX dispatch.
>=20
> Also make ieee80211_get_bssid() length-safe for S1G beacons and avoid
> regular-header address reads for S1G frames in accept/interface/MLO
> address handling. Skip extension frames in duplicate detection for the
> same reason, since that path consumes the regular sequence-control field.

This is all true, but all of the below seems far too complicated a fix?

Also seems like you should probably disclose some LLM usage, unless
you're going to tell me you wrote all this code yourself?


> @@ -4487,12 +4490,17 @@ static bool ieee80211_accept_frame(struct ieee802=
11_rx_data *rx)
>  	struct ieee80211_hdr *hdr =3D (void *)skb->data;
>  	struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
>  	u8 *bssid =3D ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
> -	bool multicast =3D is_multicast_ether_addr(hdr->addr1) ||
> -			 ieee80211_is_s1g_beacon(hdr->frame_control);
> +	bool s1g =3D ieee80211_is_s1g_beacon(hdr->frame_control);
> +	bool multicast;
>  	static const u8 nan_network_id[ETH_ALEN] __aligned(2) =3D {
>  		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
>  	};
> =20
> +	if (s1g)

no need to introduce the 's1g' variable, and it sounds weird anyway
because s1g uses other frames too, not just beacons

> @@ -5175,11 +5183,13 @@ static bool ieee80211_prepare_and_rx_handle(struc=
t ieee80211_rx_data *rx,
>  	}
> =20
>  	/* Store a copy of the pre-translated link addresses for SW crypto */
> -	if (unlikely(is_unicast_ether_addr(hdr->addr1) &&
> +	if (unlikely(!ieee80211_is_s1g_beacon(hdr->frame_control) &&
> +		     is_unicast_ether_addr(hdr->addr1) &&
>  		     !ieee80211_is_data(hdr->frame_control)))
>  		memcpy(rx->link_addrs, &hdr->addrs, 3 * ETH_ALEN);
> =20
>  	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
> +	    !ieee80211_is_s1g_beacon(hdr->frame_control) &&
>  	    is_unicast_ether_addr(hdr->addr1) &&
>  	    !ieee80211_is_probe_resp(hdr->frame_control) &&
>  	    !ieee80211_is_beacon(hdr->frame_control)) {

This seems very ... specific, and doing the same thing twice also seems
odd. While not great, I'd probably advocate for a goto or just doing the
invoke() separately for s1g beacons.

> @@ -5260,23 +5270,30 @@ static bool ieee80211_rx_for_interface(struct iee=
e80211_rx_data *rx,
>  {
>  	struct link_sta_info *link_sta;
>  	struct ieee80211_hdr *hdr =3D (void *)skb->data;
> +	u8 *sta_addr =3D hdr->addr2;
>  	struct sta_info *sta;
>  	int link_id =3D -1;
> =20
> +	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
> +		sta_addr =3D ieee80211_get_bssid(hdr, skb->len, rx->sdata->vif.type);
> +		if (!sta_addr)
> +			return false;
> +	}

That one seems even weirder - especially in the face of your *other*
changes that attempt to never access hdr-> without making sure it's
actually the right format ... you still create a pointer to addr2 here.
It's valid since you never use it, but it's also weird because it pretty
much looks like hdr->addr2 _is_ OK at the whole function level.

> +
>  	/*
>  	 * Look up link station first, in case there's a
>  	 * chance that they might have a link address that
>  	 * is identical to the MLD address, that way we'll
>  	 * have the link information if needed.
>  	 */
> -	link_sta =3D link_sta_info_get_bss(rx->sdata, hdr->addr2);
> +	link_sta =3D link_sta_info_get_bss(rx->sdata, sta_addr);

Obviously, if things work today, we didn't really need the link_sta for
these frames, and that makes some sense since there's no MLO and it's
just ieee80211_rx_mgmt_beacon() basically. Probably better to just skip
this entirely and handle s1g beacons separately.

>  	if (link_sta) {
>  		sta =3D link_sta->sta;
>  		link_id =3D link_sta->link_id;
>  	} else {
>  		struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
> =20
> -		sta =3D sta_info_get_bss(rx->sdata, hdr->addr2);
> +		sta =3D sta_info_get_bss(rx->sdata, sta_addr);
>  		if (status->link_valid) {
>  			link_id =3D status->link_id;
>  		} else if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
> @@ -5347,6 +5364,12 @@ static void __ieee80211_rx_handle_packet(struct ie=
ee80211_hw *hw,
>  		return;
>  	}
> =20
> +	if (ieee80211_is_s1g_beacon(fc) &&
> +	    !pskb_may_pull(skb, ieee80211_s1g_beacon_min_len(fc))) {
> +		dev_kfree_skb(skb);
> +		return;
> +	}

I'm fairly certain this still leaves things (e.g.
ieee80211_rx_mgmt_beacon()) wrong if the driver ever reports an s1g
beacon as a frag skb.

I think much better to just treat this frame=C2=A0like mgmt frames and
linearize it earlier in the function along with mgmt frames etc. Still
need to check the length, but we could even do that there as well,
rather than this late.

johannes

