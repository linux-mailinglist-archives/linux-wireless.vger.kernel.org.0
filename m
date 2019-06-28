Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE859E08
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1OjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 10:39:16 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:52628 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfF1OjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 10:39:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgs1y-0003h1-4m; Fri, 28 Jun 2019 16:39:14 +0200
Message-ID: <7c8b3493cd2c48beae5a12e23964c8d3ca181d04.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: fix duplicated scan entries after channel
 switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 28 Jun 2019 16:39:12 +0200
In-Reply-To: <20190613112128.834-1-sergey.matyukevich.os@quantenna.com>
References: <20190613112128.834-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-13 at 11:21 +0000, Sergey Matyukevich wrote:
> When associated BSS completes channel switch procedure, its channel record
> needs to be updated. The existing mac80211 solution was extended to
> cfg80211 in commit 5dc8cdce1d72 ("mac80211/cfg80211: update bss
> channel on channel switch")
> 
> However this solution appears to be incomplete as it may lead to
> duplicated scan entries for associated BSS after channel switch.
> The root cause of the problem is as follows. Each BSS entry is
> included into the following data structures:
> - bss list rdev->bss_list
> - bss search tree rdev->bss_tree
> Updating BSS channel record without rebuilding bss_tree may break
> tree search since cmp_bss considers all of the following: channel,
> bssid, ssid. When BSS channel is updated, but its location in bss_tree
> is not updated, then subsequent search operations may fail to locate
> this BSS since they will be traversing bss_tree in wrong direction.
> As a result, for scan performed after associated BSS channel switch,
> cfg80211_bss_update may add the second entry for the same BSS to both
> bss_list and bss_tree, rather then update the existing one.
> 
> To summarize, if BSS channel needs to be updated, then bss_tree should
> be rebuilt in order to put updated BSS entry into a proper location.

Good catch!

> This commit suggests the following straightforward solution:
> - if new entry has been already created for BSS after channel switch,
>   then remove it completely

Shouldn't we prefer the new entry?

OTOH, the old entry will likely have a "hold", so it doesn't get removed
while we're connected ... and the driver etc. might be referencing it.
So I guess the old entry should be updated with info from the newer one?

> Finally, next scan operation will find BSS entry in expected location
> in rb_tree. So all the IEs, including HT/VHT operation IEs,
> will be properly updated.

Right. Although if it was there before, then it already has been updated
in a sense... But I guess it's a corner case to even get there?

> 1. Tested using iwlwifi and qtnfmac drivers, looks good

Great.

> 2. Alternative approach: remove old BSS entry and keep new a one
> This approach may have certain benefits for mac80211 drivers.
> For instance, in this case HT/VHT operation IEs are going to be
> valid from the start, no need to wait for the next scan.

> However the following procedure for replacing current_bss, protected
> by wdev->mtx and rdev->bss_lock locks, seems to be insufficient:
> 
>   bss_ref_get(rdev, new);
>   cfg80211_hold_bss(new);
>   wdev->current_bss = new;
> 
>   cfg80211_unhold_bss(old);
>   bss_ref_put(rdev, old);
>   __cfg80211_unlink_bss(rdev, old);
> 
> When testing this alternative approach using iwlwifi driver,
> occasional general protection fault crashes have been observed
> on ieee80211_rx_mgmt_beacon/ieee80211_bss_info_update code paths.
> So far I haven't yet root caused them.

At the very least you'd also have to update ifmgd->associated in
mac80211, and that's basically not really possible? Well, I guess we
could change the channel switch API to return the new one or something.

I guess the better thing would be to go update the old entry with the
new one's data, before killing the new one.

Not sure it's worth the extra complexity though.

johannes

