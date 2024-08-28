Return-Path: <linux-wireless+bounces-12152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700629624AF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E224285E7D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A916A934;
	Wed, 28 Aug 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u1SZGUK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76D166F3A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840481; cv=none; b=btBe39bjm4xLHoZctsUwHPSQ8sK5EPWZkSvbtWg7OoLeM7+nPrViL7xqrFwwmvDFB/JLv3uvmno1Kf21G5kOroH6Fq8kTN8K0dLl1Fy4wwwsVt2auHNyBbjE/B9OUZ11ALfP2xv832LtlkDZeyZ9GCJYCBFYzxzJPF5X7F/wNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840481; c=relaxed/simple;
	bh=mYcgzghzmsUgmnhSFtlsrOG8bCl8Pns+pxXhyI4HHuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p747QjmBkD7Xqmas2MTeLpi5Kbc1AixqXdvUKVbETboSDwV+4/1rsJ1jwiRcLelNtHBaGsx4S1nMP7j5a+ok4vUiFaWktC3C2mM7SlFHVg/oBZqH+c+44Tu1XIiPG5BXjCaZPfOUIZOhz1tqlKLYQMZLrCythRPtKL3JulDaNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u1SZGUK9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zMeG3LV1wRFPeX/MYE54BMbd2ZfvJ9vGfcFeHpdRbXU=;
	t=1724840479; x=1726050079; b=u1SZGUK9kqNXmT07MEgVmd+7m1QAOb0CNrrhc9M440/vPAE
	Y9Y/+12cc3dcBwrWsLaHGIZp5h7JU8maLlTD1+kQSeIW5FyuaOUFT/8JZrpe1nkOuDen3vDCGy0Xv
	Vtj5gflgmtJnGe+rtpUi1Ae7H4AysCr8sZX7KjzFmvkrUlI6NhCgw6V1W8TRtFhqcigo47eg5HSEA
	gDdxWjLUwum3k8tDBKPeIBr9Rwh+0LaCZgh/prYqKV6hYm4MEqH3J71Jtj2FGOTX5tlO1tLcbDWzC
	7UN9qDkbJmI+dt6AzSUOk2xMmeaNop2eaLj3CWSNDu6BeaEPdGR/q3DEn19snVlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjFng-00000006wYE-0t7s;
	Wed, 28 Aug 2024 12:21:16 +0200
Message-ID: <cfc85dc7bf175cc4237d9d1423b0101b9162f727.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: skip regulatory checks when the channel
 is punctured
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_mpaluri@quicinc.com, Aditya Kumar
 Singh <quic_adisi@quicinc.com>
Date: Wed, 28 Aug 2024 12:21:14 +0200
In-Reply-To: <20240826123341.5405-1-quic_kkavita@quicinc.com>
References: <20240826123341.5405-1-quic_kkavita@quicinc.com>
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

On Mon, 2024-08-26 at 18:03 +0530, Kavita Kavita wrote:
> The kernel performs several regulatory checks for AP mode in
> nl80211/cfg80211. These checks include radar detection,
> verification of whether the sub-channel is disabled, and
> an examination to determine if the channel is a DFS channel
> (both DFS usable and DFS available). These checks are
> performed across a frequency range, examining each sub-channel.
>=20
> However, these checks are also performed on frequencies that
> have been punctured, which should not be examined as they are
> not in use.

Makes sense.

> This leads to the issue where the AP stops because one of
> the 20 MHz sub-channels is disabled or radar detected on
> the channel, even when the sub-channel is punctured.

I'm curious, how did that even happen? How did it detect radar on a
punctured channel in the first place?

Or are you saying it was detected before, but you say "the AP stops"
rather than "the AP fails to start"?

However, this possibly also points to something that's missing in this
patch and/or Aditya's patchset: if we do radar detection with a chandef
that's already punctured, we don't know that all the subchannels were
actually radar-free, and shouldn't mark them accordingly.

I think it'd make sense to incorporate that here as well, could you do
that?

> @@ -781,7 +784,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy=
,
> =20
>  		ret =3D cfg80211_get_chans_dfs_required(wiphy,
>  					MHZ_TO_KHZ(chandef->center_freq2),
> -					width, iftype);
> +					width, chandef->punctured, iftype);

This isn't really right: center_freq2 is for 80+80 which cannot use
puncturing, certainly cannot use puncturing in the secondary 80. It's
probably not strictly wrong either since 80+80 cannot be legal with
puncturing in the first place, but this really should just pass 0 I'd
think.

> @@ -868,7 +877,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
>  		WARN_ON(!chandef->center_freq2);
>  		r2 =3D cfg80211_get_chans_dfs_usable(wiphy,
>  					MHZ_TO_KHZ(chandef->center_freq2),
> -					width);
> +					width, chandef->punctured);

same here

> @@ -1113,7 +1128,7 @@ static bool cfg80211_chandef_dfs_available(struct w=
iphy *wiphy,
>  		WARN_ON(!chandef->center_freq2);
>  		r =3D cfg80211_get_chans_dfs_available(wiphy,
>  					MHZ_TO_KHZ(chandef->center_freq2),
> -					width);
> +					width, chandef->punctured);

and here, obviously

> @@ -1139,6 +1155,12 @@ static unsigned int cfg80211_get_chans_dfs_cac_tim=
e(struct wiphy *wiphy,
>  		if (!c)
>  			return 0;
> =20
> +		if (punctured & 1) {
> +			punctured >>=3D 1;
> +			continue;
> +		}
> +		punctured >>=3D 1;
> +
>  		if (c->flags & IEEE80211_CHAN_DISABLED)
>  			return 0;

We have this pattern a lot! I think perhaps we should add a kind of
for_each_subchannel() macro?

Perhaps even iterate subchannels of a chandef including center_freq2,
though I'm not sure how we'd arrange that...

Something like cfg80211_wdev_on_sub_chan() also seems to need to take
puncturing into account and could be rewritten with such a helper.

#define for_each_subchannel(chandef, subchan)
  for (subchan =3D ieee80211_next_subchan(chandef, NULL);
       subchan;
       subchan =3D ieee80211_next_subchan(chandef, subchan))

or so, with ieee80211_next_subchan() containing some necessary iteration
logic?

johannes

