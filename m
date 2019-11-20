Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F258F1038D3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 12:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfKTLg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 06:36:57 -0500
Received: from nbd.name ([46.4.11.11]:53046 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfKTLg5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 06:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dtTMopqsXpo7wgKZ9bn+4hdG1qLKud8WMJFDMxssRbQ=; b=o1iWGOVqjQOKFC98YTxr0612ZD
        ona8NxeLKWezeX+MeLpoJgr9EQKQornq1W1AAMM1OUTVwIQ6wi1LOAO1gHC0/ifAFvNRjOWppXPyp
        Iv0c4JKLjvb7u0kv03QFVPjnYFweUELRyHLAWGVh2xWu0BEgLiH1zYnpFlbONAI1b2UQ=;
Received: from p4ff13fe7.dip0.t-ipconnect.de ([79.241.63.231] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iXOI3-00065O-Uz; Wed, 20 Nov 2019 12:36:56 +0100
Subject: Re: [PATCH] mt76: disable softirqs while calling ieee80211_rx_napi
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org
References: <20191104134540.19199-1-markus.theil@tu-ilmenau.de>
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
Message-ID: <84675864-e39a-2015-d9e4-9595d88fc32b@nbd.name>
Date:   Wed, 20 Nov 2019 12:36:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191104134540.19199-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-04 14:45, Markus Theil wrote:
> mac80211 assumes ieee80211_rx_napi to be called with disabled softirqs.
> 
> ieee80211_rx_napi in mac80211.c can be called from aggregation reordering work queue
> or from mt76_rx_poll_complete. mt76_rx_poll_complete does currently not disable softirq
> processing.
> 
> This patch fixes this by disabling softirqs before calling ieee80211_rx_napi.
> It should be no problem to disable them twice, if mt76_aggr_reorder_work calls ieee80211_rx_napi
> and has already called local_bh_disable, as local_bh_disable/local_bh_enable are reentrant.
> 
> I became aware of this issue by the following dmesg output:
>   NOHZ: local_softirq_pending 08
> 
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
I believe this fix is incomplete. If we run with softirq enabled at this
point, it also implies that we've taken the RCU lock with softirq
enabled, which we really shouldn't do.
I believe this should be fixed by changing rcu_read_lock/unlock to the
_bh variant in mt76_dma_rx_poll(). I will send a patch for that.

Thanks,

- Felix
