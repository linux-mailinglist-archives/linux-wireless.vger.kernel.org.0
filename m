Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C142C68D4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgK0Pii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 10:38:38 -0500
Received: from mx08-0057a101.pphosted.com ([185.183.31.45]:57952 "EHLO
        mx08-0057a101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729872AbgK0Pih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 10:38:37 -0500
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARFV0hd006973;
        Fri, 27 Nov 2020 16:38:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=12052020;
 bh=FnnJEMcJlCYvP6TDgqEdktl3fT1Dw3slorrVObcMjfY=;
 b=J2JY3jcLvqjUwUdR8gk2Dnc4TgPJg0T3F8zAn37eokr/FGscXBHjbLTV6QzEkkc8NeOB
 7tVDJN2JM85QlNytHJ7qGWvY+s9V15zYtkJtsxNRHYaDU4YT0rchU0Ah7qgk6Ih+BIdc
 s1m4+QtOxAEk+zg6QCMu0tVJ11NS7opU/JNFxzDvyUtMTrWV9tiBkzczQbTFw1pdWrxb
 iu1wRSZmN0dHVFHjtwpMsMnDTTvrNi2lzCNLjpHegdbOn0T2Q9vJ5lfX+Dv3YxO0m1v+
 XUXZ66POBt6KV30amQfeikYdsDBkAksYUYTGIUy2y7GrCWxYUEJbgNXwh6ZHFMrAMMls YQ== 
Received: from mail.beijerelectronics.com ([195.67.87.131])
        by mx07-0057a101.pphosted.com with ESMTP id 34xyu25sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 16:38:18 +0100
Received: from wsests-s0004.westermo.com (192.168.10.12) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1847.3; Fri, 27 Nov 2020 16:38:14 +0100
Received: from [172.29.80.10] (172.29.100.2) by wsests-s0004.westermo.com
 (192.168.10.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1847.3; Fri, 27
 Nov 2020 16:38:14 +0100
Subject: Re: [RFT] ath9k: multi-rate-retry fails at HW level
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "Zefir Kurtisi" <zefku@westermo.com>,
        <linux-wireless@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, <qca-developer-program@qualcomm.com>,
        "Adrian Chadd" <adrian@freebsd.org>
References: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
 <878saqlsp8.fsf@toke.dk>
From:   Zefir Kurtisi <zefir.kurtisi@westermo.com>
Message-ID: <d05e928a-c78d-d191-7ae0-6342e05d892a@westermo.com>
Date:   Fri, 27 Nov 2020 16:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878saqlsp8.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.29.100.2]
X-ClientProxiedBy: wsevst-s0023.westermo.com (192.168.130.120) To
 wsests-s0004.westermo.com (192.168.10.12)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CC += adrian

On 24.11.20 15:45, Toke Høiland-Jørgensen wrote:
> Zefir Kurtisi <zefku@westermo.com> writes:
> 
>> Hi,
>>
>> I am running into a strange issue with the ath9k operating a 9590
>> device which to me seems like a HW issue, but since work on rate
>> controllers is already going for decades, I hardly can imagine this
>> never showed up.
>>
>> The issue observed is this: the TX status descriptors never report
>> rateindex 1, it is always 0, 2, or 3, but never 1.
>>
>> I noticed this by overwriting the rate configuration provided by
>> minstrel to a static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The
>> device operates as iperf client to a connected AP and continuously
>> transmits data. While at that, the attenuation between the endpoints
>> is gradually increased, expecting to see a gradual shift in the
>> reported TX status rateindex from 0 to 3. But nada, the values
>> reported are 0,2, and 3 - never 1.
>>
>> I double checked that the TX descriptors are correctly set with the
>> rates and retry counts - all looking sane.
>>
>> More obvious, after changing the rate configuration to
>> (7,3)(1,3)(5,3)(3,3) the expectation would be to have either 0 or 1
>> reported as rateidx, since the transmission ought to be successful
>> with the lowest rate or never. Again all rates are reported but 1.
>>
>> Now the question for me is: what is the HW exactly doing with such a
>> configuration? Is it skipping the second rate, or is it just reporting
>> wrong?
> 
> You should be able to see this by looking at the rates the frames are
> being sent at, shouldn't you?
> 
Yes, did that and from there it points to that the second rate is just skipped.

Here are some use cases and their sniffing results. Setup is a 11ng STA connected
to AP with the attenuation adjusted such that MCS 7 fails, while MCS 5 and below
succeed. Monitor is sniffing while sending a single ping from AP to STA.

With a rate configuration of (7/2)(3/2)(1/2) we get:
14:02:42.923880 9481489761us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
14:02:42.923909 9481490037us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
14:02:42.925244 9481491044us tsft 2412 MHz 11n -68dBm signal 13.0 Mb/s MCS 1 20
MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0


with (7/2)(1/2)(3/2):
13:59:37.073147 9295637087us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
13:59:37.073467 9295637438us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
13:59:37.074591 9295638498us tsft 2412 MHz 11n -68dBm signal 26.0 Mb/s MCS 3 20
MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0

and with (7/2)(3/2):
14:04:27.269806 9585836783us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
14:04:27.270342 9585837344us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
14:04:27.271368 9585838370us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
[..]

a total of 14 attempts at MCS 7 with the ping finally failing.

>> Both possibilities have great impact, since upper layers (like
>> airtime) use the returned rateidx to calculate and configure operating
>> parameters at runtime.
> 
> Have you actually observed any issues from this? If it's just skipping a
> rate, minstrel should still be able to make decisions based on the
> actual values returned, no?
> 
The issues arise from the fact that the driver reports a
(tx-rateindex/tx-attemp-index) per TX descriptor, leaving the driver to calculate
what was put on air based on these two values. If one had rates set to
(7/2)(3/7)(1/2) and the TX status reports (tx-rateindex=2/tx-attempt-index=0),
driver assumes there were 10 attempts in total while in fact they were 3 when the
second rate is skipped. What direct effect this has on RC I can't grasp, but it
definitively falsifies statistics.

Same goes for airtime: check how this falsifies its calculation in
ath_tx_count_airtime().

Also, the above mentioned is an immediate visible issue: if RC provides two rates
e.g. (7/3)(5/3) of which the first is too high and the second is not even
attempted, frames don't make it through.

>> If this is a know issue, nevermind and thanks for pointing me to it. Otherwise if
>> some of you have the named device operational, it would help a lot to get the
>> issue confirmed. Just apply the attached patch and perform some TX testing in
>> either attenuation adjustable or varying link condition setups. Whenever a frame
>> is reported to have been transmitted at a rateidx > 0, the collected stats are
>> logged, e.g.
>> MRR: 2: [51029, 0, 4741, 6454]
>>
>> In essence, the failure is confirmed if the counter for 1 is 0 or very low
>> compared to higher numbers for 0, 2, or 3.
> 
> Tried your patch and couldn't reproduce. Not the same hardware, though.
> Mine is:
> 
> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> 
> -Toke
> 

Thanks a lot for trying, let's see if someone else has the affected variant still
in use.


Cheers,
Zefir
