Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA21C0169
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfI0IrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 04:47:15 -0400
Received: from nbd.name ([46.4.11.11]:43972 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0IrP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 04:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4TbuAg0f1vW/k/Q6fFLZAZgR58dttZia1VaF+IuDaGw=; b=Sfmm7JMLCb7WcGO1Ay+6AQipfI
        T8kbfKhP9B+wss/F0TTDHyMS8XAz41vUZv0JOhcQs9FfcuLi59qZA6NyJNx7hRg5Mxtor2pQh/huO
        pxDslB3I6Go1ASxjLw3xcCLr8o+u9yaej5YKzB891Nb41Gp8LJWXC2YT6wb7LBNcQKKA=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDluE-00073s-0J; Fri, 27 Sep 2019 10:47:14 +0200
Subject: Re: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for
 airtime fairness and survey
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
References: <20190926174732.42375-1-nbd@nbd.name>
 <20190926174732.42375-10-nbd@nbd.name> <871rw218ty.fsf@toke.dk>
 <2475938e-b82c-9924-f7db-f475ec2530b3@nbd.name> <87sgoiyw0p.fsf@toke.dk>
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
Message-ID: <27bb95dd-1f0e-5862-3616-04452808e736@nbd.name>
Date:   Fri, 27 Sep 2019 10:47:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87sgoiyw0p.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-27 10:37, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2019-09-27 09:45, Toke Høiland-Jørgensen wrote:
>>> Felix Fietkau <nbd@nbd.name> writes:
>>> 
>>>> Estimate by calculating duration for EWMA packet size + estimated A-MPDU
>>>> length on tx status events
>>> 
>>> Would it make sense to move some of this code into mac80211? If we're
>>> going to do airtime estimation for queue limiting it may make sense to
>>> use this instead of the simplistic estimate I used in my RFC patch?
>> Sure. I mainly put it in the driver because I wanted to get it working,
>> tested and merged first without having to wait for a mac80211-next ->
>> wireless-drivers-next merge.
> 
> Right, OK. So that means another patch set on top of this to move it
> afterwards? Don't suppose you can be convinced to take care of that as
> well? :)
I could, but I don't know when I will have time for it, since my plate
is pretty full at the moment.

- Felix
