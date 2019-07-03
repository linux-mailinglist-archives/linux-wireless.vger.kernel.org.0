Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743A75E598
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCNiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 09:38:19 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38364 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 09:38:19 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hifSj-0000UO-7A; Wed, 03 Jul 2019 15:38:17 +0200
Message-ID: <d60d2376e2feb4d0debe4c537dff2263a4b661e5.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Wed, 03 Jul 2019 15:38:15 +0200
In-Reply-To: <20190703122829.2454-1-sergey.matyukevich.os@quantenna.com>
References: <20190703122829.2454-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-03 at 12:28 +0000, Sergey Matyukevich wrote:
> When associated BSS completes channel switch procedure, its channel
> record needs to be updated. The existing mac80211 solution was
> extended to cfg80211 in commit 5dc8cdce1d72 ("mac80211/cfg80211:
> update bss channel on channel switch")
> 
> However that solution still appears to be incomplete as it may lead
> to duplicated scan entries for associated BSS after channel switch.
> The root cause of the problem is as follows. Each BSS entry is
> included into the following data structures:
> - bss list rdev->bss_list
> - bss search tree rdev->bss_tree
> Updating BSS channel record without rebuilding bss_tree may break
> tree search since cmp_bss considers all of the following: channel,
> bssid, ssid. When BSS channel is updated, but its location in bss_tree
> is not updated, then subsequent search operations may fail to locate
> this BSS. As a result, for scan performed after associated BSS channel
> switch, cfg80211_bss_update may add the second entry for the same BSS
> to both bss_list and bss_tree, rather then update the existing one.
> 
> To summarize, if BSS channel needs to be updated, then bss_tree should
> be rebuilt in order to put updated BSS entry into a proper location.
> 
> This commit suggests the following straightforward solution:
> - if new entry has been already created for BSS after channel switch,
>   then use its IEs to update known BSS entry and then remove new
>   entry completely
> - use rb_erase/rb_insert_bss reinstall updated BSS in bss_tree
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> 
> ---
> 
> v1 -> v2
> - use IEs of new BSS entry to update known BSS entry
>   for this purpose extract BSS update code from cfg80211_bss_update
>   into a separate function cfg80211_update_known_bss
> 
> Tested on both iwlwifi and qtnfmac.

Looks good to me, a few nitpicks below.

> From my perspective, primary reason for RFC tag is nontrans_list bss handling.
> I am not sure whether nontrans_bss should be removed for new entry or not.
> The approach varies between cfg80211 API functions. For instance,
> cfg80211_unlink_bss removes them, while cfg80211_bss_expire does not.
> I would appreciate any comments in this regard.

Hmm. Good question. Ideally, if we detect CSA on any of them, we'd move
*all* of the nontrans BSSes and their transmitting BSS? Because really
that's what must happen, since a non-transmitting BSS cannot change
channel without its transmitting BSS, and vice versa.

Btw, I think expire would also remove them, since they all should always
have the same timestamp? Actually, they don't, if we jiffies changed
while we updated ... I guess we should fix that.

https://p.sipsolutions.net/09da5943735d7983.txt


>  	if (wdev->iftype == NL80211_IFTYPE_STATION &&
> -	    !WARN_ON(!wdev->current_bss))
> -		wdev->current_bss->pub.channel = chandef->chan;
> +	    !WARN_ON(!wdev->current_bss)) {
> +		cfg80211_update_assoc_bss_entry(wdev, chandef->chan);
> +	}

don't really need the braces, I suppose you previously had more code
here and refactored it? :)

> +static bool
> +cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
> +			  struct cfg80211_internal_bss *known,
> +			  struct cfg80211_internal_bss *new,
> +			  bool signal_valid)

Maybe split out this refactoring to a separate patch, or at least add a
small statement to the commit log saying that it's just broken out of
the function.

> +void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
> +				     struct ieee80211_channel *chan)
> +{
> 
[...]

> +	cbss->pub.channel = chan;
> +	cbss->ts = jiffies;

Not entirely sure we should set the timestamp here, you're going to have
an interesting situation where if you have a "new" entry found in the
loop below, you would actually have a *lower* timestamp?

Then again, we surely know that we still have valid data now, so I guess
that's fine. Doesn't matter that much anyway.

So yeah, looks fine to me.

johannes

