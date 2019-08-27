Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D379F306
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfH0TNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 15:13:53 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45936 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfH0TNx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 15:13:53 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B06CCDDE7;
        Tue, 27 Aug 2019 12:13:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B06CCDDE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1566933231;
        bh=xQteBVwidZSGC2MZfHHOR7dAWZi7qDYFFFClYgjptwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m/NdBaWWuaEyGUDgK5fKEuea6TpFHxts1IPUIe4QXLhbuwLHtgoQrYqywPGNJsp1w
         Ck53cutqu4rPGWPAnq/cf3/Tcub78y1amEr3T0hvnNN5TqWXp2kJ893kQx31JWXlIn
         meerxpxK/G2AUca0U/xW91NNV0RyLDNHWCPFdJpk=
Subject: Re: [PATCH 31/49] ath11k: add mac.c
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
 <8736hvu6e6.fsf@toke.dk> <ac6e7dbbd53e7ba9e82e49baca22b73c@codeaurora.org>
 <875zmqsudn.fsf@toke.dk> <14737343f1925a771ddd8dadf0f2b5a3@codeaurora.org>
 <87sgpmikne.fsf@toke.dk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0aa03fd8-1fad-416b-0cd5-fcca79732987@candelatech.com>
Date:   Tue, 27 Aug 2019 12:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87sgpmikne.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/19 10:27 AM, Toke Høiland-Jørgensen wrote:
> Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:
> 
>> On 2019-08-21 15:38, Toke Høiland-Jørgensen wrote:
>>> Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:
>>>
>>>> On 2019-08-20 22:21, Toke Høiland-Jørgensen wrote:
>>>>> [... snip ... ]
>>>>>
>>>>>> +static const struct ieee80211_ops ath11k_ops = {
>>>>>> +	.tx				= ath11k_mac_op_tx,
>>>>>
>>>>> No wake_tx_queue? :(
>>>>
>>>> Yes, packet queueing is handled in firmware. This makes sense
>>>> especially when we enable 802.11 encap offload support where most of
>>>> the data path processing in mac80211 will be skipped and packet is
>>>> given to driver/firmware in 802.3 format itself. Then firmware would
>>>> take care of all the classification, queueing and encapsulation
>>>> operations.
>>>
>>> Well, so does ath10k, and yet we still saw a significant improvement by
>>> moving queueing back into the host where it can be handled by the
>>> FQ-CoDel-enabled queueing structure.
>>>
>>
>> Sure, we could probably try that with ath11k as well at some point when
>> we have a baseline with HE support.
> 
> Well, rather than retrofit change things later, why not start out with a
> wake_tx_queue-based driver?

If there is something that works at all, lets get it upstream when it is
easier to develop and test against.  Then we will have a baseline to test against
when adding new features and so forth.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

