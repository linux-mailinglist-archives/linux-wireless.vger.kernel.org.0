Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFA1779AA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 15:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgCCO5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 09:57:41 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41502 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCCO5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 09:57:41 -0500
Received: from [192.168.254.4] (unknown [50.46.151.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DB8F213C2B0;
        Tue,  3 Mar 2020 06:57:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DB8F213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1583247460;
        bh=4UHGMnfZU9Y0e9cG7MGyQft7ZWQN7zDAc5h/PseG9MU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MMyozALicXk5RCcCizmQBMO4dXnG1ReV+KNlH623XahgYPylJ3QgSVKsDtCLESB+D
         S9sPBkhMoZr/B0gDj368skw2v3PJDqdHoCvTGC9YcP2gBWe2ZfkkOXSaz7hwvasWEM
         3YWlMCAxIE+5NJQ/DiQovfO8EthjZubuAi/K/xGU=
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <5E4B39B2.8050905@candelatech.com>
 <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
 <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
 <da15dc015f2992a702cc585c510e009a83b8fdb1.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <07235202-4134-f01a-5083-4c56c1ed604a@candelatech.com>
Date:   Tue, 3 Mar 2020 06:57:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <da15dc015f2992a702cc585c510e009a83b8fdb1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 03/03/2020 06:08 AM, Johannes Berg wrote:
> On Fri, 2020-02-28 at 07:26 -0800, Ben Greear wrote:
>>
>> On 02/28/2020 02:06 AM, Johannes Berg wrote:
>>> On Mon, 2020-02-17 at 17:11 -0800, Ben Greear wrote:
>>>> To sniff /AX stations, it is helpful to know their AID.  So, any problems
>>>> with adding it to 'iw station dump' output?
>>>
>>> No, no problem at all. I guess it was just never added because it
>>> originally comes from userspace (hostapd), and so didn't really need to
>>> be sent back. But yeah, we have trivial infrastructure to send it back,
>>> so sure, why not.
>>
>> Ok, thanks for the response.
>>
>>  From looking at debugfs for a station device, there is the netdev AID:
>>
>> cat /debug/ieee80211/wiphy0/netdev\:wlan0/aid
>> 1
>>
>> And there is a peer AID:
>>
>> cat /debug/ieee80211/wiphy0/netdev\:wlan0/stations/04\:f0\:21\:c2\:fd\:b0/aid
>> 0
>>
>> For sniffing AX, I'd need to use '1' here as far as I can tell.  Maybe for station
>> devices the peer is always zero?  And for AP devices, the peer IDs are what is useful
>> and the netdev AID is not?
>
> Yeah. The first is u.mgd.aid (i.e. the netdev data), and the latter is
> the STA AID.
>
> It makes sense the latter is not assigned in the client-side case.
>
> Arguably, only the *latter* should be in nl80211 per STA, since in the
> client-side case it's *our* AID, not the APs.

Although it is a bit weird, I was thinking to always return the AID as part of the station
dump, and for station netdevs, use the local netdev AID, and for APs, use the remote station AID.

That seems a bit cleaner to me than having two separate ways to get the AID for stations and APs,
but I can do two separate ways if you prefer that.

Thanks,
Ben

>
> johannes
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
