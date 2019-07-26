Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA8764D9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfGZLtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 07:49:01 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47848 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGZLtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 07:49:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqyiZ-0002CG-S9; Fri, 26 Jul 2019 13:48:59 +0200
Message-ID: <046b22fb9c4784351c36e29d0a3b8a1e0097d264.camel@sipsolutions.net>
Subject: Re: [PATCH V3 2/2] mac80211: allow setting spatial reuse parameters
 from bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Date:   Fri, 26 Jul 2019 13:48:57 +0200
In-Reply-To: <20190618061915.7102-3-john@phrozen.org>
References: <20190618061915.7102-1-john@phrozen.org>
         <20190618061915.7102-3-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-18 at 08:19 +0200, John Crispin wrote:
> Store the OBSS PD parameters inside bss_conf when bringing up an AP and/or
> when a station connects to an AP. This allows the driver to configure the
> HW accordingly.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/cfg80211.h       | 15 +++++++++++++
>  include/net/mac80211.h       |  4 ++++
>  include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++
>  net/mac80211/cfg.c           |  5 ++++-
>  net/mac80211/he.c            | 24 ++++++++++++++++++++
>  net/mac80211/ieee80211_i.h   |  3 +++
>  net/mac80211/mlme.c          |  1 +
>  net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
>  8 files changed, 121 insertions(+), 1 deletion(-)

Not sure if I missed this before, but in any case please split between
cfg80211 and mac80211 for all but the most trivial patches.

> +/**
> + * enum nl80211_he_spr - spatial reuse attributes

bad copy/paste? :)

> + * @__NL80211_HE_OBSS_PD_ATTR_INVALID: Invalid
> + *
> + * @NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET: the OBSS PD minimum tx power offset.
> + * @NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET: the OBSS PD maximum tx power offset.
> + *
> + * @__NL80211_HE_OBSS_PD_ATTR_LAST: Internal
> + * @NL80211_HE_OBSS_PD_ATTR_MAX: highest spiatl reuse attribute.

typo & wrong anyway, OBSS PD not SPR

> + */

Those prefixes are a bit confusing - IMHO they should all be
NL80211_HE_OBSS_PD_ATTR_*, NL80211_ATTR_* is mostly (except for a few
historical bugs) the top-level attributes.


> +enum nl80211_he_spr_attributes {

here also

> +	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
> +	       sizeof(struct ieee80211_he_obss_pd));

just use struct assignment

	blabla.he_obss_pd = params->he_obss_pd;


> +	[NL80211_ATTR_HE_OBSS_PD] = { .type = NLA_NESTED },

please use NLA_POLICY_NESTED() (requires putting the below policy above
this point)
 
> +static const struct nla_policy
> +			he_spr_policy[NL80211_HE_OBSS_PD_ATTR_MAX + 1] = {

I guess I'd lose all the tabs here but don't really care that much.

> +	[NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET] = { .type = NLA_U32 },
> +	[NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET] = { .type = NLA_U32 },

That can't be right, they go into u8 eventually, no? Use NLA_U8 or maybe
even NLA_POLICY_RANGE().

Also in the struct ieee80211_he_obss_pd you have u32 for no real reason?

In the element in the frame you only used a single u8.

> +	if (!tb[NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET] ||
> +	    !tb[NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET])
> +		return -EINVAL;

> +	if (he_obss_pd->min_offset >= he_obss_pd->max_offset)
> +		return -EINVAL;

Maybe add some extack error messages for this.

johannes

