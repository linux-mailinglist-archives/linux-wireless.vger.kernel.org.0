Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65F24BA9F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgHTMO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgHTMOQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 08:14:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FCC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:14:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so1395945wmi.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IolFIQhtQtLRuATBm7oAC39fugoECwB2XtyV3myhdTo=;
        b=LK5Giw6gSuve3WHz7+m4keqJH50p9L7ByFjvJvh00PzQSULgUUSO1WmatWxIvxFYnB
         eNcFniRukqSixptB43YgFT2jgjC0YiokKmVv5Lxi8wQrVsKFf9v0m3N5efSTtp2WzkeU
         16+crWsaaX28VgVVqYt3oPH/TnPz8K85mChjlSTbroM83EiZrtbKljdJqxjnKGWhZTSi
         gNFnGKdRZLabPhRT0xM0bvIdvv1P9qoOgp34P6am1bFYDaZ6/hkkakC96cWgJ/NA4t6+
         7/JiFIGIE5lY0FU638+4Wvugs2SzuJP7paeudE4yFZ05uT8jyJ7dpLrtJ3EIF1RkhMB7
         d/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IolFIQhtQtLRuATBm7oAC39fugoECwB2XtyV3myhdTo=;
        b=hDwxPWDpWp6pI1xv12Ce4owVv2rR10+XY7EuvxyUvdan0nK1sW09bHLdilqfpaFYgO
         6scxrI9RYg1rW5n9HQh0xAIBj7v7fWSbHVvw5pF9S5Sa6pfbPnzMhlufvZk4gOTKFor9
         C8z4S5JqwYfcXyFglegEB/+zmMlu3sEB4UXd0eggpO/imQbPDFzVB6Xcx8j6IMo50pyA
         gy19/FlgDKryrsAe6+r+LMhY7xGSxlSb+6R0mmD3YFBp/kTb7up/sVIcVn0I3iDGkUbK
         A+ExoJE+RjjhoYwGpE8qfJXGZ9TMWWyoAKG/eCD00IwEiUYDkGGvE2OkHdwDEDlMw52W
         GvHg==
X-Gm-Message-State: AOAM532NZRbvdxHwCqdD/urNgxUrZj7gG3M3S/RGB0vA7yeS4PWbU6Gi
        /j9Ji5xkt84WIJLYHIDGMl11zhduQvu9csu1
X-Google-Smtp-Source: ABdhPJwXJVgs6S5/4VH1hrWDQh8eNqfjD/NLkOgvyfd5NYT57dR/rS1mj47YpNaYUqMYJBnRab45QQ==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr3411050wmb.151.1597925650268;
        Thu, 20 Aug 2020 05:14:10 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f17sm4298426wru.13.2020.08.20.05.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:14:09 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
 <87pn7ojx8g.fsf@codeaurora.org>
 <CAMZdPi9sQ2BM4G2cSKNfE06fOtvOtgb+ELqAkxUJdtLbuoeYzQ@mail.gmail.com>
 <9ff7836b-2d84-91bc-0691-f8696541ffc2@nexus-software.ie>
 <CAMZdPi9MN=pJ_j0py4egeR=HM2d=T+h8JXgH=WiN1PpnbTX3qg@mail.gmail.com>
 <bec1a210-1bfc-8d80-d2a0-41b6be7f807a@linaro.org>
 <494f0978-7380-e2f5-3224-0131d9bd0935@linaro.org>
 <CAMZdPi-a_YM4oSv42Rx4gY2fRRTw160bCDZ6zC_er9qz0LYh1g@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <cf24e2bc-d6e4-c048-2319-ecc68ce825d8@linaro.org>
Date:   Thu, 20 Aug 2020 13:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi-a_YM4oSv42Rx4gY2fRRTw160bCDZ6zC_er9qz0LYh1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/08/2020 12:27, Loic Poulain wrote:
> HI Bryan,
> 
> On Thu, 20 Aug 2020 at 01:54, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 19/08/2020 11:52, Bryan O'Donoghue wrote:
>>> On 19/08/2020 09:15, Loic Poulain wrote:
>>>> Hi Bryan,
>>>>
>>>> On Tue, 18 Aug 2020 at 20:00, Bryan O'Donoghue
>>>> <pure.logic@nexus-software.ie> wrote:
>>>>>
>>>>> On 18/08/2020 14:34, Loic Poulain wrote:
>>>>>> On Tue, 18 Aug 2020 at 08:15, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>>>>
>>>>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>>>>
>>>>>>>> For software-driven scan, rely on mac80211 software scan instead
>>>>>>>> of internal driver implementation. The internal implementation
>>>>>>>> cause connection trouble since it keep the antenna busy during
>>>>>>>> the entire scan duration, moreover it's only a passive scanning
>>>>>>>> (no probe request). Therefore, let mac80211 manages sw scan.
>>>>>>>>
>>>>>>>> Note: we fallback to software scan if firmware does not report
>>>>>>>> scan offload support or if we need to scan the 5Ghz band (currently
>>>>>>>> not supported by the offload scan...).
>>>>>>>>
>>>>>>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>>>>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>>>>
>>>>>>> What changed since v2? Please always include a changelog so that I
>>>>>>> don't
>>>>>>> need to guess what you have changed in the patch. No need to resend, a
>>>>>>> reply is enough.
>>>>>>
>>>>>> Yes sorry, this patch has been rebased on ath master and squashed with
>>>>>> Bryan's fix:
>>>>>>         wcn36xx: Set sw-scan chan to 0 when not associated
>>>>>> No additional changes have been made on top of the initial patches.
>>>>>>
>>>>>> Regards,
>>>>>> Loic
>>>>>>
>>>>>
>>>>> This is excruciatingly slow on Android.
>>>>>
>>>>> Android I'm finding unlike Debian where this stuff was tested, merrily
>>>>> issues scan requests every 30 seconds.
>>>>>
>>>>> For me this ends up looking like this
>>>>>
>>>>> [  162.296995] wcn36xx: mac config changed 0x00000040
>>>>> [  162.297001] wcn36xx: wcn36xx_config channel switch=1
>>>>> [  162.297005] wcn36xx: hal init scan mode 2
>>>>> [  177.492402] wcn36xx: mac config changed 0x00000040
>>>>> [  177.492409] wcn36xx: wcn36xx_config channel switch=40
>>>>> [  177.492413] wcn36xx: hal finish scan mode 2
>>>>>
>>>>> Basically it takes 15 seconds to complete.
>>>>>
>>>>> Interleaved scan seems very slow and is IMO unusable on Android
>>>>
>>>>
>>>> The software scan is driven by mac80211 which interleaves channels
>>>> scanning
>>>> with the regular data operations. In worst case, it scans during 111ms
>>>> on the
>>>> channel and switches back to the operating channel for 200ms.
>>>> So, with 35 channels to scan that would take about 11 seconds to
>>>> complete...
>>>> So yes, it's quite slow...
>>>
>>> Yes looks a scheduling thing in mac80211.
>>>
>>>> However, one remaining
>>>> thing to try would be to send an update-channel-list command to the
>>>> firmware before each offload scan (cf UPDATE_CHANNEL_LIST_REQ
>>>> in the downstream driver). That's not something I've tried yet.
>>>
>>> I've tried
>>>
>>> 1. Setting the operating frequency to a 5ghz band before the scan
>>> 2. Updating the channel list with 2g/5g channels via
>>> UPDATE_CHANNEL_LIST_REQ
>>> 3. Updating the channel list with 5g only with UPDATE_CHANNEL_LIST_REQ
>>> 4. Doing 5g channels only in the channel list of
>>> WCN36XX_HAL_START_SCAN_OFFLOAD_REQ
>>>
>>> I don't think the channel list matters, if I recall rightly I've also
>>> tried leaving out the channel list in WCN36XX_HAL_START_SCAN_OFFLOAD_REQ
>>> and get back the same set of channels in the result
>>>
>>> I guess we should take this patch anyway, since it makes wcn36xx and
>>> mac80211 agree on ownership of the antenna...
>>>
>>> ---
>>> bod
>>
>> Ah.
>>
>> If we implement ops->flush() we can slash that idle time down significantly
>>
>> static void ieee80211_scan_state_resume(struct ieee80211_local *local,
>>                                           unsigned long *next_delay)
>> {
>>
>>           if (local->ops->flush) {
>>                   ieee80211_flush_queues(local, NULL, false);
>>                   *next_delay = 0;
>>           } else
>>                   *next_delay = HZ / 10;
>> }
>>
>> Trivial hack example:
>>
>> +void wcn36xx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>> +                  u32 queues, bool drop)
>> +{
>> +}
>> +
>>    static const struct ieee80211_ops wcn36xx_ops = {
>>           .start                  = wcn36xx_start,
>>           .stop                   = wcn36xx_stop,
>> @@ -1187,7 +1192,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
>>           .sta_add                = wcn36xx_sta_add,
>>           .sta_remove             = wcn36xx_sta_remove,
>>           .ampdu_action           = wcn36xx_ampdu_action,
>> -
>> +       .flush                  = wcn36xx_flush,
>>           CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
>>    };
> 
> Interestingly, we could indeed get rid of this extra 100ms.
> Maybe a way to implement this would be to wait for the TX
> ring to be empty in dxe.
> 
>> That ~ 20 seconds is cut to just 4 ! Which to be fair seems to be the
>> kind of time it took to do the old version of the software scan.
> 
> Sure but In the below case, it seems scan occurs while you're not
> connected to an AP, which prevents interleaving of operating channel.
> The same scan while connected should be longer.

You're right, don't get excited about a fix you 'find' at 1 am.

Still having a hard time getting this one running on Android, even 
dropping the scan interval to 60 seconds.

ops->flush() helps a bit but not enough

In terms of keeping the antenna busy during the current scan - is that a 
problem if we skip over the active channel when connected to an AP ?

__ieee80211_scan_completed() seems to re-schedule work which was delayed 
while hardware scan was ongoing, so, the TX path should be OK with the 
current scan.

The issue then I guess is on the RX path. During a scan we could tune to 
the current operational channel, the AP could send data but, we would 
drop it, because we are scanning.

One solution might be, if we were to skip scanning the operational 
channel when connected to an STA, then this problem would not happen.

Because the only time we would be tuned to the operational channel would 
be when we are also in a state to receive any data the AP might send.

We should still get a notification from the firmware on 
disconnect/dis-assocation.

