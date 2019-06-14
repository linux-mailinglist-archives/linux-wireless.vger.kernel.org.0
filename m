Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0621745E68
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfFNNi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 09:38:29 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42192 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfFNNi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 09:38:29 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmPM-00018i-I7; Fri, 14 Jun 2019 15:38:20 +0200
Message-ID: <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
Subject: Re: [PATCH-v3 1/2] wireless:  Support assoc-at-ms timer in sta-info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 15:38:19 +0200
In-Reply-To: <20190415172123.6532-1-greearb@candelatech.com> (sfid-20190415_192129_410858_A3814220)
References: <20190415172123.6532-1-greearb@candelatech.com>
         (sfid-20190415_192129_410858_A3814220)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-04-15 at 10:21 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Report time stamp of when sta became associated.

I guess that makes sense.

> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  include/net/cfg80211.h       | 2 ++
>  include/uapi/linux/nl80211.h | 2 ++
>  net/wireless/nl80211.c       | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index f49eb1464b7a..a3ad78b9d9f4 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1268,6 +1268,7 @@ struct cfg80211_tid_stats {
>   *	indicate the relevant values in this struct for them
>   * @connected_time: time(in secs) since a station is last connected
>   * @inactive_time: time since last station activity (tx/rx) in milliseconds
> + * @assoc_at_ms: time in ms of the last association

I think the "_at_ms" doesn't really make sense. "time in ms" also
doesn't make sense as documentation. I think you need to say what should
be assigned here.

Also, you're actually using ktime_get_real() for this, which again
doesn't make much sense. For exposing an absolute time, I think we're
better off with CLOCK_BOOTTIME like we use elsewhere:

 * @boottime_ns: CLOCK_BOOTTIME timestamp the frame was received at, this is
 *      needed only for beacons and probe responses that update the scan cache.


> + * @NL80211_STA_INFO_ASSOC_AT_MS: Timestamp of last association

_ASSOC_TIMESTAMP or something would make more sense too as the attribute
name, and clearly the documentation needs to spell out the semantics
here too.

johannes

