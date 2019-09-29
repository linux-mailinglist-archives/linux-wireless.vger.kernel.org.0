Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8BC1915
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfI2TSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 15:18:32 -0400
Received: from nbd.name ([46.4.11.11]:46316 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbfI2TSc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 15:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P08Jm0rXOLIiHp/vDKTWuqc2i1RWGH1eNraI0BbK8dY=; b=tT3wniaddo2HLH9vbmDd9EVWgh
        vdc4D5MT9Y0tbsIlmJGj13Z9AKENo7ON/KcDZiwX4oEgM5iplgV7+RL8PwAo0NyFf9eu74OPFxlMo
        96Wxu9c6Z2aQ4MhOBVcDD7BplaC1/LTCCc360sTCQ2ToyWec3cyz8/ZU/n2SQ4Fom1uw=;
Received: from p5b20652d.dip0.t-ipconnect.de ([91.32.101.45] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iEeiD-0000O9-Hi; Sun, 29 Sep 2019 21:18:29 +0200
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a
 better moving average
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20190929154646.90901-1-nbd@nbd.name>
 <20190929154646.90901-2-nbd@nbd.name> <87zhinx7u7.fsf@toke.dk>
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
Message-ID: <b2566142-a7ea-50e8-e683-a3702b75ea6f@nbd.name>
Date:   Sun, 29 Sep 2019 21:18:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87zhinx7u7.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-29 20:42, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Rate success probability usually fluctuates a lot under normal conditions.
>> With a simple EWMA, noise and fluctuation can be reduced by increasing the
>> window length, but that comes at the cost of introducing lag on sudden
>> changes.
>>
>> This change replaces the EWMA implementation with a moving average that's
>> designed to significantly reduce lag while keeping a bigger window size
>> by being better at filtering out noise.
>>
>> It is only slightly more expensive than the simple EWMA and still avoids
>> divisions in its calculation.
>>
>> The algorithm is adapted from an implementation intended for a completely
>> different field (stock market trading), where the tradeoff of lag vs
>> noise filtering is equally important. It is based on the "smoothing filter"
>> from http://www.stockspotter.com/files/PredictiveIndicators.pdf.
>>
>> I have adapted it to fixed-point math with some constants so that it uses
>> only addition, bit shifts and multiplication
>>
>> To better make use of the filtering and bigger window size, the update
>> interval time is cut in half.
>>
>> For testing, the algorithm can be reverted to the older one via
>> debugfs
> 
> This looks interesting! Do you have any performance numbers from your
> own testing to share? :)
To show the difference, I also generated some random data, ran it
through minstrel's EWMA and the new code and made a plot:
http://nbd.name/ewma-filter-plot.png

The real world test that I did was using mt76x2:
I ran 3 iperf TCP streams from an AP to a station in a cable setup with
an attenuator.
I switched from 70 dB attenuation to 40 dB and measured the time it
takes for TCP throughput to stabilize at a higher rate.
Without my changes it takes about 5-6 seconds, with my changes it's only
2-3 seconds.

- Felix
