Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D92179652
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgCDRJD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 12:09:03 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:38356 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgCDRJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 12:09:03 -0500
Received: from [192.168.2.98] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id AEE55580074;
        Wed,  4 Mar 2020 18:08:58 +0100 (CET)
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
To:     Steve deRosier <derosier@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, nbd@nbd.name,
        lorenzo@kernel.org
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
 <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
 <CALLGbRKPCSZW8PFQXat+_=+iD_ED81j16vNtTbF=KW-B-tTWPQ@mail.gmail.com>
 <fe471ae5-bebf-a673-48ee-f06c47f3721d@tu-ilmenau.de>
 <CALLGbR+Q_c5x-uNK41c-m3xUj_JtgtUVmWbLFs7d_2C=fmbNUQ@mail.gmail.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <34d072f8-08b7-d4db-ca1c-c00a915e93b8@tu-ilmenau.de>
Date:   Wed, 4 Mar 2020 18:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALLGbR+Q_c5x-uNK41c-m3xUj_JtgtUVmWbLFs7d_2C=fmbNUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/4/20 5:34 PM, Steve deRosier wrote:
> On Wed, Mar 4, 2020 at 1:34 AM Markus Theil <markus.theil@tu-ilmenau.de> wrote:
>>
>> On 3/3/20 10:59 PM, Steve deRosier wrote:
>>> On Tue, Mar 3, 2020 at 1:28 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>>> On Tue, 2020-03-03 at 12:50 +0100, Markus Theil wrote:
>>>>> Back in 2007 "mac80211: don't allow scanning in monitor mode"
>>>>> (f27b62d3e7ec) disabled scanning in monitor mode, because hw
>>>>> controlled by the zd1211rw driver got confused during this operation.
>>>>>
>>>>> Nevertheless, it can be useful to scan in monitor mode, e.g.
>>>>> when building a tool which processes scans, channel surveys and
>>>>> monitors the channel passively in monitor mode.
>>>> Hmm. I'm not really sure that this makes sense.
>>>>
>>>> You're in monitor mode, so you won't get any scan processing as such
>>>> (you will not be able to use nl80211 to retrieve the results!), and
>>>> there will be a lot of confusion over sending probe requests (the code
>>>> now looks like it would in fact attempt to do so ... but how?).
>>>>
>>> Additionally, I don't see what this solves for sure.  At least on an
>>> ath10k device I've been using, I can have two interfaces on one phy
>>> (phy0), wlan0 and mon0, and I can issue a `iw wlan0 scan` and it works
>>> famously and then capture fine on mon0. Granted, I haven't tried doing
>>> a scan while at the same time am actively capturing, but I wonder of
>>> the meaning of that anyway as the capturing radio would have to then
>>> go off channel and issue probe requests etc., sort of screwing up my
>>> capture for that time period.  But anyway, can you not do this on your
>>> radio?
>>>
>>> - Steve
>> I was not able to use this combination of interfaces, when only interested in monitoring networks.
>> The STA VIF can only scan when its put up, but then I cannot choose the operating frequency of the
>> monitor interface freely. Sure, I can build workarounds, like changing the interface type when I need
>> an active scan and chaning it back to monitor mode afterwards, but this also seems not very clean.
>>
> Hi Markus,
>
> I'm trying to understand the semantics of what happens when I'm
> actively doing a capture, and then issue a `iw mon0 scan` (or equiv).
> What happens to the capture and how do I make sense of it?
>
> Personally I prefer the explicit over the implicit with confusing
> results.  The following sequence is clearer and explicit to me:
>
> ifconfig wlan0 up
> iw wlan0 scan
> ifconfig wlan0 down
> iw mon0 set channel 36 HT40+
> tshark -i mon0 .....
>
> Obviously I'm using command-line tools to illustrate, tools might use
> the API instead.  In any case, there's no possible confusion over what
> the semantics might be because it's not possible to have the confusing
> state.
>
> I hear what you're saying, and you're right, in userspace you have to
> do multiple steps for your use-case.  In thinking about it, _should_
> the kernel have changes in it to make your specific use-case easier?
> And _should_ it do so for one particular NIC that works in a
> particular way?  What happens with the other NICs that have different
> capabilities and semantics than the mt76?  Seems to me that a clean
> and straightforward mechanism in the kernel is "very clean" while it's
> OK for userspace, which is where policy stuff is supposed to be, to
> have to jump through a few hoops. Do we want to add complexity and
> maintain that for all the drivers simply to avoid having two VIFs and
> avoid the extra steps of bringing one up and down when we want to do a
> scan? Your usecase is already possible, and IMHO, not that difficult
> to achieve. But maybe I'm missing some terrible hole here as I've not
> tried to write whatever app it is you're writing nor do I usually work
> with the mt76.
Sure, I can achieve what I want to do with multiple steps, like
you already sketched in your command-line example above.
Should these patches introduce more issues in the long run than
saving some steps in this particular use-case is worth it, I totally
agree, that such a feature should not be included in the kernel.

I only included the flag for mt76, because these were the NICs
I had readily available to test with.
> Honestly, I don't have the answers, but I want to raise the questions
> as they impact more than your one usecase and NIC. The semantics of
> your mechanism don't seem very clean to me, and I worry that if other
> people on NICs decide to enable your feature flag, we're going to have
> a fun time supporting that. I'm sure the maintainers will sort it out.
>
> Thanks,
> - Steve

Thanks for expressing your concerns and bringing more clarity into the discussion!

Markus


