Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32289B2942
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2019 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbfINBTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 21:19:00 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:57118 "EHLO
        17.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390867AbfINBS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 21:18:59 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 21:18:58 EDT
Received: from player726.ha.ovh.net (unknown [10.108.35.211])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id B44B6225034
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 20:43:55 +0200 (CEST)
Received: from awhome.eu (p57B7E67F.dip0.t-ipconnect.de [87.183.230.127])
        (Authenticated sender: postmaster@awhome.eu)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id C5C289B9C9DA;
        Fri, 13 Sep 2019 18:43:48 +0000 (UTC)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1568400227;
        bh=55B5kFC1l9NnAPKYZQM5AqW8VaMp7jUnZAHoghe6lkc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kIpP8gSLjAYljau+OmS5OMGilU3nbRvTBAf/UO2Z+H71s4wazgNEq+n6MioZqFPjG
         Z9cNkJe0Pj0yxgAfOiFIl6aqgjmtlm4aUWzJJWERrJEkbD8yOj8Q/YpH1D0CKrMSec
         9CFuD1aCzX66Ryf6HH6kfUgj4CRKvXwJO304Y6VA=
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Denis Kenzior <denkenz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
 <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
 <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <039058ff-178b-2396-eb10-107d8b5f8b93@wetzel-home.de>
Date:   Fri, 13 Sep 2019 20:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16387191672066874496
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> Hi Denis,
>>
>>>> I don't know anything about the driver here but in mac80211 the idea 
>>>> to avoid the race is to simply flush the queues prior deleting the 
>>>> outgoing key.
>>>
>>> Maybe a silly question, but what does flushing the queue mean in this 
>>> context?  Is it waiting for all the packets to be sent or dropping 
>>> them on the floor?
>>>
>>
>> It's stopping them to make sure nothing can be added and then sends 
>> out all MPDUs in the queues.
>>
>>>>
>>>> Now wpa_supplicant is not yet bypassing qdisks, but adding the 
>>>> socket parameter PACKET_QDISC_BYPASS is basically a one-liner in 
>>>> wpa_supplicant and should allow a generic way for drivers to avoid 
>>>> the race with a simple queue flush...
>>>
>>> Can you expand on this actually?  What would the sequence of events be?
>>>
>>
>> 1) wpa_supplicant hands over eapol #4 to the kernel.
>>     When bypassing the QDISC the frame is directly added to a driver
>>     queue or directly send out. When the send call returns the driver
>>     has eapol 4 either in the queuem already send it or the send command
>>     has failed.
>>
>> 2) wpa_supplicant deletes the old key (NL80211_CMD_DEL_KEY)
>>
>> 3) The driver stops all hw queues and sends out all MPDUs queued up to
>>     that time
>>
>> 4) Driver makes sure no traffic can be send with no/wrong key or PN to
>>     STA
>>
>> 5) the driver really removes the key from the HW/installs the new and
>>     resumes normal operation
>>
>> I've just posted my hostpad patch to use PACKET_QDISC_BYPASS for eapol 
>> frames; It's probably too optimistic and need more code to retry a 
>> transmit to compensate for the missing QDISC buffers.
>>
>>> Also, how would this be made to work with CONTROL_PORT over NL80211 ?
>>>
>>
>> Control port is an optional feature drivers can provide. 
>> wpa_supplicant should just use it when available or fall back to the 
>> "traditional" path when not. Now the driver don't has to flush all 
>> queues when using control port, as long as it makes sure the control 
>> port frame will be send out prior to deleting the key.
>>
>> But then the driver must know that eapol frames will really be handed 
>> over via control port; So I guess flushing all queues is still the 
>> simpler solution. So I guess it will change next to nothing...
> 
> Well, in the steps you describe (maybe its just how you describe it) it 
> relies on how the driver is handling it all. I mean step 4) seems more 
> the goal of the whole approach.
>
Well, if you do not take care there are plenty of pitfalls a driver can 
fall into when trying to rekey, especially when having ongoing traffic.
Most drivers will need some code to make sure they can safely delete the 
old key for a STA and install a new one without a full disassociation.
Just what exactly is driver/hw depended. (I've detailed knowledge for 
iwlfifi and ath9k and good guess how ath10 is handling it. All other 
cards: No idea...)

I've tested around ten different cards (Android, iPhone, notebooks, usb 
dongles) and found only two handling it correctly. The chances that 
someone has both an AP and a device handling that correctly is therefore 
not very good, but then my sample is still too small to be representative.
Known broken devices are e.g. Samsung galaxy S5, Nexus 5x, HTC 10, my 
Samsumg Smart TV, iwlwifi cards (both windows and linux, just different) 
and for sure any device using ath9k driver with a kernel < 4.19.

The only "good" devices I found were an iPhone (forgot the model) and a 
Microsoft Surface Pro (also forgot the exact model)

I was focusing on cards I'm using: iwlwifi, ath9k and ath10k. Of those 
cards ath10k was ok, iwlwif was working around 50% of the rekeys and 
ath9k 100% broken (pretty sure it compromised even the security by 
sending out the some frames two times: With encryption and without.

The details of that are best documented here, which fixed it for many - 
but probably not all - mac80211 cards:
https://patchwork.kernel.org/patch/10583675/

The core idea here is, to tell hostpd/wpa_supplicant when a driver 
believes it can rekey correctly and without that confirmation refuses to 
reky but disconnect/reconects fast. But that is work in progress, 
delayed by first implementing the "ideal" rekey solution added in IEEE 
802.11 - 2102 "Extended key ID".

Problem is of course, that all card/drivers are handling things a bit 
different and what works for one may well be broken for another. ath10k 
is a good sample for that: Doing basically everything in HW it worked 
quite well, bypassing the pitfalls.

The generic risks are:
- PN out of sync with the key (ath9k's main fault)
   Especially risky are drivers using HW crypto but generating the PNs in
   SW.

- A-MPDU sessions across rekeys. (Holding back MPDUs till all belonging
   to the session are received. And then bump the PN for the new key to
   the value the old key used. And then dropping all MPDUs for the new
   key as "replay")

- Not stopping/blocking Tx depending on the outgoing key

- repeating lost frames originally send with the old with the new key


> Basically, we now have two bypass methods dealing with the same/similar 
> issue:
> 
> 1) bypass the QDISC.
> 2) bypass network stack entirely with CONTROL_PORT.
> 
> How does option 1) work for drivers that skip the QDISC for all traffic 

Which drivers skip QDISC, and how? I'm not aware of a way "normal" 
network traffic can do that.
A "normal" linux wlan driver will register as a network card and short 
of setting PACKET_QDISC_BYPASS on the socket or providing a non-standard 
API all network traffic will pass trough QDISC. (But that's mostly new 
area for me, just stitched the path together end2end some days ago.)

Now assuming you start a load generator using PACKET_QDISC_BYPASS and 
try to rekey the connection: the NIC driver still will have the eapol#4 
in one of it's queue. So stopping to add new skb's for the queues and 
send out everything which is in the driver queues would send out tons of 
other MPDUs, but one of them would be the eapol #4 one.

The only "trick" here is, that the the sendto() call from wpa_supplicant 
up to the *driver* queues is atomic. With PACKET_QDISC_BYPASS set it - 
at least for my understanding after investigating the issue some hours.

Once the sendto call returns and code execution in wpa_supplicant 
continues - heading for the key deletion - the eapol #4 MPDU is 
accessible for the driver and can be send out.

> and rely on mac80211 to schedule the packets? Guess mac80211 can control 
> that, right?
> 

Not sure i understand that part.. mac80211 is like the top half of a 
wlan driver: It handles some parts but the full driver consists of 
(mac80211 + low level driver).

Alexander
