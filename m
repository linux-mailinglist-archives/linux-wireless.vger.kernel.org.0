Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D81779D9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgCCPC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 10:02:58 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41706 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgCCPC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 10:02:58 -0500
Received: from [192.168.254.4] (unknown [50.46.151.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 09DD213C283;
        Tue,  3 Mar 2020 07:02:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 09DD213C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1583247777;
        bh=AAXoGvcEdyNdSHvTdIdm0sQYkpPNWxjIfPikoClZJg4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Om+0H8ko/oPVYPCzCnScfgJ4CrRKNzJ+R2rrMN+kHEqjhbjl/hI8djrpVv5Q9lOpj
         7LWIpUx7hs0rXDk0gK9Db5xp6EoblCi97k0hklJotw+QJzWZdYORseaXMKTf6btFUh
         gCnKf/lnwC0Ip8drTpun3obqR0bRugsDrkpQW1HU=
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <5E4B39B2.8050905@candelatech.com>
 <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
 <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
 <da15dc015f2992a702cc585c510e009a83b8fdb1.camel@sipsolutions.net>
 <07235202-4134-f01a-5083-4c56c1ed604a@candelatech.com>
 <5d6760e94097b3c11c7244076befeb77066d02c8.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <585e840a-c2e7-cd75-bf5b-8cd9c089a666@candelatech.com>
Date:   Tue, 3 Mar 2020 07:02:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5d6760e94097b3c11c7244076befeb77066d02c8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 03/03/2020 06:59 AM, Johannes Berg wrote:
> On Tue, 2020-03-03 at 06:57 -0800, Ben Greear wrote:
>>
>> Although it is a bit weird, I was thinking to always return the AID as part of the station
>> dump, and for station netdevs, use the local netdev AID, and for APs, use the remote station AID.
>>
>> That seems a bit cleaner to me than having two separate ways to get the AID for stations and APs,
>> but I can do two separate ways if you prefer that.
>
> I don't really agree that it's cleaner - by definition, the data in a
> station is data about that station, not data about "self".
>
> We may not have a great way right now to show the latter ('data about
> self')? But I still don't think we should mix it.

Ok, I'll go poke at the code and see what I can figure out.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
