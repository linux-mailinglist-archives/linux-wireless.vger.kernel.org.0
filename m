Return-Path: <linux-wireless+bounces-27151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9EB4A5F8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFC1447027
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75919273D7B;
	Tue,  9 Sep 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U175LuUL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9716239570
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407907; cv=none; b=kKgpnQtg9Qxc3peoVUrsnM4iP29iUA0HSlsVhTPi70nZqliC/E2xlIZuMzahS1B52nJQNJt6n9I9flvLKAHuJQDfY01xdqZfemoO18HYP+jcwgtoM6DGAl369SCFohpMZJTYzYBfZGB/xId8yfN3LmBfaZGhJ25JHOdG3Nl6kcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407907; c=relaxed/simple;
	bh=5NJ+YUQCNg4g1Mab2wmTpUETkb6uPstH7AGi4DU30Vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGN8bM18StSY60csVmq3wtn7AkyfvxfHeA+Bn3aPC3pT8d/dIgMy0jXHXVDCxsVlZejLw/IJixmHiPqGa4Su2UZYWeNBPZBbItnCGdHDeeiJZgMZyD3UD8BbxLzPAMsKJPbDLl9015ykRfgnqkDpR6MOQEileYeahhE0sZBxwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U175LuUL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YxqSLb+9rOJZVfQdrABPssP/VuWLcrPeMai4AUzXOUg=;
	t=1757407905; x=1758617505; b=U175LuULnvzQubYqZNWUUnS/GPLLrXroplX8yRwVjVZIe5i
	Y5AWbPet6TwLGwwcoWn6yrNe8CF6wzxcYUxsD/Jzt7mwMJUNE8h7fMmDfAQeLpW9tmpWQa/r+Lfbq
	IX3rO2VVj1BL9OXh13Z+dB230qNNT+BobcU7QV3eYDSPMsXYUvSz8oqL5AUbLqRkyX7UdDEJjms5l
	scwes8b24IJMf/dBIcVrx0Q7dm2SQMwEvmyHQhecHx8p7+HWG3Ivs80oAJS3/fgkjWwquzGLluvWL
	t5Nt7JECrmwzVo+gvQ1eenpQNwTjlLOGhw3VnAwXIxiYIeYzP/9/QgNjZPdQIQXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvu4l-00000009vxl-1Lk7;
	Tue, 09 Sep 2025 10:51:43 +0200
Message-ID: <a70b8e474d097275267458e5bbc8c96ed2cb5955.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 2/3] wifi: mac80211: correctly initialise
 S1G chandef for STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 09 Sep 2025 10:51:42 +0200
In-Reply-To: <20250909080758.1004956-3-lachlan.hodges@morsemicro.com> (sfid-20250909_100820_030103_3BF128DA)
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
	 <20250909080758.1004956-3-lachlan.hodges@morsemicro.com>
	 (sfid-20250909_100820_030103_3BF128DA)
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

On Tue, 2025-09-09 at 18:07 +1000, Lachlan Hodges wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -180,11 +180,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_=
data *sdata,
> =20
>  	/* get special S1G case out of the way */
>  	if (sband->band =3D=3D NL80211_BAND_S1GHZ) {
> -		if (!ieee80211_chandef_s1g_oper(elems->s1g_oper, chandef)) {
> -			sdata_info(sdata,
> -				   "Missing S1G Operation Element? Trying operating =3D=3D primary\n=
");
> -			chandef->width =3D ieee80211_s1g_channel_width(channel);
> -		}
> +		if (!ieee80211_chandef_s1g_oper(sdata->local, elems->s1g_oper,
> +						chandef))
> +			WARN_ON(1);

We generally don't want WARN_ON() if the AP is broken/wrong/stupid, so
should probably do something like that had before? Or just not connect?


(and if we did accept WARN_ON, you'd want WARN_ON(!...) here)

> @@ -3227,12 +3228,36 @@ bool ieee80211_chandef_s1g_oper(const struct ieee=
80211_s1g_oper_ie *oper,
>  		return false;
>  	}
> =20
> -	oper_freq =3D ieee80211_channel_to_freq_khz(oper->oper_ch,
> -						  NL80211_BAND_S1GHZ);
> -	chandef->center_freq1 =3D KHZ_TO_MHZ(oper_freq);
> -	chandef->freq1_offset =3D oper_freq % 1000;
> +	chandef->s1g_primary_2mhz =3D false;
> =20
> -	return true;
> +	switch (FIELD_GET(S1G_OPER_CH_WIDTH_PRIMARY, oper->ch_width)) {

nit: I tend to prefer u8_get_bits(oper->ch_width, S1G_OPER...) although
that mostly applies for fields wider than u8 since then you can use
le16_get_bits() etc. Might be nicer to be consistent and use the newer
helpers in newer code.

(But I don't feel very strongly about it, so if you feel strongly this
is better, feel free.)

> +	case IEEE80211_S1G_PRI_CHANWIDTH_1MHZ:
> +		pri_1mhz_khz =3D ieee80211_channel_to_freq_khz(
> +			oper->primary_ch, NL80211_BAND_S1GHZ);
> +		break;
> +	case IEEE80211_S1G_PRI_CHANWIDTH_2MHZ:
> +		chandef->s1g_primary_2mhz =3D true;
> +		pri_2mhz_khz =3D ieee80211_channel_to_freq_khz(
> +			oper->primary_ch, NL80211_BAND_S1GHZ);
> +
> +		if (FIELD_GET(S1G_OPER_CH_PRIMARY_LOCATION, oper->ch_width) =3D=3D
> +		    S1G_2M_PRIMARY_LOCATION_LOWER)

same here

johannes

