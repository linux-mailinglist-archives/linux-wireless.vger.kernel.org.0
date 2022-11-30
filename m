Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1388163D96A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK3P2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 10:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3P2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 10:28:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605748763
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 07:28:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fy37so42139581ejc.11
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54TAPFfJ8uPjFjvPV9iyvnp+RskK6ie4izbT7lZlwmM=;
        b=Eebu/fa617gAKUwxuOrXYyzns96eQPqUaNhAjxMq3Vq1EuUj6YyhrohOXNKd6LDZTK
         rpSFPYOJvb+EFzPBR4uNxmvU6aQOk/vRFEmTG1iVqA3Oe7IxDMg8AzAQHQkg4qKS/MKU
         0CzqRvOVNJwv5JGVNnLYJzpbSxiCBQMQ+6gWR8+qaWQY7V/1qYXyMdz36iAUlBKUrG+1
         zPGiTRG0BUTDnqnPbCRBkVUM46LHO8G3ux3YaD3CISbWKcsKfi31+uPs0x35k/SIuYtB
         u2M8ysWFpUEEraI9Wsq2MubCqcNWdgL/LdwAiLKQ+NlArg7baNOaYTw2TlnKJGKZjOGv
         fcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54TAPFfJ8uPjFjvPV9iyvnp+RskK6ie4izbT7lZlwmM=;
        b=TjbrzDhv17yOTaVMJjzdHRN3PGTFpNeiMAoJzBb45alm/HcYLVLhQw8mrHTVq1+1/Q
         8Z5mHUJ7wMgqGMM3RiCssFYOxKcAN6epCAKIom+UMb9DoqHhvcpk0OwLMm3WgzwBlfWp
         Ii79HKclZzCX1ezRhG+Sbq1qBft9WqXT00pgJ6V3hULujbUYU9fMNtWwOwShSmvKy+E8
         CU/wspIvqzqoAG36pAxh5L5NUFdylpgvqrO2LfxhdgXfL8KVDQMGLLTXfXo0NPx54lWo
         a7A6P0Qxwv4c9hBEBqDsIm5/OsWXz8kq7xfZ6h9k8GhHcFeU7uBfrweV/oRn0MBS/isL
         +/bg==
X-Gm-Message-State: ANoB5pmW2QOGmgDuUXFashda6rL9XF41BHt1ovY8K1JglyN2fC9UKg56
        kySdeW6uwo3nwbWc90NNxwo=
X-Google-Smtp-Source: AA0mqf71YyYdTNXbKyByKiaWwMpoiwcLPMwHUxLmqdECrNLlRlDdFW/04MBg6BAYJ/hUBV7KGkGGxA==
X-Received: by 2002:a17:906:2345:b0:7ad:adfe:1ceb with SMTP id m5-20020a170906234500b007adadfe1cebmr44274622eja.89.1669822086590;
        Wed, 30 Nov 2022 07:28:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906495a00b0077205dd15basm752487ejt.66.2022.11.30.07.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:28:05 -0800 (PST)
Message-ID: <cc380eb0-cf44-5273-5340-c80cd001aaf8@gmail.com>
Date:   Wed, 30 Nov 2022 17:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/3] wifi: rtl8xxxu: Fix the channel width reporting
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <ba821a9d-af25-3ade-9fa8-0d3f4b58aec5@gmail.com>
 <aa0afff7-eccd-eac6-9b0d-6d5e94fb2c06@gmail.com>
 <4959ded326514badbb7bbfbf60e353d4@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4959ded326514badbb7bbfbf60e353d4@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/11/2022 02:38, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, November 30, 2022 3:06 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH v3 2/3] wifi: rtl8xxxu: Fix the channel width reporting
>>
>> The gen 2 chips RTL8192EU and RTL8188FU periodically send the driver
>> reports about the TX rate, and the driver passes these reports to
>> sta_statistics. The reports from RTL8192EU may or may not include the
>> channel width. The reports from RTL8188FU do not include it.
>>
>> Only access the c2h->ra_report.bw field if the report (skb) is big
>> enough.
>>
>> The other problem fixed here is that the code was actually never
>> changing the channel width initially reported by
>> rtl8xxxu_bss_info_changed because the value of RATE_INFO_BW_20 is 0.
>>
>> Fixes: 0985d3a410ac ("rtl8xxxu: Feed current txrate information for mac80211")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v3:
>>  - Don't assume bw will always be 1 byte.
>>
>> v2:
>>  - Eliminate the magic numbers.
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 28f136064297..9799bc5ed60a 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>  			rarpt->txrate.flags = 0;
>>  			rate = c2h->ra_report.rate;
>>  			sgi = c2h->ra_report.sgi;
>> -			bw = c2h->ra_report.bw;
>>
>>  			if (rate < DESC_RATE_MCS0) {
>>  				rarpt->txrate.legacy =
>> @@ -5586,8 +5585,14 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>  						RATE_INFO_FLAGS_SHORT_GI;
>>  				}
>>
>> -				if (bw == RATE_INFO_BW_20)
>> -					rarpt->txrate.bw |= RATE_INFO_BW_20;
>> +				if (skb->len >= offsetof(typeof(*c2h), ra_report.bw) +
>> +						sizeof(c2h->ra_report.bw)) {
> 
> Today, I look up if we have a better choice, and offsetofend() can make thing simple.
> 
> if (skb->len >= offsetofend(typeof(*c2h), ra_report.bw))
> 
> Sorry for the late.
> 

Even better. Thank you.

