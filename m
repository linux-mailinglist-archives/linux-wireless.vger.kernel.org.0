Return-Path: <linux-wireless+bounces-62-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D927F81EB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E281C22300
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06149364B7;
	Fri, 24 Nov 2023 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r7IiyQsa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75A2109
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ChbXKGnQtRkSxEuBLSc1j0RFVT/XogkIiwxkgBcli4w=;
	t=1700852316; x=1702061916; b=r7IiyQsa5Tv12AAi/NfrbCRtARVBf9/2j+9lzwb8ajZVcwt
	aUHRGK7Dekvwh+Ti0mfG0VWZrfVWI+9e3rpAOKDQM25HuHRgXOgKiPwQm/JqiK+8hJdZykUuSXZFL
	idn72H+lhI23qyNpkMkEqWy1x5NJq0FmcTsqAANTJgv3HJLuT47Nki1j1NjCHW9x8uFjnQjWgoTI6
	/cRhcTKOi5IVLJ2n55INN6m4d5A7/HPZPlcpEhKsBzx6gbpuhB9+9Ba/d+QUU0weFb1S9DATruKjE
	dpl1F5JPENPPMwhPEN0EANLR1NcHCHASODKddWPKFGKaM5fQ3RH/EL10bY/9hE5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6bNq-00000002jIJ-0KDu;
	Fri, 24 Nov 2023 19:58:34 +0100
Message-ID: <da6f058b85f91af5d4abd10bc56034f8d7811e86.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/1] wifi: nl80211: Extend del pmksa support for SAE
 and OWE security
From: Johannes Berg <johannes@sipsolutions.net>
To: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date: Fri, 24 Nov 2023 19:58:33 +0100
In-Reply-To: <ff0778a86574b552769027496f12596e2e627931.1699530774.git.vinayak.yadawad@broadcom.com>
References: 
	<ff0778a86574b552769027496f12596e2e627931.1699530774.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-09 at 18:00 +0530, Vinayak Yadawad wrote:
>=20
> +++ b/net/wireless/nl80211.c
> @@ -12183,24 +12183,37 @@ static int nl80211_setdel_pmksa(struct sk_buff =
*skb, struct genl_info *info)
> =20
>  	memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
> =20
> -	if (!info->attrs[NL80211_ATTR_PMKID])
> +	if ((info->genlhdr->cmd =3D=3D NL80211_CMD_SET_PMKSA) &&
> +	    (!info->attrs[NL80211_ATTR_PMKID]))
>  		return -EINVAL;

Maybe it'd be better to split set/del now? The code kind of looks
awkward now, don't you think?

Or split this part of the parsing depending on set or del?

> -	pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID]);
> +	if (info->attrs[NL80211_ATTR_PMKID])
> +		pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID]);
> =20
>  	if (info->attrs[NL80211_ATTR_MAC]) {
>  		pmksa.bssid =3D nla_data(info->attrs[NL80211_ATTR_MAC]);
> -	} else if (info->attrs[NL80211_ATTR_SSID] &&
> -		   info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> -		   (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
> +	} else if (info->attrs[NL80211_ATTR_SSID]) {
> +		/* SSID based pmksa flush suppported only for FILS,
> +		 * OWE/SAE OFFLOAD cases
> +		 */
> +		if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> +		    (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
>  		    info->attrs[NL80211_ATTR_PMK])) {
> +			pmksa.cache_id =3D
> +				nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
> +		} else if ((info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA) &&
> +		    (!wiphy_ext_feature_isset(
> +		    &rdev->wiphy, NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
> +		    (!wiphy_ext_feature_isset(
> +		    &rdev->wiphy,NL80211_EXT_FEATURE_OWE_OFFLOAD)))){


The indentation here is also really awful ... I'd rather go over 80
columns than break like that. But you could just have local variables
for all the feature checks too.

And if you don't split set/del, I'd recommend a variable for that too,
set at the beginning, perhaps moving the "rdev_ops" thing up? But I'm
thinking it's probably nicer to split it. See how that looks like?

> +			return -EINVAL;
> +		}
>  		pmksa.ssid =3D nla_data(info->attrs[NL80211_ATTR_SSID]);
>  		pmksa.ssid_len =3D nla_len(info->attrs[NL80211_ATTR_SSID]);
> -		pmksa.cache_id =3D
> -			nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
>  	} else {
>  		return -EINVAL;
>  	}
> +
>  	if (info->attrs[NL80211_ATTR_PMK]) {

Then again, that isn't even relevant for DEL, is it? Should we even
parse it? Does anyone want to "delete only if it's exactly this PMK"?


Also seems like this should come with some nl80211.h updates though?

johannes

