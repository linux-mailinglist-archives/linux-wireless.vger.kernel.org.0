Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B27171541
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgB0KnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 05:43:03 -0500
Received: from nbd.name ([46.4.11.11]:37148 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgB0KnD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 05:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=95Rk59hmPo2Tb5eR7Me0y/aQ+KCczKBRxIGNQtm5bao=; b=dE7cYA4Y6lP6Y8kcNcsb39p2cl
        TKquz9cEGv/7ZYT0fszZT6OkiqtMm/3vFmFwUJwSM1qUyJPZ/n+OpAKOoUDGAriKbhEMHKs/PGUIP
        ZrPrJPoea7sbhzdqli1z52PdnOfl0Zt748xrK/j7kYYhmiv+RFiMHjEfzglNV/exVxJ4=;
Received: from [80.255.7.118] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j7Gd6-00022G-KZ; Thu, 27 Feb 2020 11:42:56 +0100
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     Kan Yan <kyan@google.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
References: <20191119060610.76681-1-kyan@google.com>
 <20191119060610.76681-5-kyan@google.com>
 <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk>
 <CA+iem5vcz4PqJR+hj9CyS4pJMD4RpNz2RHxQyUy+-qT9y2WhyQ@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <cedd9fa8-e6ff-be64-d013-4243cb2fd85f@nbd.name>
Date:   Thu, 27 Feb 2020 11:42:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+iem5vcz4PqJR+hj9CyS4pJMD4RpNz2RHxQyUy+-qT9y2WhyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-27 09:24, Kan Yan wrote:
>> - AQL estimated airtime does not take into account A-MPDU, so it is
>> significantly overestimating airtime use for aggregated traffic,
>> especially on high rates.
>> My proposed solution would be to check for a running aggregation session
>> and set estimated tx time to something like:
>> expected_airtime(16 * skb->len) / 16.
> 
> Yes, that's a known limitation that needs to be improved. I actually
> post a comment for this patch:
> "[PATCH v10 2/4] mac80211: Import airtime calculation code from mt76"
>>
>> When a txq is subjected to the queue limit,
>> there is usually a significant amount of frames being queued and those
>> frames are likely being sent out in large aggregations. So, in most
>> cases when AQL is active, the medium access overhead can be amortized
>> over many frames and the per frame overhead could be considerably
>> lower than 36, especially at higher data rate. As a result, the
>> pending airtime calculated this way could be higher than the actual
>> airtime. In my test, I have to compensate that by increasing
>> "aql_txq_limit" via debugfs to get the same peak throughput as without
>> AQL.
> 
> 
>> My proposed solution would be to check for a running aggregation session
>> and set estimated tx time to something like:
>> expected_airtime(16 * skb->len) / 16.
> 
> I think that's a reasonable approximation, but doubts aggregation
> information is available in all architectures. In some architecture,
> firmware may only report aggregation information after the frame has
> been transmitted.
I'm not proposing using frame transmission aggregation. It would be a
simple approximation where it would use a fixed assumed average
aggregation size if an aggregation session is established.

> In my earlier version of AQL for the out-of-tree ChromeOS kernel,
> A-MPDU is dealt this way:  The the medium access overhead is only
> counted once for each TXQ for all frames released to the hardware over
> a 4ms period, assuming those frames are likely to be aggregated
> together.
I think that would be more accurate, but probably also more expensive to
calculate.

> Instead of calculating the estimated airtime using the last known phy
> rate, then try to add some estimated overhead for medium access time,
> another potentially better approach is to use average data rate, which
> is byte_transmited/firmware_reported_actual_airtime. The average rate
> not only includes medium access overhead, but also takes retries into
> account.
Also an interesting idea, though probably not available on all hardware.

>> - We need an API that allows the driver to change the pending airtime
>> values, e.g. subtract estimated tx time for a packet.
>> mt76 an ath9k can queue packets inside the driver that are not currently
>> in the hardware queues. Typically if the txqs have more data than what
>> gets put into the hardware queue, both drivers will pull an extra frame
>> and queue it in its private txq struct. This frame will get used on the
>> next txq scheduling round for that particular station.
>> If you have lots of stations doing traffic (or having driver buffered
>> frames in powersave mode), this could use up a sizable chunk of the AQL
>> budget.
> 
> Not sure I fully understand your concerns here. The AQL budget is per
> STA, per TID, so frames queued in the driver's special queue for one
> station won't impact another station's budget. Those frames are
> counted towards the per interface pending airtime, which could trigger
> AQL to switch to use the lower queue limit. In this case, that could
> be the desirable behavior when there is heavy traffic.
Yes, the per interface limit is what I'm concerned about. I'm not sure
if it will be an issue in practice, it's just something that I noticed
while reviewing the code.

- Felix
