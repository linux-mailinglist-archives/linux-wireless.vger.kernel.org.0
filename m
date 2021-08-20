Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8E53F2E99
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhHTPJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 11:09:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:55278 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240830AbhHTPJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 11:09:36 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.178])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 33C111A006C;
        Fri, 20 Aug 2021 15:08:57 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EC510B00017;
        Fri, 20 Aug 2021 15:08:56 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id AA9D813C2B1;
        Fri, 20 Aug 2021 08:08:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AA9D813C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629472136;
        bh=4IYuTzG8CyRKnbhBsPfmXxh3KG2A7Xh9Jhn2VvBrPJQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=UWRHkvfKTzINRmDaGERq4jRurmFOWyBc6Qx3xlUYmKOiBzo6hGPBc1/AeVRE+YGqO
         cTMqtn0IKMcdUZjxm3l7EdOfzzu2bj48dfiXcpCqlasg5h6rDA9zs2jv9F6KpWPHt7
         DNpaqAtdvbCIOrKH2bmqlwvNZBgTa07fo/qNDs6g=
Subject: Re: question on HE debugfs output
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <578da3a0-f029-4e60-d4e6-34d42def62e8@candelatech.com>
 <2c55dce18c94d778207b3fc452a09e14ee80c032.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <dd40890b-c8a1-e3c1-d234-672179dc6331@candelatech.com>
Date:   Fri, 20 Aug 2021 08:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2c55dce18c94d778207b3fc452a09e14ee80c032.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1629472137-LfiB1ebh1LNv
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/20/21 2:17 AM, Johannes Berg wrote:
> Hi Ben,
> 
>> While poking around in things, I noticed that the
>> he_capa debugfs is not showing the least-common-denominator, but rather
>> more specifically the peer's capabilities.
>>
>> This could be bugs in how I'm using this, but thought I'd ask to
>> see if this was on purpose or not.
> 
> It was on purpose. Also, for HE it's different from HT/VHT in that we
> don't do this in the stack any more.
> 
> I'm not really sure _why_ now (or if we should change it), but I seem to
> remember it was just a lot more complex to do in general, but drivers
> didn't really care so much since they tend to have a lot of hard-coded
> assumptions, e.g. they might not care about seeing 2, 3 or more streams
> supported if their code assumes the device always only supports 2 in the
> first place, so all they need is a >= 2 check in this case, for example.
> 
> If you wanted to change that, I wouldn't mind, but it might be complex.

Ok, for now it is a curiosity.  While hacking on things (to disable 160Mhz
support so that a station can be forced to 80Mhz when radio supports 160),
I ended up writing code to take the station HE capabilities from the driver
and then modify them.  Other code in mac80211 is already sort of doing this
here and there.  So, maybe that is a way to start consolidating the
'overrides' logic to build a more proper HE capab in mac80211...

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
