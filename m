Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EF6D689E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDDQUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDDQU3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 12:20:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E33C2F
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 09:20:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so133073751eda.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680625224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcIqjbH+cijcl8pWYbgTd1sy+eahfWBaqxFC9SUAAks=;
        b=ESljJ613EoX0a/jKx+iWtquzzbj7IOoraoZuNTAN0dJXiCDiZTgTaxcTfSjh30mYBL
         GUhfhtP2qcUk//VjzbPu/1IjZ6Xlpsbkw+9qSypDT6kSvgYavS1S4R9EvebXr6G4mk1/
         8YlengaX+5/QmB1yAfSPCdIbIwTcpSNpCC0V67CtFbeeE4DWPFspmOaZHla9RhSkTzsA
         DGgHxXXj/3hXYKpQQBukh4LmzmmwdDIuv+atgDyw31s270GrDPne8GVse4P9qwD9Z/wt
         A+dUSbsapynycWbbmLnqblsYSFQBhmVzyd1XJ8HYcjzAaToRTu6iBNEuWtz2GZYvZkQE
         NtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcIqjbH+cijcl8pWYbgTd1sy+eahfWBaqxFC9SUAAks=;
        b=hSBKh/ImS8F0uxrsbwjkz8rEZPD3H7eijRabuEqyqWSuMeHQ2JlJRBsrn5nHROmBWL
         ZDo+rgawdBzypVTDvRwnRh2dCx6xS/ofy7AnC1kSY67JrZCe9qQ/T/CY1XWOgdytuyoe
         QqvqWb1Ys92OMORunlHGZkmJjUftCuexeeaI3e5r0cSQhOtjY2/n/uST9NoXBKSasW35
         GeGLgWJnw4IJrkGT/jkX+IJ5dqkPbcoEze2WAHIcwm6djEUqjHLaTCCEmVx/dhyMOoti
         PTAPM14DRJ1eKcDH6o7W3p7qnyyd9icTQIxpAG94SNbGKkPjWx/XijcxG7adjsRy3kg8
         wW8Q==
X-Gm-Message-State: AAQBX9fkFwiA0yhIMlnPEpFK0U1ARggfuBWuI5wrAYrZPwJU+3qIFYFO
        +aAbZvJ3POxIIzek6xiG32p0qqpSFQW9Wxs3
X-Google-Smtp-Source: AKy350bNpuVYNcMkR+HI5/N0rERkZAqVrEt/1xQaCJpp/IuY/ooehItXDSyhwIInghw3Bt5aYnGVHg==
X-Received: by 2002:a17:906:258c:b0:932:c56a:c19b with SMTP id m12-20020a170906258c00b00932c56ac19bmr139701ejb.22.1680625224447;
        Tue, 04 Apr 2023 09:20:24 -0700 (PDT)
Received: from [192.168.1.15] (cable-24-135-222-102.dynamic.sbb.rs. [24.135.222.102])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906541400b009442efdaf20sm6188286ejo.156.2023.04.04.09.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:20:23 -0700 (PDT)
Message-ID: <ce8001cb-af43-ade4-3f68-36fe7eb0d46f@gmail.com>
Date:   Tue, 4 Apr 2023 18:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: wilc1000 kernel crash
Content-Language: en-US
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org,
        kvalo@kernel.org, mwalle@kernel.org
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
 <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
 <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
 <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
 <20221216101842.jjz3glyotqbbqlk4@0002.3ffe.de>
 <8d6316ef-fd66-0b18-ca5b-bb945ebc5370@gmail.com>
 <f69b432d-f7c0-a03f-870e-c8fc0038feda@microchip.com>
From:   Kirill Buksha <kirbuk200@gmail.com>
In-Reply-To: <f69b432d-f7c0-a03f-870e-c8fc0038feda@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4.4.23. 03:30, Ajay.Kathat@microchip.com wrote:
> On 4/3/23 07:24, Kirill Buksha wrote:
>> [Some people who received this message don't often get email from kirbuk200@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 16.12.22. 11:18, Michael Walle wrote:
>>> Hi,
>>>
>>> On 22/12/09 02:14, Ajay.Kathat@microchip.com wrote:
>>>> No progress yet. I tried to simulate the condition a few times but was
>>>> unable to see the exact failure in my setup so I need to try more.
>>> Shouldn't it also be possible to see the issue by code reading? I've
>>> provided the call tree in my previous mail and my concerns regarding
>>> the locking. Either I'm missing something there or there is no
>>> locking between these threads which could cause this issue.
>>>
>>>> For the other "FW not responding" continuous logs, I got some clue.
>>>> Probably, will try to send that patch first.
>>> Ok, let me know if you have some patches, I'm happy to test them.
>>>
>>> -michael
>>>
>>>
>> Hello,
>>
>> I faced the same kernel oops issue. After analyzing my logs and brief
>> debugging, I agree with Mikhail: the problem seems to be accessing the
>> scan_result pointer after it has been nulled.
> I have submitted a patch [1] which has fix for scan_result NULL pointer
> exception issue. The submitted patch handles the synchronization between
> mac_close() and asynchronous interrupts from firmware. Basically, it
> takes care of blocking the execution of mac_close() till all pending
> works are completed and afterward no new work addition is allowed since
> the close is in progress. It is worth to try with that patch once and
> check it's behavior.
>
> 1.
> https://lore.kernel.org/linux-wireless/20230404012010.15261-1-ajay.kathat@microchip.com/T/#u

Thank you for the patch. I will take a look/test it when I have time.

>> Regarding the solution: if there is a race between two threads (as
>> Michael described earlier), then I think that the locking mechanism will
>> be the most reliable solution. We ran into problems during
>> deinitialization, but driver contains two more places
>> (handle_scan_done() and wilc_disconnect() functions in wilc1000/hif.c),
>> where scan_result is set to NULL.
>>
>> I use NetworkManager to manage networks and I have experienced the same
>> failure multiple times when switching from one WiFi network to another.
>> Keep in mind that switching between networks calls wilc_disconnect() and
>> wilc_deinit() functions and it is not yet clear which one is causing a
>> core dump. I think it's worth at least taking a look at these areas of
>> the code. What do you think?
> If possible, please share the sequence(commands) for Wifi network
> switching scenario. It looks like both functions(mac_close & disconnect)
> are getting called from user context. mac_close() is a netdevice
> callback whereas wilc_disconnect() is a cfg80211 callback. Generally,
> wilc_disconnect() should be enough to disconnect from current Wifi
> network without bringing the complete interface down. Is NetworkManager
> closing the interface(mac_close()) before switching the WiFi network.
>
>
> Regards,
> Ajay

The commands are as follows:
while true; do nmcli c up wlan0-client; nmcli c up wlan0-client-2; done

It takes about 5 minutes until I see the core dump.
I see following message after every command:
...
wilc1000_sdio mmc0:0001:1 wlan0: Deinitializing wilc1000...
...
Message above comes from wilc_wlan_deinitialize() function which is called from wilc_mac_close(). It seems that interface is closed between connections.

Best regards,
Kirill Buksha.
