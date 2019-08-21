Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAE97741
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfHUKkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 06:40:18 -0400
Received: from nbd.name ([46.4.11.11]:35850 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfHUKkS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 06:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zk1OZ4AZxMZIHmxBRMpz486j7h5k1iWmCFDX+hGXK+o=; b=LrBITJSp791dXNqswLKgcKVnch
        8sUWIeZxWfRedwjasZjPdoRKeD5ErBVIGcbyiUBBHZZBEGhJ428r7YcBaELAV9pDwDbh7ozEXeDc+
        ybZ/lahmPOdVXbJJJUUnUEP3ylF9awRbzCIF2t1CNA1G5bqiZrZAqKeVtzz/6kkmA9X4=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0O2J-0005ko-Et; Wed, 21 Aug 2019 12:40:15 +0200
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
From:   Felix Fietkau <nbd@nbd.name>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
 <20190815100936.GA21775@redhat.com>
 <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
 <20190819110639.GA6037@redhat.com>
 <7b46ab63-d69d-f389-b3c2-245cbe11c7b7@nbd.name>
 <20190820112438.GA2227@redhat.com> <20190821084724.GB20223@redhat.com>
 <433c1d1f-3590-375f-ed8d-c9de2af873d5@nbd.name>
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
Message-ID: <876a4137-ecd5-2e6c-0c75-87eae895e672@nbd.name>
Date:   Wed, 21 Aug 2019 12:40:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <433c1d1f-3590-375f-ed8d-c9de2af873d5@nbd.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-21 11:03, Felix Fietkau wrote:
> On 2019-08-21 10:47, Stanislaw Gruszka wrote:
>> On Tue, Aug 20, 2019 at 01:24:39PM +0200, Stanislaw Gruszka wrote:
>>> > Can you test if disabling hw encryption only for shared or only for
>>> > pairwise keys makes any difference?
>>> 
>>> Disabling only pairwise keys helps. Disabling only shared keys does
>>> not help.
>>> 
>>> Not sure if this will be helpful information or make things more
>>> confusing, but seems the difference between mt76_txq_schedule()
>>> and tasklet_schedule() in mt76_wake_tx_queue() is that on 
>>> mt76_txq_schedule() some tx packets are serialized by dev->rx_lock
>>> (because some ARP and TCP packets are sent via network stack as response
>>> of incoming packet within ieee80211_rx_napi() call). Removing
>>> spin_lock(&dev->rx_lock) in mt76_rx_complete() make the problem
>>> reproducible again with mt76_txq_schedule() & HW encryption.
>> 
>> So, I think this is FW/HW issue related with encryption and ordering
>> and we should apply patch originally posted in this thread that
>> disable HW encryption for MT7630E.
>> 
>> I do not think we should disable HW encryption only for pairwise keys,
>> because FW/HW can have the same bug for shared keys, but is not
>> triggered in my test, as we do not sent lot of group frames.
> I'm still not convinced that this is just the hardware implementation of
> hw crypto being faulty. I think it's more likely that there's a bug in
> the tx path somewhere, which causes hangs on MT7630E but remains hidden
> (or at least recoverable) on other devices.
> I'm currently reviewing key handling in the mac80211 fast-xmit codepath
> and get the feeling that something might be racy there.
> I will let you know when I make some progress with that review.
> If we can't find the bug soon, then I'm fine with merging this patch.
> Right now, I would like to see first if we can fix it properly.
Another question: Does a watchdog restart happen before tx fails?

- Felix
