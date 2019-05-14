Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988701CE66
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfENRzv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 13:55:51 -0400
Received: from [208.74.158.174] ([208.74.158.174]:54604 "EHLO
        mail3.candelatech.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfENRzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 13:55:51 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0923D13C283;
        Tue, 14 May 2019 10:55:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0923D13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1557856550;
        bh=1oLOTWzN5aUL+BV36V/HH5i+dM7TibE9gwI1+9t2OI0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gctrmng/rcmgK71WC2Fxf0uAi4sLb++t+7wSccPobluuRXnaSZNTmSMTqnmYMgduu
         kcsAwkl0DIu91ypAtlVMfNWUEf7g9ISYGpiKzlldeymjeinfzUOoARBdxvlNtvvFRE
         4x/R7+Tve1UC/1OAqVKxYGJsHIaKFN4kCvQHGsvA=
Subject: Re: [PATCH v2] mac80211: remove warning message
To:     Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
 <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
 <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
 <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
 <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
Date:   Tue, 14 May 2019 10:55:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/14/19 8:44 AM, Joe Perches wrote:
> On Tue, 2019-05-14 at 11:12 +0200, Johannes Berg wrote:
>> On Tue, 2019-05-14 at 17:10 +0800, Yibo Zhao wrote:
>>> On 2019-05-14 17:05, Johannes Berg wrote:
>>>> On Tue, 2019-05-14 at 17:01 +0800, Yibo Zhao wrote:
>>>>> In multiple SSID cases, it takes time to prepare every AP interface
>>>>> to be ready in initializing phase. If a sta already knows everything
>>>>> it
>>>>> needs to join one of the APs and sends authentication to the AP which
>>>>> is not fully prepared at this point of time, AP's channel context
>>>>> could be NULL. As a result, warning message occurs.
> []
>>> I was planning to use WARN_ON_ONCE() in the first place to replace
>>> WARN_ON() then after some discussion, we think removing it could be
>>> better. So the first patch was based on my first version which is sent
>>> incorrectly. Please check again.
> []
>> I guess changing it to WARN_ON_ONCE() makes sense,
> 
> WARN_ON_RATELIMIT exists.

We know the WARN hits, we have the backtrace, and it is easy enough (in my setup
at least) to reproduce this.  So, the WARN logic has done its job.

Having more of these spam the kernel doesn't add much benefit I think.

Anyone have any suggestions on how to fix the underlying issue?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

