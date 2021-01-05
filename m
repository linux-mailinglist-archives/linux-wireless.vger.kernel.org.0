Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19F2EA27A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbhAEBCX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 20:02:23 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:37348 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbhAEBB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 20:01:59 -0500
Received: from [192.168.254.6] (unknown [50.46.152.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2F25C13C359;
        Mon,  4 Jan 2021 17:01:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2F25C13C359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609808476;
        bh=8uouPfJmxEzF/g181Ay37CCyCQ6IK3/S1E5TKxAqrpo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wu+ze/7Il2zlJBgYcmviW4eD9ZmwFa3y9u94msE0Q3YCwV6Z8P8sNsPK8dpy0z7Li
         p0jdgGcL1cvgQMQnH/eEAi8YY9gU5YLEzuPdmyWi6iwe39PilYMB3OI1Ujxpb1B640
         wzqieTFlFuMJ6u3Px/CTtPYcuadIp/eQ3OrmSYdQ=
Subject: Re: RX rate is wrong in 5.10? (bisected to: mac80211: receive and
 process S1G beacons)
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
References: <584816e2-ed18-3d5e-651e-293637222148@candelatech.com>
 <5dc86950-1672-6900-dad4-3b437f4959c5@candelatech.com>
 <772a3a0517eb4d4cc6cee975e5fde100@adapt-ip.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <fcb62a2f-a008-2bb6-d5b1-272a4f58febf@candelatech.com>
Date:   Mon, 4 Jan 2021 17:01:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <772a3a0517eb4d4cc6cee975e5fde100@adapt-ip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/4/21 4:25 PM, Thomas Pedersen wrote:
> Hi Ben,
> 
> On 2021-01-04 16:18, Ben Greear wrote:
>> On 1/4/21 8:18 AM, Ben Greear wrote:
>>> Hello,
>>>
>>> I noticed that RX rate is always 6Mbps when I use -ct firmware and -ct driver in
>>> 5.10, and on stock 5.10.0 driver and stock firmware, rx-rate does not show up at
>>> all in 'iw dev wlan1 station dump'.
>>>
>>> I'm using 9984 NIC...
>>>
>>> Anyone else see this?
>>
>> After a bisect, the first bad commit shows this:
>>
>> commit 09a740ce352e1a1d16b9984115514ba9a4f4704b (refs/bisect/bad)
>> Author: Thomas Pedersen <thomas@adapt-ip.com>
>> Date:   Mon Sep 21 19:28:14 2020 -0700
>>
>>     mac80211: receive and process S1G beacons
>>
>>     S1G beacons are 802.11 Extension Frames, so the fixed
>>     header part differs from regular beacons.
>>
>>     Add a handler to process S1G beacons and abstract out the
>>     fetching of BSSID and element start locations in the
>>     beacon body handler.
>>
>>     Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>>     Link: https://lore.kernel.org/r/20200922022818.15855-14-thomas@adapt-ip.com
>>     [don't rename, small coding style cleanups]
>>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> From a glance through the diff, I'm at a loss as to why it causes the
>> symptom.  I manually
>> double-checked the bisect, an it appears correct.
>>
>> What I see is that in the commit before this, I see a useful rx rate
>> (1.3Gbps for instance)
>> in 'iw dev wlan1 station dump', but in this bad commit, both show
>> 6Mbps rate.  (Tx rate
>> in ath10k is probably broken for other reasons, so I only bisected the
>> rx side issue.)
>>
>> I'm using ath10k 9984 radio with firmware 10.4-3.9.0.2-00070 in station mode.
>>
>> AP is an ath11k Hawkeye...
>>
>> I'm using a 1Mbps UDP packet 'download' stream to make sure I'm seeing
>> rates for data frames
>> and not just management frames.
> 
> Sorry about that.
> 
>> Any idea what might be the issue?
> 
> It may be fixed by https://patchwork.kernel.org/project/linux-wireless/patch/1607483189-3891-1-git-send-email-wgong@codeaurora.org/

Yes, that fixes it.  Looks like it is already in 5.10.4 stable, so I'll upgrade to that.

Thanks for the quick hint.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
