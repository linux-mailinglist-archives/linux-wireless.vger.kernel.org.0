Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979F35B388
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDKL1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 07:27:05 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:52176 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233696AbhDKL1E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 07:27:04 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 07:27:04 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 772B9227EA0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 11:17:01 +0000 (UTC)
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.81])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2F0106005F;
        Sun, 11 Apr 2021 11:17:01 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (cache2.dclocal [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2428F1A005E;
        Sun, 11 Apr 2021 11:17:00 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B7AC8780068;
        Sun, 11 Apr 2021 11:16:59 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8A10413C2B3;
        Sun, 11 Apr 2021 04:16:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8A10413C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1618139819;
        bh=4Il3VsbAY3QKC6UEhsF2QOTodNnxO3lqbT5oWJGX6dU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P7ShuHQrVtJV4zBbMWH7q2z/jq0uxvSV68Uwjc8TaL5EJdsCna5kPBy1+AI2x65DG
         c7GJ5Z5plAe3J+GfUn4PM8L5GKBoDtkJumfC6m/qg1aNNwo0VuvEZpm4CKdeLG4ECR
         HoT1s3Dt83aZLeJamb/yEOKemK4fOUu4QmxWMIaE=
Subject: Re: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
To:     "Peer, Ilan" <ilan.peer@intel.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
 <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
 <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <eb60c152-81ac-2977-87fc-f724d4d6ccf0@candelatech.com>
Date:   Sun, 11 Apr 2021 04:16:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1618139820-6v4eKNU07ua6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/21 3:14 AM, Peer, Ilan wrote:
> Hi Ben,
> 
>> -----Original Message-----
>> From: Ben Greear <greearb@candelatech.com>
>> Sent: Wednesday, March 31, 2021 15:04
>> To: Luca Coelho <luca@coelho.fi>; kvalo@codeaurora.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
>>
>> On 3/31/21 2:14 AM, Luca Coelho wrote:
>>> From: Ilan Peer <ilan.peer@intel.com>
>>>
>>> When doing scan while 6GHz channels are not enabled, the 6GHz band is
>>> not scanned. Thus, if there are no APs on the 2GHz and 5GHz bands
>>> (that will allow discovery of geographic location etc. that would
>>> allow enabling the 6GHz channels) but there are non collocated APs on
>>> 6GHz PSC channels these would never be discovered.
>>>
>>> To overcome this, FW added support for performing passive UHB scan in
>>> case no APs were discovered during scan on the 2GHz and 5GHz channels.
>>>
>>> Add support for enabling such scan when the following conditions are
>>> met:
>>>
>>> - 6GHz channels are supported but not enabled by regulatory.
>>> - Station interface is not associated or less than a defined time
>>>     interval passed from the last resume or HW reset flows.
>>> - At least 4 channels are included in the scan request
>>> - The scan request includes the widlcard SSID.
>>> - At least 50 minutes passed from the last 6GHz passive scan.
>>
>> Why are you trying so hard to not do passive scans?  This seems like it is set
>> up for all sorts of frustration.
>>
> 
> This logic enables a special 'passive' scan which is not directly intended for discovery of APs for connection etc. but
> for discovery of APs with country information in the beacons/probe responses, so the fw could use this information
> as an input that might allow it to enable 6GHz channels (which are supported but are disabled). This special scan
> is intended for cases that the device does not have any other regulatory information that allows it to enable the 6GHz channels.
> Once these channels are enabled, we use passive scan as needed.
> 
> We generally try to avoid passive scan on all the 6GHz channels as this is a long flow that takes at least 6 seconds (as there are
> such 64 channels) and with the discovery mechanisms defined for the 6GHz is not really needed.

If the station comes up and does a 6E passive scan and does not find any AP, perhaps because 6Ghz AP was turned on 1 minute after the station
tried to initially scan, this means that it will take 50 minutes before it can have a chance to scan
the AP and connect to the Internet?  If station cannot connect after a relatively short time,
then I think it should scan as widely as it can in order find some possible way to connect.

And why care about 'at least 4 channels'.  If we know the AP channel, and can scan exactly there, then your
concern about taking a long time is resolved.

How else can we tell the radio that 6E is allowed?  I previously tried all sorts of things
to enable 6E channels so that I could more easily set the radio to sniff one of those channels
in monitor mode, and I had no luck.

If all of the 6E channels are marked as passive, what harm is it to enable the channels
in the regdom from the beginning?

Thanks,
Ben

> 
> Hope this clarifies things.
> 
> Regards,
> 
> Ilan.
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
