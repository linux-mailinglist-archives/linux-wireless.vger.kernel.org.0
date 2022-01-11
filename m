Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6C48B7C9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiAKUCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 15:02:55 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:43160 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242146AbiAKUCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 15:02:54 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F36DF1A0083;
        Tue, 11 Jan 2022 20:02:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BF89884007A;
        Tue, 11 Jan 2022 20:02:52 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 09AD113C2B0;
        Tue, 11 Jan 2022 12:02:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 09AD113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1641931372;
        bh=vnV8ahiciAWObkeeBY0DA6FOWi6bFkX7QAgOpNU9mcs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=JDsMYxnzlGkHNZAQqASm2hdWf8VHouBMubgTadua5HbBZpx/bYPvBlZK4p6XALivd
         1jwql3A6zM3tYQklUwPlTyasUM3Z1ekXzJb/RNAcse6h9YkJuwLzJ7hVDb4xyCsNVY
         9mvd6wPbUL80qtiqjXQOo+QbVSPzxPTj1uuRswLE=
Subject: Re: iwlwifi: AX201 not using 2 receive streams
To:     Brandon Nielsen <nielsenb@jetfuse.net>,
        linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
 <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
 <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <333d94a2-87b6-b1e3-f369-d11eeead231e@candelatech.com>
Date:   Tue, 11 Jan 2022 12:02:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1641931373-FW93J9R2TS_k
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/11/22 11:46 AM, Brandon Nielsen wrote:
> On 1/8/22 3:22 PM, Ben Greear wrote:
>> On 1/8/22 12:50 PM, Brandon Nielsen wrote:
>>> I have a system with Intel AX201 not using 2 spatial streams in the RX (download) direction. TX (upload) functions as expected. I'm seeing similar behavior 
>>> with an AX200 system. I'm seeing the same behavior on 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. Windows works as expected.
>>>
>>> I have opened bug 215465[0] with some more detail.
>>>
>>> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
>>>
>>
>> We saw something similar with ax210, but only on 6E, in kernel 5.15.7+. On 5Ghz, it worked 2x2 as expected.
>> On a 5.15.0-rc something, it worked OK for us.
>>
>> We verified same firmware is used in both cases, but have not fully bisected the problem yet but we are
>> working on it.  In case you find the problem patch before us, please let me know!
>>
>> Thanks,
>> Ben
>>
> 
> I'm still seeing this as far back as 5.11.12, so I'm not convinced this is a regression. At least for the 5 GHz / 802.11ac case.
> 

Ok, we are trying to bisect now...slow going as normal.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

