Return-Path: <linux-wireless+bounces-25855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95283B0D97C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B81547BBA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F072E1C61;
	Tue, 22 Jul 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kTNHUfSm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622C2E3B1E;
	Tue, 22 Jul 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186979; cv=none; b=sLaUFQJZDDxykfojFornbcH2pI5i35z8hfZ6UfUIpx29b5nJ3/io/UyJTrSuib1zQitqupSB4rkh8dcU5k4N4PC9e4IA5G3dLSKpanOnJP6sbZAYiGtJjAF2oBQ+9HC2pUqUOG+HfJFJFY2usIyJN7/tjl5nsnN3fRnIOO7JL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186979; c=relaxed/simple;
	bh=keCgDURcv9+m6vpU6rHa61mzyeJqReGQO4z/vF4svIQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZGRryfWuF7wTxNYAaHxaQz+QsZEzUkm/KJfUFMkztZ4iID3oH2uN8o+kAMzaQKraTg7xmz++w1maz0RZg/omxsgWSc2GPEzHHBrRa2i+mdfk3WDv21mlH+w7wqiMEDaNmK8lht1HfOXV+zS/OmlggwY9Y3ceYlT23bJRCu3Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kTNHUfSm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KnwXTqtHOleKG0B9HcgxxzHBfNasjXdXwWf+q1NedP4=;
	t=1753186978; x=1754396578; b=kTNHUfSmas1DAkQMW1SlSFKjYA93+g7DH9LwVLJYi+pA/aE
	LfKDhmm/58gv3v9hNGJqLwnilPtCHRFNcvvD+FP8lbVVww8dlyVgMTC6quGpMP2WbhyKGOFqBen0h
	cH8xmSxXTHH4pNZuRfL2Y0Fcn1ECB1tGYx6DIKGa3M440mcsuDVSRxa/D4ALC7XVxbWIt8mTli+1O
	gfOOUwX4lTcbSqche/EIJQQOK8iqt1yuQ/WldMw+ysGouHoKh87kEzPcIf5BFwthJ5MyYYaHhPbHt
	Ut635lSC9KM9EBWJNlmyOoX1YKl5+LQezmL31I2k4SMKg7GVJlxqAbr+VnIuJgSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueC1H-000000026Pp-1C60;
	Tue, 22 Jul 2025 14:22:55 +0200
Message-ID: <d59c69a46c36db6fb6616b4c2ba9847cccd29e5d.camel@sipsolutions.net>
Subject: Re: [RFC PACTH v2 wireless-next 1/3] wifi: mac80211: Get link_id
 from freq for received management frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 14:22:54 +0200
In-Reply-To: <dd0eb517cf088f386b00c138563bda3c778ebe41.1752225123.git.repk@triplefau.lt>
References: <cover.1752225123.git.repk@triplefau.lt>
	 <dd0eb517cf088f386b00c138563bda3c778ebe41.1752225123.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-07-11 at 12:03 +0200, Remi Pommarel wrote:
>=20
> +static int ieee80211_rx_get_link_from_freq(struct ieee80211_rx_data *rx,
> +					   struct sk_buff *skb,
> +					   struct link_sta_info *link_sta)
> +{
> +	struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
> +	struct ieee80211_sta *sta =3D &link_sta->sta->sta;
> +	struct ieee80211_link_data *link;
> +	struct ieee80211_bss_conf *bss_conf;
> +	struct ieee80211_chanctx_conf *conf;
> +
> +	if (!status->freq)
> +		return link_sta->link_id;
> +
> +	for_each_link_data(rx->sdata, link) {


..._rcu()

> +		bss_conf =3D link->conf;
> +		if (!bss_conf)
> +			continue;
> +		conf =3D rcu_dereference(bss_conf->chanctx_conf);
> +		if (!conf || !conf->def.chan)
> +			continue;
> +
> +		if (conf->def.chan->center_freq !=3D status->freq)
> +			continue;
> +
> +		if (ieee80211_rx_is_valid_sta_link_id(sta, link->link_id))
> +			return link->link_id;
> +	}

But this is now almost the same as the code added via
https://patch.msgid.link/20250721062929.1662700-1-michael-cy.lee@mediatek.c=
om
so I think it should be refactored/combined.

> @@ -5131,7 +5162,15 @@ static bool ieee80211_rx_for_interface(struct ieee=
80211_rx_data *rx,
>  	link_sta =3D link_sta_info_get_bss(rx->sdata, hdr->addr2);
>  	if (link_sta) {
>  		sta =3D link_sta->sta;
> -		link_id =3D link_sta->link_id;
> +
> +		/* Use freq to get link id information on management frames to
> +		 * allow for offchannel scan, roaming, etc.
> +		 */
> +		if (ieee80211_is_mgmt(hdr->frame_control))
> +			link_id =3D ieee80211_rx_get_link_from_freq(rx, skb,
> +								  link_sta);

It seems to me taht _iff_ the link ID ends up not being link_sta-
>link_id here, we should set link_sta=3DNULL. Otherwise we think we're
actually receiving from that STA but we aren't really, and if we then
use sta->link[link_id] we'd crash, and I'd be very surprised if this
were impossible.

I'm not sure what consequences that has, but OTOH it really should not
be sending anything other than probe requests, authentication frames and
some few public action frames on another link. We need not handle other
frames as if we didn't realise the link was different, it's fine to even
just drop them because we don't recognise the STA there.

So I think that's what we should do. As written this seems really
problematic to have a link_sta !=3D NULL and thus sta !=3D NULL but then
sta->link[link_id] =3D=3D NULL and not =3D=3D link_sta.


Arguably, given the code we already have, we should perhaps implement
this in another way and after doing the link_sta lookup via
link_sta_info_get_bss() simply reject the link_sta (set it to NULL) if
the RX link doesn't match the link it's expected to be on. Then we'd
fall back to the existing code I linked to above anyway, which seems
almost better.

johannes

