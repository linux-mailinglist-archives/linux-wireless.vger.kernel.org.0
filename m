Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AD1C4E82
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgEEGx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 02:53:27 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:33011 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEGx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 02:53:27 -0400
Received: from [192.168.178.34] (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 29329580243;
        Tue,  5 May 2020 08:53:25 +0200 (CEST)
Subject: Re: [PATCH 2/2] ath11k: use cumulative survey statistics
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <20200504154122.91862-2-markus.theil@tu-ilmenau.de>
 <85fa2d5f9183b3a12c5283b800f3750f@codeaurora.org>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <c786e982-fcd6-2368-6b2f-f09b265654d6@tu-ilmenau.de>
Date:   Tue, 5 May 2020 08:53:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <85fa2d5f9183b3a12c5283b800f3750f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 05.05.2020 um 01:37 schrieb Rajkumar Manoharan:
> On 2020-05-04 08:41, Markus Theil wrote:
>> ath11k currently reports survey results for the last interval between 
>> each
>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>> data and iw survey dump is invoked in parallel. Fix this by returning
>> cumulative results, that don't depend on the last invocation. Other
>> drivers, e.g. ath9k or mt76 also use this behavior.
>>
>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> ---
>>  drivers/net/wireless/ath/ath11k/wmi.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c
>> b/drivers/net/wireless/ath/ath11k/wmi.c
>> index c2a972377687..322ddfda5bfd 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>> @@ -5610,16 +5610,16 @@ ath11k_pdev_bss_chan_info_event(struct
>> ath11k_base *ab, struct sk_buff *skb)
>>
>>      survey = &ar->survey[idx];
>>
>> -    survey->noise     = bss_ch_info_ev.noise_floor;
>> -    survey->time      = div_u64(total, cc_freq_hz);
>> -    survey->time_busy = div_u64(busy, cc_freq_hz);
>> -    survey->time_rx   = div_u64(rx_bss, cc_freq_hz);
>> -    survey->time_tx   = div_u64(tx, cc_freq_hz);
>> -    survey->filled   |= (SURVEY_INFO_NOISE_DBM |
>> -                 SURVEY_INFO_TIME |
>> -                 SURVEY_INFO_TIME_BUSY |
>> -                 SURVEY_INFO_TIME_RX |
>> -                 SURVEY_INFO_TIME_TX);
>> +    survey->noise      = bss_ch_info_ev.noise_floor;
>> +    survey->time      += div_u64(total, cc_freq_hz);
>> +    survey->time_busy += div_u64(busy, cc_freq_hz);
>> +    survey->time_rx   += div_u64(rx_bss, cc_freq_hz);
>> +    survey->time_tx   += div_u64(tx, cc_freq_hz);
>> +    survey->filled    |= (SURVEY_INFO_NOISE_DBM |
>> +                  SURVEY_INFO_TIME |
>> +                  SURVEY_INFO_TIME_BUSY |
>> +                  SURVEY_INFO_TIME_RX |
>> +                  SURVEY_INFO_TIME_TX);
>
> Markus,
>
> It depends on type of survey request is given to firmware. In ath11k, 
> firmware reports
> accumulated values. So the above addition is wrong and report double 
> value. Have you
> tested this change?
>
> -Rajkumar
Ok, so please drop both of my patches. My assumptions were incomplete 
and too humble. I just assumed, ath10k and ath11k both use incremental 
surveys.
