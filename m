Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194F2265A99
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgIKHgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgIKHgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 03:36:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE4C061573
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 00:36:32 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kGdba-0025tF-N9; Fri, 11 Sep 2020 09:36:22 +0200
Message-ID: <1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix radiotap header channel flag for 6GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 09:36:21 +0200
In-Reply-To: <010101747ab7b9c0-45fa1c2a-3bb5-44e8-8e6d-457cad2e9845-000000@us-west-2.amazonses.com>
References: <010101747ab7b9c0-45fa1c2a-3bb5-44e8-8e6d-457cad2e9845-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-11 at 01:11 +0000, Aloka Dixit wrote:
> Radiotap header field 'Channel flags' has '2 GHz spectrum' set to
> 'true' for 6GHz packet.
> Change it to 5GHz as there isn't a separate option available for 6GHz.
> 
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> ---
>  net/mac80211/rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 836cde516a18..a959ebf56852 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -451,7 +451,8 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
>  	else if (status->bw == RATE_INFO_BW_5)
>  		channel_flags |= IEEE80211_CHAN_QUARTER;
>  
> -	if (status->band == NL80211_BAND_5GHZ)
> +	if (status->band == NL80211_BAND_5GHZ ||
> +	    status->band == NL80211_BAND_6GHZ)
>  		channel_flags |= IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ;

I guess we should just not set any of those flags?

Not that anything even cares ... so there's no point in adding a 6GHz
flag to radiotap.

johannes

