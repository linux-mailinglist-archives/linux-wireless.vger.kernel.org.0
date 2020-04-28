Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051641BCCBE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgD1Tvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 15:51:32 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:42602 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgD1Tvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 15:51:32 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A34B313C283;
        Tue, 28 Apr 2020 12:51:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A34B313C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588103492;
        bh=Rqlh4uYPWRlgBA56/bK7VM+H8DUVi3kogLY1b6DkM4Q=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jytNVKPcCn5yS8NEinEiCIjGQo1L84FFrlmYHZq4E1T5micefqx38gYPaMFw/qKss
         ad1W5+F283s/6p8DbXGa3wjN/t5yGKy3a/l8D/Le8QJakZNwhaE8ydYz+nKWIFN9sU
         ZEx/RmjWlt6L52C11ip97E+2lq/08hMfqBJvQayg=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
Date:   Tue, 28 Apr 2020 12:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <87h7x3v1tn.fsf@toke.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 04/28/2020 12:37 PM, Toke Høiland-Jørgensen wrote:
> greearb@candelatech.com writes:
>
>> From: Ben Greear <greearb@candelatech.com>
>>
>> While running tcp upload + download tests with ~200
>> concurrent TCP streams, 1-2 processes, and 30 station
>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>> around 20% of the CPU according to perf-top, which other locking
>> taking an additional ~15%.
>>
>> I believe the issue is that the ath10k driver would unlock the
>> txqueue when a single frame could be transmitted, instead of
>> waiting for a low water mark.
>>
>> So, this patch adds a low-water mark that is 1/4 of the total
>> tx buffers allowed.
>>
>> This appears to resolve the performance problem that I saw.
>>
>> Tested with recent wave-1 ath10k-ct firmware.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>> index 31c4ddbf45cb..b5634781c0dc 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>
>>  	u8 target_version_major;
>>  	u8 target_version_minor;
>> +	bool needs_unlock;
>>  	struct completion target_version_received;
>>  	u8 max_num_amsdu;
>>  	u8 max_num_ampdu;
>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> index 9b3c3b080e92..44795d9a7c0c 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>  	lockdep_assert_held(&htt->tx_lock);
>>
>>  	htt->num_pending_tx--;
>> -	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>> +	if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
>
> Why /4? Seems a bit arbitrary?

Yes, arbitrary for sure.  I figure restart filling the queue when 1/4 full so that it
is unlikely to run dry.  Possibly it should restart sooner to keep it more full
on average?

Before my patch, the behaviour would be to try to keep it as full as possible, as in
restart the queues as soon as a single slot opens up in the tx queue.

>
> What's a typical value of max_num_pending_tx?

1424

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
