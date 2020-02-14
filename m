Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD715D44A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgBNJDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:03:42 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38960 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNJDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:03:41 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2Wst-00BCvZ-HS; Fri, 14 Feb 2020 10:03:39 +0100
Message-ID: <d6fdf3419a323bdf5008bcd51c36b92977f5b872.camel@sipsolutions.net>
Subject: Re: [PATCH V2 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
Date:   Fri, 14 Feb 2020 10:03:38 +0100
In-Reply-To: <20200204103514.18111-1-john@phrozen.org>
References: <20200204103514.18111-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-02-04 at 11:35 +0100, John Crispin wrote:
> 
> +	[NL80211_TXRATE_HE] = {
> +		.type = NLA_EXACT_LEN,
> +		.len = sizeof(struct nl80211_txrate_he),
> +	},
> +	[NL80211_TXRATE_HE_GI] =  NLA_POLICY_RANGE(NLA_U8,
> +						   NL80211_RATE_INFO_HE_GI_0_8,
> +						   NL80211_RATE_INFO_HE_GI_3_2),
> +	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
> +						   NL80211_RATE_INFO_HE_1XLTF,
> +						   NL80211_RATE_INFO_HE_4XLTF),
>  };

Thanks for this :-)

> +		if (tb[NL80211_TXRATE_HE]) {
> +			if (!he_set_mcs_mask(info, sband, nla_data(tb[NL80211_TXRATE_HE]),
> +					     mask->control[band].he_mcs))
> +				return -EINVAL;

Maybe unify these into a single condition?

if (tb[...] &&
    he_set_...
	return -EINVAL;

Seems nicer to me. Especially with the lines already being so long.

> +		}
> +		if (tb[NL80211_TXRATE_HE_GI]) {
> +			mask->control[band].he_gi =
> +				nla_get_u8(tb[NL80211_TXRATE_HE_GI]);
> +			if (mask->control[band].he_gi > NL80211_RATE_INFO_HE_GI_3_2)
> +				return -EINVAL;

This is not needed with the policy, is it?

> +		}
> +		if (tb[NL80211_TXRATE_HE_LTF]) {
> +			mask->control[band].he_ltf =
> +				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
> +			if (mask->control[band].he_ltf > NL80211_RATE_INFO_HE_4XLTF)
> +				return -EINVAL;

Same here.

>  			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
> -			      rdev->wiphy.bands[band]->vht_cap.vht_supported))
> +			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
> +			      (rdev->wiphy.bands[band]->iftype_data &&
> +			       rdev->wiphy.bands[band]->iftype_data->he_cap.has_he)))
>  				return -EINVAL;

And now we get to why I replied at all and didn't just fix it up ;-)

That can't be right, iftype_data is an array of pointers, you're
basically always taking the first one?

johannes

