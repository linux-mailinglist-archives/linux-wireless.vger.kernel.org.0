Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722D31B02C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfEMGU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 02:20:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMGU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 02:20:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5371F60850; Mon, 13 May 2019 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557728427;
        bh=T+hUVENOurRHcRRbtlZ0pXY3c7M47y8tTE+83qFhXNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+fQs+4wIdfk53bgfk4xsibUO7FFz1LQrDrXvKVyiEoB61iiNNnjp7YAZiaHoDYOZ
         ndU9BSx2sUL7E0S21amX4VCh5M9ucZVKS01pYuBom01jArXAuoSNghAbpMFVl+ZIzJ
         avMUKqkJAo+jdJ12LM+BAKx1Has8W5xL9yOhFbWs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8F82D60735;
        Mon, 13 May 2019 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557728426;
        bh=T+hUVENOurRHcRRbtlZ0pXY3c7M47y8tTE+83qFhXNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZrI/Ju0Xt1Ki/tjgzAweE/21187vYG3dBk1Aj9GNEpS6wxRBpftgaABnjQ4dhUOzz
         sY3kUXeZiP3lLbrNDqKxGb8B+s8/scfUV4qBUeny071mQZK013yoPdVjbze9hO1uRz
         FITCMoOJGWvgfV51z27IhAPoKxaAHPWW5wznIDec=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 14:20:26 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Subject: Re: [PATCH] mac80211: remove warning message
In-Reply-To: <7119f24f-5b88-629a-d507-73776b841f65@candelatech.com>
References: <1557471662-1355-1-git-send-email-yiboz@codeaurora.org>
 <7119f24f-5b88-629a-d507-73776b841f65@candelatech.com>
Message-ID: <0247de90c551b76aed1f9647f9b274c0@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-10 22:04, Ben Greear wrote:
> On 05/10/2019 12:01 AM, Yibo Zhao wrote:
>> In multiple SSID cases, it takes time to prepare every AP interface
>> to be ready in initializing phase. If a sta already knows everything 
>> it
>> needs to join one of the APs and sends authentication to the AP which
>> is not fully prepared at this point of time, AP's channel context
>> could be NULL. As a result, warning message occurs.
>> 
>> Even worse, if the AP is under attack via tools such as MDK3 and 
>> massive
>> authentication requests are received in a very short time, console 
>> will
>> be hung due to kernel warning messages.
> 
> Since it is a WARN_ON_ONCE, how it the console hang due to warnings?  
> You should
> get no more than once per boot?
> 
Hi Ben,

I was planning to use WARN_ON_ONCE() in the first place to replace 
WARN_ON() then after some discussion, we think removing it could be 
better. So the patch was based on my first version. Sorry for the 
confusing. Will raise another one.

> I have no problem with removing it though.  Seems a harmless splat and 
> I removed
> it from my tree some time back as well.
> 
> Thanks,
> Ben
> 
>> 
>> If this case can be hit during normal functionality, there should be 
>> no
>> WARN_ON(). Those should be reserved to cases that are not supposed to 
>> be
>> hit at all or some other more specific cases like indicating obsolete
>> interface.
>> 
>> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>> ---
>>  net/mac80211/ieee80211_i.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
>> index 2ae0364..f39c289 100644
>> --- a/net/mac80211/ieee80211_i.h
>> +++ b/net/mac80211/ieee80211_i.h
>> @@ -1435,7 +1435,7 @@ struct ieee80211_local {
>>  	rcu_read_lock();
>>  	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
>> 
>> -	if (WARN_ON_ONCE(!chanctx_conf)) {
>> +	if (!chanctx_conf) {
>>  		rcu_read_unlock();
>>  		return NULL;
>>  	}
>> 

-- 
Yibo
