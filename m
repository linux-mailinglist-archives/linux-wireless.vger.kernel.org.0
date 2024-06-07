Return-Path: <linux-wireless+bounces-8675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98178FFFCB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D38280ED0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57615B148;
	Fri,  7 Jun 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lve8Q8qb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45313790B
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753454; cv=none; b=eMwbm2A7opF/xQ1goeyS+RWSMczRZ9ffKJJJYd40WvYgkFjXyinDPP+cn8rNNCQyVY4xeguhvHf3IBq6N6ieRiNErc93w1PEmE4m5/DrL28lS1vIj9VqRI1TJuhRVeIbM0GCQd7RB+9ereiR3L54zArlVg7MsYbir3NStBi4FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753454; c=relaxed/simple;
	bh=KHqR4Rlz35mAzkLFXXQk1FaNZcIMC6pwUUq9kYrvFpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6tQhF7zlfBoMLdcX+ywvdbg9XqQtR4MK7Hl+qERzdFxIAxrB+X+cBZdNbQn6ZQPVktZNjQ55je98H3PTCxDBjpxiVmiuWcGl+8nf37Erto+qDqEAl4rc1INvwg/iXo9gdrZncB7ycVHpUGSCtiHyFXkhSPad+5BbwaG2zg2CoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lve8Q8qb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JcyM4J3i8eT5X37rRw9HSt3/1V0+wkACsp31JSdtjMI=;
	t=1717753448; x=1718963048; b=lve8Q8qbrX8S/KgMQLX+9OUkD6TU6Z62e/VNLYen6ZqMHch
	4Qib3iotYzX4th1i7fh1bIE4T2IC7lpBZ7tpS5eWXXYrAvgIq02RwiYFNIdfgOM1hPzgfZidbUkIT
	6/GvYJzZmHNI6OOk2wm1pDCmdAm3aozMpPyv4Rtp+TK3QDYzMYl4KaNdODm7+vQvb4zdn0KmSinFk
	Qp+tVrPSg0UwNvEB0MVAkG9qyAQiZJrN9dZEoPZOzuvxnftWgOoOA/Ro+gGAhmkkgxwW73vdIEdcw
	3kAjEZwADVkruKX6tL1w80hi5ngndGbT/pRQGxG/fgeofU+sCcTTf+ZP9PU4MEuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFW8e-00000000swZ-3Eyx;
	Fri, 07 Jun 2024 11:44:00 +0200
Message-ID: <a1cff51f789c21b2b307c58ee4d743a62874cec6.camel@sipsolutions.net>
Subject: Re: [RFC v3 8/8] wifi: mac80211: add wiphy radio assignment and
 validation
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 07 Jun 2024 11:44:00 +0200
In-Reply-To: <9b331a61b8d53284b044bc594cf9952c60164e5f.1717696995.git-series.nbd@nbd.name>
References: 
	<cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
	 <9b331a61b8d53284b044bc594cf9952c60164e5f.1717696995.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:
>=20
> +static bool
> +ieee80211_radio_freq_match(const struct wiphy_radio *radio,
> +			   const struct ieee80211_chan_req *chanreq)
> +{
> +	const struct wiphy_radio_freq_range *r;
> +	u32 freq;
> +	int i;
> +
> +	freq =3D ieee80211_channel_to_khz(chanreq->oper.chan);
> +	for (i =3D 0; i < radio->n_freq_range; i++) {
> +		r =3D &radio->freq_range[i];
> +		if (freq >=3D r->start_freq && freq <=3D r->end_freq)
> +			return true;

IMHO should be inclusive only on one side of the range. Can always make
it work since channels are at least a few MHz apart, but the purist in
me says it's easier to grok if the end is not inclusive :)

Maybe this should be a cfg80211 helper like

struct wiphy_radio *wiphy_get_radio(struct wiphy *wiphy, ... *chandef);

which could also check that the _whole_ chandef fits (though that should
probably also be handled elsewhere, like chandef_valid), and you can use
it to get the radio pointer and then check for =3D=3D below.

The point would be to have a single place with this kind of range logic.
This is only going to get done by mac80211 now, but it'd really be
awkward if some other driver had some other logic later.

>  	if (!curr_ctx || (curr_ctx->replace_state =3D=3D
>  			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
> @@ -1096,6 +1117,12 @@ ieee80211_replace_chanctx(struct ieee80211_local *=
local,
>  			if (!list_empty(&ctx->reserved_links))
>  				continue;
> =20
> +			if (ctx->conf.radio_idx >=3D 0) {
> +					radio =3D &wiphy->radio[ctx->conf.radio_idx];
> +					if (!ieee80211_radio_freq_match(radio, chanreq))
> +							continue;
> +			}

something happened to indentation here :)

> +static bool
> +ieee80211_find_available_radio(struct ieee80211_local *local,
> +			       const struct ieee80211_chan_req *chanreq,
> +			       int *radio_idx)
> +{
> +	struct wiphy *wiphy =3D local->hw.wiphy;
> +	const struct wiphy_radio *radio;
> +	int i;
> +
> +	*radio_idx =3D -1;
> +	if (!wiphy->n_radio)
> +		return true;
> +
> +	for (i =3D 0; i < wiphy->n_radio; i++) {
> +		radio =3D &wiphy->radio[i];
> +		if (!ieee80211_radio_freq_match(radio, chanreq))
> +			continue;
> +
> +		if (!ieee80211_can_create_new_chanctx(local, i))
> +			continue;
> +
> +		*radio_idx =3D i;
> +		return true;
> +	}
> +
> +	return false;
> +}

which would also get used here to find the radio first, though would
have to differentiate n_radio still, of course.

johannes

