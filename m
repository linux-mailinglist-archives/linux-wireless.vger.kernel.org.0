Return-Path: <linux-wireless+bounces-32105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +APrDolJnGmODAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:35:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A959B17626A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 518D73031034
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F13361654;
	Mon, 23 Feb 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PV7Td6dV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B23612F6
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850118; cv=none; b=lr1T17hwxrq9asPEWto66D0eGECkx9o5ZrjHtCRK552oFXOkzQedGttq9YBC4QYYP9wSJOH4XrAjBIxWI8cF8wnqwoUBNyNSO6+UiuLK/imQ2L6CQe43M2g/Dg2fRYEv0bh8DUruM+WGTiNnllYCW9cnW23R9De6l9Toqxst20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850118; c=relaxed/simple;
	bh=Qnk8C/vrQkoXjywzOWEuyxTF6uzITW2LQAoh9UC4PrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9UG0kkdBc/oGVfQRZYxG2CkkwihERe+Fu3XOrzSqMtRTQwHriHsRNaLfGwxeyBhzat1xKSXyA/4cEAan4x/0COwHNYhQiYIQZ9kVWXR5rDyfdFa7J5YJwkePlzbEhtfSbpAwrmYo5K5AMSZof5KC/WJ9DOtrKsv+pwV79w+qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PV7Td6dV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1FwDiNdb3wjxpaeb/x/w+8KiTSuu8OSbmuGmA7d5Wu8=;
	t=1771850117; x=1773059717; b=PV7Td6dVZ1WSuVtSTu6U0Ai9XiaW7IN5Z7qTiqit0STQ3qE
	/biEj4oEWZOuDfzavUzJxOFI2akHooQrlMHgKPGxvKagxVoWXW5K4G7gVkAwnyYHdOyCvoqJu476F
	9pEpOGPk9UWsHIdeKcXZTrGUsm6FbnQdXWstgyg9kZ8x+83W0XNIhREWZmdjWA182dXJDa0ZrEfU4
	7cf9v+xD1jtASz+isAd+HPePXNgq9B7wJuj6hGKQIm744rPvyO3TeWg+I8wsy1tBtx0ve47PbnC0/
	kl1tvCbMJNOgRTKm2lZWpVO7ggi4fL6N8Z0BEmFS+wviLseDPfDWIWAmyEADR9Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuV9e-0000000H2jj-07qj;
	Mon, 23 Feb 2026 13:35:14 +0100
Message-ID: <d68eaccb20f4339b7bde84f45c2720239cb03a26.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 4/8] wifi: mac80211: rework RX packet handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, Ramasamy
 Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 13:35:13 +0100
In-Reply-To: <66d57a5e-339b-40be-bad8-5348e70a6a35@oss.qualcomm.com>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
	 <20260220151929.9c68f68fca75.Ie12ec077142c6a7fdbb58cdfc5660497cc75150e@changeid>
	 <66d57a5e-339b-40be-bad8-5348e70a6a35@oss.qualcomm.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32105-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: A959B17626A
X-Rspamd-Action: no action

On Fri, 2026-02-20 at 10:19 -0800, Jeff Johnson wrote:
> On 2/20/2026 6:19 AM, Benjamin Berg wrote:
> > @@ -5292,92 +5284,102 @@ static void __ieee80211_rx_handle_packet(struc=
t ieee80211_hw *hw,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 ieee80211_is_s1g_beacon(hdr->frame_con=
trol)))
> > =C2=A0		ieee80211_scan_rx(local, skb);
> > =C2=A0
> > +	/*
> > +	 * RX of a data frame should only happen to existing stations.
> > +	 * It is therefore more efficient to use the one provided by the driv=
er
> > +	 * or search based on the station's address.
> > +	 *
> > +	 * Note we will fall through and handle a spurious data frame in the
>=20
> Note that checkpatch doesn't like the use of "fall through" in a comment =
since
> that term is usually associated with switch code where one case does some
> processing and then falls through to a subsequent case instead of having =
a
> break. Should we reword so that checkpatch doesn't complain?

I feel that "fall through" captures quite nicely what we do here and
there is really no need to change the wording just to make checkpatch
happy.

That said, I'll change the if/else that was also flagged.

Benjamin

> CHECK: Prefer 'fallthrough;' over fallthrough comment
> #5293: FILE: net/mac80211/rx.c:5293:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note we will fall through a=
nd handle a spurious data frame in the
>=20
>=20
> > +	 * same way as a management frame.
> > +	 */
> > =C2=A0	if (ieee80211_is_data(fc)) {
> > -		struct sta_info *sta, *prev_sta;
> > -
> > =C2=A0		if (link_pubsta) {
> > -			sta =3D container_of(link_pubsta->sta,
> > -					=C2=A0=C2=A0 struct sta_info, sta);
> > -			if (!ieee80211_rx_data_set_sta(&rx, sta,
> > -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link_pubsta->link_id))
> > -				goto out;
> > +			sta =3D container_of(link_pubsta->sta, struct sta_info,
> > +					=C2=A0=C2=A0 sta);
> > +			link_sta =3D rcu_dereference(sta->link[link_pubsta->link_id]);
> > =C2=A0
> > -			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
> > +			rx.sdata =3D sta->sdata;
> > +			if (ieee80211_rx_data_set_link_sta(&rx, link_sta) &&
> > +			=C2=A0=C2=A0=C2=A0 ieee80211_prepare_and_rx_handle(&rx, skb, true))
> > =C2=A0				return;
> > +
> > =C2=A0			goto out;
> > =C2=A0		}
> > =C2=A0
> > -		prev_sta =3D NULL;
> > +		rx_data_pending =3D false;
> > =C2=A0
> > +		/* Search for stations on non-MLD interfaces */
> > =C2=A0		for_each_sta_info(local, hdr->addr2, sta, tmp) {
> > -			int link_id;
> > +			struct ieee80211_link_data *link;
> > =C2=A0
> > -			if (!prev_sta) {
> > -				prev_sta =3D sta;
> > +			if (ieee80211_vif_is_mld(&sta->sdata->vif))
> > =C2=A0				continue;
> > -			}
> > -
> > -			rx.sdata =3D prev_sta->sdata;
> > -
> > -			/*
> > -			 * FIXME: This is not correct as the addr2 cannot be a
> > -			 * link address if the loop itself is iterated.
> > -			 */
> > -			if (prev_sta->sta.mlo) {
> > -				struct link_sta_info *link_sta;
> > =C2=A0
> > -				link_sta =3D link_sta_info_get_bss(rx.sdata,
> > -								 hdr->addr2);
> > -				if (!link_sta)
> > -					continue;
> > +			link =3D &sta->sdata->deflink;
> > +			if (!ieee80211_rx_valid_freq(status->freq, link))
> > +				continue;
> > =C2=A0
> > -				link_id =3D link_sta->link_id;
> > -			} else {
> > -				link_id =3D sta->deflink.link_id;
> > +			if (rx_data_pending) {
> > +				ieee80211_prepare_and_rx_handle(&rx, skb,
> > +								false);
> > +				rx_data_pending =3D false;
> > =C2=A0			}
> > =C2=A0
> > -			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
> > -				goto out;
> > -
> > -			ieee80211_prepare_and_rx_handle(&rx, skb, false);
> > +			rx.sdata =3D sta->sdata;
> > +			if (!ieee80211_rx_data_set_link_sta(&rx, &sta->deflink))
> > +				continue;
> > =C2=A0
> > -			prev_sta =3D sta;
> > +			rx_data_pending =3D true;
> > =C2=A0		}
> > =C2=A0
> > -		if (prev_sta) {
> > -			int link_id;
> > -
> > -			rx.sdata =3D prev_sta->sdata;
> > +		/* And search stations on MLD interfaces */
> > +		for_each_link_sta_info(local, hdr->addr2, link_sta, tmp) {
> > +			struct ieee80211_link_data *link;
> > =C2=A0
> > -			/*
> > -			 * FIXME: This is not correct as the addr2 cannot be a
> > -			 * link address if the loop itself is iterated.
> > -			 */
> > -			if (prev_sta->sta.mlo) {
> > -				struct link_sta_info *link_sta;
> > +			sta =3D link_sta->sta;
> > +			sdata =3D	sta->sdata;
> > +			link =3D rcu_dereference(sdata->link[link_sta->link_id]);
> > =C2=A0
> > -				link_sta =3D link_sta_info_get_bss(rx.sdata,
> > -								 hdr->addr2);
> > -				if (!link_sta)
> > -					goto out;
> > +			if (!ieee80211_rx_valid_freq(status->freq, link))
> > +				continue;
> > =C2=A0
> > -				link_id =3D link_sta->link_id;
> > -			} else {
> > -				link_id =3D sta->deflink.link_id;
> > +			if (rx_data_pending) {
> > +				ieee80211_prepare_and_rx_handle(&rx, skb,
> > +								false);
> > +				rx_data_pending =3D false;
> > =C2=A0			}
> > =C2=A0
> > -			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
> > -				goto out;
> > +			rx.sdata =3D sta->sdata;
> > +			if (!ieee80211_rx_data_set_link_sta(&rx, link_sta))
> > +				continue;
> > +
> > +			rx_data_pending =3D true;
> > +		}
> > =C2=A0
> > +		if (rx_data_pending) {
> > =C2=A0			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
> > =C2=A0				return;
> > -			goto out;
> > +			else
> > +				goto out;
>=20
> why change this?
> kernel convention is to avoid else after an if that ends in a change in f=
low.
>=20
> WARNING: else is not generally useful after a break or return
> #5363: FILE: net/mac80211/rx.c:5363:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>=20
> > =C2=A0		}
> > +
> > +		/* fall through, e.g. for spurious frame notification */
>=20
> here again
>=20
> CHECK: Prefer 'fallthrough;' over fallthrough comment
> #5367: FILE: net/mac80211/rx.c:5367:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* fall through, e.g. for spurious frame notification */
>=20
> > =C2=A0	}
> > =C2=A0
> > -	prev =3D NULL;
> > +	/*
> > +	 * This is a management frame (or a data frame without a station) and
> > +	 * it will be delivered independent of whether a station exists,
> > +	 * so iterate the interfaces.
> > +	 */
> > +	rx_data_pending =3D false;
> > +
> > +	/* We expect the driver to provide frequency information */
> > +	if (WARN_ON_ONCE(!local->emulate_chanctx && !status->freq))
> > +		goto out;
> > =C2=A0
> > =C2=A0	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> > +		struct ieee80211_link_data *link =3D NULL;
> > +
> > =C2=A0		if (!ieee80211_sdata_running(sdata))
> > =C2=A0			continue;
> > =C2=A0

