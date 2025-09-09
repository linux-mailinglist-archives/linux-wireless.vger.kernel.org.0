Return-Path: <linux-wireless+bounces-27150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B41B4A5D6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2E43BB7D6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5042566DF;
	Tue,  9 Sep 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yYIRjM6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E01EFF8D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407629; cv=none; b=Ofal92Tpv20o/Lm6o3jPYXMNTMBZ20Ls0wT5/7pNdY65zCeGCgjUcghoWSKCDXWECErA4B9iLo02c7zC8I+zEN6eO7zZePdDtbFw0R80TlItdXblpO9IjxGreUmApthK0AO8KpE6i6GBI4A1fZlFW884UM7eIMHEOESgBE7sJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407629; c=relaxed/simple;
	bh=xLpeJsa2Cbv+gNC6nlyEtYq0PRmjcTV6cOAIuDEiCmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EH6U/FaP9aUey4ttiBrE6oF7J4sYD1eZyQXF9eb5otWD41FaE/VdJxI7+cbc6zwL3bIJTsKHzumOxhSXXrV0KrewbM2Vj57ykqkgt6RE2R+BbmOScIOtGGuXx/lkHZS9mzSi5d/PyIuJ1eKLHi+piOSstERcDtaLWfhf0rNZ+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yYIRjM6z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=POgSPXe2wERoUyH9SGM6W44oGLTS7okUmySDt/aNSqg=;
	t=1757407627; x=1758617227; b=yYIRjM6zmmgfYe7XUYMoQLO+diqhklLR7TdlJFZv0GkJCDE
	bg6JIxWW2G7YSfZPP/EenINzE8Wq0lA27+u8T9QVY6LagBhiQtJrZBg8MeU85/DRyEE7hils/gse8
	rJho2qH4l1r+WAKBMfAAfEspX4Yr3ZYSjK+cJij6HxyhU1Gkw6bVNAKrQX3gdg1RaMKrcxVzF0/gp
	//5jiOBCn9Rqc9bsG87s940vVZx9RhaevKYmgQ+HILKKHeEapyr4HiMBsBs4UhyBeDOEvE0twIum9
	Asj+zAuXg2RAZL5Tp7KM//bcYS7vmxDUqPrfZI1hDXnYtjdKFw1sV23M+1sh3v4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvu0B-00000009vVX-1AEP;
	Tue, 09 Sep 2025 10:46:59 +0200
Message-ID: <8d4d59375d86747b8bace9a1a4b443d7238b5553.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 1/3] wifi: cfg80211: correctly implement and
 validate S1G chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com, Andrew Pope
	 <andrew.pope@morsemicro.com>
Date: Tue, 09 Sep 2025 10:46:58 +0200
In-Reply-To: <20250909080758.1004956-2-lachlan.hodges@morsemicro.com> (sfid-20250909_100814_599104_F3481DDC)
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
	 <20250909080758.1004956-2-lachlan.hodges@morsemicro.com>
	 (sfid-20250909_100814_599104_F3481DDC)
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
> +++ b/include/net/cfg80211.h
> @@ -101,15 +101,11 @@ struct wiphy;
>   * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
>   *	on this channel.
>   * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
> - * @IEEE80211_CHAN_1MHZ: 1 MHz bandwidth is permitted
> + * @IEEE80211_CHAN_NO_4MHZ: 4 MHz bandwidth is not permitted
>   *	on this channel.
> - * @IEEE80211_CHAN_2MHZ: 2 MHz bandwidth is permitted
> + * @IEEE80211_CHAN_NO_8MHZ: 8 MHz bandwidth is not permitted
>   *	on this channel.
> - * @IEEE80211_CHAN_4MHZ: 4 MHz bandwidth is permitted
> - *	on this channel.
> - * @IEEE80211_CHAN_8MHZ: 8 MHz bandwidth is permitted
> - *	on this channel.
> - * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
> + * @IEEE80211_CHAN_NO_16MHZ: 16 MHz bandwidth is permitted
>   *	on this channel.
>   * @IEEE80211_CHAN_NO_320MHZ: If the driver supports 320 MHz on the band=
,
>   *	this flag indicates that a 320 MHz channel cannot use this
> @@ -129,6 +125,10 @@ struct wiphy;
>   *	with very low power (VLP), even if otherwise set to NO_IR.
>   * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow activity on a 20 MHz chan=
nel,
>   *	even if otherwise set to NO_IR.
> + * @IEEE80211_CHAN_S1G_NO_PRIMARY: Prevents the channel for use as an S1=
G
> + *	primary channel. Does not prevent the wider operating channel
> + *	described by the chandef from being used. In order for a 2MHz primary
> + *	to be used, both 1MHz subchannels shall not contain this flag.
>   */
>  enum ieee80211_channel_flags {
>  	IEEE80211_CHAN_DISABLED			=3D BIT(0),
> @@ -145,11 +145,9 @@ enum ieee80211_channel_flags {
>  	IEEE80211_CHAN_NO_20MHZ			=3D BIT(11),
>  	IEEE80211_CHAN_NO_10MHZ			=3D BIT(12),
>  	IEEE80211_CHAN_NO_HE			=3D BIT(13),
> -	IEEE80211_CHAN_1MHZ			=3D BIT(14),
> -	IEEE80211_CHAN_2MHZ			=3D BIT(15),
> -	IEEE80211_CHAN_4MHZ			=3D BIT(16),
> -	IEEE80211_CHAN_8MHZ			=3D BIT(17),
> -	IEEE80211_CHAN_16MHZ			=3D BIT(18),
> +	IEEE80211_CHAN_NO_4MHZ			=3D BIT(16),
> +	IEEE80211_CHAN_NO_8MHZ			=3D BIT(17),
> +	IEEE80211_CHAN_NO_16MHZ			=3D BIT(18),
>  	IEEE80211_CHAN_NO_320MHZ		=3D BIT(19),
>  	IEEE80211_CHAN_NO_EHT			=3D BIT(20),
>  	IEEE80211_CHAN_DFS_CONCURRENT		=3D BIT(21),
> @@ -158,6 +156,7 @@ enum ieee80211_channel_flags {
>  	IEEE80211_CHAN_CAN_MONITOR		=3D BIT(24),
>  	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	=3D BIT(25),
>  	IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY     =3D BIT(26),
> +	IEEE80211_CHAN_S1G_NO_PRIMARY		=3D BIT(27),

This is fine, and you could even reuse BIT(14) for the S1G_NO_PRIMARY
flag.

But ...

> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
...

> @@ -4365,15 +4370,11 @@ enum nl80211_wmm_rule {
>   * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this ch=
annel
>   *	in current regulatory domain.
>   * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
> - * @NL80211_FREQUENCY_ATTR_1MHZ: 1 MHz operation is allowed
> - *	on this channel in current regulatory domain.
> - * @NL80211_FREQUENCY_ATTR_2MHZ: 2 MHz operation is allowed
> - *	on this channel in current regulatory domain.
> - * @NL80211_FREQUENCY_ATTR_4MHZ: 4 MHz operation is allowed
> + * @NL80211_FREQUENCY_ATTR_NO_4MHZ: 4 MHz operation is not allowed
>   *	on this channel in current regulatory domain.
> - * @NL80211_FREQUENCY_ATTR_8MHZ: 8 MHz operation is allowed
> + * @NL80211_FREQUENCY_ATTR_NO_8MHZ: 8 MHz operation is not allowed
>   *	on this channel in current regulatory domain.
> - * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
> + * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed
>   *	on this channel in current regulatory domain.
>   * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this cha=
nnel
>   *	as the primary or any of the secondary channels isn't possible
> @@ -4427,11 +4428,9 @@ enum nl80211_frequency_attr {
>  	NL80211_FREQUENCY_ATTR_WMM,
>  	NL80211_FREQUENCY_ATTR_NO_HE,
>  	NL80211_FREQUENCY_ATTR_OFFSET,
> -	NL80211_FREQUENCY_ATTR_1MHZ,
> -	NL80211_FREQUENCY_ATTR_2MHZ,
> -	NL80211_FREQUENCY_ATTR_4MHZ,
> -	NL80211_FREQUENCY_ATTR_8MHZ,
> -	NL80211_FREQUENCY_ATTR_16MHZ,
> +	NL80211_FREQUENCY_ATTR_NO_4MHZ,
> +	NL80211_FREQUENCY_ATTR_NO_8MHZ,
> +	NL80211_FREQUENCY_ATTR_NO_16MHZ,
>  	NL80211_FREQUENCY_ATTR_NO_320MHZ,
>  	NL80211_FREQUENCY_ATTR_NO_EHT,
>  	NL80211_FREQUENCY_ATTR_PSD,

This you can't do, you have to keep the old attributes for API/ABI
purposes and add new ones at the end for the new settings.

We probably don't need/want to translate the 8MHZ to !NO_8MHZ, I'm not
sure the 1/2/4/8/16 ever even made sense at all so I'm not worried about
that, but we can't renumber any  of these (to keep a stable ABI) and/or
take away constant names (to keep the API.)

> +	for_each_s1g_subchan(chandef, freq_khz)
> +	{

nit: { should be on the end of line for loops/conditions

> +		chan =3D ieee80211_get_channel_khz(wiphy, freq_khz);
> +		if (!chan || (chan->flags & prohibited_flags))
> +			return false;
> +	}
> +
> +	if (chandef->s1g_primary_2mhz) {
> +		sibling =3D cfg80211_s1g_get_primary_sibling(wiphy, chandef);

also nit: you could move some variables into this scope

> +		if (attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ])
> +			chandef->s1g_primary_2mhz =3D nla_get_flag(
> +				attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ]);

Now seeing this and looking back - I think you need additional
validation in cfg80211_chandef_valid() to make sure that
s1g_primary_2mhz is _not_ set in the !S1G case?


> +++ b/net/wireless/util.c
> @@ -109,27 +109,7 @@ EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
>  enum nl80211_chan_width
>  ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
>  {
> -	if (WARN_ON(!chan || chan->band !=3D NL80211_BAND_S1GHZ))
> -		return NL80211_CHAN_WIDTH_20_NOHT;
> -
> -	/*S1G defines a single allowed channel width per channel.
> -	 * Extract that width here.
> -	 */
> -	if (chan->flags & IEEE80211_CHAN_1MHZ)
> -		return NL80211_CHAN_WIDTH_1;
> -	else if (chan->flags & IEEE80211_CHAN_2MHZ)
> -		return NL80211_CHAN_WIDTH_2;
> -	else if (chan->flags & IEEE80211_CHAN_4MHZ)
> -		return NL80211_CHAN_WIDTH_4;
> -	else if (chan->flags & IEEE80211_CHAN_8MHZ)
> -		return NL80211_CHAN_WIDTH_8;
> -	else if (chan->flags & IEEE80211_CHAN_16MHZ)
> -		return NL80211_CHAN_WIDTH_16;
> -
> -	pr_err("unknown channel width for channel at %dKHz?\n",
> -	       ieee80211_channel_to_khz(chan));
> -
> -	return NL80211_CHAN_WIDTH_1;
> +	return NL80211_CHAN_WIDTH_20_NOHT;
>  }
>  EXPORT_SYMBOL(ieee80211_s1g_channel_width);

Wait, what? Maybe you just want to remove this API?

johannes

