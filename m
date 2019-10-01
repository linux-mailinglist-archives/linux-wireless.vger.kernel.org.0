Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A04C31CD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfJAKwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:52:16 -0400
Received: from nbd.name ([46.4.11.11]:55780 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfJAKwP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ca5yI2RNFSqrsK9sm6nitHIALj8F0DAqbPKRja6JU9A=; b=Q6uUxIAPqJmNTT/yz+3L64E/30
        pRIJjan1QAiTKhYc3UvU0gH9il5+qwA75MpRQJG2qSTpnTGSCeOkakFbNTYUz0t8ckypF3QoYiELI
        7zM9+RnJB+SufP9T3E/zQcIiijHKy9UTwya0Tb6o+237L3S1WAMWs3Q6lUZHzyKyylRk=;
Received: from p5b20652d.dip0.t-ipconnect.de ([91.32.101.45] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iFFlN-0007nt-Qq; Tue, 01 Oct 2019 12:52:13 +0200
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a
 better moving average
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190929154646.90901-1-nbd@nbd.name>
 <20190929154646.90901-2-nbd@nbd.name>
 <f40bd542d0d13f5be701de41b8870b0bd1f34230.camel@sipsolutions.net>
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
Message-ID: <017c1a59-edf2-0a1a-aa8c-3c32e57d6cd0@nbd.name>
Date:   Tue, 1 Oct 2019 12:52:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f40bd542d0d13f5be701de41b8870b0bd1f34230.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-01 12:17, Johannes Berg wrote:
> 
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
> 
> Would it be worth pulling that out into similar helpers to EWMA in
> average.h, perhaps even in the same file?
> 
> You need to keep a bit more state, but essentially the same API should
> work since EWMA already declares the "struct ewma_something" once you
> use the DECLARE_EWMA().
Might be useful, yes. The main issue here is that the period / window
size has to be hardcoded through the coefficient values, unless we find
a way to do floating point math, including exp() and cos() at compile
time, including conversion to fixed point.

- Felix
