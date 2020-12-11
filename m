Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242182D72CC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404450AbgLKJ2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 04:28:31 -0500
Received: from mx07-0057a101.pphosted.com ([205.220.184.10]:28972 "EHLO
        mx07-0057a101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393629AbgLKJ2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 04:28:25 -0500
X-Greylist: delayed 1607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 04:28:23 EST
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB8qUc4005119;
        Fri, 11 Dec 2020 10:00:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=12052020;
 bh=nT3aAdYuq2eHSkBrET9FpDE/SkL4EV4r6yB6YdYNnGU=;
 b=u/aFg6qUovjJr1Vm9XR2QV4+icqvkpl2cvDUVxo8iprJxF900HPK7wfDa15YVVnnx6Uj
 jhxdix98NJt+8/ouFqaCC3MP8S7kamhL+SGk/3p0hSonBUj4kVnpkh5HeUAOIGzbZICB
 4/V/felp68b4uLFaTkrJTMlZF+LvurqicUvTERRwMoH0pUahNgnsNzkpGt3BUGGVvK+T
 cbJP+nfFMEHF1OcnyVNR8smO3VVBS7U//Ax1z+Hc89wgiLab95sMDaVOCdR+CqtsMM0G
 l9EFyseCA6BF2l2CK558gkajwq8O8U9qHYQlzmeXWKenS0NdtFmVeBMw6nh/5B5fuCZ2 1w== 
Received: from mail.beijerelectronics.com ([195.67.87.131])
        by mx07-0057a101.pphosted.com with ESMTP id 358syg4yn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:00:33 +0100
Received: from wsests-s0004.westermo.com (192.168.10.12) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1847.3; Fri, 11 Dec 2020 10:00:32 +0100
Received: from [172.29.80.46] (172.29.100.2) by wsests-s0004.westermo.com
 (192.168.10.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1847.3; Fri, 11
 Dec 2020 10:00:31 +0100
Subject: Re: [RFT] ath9k: multi-rate-retry fails at HW level
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "Zefir Kurtisi" <zefku@westermo.com>,
        <linux-wireless@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, <qca-developer-program@qualcomm.com>,
        "Adrian Chadd" <adrian@freebsd.org>
References: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
 <878saqlsp8.fsf@toke.dk> <d05e928a-c78d-d191-7ae0-6342e05d892a@westermo.com>
 <87r1o91wi6.fsf@toke.dk>
From:   Zefir Kurtisi <zefir.kurtisi@westermo.com>
Message-ID: <57d98dc9-7e5d-4d2e-335e-5948ef3645ad@westermo.com>
Date:   Fri, 11 Dec 2020 10:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1o91wi6.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.29.100.2]
X-ClientProxiedBy: wsevst-s0023.westermo.com (192.168.130.120) To
 wsests-s0004.westermo.com (192.168.10.12)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01.12.20 14:33, Toke Høiland-Jørgensen wrote:
> Zefir Kurtisi <zefir.kurtisi@westermo.com> writes:
> 
>> CC += adrian
>>
>> On 24.11.20 15:45, Toke Høiland-Jørgensen wrote:
>>> Zefir Kurtisi <zefku@westermo.com> writes:
>>>
>>>> Hi,
>>>>
>>>> I am running into a strange issue with the ath9k operating a 9590
>>>> device which to me seems like a HW issue, but since work on rate
>>>> controllers is already going for decades, I hardly can imagine this
>>>> never showed up.
>>>>
>>>> The issue observed is this: the TX status descriptors never report
>>>> rateindex 1, it is always 0, 2, or 3, but never 1.
>>>>
>>>> I noticed this by overwriting the rate configuration provided by
>>>> minstrel to a static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The
>>>> device operates as iperf client to a connected AP and continuously
>>>> transmits data. While at that, the attenuation between the endpoints
>>>> is gradually increased, expecting to see a gradual shift in the
>>>> reported TX status rateindex from 0 to 3. But nada, the values
>>>> reported are 0,2, and 3 - never 1.
>>>>
>>>> I double checked that the TX descriptors are correctly set with the
>>>> rates and retry counts - all looking sane.
>>>>
>>>> More obvious, after changing the rate configuration to
>>>> (7,3)(1,3)(5,3)(3,3) the expectation would be to have either 0 or 1
>>>> reported as rateidx, since the transmission ought to be successful
>>>> with the lowest rate or never. Again all rates are reported but 1.
>>>>
>>>> Now the question for me is: what is the HW exactly doing with such a
>>>> configuration? Is it skipping the second rate, or is it just reporting
>>>> wrong?
>>>
>>> You should be able to see this by looking at the rates the frames are
>>> being sent at, shouldn't you?
>>>
>> Yes, did that and from there it points to that the second rate is just skipped.
>>
>> Here are some use cases and their sniffing results. Setup is a 11ng STA connected
>> to AP with the attenuation adjusted such that MCS 7 fails, while MCS 5 and below
>> succeed. Monitor is sniffing while sending a single ping from AP to STA.
>>
>> With a rate configuration of (7/2)(3/2)(1/2) we get:
>> 14:02:42.923880 9481489761us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>> 14:02:42.923909 9481490037us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>> 14:02:42.925244 9481491044us tsft 2412 MHz 11n -68dBm signal 13.0 Mb/s MCS 1 20
>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>>
>>
>> with (7/2)(1/2)(3/2):
>> 13:59:37.073147 9295637087us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>> 13:59:37.073467 9295637438us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>> 13:59:37.074591 9295638498us tsft 2412 MHz 11n -68dBm signal 26.0 Mb/s MCS 3 20
>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>>
>> and with (7/2)(3/2):
>> 14:04:27.269806 9585836783us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>> 14:04:27.270342 9585837344us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>> 14:04:27.271368 9585838370us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MCS 7 20
>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>> [..]
>>
>> a total of 14 attempts at MCS 7 with the ping finally failing.
>>
>>>> Both possibilities have great impact, since upper layers (like
>>>> airtime) use the returned rateidx to calculate and configure operating
>>>> parameters at runtime.
>>>
>>> Have you actually observed any issues from this? If it's just skipping a
>>> rate, minstrel should still be able to make decisions based on the
>>> actual values returned, no?
>>>
>> The issues arise from the fact that the driver reports a
>> (tx-rateindex/tx-attemp-index) per TX descriptor, leaving the driver to calculate
>> what was put on air based on these two values. If one had rates set to
>> (7/2)(3/7)(1/2) and the TX status reports (tx-rateindex=2/tx-attempt-index=0),
>> driver assumes there were 10 attempts in total while in fact they were 3 when the
>> second rate is skipped. What direct effect this has on RC I can't grasp, but it
>> definitively falsifies statistics.
>>
>> Same goes for airtime: check how this falsifies its calculation in
>> ath_tx_count_airtime().
> 
> Ah, right, I was assuming that rates[1].count would be reset to zero
> somehow. Have you confirmed that the attempts actually go up on in the
> Minstrel stats for the skipped rate?
> 
>> Also, the above mentioned is an immediate visible issue: if RC
>> provides two rates e.g. (7/3)(5/3) of which the first is too high and
>> the second is not even attempted, frames don't make it through.
> 
> Yeah, rate control would likely take longer to converge to the right
> rate. I suppose if this is a hardware model-specific issue that a quirks
> bit could be added to instruct Minstrel to disregard the second index.
> But it does sound a bit odd; have you verified that it's consistent on
> different units of the same model (and not just a busted device)?
> 

False alarm.

We got confirmation that the observed failure with that exact chip revision is not
happening on a different platform. It still might be a HW issue specific to our
rarely used PPC platform, but it is not an ath9k malfunction. I'll dig further
into that and report back if it is relevant for the list.

Thanks Toke for the feedback and insights and sorry for noise.


Cheers,
Zefir

