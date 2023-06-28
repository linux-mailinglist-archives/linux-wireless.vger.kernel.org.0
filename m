Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9435D741275
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjF1N3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjF1N2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 09:28:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A8030EF
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 06:28:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa96fd79feso39930275e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958911; x=1690550911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkL44OxPpbcdbYzT/r8cE9ex42EUso2KOW4LcKcWKGA=;
        b=rDgKTFhkN3bVeHxGibqKZOi6hBLbA0Cweizt3m8QdAayUQ2TyUZCP3YO0PfIcyEzTl
         sgPEtKkvxCROqlY11aCZyr8CHQ04XWUG8e7Iu/OsCOsIZhk5H91NlGRzaUMn5HWCm45e
         LauHbqgOJEr5UDHImvqxqeeo4CqjfZHT6P0llogKcc7lwvcycd+SyEGwrzHJWzL+H058
         iruLVwsINxhwTeDqWSPkHPaO+vGCvkHSM/A8GXdVdhoN8q3r2hvDknurGzA3OpVW8DMm
         wLWN++J9Nba9Fp9X0N8CPkXaRcjJNsxVLPSH4uJCpIzUyEK0edgHbUjtQgKBzk9Bqvbf
         dV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958911; x=1690550911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkL44OxPpbcdbYzT/r8cE9ex42EUso2KOW4LcKcWKGA=;
        b=DM8xI6cqdjICBEle7lx51FkH3cf9/TDkn2wVsLW2bCQ/NsDA95vdCxYbjEJ1C0umQV
         gTZ8lc6VKHDCaphesvvBq6JW9ohwlkZtgpQas6czKwwyEZdepbYUCSZBI5XGsQrvRrbl
         dUUejyQbHJb9FdYvb9KpkbmOcegad+C15zdHW9tDiH3BfAcYQulnSLgN5PLt0NqrXjuu
         C4UUZs2KbLH50QgTCZnyquBmHteGeJ5QM4SQXADHTXfTHnFziWMZpuuTewbiJEbKOKnR
         yhwbXaUF07YZbbgdz5iePRlzwgFpqAdfPtjEviMFNI0nhU71HGgOjGjIxIVM/n0G7H0f
         l3sw==
X-Gm-Message-State: AC+VfDyJuh/H62M/dK8x7jjptXsLWLrsDK/Dd/YXACYMQ/q3OeBruycI
        5EUF8bhELOUhKO7eNurp/aApA5BNp5Y=
X-Google-Smtp-Source: ACHHUZ6zHrK/l5ljK8fO8d3ssJIZc8mFhDiVzoXYmPcAathaoFjJ6cxG4GiCrrc+QLsU1OyO60lteA==
X-Received: by 2002:a05:600c:3790:b0:3fb:5dad:1392 with SMTP id o16-20020a05600c379000b003fb5dad1392mr4416575wmr.17.1687958910770;
        Wed, 28 Jun 2023 06:28:30 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id bf11-20020a0560001ccb00b003062b2c5255sm13327759wrb.40.2023.06.28.06.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:28:30 -0700 (PDT)
Message-ID: <d4c7dbda-a24f-9ff1-3a9f-918034c60f92@gmail.com>
Date:   Wed, 28 Jun 2023 16:28:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Realtek 8822ce connection is very unstable
To:     Giulio Paci <giuliopaci@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     James <bjlockie@lockie.ca>, linux-wireless@vger.kernel.org
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
 <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
 <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
 <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
 <b3c5f2f05d0844dfb4e9f7e943b4cbbd@realtek.com>
 <CA+zRt5HyZaOvDpVUxF9Rfv4rrx4Us1Krs+TeiP-U9QsrA_SX6A@mail.gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CA+zRt5HyZaOvDpVUxF9Rfv4rrx4Us1Krs+TeiP-U9QsrA_SX6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/06/2023 13:35, Giulio Paci wrote:
> Il mer 28 giu 2023, 03:29 Ping-Ke Shih <pkshih@realtek.com> ha scritto:
>> Try below options to see if they can help:
>>
>> 1. try another band (switch from 2GHz to 5GHz or opposite)
> 
> I tried to force 5GHz. And then to force 2GHz. When connected to 5GHz
> it seems a little bit more stable, but still hangs within seconds.
> 
>> 2. try another AP
> 
> I have tried 2 different AP, but the situation is very similar with
> both. One of them supports only b/g/n, so I was able to change band
> only with the other one (which is a hotspot on Android phone).
> 
>> 3. disable WiFi power save by
>>    rtw88_core.ko disable_lps_deep=1
>>    or
>>    iw wlan0 set power_save off
> 
> I tried setting disable_lps_deep=1, but still the connection seems unstable.
> 
>> By the way, when you try disable_aspm=1 and disable_msi=1, I suggest to
>> create a file and add them to /etc/modprobe.d/, and then shutdown and turn on
>> your computer after a while. Because some PCI settings are persistent if only
>> do rmmod/insmod.
> 
> I confirm this is the approach I used in all my attempts, including
> disable_lps_deep=1.
> I also checked /sys/module/$module/parameters/$option content, to
> confirm that the options were correctly set.
> 
> I have also carried out some additional attempts:
> 
> - boot with iommu.passthrough=1 instead of pcie_aspm=off, but it does
> not seem to improve anything (and AER errors came back in the dmesg);
> - After my comments on https://github.com/lwfinger/rtw88/issues/150,
> https://github.com/lwfinger/rtw88/ was updated and I was able to load
> these modules. The connection is still very unstable, but with these
> modules, when the connection hangs, dmesg reports:
> 
> rtw_8822ce 0000:03:00.0: firmware failed to leave lps state
> 
> sometimes followed by:
> 
> rtw_8822ce 0000:03:00.0: failed to send h2c command
> 
> I have tried to set some of the options above using modules from
> https://github.com/lwfinger/rtw88/, but so far, apart from these
> additional messages, the results are almost identical to the
> precompiled modules that come with Debian.
> 
> 
> One of my colleagues has the same hardware (same AP model and same
> laptop model) and also tried to install Debian bookworm on it. I asked
> to check if he experiences the same issue, but in his case he was able
> to stay connected for a few hours without any issue.
> I wonder if the issue I am experiencing could be due to defective
> hardware (initially I excluded it since the same configuration is very
> stable under Windows). Is there any specific test that I can try to
> exclude hardware issues?
> 
> Bests,
> Giulio

You can swap the wifi cards in the two laptops. Make sure to unplug
the charger and the battery before working inside.
