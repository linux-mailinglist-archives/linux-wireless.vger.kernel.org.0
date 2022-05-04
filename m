Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0045F519D5F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiEDK4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiEDK4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 06:56:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B523BE7
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Byyfgh5KdoOe2K/Vk4t02yiPv5F+2XzxdiCVEHZvgvs=;
        t=1651661594; x=1652871194; b=i18YfV82hqK4nfYtjduPPoz661Q6gOQfW741CglqozpNp/2
        dYzDSm8eGmh3nY1xWb6ANp9QdTcdUsMMUzYauBOyWrzS62+r/X9HOudUtqH8uNWm0TVmhjyXp7huk
        59P28gwW8Z+JRdSpdQ78A4PV1hM+7b2iykH5NhUWH9TToJxxcI1GCHmpO22a9mGdkl86YSAw1LitK
        GTlMQwSgytUEhk03rxsdDT1UBxMJ7jLrKlu4Wcq+Yjq0YWb9zvj0FAdSIrCG1QaNWtaAGK5J9sd0L
        l/idtAb37a65mUDESBI5yMqkWrBFfvNOz2G0C+MS8Ozu+KkdD0iNhVZMfWKjggzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmCd6-0020e3-Cs;
        Wed, 04 May 2022 12:53:12 +0200
Message-ID: <b11b11c0dab8e4eb527bba7b332287efe0bc2cbc.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211:  Allow drivers to report avg chain signal.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 12:53:11 +0200
In-Reply-To: <20220225232842.32028-1-greearb@candelatech.com>
References: <20220225232842.32028-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-25 at 15:28 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Drivers that use RSS cannot get the avg signal from mac80211.
> So allow drivers to report the avg chain signal while letting
> mac80211 take care of the last chain signal.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/sta_info.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index 43a58b30c6a4..00836f587b6d 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2543,6 +2543,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>  	if (last_rxstats->chains &&
>  	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
>  			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
> +		/* Neither chain signal nor chain signal avg is filled */
>  		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);

I don't think that comment adds value, in fact, since it's _after_ the
condition it applies to (rather than before), it's confusing? At least
to me it was ... And if you read the condition that already says so
pretty clearly anyway.

> @@ -2557,6 +2558,21 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>  		}
>  	}
>  
> +	/* Check if chain signal is not filled, for cases avg was filled by
> +	 * driver bug last chain signal was not.
> +	 */
> +	if (last_rxstats->chains &&
> +		 !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)))) {
> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
> +
> +		sinfo->chains = last_rxstats->chains;
> +
> +		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
> +			sinfo->chain_signal[i] =
> +				last_rxstats->chain_signal_last[i];
> +		}
> +	}
> 

Now you've duplicated this code ... you can remove it above, no?

(Also code style is off wrt. indentation and braces, I feel like I'm
telling you that or fixing such things on every other patch, please take
a little more care before sending patches upstream, you can even run
checkpatch.)

johannes
