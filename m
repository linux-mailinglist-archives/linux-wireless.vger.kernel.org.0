Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6515921D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgBKOnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 09:43:53 -0500
Received: from nbd.name ([46.4.11.11]:39786 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgBKOnx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 09:43:53 -0500
Received: from [2a04:4540:1401:2a00:cab8:b5b3:a1b1:af79]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1j1WlP-0002NF-1t; Tue, 11 Feb 2020 15:43:47 +0100
Subject: Re: [RESEND V2 3/4] ath11k: switch to using ieee80211_tx_status_ext()
To:     Sven Eckelmann <sven@narfation.org>, ath11k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
References: <20200204151135.25302-1-john@phrozen.org>
 <20200204151135.25302-3-john@phrozen.org>
 <87h7zxxob7.fsf@kamboji.qca.qualcomm.com> <4744821.iAptAJfnkX@bentobox>
From:   John Crispin <john@phrozen.org>
Message-ID: <94d0da89-6b48-0433-7a01-275af1a99ca1@phrozen.org>
Date:   Tue, 11 Feb 2020 15:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4744821.iAptAJfnkX@bentobox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/02/2020 15:38, Sven Eckelmann wrote:
> On Tuesday, 11 February 2020 14:10:04 CET Kalle Valo wrote:
> [...]
>>> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
>>> index 7b532bf9acd8..66a6cfd54ad9 100644
>>> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>>> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>>> @@ -357,9 +357,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>>>   				       struct sk_buff *msdu,
>>>   				       struct hal_tx_status *ts)
>>>   {
>>> +	struct ieee80211_tx_status status = { 0 };
>>
>> This adds a sparse warning:
>>
>> drivers/net/wireless/ath/ath11k/dp_tx.c:350:47: warning: Using plain integer as NULL pointer
>>
>> Seems like a false warning, no? But not sure how to shut up the warning,
>> using '{ NULL }' would do that but just feels wrong. Any opinions?
> 
> Why is this a false warning? The structure is following:
> 
>      struct ieee80211_tx_status {
>      	struct ieee80211_sta *sta;
>      	struct ieee80211_tx_info *info;
>      	struct sk_buff *skb;
>      	struct rate_info *rate;
>      };
> 
> And this is a pre-C99 initializer. The equal C99-Initializer would be
> 
>      struct ieee80211_tx_status status = {
>      	.sta = NULL,
> 	};
> 
> So it is initializing status.sta with 0. But status.sta is a pointer
> and we should use NULL for pointers instead of plain 0. If you want
> to initialize the object on stack to zero but not initialize each
> member then just use {}.
> 
> Kind regards,
> 	Sven
> 

yup, i just need to drop the 0 and use {}. I'll respin/send
	John
