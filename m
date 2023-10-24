Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564057D5881
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjJXQfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbjJXQfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 12:35:16 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E5133
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 09:35:12 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3CBFF2C0072;
        Tue, 24 Oct 2023 16:35:10 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7D05213C2B0;
        Tue, 24 Oct 2023 09:35:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7D05213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698165309;
        bh=ifRa9iCAConMorJlqUIjtY8Qw+teNxBw+AZTbyQQcnY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=FfxSZIOhKNqJIJVdWr7POo4FGhmSyOHH0NostER30hXNVZqqm0GX47/xG4ZVeoSd5
         ZQ9ai4lpW+g5oN8dfbos+KsMHV0d5pJw93fQm3GmCzutD13/LLWKHv97KE27FuXVv8
         sBIo0vjaGIy6f91rOsXGPD/LBft+3lntjvhR6SnI=
Message-ID: <eaee11ec-a05c-0b04-a399-d88c75a38790@candelatech.com>
Date:   Tue, 24 Oct 2023 09:35:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: mac80211: work around crash in mlme.c
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231023175738.1686631-1-greearb@candelatech.com>
 <08a47f34f85bb64be720e473d5a43193412185a1.camel@sipsolutions.net>
 <c6a2047e-0b01-bdd7-9920-5a1c81aa96b3@candelatech.com>
 <f260261edd307a8befe3561185acc5b24c0d3ff8.camel@sipsolutions.net>
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f260261edd307a8befe3561185acc5b24c0d3ff8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698165311-q7fH1GMqXc57
X-MDID-O: us5;at1;1698165311;q7fH1GMqXc57;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/24/23 01:28, Johannes Berg wrote:
> On Mon, 2023-10-23 at 13:05 -0700, Ben Greear wrote:
>> On 10/23/23 11:17, Johannes Berg wrote:
>>> On Mon, 2023-10-23 at 10:57 -0700, greearb@candelatech.com wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> Protect from NULL ifmgd->assoc_data in ieee80211_mgd_deauth, crash
>>>> was seen here fairly often in a 32-station test case utilizing
>>>> mtk7922 and be200 radios.  I'm not sure if radio types matters
>>>> though.
>>>>
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>> ---
>>>>
>>>> Patch is for wireless-next tree, bug was likely introduced in
>>>> this release since this crash was not seen in earlier 6.6-rc testing
>>>> nor in 6.5 or earlier.
>>>>
>>>> There may be a better way to fix this...
>>>
>>> I mean, you're not *actually* suggesting we merge this patch, right?
>>> Right?!
>>
>> No, but it is easier to explain backtraces when you can see the code that
>> generated it.
> 
> Sure, but why actually post it as a [PATCH] then rather than just part
> of the bug report or something? :)
> 
> Anyway ...
> 
>> The bug appears to have come in with this patch that I grabbed from linux-wireless
>> mailing list:
>>
>> [greearb@ben-dt5 linux-6.6-wn.dev.y]$ git show 4600547c01ef7
>> commit 4600547c01ef728113253c6df9367eb4ed75193c
>> Author: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>> Date:   Thu Sep 28 17:35:34 2023 +0300
>>
>>       wifi: mac80211: add link id to mgd_prepare_tx()
>>
>>       As we are moving to MLO and links terms, also the airtime protection
>>       will be done for a link rather than for a vif. Thus, some
>>       drivers will need to know for which link to protect airtime.
>>       Add link id as a parameter to the mgd_prepare_tx() callback.
>>
>>       Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>>       Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>>
>>
>> I see no response to it on linux-wireless mailing list.  I applied the
>> series locally since it preceded other iwlwifi related patches that
>> I wanted to test.
> 
> I applied the same patch as commit
> e76f3b4a73ea60ef098c5762b2aef4d11e094a04
> Author: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Date:   Thu Sep 28 17:35:34 2023 +0300
> 
>      wifi: mac80211: add link id to mgd_prepare_tx()
> 
> from
> 
> https://lore.kernel.org/r/20230928172905.c7fc59a6780b.Ic88a5037d31e184a2dce0b031ece1a0a93a3a9da@changeid
> 
> 
> It doesn't contain that bug, neither in my version nor in the list
> version.
> 
> Maybe you had some conflicts due to other changes and resolved them
> incorrectly by accident?
> 
>> So proper fix (assuming Miri's patch is applied at all) is to just not
>> assign link-id in this specific case?
> 
> No, it should assign the link ID from the correct place, as Miri's patch
> does :)

My hack/patch did have a typo in it on the second clause, and checked the
wrong thing being NULL.  But, before I got the patch into my kernel, I managed
to hit NPE in both the clauses.  Not immediately...but sometimes.

I noticed afterwards that mtk7922 has a regression where it will not assoc on
6e, and it was 6e test case that reliably triggered the bug, so I suspect
it is something about deauthing a sta that never managed to auth in the first
place.

I guess just keep it in mind if someone else reports the problem.  I'll run locally
with an 'if null, skip assigning link-id' patch.

>> But there is also the case where a patch may be technically OK, and useful
>> to me, but it is not an API or feature that the driver/stack maintainer
>> cares about, so it is ignored.
> 
> Well, it does raise the question of whether we (or often really just
> me?) should maintain something in upstream that's not generally useful,
> or already solved in another way (like ethtool stuff).

I'm not going likely going anywhere.  I have been maintaining my various patches
out-of-tree for a great many years, and that is even worse than maintaining them
in the tree.  So whatever of my stuff makes it into the tree, if you ever find it
needs some work and I don't notice right away, dump it on me and I or someone else
at my company will work on it.

Thanks,
Ben

> 
> Yes, I tend to not want to commit to saying no and let stuff linger, and
> that's really a bad pattern that I have.
> 
>> Regarding my previous patch to fix a
>> crash,
>>
> 
> If you mean this:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20231021154827.1142734-1-greearb@candelatech.com/
> 
>>   I'm not going to spend my time renaming
>> variables on the off chance that you'd like the patch vs just fixing the
>> specific broken code and moving on to other tasks.
> 
> I actually applied it. Someone else was replying there :)
> 
>> Since you known your
>> own mind, you could rename variables in 2 minutes, post the patch, and
>> you'd be done.
> 
> Agree. I think I do that, but maybe not often enough.
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


