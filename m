Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173BE2DC845
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 22:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgLPVUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 16:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPVUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 16:20:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3D8C061794
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=88+2tsSMH6HZY4zTdIeVZLF09NJz21xBnxEal1fzByI=; b=RLyW7NMxQ6J+TOVRvuxPK0zMtR
        8BkPoUb2aEqDUXOsH4g2SEFb1bqW/kh778SYVJfRLQQUxA/pzcg9/8uSLwpZhz5c3LFRGoTRFS+y3
        GQDlMsyXqkljWk3IvipPsdvbNk+Xyag9GHL2XZK82KUnwLDlVeoYr6unv41ttEt/wGGk=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpeCR-0004m8-FZ; Wed, 16 Dec 2020 22:19:07 +0100
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-7-nbd@nbd.name>
 <893856dcc9ff9adf65b0bcdbb6ce127d56980ee8.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 7/7] mac80211: add rx decapsulation offload support
Message-ID: <dc5db3c0-e4bf-d8ed-3da6-5b549628a0cb@nbd.name>
Date:   Wed, 16 Dec 2020 22:19:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <893856dcc9ff9adf65b0bcdbb6ce127d56980ee8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-16 22:03, Johannes Berg wrote:
> On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
>> 
>> +	offload = assign &&
>> +		  (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);
>> +
>> +	if (offload)
>> +		set_offload = !test_and_set_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
>> +	else
>> +		set_offload = test_and_clear_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
>> +
>> +	if (set_offload)
>> +		drv_sta_set_decap_offload(local, sdata, &sta->sta, assign);
> 
> Some of these lines look a bit long?
Just a tiny bit over 80 characters. Wasn't the 80 characters line limit
removed a while back? I don't think line wrapping would make things more
readable here.

>> -	skb = ieee80211_rx_monitor(local, skb, rate);
>> +	if (!(status->flag & RX_FLAG_8023))
>> +		skb = ieee80211_rx_monitor(local, skb, rate);
> 
> Is that worth the check? You basically disable it anyway if monitor
> interfaces are there.
There could be a race. The driver or hw might have queued up some 802.3
frames after offload was disabled.

> Not sure that's really the right thing to do ... we often want monitor
> interfaces (with no flags set) for debug?
> 
> Or maybe we should add some tracing then (instead).
Tracing probably makes more sense. I'm not sure pcap or radiotap can
deal with a mix of 802.3 and 802.11 packets. Leaving offload enabled and
silently dropping 802.3 packets seems like a bad idea to me as well.

- Felix

