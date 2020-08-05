Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477C23D104
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHETzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHEQqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FDC0A889C
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 07:01:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i19so24308479lfj.8
        for <linux-wireless@vger.kernel.org>; Wed, 05 Aug 2020 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1iOZ+P++d3lrufGqurBgPCXRh6ZcH1g+4KMY8qM0WU0=;
        b=Lwg4a84I6HeDaQ4x1UJ4L4QCAJGWNrUYiyCQwvRVv8L/0kaKsv1olAIETmn7Hw1ea9
         F4W1dvoe2WUvpOg3e/8UedL/FUCMs2YIXWW+yuR6GwyuM1PH944zUAfWTygIKAygkS6J
         3xg+NRZlLlOmDH1bhEEoOVGLhlKrwIokqZV7+YCeZnRnOQdDfoBrzj1MX2BQXvjABhGj
         FzoEvGbBR6w1cg1j5WaXxsOau5uYKDKCHnahl3cE5jvI+4t7aopJlN+N7/rFpKr36wLn
         QP6gCEojx4xiM+U/fFL5oCGpEMT9oxTZKvl10b/tuLl+m7zD5ABpUz1nnKTo5649criW
         jpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1iOZ+P++d3lrufGqurBgPCXRh6ZcH1g+4KMY8qM0WU0=;
        b=Ak4EVABbvhxdbtoGGAG3efSOGgeKrtQkppRStYnQy09akKmnXCt0JyvP+dFVMbxSqu
         e4wJf4Bns9ecbpUzLhJGG3fwpQYo1ogp5+Gx5VWhtAkE1dBmAeYkY5ndPFlGWq0s961i
         O8C5k0lzai1OBtxLYC8nHdYL7w6Gux0kaoRlAKktwZTAHABvEX4HRlOS21s1FPINX/FY
         ZFKaY4+VXdOzBS0EiP6SDClfYyMgye/NC/NAMVQVLeAcaByVdSIg0vxXNi/ouvpcXyh1
         UairzyA7kwnB9RepIR/EIHCt67JFwt+qHZ1b6CwI24EqZFlF2L41qyvaK9gONJaB/a7M
         bwow==
X-Gm-Message-State: AOAM5335EUtjkLbOgNVVLn3Km2uDJNFfNAGGww1W1TEbkkv1W4jQ6gG0
        nio7v68EgesfMvwSIHOkNXY=
X-Google-Smtp-Source: ABdhPJyhlQZC9a8l7v8VqEZ2QwvL8PvxJ8yRf6YWlBDOSbLzNhSPMIt2nM5BoI/VvpNBKcZWKnYPyA==
X-Received: by 2002:a19:c1d6:: with SMTP id r205mr1627463lff.141.1596636065715;
        Wed, 05 Aug 2020 07:01:05 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id c21sm1145501lfh.38.2020.08.05.07.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 07:01:04 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
 <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
Date:   Wed, 5 Aug 2020 17:01:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2020 11:24, Chi-Hsien Lin пишет:
> 
> On 8/5/2020 1:22 AM, Kalle Valo wrote:
>> Dmitry Osipenko <digetx@gmail.com> writes:
>>
>>> 04.08.2020 14:08, Kalle Valo пишет:
>>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>>
>>>>> 10.06.2020 18:21, Chi-Hsien Lin пишет:
>>>>>> From: Amar Shankar <amsr@cypress.com>
>>>>>>
>>>>>> It is observed that sometimes when sdiod is low in tx credits in low
>>>>>> rssi scenarios, the data path consumes all sdiod rx all credits and
>>>>>> there is no sdiod rx credit available for control path causing host
>>>>>> and card to go out of sync resulting in link loss between host and
>>>>>> card. So in order to prevent it some credits are reserved for control
>>>>>> path.
>>>>>>
>>>>>> Note that TXCTL_CREDITS can't be larger than the firmware default
>>>>>> credit update threshold 2; otherwise there will be a deadlock for
>>>>>> both
>>>>>> side waiting for each other.
>>>>>>
>>>>>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>>>>>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>>>>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>>> [...]
>>>>
>>>>> This patch causes a severe WiFi performance regression on BCM4329.
>>>>> Please fix or revert this patch, thanks in advance.
>>>>>
>>>>> Before this patch:
>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>>> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec   
>>>>> 0             sender
>>>>> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
>>>>> receiver
>>>>>
>>>>>
>>>>> After this patch:
>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>>> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec   
>>>>> 3             sender
>>>>> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
>>>>> receiver
>>>> Can someone please send a revert patch (with the explanation above)
>>>> if a
>>>> fix is not quickly found? The commit id is:
>>>>
>>>> commit b41c232d33666191a1db11befc0f040fcbe664e9
>>>> Author:     Amar Shankar <amsr@cypress.com>
>>>> AuthorDate: Wed Jun 10 10:21:03 2020 -0500
>>>> Commit:     Kalle Valo <kvalo@codeaurora.org>
>>>> CommitDate: Tue Jul 14 12:46:43 2020 +0300
>>>>
>>>>      brcmfmac: reserve 2 credits for host tx control path
>>>>
>>> Hello Kalle,
>>>
>>> I'll send the revert if nobody will stand up to address the problem in a
>>> two weeks, thanks.
>> Thanks. Then I should be able to get the revert to v5.9 so that the
>> release won't be broken. (v5.8 is unaffected)
> 
> Dmitry/Kalle,
> 
> We'll take a look and revert/fix it in a few days.

Good to know, thank you.

