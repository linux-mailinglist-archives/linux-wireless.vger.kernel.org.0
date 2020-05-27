Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D8E1E450D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgE0OAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgE0OAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:00:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FAC08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:00:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdwbr-0048ZD-8z; Wed, 27 May 2020 16:00:43 +0200
Message-ID: <bf0f6c17c188901477c1d6aa61aab6143c4ac635.camel@sipsolutions.net>
Subject: Re: [PATCH v3 02/11] cfg80211: handle 6 GHz capability of new
 station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:00:42 +0200
In-Reply-To: <1589399105-25472-2-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-2-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
> Handle 6 GHz HE capability while adding new station. It will be used
> later in mac80211 station processing.

This doesn't compile without the next patch.

> +       const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;

This we made just an __le16, any particular reason to have the struct?
It does need to be a pointer for the "no changes" case, but the struct
seems a bit overkill?

> + * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
> + *	association request when used with NL80211_CMD_NEW_STATION).

That we have pretty much identically.

> @@ -2998,6 +3003,7 @@ enum nl80211_attrs {
>  #define NL80211_HE_MAX_CAPABILITY_LEN           54
>  #define NL80211_MAX_NR_CIPHER_SUITES		5
>  #define NL80211_MAX_NR_AKM_SUITES		2
> +#define NL80211_HE_6GHZ_CAPABILITY_LEN		2

This not, we defined it just to be a U16.

> +	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
> +		.type = NLA_EXACT_LEN,
> +		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
> +	},

This no longer exists, but I guess I'll just take our patch for the U16
here.
 
> +	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
> +	if (params.he_6ghz_capa && (params.ht_capa || params.vht_capa))
> +		return -EINVAL;

Not sure this makes much sense? We can only check what's being set at
the same time, so multiple calls here would still be possible ...
doesn't hurt much though.

We didn't have this check, and have one additional check:

@@ -6170,7 +6200,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
                params.vht_capa = NULL;
 
                /* HE requires WME */
-               if (params.he_capa_len)
+               if (params.he_capa_len || params.he_6ghz_capa)
                        return -EINVAL;
        }
 

johannes

