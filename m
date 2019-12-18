Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C051123E40
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 05:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLREFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 23:05:31 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:54503 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLREFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 23:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=rFjaA1MgH0DmRFIFWiCHh660Qit95dLDtCB6mWbKeJQ=;
        b=xt+f6jBEA24h268VHBsupd3E1s9407kT9dSO1RbWI8s1KwEOZSxk8dwrT3GqEpeDBL4kHfMP+8xnfVAscUzv5ALXpnSwwqeijXarMyo93KS9SMSWePS+hQB66LqFxSXGP1WDKF0XjXgzFZ0Cd8Y+RXGVawn5hoBh0ePPPXYK8lQ=;
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Ben Greear <greearb@candelatech.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
References: <20191216220747.887-1-greearb@candelatech.com>
 <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de>
 <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de>
 <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com>
 <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com>
 <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
 <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
 <5e3f22d1-b8ba-d756-a15c-1e7ae56c1dad@newmedia-net.de>
 <8eae96cd-a94e-abc1-4750-73f931d657d6@candelatech.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <9431f1a2-a44e-9b81-72b0-9a703e1841ac@newmedia-net.de>
Date:   Wed, 18 Dec 2019 05:05:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <8eae96cd-a94e-abc1-4750-73f931d657d6@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2003:c9:3f0e:3a00:383d:f7f7:6179:80c8]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1ihQZ7-0006Xr-C8; Wed, 18 Dec 2019 05:04:01 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 18.12.2019 um 03:37 schrieb Ben Greear:
>
>
> On 12/17/2019 06:12 PM, Sebastian Gottschall wrote:
>> i dont know what you want to compare here.
>>
>> 1. you compare 2 different wifi chipsets. both have different 
>> sensititivy and overall output power spec
>>
>> 2. both have different amount of antenna chains. which does make a 
>> difference in input sensitivity
>>
>> 3. the patch ben made has no effect on qca9880 chipsets. it only 
>> takes effect on 10.4 based chipsets like 9984
>
> The part of my patch that sums secondary frequencies should apply to 
> wave-1 as well, but I have
> not verified that yet.
yeah. right. sorry i was just looking at total signal sum which uses 
rssi_comb_ht
>
>
>> about noise floors in general. noise floors of -108 are bogus. there 
>> is a physical limit a noise level can be.
>> since drivers like ath9k are doing a cyclic calibration, the noise 
>> value might indeed change. but this calibration is
>> not running in realtime. its cyclic. i'm not aware if chipsets like 
>> qca988x are going the same way, but since qca988x
>> has sime similaries with ath9k chipsets unlike the newer 9984 
>> variants, it could be. the 30 seconds mentioned
>> in the bug report fits to my expectations of the early noisefloor 
>> calibration which has a short delay and after success
>> turning to use a long delay. anyway. in this early calibration phase 
>> signals might change and will stabilize after. this isnt a issue
>> since your connection will work anyway even if it might take a little 
>> bit longer if you have poor signal levels
>>
>> @ben. am i wrong or what do think?
>
> I don't know enough about how the noise floor calculations are done or 
> how the apply to settings
> to know the answer.
>
> I will be happy in general if ath10k wave-1, wave-2, and ath9k report 
> similar RSSI for similar
> setups.
that will not work. you compare different chipsets and depending on the 
implementation by the card vendor
rf sensitivity can be very diffent. the same goes for output power. some 
vendors are using additional rf amps
for enhancing output power (ubiquiti is best example here). this these 
amps also may have influence to sensitivity.
on these cards you set 10 db output power, but in fact it outputs 18 db. 
so there is a bias offset on these cards or devices. (the offset is 
depending on the device model)

what you measure is what the chip receives, but not what was lost on the 
pcb layout. (or was even generated in case of noise)
and when it comes to calibration data. correct would be if each 
individual card is calibrated before shipment. in reality manufactures
are doing calibration on a single reference card and clone it on all 
following cards to save time. the result depends on day or week of 
production
and current position of the moon and sun. errors of +- 2 db are common 
here. (this is not a fact for all card or device vendors)

>
> If you look at the tx-rate-power table in ath10k, for instance, you 
> can see different MCS are transmitted
> at different signal levels.  So, some change from initial conditions 
> might be because higher MCS is
> being transmitted after rate-ctrl scales up?
yes. this is modulation related. as higher the rate goes as lower the 
power will be. thats princible of QAM.
and the rate control itself isnt signal but error rate based. so high 
packet loss triggers the rate control to lower the rate which results
in increased output power and vice versa. but as mentioned. at card 
startup a noise floor calibration starts which may succeed or fail.
if it succeeds it will turn into a long delay phase. so cyclic 
calibration. the calibration time is exactly 30 seconds (minimum) and if 
it fails it can
exceed to 60 seconds. after that time it will sleep for 300 seconds and 
will check for recalibration conditions. (there are rules like high 
noise floor changes etc.)
a recalibration is also triggered at channel changes  and if chipset 
temperature changes at a certain level.
from what i have seen the procedure in the qca9880 firmware is exactly 
the same as in ath9k.
anyway. while this calibration is running, the signal and noise floor 
might be unstable or even bogus until this is finished and rate control 
might not be optimal
under stress conditions like long range links with low signals. with 
standard wifi usage you should not notice it that much since signal to 
noise ratio is high enough anyway


>
> Lots of moving parts...
>
> Thanks,
> Ben
>
>>
>> Sebastian
>>
>> Am 18.12.2019 um 00:37 schrieb Tom Psyborg:
>>> also noticed now that the noise floor changes with signal strength as
>>> described in this bug report:
>>> https://www.mail-archive.com/ath10k@lists.infradead.org/msg11553.html
>>>
>>> after wifi restart
>>>
>>> iwinfo:
>>>
>>> signal: -59dBm noise: -108dBm
>>>
>>> then goes to
>>>
>>> signal: -52dBm noise: -103dBm
>>>
>>> and finally drops to
>>>
>>> signal: -59dBm noise: -103dBm
>>>
>>
>
