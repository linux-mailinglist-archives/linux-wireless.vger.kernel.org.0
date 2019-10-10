Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E80D2090
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 07:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfJJF4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 01:56:37 -0400
Received: from nbd.name ([46.4.11.11]:43366 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfJJF4g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 01:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6Sa4ogDKtaoaSCtMsMa5zSW7i7Opg6+eI/MkR7lfzm4=; b=I7dRy2o0cn7sgYiVQ7BBHaVd2P
        GVNcSJPPjXt5g7DPtTU3EJJg1AAJWKiF3pSHdbdij6kImSaF4THpl7W2MF5xOge9KwEeFNMNr1Hur
        oNERA1H5HGRJYKHA8OPZbTKrycQcQBlQXzZihnRmxWJFomMmPZZTOZ2StzqjagXB1GeM=;
Received: from p54ae92e8.dip0.t-ipconnect.de ([84.174.146.232] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iIRRB-00062z-6X; Thu, 10 Oct 2019 07:56:33 +0200
Subject: Re: [PATCH] mac80211: rework locking for txq scheduling / airtime
 fairness
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20190315100335.91445-1-nbd@nbd.name>
 <b2bded992cb02bad84fc738b7e4b1837@codeaurora.org>
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
Message-ID: <5005bfd2-c207-6c2b-ae87-71ef6a16980e@nbd.name>
Date:   Thu, 10 Oct 2019 07:56:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b2bded992cb02bad84fc738b7e4b1837@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-10 04:43, Yibo Zhao wrote:
> Hi Felix,
> 
> In ath10k, we might have situations like,
> 
>            CPU0                           CPU1
> ...                                   ieee80211_txq_schedule_start()
> ...                                   while(ieee80211_next_txq()) {
> ...                                       driver dequeue packets from 
> txq
> ...                                       ieee80211_return_txq()
> ieee80211_txq_schedule_start()            ...
> ieee80211_next_txq()                  }
> driver dequeue packets from txq       ieee80211_txq_schedule_end()
> ieee80211_return_txq()
> ieee80211_txq_schedule_end()
> 
> The problem is while CPU1 is looping to dequeue txqs, the schedule_round 
> which is used to make sure no infinite loop will be changed in CPU0. So 
> a txq has already been scheduled will be scheduled again then the loop 
> won't be end at that point as our expected.
Hi,

I think this is something that should be fixed in the driver. The
comment for ieee80211_txq_schedule_start() already states:
"The driver must not call multiple TXQ scheduling rounds concurrently"

The way that I'm dealing with this in mt76 is that I ensure that all txq
scheduling is done from a single tasklet, which is scheduled from the tx
status and the queue wake path.

I think that approach should perform well in ath10k as well, and it will
avoid the cost of waiting for a lock on one CPU while the other is
scheduling tx already.

- Felix
