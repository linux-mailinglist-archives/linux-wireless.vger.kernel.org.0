Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EFF316AE2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBJQOt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhBJQOZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95193C06178C
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 08:13:09 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y15so2308400ilj.11
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sc0vbOHbxfn9JzOXGmtKhPpSM5gmhu52/wuwtc+m/jk=;
        b=CQnI1cl/+RKOawcv1Cq/crfluAy6RYgUTGSmnwgRf/BdAc8rwoz1UigSks3ySZ3Bq0
         XdSK4+gbQO6pBfnb+vvMEFG7JAT4MoYceD9fnSOfyIUTRbFyETH8LbTRcNIdzfUjp3uB
         Y/2d/s5Tk1iNGW4xM8YKag3uhttUehCoZQ8NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sc0vbOHbxfn9JzOXGmtKhPpSM5gmhu52/wuwtc+m/jk=;
        b=eVZe9KCiDv1qrBb5gMjnSvEo+PdkY9qsAp/5bmqLHewOTbf3J4Sy0R4EP01BaRo5BK
         pxzyEdxBCq4FzOQe2/qHm7Kr+0yQuWMt394RHGnRjrV60Wnao0TxKzvSglB3fKKnNZQ1
         CKrDucq63yq3lVDboyodDknnHmNpr5GiAmtoAjD97Qkz7GJTyimuq1toomABrIBpVSy6
         HwI+UoPTS90iIKvXpNP3V5pk6v/QVREkPUm1AmRD8F2J/A0OVVQdy29aHrlxQao+Qv4G
         S+2zDzuAoWQ9baFs3CXWApTQGbFffny//xZDRKdjqBACAD0G0LKa5iJhJS8NBA9RIUtW
         K2mQ==
X-Gm-Message-State: AOAM531hHhd8nbmmigRhqQDyWrApdcEmsoWBhgBxG0g8Q8l2LGa1/Alx
        S3iDZvzS+xhefQ6fssi3USTAOA==
X-Google-Smtp-Source: ABdhPJxqFfEGP4eD56gpzU1NU9/JmnxIk/kszmquParxawZ26pe0lwC7X5CNw3qHfJ8ZwuPYQRSp3A==
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr1694292ilv.214.1612973588981;
        Wed, 10 Feb 2021 08:13:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i6sm1217646ilq.51.2021.02.10.08.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:13:08 -0800 (PST)
Subject: Re: [PATCH 5/5] ath10k: reduce invalid ht params rate message noise
To:     Kalle Valo <kvalo@codeaurora.org>, Wen Gong <wgong@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        kuba@kernel.org, davem@davemloft.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org>
 <5c31f6dadbcc3dcb19239ad2b6106773@codeaurora.org>
 <87h7mktjgi.fsf@codeaurora.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db4cd172-6121-a0b7-6c3f-f95baae1c1ed@linuxfoundation.org>
Date:   Wed, 10 Feb 2021 09:13:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87h7mktjgi.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/10/21 1:28 AM, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2021-02-10 08:42, Shuah Khan wrote:
>>> ath10k_mac_get_rate_flags_ht() floods dmesg with the following
>>> messages,
>>> when it fails to find a match for mcs=7 and rate=1440.
>>>
>>> supported_ht_mcs_rate_nss2:
>>> {7,  {1300, 2700, 1444, 3000} }
>>>
>>> ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2
>>> mcs 7
>>>
>>> dev_warn_ratelimited() isn't helping the noise. Use dev_warn_once()
>>> instead.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>>   drivers/net/wireless/ath/ath10k/mac.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>>> b/drivers/net/wireless/ath/ath10k/mac.c
>>> index 3545ce7dce0a..276321f0cfdd 100644
>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>> @@ -8970,8 +8970,9 @@ static void ath10k_mac_get_rate_flags_ht(struct
>>> ath10k *ar, u32 rate, u8 nss, u8
>>>   		*bw |= RATE_INFO_BW_40;
>>>   		*flags |= RATE_INFO_FLAGS_SHORT_GI;
>>>   	} else {
>>> -		ath10k_warn(ar, "invalid ht params rate %d 100kbps nss %d mcs %d",
>>> -			    rate, nss, mcs);
>>> +		dev_warn_once(ar->dev,
>>> +			      "invalid ht params rate %d 100kbps nss %d mcs %d",
>>> +			      rate, nss, mcs);
>>>   	}
>>>   }
>>
>> The {7,  {1300, 2700, 1444, 3000} } is a correct value.
>> The 1440 is report from firmware, its a wrong value, it has fixed in
>> firmware.
> 
> In what version?
> 

Here is the info:

ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 
0x00340aff sub 17aa:0827

ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1 
api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1

ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 4ac0889b

ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal otp max-sta 
32 raw 0 hwcrypto 1

>> If change it to dev_warn_once, then it will have no chance to find the
>> other wrong values which report by firmware, and it indicate
>> a wrong value to mac80211/cfg80211 and lead "iw wlan0 station dump"
>> get a wrong bitrate.
> 

Agreed.

> I agree, we should keep this warning. If the firmware still keeps
> sending invalid rates we should add a specific check to ignore the known
> invalid values, but not all of them.
> 

Would it be helpful to adjust the default rate limits and set the to
a higher value instead. It might be difficult to account all possible
invalid values?

Something like, ath10k_warn_ratelimited() to adjust the

DEFAULT_RATELIMIT_INTERVAL and DEFAULT_RATELIMIT_BURST using
DEFINE_RATELIMIT_STATE

Let me know if you like this idea. I can send a patch in to do this.
I will hang on to this firmware version for a little but longer, so
we have a test case. :)

thanks,
-- Shuah


