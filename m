Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9742D38FA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgLICtN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 21:49:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:34918 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLICtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 21:49:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607482128; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=46bJUxgq79O6ZYLsq5vRFJDYjMMuddxgHfULx7TR2ZM=;
 b=LNAS94BMkgiNWrMZjAR6WF0vYcWKC13ykSo8e8fV1idiYd8szrFfSTuJREbvSsr6H10NlxAZ
 PGT79eD4cPgXdKs4xduaYQrBe1G2UycYMEFMy4QmMaYKfbUpqcDf30uj0pOr6GGDXrBAIi62
 Q7/wuSUgE6kEC0ZL6QBEdME4MAA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fd03af66d5c2f1d206d0e6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 02:48:22
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4042EC43463; Wed,  9 Dec 2020 02:48:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E8EDC433C6;
        Wed,  9 Dec 2020 02:48:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Dec 2020 10:48:21 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 13/17] mac80211: receive and process S1G beacons
In-Reply-To: <bc3e532c5d21ac5d703de41d4144cf7d@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-14-thomas@adapt-ip.com>
 <6064b579538afca27c511edeb5400032@codeaurora.org>
 <bc3e532c5d21ac5d703de41d4144cf7d@adapt-ip.com>
Message-ID: <b64d2f6db4464c9ea53a4e29af8332af@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-09 02:19, Thomas Pedersen wrote:
> Hi Wen,
> 
> On 2020-12-07 23:44, Wen Gong wrote:
>> On 2020-09-22 10:28, Thomas Pedersen wrote:
>>> S1G beacons are 802.11 Extension Frames, so the fixed
>>> header part differs from regular beacons.
>>> 
>>> Add a handler to process S1G beacons and abstract out the
>>> fetching of BSSID and element start locations in the
>>> beacon body handler.
>>> 
>>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>>> ---
>>>  net/mac80211/ieee80211_i.h |  4 ++
>>>  net/mac80211/iface.c       |  5 +++
>>>  net/mac80211/mlme.c        | 84 
>>> +++++++++++++++++++++++++++++---------
>>>  net/mac80211/rx.c          | 84 
>>> ++++++++++++++++----------------------
>>>  net/mac80211/util.c        | 52 +++++++++++++++++++++++
>>>  5 files changed, 162 insertions(+), 67 deletions(-)
>>> 
>> ...
>>> @@ -1801,7 +1756,8 @@ ieee80211_rx_h_sta_process(struct 
>>> ieee80211_rx_data *rx)
>>>  		}
>>>  	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
>>>  		sta->rx_stats.last_rx = jiffies;
>>> -	} else if (!is_multicast_ether_addr(hdr->addr1)) {
>>> +	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
>>> +		   is_multicast_ether_addr(hdr->addr1)) {
>> is this a typo mistake?
>> it removed ! for is_multicast_ether_addr(!is_multicast_ether_addr ==>
>> is_multicast_ether_addr)
> 
> Yes that does look like a typo, it should be:
> 
> 	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
> 		   !is_multicast_ether_addr(hdr->addr1)) {
> 
> (because is_multicast_ether_addr() evaluates to true for s1g beacons).
> 
> Do you have a patch or would you like me to send a fixup?
Yes, I have a patch for it.
I will send it.
> 
> Thanks,
