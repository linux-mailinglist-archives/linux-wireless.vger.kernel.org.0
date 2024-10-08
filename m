Return-Path: <linux-wireless+bounces-13733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E817199585A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 22:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E46F1F22792
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C14215006;
	Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Aqay5GK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18D1E104B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419184; cv=none; b=OQbfeZqUNnkeZFbFFPd4RxHmnr82+0stpBnNMhQSQ5EjU+L+GK4TR/v92/NxlURKjf4VunxnX0UmRj08T9Gagdm7sIYib3/0iog8c/zPIHyV8e+Li+J63SGTYdGlQiOWHBQwHxGymbMqlGGt4kT9vYQhVd8X8+wBaQgwZU9Wh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419184; c=relaxed/simple;
	bh=sCo12iY1AfRT+sjp1kgRKvXKOzFE1M/VF6MJNYghPxE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ytl2HepFCBTYF4fm9T0k0c9dMQOilHtKAUjR3N9mo6oLy6f+99e0pWjwjrqbDeRjKj74M8hLzvFgAJRzhirJkln3fbril5eM22fNoXVahqr0l2mPOOM8z1++foOhSCvXGGedpjBK0feTYlGtUWBmzJOHiOyv3xyi2KLxrGTjLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Aqay5GK0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pguwOqbT95af/Lf619A3V1B+12Fg/QJXBqgHuxJLPAM=;
	t=1728419183; x=1729628783; b=Aqay5GK0Hi+dIQPi+VEIZSsgsd+QW1Nb9i7kK1GNME95ID4
	ACLRtS34rKAusfOjPxxV03SPJXqTyKugpUbsNCYlOZio/eYsH+V+P8pqwBzKNStzQJVxwGgNIetMn
	xntG9GhwZWNr1v3yPy91z8LheDvolyXLXhPfZy8lCJAl6C2PR29SxCndjR2/wluLHREkc6bytVbhG
	QR0wsmVIvg815mOKU2pgLUiFtHp4UB6C7SAoC3LoxeYdjEFh9AQowYHcZuZ3R/g0kVW4gWoZJ9Lh+
	NseAXlQgQU3TeW2SKf0rtgAuCGtldqLZ1Gx+v1MspqDE6oHS6/fmCj+IUeTp3JSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syGmi-00000004Nif-2ccE;
	Tue, 08 Oct 2024 22:26:20 +0200
Message-ID: <a6f71a159f8e2770dba6279dc7e685c22b309937.camel@sipsolutions.net>
Subject: Re: [PATCH v4 02/11] wifi: mac80211: use vif radio mask to limit
 ibss scan frequencies
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 08 Oct 2024 22:26:19 +0200
In-Reply-To: <f41b5a66279c2a106f69042d64aa2bf0f9ce81c6.1728372192.git-series.nbd@nbd.name>
References: 
	<cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
	 <f41b5a66279c2a106f69042d64aa2bf0f9ce81c6.1728372192.git-series.nbd@nbd.name>
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

> Reject frequencies not supported by any radio that the vif is allowed to =
use.

Should line-break to fewer chars per line, though I guess you're not
over by much (78 vs. 75) :)

> +++ b/net/mac80211/scan.c
> @@ -1176,14 +1176,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_=
sub_if_data *sdata,
>  				unsigned int n_channels)
>  {
>  	struct ieee80211_local *local =3D sdata->local;
> -	int ret =3D -EBUSY, i, n_ch =3D 0;
> +	int ret =3D -EINVAL, i, n_ch =3D 0;
>  	enum nl80211_band band;
> =20
>  	lockdep_assert_wiphy(local->hw.wiphy);
> =20
>  	/* busy scanning */
> -	if (local->scan_req)
> +	if (local->scan_req) {
> +		ret =3D -EBUSY;
>  		goto unlock;
> +	}
> =20
>  	/* fill internal scan request */
>  	if (!channels) {
> @@ -1200,7 +1202,9 @@ int ieee80211_request_ibss_scan(struct ieee80211_su=
b_if_data *sdata,
>  				    &local->hw.wiphy->bands[band]->channels[i];
> =20
>  				if (tmp_ch->flags & (IEEE80211_CHAN_NO_IR |
> -						     IEEE80211_CHAN_DISABLED))
> +						     IEEE80211_CHAN_DISABLED) ||
> +				    !cfg80211_wdev_channel_allowed(&sdata->wdev,
> +								   tmp_ch))
>  					continue;
> =20
>  				local->int_scan_req->channels[n_ch] =3D tmp_ch;
> @@ -1215,14 +1219,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_=
sub_if_data *sdata,
>  	} else {
>  		for (i =3D 0; i < n_channels; i++) {
>  			if (channels[i]->flags & (IEEE80211_CHAN_NO_IR |
> -						  IEEE80211_CHAN_DISABLED))
> +						  IEEE80211_CHAN_DISABLED) ||
> +			    !cfg80211_wdev_channel_allowed(&sdata->wdev,
> +							   channels[i]))
>  				continue;
> =20
>  			local->int_scan_req->channels[n_ch] =3D channels[i];
>  			n_ch++;
>  		}
> =20
> -		if (WARN_ON_ONCE(n_ch =3D=3D 0))
> +		if (n_ch =3D=3D 0)
>  			goto unlock;
>=20

You're changing the return value here and in another case hidden in the
context, is that intentional?

And either way it's better to just remove the unlock label and 'ret'
variable while at it now, it's pretty much unused already.

johannes

