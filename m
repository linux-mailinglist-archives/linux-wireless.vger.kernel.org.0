Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0A2D3201
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgLHSUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 13:20:42 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:49098 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730488AbgLHSUl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 13:20:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 14A004FAFE7;
        Tue,  8 Dec 2020 18:19:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id g7w09fRtMwrg; Tue,  8 Dec 2020 18:19:53 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 979464FAFE4;
        Tue,  8 Dec 2020 18:19:52 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 08 Dec 2020 10:19:52 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 13/17] mac80211: receive and process S1G beacons
In-Reply-To: <6064b579538afca27c511edeb5400032@codeaurora.org>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-14-thomas@adapt-ip.com>
 <6064b579538afca27c511edeb5400032@codeaurora.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <bc3e532c5d21ac5d703de41d4144cf7d@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Wen,

On 2020-12-07 23:44, Wen Gong wrote:
> On 2020-09-22 10:28, Thomas Pedersen wrote:
>> S1G beacons are 802.11 Extension Frames, so the fixed
>> header part differs from regular beacons.
>> 
>> Add a handler to process S1G beacons and abstract out the
>> fetching of BSSID and element start locations in the
>> beacon body handler.
>> 
>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>> ---
>>  net/mac80211/ieee80211_i.h |  4 ++
>>  net/mac80211/iface.c       |  5 +++
>>  net/mac80211/mlme.c        | 84 
>> +++++++++++++++++++++++++++++---------
>>  net/mac80211/rx.c          | 84 
>> ++++++++++++++++----------------------
>>  net/mac80211/util.c        | 52 +++++++++++++++++++++++
>>  5 files changed, 162 insertions(+), 67 deletions(-)
>> 
> ...
>> @@ -1801,7 +1756,8 @@ ieee80211_rx_h_sta_process(struct 
>> ieee80211_rx_data *rx)
>>  		}
>>  	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
>>  		sta->rx_stats.last_rx = jiffies;
>> -	} else if (!is_multicast_ether_addr(hdr->addr1)) {
>> +	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
>> +		   is_multicast_ether_addr(hdr->addr1)) {
> is this a typo mistake?
> it removed ! for is_multicast_ether_addr(!is_multicast_ether_addr ==>
> is_multicast_ether_addr)

Yes that does look like a typo, it should be:

	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
		   !is_multicast_ether_addr(hdr->addr1)) {

(because is_multicast_ether_addr() evaluates to true for s1g beacons).

Do you have a patch or would you like me to send a fixup?

Thanks,

-- 
thomas
