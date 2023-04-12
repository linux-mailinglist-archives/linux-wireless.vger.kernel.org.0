Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AC6DF651
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDLNAd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLNAc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 09:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746BC0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 06:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA4763132
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 13:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82923C433EF;
        Wed, 12 Apr 2023 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681304430;
        bh=qlGbQmaFkeUZea4Edcnrn7PLgWR7fNj/3t1cgsC08Bg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fe3sNzZUg1TC8CSnRmJHJfBoVhsr2DCUFoPFKfAcX7KVkJXFx7XCzI2rYHfwoeiRc
         8m3lIcJuMCRCPg5Y9MxMUdMHC7PZtMM60KmXuJIS+1Ir+xNsgVRsWVGIyZkfkllOzA
         RZ7zBXBzB3Kgl1/byzK0n+pCOilQm+7KP9TFDo0RTTBPRkCpN2u5N7k+1FFGK0z9BT
         an0I6biENSLQN+Dy5bvR2EpkommZrXV5FcTEmWKcuSs+N8RDnLSjjhNlU5L6iAJ4F2
         MB2olORtLD1rzk3x+3K5VuYaXTjxHbYd6naM+eaZv7480YHGacpf3gmN81RG1H5BpQ
         1BOwnJoVHaJ8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-3-pkshih@realtek.com>
        <87v8j2mmqt.fsf@kernel.org>
        <360e6dd64e3645c68742fc4c603b3c2b@realtek.com>
        <875yadb6i1.fsf@kernel.org>
        <761e605b96d734881dc51be4679f3a04c75abb89.camel@realtek.com>
        <56831ba4f216daee09b3d9c9a7deaf5810cade34.camel@realtek.com>
Date:   Wed, 12 Apr 2023 16:00:27 +0300
In-Reply-To: <56831ba4f216daee09b3d9c9a7deaf5810cade34.camel@realtek.com>
        (Ping-Ke Shih's message of "Tue, 11 Apr 2023 13:01:36 +0000")
Message-ID: <8735558dck.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Tue, 2023-04-04 at 10:37 +0800, Ping-Ke Shih wrote:
>
>> On Mon, 2023-04-03 at 13:32 +0300, Kalle Valo wrote:
>> > I would expect that there's polling if you are waiting something from
>> > hardware, or maybe when implementing a spin lock, but not when waiting
>> > for another kernel thread. This just doesn't feel right but I don't have
>> > time to propose a good alternative either, sorry.
>> > 
>> 
>> I have found a solution that uses an owner variable with a spin lock
>> to determine which side to free completion object. Simply show two use
>> cases below:
>> 
>> Use case 1: (normal case; free completion object by work 1)
>>     work 1                                work 2
>>     wait
>>                                           (spin_lock)
>>                                           complete
>>                                           check & set owner --> owner = work1
>> 		                          (spin_unlock)
>>     wait ok
>>     (spin_lock)
>>     check & check owner --> free by work 1
>>     (spin_unlock)
>>     free completion
>> 
>> 
>> Use case 2: (timeout case; free completion object by work 2)
>>     work 1                                work 2
>>     wait
>>     wait timeout
>>     (spin_lock)
>>     check & set owner --> owner = work 2
>>     (spin_unlock)
>>                                          (spin_lock)
>>                                          completion
>>                                          check & set owner --> free by work 2
>>                                          (spin_unlock)
>>                                          free completion
>> 
>> I will apply this by v5.
>> 
>
> We have a better idea that use kfree_rcu() to free completion, so no
> need spin_lock(). Then, the use cases become below, and I have sent
> this change by v6.
>
> Use case 1: (normal case)
>     work 1                                work 2
>     (rcu_assign_pointer(wait))
>     wait
>                                           (rcu_read_lock)
>                                           wait = rcu_dereference();
>                                           if (wait)    --> wait != NULL
>                                               complete
>                                           (rcu_read_unlock)
>     wait ok
>     (rcu_assign_pointer(NULL))
>     kfree_rcu(completion)
>
>
> Use case 2: (timeout case)
>     work 1                                work 2
>     (rcu_assign_pointer(wait))
>     wait
>     wait timeout
>     (rcu_assign_pointer(NULL))
>     kfree_rcu(completion)
>                                           (rcu_read_lock)
>                                           wait = rcu_dereference();
>                                           if (wait)    --> wait == NULL
>                                               complete
>                                           (rcu_read_unlock)

Thanks, I haven't had a chance to look at v6 yet (nor v5 for that
matter) but at least based on this mail your idea looks much better than
polling.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
