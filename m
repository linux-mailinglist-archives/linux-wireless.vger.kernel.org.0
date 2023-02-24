Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20AB6A1EFF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBXPzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBXPzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 10:55:12 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441A13516
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 07:55:11 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso1668584otb.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2W2Gqr5PNwSjMYUJdjGYZMDACYzsMA6ZYns91GfnXyM=;
        b=E/HsUwgwqHvW0yvlBWR9uv4xREwKAdvv9frUV/EA3g+EvapwAGg1J+P9OZ2477DQL7
         tsk0EO4YYrmabtckmcBz4TAIZxxtotEGV6GxVtmJnet23P5IrfI7J+DulTulgkbu4xJn
         CFcwVaHWsOanB4NqGLN7WcuwZ6uxLlPNBMTjxltoMfkqFCCwCMaHJcBgifqi5i03tiT0
         nbbJ9dAqcAGHASKny/2bOLb4qds5wMWLU8dUPJeEcDGH5VuqfDpl/G3/KLaV/Tu5thUj
         QkVX9f/q3Y0juoc1P5B2wS9+QbHL4FzGNvElKbzZk/FdmTPxeEkXkPyZWn5xbD2t5OWL
         ijUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2W2Gqr5PNwSjMYUJdjGYZMDACYzsMA6ZYns91GfnXyM=;
        b=vz6+bPesCIK7RojFGxiPFREBldmmPKFHqafAtjJjiHWxGTenUqGPCKIsG3QUXplghv
         rRJyFy74RoufKgQQwUCFpBEqm9folsPkO/J0A0A9sCPyTINUr9nW9Lr5W5IXqJexuu4z
         gMGP1tMkcrlXxmr4AXH8dNxEfKPO7SAmXFYKCvL43oJ3cSKYXRYDmedTska9WZP3CaVc
         xqoMcCAXYSJUcBp7HF+iuBCWU4PL7TvsE0f17CsUUEHmlU4a6M2osz3SxXz9Wtl5j6w2
         lWJZgq58acaSK3PIsWW4ZuC+bCh0m/WhGlW476p+E4FLIlain9sM8nAZNIYNiOj6IXEL
         42MA==
X-Gm-Message-State: AO0yUKWO2U4T211kpGgq162O3bJMgnU8BLcJNa3jXNsuUbwXhKNqGzi9
        0iE5jjA6XePD1k2wikBorW4=
X-Google-Smtp-Source: AK7set9/IjVSmHegGjck3fP5hAskU53eci9bPzFJTcrYmdihHYcoks0+Qee9EhkTiFoFpfPmH2Xgqw==
X-Received: by 2002:a9d:1b4d:0:b0:68d:972e:e8dd with SMTP id l71-20020a9d1b4d000000b0068d972ee8ddmr8380584otl.29.1677254110955;
        Fri, 24 Feb 2023 07:55:10 -0800 (PST)
Received: from [192.168.0.156] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w6-20020a9d5386000000b00690e6d56670sm3327276otg.25.2023.02.24.07.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 07:55:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1212c259-1125-45d8-30d5-6d53284ab492@lwfinger.net>
Date:   Fri, 24 Feb 2023 09:55:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in
 wireless_warn_cfg80211_wext()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
 <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
 <93bc48d2-a692-3709-e323-929600f37646@lwfinger.net>
 <87pm9zryzu.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87pm9zryzu.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/24/23 07:09, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
>> On 2/23/23 02:12, Johannes Berg wrote:
>>> On Wed, 2023-02-22 at 14:49 -0600, Larry Finger wrote:
>>>> Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
>>>> usage") introduces a warning when wireless extensions are used with
>>>> cfg80211 drivers. Although such a warning is desirable, the current
>>>> implementation overflows the dmesg buffer with thousands of warnings,
>>>> all of which are the same.
>>>>
>>>
>>> What are you seeing them from?
>>>
>>> This is rate-limited, so not sure why you're getting so many?
>>>
>>>>    A WARN_ONCE() call is sufficient.
>>>
>>> I think a WARN is inappropriate (it's a userspace 'issue', not an in-
>>> kernel consistency problem), but I guess we could pr_once().
>>>
>>> But that's not great because it only shows a single application that was
>>> still using it, not if there are multiple.
>>>
>>> Hmm. Not sure what to do. Let's start with "why are you getting it so
>>> much". Maybe we can somehow print it less, or try to do per application
>>> once, or something.
>>
>> Johannes,
>>
>> This patch has a magic number, but it does the job:
>>
>> diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
>> index 13a72b17248e..22a67172a163 100644
>> --- a/net/wireless/wext-core.c
>> +++ b/net/wireless/wext-core.c
>> @@ -637,12 +637,27 @@ void wireless_send_event(struct net_device *      dev,
>>   EXPORT_SYMBOL(wireless_send_event);
>>
>>   #ifdef CONFIG_CFG80211_WEXT
>> +
>> +#define ARRAY_MAX  15
>> +static char name_array[ARRAY_MAX][TASK_COMM_LEN];
>> +static int array_count = 0;
>> +
>>   static void wireless_warn_cfg80211_wext(void)
>>   {
>>          char name[sizeof(current->comm)];
>> +       int i;
>>
>> -       pr_warn_ratelimited("warning: `%s' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211\n",
>> -                           get_task_comm(name, current));
>> +       get_task_comm(name, current);
>> +       for (i = 0; i < array_count; i++) {
>> +               if (!strncmp(name, name_array[i], TASK_COMM_LEN))
>> +                       return;
>> +       }
>> +       /* Found new one - print warning and add to array */
>> +       strncpy(name_array[array_count], name, TASK_COMM_LEN);
>> +       if (array_count < ARRAY_MAX)
>> +               array_count++;
>> +       pr_warn("warning: `%s' uses wireless extensions that are
>> deprecated for modern drivers; use nl80211\n",
>> +               name);
>>   }
>>   #endif
> 
> This looks a bit complicated. What about printing the warning once per
> boot using pr_warn_once()? That way we would not annoy people too much
> but hopefully still motivate the applications to switch to using
> nl80211.
> 
>> Looking at my log, I do get only one for each application.
>>
>> finger@localhost:~>dmesg | grep warning | grep nl80211
>> [    8.826056] warning: `nspr-2' uses wireless extensions that are
>> deprecated for modern drivers; use nl80211
>> [   17.212260] warning: `kded5' uses wireless extensions that are
>> deprecated for modern drivers; use nl80211
>> [   17.252420] warning: `Qt bearer threa' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>> [   22.664380] warning: `akonadi_notes_a' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>> [   23.058001] warning: `akonadi_maildis' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>> [   23.175135] warning: `akonadi_mailmer' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>> [   23.329265] warning: `akonadi_followu' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>> [   24.075119] warning: `akonadi_sendlat' uses wireless extensions
>> that are deprecated for modern drivers; use nl80211
>>
>> I have no idea why most, if not all, of those applications even care
>> about wireless. As you can see, I get 8 messages in a relatively short
>> time, thus I selected 15 as the size of the array.
> 
> Oh man, that's a lot of applications. Are these all KDE or QT
> applications, maybe libqt uses Wireless Extensions for something?
> 
> Linus also reported that he is seeing spam from google-chrome:
> 
> https://lore.kernel.org/all/CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com/
> 
> So there are a lot more applications using the outdated Wireless
> Extension interface as we originally thought. It will take a long time
> to get rid of WE usage :(

Kalle,

Yes, my patch is a bit complicated, but it provides information that can be sent 
upstream to get proper fixes for all applications - a "feature" lacking if a 
simple pr_warn_once() is used. As I told Johannes and Linus in my previous 
E-mail, I will keep my patch locally to accumulate usage info for more than the 
first instance of this warning.

I do not know anything about Akonadi internals, but the rest of the warnings 
seem to come from KDE or QT. I agree that libqt is a likely culprit.

Larry


Larry

> 

