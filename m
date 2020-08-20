Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617A024B73A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgHTKPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 06:15:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35818 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbgHTKPH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597918506; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WY135IggpTO2oe8SZoM2B12vLSGVblgHYCxVCvQH7Lc=;
 b=DITse04TNsmv+7+tzsg7IcI15vF8wShn/TcEwrEKT+LX8j/1/2kdiYOu6hIJTJ5l3mdgefUz
 Q7N2ThqY9T9Q694xf01T8Arewg/d9T9aRsfS3FKzKYF2znwhP9xZjGIJ0u6LAHHfvQ1Whqhs
 1IRyu/6kepjW9yGA4AoRqIO/TyI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f3e4d0ef37da9fb0eed92d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 10:14:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36FBBC433A0; Thu, 20 Aug 2020 10:14:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FB16C43387;
        Thu, 20 Aug 2020 10:14:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 18:14:37 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
In-Reply-To: <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
Message-ID: <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-20 17:19, Krishna Chaitanya wrote:
...
>> > diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
>> > index 7b894dcaad2e..b71499b171c6 100644
>> > --- a/drivers/net/wireless/ath/ath10k/sdio.c
>> > +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>> > @@ -1756,8 +1756,6 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
>> >       struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>> >       int ret;
>> >
>> > -     napi_enable(&ar->napi);
>> > -
>> >       /* Sleep 20 ms before HIF interrupts are disabled.
>> >        * This will give target plenty of time to process the BMI done
>> >        * request before interrupts are disabled.
>> > @@ -1884,7 +1882,6 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
>> >       spin_unlock_bh(&ar_sdio->wr_async_lock);
>> >
>> >       napi_synchronize(&ar->napi);
>> > -     napi_disable(&ar->napi);
>> >  }
>> >
>> >  #ifdef CONFIG_PM
>> > @@ -2121,6 +2118,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
>> >
>> >       netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
>> >                      ATH10K_NAPI_BUDGET);
>> > +     napi_enable(&ar->napi);
>> >
>> >       ath10k_dbg(ar, ATH10K_DBG_BOOT,
>> >                  "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
>> > @@ -2235,6 +2233,7 @@ static void ath10k_sdio_remove(struct sdio_func *func)
>> >
>> >       ath10k_core_unregister(ar);
>> >
>> > +     napi_disable(&ar->napi);
>> >       netif_napi_del(&ar->napi);
>> >
>> >       ath10k_core_destroy(ar);
>> 
>> I'm not really convinced that this is the right fix, but I'm no NAPI
>> expert. Can anyone else help?
> Calling napi_disable() twice can lead to hangs, but moving NAPI from
> start/stop to
> the probe isn't the right approach as the datapath is tied to 
> start/stop.
> 
> Maybe check the state of NAPI before disable?
> 
>  if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
>   napi_disable(&ar->napi)
> or maintain napi_state like this 
> https://patchwork.kernel.org/patch/10249365/
it is better to use above link's patch.
napi.state is controlled by napi API, it is better ath10k not know it.
> 
> Also, the most common cause for such issues (1st
> napi_synchronize/napi_disable hang)
> is that napi_poll is being scheduled, so, you might want to check that
> napi_schedule isn't
> called after stop.
> 
> cd ath10k; git log --grep=napi shows plenty of such issues. the one
> that matches closest is
> c2cac2f74ab4bcf0db0dcf3a612f1e5b52d145c8, so, it could just be a 
> regression.
This above commit's scene is not same with this patch.
It is hang for only do 1 simulate crash of the commit, this patch is 
doing simulate crash and rmmod meanwhile.
