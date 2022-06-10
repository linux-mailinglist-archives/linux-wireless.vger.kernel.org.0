Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A8546FBF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 00:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiFJWwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiFJWv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 18:51:59 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5613D6E
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 15:51:57 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25AMpjra090332;
        Sat, 11 Jun 2022 07:51:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sat, 11 Jun 2022 07:51:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25AMpjqo090329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 Jun 2022 07:51:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <886f1a69-5688-196c-90f1-e1324e941e77@I-love.SAKURA.ne.jp>
Date:   Sat, 11 Jun 2022 07:51:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ath6kl: avoid flush_scheduled_work() usage
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
 <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
 <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022/06/11 4:10, Jeff Johnson wrote:
> On 6/10/2022 12:05 PM, Jeff Johnson wrote:
>>> +static int __init ath6kl_init(void)
>>> +{
>>> +    int ret;
>>> +
>>> +    ath6kl_wq = alloc_workqueue("ath6kl_wq", 0, 0);
>>> +    if (!ath6kl_wq)
>>> +        return -ENOMEM;
>>
>> this approach means the driver will always allocate a workqueue even if the associated hardware is never present.

Creating a WQ without WQ_MEM_RECLAIM flag consumes little resource.

>>
>> did you consider instead having the allocation take place within the processing of ath6kl_usb_probe() and the destroy take place within the processing of ath6kl_usb_pm_remove()?
> 
> typo: ath6kl_usb_pm_remove() => ath6kl_usb_remove()

Technically possible to use ath6kl_usb_create()/ath6kl_usb_destroy() if you prefer it.

Do you want ath6kl_wq be shared within this module (using a refcount), or be local to
each "struct ath6kl_usb" (adding a member and accessing via usb_get_intfdata()) ?

