Return-Path: <linux-wireless+bounces-25383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49CB03F20
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7577A7A51
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303024DD00;
	Mon, 14 Jul 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="foFEY35j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753024A051
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498017; cv=none; b=BnUF9bfSKJh5VO1i5Ej8zsnGjaHWBgPWr2xE0opqFiBXH7+xzXdGyS+3RHrY8rxykTwJGERtszjPv/adkyhuB57VvPZ348VLD8NPZGExAXB3Rg5g6kSaUQwYVzhNSB3X2F+3i+ihXx5HkU8UH558oK25xH5JWo+1uNI7FhG8cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498017; c=relaxed/simple;
	bh=NcME/Wt9+5/7VL4lYUOVqWLoRY2NOpElAFRfUGH6M68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/K4Tl2NUqA7afKN54ix/spnOdHFkKFHdc2XnIfMrWW9zxAl7aVWi98YwR4YSmVUgS48pGM13tOGn5s5rCZOg9U5NHB7zsFL1NWyJtt8mbDUGZz6fgKNn4UoroMq3kx0HFpbqzYQ2CSi7xW6Va05xphyt/iPzjurv/zEySBgF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=foFEY35j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J/Mob8kUpptXtlYOpZQBc6VjtiHIckgBQpSSM/sMSQA=;
	t=1752498015; x=1753707615; b=foFEY35jAQiyfPHrZSD0IVhVzv7qPf+7R9z7U2PImpjcCVc
	SUpYpd3CoByMbQBQop/Tu3DdAwtSKinfr5DCaZLCU/Sz2aBWu8nXqYr1amLatv87CWV7FECWSgy9c
	O2n0b3aZp+MyMu9jm2PYYe4sBRYKn7X7MGgcnXkUNaxf9DlEbZythqu1YMPN1vOeHWbzolVkodLwe
	I1ePL4lRjDVP05iDYJoFsVT4MIjtl0WbVxzXjWRsluvoxdjOpS6uLutI1DwApUEkLIc3kBbh+8qy5
	uV+qSs5kwtEXa8p3OanYVBVAdAL7Qjxq1f2UXJs5aRzKL0w7RM+qSgNjT+RfN86A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubImx-000000045y2-3fbG;
	Mon, 14 Jul 2025 15:00:12 +0200
Message-ID: <4333caeb7a98bf2d29da7a26181dc34032d5bd9b.camel@sipsolutions.net>
Subject: Re: [RFC 1/5] wifi: cfg80211: support configuring an S1G short
 beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 14 Jul 2025 15:00:11 +0200
In-Reply-To: <20250714051403.597090-2-lachlan.hodges@morsemicro.com> (sfid-20250714_071432_241839_F48088A7)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
	 <20250714051403.597090-2-lachlan.hodges@morsemicro.com>
	 (sfid-20250714_071432_241839_F48088A7)
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

On Mon, 2025-07-14 at 15:13 +1000, Lachlan Hodges wrote:
>=20
> +/**
> + * enum nl80211_s1g_short_beacon_attrs - S1G short beacon data
> + *
> + * @__NL80211_S1G_SHORT_BEACON_ATTR_INVALID: Invalid
> + *
> + * @NL80211_S1G_SHORT_BEACON_HEAD: Short beacon head (binary).
> + * @NL80211_S1G_SHORT_BEACON_TAIL: Short beacon tail (binary).
> + * @NL80211_S1G_SHORT_BEACON_INTERVAL: Time in TUs between each short
> + *	beacon transmission (u32).
> + * @NL80211_S1G_SHORT_BEACON_DTIM_PERIOD: DTIM period for a short
> + *	beaconing BSS (u8).
> + */
> +enum nl80211_s1g_short_beacon_attrs {
> +	__NL80211_S1G_SHORT_BEACON_ATTR_INVALID,
> +
> +	NL80211_S1G_SHORT_BEACON_HEAD,
> +	NL80211_S1G_SHORT_BEACON_TAIL,
> +	NL80211_S1G_SHORT_BEACON_INTERVAL,
> +	NL80211_S1G_SHORT_BEACON_DTIM_PERIOD,

nit: we usually have _ATTR_ in there after the qualification, so
something like NL80211_S1G_SHORT_BEACON_ATTR_HEAD.

Also, the bot complained about some missing kernel-doc.
=20
> +/*
> + * Short beacons contain a limited set of allowed elements as per
> + * IEEE80211-2024 9.3.4.3 Table 9-76. The TIM element is allowed,
> + * but as it is inserted by mac80211, we do not check for it.
> + */
> +static int is_valid_s1g_short_elem(const struct element *elem)
> +{
> +	switch (elem->id) {
> +	case WLAN_EID_FMS_DESCRIPTOR:
> +	case WLAN_EID_RPS:
> +	case WLAN_EID_SST:
> +	case WLAN_EID_S1G_RELAY:
> +	case WLAN_EID_PAGE_SLICE:
> +	case WLAN_EID_VENDOR_SPECIFIC:
> +	case WLAN_EID_MMIE:
> +	case WLAN_EID_MIC:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Is that really worth it? We don't have to protect userspace from
shooting it self into the foot _too_ much, just make sure that we don't
get into a mess in the kernel itself. As long as the elements are not
malformed, I'd argue we're fine from a kernel perspective?

This also prevents future updates and experimentation, and I see little
value in it?

> +static int nl80211_validate_s1g_short_conf(struct cfg80211_ap_settings *=
params)
> +{
> +	struct cfg80211_s1g_short_beacon *sb =3D &params->s1g_short_beacon;
> +	u64 beacon_int =3D params->beacon_interval;

Why a u64, it's not a u64 in the params? and it makes the division
harder (well, really you wanted the remainder)

> +	u32 short_int =3D sb->short_interval;
> +
> +	/*
> +	 * As per IEEE80211 11.1.3.10.2, beacon_interval =3D n * short_interval
> +	 * where n is a positive integer. Meaning a BSS can be configured such
> +	 * that both the short beacon interval and long beacon interval are
> +	 * equivalent. This effectively means we aren't short beaconing. In
> +	 * this case, since the short beacon data is irellevent its probably a

typo: irrelevant

> +	 * misconfiguration and we should reject it.
> +	 */
> +	if (sb->short_interval >=3D params->beacon_interval)
> +		return -EINVAL;
> +
> +	if (do_div(beacon_int, short_int))
> +		return -EINVAL;

so that could just be

	if (params->beacon_interval % sb->short_interval)
		return -EINVAL;

no?

> +static int
> +nl80211_parse_s1g_short_beacon(struct cfg80211_registered_device *rdev,
> +			       struct nlattr *attrs,
> +			       struct cfg80211_s1g_short_beacon *sb)
> +{
> +	struct nlattr *tb[NL80211_S1G_SHORT_BEACON_ATTR_MAX + 1];
> +	int ret;
> +
> +	if (!rdev->wiphy.bands[NL80211_BAND_S1GHZ])
> +		return -EINVAL;

Maybe we should (instead?) check that it's operating as or being set up
for s1g? Not sure how easy that is, but I've actually wanted it in other
places before, I think.

> +
> +	ret =3D nla_parse_nested(tb, NL80211_S1G_SHORT_BEACON_ATTR_MAX, attrs,
> +			       NULL, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Short beacon tail is optional (i.e might only include the TIM) */
> +	if (!tb[NL80211_S1G_SHORT_BEACON_HEAD])
> +		return -EINVAL;
> +
> +	sb->update =3D false;
> +	sb->short_head =3D nla_data(tb[NL80211_S1G_SHORT_BEACON_HEAD]);
> +	sb->short_head_len =3D nla_len(tb[NL80211_S1G_SHORT_BEACON_HEAD]);
> +	sb->short_tail_len =3D 0;
> +
> +	if (tb[NL80211_S1G_SHORT_BEACON_TAIL]) {
> +		sb->short_tail =3D nla_data(tb[NL80211_S1G_SHORT_BEACON_TAIL]);
> +		sb->short_tail_len =3D nla_len(tb[NL80211_S1G_SHORT_BEACON_TAIL]);
> +	}
> +
> +	if (!tb[NL80211_S1G_SHORT_BEACON_INTERVAL] ||
> +	    !tb[NL80211_S1G_SHORT_BEACON_DTIM_PERIOD]) {
> +		sb->update =3D true;
> +		return 0;
> +	}
> +
> +	sb->short_interval =3D
> +		nla_get_u32(tb[NL80211_S1G_SHORT_BEACON_INTERVAL]);
> +	sb->short_dtim_period =3D
> +		nla_get_u8(tb[NL80211_S1G_SHORT_BEACON_DTIM_PERIOD]);
> +
> +	return 0;
> +}
> +
>  static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> @@ -6442,6 +6615,28 @@ static int nl80211_start_ap(struct sk_buff *skb, s=
truct genl_info *info)
>  		goto out;
>  	}
> =20
> +	if (info->attrs[NL80211_ATTR_S1G_SHORT_BEACON]) {
> +		err =3D nl80211_parse_s1g_short_beacon(
> +			rdev, info->attrs[NL80211_ATTR_S1G_SHORT_BEACON],
> +			&params->s1g_short_beacon);
> +		if (err)
> +			goto out;
> +
> +		/*
> +		 * If we have only received the parameters to perform a
> +		 * short beacon update, return an error to usermode as
> +		 * the BSS has not yet been configured for short beaconing.
> +		 */
> +		if (params->s1g_short_beacon.update) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		err =3D nl80211_validate_s1g_short_conf(params);
> +		if (err)
> +			goto out;

why not call the validation inside nl80211_parse_s1g_short_beacon()?
seems harder to misuse later then, and the order shouldn't matter much?

> @@ -6550,6 +6745,19 @@ static int nl80211_set_beacon(struct sk_buff *skb,=
 struct genl_info *info)
>  			goto out;
>  	}
> =20
> +	attr =3D info->attrs[NL80211_ATTR_S1G_SHORT_BEACON];
> +	if (attr) {
> +		err =3D nl80211_parse_s1g_short_beacon(rdev, attr,
> +						     &params->s1g_short_beacon);
> +		if (err)
> +			goto out;
> +
> +		if (!params->s1g_short_beacon.update) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +	}

And you already forgot the validation here, it seems?

Looks fine from the perspective of when/how you parse it, I think,
unless you were going to need channel switch and/or BSS color change.

johannes

