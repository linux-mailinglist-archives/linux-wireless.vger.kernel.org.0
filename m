Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66B7E5C96
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 18:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjKHRqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 12:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKHRqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 12:46:18 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235441BD4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 09:46:16 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8DD3FC00068;
        Wed,  8 Nov 2023 17:46:13 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F0DCC13C2B0;
        Wed,  8 Nov 2023 09:46:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F0DCC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699465573;
        bh=PL+I8Ww16S1IPoqwVyKjZIZH1fVNVtEivdRSPrg5ab0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EZPYcoWo8/2vxF7SfDyDO9HJl5xCUugFwBWarmyR90XiFEwO3o13Ttp7QGqXBdLyb
         QLf5tRMIgOCttom+iPScqOAziJFU2vQWET1QtwW9934n4I4shlGO7tu9lDtwOYq1tS
         RPTrgY9cD/c6FGtCopr2fJweK32+7nE6g/5JKxqk=
Message-ID: <20503f3f-7764-b043-baaa-fbc3c3c4039f@candelatech.com>
Date:   Wed, 8 Nov 2023 09:46:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
Content-Language: en-US
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
 <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
 <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
 <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
 <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
 <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
 <2c079a7405e81715e6ded79cd5fe1d990b458418.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <2c079a7405e81715e6ded79cd5fe1d990b458418.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1699465574-l-0qpESVeMIW
X-MDID-O: us5;at1;1699465574;l-0qpESVeMIW;<greearb@candelatech.com>;13948b997c46854c0bd0ff51e4288855
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/23 09:39, Benjamin Berg wrote:
> On Wed, 2023-11-08 at 17:07 +0100, Johannes Berg wrote:
>>>   From the backtrace in the removal logic, it seems that something waits
>>> for a debugfs file to be closed.
>>
>> Yes, debugfs remove waits for it to no longer have active users, but
>> that cannot succeed because the users are blocked on acquiring the
>> mutex.
>>
>>> Maybe the logic attempting to get the
>>> mutex in debugfs can check if file is waiting to be deleted,
>>> combined with a try-mutex-lock logic, and bail out that way?
>>
>> I don't know if there's a way to check that, but I'm also not sure how
>> you'd even implement that?
> 
> Is it likely that we have lock contention for debugfs operations?
> 
> If it is relatively unlikely, then maybe just doing a mutex_trylock()
> and immediately failing the operation with -EAGAIN could be a solution?
> Obviously userspace would need some retry logic, but that is simple and
> it could solve the delete problem.

That is pretty nasty to expect each and every user-space app anywhere to suddenly
know that file operations are randomly unreliable...

I think we can do this where we only return no useful file data when we are actually
in teardown phase...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


