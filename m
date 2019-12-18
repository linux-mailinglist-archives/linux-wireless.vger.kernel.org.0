Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E69123D29
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLRChf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 21:37:35 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:42240 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRChf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 21:37:35 -0500
Received: from [192.168.1.47] (unknown [50.34.171.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0360213C283;
        Tue, 17 Dec 2019 18:37:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0360213C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576636654;
        bh=3H9trgQNWBrc22X6PZNQFVkDGnRAXE2r7TDukdsqHVQ=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=nb0yZIc3xm4CgGP+DHzlq3JVfwEbNs07eAp3Nh6ERXUWG+32wtl71aAOaCNIy++rF
         KaIe5vVmL25thAo0Fv08Ntz8EhMYE1/jbH2yGUxgZSxD/8S6d837v3JfoYc7Fhag8c
         C0r3tGgB4QmrOPWkSf3iPCG3jUBv2pKdzequSLwU=
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Tom Psyborg <pozega.tomislav@gmail.com>
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
Cc:     Justin Capella <justincapella@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <8eae96cd-a94e-abc1-4750-73f931d657d6@candelatech.com>
Date:   Tue, 17 Dec 2019 18:37:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5e3f22d1-b8ba-d756-a15c-1e7ae56c1dad@newmedia-net.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/17/2019 06:12 PM, Sebastian Gottschall wrote:
> i dont know what you want to compare here.
>
> 1. you compare 2 different wifi chipsets. both have different sensititivy and overall output power spec
>
> 2. both have different amount of antenna chains. which does make a difference in input sensitivity
>
> 3. the patch ben made has no effect on qca9880 chipsets. it only takes effect on 10.4 based chipsets like 9984

The part of my patch that sums secondary frequencies should apply to wave-1 as well, but I have
not verified that yet.


> about noise floors in general. noise floors of -108 are bogus. there is a physical limit a noise level can be.
> since drivers like ath9k are doing a cyclic calibration, the noise value might indeed change. but this calibration is
> not running in realtime. its cyclic. i'm not aware if chipsets like qca988x are going the same way, but since qca988x
> has sime similaries with ath9k chipsets unlike the newer 9984 variants, it could be. the 30 seconds mentioned
> in the bug report fits to my expectations of the early noisefloor calibration which has a short delay and after success
> turning to use a long delay. anyway. in this early calibration phase signals might change and will stabilize after. this isnt a issue
> since your connection will work anyway even if it might take a little bit longer if you have poor signal levels
>
> @ben. am i wrong or what do think?

I don't know enough about how the noise floor calculations are done or how the apply to settings
to know the answer.

I will be happy in general if ath10k wave-1, wave-2, and ath9k report similar RSSI for similar
setups.

If you look at the tx-rate-power table in ath10k, for instance, you can see different MCS are transmitted
at different signal levels.  So, some change from initial conditions might be because higher MCS is
being transmitted after rate-ctrl scales up?

Lots of moving parts...

Thanks,
Ben

>
> Sebastian
>
> Am 18.12.2019 um 00:37 schrieb Tom Psyborg:
>> also noticed now that the noise floor changes with signal strength as
>> described in this bug report:
>> https://www.mail-archive.com/ath10k@lists.infradead.org/msg11553.html
>>
>> after wifi restart
>>
>> iwinfo:
>>
>> signal: -59dBm noise: -108dBm
>>
>> then goes to
>>
>> signal: -52dBm noise: -103dBm
>>
>> and finally drops to
>>
>> signal: -59dBm noise: -103dBm
>>
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
