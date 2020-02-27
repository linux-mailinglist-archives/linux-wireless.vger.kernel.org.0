Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA4171617
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgB0Leo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 06:34:44 -0500
Received: from nbd.name ([46.4.11.11]:39838 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgB0Leo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 06:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xxanptpIikw5AKXHzujs1PjnZA3W+QG3cOPHMjSrRPw=; b=icOUlHmqVg82jENxNxidQJtaz7
        guamHcbcTo/AmYULWSad00iM9ZRkgtbepUd/MJQqeEbOa9TLosCyGD0lokfMdi3Ps8/AtFpbpkTfh
        FdBXAKuuqkUmECxwY4jrFuXEvYmGqiQlPFDH3ShYvj9c4ewsMDO5/1tGWPGzPzIPZyX4=;
Received: from [80.255.7.118] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j7HR7-0004XW-DZ; Thu, 27 Feb 2020 12:34:37 +0100
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, yiboz@codeaurora.org,
        john@phrozen.org, lorenzo@kernel.org, rmanohar@codeaurora.org,
        kevinhayes@google.com
References: <20191119060610.76681-1-kyan@google.com>
 <20191119060610.76681-5-kyan@google.com>
 <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk>
 <829b6b28-99cd-ea9d-fea3-603a10eae401@nbd.name> <875zfsxs0u.fsf@toke.dk>
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
Message-ID: <04284fb6-4a68-8449-4105-dcf90f128ef8@nbd.name>
Date:   Thu, 27 Feb 2020 12:34:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zfsxs0u.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-27 11:07, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2020-02-26 22:56, Toke Høiland-Jørgensen wrote:
>>> Felix Fietkau <nbd@nbd.name> writes:
>>>> - We need an API that allows the driver to change the pending airtime
>>>> values, e.g. subtract estimated tx time for a packet.
>>>> mt76 an ath9k can queue packets inside the driver that are not currently
>>>> in the hardware queues. Typically if the txqs have more data than what
>>>> gets put into the hardware queue, both drivers will pull an extra frame
>>>> and queue it in its private txq struct. This frame will get used on the
>>>> next txq scheduling round for that particular station.
>>>> If you have lots of stations doing traffic (or having driver buffered
>>>> frames in powersave mode), this could use up a sizable chunk of the AQL
>>>> budget.
>>> 
>>> I'm a bit more skeptical about this. If the driver buffers a bunch of
>>> packets that are not accounted that will hurt that station due to extra
>>> latency when it wakes up. For ath9k, this is the retry_q you're talking
>>> about, right? The number of packets queued on that is fairly limited,
>>> isn't it? What kind of powersave buffering is the driver doing, and why
>>> can't it leave the packets on the TXQ? That would allow them to be
>>> scheduled along with any new ones that might have arrived in the
>>> meantime, which would be a benefit for latency.
>> For mt76 there should be max. 1 frame in the retry queue, it's just a
>> frame that was pulled from the txq in a transmission attempt but that it
>> couldn't put in the hw queue because it didn't fit in the current
>> aggregate batch.
> 
> Wait, if it's only a single frame that is queued in the driver, how is
> this causing problems? We deliberately set the limit so there was a bit
> of slack above the size of an aggregate for things like this. Could you
> please describe in a bit more detail what symptoms you are seeing of
> this problem? :)
It would be a single frame per sta/txq. I don't know if it will cause
problems in practice, it's just a potential corner case that I found
during review. I'd imagine this would probably show up in some
benchmarks at least.
I'm not seeing any symptoms myself, but I also haven't run any intricate
tests yet.

- Felix
