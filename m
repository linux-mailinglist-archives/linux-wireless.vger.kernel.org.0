Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0A287131
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgJHJGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgJHJGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 05:06:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E20EC061755
        for <linux-wireless@vger.kernel.org>; Thu,  8 Oct 2020 02:06:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQRsw-001VGL-Tr; Thu, 08 Oct 2020 11:06:51 +0200
Message-ID: <e5b99d2b7215841b184ddcec5ca8498f27795547.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: add support to configure HE MCS for beacon
 rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Oct 2020 11:06:49 +0200
In-Reply-To: <1601762257-14934-1-git-send-email-rmanohar@codeaurora.org>
References: <1601762257-14934-1-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-10-03 at 14:57 -0700, Rajkumar Manoharan wrote:
> This allows an option to configure a single HE MCS beacon tx rate.
> 
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> ---
> v2: clear mcs ratemask when beacon tx rate is not set.

I can't believe I didn't realize this before, but ...

> @@ -4672,14 +4673,20 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>  					nla_len(tb[NL80211_TXRATE_HT]),
>  					mask->control[band].ht_mcs))
>  				return -EINVAL;
> -		}
> +		} else if (is_beacon_tx_rate)
> +			memset(&mask->control[band].ht_mcs, 0,
> +			       sizeof(mask->control[band].ht_mcs));

I think this is a bit strange?

I mean, why not just skip the

        /* Default to all rates enabled */
        for (i = 0; i < NUM_NL80211_BANDS; i++) {
		[...]
	}

code? Right now you're first setting it, and then clearing it again when
is_beacon_tx_rate is set ...


I'd prefer a "default_all_enabled" parameter, and then call the above
loop conditionally on it (perhaps moving it to a separate function to
not have all the deep indentation to worry about).

johannes

