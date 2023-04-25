Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF66EE724
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjDYRx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjDYRxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 13:53:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE9CC0B
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 10:53:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24736992dd3so4021591a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682445234; x=1685037234;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6oJYcosfRwbbNU06NwcMZ9ejTrlBEGEzTe2JmcdvzY=;
        b=RLCiqXMEQXGOulGjxIUjD+rInyUnC/2YtBJu5e+JYpw3+rk9py/xmwpuHAIsKyL6Bd
         ht0b7L50WQqIhElm0ShIUqU2C3MKbJvprOfQN/DJEnKXXImRehn2ZvJgRNfhiNNgJH5Y
         MoO8uUmOMtGw8ZgkjOHVfZJ1cLryPK48dxHRV50FFNpC2T9HEdm61SXEHEW2Y+C35Qrk
         JKfUA55MukASBp1zffKTgntiCxiS6Vv3wAv5d9Uhxqc5Pq/vec7grSHBdx2BN3cIH5Gw
         sxWotgaJIYhPpbapkLm/J5htMCWowZ96eyrixwLlLv5I4OlcD5cKLNdtWHz9B6QVgTWI
         +RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445234; x=1685037234;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6oJYcosfRwbbNU06NwcMZ9ejTrlBEGEzTe2JmcdvzY=;
        b=SmUbmdlt87MctLC8ssoGqT047AnLJZLHBnyTu6cN0ARSNdrK1WT6hinM2b4oNsms3T
         uUyNj22u8Kf4u+ESsRpQfO/AVABm+4/LEFdeQeMlxhBt7WfD0CBlI41B+cpVZXg1ABuf
         C6eaL2FjAPeO6VZMhMoKXxfOva3w/Ht8x9vM/2NQYKqI9GXRsxv7OH+1WwdMdTWOhPTm
         XfHC16Xn/IUYjePBQp9bXSf0TCPlhH85rVlA1r5jmbSenqkcF5cvjABndwnYEVSunFNR
         Rvgndynkc1DhK/AmalWBp9Ew8ZtcYBAdmTakrtLPmva8DhCjcP7//o9hwTavNdljdiUk
         Jbew==
X-Gm-Message-State: AAQBX9eycWBJbnc0cfX/kX2oH99OcEPkrImhQkyMVUJUPbqEmfnp91VK
        eTdHKJF9BZuI53w/xrv53L73pqkTpOtszg==
X-Google-Smtp-Source: AKy350Ybf2ZrcXkIUIcu+/7asFj2BLew2gS+8ZwpVCq4IgxLUje+Es362TcFk3QUSfMG66la5AOhmg==
X-Received: by 2002:a05:6a20:7345:b0:f0:f610:2e0 with SMTP id v5-20020a056a20734500b000f0f61002e0mr24538407pzc.1.1682445234059;
        Tue, 25 Apr 2023 10:53:54 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id 189-20020a6304c6000000b00513cc8c9597sm8281013pge.10.2023.04.25.10.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:53:53 -0700 (PDT)
Message-ID: <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
Date:   Tue, 25 Apr 2023 10:53:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
 <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
 <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 4/24/23 10:36 AM, Johannes Berg wrote:
> On Mon, 2023-04-10 at 15:49 -0700, James Prestwood wrote:
>> On 4/7/23 11:47 AM, James Prestwood wrote:
>>> Hi,
>>>
>>> I'm having an issue with CMD_REMAIN_ON_CHANNEL taking a full second to
>>> become ready versus CMD_FRAME (offchannel_ok=1) which is quite fast.
>>> Under the hood it looks like both commands call
>>> ieee80211_start_roc_work() so its curious why one would take so long.
>>> I'm running this in UML so I shouldn't be hitting scheduling problems
>>> (at least that's how I understand UML).
>>>
>>> This happens during the DPP auth exchange, I can include a full log if
>>> desired, but this is the sequence:
>>>
>>> - Start ROC on 2417mhz
>>> - Wait for ROC event indicating we are offchannel
>>> - Receive DPP presence announcement from enrollee
>>> - Send DPP auth request, request enrollee switches to 2412mhz
>>> - Send Cancel ROC (and wait for confirmation)
>>>
>>> - Start ROC on 2412mhz
>>> - Oddly, receive the enrollees auth response before ROC event. So the
>>> driver _did_ switch channels.
>>> - ROC event comes about a second later, and enrollee has timed out
>>>
>>> So the driver is in fact going offchannel to 2412 and even receiving a
>>> frame. But for whatever reason it doesn't send the ROC event for a full
>>> second. Any idea why the ROC event is so delayed here?
>>
>> After a lot of kernel prints I think I know whats going on, but still
>> somewhat confused.
>>
>> It appears that sending a frame then immediately canceling the ROC
>> request is the issue. The kernel seems to be queuing the CMD_FRAME
>> rather than adding it to the ROC request (is this expected?).
>>
> 
> I can't tell with the information you gave - depends on the waiting
> period for a response frame you ask for, I guess? With HW ROC (if you're
> using iwlwifi) we cannot extend the previous period, see
> ieee80211_coalesce_hw_started_roc().

This is purely virtual at the moment, but in my case its looking like it 
cannot be extended either since the CMD_FRAME just queues a separate 
request.

>   
>> To simplify the above sequence without DPP specifics:
>>
>> ROC on 2417mhz
>> ...
>> Send frame on 2417mhz (queued)
>> Cancel ROC request.
>> ROC request on 2412mhz (queued)
>>
>> At this point the kernel waits for the first (canceled) ROC to complete,
>> then processes the frame request (which requires going offchannel
>> again). THEN its able to handle the second ROC request.
> 
> What are the durations asked for, and waiting for response or not?
> 
>> Anyways, maybe ROC is the wrong way to be doing this? It was convenient
>> because its much easier to set some ultimate timeout then fire off
>> frames as needed in that duration in addition to listening for presence
>> announcements... But maybe ROC is just very limited in what can be done?
>> and using CMD_FRAME + a duration is the only way the kernel can support
>> this nicely?
> 
> Not sure I understand this part. ROC is fine mostly for the "wait for
> some frame and send a response", but not so much suited for "send a
> frame and wait for a response" part. So 3-way-handshakes are iffy with
> it...

Yeah, and it actually has worked great for the entire DPP procedure 
using the same channel (presence -> auth request -> auth response -> 
auth confirm) assuming both sides respond in a timely fashion.

The comes when changing the channel after the auth request. The auth 
request gets queued separately, which then delays the ROC and we 
can't/shouldn't send anything until ROC starts. The only strange thing 
is we actually receive the auth response on the new channel before the 
ROC for that new channel even starts. Its like the hardware and driver 
aren't quite in sync.

But anyways I think its best to use ROC for presence (waiting for 
announcements) but then use CMD_FRAME for the rest of the protocol.

Thanks,
James


> 
> johannes
