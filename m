Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE95B1DAB08
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgETGsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 02:48:52 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:55850 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgETGsw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 02:48:52 -0400
Received: from [192.168.178.25] (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 50C8D58006C;
        Wed, 20 May 2020 08:48:49 +0200 (CEST)
Subject: Re: [PATCHv4] ath10k : Fix channel survey dump
To:     John Deere <24601deerej@gmail.com>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1588820612-15884-1-git-send-email-vnaralas@codeaurora.org>
 <bee1439c-de98-dbf0-ee82-88620ecc560a@gmail.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <f3da0683-1e1e-6c67-08bb-2147e745a317@tu-ilmenau.de>
Date:   Wed, 20 May 2020 08:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bee1439c-de98-dbf0-ee82-88620ecc560a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've seen this patch got dropped again from the ath.git pending branch.
On which hw/firmware combination did it fail to operate?

On 5/17/20 4:26 AM, John Deere wrote:
>
> On 5/7/20 11:03 AM, Venkateswara Naralasetty wrote:
>> Channel active/busy time are showing incorrect(less than previous or
>> sometimes zero) for successive survey dump command.
>>
>> example:
>> Survey data from wlan0
>>     frequency:                      5180 MHz [in use]
>>     channel active time:            54995 ms
>>     channel busy time:              432 ms
>>     channel receive time:           0 ms
>>     channel transmit time:          59 ms
>> Survey data from wlan0
>>     frequency:                      5180 MHz [in use]
>>     channel active time:            32592 ms
>>     channel busy time:              254 ms
>>     channel receive time:           0 ms
>>     channel transmit time:          0 ms
>>
>> This patch fix this issue by assigning 'wmi_bss_survey_req_type'
>> as 'WMI_BSS_SURVEY_REQ_TYPE_READ' which accumulate survey data in
>> FW and send survey data to driver upon the driver request. Wrap around
>> is taken care by FW.
>>
>> hardware used : QCA9984
>> firmware ver  : ver 10.4-3.5.3-00057
>>
>> hardware used : QCA988X
>> firmware ver  : 10.2.4-1.0-00047
>>
>> Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
>> ---
>> v4:
>>   * updated signed-off-by
>>
>> v3:
>>   * Rebased on TOT and added Tested-by
>>
>>   drivers/net/wireless/ath/ath10k/mac.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>> b/drivers/net/wireless/ath/ath10k/mac.c
>> index a1147cc..9330b52 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -7275,7 +7275,7 @@ ath10k_mac_update_bss_chan_survey(struct ath10k
>> *ar,
>>                     struct ieee80211_channel *channel)
>>   {
>>       int ret;
>> -    enum wmi_bss_survey_req_type type =
>> WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR;
>> +    enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ;
>>         lockdep_assert_held(&ar->conf_mutex);
>>  
>
>
> I have tested this on a QCA9980 device on a TP-Link Archer A7v5 with
> the firmware version 10.2.4.70.70.
>
> [root@Archer-A7v5 ~]# uptime
>  10:18:40 up 7 days,  3:52,  load average: 0.03, 0.01, 0.00
>
>
> It has been working fine:
>
> Survey data from wlan0
>     frequency:            5240 MHz [in use]
>     noise:                -101 dBm
>     channel active time:        593724580 ms
>     channel busy time:        9706985 ms
>     channel receive time:        2053580 ms
>     channel transmit time:        6473058 ms
>
> Tested-by: John Deere <24601deerej@gmail.com>
>
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k

-- 
Markus Theil

Technische Universität Ilmenau, Fachgebiet Telematik/Rechnernetze
Postfach 100565
98684 Ilmenau, Germany

Phone: +49 3677 69-4582
Email: markus[dot]theil[at]tu-ilmenau[dot]de
Web: http://www.tu-ilmenau.de/telematik

