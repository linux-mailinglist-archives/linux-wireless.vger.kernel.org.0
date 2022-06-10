Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C7546D04
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiFJTKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350472AbiFJTKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 15:10:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AEBAE
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654888210; x=1686424210;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mm6gMpX7ZaYHXH/tOhhcfO8veWZe8aeTZ+xmBQDIB9Q=;
  b=X/qNktCi6zg0wF5yp0ARAsol8aT56AfQC1/FsHiGkzW19Mco830GQnJg
   32p42+A+yPbobbLxXuB5PpgH3jhYFo0w4itWRfBtuaiLhS2/nqRuRI8pV
   XNXlHQXXCmqIWCyv6joioMPC+2bXYhbiecL8L63lpZ7DxTmr2sfB2mIB6
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jun 2022 12:10:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 12:10:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 12:10:09 -0700
Received: from [10.110.62.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 10 Jun
 2022 12:10:08 -0700
Message-ID: <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
Date:   Fri, 10 Jun 2022 12:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ath6kl: avoid flush_scheduled_work() usage
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kalle Valo <kvalo@kernel.org>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
References: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
 <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
In-Reply-To: <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/10/2022 12:05 PM, Jeff Johnson wrote:
> On 6/10/2022 4:12 AM, Tetsuo Handa wrote:
>> Use local wq in order to avoid flush_scheduled_work() usage.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
>> using a macro") for background.
>>
>> This is a blind conversion, and is only compile tested.
>>
>>   drivers/net/wireless/ath/ath6kl/usb.c | 29 +++++++++++++++++++++++----
>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c 
>> b/drivers/net/wireless/ath/ath6kl/usb.c
> [snip]
>> -module_usb_driver(ath6kl_usb_driver);
>> +static int __init ath6kl_init(void)
>> +{
>> +    int ret;
>> +
>> +    ath6kl_wq = alloc_workqueue("ath6kl_wq", 0, 0);
>> +    if (!ath6kl_wq)
>> +        return -ENOMEM;
> 
> this approach means the driver will always allocate a workqueue even if 
> the associated hardware is never present.
> 
> did you consider instead having the allocation take place within the 
> processing of ath6kl_usb_probe() and the destroy take place within the 
> processing of ath6kl_usb_pm_remove()?

typo: ath6kl_usb_pm_remove() => ath6kl_usb_remove()
