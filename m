Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C32A1783
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgJaNBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgJaNBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 09:01:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBEC0613D5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 06:01:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v5so5187498wmh.1
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KzAlYWs6+n93X6mMU2Lsba/iMGFVx59RQWXfhbhyAA=;
        b=Flu0huZydgQUY9ZdySmLLhMsMaN3jXAFwkLJMFX8gkUQHvAyZlrTo6Hxwkf83Gj5dg
         mcPYGXcWYXuPmiF1ZiZYHirmJ0YFRJ+i5CdZiYBFmnSLiQGUaCP1zMxPmINUgLPynoTV
         HAPmrzTzUxtmYeMpzyZOOUS72OJ4H9xw6pW7ZKUCDs01RaeeeNcGTddO72A164d2AsDS
         N4M2lXikxeXASo5lblWFphHoM4oLoLVs3KehEAJntacqRg0p5EjbqFOEvQVEIxQYTL2A
         G5NoDwffBQ1ocaMFxFloD/dVuLAS8H+2oo5IrqQI+uK9u2dBsdzhU8ANVpnZkLBI1QEY
         z9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KzAlYWs6+n93X6mMU2Lsba/iMGFVx59RQWXfhbhyAA=;
        b=ukxAYIucP81/2gCC8OirviYsOwYyZQrvwbWuHJvQkP/SEp/ZU79uMSDeO7ZMTVaZig
         0Q3uHWG/yu+otYT/KuL99YYJOtecFt/Byy4m56bXi5nr2+qY7g34rs8EhJz995Dwh4m8
         +RSpkiDm+As+qsTPoOhlab/GWmanfZDk1V8EO01MLTIgPgIQUrcKPqBQrBO8A8Ni6F36
         LPlXDJb7+tUN2lpDsHV1+aI0E4mhR76hCIH50bhqhhJv5Zqa27wrO4r6Zyi73FncsQbH
         15Ueuw/8A0+3i28+/tvqzi7T74dxtp9h9vavaZFJt9NuBpl20zICiipIqGN+uqhc03bP
         6uOA==
X-Gm-Message-State: AOAM532EtFCojaLciBUpthtv5P/VTdp2F9X5yvDFzFn+gyFQE1SfPkU0
        Jcn91kqUchGQhQmyIGbX6FO21w==
X-Google-Smtp-Source: ABdhPJwN2NRpDYDDvHMkpWcFxSmQzubn/en1L9K+necm6YJCtAG5gTe4A8l01chZqh6DfwkKgLxbtA==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr8629087wmg.68.1604149276361;
        Sat, 31 Oct 2020 06:01:16 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r1sm15301062wro.18.2020.10.31.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 06:01:15 -0700 (PDT)
Subject: Re: [PATCH 2/3] wcn36xx: Enable firmware link monitoring
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
 <20201031022311.1677337-3-bryan.odonoghue@linaro.org>
 <CAMZdPi8+_17YSOK3G+MX3dFb0vejeikBYarRR6EckysZD4G70A@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <53a8a962-386e-3af4-2caf-6ac74fc48a25@linaro.org>
Date:   Sat, 31 Oct 2020 13:02:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi8+_17YSOK3G+MX3dFb0vejeikBYarRR6EckysZD4G70A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31/10/2020 09:57, Loic Poulain wrote:
> On Sat, 31 Oct 2020 at 03:22, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> This patch switches on CONNECTION_MONITOR. Once done it is up to the
>> firmware to send keep alive and to monitor the link state.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/net/wireless/ath/wcn36xx/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
>> index 706728fba72d..e924cc4acde0 100644
>> --- a/drivers/net/wireless/ath/wcn36xx/main.c
>> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
>> @@ -1246,6 +1246,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
>>          ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
>>          ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
>>          ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
>> +       ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
> 
> The problem could be that when connection monitor is enabled, mac80211
> stop sending regular null/probe packet to the AP (as expected), but
> also stop monitoring beacon miss:
> https://elixir.bootlin.com/linux/v5.10-rc1/source/net/mac80211/mlme.c#L115
> 
> That's not a big problem, but that would mean that in active mode
> (power_save disabled, non PS), the mac80211 will not detect if the AP
> has left immediately, and in worst case, only after 30 seconds. Note
> that in PS mode, beacon monitoring is well done by the firmware.
> 

If you pull the plug out of the AP it can take up to 30 seconds to see 
it agreed.

On the flip side, the amount of NULL data packets produced drops off 
significantly once we delegate this completely to the firmware.

IMO you gain more by reducing the regular runtime noise than you loose 
with the timing out of an gone away AP.
