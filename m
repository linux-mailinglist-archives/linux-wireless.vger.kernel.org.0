Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567A548135
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiFMIBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiFMIB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 04:01:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1708BC15
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 01:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1904B80D7A
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 08:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017ADC34114;
        Mon, 13 Jun 2022 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655107279;
        bh=es9ZZy12mClbCoALSVCDFwBwI64ADO1gl/HposH8BQo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tcBCzfS+nOahH58WG2VzuoDEOvSbYA7s3sxlSpIV+EHFmdlboo98tWuWEiWOCzs3m
         /LIBC+RqWMsnL1tMCwMzrDrvq4fzwlPfnCONtpfBiXfoJOu2YK9KF8z1UsvTqfOJo+
         vMdx9XUTfBa6LtHW9UN4D61wZvA5z6psIzMJTpC+fj/3iPqlOCiFGB6V/BqTzuSPaQ
         y5QCusqnJnCDciNp7GIzpGYi3d/K8D1lzku7vGXHTYI2cGEL13269q2zwGt+pErdPQ
         OBjaidX2mMiRCdUxEpDYjS1cc5SOY7VpxPbNoSoqn80JmPWUZJhNiiv6DFdBde+dGh
         iU4aWSjIRlSsg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath6kl: avoid flush_scheduled_work() usage
References: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
        <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
        <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
        <886f1a69-5688-196c-90f1-e1324e941e77@I-love.SAKURA.ne.jp>
        <7191382d-8794-ccb6-791b-01693cbd0921@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Jun 2022 11:01:14 +0300
In-Reply-To: <7191382d-8794-ccb6-791b-01693cbd0921@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Sun, 12 Jun 2022 11:08:00 +0900")
Message-ID: <87pmjdouut.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2022/06/11 7:51, Tetsuo Handa wrote:
>> On 2022/06/11 4:10, Jeff Johnson wrote:
>>> On 6/10/2022 12:05 PM, Jeff Johnson wrote:
>>>>> +static int __init ath6kl_init(void)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ath6kl_wq = alloc_workqueue("ath6kl_wq", 0, 0);
>>>>> +    if (!ath6kl_wq)
>>>>> +        return -ENOMEM;
>>>>
>>>> this approach means the driver will always allocate a workqueue even if the associated hardware is never present.
>> 
>> Creating a WQ without WQ_MEM_RECLAIM flag consumes little resource.
>
> My understanding is that a loadable kernel module file is modprobe'd when
> the kernel detected a hardware and some userspace program determined a .ko
> file to use based on device IDs database). Thus, I think it is very likely
> that an associated hardware presents if module's __init function is called.
>
> If a module is built-in, that user is ready to tolerate memory footprint
> wasted by non-present hardware. And I think memory wasted by keeping an
> unused !WQ_MEM_RECLAIM workqueue is much smaller than memory wasted by
> keeping that module.
>
> Thus, I wonder who complains about creating possibly unused !WQ_MEM_RECLAIM
> workqueue, unless that module is designed for tiny embedded
> environments.

I complain, it's still wrong. We have patches which save few bytes
everywhere we can, we shouldn't deliberately increase the kernel size.

>>From 00c560307d72abffea29409328be8cd69abecc95 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 12 Jun 2022 10:38:03 +0900
> Subject: [PATCH v2] ath6kl: avoid flush_scheduled_work() usage
>
> Use local wq in order to avoid flush_scheduled_work() usage.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v2:
>   Use per "struct ath6kl_usb" workqueue instead of per module workqueue.

Please don't embed patches into email, patchwork doesn't see those:

https://patchwork.kernel.org/project/linux-wireless/list/

Please submit v3.

> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> using a macro") for background.
>
> This is a blind conversion, and is only compile tested.

This is good information to have, please include that to the commit log
so that it's stored to git.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
