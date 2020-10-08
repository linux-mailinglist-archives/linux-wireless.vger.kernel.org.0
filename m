Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EE2870D0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgJHIh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHIh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 04:37:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D736C061755
        for <linux-wireless@vger.kernel.org>; Thu,  8 Oct 2020 01:37:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQRQS-001UUN-MQ; Thu, 08 Oct 2020 10:37:24 +0200
Message-ID: <961b6dc93de57cc292f30741bf6d9d7190a9de0a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] mac80211: handle lack of sband->bitrates in rates
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 08 Oct 2020 10:37:13 +0200
In-Reply-To: <20201005164522.18069-1-thomas@adapt-ip.com>
References: <20201005164522.18069-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-10-05 at 09:45 -0700, Thomas Pedersen wrote:
> Even though a driver or mac80211 shouldn't produce a
> legacy bitrate if sband->bitrates doesn't exist, don't
> crash if that is the case either.
> 
> This fixes a kernel panic if station dump is run before
> last_rate can be updated with a data frame when
> sband->bitrates is missing (eg. in S1G bands).
> 
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
> 
> ---
> 
> v2:
>   WARN_ON -> WARN_ON_ONCE (Ben)
> ---
>  net/mac80211/cfg.c      | 3 ++-
>  net/mac80211/sta_info.c | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index da70f174d629..eb52aafd9381 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -709,7 +709,8 @@ void sta_set_rate_info_tx(struct sta_info *sta,
>  		u16 brate;
>  
>  		sband = ieee80211_get_sband(sta->sdata);
> -		if (sband) {
> +		WARN_ON_ONCE(sband && !sband->bitrates);
> +		if (sband && sband->bitrates) {
>  			brate = sband->bitrates[rate->idx].bitrate;
>  			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
>  		}
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index f2840d1d95cf..fb4f2b9b294f 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2122,6 +2122,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
>  		int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);
>  
>  		sband = local->hw.wiphy->bands[band];
> +
> +		if (WARN_ON_ONCE(!sband->bitrates))
> +			break;
> +

Given the premise described in the commit message, neither of these
really seem right - why would we want to trigger a WARN_ON(_ONCE) if
userspace requests the information that early? Should be silent IMHO?

johannes

