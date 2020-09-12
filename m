Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36E2677F7
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Sep 2020 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgILFGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Sep 2020 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgILFGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Sep 2020 01:06:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B581C061573
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Uy8Fy+jdpS1aZ/aa4dYb/2qAzNxItfbQSomjvNFML4Y=; b=MVbNcTGTIAPwSp5AC9wetnHZxH
        ARS4PWaGqmauHjj8pLZIyMfPK2NifwqRYkmmKTKHStNA3TaeJZTRKA818KnCvgvlLLntqTjMQQFYg
        sT0+K8kucW5PyIIFSGb7MyPfRv5umvjYdjbGmj98ZcyA84NIepGtk6aEO4a9lDiCKSPM=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kGxjb-0006Re-P5; Sat, 12 Sep 2020 07:05:59 +0200
Subject: Re: [PATCH 04/11] mt76: add utility functions for deferring work to a
 kernel thread
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20200908211756.15998-1-nbd@nbd.name>
 <20200908211756.15998-4-nbd@nbd.name>
 <010101747c3b747d-09af9fc1-2e74-400f-89f5-fae71b7d163b-000000@us-west-2.amazonses.com>
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
Message-ID: <7e2b25d9-c6cc-1c78-a96f-e60604408578@nbd.name>
Date:   Sat, 12 Sep 2020 07:05:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <010101747c3b747d-09af9fc1-2e74-400f-89f5-fae71b7d163b-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 10:15, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> In order to avoid keeping work like tx scheduling pinned to the CPU it was
>> scheduled from, it makes sense to switch from tasklets to kernel threads.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]
> 
>> --- a/drivers/net/wireless/mediatek/mt76/util.c
>> +++ b/drivers/net/wireless/mediatek/mt76/util.c
>> @@ -110,4 +110,32 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
>>  }
>>  EXPORT_SYMBOL_GPL(mt76_get_min_avg_rssi);
>>  
>> +int __mt76_worker_fn(void *ptr)
>> +{
>> +	struct mt76_worker *w = ptr;
>> +
>> +	while (!kthread_should_stop()) {
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +		if (kthread_should_park()) {
>> +			kthread_parkme();
>> +			continue;
>> +		}
>> +
>> +		if (!test_and_clear_bit(MT76_WORKER_SCHEDULED, &w->state)) {
>> +			schedule();
>> +			continue;
>> +		}
>> +
>> +		set_bit(MT76_WORKER_RUNNING, &w->state);
>> +		set_current_state(TASK_RUNNING);
>> +		w->fn(w);
>> +		cond_resched();
>> +		clear_bit(MT76_WORKER_RUNNING, &w->state);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(__mt76_worker_fn);
> 
> So how is this better than, for example,
> create_singlethread_workqueue()? And if this is better, shouldn't it be
> part of workqueue.h instead of every driver reinventing the wheel?
Unlike a workqueue, this one only allows one fixed worker function to be
executed by the worker thread. Because of that, there is less locking
and less code for scheduling involved.
In fact, the function that schedules the worker is small enough that
it's just a simple inline function.
The difference matters in this case, because the tx worker is scheduled
very often in a hot path.
I don't think it fits into workqueue.h (because of the lack of
separation between workqueue and work struct), and I don't know if other
drivers need this, so let's keep it in mt76 and only move to a generic
API if we find another user for it.

- Felix
