Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8935B60C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhDKQWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 12:22:09 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:56056 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235756AbhDKQWI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 12:22:08 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 12:22:08 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B16EF24F322
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 16:15:12 +0000 (UTC)
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.129])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0F0D320061;
        Sun, 11 Apr 2021 16:15:12 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.25])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4C70AA0061;
        Sun, 11 Apr 2021 16:15:11 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CAA6AB0006A;
        Sun, 11 Apr 2021 16:15:10 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E326E13C2B3;
        Sun, 11 Apr 2021 09:15:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E326E13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1618157710;
        bh=ycS2NdssvmfDMnIxk0K8SpStyNymk7wTurqcARd+v7M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r89SIxldXp11E5cSyId1bLaLktYvRUYFSvTLBvTjSxIc7q6v11km9MmZVIuO78i0H
         zay+qwcD9RwvtZtW6Dzen92KcH3qBDozQxWGM4+bNfTw9RtzOOtGWW6PxHoZ7hJH2/
         NkUAISJ5jZD85NrQgXfkZHGx5VBOcWK9QJcDbYio=
Subject: Re: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
To:     "Peer, Ilan" <ilan.peer@intel.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
 <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
 <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
 <eb60c152-81ac-2977-87fc-f724d4d6ccf0@candelatech.com>
 <BN7PR11MB2610CE4FAF07FFB017E19AB0E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <8dfae5c0-1900-a1fc-ee36-8ceaa9ec0dbe@candelatech.com>
Date:   Sun, 11 Apr 2021 09:15:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BN7PR11MB2610CE4FAF07FFB017E19AB0E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1618157711-JGU2YnKANRn5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/21 5:14 AM, Peer, Ilan wrote:
> Hi,
> 
>>> This logic enables a special 'passive' scan which is not directly
>>> intended for discovery of APs for connection etc. but for discovery of
>>> APs with country information in the beacons/probe responses, so the fw
>>> could use this information as an input that might allow it to enable 6GHz
>> channels (which are supported but are disabled). This special scan is intended
>> for cases that the device does not have any other regulatory information that
>> allows it to enable the 6GHz channels.
>>> Once these channels are enabled, we use passive scan as needed.
>>>
>>> We generally try to avoid passive scan on all the 6GHz channels as
>>> this is a long flow that takes at least 6 seconds (as there are such 64
>> channels) and with the discovery mechanisms defined for the 6GHz is not
>> really needed.
>>
>> If the station comes up and does a 6E passive scan and does not find any AP,
>> perhaps because 6Ghz AP was turned on 1 minute after the station tried to
>> initially scan, this means that it will take 50 minutes before it can have a
>> chance to scan the AP and connect to the Internet?  If station cannot connect
>> after a relatively short time, then I think it should scan as widely as it can in
>> order find some possible way to connect.
>>
> 
> The purpose of this heuristic was to handle a very specific corner case where there are
> no APs on the 2GHz/5GHz bands and there are only one or more non-collocated APs
> on the 6GHz band. Based on our understanding, this is not a very likely situation and thus,
> due to other consideration e.g., power KPIs etc., the above conditions were defined. However,
> as you can see in the patch, there are options to tune the heuristic to be more aggressive,
> and if it would indeed be needed we can change the behavior such cases.

Yes, and I can tweak the code myself if needed.  But better if upstream driver
is already nice as possible.

>> And why care about 'at least 4 channels'.  If we know the AP channel, and can
>> scan exactly there, then your concern about taking a long time is resolved.
>>
> 
> The assumption was that while a connection was not established a full scan
> is expected, so that's why the above condition was set. However, I'll take this
> with my colleagues and see if this condition can be removed or defined
> differently.

The complexity of the restrictions are going to silently break certain configs that
a user can reasonable expect to work I think.

> 
>> How else can we tell the radio that 6E is allowed?  I previously tried all sorts of
>> things to enable 6E channels so that I could more easily set the radio to sniff
>> one of those channels in monitor mode, and I had no luck.
>>
> 
> Are you asking specifically for iwlwifi devices? I'm not familiar with a simple
> way to do so other the one described here, but I can check if you need it.

Yes.  ax210 in particular.

> 
>> If all of the 6E channels are marked as passive, what harm is it to enable the
>> channels in the regdom from the beginning?
>>
> 
> AFAIK, as the 6GHz regulatory is still evolving, we are not yet allowed to do so. But once again,
> If you are interested I can further check this our regulatory team.

Your patch enables passive scan of 6Ghz when no regulatory specifically allows it.
I think just enabling the band as passive is the same thing, but significantly
simplifies things.  If there are regulatory reasons to not allow even passsive scanning on 6E,
then your patch breaks that.  If not, then just always allow 6E channels to be available in
passive mode.

The logic to optimize scanning time and channels belongs up in the supplicant
and other higher level code that can take user input/config and make decisions using info
that the driver will never have.

Thanks,
Ben

> 
> Regards,
> 
> Ilan.
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
