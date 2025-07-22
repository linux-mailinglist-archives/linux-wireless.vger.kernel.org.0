Return-Path: <linux-wireless+bounces-25851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CCB0D821
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D15560065
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99823814C;
	Tue, 22 Jul 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RIdTp0iO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B442BEC3F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183564; cv=none; b=Jzf2Yk3koRzWs517qzPs9hO6KZHXDeiwjbrwUO9ttcMN2nfzYb8zMBxbxe2fGbvFX29CsQaY1V54EaGObrAegRsGF8SUYNaLkmXYA0Cz5VEO9NNgf1rBY0MUMmN9n/hSUnpLpRSmjUbdEkrw/yThVRGE+WsvSMX9optI5SxBxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183564; c=relaxed/simple;
	bh=L6cVTARNQ2wleGa51fNDKo5q5qEPFzdi7Hd0cge+pgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuH1UMkomD6ptuHVuwWZ6D5vwurd0VpgnztSc8P7LJxa45obCvydDFWOpwWI9fLs+K4JG42vJPaaLsTw9nGAJIiJrzlB/tE3jLCEfwcdqqz5q7A6awHsYhAz1hDF9COfQGu7HelIQqC6aMbUzC38LvOI/ofA90I/7xmt3/HUm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RIdTp0iO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G6XZOWB1oyUVGr68M8/v601BV4HkECWgfvpYLzaBsQY=;
	t=1753183562; x=1754393162; b=RIdTp0iO4Cl81NgyVWZZNz/wRl/I7Ld4QmRbcK1WkcHsylE
	KUvMHC4jdhi749BHSBD4Tfgd9jC6IfBcYaGkq8yuF0UeEcI1Qs+MS/yVjB8+bwu/TfXZrFebWqXJv
	XBWeXYp1us91hk03sXiCgMzkc13LdQYvBLm0IqvTNOAvvVQDBAYkNqGXesP7/T47shhabzWAUFd73
	guArVYuQoQfu9CDH3iOhsdrcJjCNCHvaz7+q49ZFnSzjRTIl093JDaDctNJRCWure99POeZEctH6A
	v0rXrkjuXIM+0pfDoFOHZB5P6caHWLlK/alBDxc5SIZAdapXKMDgv2QA6neIF3qA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueB83-000000022qp-2NLo;
	Tue, 22 Jul 2025 13:25:52 +0200
Message-ID: <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 22 Jul 2025 13:25:50 +0200
In-Reply-To: <20250722071642.875875-3-lachlan.hodges@morsemicro.com> (sfid-20250722_091734_347547_503BDD6C)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
	 (sfid-20250722_091734_347547_503BDD6C)
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

On Tue, 2025-07-22 at 17:16 +1000, Lachlan Hodges wrote:
> When parsing a TIM element from an S1G AP, ensure we correctly
> parse based on the S1G PPDU TIM PVB format, allowing an S1G STA
> to correctly enter/exit power save states to receive buffered
> unicast traffic.

I think this isn't quite correct.

> Also make sure we don't allocate over the
> mac80211 supported S1G PPDU AID count.

But this specifically caught my eye - how can the client ensure it
doesn't allocate over, since it doesn't even allocate? First I thought
this really belongs into the AP side code (i.e. the other patch), but
you actually did something here:

> @@ -6374,10 +6375,12 @@ static void ieee80211_rx_mgmt_assoc_resp(struct i=
eee80211_sub_if_data *sdata,
>  	reassoc =3D ieee80211_is_reassoc_resp(mgmt->frame_control);
>  	capab_info =3D le16_to_cpu(mgmt->u.assoc_resp.capab_info);
>  	status_code =3D le16_to_cpu(mgmt->u.assoc_resp.status_code);
> -	if (assoc_data->s1g)
> +	if (assoc_data->s1g) {
>  		elem_start =3D mgmt->u.s1g_assoc_resp.variable;
> -	else
> +		max_aid =3D IEEE80211_MAX_AID_S1G_NO_PS;
> +	} else {
>  		elem_start =3D mgmt->u.assoc_resp.variable;
> +	}
> =20
>  	/*
>  	 * Note: this may not be perfect, AP might misbehave - if
> @@ -6401,8 +6404,6 @@ static void ieee80211_rx_mgmt_assoc_resp(struct iee=
e80211_sub_if_data *sdata,
> =20
>  	if (elems->aid_resp)
>  		aid =3D le16_to_cpu(elems->aid_resp->aid);
> -	else if (assoc_data->s1g)
> -		aid =3D 0; /* TODO */
>  	else
>  		aid =3D le16_to_cpu(mgmt->u.assoc_resp.aid);
> =20
> @@ -6447,7 +6448,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct iee=
e80211_sub_if_data *sdata,
>  		event.u.mlme.reason =3D status_code;
>  		drv_event_callback(sdata->local, sdata, &event);
>  	} else {
> -		if (aid =3D=3D 0 || aid > IEEE80211_MAX_AID) {
> +		if (aid =3D=3D 0 || aid > max_aid) {
>  			sdata_info(sdata,
>  				   "invalid AID value %d (out of range), turn off PS\n",
>  				   aid);

Which ... seems questionable? At least in terms of message it's not
actually _invalid_ if it's out of this range, in theory S1G allows up to
8191.

And you also forgot to change the masking - S1G says 3 bits are
reserved, where we actually check the top two bits are 0b11 I think?

Also the parsing for S1G only parses a subset of the valid formats,
notably the format that mac80211 can generate. That seems questionable,
unless you expect there never to be another implementation (or the
mac80211 one to never be extended) and you can basically make up your
own standard?

And even if you _do_ get an AID that's <1600 there's still no guarantee
that the encoding will be in the bitmap format, if only two stations
have traffic the AP might well decide to use the "Single AID" mode?

So I'm overall a bit confused how all this is meant to work - even if
only partially - because AID<1600 is no guarantee that you can parse the
bitmap, so turning off powersave only for AID>=3D1600 will not really be
sufficient?


Which also means that

> +#define IEEE80211_MAX_AID_S1G_NO_PS	1600

really doesn't belong into ieee80211.h, if it should exist at all then
as part of mac80211 (but above I'm arguing it shouldn't.)

johannes

