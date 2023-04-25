Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A86EE83C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjDYT3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 15:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjDYT3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 15:29:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4090A8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 12:29:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b51fd2972so4939915b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682450947; x=1685042947;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im6QHu9hVH3rK0y6D5FEnGteKwBCxTDffMc7HifqWrI=;
        b=bj//Xq3phlrBMlecgzsTBwoTDVLZRtWzp5yWm8ruEW2FRkU/i6vde7WqRLJjtYYCh7
         JbghPhp0sG9mQdhbVpeWmlMOx3P/ADwbhyorWliNYczk+/gJOxSkVbBG1kq1geU8vq6y
         su3frsUrZ0YJlalUdi6N3Uqc2Nn9VUUUkRlXsn1lTixoU4ymk/FxzpKRSDB+4DkWySoz
         UPQbkl9VRbdt9+ZN2qtG5i+WE/7HyQbLnpzuDz3Tigw3Gw8pTq9VYKbjbv48+sdiWJf/
         QupYT0RxrRm8dQtIFL5jXVFp9pZ6Bm0r3Z2rEUb6zHIpxvtZsQ6nxi9tFhWusIf0dB+p
         ZsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450947; x=1685042947;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im6QHu9hVH3rK0y6D5FEnGteKwBCxTDffMc7HifqWrI=;
        b=KQI7kArcHj8DBHZcelMTvJPjobtoRGHIxdWZCAG4nLeSyZ34H2GJ0LC6cwuTlx9eNA
         jPUZnScaOhAzttMJlBcbwzcddDsbCxfQdmbZTfYBKkhtnIaq4UwZCmLLugqSgpmqELxy
         wpebMJ3/cDoI813AZ6pRLbwuca6qUTciRpjSLzm4qIzU20TmflsP4Tt63wE4K2wH7nIs
         HYOUTUAHk84+wQB6kzEwr9qjWw7E6MzPzcYRtYzzQWk22TI6rEjd9UaVvttMQ30yneX0
         uKSeqKWn0X3CZmmHNZL6fKvr6zdqW3KO+KJbYLVfTD/ZtuhRVCU4ICZART3/rtckJ+0A
         gZyw==
X-Gm-Message-State: AAQBX9fcgrPtpyb8FHQBo0p2+QtsffYaAdLkCrQTOoinqGI5L23FO7ew
        vbkusUbOJwgQqB7OJEGNPAktdcx6gk+GxQ==
X-Google-Smtp-Source: AKy350a0tb2f0WDHEAke3jVi3/jMr3mZX/fX7YhMB+Lf94JBI5MEDBUgTVdfNA4PI2lhR8JhDiV/ew==
X-Received: by 2002:a05:6a00:15ce:b0:63d:3411:f9e3 with SMTP id o14-20020a056a0015ce00b0063d3411f9e3mr26947143pfu.19.1682450947296;
        Tue, 25 Apr 2023 12:29:07 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b21-20020a62a115000000b0063b64f1d6e9sm8617707pff.33.2023.04.25.12.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:29:06 -0700 (PDT)
Message-ID: <2cb80ae0-a0f3-22cd-d9af-46f100f36904@gmail.com>
Date:   Tue, 25 Apr 2023 12:29:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
Content-Language: en-US
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
 <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
 <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
 <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
 <f0383c934075f90d50af6e91aa3307057f6188f8.camel@sipsolutions.net>
 <9c298074-9ae1-e053-d7da-85ca3063058c@gmail.com>
In-Reply-To: <9c298074-9ae1-e053-d7da-85ca3063058c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/25/23 12:14 PM, James Prestwood wrote:
> Hi Johannes,
> 
> On 4/25/23 11:10 AM, Johannes Berg wrote:
>> Hi,
>>
>>>> I can't tell with the information you gave - depends on the waiting
>>>> period for a response frame you ask for, I guess? With HW ROC (if 
>>>> you're
>>>> using iwlwifi) we cannot extend the previous period, see
>>>> ieee80211_coalesce_hw_started_roc().
>>>
>>> This is purely virtual at the moment, but in my case its looking like it
>>> cannot be extended either since the CMD_FRAME just queues a separate
>>> request.
>>
>> Hm. Not sure then? I guess then you'd be falling into the max duration
>> or so?
>>
>>                  if (!local->ops->remain_on_channel) {
>>                          /* If there's no hardware remain-on-channel, and
>>                           * doing so won't push us over the maximum r-o-c
>>                           * we allow, then we can just add the new one to
>>                           * the list and mark it as having started now.
>>                           * If it would push over the limit, don't try to
>>                           * combine with other started ones (that haven't
>>                           * been running as long) but potentially sort it
>>                           * with others that had the same fate.
>>                           */
>>                          unsigned long now = jiffies;
>>                          u32 elapsed = jiffies_to_msecs(now - 
>> tmp->start_time);
>>                          struct wiphy *wiphy = local->hw.wiphy;
>>                          u32 max_roc = 
>> wiphy->max_remain_on_channel_duration;
>>
>>                          if (elapsed + roc->duration > max_roc) {
>>                                  combine_started = false;
>>                                  continue;
>>                          }
>>
>> Or maybe that logic here is broken somewhat ...
> 
> I guess my assumption was if ROC is currently active then a CMD_FRAME 
> (on the same channel) should just go out immediately, not be queued, and 
> not even bother checking the duration. (and in this case I'm not even 
> setting a duration for CMD_FRAME).
> 
> Does the OFFCHANNEL_TX_OK flag have any bearing on this? I found that I 
> have to set it even if ROC is ongoing, maybe thats another topic of 
> discussion.
> 
>>
>>>> Not sure I understand this part. ROC is fine mostly for the "wait for
>>>> some frame and send a response", but not so much suited for "send a
>>>> frame and wait for a response" part. So 3-way-handshakes are iffy with
>>>> it...
>>>
>>> Yeah, and it actually has worked great for the entire DPP procedure
>>> using the same channel (presence -> auth request -> auth response ->
>>> auth confirm) assuming both sides respond in a timely fashion.
>>>
>>> The comes when changing the channel after the auth request. The auth
>>> request gets queued separately, which then delays the ROC and we
>>> can't/shouldn't send anything until ROC starts. The only strange thing
>>> is we actually receive the auth response on the new channel before the
>>> ROC for that new channel even starts. Its like the hardware and driver
>>> aren't quite in sync.
>>
>> Did you say hwsim? That'd be weird. Though in hwsim I think you have an
>> additional quirk - it never really *leaves* the original channel it's
>> connected on, it kind of sticks around on *both* which isn't real but
>> some kind of simplification there. We might want to fix that eventually.
>> But not sure it's connected already in this case?
> 
> Ah ok, thats probably whats happening then. And it is connected in this 
> case. We're connected to a BSS then initiate DPP to configure some 
> unprovisioned device. Start the protocol with the channel it used for 
> presence announcements, then tell the peer to transition to our 
> currently connected channel (by setting the frequency in the auth request).

So when you asked about being connected it got me thinking, and I went 
to check and saw I was doing something very stupid. When we switch to 
the new channel its the connected channel, so doing ROC is pointless 
(surprised it actually allowed it). And this avoids the issue in 
question entirely since there is no delay waiting for another ROC, just 
cancel the last request and wait for a frame on the connected channel.

So thats my bad :) The behavior in question is still weird IMO (not 
sending CMD_FRAME right away), but in any case it at least works now.

Thanks for the help getting my brain to work :)

> 
>>
>>> But anyways I think its best to use ROC for presence (waiting for
>>> announcements) but then use CMD_FRAME for the rest of the protocol.
>>
>> Right, that's pretty much the intent for this kind of thing. Similar in
>> P2P where we designed all this, really.
> 
> Ok cool, thanks for clarifying
> 
>>
>> johannes
