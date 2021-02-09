Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9F315207
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhBIOtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 09:49:42 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:17798 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhBIOtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 09:49:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612882149; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=lpR97qmIIyIzmbi1fHDnS3cyxd7e5ZkhkYFfAEWnJWs=;
 b=CSGNOfBB+msGCf11wZLsxtDVOZDSsMYmbXiqTKx87SoYWEfUhvO5V5RYrbxLUeImS7qbZ6La
 +Fgcsb114RlEY/vglx2J/TjmUO3MOA2wewPENrsWw1gImKmjdZ2bAcRPMbJMUBlE0PcO+H9d
 KSqojnJuCubE8KblYAsYiwlHljs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6022a0c2e4842e91289d7924 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 14:48:34
 GMT
Sender: usdutt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3B8FC43462; Tue,  9 Feb 2021 14:48:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: usdutt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB487C433C6;
        Tue,  9 Feb 2021 14:48:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 09 Feb 2021 20:18:32 +0530
From:   usdutt@codeaurora.org
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE
 802.11be)
In-Reply-To: <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
 <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
 <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
 <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
Message-ID: <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
X-Sender: usdutt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-23 21:59, usdutt@codeaurora.org wrote:
> On 2020-12-14 14:55, Arend van Spriel wrote:
>> On 09-12-2020 16:36, Johannes Berg wrote:
>>> Hi,
>>> 
>>>> Multi-link support is introduced in 802.11be specification.
>>> [...]
>>> 
>>> I'll definitely have to take a closer look at this and the spec and
>>> think about it - but a couple of quick comments below.
> 
> Thanks for your comments. Please allow me to address your comments in
> the subsequent patches.
> Our main intention through this RFC is to get the view on the proposal
> to introduce a new NL80211_IFTYPE for an MLO Link.
> Please suggest on this.
> 
> 
>> Did not get my hands on the spec yet, but just firing random thoughts.
>> This multi-link support sounds a bit like bonding. Could that be
>> leveraged for wireless? I wonder why there is a need for a non-netdev
>> interface. Does networking layer need to be aware of the multi-link
>> for scheduling traffic to it? Is there one driver per multi-link or
>> per radio?
> 
> The following is what the Bonding driver / interface does for the
> multiple network interfaces.
> 1. Bonding driver aggregates multiple network interfaces into a single
> logical bonded interface.
> 2. Each network interface is called as a slave in the bonding driver.
> 3. It’s the Bonding driver that schedules the traffic across these 
> slaves.
> 4. Bonding interface operates on one of the following modes (
> mentioning for a quick reference ).
>        balance-rr : Round-robin policy: Transmit packets in sequential
> order from the first available slave through the last.
>        active-backup : Only one slave in the bond is active. A
> different slave becomes active if, and only if, the active slave
> fails.
>        balance-xor : Transmit based on the selected transmit hash 
> policy.
>        balance-tlb : channel bonding that does not require any special
> switch support. The outgoing traffic is distributed according to the
> current load
>        balance-alb : includes balance-tlb plus receive load balancing.
> 5. With the above modes, the scheduling of the traffic is determined
> with in the kernel / bonding driver and have the host driver /
> firmware follow it.
> 
> The following are the factors for not considering the MLO Link as a
> bonding interface and further to propose this RFC
> (new NL80211_IF_TYPE -> NL80211_IFTYPE_MLO_LINK_DEVICE).
> 
> 1. For MLO, our intention is to allow the traffic scheduling (among
> the MLO links) to be closer to the lower layers in
>         the driver/firmware, etc, unlike the bonding driver where
> kernel schedules the traffic.
> 2. If MLO Link has to use a bonding interface, each MLO link has to be
> associated with a network interface and thus each
>         of the MLO link has to be of NL80211_IF_TYPE  -> 
> NL80211_IFTYPE_STATION.
> 3. This further means that NL80211_CONNECT / NL80211_ASSOCIATE needs
> to get triggered on each of this MLO Link of the
>         MLO connection.
> 4. Our intention is to consider the MLO station as a single network
> interface . More specifically, have a single
>         NL80211_CONNECT / NL80211_CMD_ASSOCIATE triggered for each MLO
> connection ( MLD + MLO Links).
> 5. The reason we had to introduce a new NL80211_IF_TYPE ->
> NL80211_IFTYPE_MLO_LINK_DEVICE is to have the corresponding
>        link connection specific information ( e.g., Connection State,
> Connected BSS Info, Connection Frequency/properties, etc),
>        for each wdev / MLO Link and at the same  time have a single
> connect / association request to the driver / AP.
> 6. Further, these NL80211_IFTYPE_MLO_LINK_DEVICE link devices shall
> represent an MLO Link and attribute to a network interface ( MLD ) of
> an
>       MLO connection.
> 7. The current proposal to introduce a new NL80211_IF_TYPE should
> support the architectures of MLO links across the multiple wiphy
>         interfaces or on the same wiphy interface. These wiphy
> interfaces can be from different drivers too.
> 
> Please review the above.
> 
>> 
>> [...]
>> 
>>>>   	struct sk_buff *msg;
>>>>   	void *hdr;
>>>> +	struct nlattr *nested, *nested_mlo_links;
>>>> +	struct cfg80211_mlo_link_device_params *mlo_link;
>>>> +	int i = 0;
>>>>     	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
>>>>   			cr->fils.kek_len + cr->fils.pmk_len +
>>>> -			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>>>> +			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>>>> +			(cr->n_mlo_links ? cr->n_mlo_links * 32 : 0), gfp);
>>> 
>>> 32 probably should be some NLA_SIZE or something constant?
>> 
>> Probably sizeof(*mlo_link) ?
>> 
>>> There's also no point in the ternary operator since 0 * 32 is 0 :)
>>> 
>>>>   /* Consumes bss object one way or another */
>>>> @@ -833,7 +849,9 @@ void cfg80211_connect_done(struct net_device 
>>>> *dev,
>>>>   	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
>>>>   		     params->req_ie_len + params->resp_ie_len +
>>>>   		     params->fils.kek_len + params->fils.pmk_len +
>>>> -		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>>>> +		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>>>> +		     (params->n_mlo_links ? params->n_mlo_links *
>>>> +		      sizeof(struct cfg80211_mlo_link_device_params) : 0), gfp);
>>> 
>>> same here, no need for the ternary
>>> 
>>> 
>>> It feels strangely asymmetric to have stop and no start ... but I 
>>> guess
>>> that's the part where I need to think about it and look a bit at how 
>>> it
>>> all works :)
>> 
>> Had the same feeling in my gutt (wherever that is ;-)
> 
> Sure. Will take this point. In fact, this was documented in the commit
> message to consider the start (say start_mlo_link), but do not want
> the drivers to depend on this trigger for starting the MLO link.
> For example, the host drivers with SME can as well start the MLO Link
> after getting the Assoc response for MLO links from the AP.
> 
> 
>> 
>> Regards,
>> Arend

Hi,

Can you please provide your comments on the proposal.
We wanted to hear your feedback on the following points.

Represent MLO link of an MLO connection by a wdev of type 
NL80211_IFTYPE_MLO_LINK_DEVICE.
MLO link wdev does not have an active netdev associated to it but will 
be similar to that of NL80211_IFTYPE_STATION, w.r.t maintaining link’s 
connection information ( connected channel , BSSID, etc).
MLD interface of an MLO connection will be a station interface 
(NL80211_IFTYPE_STATION wdev) This station interface shall link the 
wdev’s of all the MLO link wdev’s part of the MLO connection. Cfg80211 
layer shall link all such wdev’s.
Such MLO Link wdev’s shall be part of the same wiphy or different wiphy 
(if host driver's register a single wiphy for each supported 
band/MAC/PHY).
MLO link wdev (NL80211_IFTYPE_MLO_LINK_DEVICE) is created by the user 
space prior the MLO connection.
User space can as well change the interface type among 
NL80211_IFTYPE_STATION wdev To NL80211_IFTYPE_MLO_LINK_DEVICE wdev. To 
support the use case where an existing STA wdev can change to a MLO wdev 
and vice versa.

Regards,
Sunil

