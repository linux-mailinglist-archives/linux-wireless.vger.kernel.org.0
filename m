Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDD43A460
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhJYUX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhJYUXy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 16:23:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDAC0EC84E
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1F87+sikkubQJPygLdQF6HOpYZ2B2TtzpImTpNaIQ6Q=;
        t=1635191972; x=1636401572; b=cTiutT2H4VjUq+lZy1eGWjj0NVLgSw5Tq5G3c9br5bvuCIe
        xrgCyGKGBrU/hPMilPxpYaMdtDisKBSag8lCU51CYbvKlL8KISLWi+2rRQqc2xgZNQYPjPRWcuUrb
        s+P25EQpG2kXEUMtaE6ZuPrOshV+gbDTfEdSak3gGJy6A/tpeu4BI86XuQbqBYwIzhfDMk/p/WwaK
        h2+gZYBiD18vfzXA/l4TlHrAx4lkeKV7UUxEXb/2Y4SPkHBvrTpPmesQ1rG6oLE/cOD3paMy68WF8
        b7WYPOvkXy4acTFPr6bFraFPxjsSg5fL/7TJ1GD6tuf4hCRshWdU3LL92PC0b3uA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mf681-006qIl-Ak;
        Mon, 25 Oct 2021 21:59:29 +0200
Message-ID: <9de7dbefe3cf0682fd28e5f4c42324e6a58ce508.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/3] nl80211: Extended ROC support for 40-80 MHz
 bandwidth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     P Praneesh <ppranees@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Date:   Mon, 25 Oct 2021 21:59:28 +0200
In-Reply-To: <1634906227-22028-2-git-send-email-ppranees@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
         <1634906227-22028-2-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-22 at 18:07 +0530, P Praneesh wrote:
> 
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4181,7 +4181,7 @@ struct cfg80211_ops {
>  
> 
> 
> 
>  	int	(*remain_on_channel)(struct wiphy *wiphy,
>  				     struct wireless_dev *wdev,
> -				     struct ieee80211_channel *chan,
> +				     struct cfg80211_chan_def *chandef,
>  				     unsigned int duration,
>  				     u64 *cookie);

I find it's odd you update this, but
> 
>  	if (!roc->mgmt_tx_cookie)
>  		cfg80211_remain_on_channel_expired(&roc->sdata->wdev,
> -						   roc->cookie, roc->chan,
> +						   roc->cookie,
> +						   roc->chandef.chan,
>  						   GFP_KERNEL);

not the reporting API? Would seem better to pass back the whole thing?

> @@ -211,6 +212,7 @@ static unsigned long ieee80211_end_finished_rocs(struct ieee80211_local *local,
>  		 * ROC session before the actual requested time. In such a case
>  		 * end the ROC session (disregarding the remaining time).
>  		 */
> +
>  		if (roc->abort || roc->hw_begun || remaining <= 0)
>  			ieee80211_roc_notify_destroy(roc);


spurious change?

> @@ -311,7 +316,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
>  	list_for_each_entry(tmp, &local->roc_list, list) {
>  		if (tmp == roc)
>  			continue;
> -		if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
> +		if (tmp->sdata != roc->sdata || tmp->chandef.chan != roc->chandef.chan)
>  			break;

This really doesn't work - you need to actually compare the chandefs for
being identical or at least compatible when merging etc. happens here.

At least if we want mac80211 to support this feature (more on that
later)

> @@ -331,7 +337,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
>  			 */
>  			list_for_each_entry(tmp, &local->roc_list, list) {
>  				if (tmp->sdata != roc->sdata ||
> -				    tmp->chan != roc->chan)
> +				    tmp->chandef.chan != roc->chandef.chan)
>  					break;

likewise

> +	roc->chandef.chan = chandef->chan;
> +	roc->chandef.width = chandef->width;
> +	roc->chandef.center_freq1 = chandef->center_freq1;
> +	roc->chandef.center_freq2 = chandef->center_freq2;

That probably should use a struct assignment - there are some more
struct members you're now not setting.
> 
>  	mutex_lock(&local->mtx);
> -	ret = ieee80211_start_roc_work(local, sdata, chan,
> -				       duration, cookie, NULL,
> -				       IEEE80211_ROC_TYPE_NORMAL);
> +	if (chandef) {
> +		ret = ieee80211_start_roc_work(local, sdata, chandef,
> +					       duration, cookie, NULL,
> +					       IEEE80211_ROC_TYPE_NORMAL);
> +	}

No need for braces, but how would that actually be NULL?!
> 
> +	chandef.chan = params->chan;

Uh, well, the other fields of a stack struct really want to be
initialized too :)


> @@ -1244,8 +1244,9 @@ TRACE_EVENT(drv_remain_on_channel,
>  	TP_fast_assign(
>  		LOCAL_ASSIGN;
>  		VIF_ASSIGN;
> -		__entry->center_freq = chan->center_freq;
> -		__entry->freq_offset = chan->freq_offset;
> +		CHANDEF_ASSIGN(chandef);
> +		__entry->center_freq = chandef->chan->center_freq;
> +		__entry->freq_offset = chandef->chan->freq_offset;

Why would we need center_freq/freq_offset if we have a whole chandef?

We're not usually taking much care with compatibility here with tracing.

> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -11282,7 +11282,7 @@ static int nl80211_remain_on_channel(struct
> sk_buff *skb,
>  		goto free_msg;
>  	}
>  
> -	err = rdev_remain_on_channel(rdev, wdev, chandef.chan,
> +	err = rdev_remain_on_channel(rdev, wdev, &chandef,
>  				     duration, &cookie);
>  
>  	if (err)
> 

Really though, the biggest issue I see with this that you added no
feature advertisement, no checks for the channel even being valid,
nothing?

Seems like we should have some kind of feature check, at least to reject
40/80/160/whatever bandwidths with all the existing drivers you only
updated the API on, but didn't actually implement the new changes? I.e.
this really needs to be opt-in somehow.

And for mac80211 we need to implement some different merge logic, etc.,
it seems.

johannes

