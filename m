Return-Path: <linux-wireless+bounces-12154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DC962501
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C194B22124
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AEB160783;
	Wed, 28 Aug 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="thBljPJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D616C6A8
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841197; cv=none; b=rIymcpQaKSKfNoUu3d2eGqKHDbbD2Eb0QGziJSZ/xBKObFM3DQbC5y+csFODsi1DdMYWkpTk10iQUApzeVDanNvkoztw7eEcQeJZyAongQuIpliZR7fO3586+RYTLZwrwPA35+oQs7aF1zad1BkUvwGdBU8cMXEAfIkjSW3q4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841197; c=relaxed/simple;
	bh=6uPWgnrsx7LZ6AZs5YB50pYMtCSFJUF4hdiEwyES0LE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XC+Ho8z8Zo6Uho3Vi+sjchdW/z7kmj+g8Yptr5L0dDuZahNHS7JuXRSc7eZo9qh2leUwNpCvgQyXBb8W4Tm4V5HmIL3ODkxelVncqEi4gAbCbTybgAkmLTUnUmmoz0d7I+uvyBxIoLHsr4bOTUInQx2aG92razd0SgEyiVEdcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=thBljPJu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pzn5S3hzcXDwgn4xANFI56Lp0/1AzeLTwKf9sHqZTPs=;
	t=1724841196; x=1726050796; b=thBljPJuK/sq1ywUoNk4hnPFqARHVdgkY3vmchzWP+x+1rR
	tlebjonmV+kq90B1+R3zPlh2ZbJtkmU8KoVxlUw+K0hTSDoXI727HQAwYuLdXeNDAL234zBoiLo+c
	K+iIHdrM29PIlDMGrIUCjnu9kUR406cpMh+Xat0IOaN1zuERiMrhUcxiLMVfcUl3CbqCCzpEsC23O
	aU60PzDm1kzmkhXW207RgaUubivtb4p3EYXmQ0++ep0bcYfXvp2bAqS4seeZDn4VXd9bkYZO+9U0L
	i8r1SNJ1YZ3awMQTtIgl1976rjrBNpenW61jW3wl9IqPEBj2b2IYYRan4I+lvq7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjFzF-00000006xgI-06gt;
	Wed, 28 Aug 2024 12:33:13 +0200
Message-ID: <5c099cda2015594d23f29635d77adf9db5744a15.camel@sipsolutions.net>
Subject: Re: [PATCH v3 8/8] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 12:33:12 +0200
In-Reply-To: <20240711035147.1896538-9-quic_adisi@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
	 <20240711035147.1896538-9-quic_adisi@quicinc.com>
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

On Thu, 2024-07-11 at 09:21 +0530, Aditya Kumar Singh wrote:
>=20
>   * In the worker, go over all the contexts again and for all such contex=
t
>     which is marked with radar detected, add it to a local linked list.

Why is the local list needed first?

> +++ b/include/net/mac80211.h
> @@ -257,6 +257,7 @@ struct ieee80211_chan_req {
>   *	after RTS/CTS handshake to receive SMPS MIMO transmissions;
>   *	this will always be >=3D @rx_chains_static.
>   * @radar_enabled: whether radar detection is enabled on this channel.
> + * @radar_detected: whether radar got detected on this channel.
>   * @drv_priv: data area for driver use, will always be aligned to
>   *	sizeof(void *), size is determined in hw information.
>   */
> @@ -269,6 +270,7 @@ struct ieee80211_chanctx_conf {
>  	u8 rx_chains_static, rx_chains_dynamic;
> =20
>  	bool radar_enabled;
> +	bool radar_detected;

I'm not sure why you're adding this to the driver visible part of the
chanctx, I don't think that really makes sense since setting it must be
done by mac80211 through the API function to trigger all the work?

> +++ b/net/mac80211/ieee80211_i.h
> @@ -1329,6 +1329,11 @@ enum mac80211_scan_state {
> =20
>  DECLARE_STATIC_KEY_FALSE(aql_disable);
> =20
> +struct radar_info {
> +	struct list_head list;
> +	struct cfg80211_chan_def chandef;
> +};

If it _really_ is needed this can be local to the C file.

> +	INIT_LIST_HEAD(&radar_info_list);

but really, why?

>  	list_for_each_entry(ctx, &local->chanctx_list, list) {
>  		if (ctx->replace_state =3D=3D IEEE80211_CHANCTX_REPLACES_OTHER)
>  			continue;
> =20
> -		num_chanctx++;
> -		chandef =3D ctx->conf.def;
> +		if (ctx->conf.radar_detected) {
> +			ctx->conf.radar_detected =3D false;
> +			num_chanctx++;
> +
> +			radar_info =3D kzalloc(sizeof(*radar_info), GFP_KERNEL);
> +			if (WARN_ON(!radar_info))
> +				continue;

that clearly shouldn't be a WARN_ON,

> +
> +			INIT_LIST_HEAD(&radar_info->list);
> +			radar_info->chandef =3D ctx->conf.def;
> +			list_add_tail(&radar_info->list, &radar_info_list);

but I also don't really see why you couldn't just call
cfg80211_radar_event() here.

> +	if (num_chanctx > 1) {
> +		/* XXX: multi-channel is not supported yet in case of non-MLO */
> +		if (WARN_ON(!(wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
> +			trigger_event =3D false;
> +	}

I don't see how that'd happen in the first place?

johannes

