Return-Path: <linux-wireless+bounces-25521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CBB06FBE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D496A4A24A0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2532857E2;
	Wed, 16 Jul 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cAgoMqYA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7844A11
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652577; cv=none; b=QTnCpMbvVhIMjXcapIvTUit6XCcbdhre9t2YRGDHKbnYL5vuhwhiC8R+FeapKfyiuH3Rcdbj5LrUoagu4QTKCecIDHFXu06P5gFkB04+S4Pw+Q44Uxsss8HEDi7omFcI65aGH6jDfuVPRGUKyxXJ0UL2CW0EMwuKwW23jgrO11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652577; c=relaxed/simple;
	bh=fsZj66BE6aS8iyqatEELdz0rNJc0ly0SR0Nx7vAYyMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upXZfK4qvA/8KiNP4hLw+0xnr6frY9/AmLkgimnAScFJCRdlucVpXCRYY1GLwSZYruJLqvfUl1FxIEozFFOrm+cKdTlwHe4u0R0UKmr5B3FhkJRhBfyLF6TL5SyMe9OXJQeHSe5tjxl/b6veetDAnpQPAH9oy57VwWe41jIC9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cAgoMqYA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z3+kwWRo7S1wRZgEDLvO880O4v9ACy7nLbddM5BWICs=;
	t=1752652574; x=1753862174; b=cAgoMqYAj5ouAgVpv5Hr6/iWU8t7scf8s/LTX43IcuH+GfF
	Ys48FFNzRZRCVNwBoQqu7rnI0DVzT3lsPfaz5XwiU271BTEFZESbnBZ2ZqcUOR33/DR7sDJMkPf3X
	cIe5InAdFitbUjY7IhSJyecTuUH6l577JkXWda5rJz9XWerelHMehC0J0EayzOWiFzuMekQgf50ky
	If2F0YsYk5SviIqwlzpdaJcNG4bz6AokZdFSmuP8zIYJEesvBMFwy4UkaklOTPHdA7QBKDqfHcO05
	banAzyvmio4uFPpQoML8SVeogylMrOwN7dVlJCVjX0Y5NmdYDeoi1drrO3kz9n3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubwzj-00000007vNX-3sIz;
	Wed, 16 Jul 2025 09:56:04 +0200
Message-ID: <d5d5cce69b8300cfe1de7c0b2109403a4735f309.camel@sipsolutions.net>
Subject: Re: [wireless-next v2 2/4] wifi: mac80211: support initialising an
 S1G short beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 16 Jul 2025 09:55:58 +0200
In-Reply-To: <20250716053254.439698-3-lachlan.hodges@morsemicro.com> (sfid-20250716_073405_107075_CA53A324)
References: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
	 <20250716053254.439698-3-lachlan.hodges@morsemicro.com>
	 (sfid-20250716_073405_107075_CA53A324)
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

On Wed, 2025-07-16 at 15:32 +1000, Lachlan Hodges wrote:
>=20
> +++ b/include/net/mac80211.h
> @@ -365,6 +365,7 @@ struct ieee80211_vif_chanctx_switch {
>   * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
>   * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
>   * @BSS_CHANGED_TPE: transmit power envelope changed
> + * @BSS_CHANGED_S1G_SHORT_BEACON: S1G short beacon changed
>   */
>  enum ieee80211_bss_change {
>  	BSS_CHANGED_ASSOC		=3D 1<<0,
> @@ -402,6 +403,7 @@ enum ieee80211_bss_change {
>  	BSS_CHANGED_MLD_VALID_LINKS	=3D BIT_ULL(33),
>  	BSS_CHANGED_MLD_TTLM		=3D BIT_ULL(34),
>  	BSS_CHANGED_TPE			=3D BIT_ULL(35),
> +	BSS_CHANGED_S1G_SHORT_BEACON	=3D BIT_ULL(36),

I feel like at the moment the driver has no way of using this, is it
even needed? It's (currently) designed to really only work with drivers
that pull each individual beacon, since you have no "get short beacon
template" and such.

> + * @s1g_short_beaconing: determines if short beaconing is enabled for an=
 S1G
> + *	BSS.
> + * @s1g_long_beacon_period: number of beacon intervals between each long
> + *	beacon transmission.
>   */
>  struct ieee80211_bss_conf {
>  	struct ieee80211_vif *vif;
> @@ -857,6 +863,9 @@ struct ieee80211_bss_conf {
> =20
>  	u8 bss_param_ch_cnt;
>  	u8 bss_param_ch_cnt_link_id;
> +
> +	bool s1g_short_beaconing;
> +	u8 s1g_long_beacon_period;
>  };

Given that, should these even be visible to the driver?

And is s1g_short_beaconing needed at all, I don't see it ever being
read? Almost feels like it shouldn't - could get out of date vs. the
link->u.ap.s1g_short_beacon pointer, which internally indicates the
same.


> +static int
> +ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
> +			       struct cfg80211_s1g_short_beacon *params,
> +			       struct ieee80211_link_data *link,
> +			       struct ieee80211_bss_conf *link_conf,
> +			       u64 *changed)
> +{
> +	struct s1g_short_beacon_data *new, *old;
> +	int new_head_len, new_tail_len, size;
> +
> +	if (!params->update)
> +		return 0;
> +
> +	old =3D sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
> +	if (!params->short_head && !old)
> +		return -EINVAL;

Not sure I understand this logic. If there's no update, it returns
anyway.

This should probably be on the cfg80211 patch, but now that I'm writing
here ... If there is no new short beacon update cannot currently be set
to true, I think? And also, right now by the policy you can't set the
long_beacon_interval =3D=3D 1 from userspace, but what if you actively want
to _remove_ the short beacon entirely?

Maybe that's not legal? Or maybe it should be allowed, and then I think
the easiest way of achieving it would be to allow the long beacon
interval to be set to 1, which effectively removes the short beacon?

Either way - I'm not sure I follow the "!new && !old" part here since
you can't actually have params->update && !params->head right now? And
even if you could, I'm not sure what the old matters.

> +	new_head_len =3D params->short_head ? params->short_head_len :
> +					    old->short_head_len;
> +	new_tail_len =3D (params->short_tail || !old) ? params->short_tail_len =
:
> +						      old->short_tail_len;

This seems similarly odd to me, if you set a new short head but no short
tail you surely don't want to reuse the old short tail?

Seems to me really this should never use "old" at all, since you want to
update everything (or even remove the short beacon if that's allowed per
above), but never mix things?

And if update is false nothing ever happens here anyway.

> +	if (old)
> +		kfree_rcu(old, rcu_head);

Though of course this is still needed.

johannes

