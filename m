Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2501C461C9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFNO5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:57:01 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43252 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfFNO5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:57:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbndN-0003Ic-Ll; Fri, 14 Jun 2019 16:56:53 +0200
Message-ID: <e8343919c6851e6b5a7905b708661870c4c88481.camel@sipsolutions.net>
Subject: Re: [PATCH-v3 1/2] wireless: Support assoc-at-ms timer in sta-info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 16:56:52 +0200
In-Reply-To: <3ad69c55-2b88-a96b-d21e-99f4418466ee@candelatech.com>
References: <20190415172123.6532-1-greearb@candelatech.com>
         <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
         <3ad69c55-2b88-a96b-d21e-99f4418466ee@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 07:46 -0700, Ben Greear wrote:
> 
> The point of my patch was to allow 'iw' to return a more precise time
> that the station has been associated, so I am not sure that BOOTIME is
> a good thing to use for that?

Depends what you want, really.

> +       if (sinfo[NL80211_STA_INFO_ASSOC_AT_MS])
> +               printf("\n\tassociated at:\t%llu ms",
> +                        (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_MS]));
> 
> -       printf("\n");
> +       printf("\n\tcurrent time:\t%llu ms\n", now_ms);

Since you just print the time in milliseconds, and the current time in
milliseconds, you don't even really have any value in the wall clock.
Quite the opposite - this lends itself to subtracting to try to figure
out how long it was associated, which is the completely wrong thing to
do with wall clock - timezone adjustment could've happened inbetween,
for example!

I really see no point in trying to give the wall clock at assoc time. If
no timezone adjustment happened, you can just as well give the boottime
and have the userspace figure out the wall clock. If timezone adjustment
happened, then any calculations are wrong anyway, what would the point
be?

johannes

