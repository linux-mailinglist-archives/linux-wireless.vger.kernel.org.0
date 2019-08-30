Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D503DA3099
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfH3HRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 03:17:02 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59608 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfH3HRC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 03:17:02 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3b9Y-0008HG-1K; Fri, 30 Aug 2019 09:17:00 +0200
Message-ID: <94e4db96eb0602dd795cbbc171a7a3b7383a0b37.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Add new helper function for channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
Date:   Fri, 30 Aug 2019 09:16:59 +0200
In-Reply-To: <1567115381-7831-1-git-send-email-asinghal@codeaurora.org>
References: <1567115381-7831-1-git-send-email-asinghal@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-29 at 14:49 -0700, Amar Singhal wrote:
> Add new helper function to convert (chan_number, oper_class) pair to
> frequency. Call this function ieee80211_channel_op_class_to_frequency.
> This function would be very useful in the context of 6 GHz channels,
> where channel number is not unique.

Nit: it is unique within 6 GHz, just not within the overall channel
number space, and that was actually already not unique before, it just
didn't matter much to us :-)

I may reword that when I apply it.

> Signed-off-by: Amar Singhal <asinghal@codeaurora.org>
> ---
>  include/net/cfg80211.h | 10 ++++++++++
>  net/wireless/util.c    | 23 +++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 6467b60..decafba 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4914,1 +4914,1 @@ static inline void *wdev_priv(struct wireless_dev *wdev)
>  int ieee80211_channel_to_frequency(int chan, enum nl80211_band band);
> 
>  /**
> + * ieee80211_channel_op_class_to_frequency - convert
> + * (channel, operating class) to frequency

That's formatted badly, the short description must fit on one line.

> +	if (global_op_class >= 131 && global_op_class <= 135)
> +		return (5940 + 5 * chan_num);
> +	else if (global_op_class >= 115 && global_op_class <= 130)
> +		return (5000 + 5 * chan_num);
> +	else if (global_op_class >= 112 && global_op_class <= 113)
> +		return (5000 + 5 * chan_num);
> +	else if (global_op_class >= 109 && global_op_class <= 110)
> +		return (4000 + 5 * chan_num);
> +	else if (global_op_class >= 83 && global_op_class <= 84)
> +		return (2407 + 5 * chan_num);
> +	else if (global_op_class == 81)
> +		return (2407 + 5 * chan_num);
> +	else if (global_op_class == 82)
> +		return (2414 + 5 * chan_num);
> +	else if (global_op_class == 180)
> +		return (56160 + 5 * chan_num);

I think it would be good to have a list of valid channel numbers for
them as well. I was wondering about 82 for a second there for example,
until I looked up again that it is just for channel 14.

I think this is also missing 83/84 and various other operating classes
for wider channels. Perhaps in those we don't really need to check the
channel numbers precisely, i.e. we could probably treat 81/83/84 all the
same.

But depending on what you feed to the function, it's possible that you
could encounter those other operating classes.

johannes

