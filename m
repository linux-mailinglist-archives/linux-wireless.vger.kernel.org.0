Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F01A81B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEKOaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 10:30:04 -0400
Received: from nbd.name ([46.4.11.11]:59278 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfEKOaD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 10:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DZMSeZjs6cT5UxXd9HXggx65pMslrrA4MG2HLlwOw1o=; b=ahTt9l507pBJL7z3zVQV4YuwLJ
        mOVGGf+e6RcrzOgjymccEBmLzPNzHzTtX4kIWkvMwfgmVmxDjOGV0gFT7t7DM80646nrlbssX5upY
        a0aPevRikCfAzGeobOcVznTIBYD0EhtRTgcvgPGofa5MT9f1bUZSLUtca63IQGqinrxY=;
Received: from p54ae9c89.dip0.t-ipconnect.de ([84.174.156.137] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hPT0k-0006WK-PD; Sat, 11 May 2019 16:30:02 +0200
Subject: Re: [PATCH 4/4] mt76: mt76x02: run mt76x02_edcca_init atomically in
 mt76_edcca_set
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
References: <cover.1557567465.git.lorenzo@kernel.org>
 <436469e1a4c1e0c11ae43a0b002378708d31f15d.1557567465.git.lorenzo@kernel.org>
 <97ef0073-6dae-f9d1-e97f-9aadaa629628@nbd.name>
 <CAJ0CqmW8RyBmn1_-M0gQGvLOsTd45kAji7wmurs-GHBLac9Dyg@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Openpgp: preference=signencrypt
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 mQGiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwbQcRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPohgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQuQINBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabiEkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <b1f8f1c1-a3f5-d94d-1790-320350578100@nbd.name>
Date:   Sat, 11 May 2019 16:30:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ0CqmW8RyBmn1_-M0gQGvLOsTd45kAji7wmurs-GHBLac9Dyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-11 16:29, Lorenzo Bianconi wrote:
>>
>> On 2019-05-11 12:17, Lorenzo Bianconi wrote:
>> > Run mt76x02_edcca_init atomically in mt76_edcca_set since it runs
>> > concurrently with calibration work and mt76x2_set_channel.
>> > Introduce __mt76x02_edcca_init helper routine
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> I don't think this is enough. To prevent issues with calibration, we
>> probably need to hold the mutex for the duration of the calibration
>> anyway. Otherwise it might get enabled right in the middle of it and
>> screw things up.
>> Also, it probably simplifies the patch if you don't add the wrapper
>> function that takes the mutex, and instead just explicitly take the
>> mutex where needed.
> 
> So IIUC it would be better to hold the mutex during
> mt76x2_phy_calibrate processing, right?
Right.

> If so, do I need to repost all the series or just this patch?
Feel free to repost just this patch.

Thanks,

- Felix
