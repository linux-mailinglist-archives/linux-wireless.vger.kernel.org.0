Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51BA7EB6E6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKNTba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 14:31:29 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F9BB
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 11:31:26 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so3168369a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 11:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699990285; x=1700595085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtboxeZapevqapsYTQaBIObnwy8xk1I1VCxFzE4AvHA=;
        b=jcGiQylGNbQKKS+8VgLNUT7nNlZ9gtBJhHm4RYFh1Ghk/40991MXcIN4qUtFRJ43K0
         QW5IAmdIsMX+t74zYi472IxC0qQJrxkvPdYNnbsnGm2ePdQqUAPzSrWOmhuDO4k+N0wW
         yUVQRcrxEYQRbyhBRGyMKb014yvtO7P/jcGeSkJFH2yMvNbjXpKpQvmaIgPL3UsBiA7r
         2ix4OyktteuijtUucNhH8+wLiBC1t1I16ud4CMmpb/11eJxgtDB2UKFV0Q1qOfpy0XIK
         F6ZFmLR4SLCZ33TsO5v+pQivW9TCygkZ+MqROjuFeSdm7xEtakaDK+4UaDAZ2krorGYl
         s7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699990285; x=1700595085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtboxeZapevqapsYTQaBIObnwy8xk1I1VCxFzE4AvHA=;
        b=WLDFGOPZRlTl31SqqGzw3H6hoxKAepLauqaHqyn8LG9WKpDRSgNFeatJmoYiht0nYw
         3ZFvUPgHKIZ7JAUJvrFJyhPEVZaLdf3x48QLRw+VzSenDuzn74szRAW+kNhbOAmTTPkM
         p0B6G+UMP04QOomeGB+GZDEmdpqHsWhg6MMm9CBkpa5xTIAZxc9eUvqDfClwSAqG9bpt
         8YTZrCtj+rNpjSE9+W7gLgqL440BpWZx4JRCWXnRMO83OoUMJKl6RMd+GiCvihJKYK8d
         qJhPVTTRdo5mLUW7bvTybMG8oCe0fqyYDIUsiq1c6VROYYSvY4qU4SXISBLO1YHy5s+e
         Advw==
X-Gm-Message-State: AOJu0YyVPTbwA+tP6xfv4tHplFCoLoNFB9hxXNMfVuNXj1K+M+jevHvl
        8dX8jTtAMSa/sOCEypiDAFc=
X-Google-Smtp-Source: AGHT+IGs2PcbzQVSKPf2e6fUgw/IkPW+D2xbIBMQ7C0prthDuv25lgTuqorqOhA99tsKawGm10sWWQ==
X-Received: by 2002:a05:6830:90b:b0:6b9:b1b0:fcd1 with SMTP id v11-20020a056830090b00b006b9b1b0fcd1mr3851837ott.31.1699990285238;
        Tue, 14 Nov 2023 11:31:25 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g16-20020ad45150000000b0066d1bae2326sm3163226qvq.57.2023.11.14.11.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 11:31:24 -0800 (PST)
Message-ID: <7c3874b1-2d0f-49a0-9542-18b5350ae99a@gmail.com>
Date:   Tue, 14 Nov 2023 11:31:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ath10k: reduce invalid ht params rate message noise
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, skhan@linuxfoundation.org,
        Wen Gong <quic_wgong@quicinc.com>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org>
 <5c31f6dadbcc3dcb19239ad2b6106773@codeaurora.org>
 <87h7mktjgi.fsf@codeaurora.org>
 <db4cd172-6121-a0b7-6c3f-f95baae1c1ed@linuxfoundation.org>
 <87wnvesv8t.fsf@codeaurora.org>
 <82e3e0a2-d95b-cffb-4fa7-2eaa4513dd48@linuxfoundation.org>
 <4a02dd43-c629-4c7c-83fe-256e6d444d60@locusrobotics.com>
 <859fac21-9b1a-452e-91bb-c6d097d451b6@quicinc.com>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <859fac21-9b1a-452e-91bb-c6d097d451b6@quicinc.com>
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

On 9/20/23 12:23 PM, Jeff Johnson wrote:
> (just a resend with Wen's current e-mail address, no further comments)
> On 9/20/2023 11:27 AM, James Prestwood wrote:
>> On 2/26/21 10:01 AM, Shuah Khan wrote:
>>> On 2/11/21 4:24 AM, Kalle Valo wrote:
>>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>>
>>>>> On 2/10/21 1:28 AM, Kalle Valo wrote:
>>>>>> Wen Gong <wgong@codeaurora.org> writes:
>>>>>>
>>>>>>> On 2021-02-10 08:42, Shuah Khan wrote:
>>>>>>>> ath10k_mac_get_rate_flags_ht() floods dmesg with the following
>>>>>>>> messages,
>>>>>>>> when it fails to find a match for mcs=7 and rate=1440.
>>>>>>>>
>>>>>>>> supported_ht_mcs_rate_nss2:
>>>>>>>> {7,  {1300, 2700, 1444, 3000} }
>>>>>>>>
>>>>>>>> ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2
>>>>>>>> mcs 7
>>>>>>>>
>>>>>>>> dev_warn_ratelimited() isn't helping the noise. Use 
>>>>>>>> dev_warn_once()
>>>>>>>> instead.
>>>>>>>>
>>>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>>>> ---
>>>>>>>>    drivers/net/wireless/ath/ath10k/mac.c | 5 +++--
>>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>>> b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>>> index 3545ce7dce0a..276321f0cfdd 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>>> @@ -8970,8 +8970,9 @@ static void 
>>>>>>>> ath10k_mac_get_rate_flags_ht(struct
>>>>>>>> ath10k *ar, u32 rate, u8 nss, u8
>>>>>>>>            *bw |= RATE_INFO_BW_40;
>>>>>>>>            *flags |= RATE_INFO_FLAGS_SHORT_GI;
>>>>>>>>        } else {
>>>>>>>> -        ath10k_warn(ar, "invalid ht params rate %d 100kbps nss 
>>>>>>>> %d mcs %d",
>>>>>>>> -                rate, nss, mcs);
>>>>>>>> +        dev_warn_once(ar->dev,
>>>>>>>> +                  "invalid ht params rate %d 100kbps nss %d 
>>>>>>>> mcs %d",
>>>>>>>> +                  rate, nss, mcs);
>>>>>>>>        }
>>>>>>>>    }
>>>>>>>
>>>>>>> The {7,  {1300, 2700, 1444, 3000} } is a correct value.
>>>>>>> The 1440 is report from firmware, its a wrong value, it has 
>>>>>>> fixed in
>>>>>>> firmware.
>>>>>>
>>>>>> In what version?
>>>>>>
>>>>>
>>>>> Here is the info:
>>>>>
>>>>> ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>>>>> 0x00340aff sub 17aa:0827
>>>>>
>>>>> ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1
>>>>> api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1
>>>>>
>>>>> ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 4ac0889b
>>>>>
>>>>> ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal otp
>>>>> max-sta 32 raw 0 hwcrypto 1
>>>>>
>>>>>>> If change it to dev_warn_once, then it will have no chance to 
>>>>>>> find the
>>>>>>> other wrong values which report by firmware, and it indicate
>>>>>>> a wrong value to mac80211/cfg80211 and lead "iw wlan0 station dump"
>>>>>>> get a wrong bitrate.
>>>>>>
>>>>>
>>>>> Agreed.
>>>>>
>>>>>> I agree, we should keep this warning. If the firmware still keeps
>>>>>> sending invalid rates we should add a specific check to ignore 
>>>>>> the known
>>>>>> invalid values, but not all of them.
>>>>>>
>>>>>
>>>>> Would it be helpful to adjust the default rate limits and set the to
>>>>> a higher value instead. It might be difficult to account all possible
>>>>> invalid values?
>>>>>
>>>>> Something like, ath10k_warn_ratelimited() to adjust the
>>>>>
>>>>> DEFAULT_RATELIMIT_INTERVAL and DEFAULT_RATELIMIT_BURST using
>>>>> DEFINE_RATELIMIT_STATE
>>>>>
>>>>> Let me know if you like this idea. I can send a patch in to do this.
>>>>> I will hang on to this firmware version for a little but longer, so
>>>>> we have a test case. :)
>>>>
>>>> I would rather first try to fix the root cause, which is the firmware
>>>> sending invalid rates. Wen, you mentioned there's a fix in 
>>>> firmware. Do
>>>> you know which firmware version (and branch) has the fix?
>>>>
>>>
>>> Picking this back up. Wen, which firmware version has this fix? I can
>>> test this on my system and get rid of the noisy messages. :)
>>>
>>> thanks,
>>> -- Shuah
>>
>> I know its been years, but reading through this Wen mentioned there 
>> is a fix in the firmware? I haven't tried all of the firmware 
>> binaries in Kalle's tree but the most recent definitely still spam 
>> the logs with this message. Is there a specific version I can use to 
>> get rid of these?
>>
>> One thing to note is the older "firmware-4.bin" did not have this 
>> problem, but was met with worse problems like driver/firmware crashes.

I hate to keep bringing this up, and if its a "won't fix" type of issue 
you don't have to tell me twice and I can deal with it out of tree. Any 
answer would be greatly appreciated so I know how to proceed, and if its 
something I can wait for on upstream or handle on my own. Since its 
apparently a firmware bug its not something I can fix, or I would try to 
myself.

(sorry, my last inquiry was mistakenly from a different email address).

Thanks,

James

