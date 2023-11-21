Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9387F320A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKUPOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjKUPOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 10:14:17 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0119A
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 07:14:12 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77784edc2edso364846285a.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700579651; x=1701184451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m18ZEuLNw7SFuM/At9/C0XioS5uJCftOiNsRL9m7KNY=;
        b=VWjixK+Bm4vWHxS5zxDs+e0IhcSQWaPL4H0yIkPDCEFVozaRcbUmWvEIyT75PLPQA8
         DqCwZIDbaYl9vLaWwEVTX+I5t0XugWNbHKIuXQRcPE6aoF48YkOqsZ4OvHYEocf2Nza8
         wj4U2aptEUod364QrZfThCRqpJ/Uab2ngkCCTrX694b6bxFFXUzK0ksIAhW3+Nm1+x+q
         zB3yNqCeGf8o0Yck89moAXDBuy4S/DKtqga/9aMXLeJ6s3lMXfeCvuHo5ohAlY8XQqG6
         JrJeOc0wQW0gs4cI72ytQYIr5vJbcKlizkELDzompN2C6s3ZA59nQNuOlovAjascl0zG
         PDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579651; x=1701184451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m18ZEuLNw7SFuM/At9/C0XioS5uJCftOiNsRL9m7KNY=;
        b=RhCVtVCQHTFV4cfb+hkrhvY6T5Ez5EAI/hdJfrqT6CshiK2wq+TvqCwPTHm1p5fEEc
         ViNHKGVGoZ6zWS9icoQmGYbO3Fo0xppwm9BKO7+CdIMTZo4+NB/BxkDPjYZBFtW93w3g
         tCKIfTyeaJpbxsXPKHeh+7zoVwBH7rM7sUZsu7nDkgsgJab7KfzhBT95MfuLY06iOfQC
         RJ5Mg3dQb0UVX9U0muCrt8YfkkZFxMNe5iBMZmDjAbkMX9GVKMCDCnWRedQDJbRw/VDz
         bIbkxhr0LyoYd67Q/YvxaeNRAnlz9YDLo0QKIXdIIRcPHdSiOBiENmS6vwqQmcRlha3D
         uaAw==
X-Gm-Message-State: AOJu0YwbQDqQqH3/EAKvOOzUNIwo9Y9rFTrVjD/uTez4YW6sBM+PxqDu
        mtnQl5uod1Qq+VxpmgKJSAPMgohOimY=
X-Google-Smtp-Source: AGHT+IH6VbZJcYLjUiF3iA2Sv9k64F/4HwgaDg2y5WJBh7lyf5VeL2OaZ7OQYNN5C6HNjzoxg/Ja0w==
X-Received: by 2002:a05:620a:8f0f:b0:76d:268b:9741 with SMTP id rh15-20020a05620a8f0f00b0076d268b9741mr9080279qkn.17.1700579651483;
        Tue, 21 Nov 2023 07:14:11 -0800 (PST)
Received: from [10.175.109.209] ([208.195.13.131])
        by smtp.gmail.com with ESMTPSA id bj35-20020a05620a192300b0077d6084e205sm112833qkb.15.2023.11.21.07.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 07:14:11 -0800 (PST)
Message-ID: <fb855941-d70e-4ff6-9f3f-87bfcbcad1c9@gmail.com>
Date:   Tue, 21 Nov 2023 07:14:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Power save setting while interface is down
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com>
 <87msv76vma.fsf@kernel.org>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87msv76vma.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 11/21/23 06:15, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> Hi,
>>
>> I've noticed a somewhat rare behavior (<1% of the time) where bringing
>> an interface up fails after disabling power save. This is done by IWD
>> when a user-option is enabled, and follows an interface
>> removal/creation. The sequence is:
>>
>> 1. Remove default interface
>>
>> 2. Create new interface
>>
>> 3. Disable power save on new interface
>>
>> 4. Bring up new interface (rarely fails with -110).
>>
>> iwd[1286641]: src/netdev.c:netdev_disable_ps_cb() Disabled power save
>> for ifindex 54
>> kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
>> iwd[1286641]: Error bringing interface 54 up: Connection timed out
>> kernel: ath10k_pci 0000:02:00.0: Could not init core: -110
> So I guess you have a test setup to reproduce this easily? How long does
> it take to see this?

It really depends. I was letting IWD do the work and waiting excessively 
which could sometimes take an hour. But I managed to get it to happen 20 
seconds apart using ip/iw in a loop. On average it usually happens 
within 5-10 minutes, sometimes sooner.

$ dmesg --follow & $ for i in $(seq 1 4000); do sudo ip link set wlan0 
down; sudo iw dev wlan0 set power_save off; sudo ip link set wlan0 up; done

[ 882.927218] ath10k_pci 0000:02:00.0: wmi service ready event not 
received RTNETLINK answers: Connection timed out [ 883.016550] 
ath10k_pci 0000:02:00.0: Could not init core: -110 [ 904.434930] 
ath10k_pci 0000:02:00.0: wmi service ready event not received RTNETLINK 
answers: Connection timed out [ 904.524287] ath10k_pci 0000:02:00.0: 
Could not init core: -110

> What hardware and firmware version are you using?
[    5.680909] ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 
chip_id 0x00340aff sub 1dac:0261
[    5.680921] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 
tracing 1 dfs 0 testmode 0

[    5.681607] ath10k_pci 0000:02:00.0: firmware ver 
WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2

I've seen this on 00241, 00288, and the latest firmware above.

>> I'm thinking maybe there is a race between creating the fresh
>> interface and disabling PS, then bringing the interface back up?
> Yeah, looks like it. If it's relatively easy for you to reproduce this
> you could try adding delays to suitable spots in ath10k. That might be
> give more ideas where the race is exactly.

Ok, I can add a delay ahead of the WMI request that's timing out and see 
what happens.

>
>> Setting PS after the interface is up (so far) seems to be 100%
>> reliable and have not yet seen this behavior. Regardless of any kernel
>> fixes I'll need to reorder the command sequence in IWD to support
>> existing kernels, but before I work around this issue I wanted to
>> point it out so its not hidden from view.
> To me working around this in user space doesn't sound like a good idea.
> I would rather have a workaround in the kernel (but obviously I hope we
> can find a proper fix).

Yep, totally agree.

Thanks,

James


