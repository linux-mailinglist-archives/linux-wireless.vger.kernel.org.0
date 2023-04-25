Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA576EE819
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjDYTOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjDYTOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 15:14:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3B3C35
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 12:14:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so3679977a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682450079; x=1685042079;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haVieU44vaE/S1Kd+cX29AOXnP+W1832nsjiFBduO+g=;
        b=RVXEAhrs+mWTaObAbThOqd8EuaLhUN0BshKXWG/uoFKGh7vcVMXXZ4iS1zweOjrmK3
         bWez88/QmZXRCpzUX8YNwTztum8RqXq2qUvnR1zlG0TTjs5/6HcvIEnLsPz2HXjEpWem
         mflWR7Ul291Lg2nc1TmTPFeMVNAoIn5D+oNd1+0KLHImcvU6Dtv8XN4c3LzRSomzsAsJ
         vnsVjIuJMht3txfJL2VtCbIUwEvtyjLT2DwC5n2UYA9QVAovtGlXFRm9YbLheSejDAiP
         nGcNT5yYK7vz1I5985uWalVYMAPnJrf7LZpC8GP6d637teenM6J14jWDvJ1L+Kl/IQYV
         W72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450079; x=1685042079;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haVieU44vaE/S1Kd+cX29AOXnP+W1832nsjiFBduO+g=;
        b=VVQS7k8TFYZybOkFno7QhRAkigpf0urO9iobpZeVR2JQfr0mc6lojLZ4Z1JiQWnuov
         0+bwuqDqYN4qZHLh+3LZmdZWoP8onJN+647nqIOF0pF43bJWN7DoAWvfVvdxswAHWwg4
         KMCeXIqvVq7mcRCYLAgJfxEBVwhj57WDg+cHNEBzjOAVyj3ZQFuhRUC5VI7BxY2dkwrG
         WNBl638whLb65yQECWgdyhsmwU4x9SulejJfuSxaroJUMxw9gzB8huhtXGf4CY/1bpvp
         8CYTrwIY2Mk04X4ztwvsnuEenuN3EyIGyeOQWy3ttYso0CL1JN/nJ+Dd1GwH2ukaKE/5
         bqlQ==
X-Gm-Message-State: AAQBX9eCtehdURmDFev9Msx5mfCntbEw/1MPkgw9hDg5Dt43hg8LnF++
        BejxHvVIDfcQe8PAbpo4lyeDXFPEzku+1w==
X-Google-Smtp-Source: AKy350YykogpTuIxhqi0vg9myhQ7noCNqqeKaRtPdL3vERWUNGjV8p5veo85nfa8/wcuhS2YTDlw2A==
X-Received: by 2002:a17:90a:1101:b0:23d:10f2:bda2 with SMTP id d1-20020a17090a110100b0023d10f2bda2mr18864380pja.30.1682450078972;
        Tue, 25 Apr 2023 12:14:38 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a2b4e00b002466f45788esm8174192pjc.46.2023.04.25.12.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:14:38 -0700 (PDT)
Message-ID: <9c298074-9ae1-e053-d7da-85ca3063058c@gmail.com>
Date:   Tue, 25 Apr 2023 12:14:38 -0700
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
 <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
 <f0383c934075f90d50af6e91aa3307057f6188f8.camel@sipsolutions.net>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f0383c934075f90d50af6e91aa3307057f6188f8.camel@sipsolutions.net>
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

On 4/25/23 11:10 AM, Johannes Berg wrote:
> Hi,
> 
>>> I can't tell with the information you gave - depends on the waiting
>>> period for a response frame you ask for, I guess? With HW ROC (if you're
>>> using iwlwifi) we cannot extend the previous period, see
>>> ieee80211_coalesce_hw_started_roc().
>>
>> This is purely virtual at the moment, but in my case its looking like it
>> cannot be extended either since the CMD_FRAME just queues a separate
>> request.
> 
> Hm. Not sure then? I guess then you'd be falling into the max duration
> or so?
> 
>                  if (!local->ops->remain_on_channel) {
>                          /* If there's no hardware remain-on-channel, and
>                           * doing so won't push us over the maximum r-o-c
>                           * we allow, then we can just add the new one to
>                           * the list and mark it as having started now.
>                           * If it would push over the limit, don't try to
>                           * combine with other started ones (that haven't
>                           * been running as long) but potentially sort it
>                           * with others that had the same fate.
>                           */
>                          unsigned long now = jiffies;
>                          u32 elapsed = jiffies_to_msecs(now - tmp->start_time);
>                          struct wiphy *wiphy = local->hw.wiphy;
>                          u32 max_roc = wiphy->max_remain_on_channel_duration;
> 
>                          if (elapsed + roc->duration > max_roc) {
>                                  combine_started = false;
>                                  continue;
>                          }
> 
> Or maybe that logic here is broken somewhat ...

I guess my assumption was if ROC is currently active then a CMD_FRAME 
(on the same channel) should just go out immediately, not be queued, and 
not even bother checking the duration. (and in this case I'm not even 
setting a duration for CMD_FRAME).

Does the OFFCHANNEL_TX_OK flag have any bearing on this? I found that I 
have to set it even if ROC is ongoing, maybe thats another topic of 
discussion.

> 
>>> Not sure I understand this part. ROC is fine mostly for the "wait for
>>> some frame and send a response", but not so much suited for "send a
>>> frame and wait for a response" part. So 3-way-handshakes are iffy with
>>> it...
>>
>> Yeah, and it actually has worked great for the entire DPP procedure
>> using the same channel (presence -> auth request -> auth response ->
>> auth confirm) assuming both sides respond in a timely fashion.
>>
>> The comes when changing the channel after the auth request. The auth
>> request gets queued separately, which then delays the ROC and we
>> can't/shouldn't send anything until ROC starts. The only strange thing
>> is we actually receive the auth response on the new channel before the
>> ROC for that new channel even starts. Its like the hardware and driver
>> aren't quite in sync.
> 
> Did you say hwsim? That'd be weird. Though in hwsim I think you have an
> additional quirk - it never really *leaves* the original channel it's
> connected on, it kind of sticks around on *both* which isn't real but
> some kind of simplification there. We might want to fix that eventually.
> But not sure it's connected already in this case?

Ah ok, thats probably whats happening then. And it is connected in this 
case. We're connected to a BSS then initiate DPP to configure some 
unprovisioned device. Start the protocol with the channel it used for 
presence announcements, then tell the peer to transition to our 
currently connected channel (by setting the frequency in the auth request).

> 
>> But anyways I think its best to use ROC for presence (waiting for
>> announcements) but then use CMD_FRAME for the rest of the protocol.
> 
> Right, that's pretty much the intent for this kind of thing. Similar in
> P2P where we designed all this, really.

Ok cool, thanks for clarifying

> 
> johannes
