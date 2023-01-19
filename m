Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9924673E44
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 17:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjASQJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 11:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjASQI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 11:08:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86A4B882
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 08:08:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i4so1711727wrs.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HS5AIloNlFdyP77OzDYTVAvLNPPVi3Y+4XLB25KQ3Tc=;
        b=YSs19o31s1DmHCOxoroGkOkefLZBIl8VZwlwfIJvID1OZvxcAEWwdDt6qn75NiBdh0
         SfstCsys+x9LsHEN9Yo6cdMxoXZqTpXAg0BrozM4hbaA7WoAPiOlUKwjB8G7F9PFa1d7
         8hh+MVGgYJ8qfWeClntxZdCrSSy8aNYXsmMMQqczW/XQyrMqt+l1n14cJUEp26QVUrvX
         1QRWmwCB8xZeEHAEyOAkLzVW/eCriZyMkiZ0ghQC51JzT1RFSwic2sUsek5/XLfrE88X
         6QhZjP6LfaCq1jvQ/hshXH21I/F+vJGKx+OMo9gQRWTCv4nA+2KvE4/Z2Flw9nOExxlM
         P+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HS5AIloNlFdyP77OzDYTVAvLNPPVi3Y+4XLB25KQ3Tc=;
        b=oez1KvupIBx7v1Y9AjIv2LiyrZzWwqYnUDFMhDlHNslX5xY1VLC0xwM/QmUd2dOaQt
         p/ly5xLckcTfny6krAxtUYDnPtQUfSsx3/u8Pf+38Nlxw0EhM+cAQP7KJTlCO73yO1Ex
         mdRqATbi2HmnECep8Fm4lT/kdq1twMmCqRNzK3PdXup52gf4KjY4pkQIMQqLWuqjtBjN
         jwRooLAul1srotfplAINYEjtHqP3/tOzf9qykBHCI1AiHcJoBl3Y0ijXLtqtS2tyYSjG
         +ZOeB1mlbGvMrUXxt5rxxVGQHrmJuHe1l5UUt/sPjcIAH63q7mCrV/ftD2YTfsqPdiAg
         V71A==
X-Gm-Message-State: AFqh2kpXp37lNu07RiO8lOI3KRwiPU+AkCGLcy0a2MC1H83Ov4zy1Z9n
        dxe300XHH0IEBbaqn7QlE0Y=
X-Google-Smtp-Source: AMrXdXvHBOlpGYplmlcYi3ZXZD0ddYXUGbBu6/BPFP/xFbD4kG2qAlq+/ioAxPky4LYg3Lfh82RhQA==
X-Received: by 2002:a5d:5259:0:b0:2bb:6c90:26a0 with SMTP id k25-20020a5d5259000000b002bb6c9026a0mr10134198wrc.43.1674144533976;
        Thu, 19 Jan 2023 08:08:53 -0800 (PST)
Received: from [192.168.1.8] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm24643312wrr.26.2023.01.19.08.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:08:53 -0800 (PST)
Message-ID: <1c4f6990-299e-be8d-b684-e59b789d4869@gmail.com>
Date:   Thu, 19 Jan 2023 18:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
 <f2f52496d4274861b5870c1f425fa8e8@realtek.com>
 <668921d6-cff5-7b42-3406-f42f445a15ef@gmail.com>
 <ec33046591ca4838aacccdd7dd547ea3@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ec33046591ca4838aacccdd7dd547ea3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/01/2023 02:25, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, January 18, 2023 9:53 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
>>
>> On 18/01/2023 02:52, Ping-Ke Shih wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> Sent: Wednesday, January 18, 2023 6:03 AM
>>>> To: linux-wireless@vger.kernel.org
>>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>>>> Subject: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
>>>>
>>>> If the chip can have an LED, register a struct led_classdev and enable
>>>> hardware-controlled blinking. When the chip is not transmitting or
>>>> receiving anything the LED is off. Otherwise the LED will blink
>>>> faster or slower according to the throughput.
>>>>
>>>> The LED can be controlled from userspace by writing 0, 1, or 2 to
>>>> /sys/class/leds/rtl8xxxu-usbX-Y/brightness:
>>>> 0 - solid off.
>>>> 1 - solid on.
>>>> 2 - hardware-controlled blinking.
>>>
>>> So, do you like
>>>
>>> #define RTL8XXXU_HW_LED_BLINKING	2
>>>
>> I'm not sure what you mean. Can you elaborate?
> 
> Originally, I would like to replace RTL8XXXU_HW_LED_CONTROL by
> RTL8XXXU_HW_LED_BLINKING, because commit messages say "blinking". 
> After reviewing 2/4, 3/4 and 4/4, I aware that this blinking is
> hardware behavior. Then, it becomes hard to me to decide which
> name is clear. Anyway, original is fine to me.
> 
Ah, okay. Now I get it. I will keep the original name.
