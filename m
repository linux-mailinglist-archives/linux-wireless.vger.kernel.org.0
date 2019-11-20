Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA97010396D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 13:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfKTMDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 07:03:02 -0500
Received: from nbd.name ([46.4.11.11]:54570 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfKTMDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 07:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yS+2O5rZ8IAgyH0H857VHTFoQO0nTiOVyHM5S5zXopk=; b=X9G60fnX1B48Ei5ZeHBpaArFnx
        TCsXWSFXyqDwpX1hmNuii14PUk+1V78rg48MYb2aefUk3ZsDtpEJc1I/yDiEgPdgmUiG/uEoRhMWK
        gXbArRNzvzkJNVoeLeWnuy1IjMi5n7s9S06XHnURK2nM3wGvVvmGGsnp6zN393x69GAs=;
Received: from p4ff13fe7.dip0.t-ipconnect.de ([79.241.63.231] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iXOhJ-0007hd-Eu; Wed, 20 Nov 2019 13:03:01 +0100
Subject: Re: [PATCH] mt76: use rcu_read_lock_bh in mt76_dma_rx_poll
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
References: <20191120114647.88967-1-nbd@nbd.name>
 <00ba1886-188f-f8f8-07f1-61a89bbdd768@tu-ilmenau.de>
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
Message-ID: <ec3204cf-ad4a-aecf-fed9-720523d58ff8@nbd.name>
Date:   Wed, 20 Nov 2019 13:03:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <00ba1886-188f-f8f8-07f1-61a89bbdd768@tu-ilmenau.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-20 12:59, Markus Theil wrote:
> On 11/20/19 12:46 PM, Felix Fietkau wrote:
>> Fixes potential RCU issues and avoids calling ieee80211_rx_napi with softirq
>> enabled.
>>
>> Reported-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  drivers/net/wireless/mediatek/mt76/dma.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
>> index 6173c80189ba..ed0ee2d4a452 100644
>> --- a/drivers/net/wireless/mediatek/mt76/dma.c
>> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
>> @@ -528,7 +528,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
>>  	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
>>  	qid = napi - dev->napi;
>>  
>> -	rcu_read_lock();
>> +	rcu_read_lock_bh();
>>  
>>  	do {
>>  		cur = mt76_dma_rx_process(dev, &dev->q_rx[qid], budget - done);
>> @@ -536,7 +536,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
>>  		done += cur;
>>  	} while (cur && done < budget);
>>  
>> -	rcu_read_unlock();
>> +	rcu_read_unlock_bh();
>>  
>>  	if (done < budget && napi_complete(napi))
>>  		dev->drv->rx_poll_complete(dev, qid);
> 
> This patch is incomplete. The same problem exists for usb. I'll send a fix for that.
How so? On usb, it is called from a tasklet already.

- Felix
