Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB46D420C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjDCKdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDCKdC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492313589
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A1D66189B
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C018C4339B;
        Mon,  3 Apr 2023 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680517979;
        bh=Co7LhimcNM0pw8bd0/4VQmCps4FvAiU4Y2M6iZQ38X8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BKb/I2B94R+LYFepsLrZxfdJWdGX7E+cQNFU7RvmRYfaS8ZLkrAHaiOpJr3FZ7AaP
         P2N7eob8+XWxk4XqsUOmxHJRIUm9+EpWW09YJOx4bYuqGSpDoE8bqiW+gEbcZaymcG
         s6UKt7EM/PX3iRzAwDCxiP8T7ra0bQ7cymjyjpMcwnEOWIScUDbQBurpsApHK5vRVq
         sKgSEdMulj0gbdHGXHNbKCIChYwovwWOj/k/3HZ+FHaM/sORzV8Xe7YxeRUto4whIA
         Y+fFuWs6OoXLNtCJkqQfKpODPJP3a/Spwo9qUoaBgLGV0pgTyg+r39T7hyAdpR/WyL
         bqJB5qGL7zYpw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-3-pkshih@realtek.com>
        <87v8j2mmqt.fsf@kernel.org>
        <360e6dd64e3645c68742fc4c603b3c2b@realtek.com>
Date:   Mon, 03 Apr 2023 13:32:54 +0300
In-Reply-To: <360e6dd64e3645c68742fc4c603b3c2b@realtek.com> (Ping-Ke Shih's
        message of "Wed, 15 Mar 2023 12:09:26 +0000")
Message-ID: <875yadb6i1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > +static void rtw89_core_free_tx_wait_work(struct work_struct *work)
>> > +{
>> > +     struct rtw89_tx_wait_info *wait =
>> > +                     container_of(work, struct rtw89_tx_wait_info, work);
>> > +     struct rtw89_dev *rtwdev = wait->rtwdev;
>> > +     int done, ret;
>> > +
>> > +     ret = read_poll_timeout(atomic_read, done, done, 1000, 100000, false,
>> > +                             &wait->wait_done);
>> > +
>> > +     if (ret)
>> > +             rtw89_err(rtwdev, "tx wait timed out, stop polling\n");
>> > +     else
>> > +             kfree(wait);
>> > +}
>> 
>> I admit I didn't try to understand this patch in detail but this
>> function just looks odd to me. Why there's polling able to free
>> something?
>> 
>
> Three works are involved in the "wait/completion".
>
> work 1. remain-on-channel work
>    It trigger TX null data and wait (kmalloc 'wait' object, and wait for completion)
>
> work 2. TX completion by napi_poll
>    It returns TX status (failed or succeed to TX), and complete the 'wait' object,
>    and queue rtw89_core_free_tx_wait_work() to free 'wait' object.
>
>    We queue this by work 2, because time of work 1 is predictable, but
>    it is hard to estimate time of work 2. The read_poll_timeout() is for
>    the work 1 predictable time.
>
> work 3. This work is to do garbage collection of 'wait' object
>    It polls if work 1 is done before doing free 'wait' object.
>
>
> Things are complex because work 1 and 2 are done asynchronously, so one
> of them can't free 'wait' object, or it will causes use-after-free in other
> side.
>
> Use case 1: (work 1 could free 'wait' object)
>     work 1         work 2          work 3
>     wait
>                    completion
>     wait ok
>                                    free 'wait'
>
> Use case 2: (work 2 could free 'wait' object)
>     work 1         work 2          work 3
>     wait
>     wait timeout
>                    completion
>                                    free 'wait'
>
>
> I can add a comment as a hint why we can use a read_poll_timeout() to assist
> in freeing something. 

I would expect that there's polling if you are waiting something from
hardware, or maybe when implementing a spin lock, but not when waiting
for another kernel thread. This just doesn't feel right but I don't have
time to propose a good alternative either, sorry.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
