Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EED6BF0BF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCQScX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQScW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 14:32:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770694AFC2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:32:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id be16so4506589oib.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679077940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=18Da+1R+cKp5O8LOWdTXS+hOZpZrMV0Qpk8B5ge8NjY=;
        b=JdOreYXd11d32Pji5JWn1v3QXM547LwmW6WAaqutGl4t2thBtZaF6OlTgzH8/ztWC9
         63z8xJ6bU2GNbCGclz8xDL8ajaGjvkzda6HrULYRZwcd0Rfc3QRursOpFU3cqz6O6GdM
         P9QoQhLKW3wvH3DpLa8/KYYVhYuelj46vb9QcPB0gN4SFhwK7cCZbdu1ALK3rMpErw6U
         OK/j4F9D8jfVJzlkVP9rN/33YZYOfF4glhvKIYLsC44JFTmOXY2M+R/0cTyDB9WIUUko
         jhUtrAX9Tqsj4YPyZaq6A4H01PvY+idl6w8HSLsymxlP1myjZo5TPGSJ1fNkRbDL++6u
         r2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18Da+1R+cKp5O8LOWdTXS+hOZpZrMV0Qpk8B5ge8NjY=;
        b=gCIlfAUrwa6xzJHaWpIgyWmdxgolKog6L/Z3PunCo8uaR/lQPum8anV7p1Cd7s7VgE
         PDQd8CFRx4D2p5gsNO5BthN0YfmLPR3zDN5ksXhJoal9wrrWJacTVWRPb8+4BlTEAEok
         eJGGr4wU+yei+jV6Rwh/KYwzzXwITtBEWI6eoOH9DAfOpI9XGYdwgZp+bnOqftxmvV/L
         O8bOPhStsoHcYOyU5/h79SzEB75/yHZUUyChTrvzrn6YgvsFXGnwtmha0O0XPVXXG6ej
         U321lS/yv219xHdfy/vqVh+A65iKUWMopqzZdUmcGdJ30h4m0ZytTl44P5F4LIRLuz4Y
         1DYQ==
X-Gm-Message-State: AO0yUKWEXhIIO+2leo6UZuXICvbq8JLc4lUNSv4Po/K9mGLJ/vYH59tw
        fWc0sUSbgMYtytWrGYgXKGg=
X-Google-Smtp-Source: AK7set9tMtjygMbrvXFnTaK9EypbQPCAR5t0VEJcS71Oz7Yw4gl/6BWsfIr2KnfF4IfibRu6b8crPQ==
X-Received: by 2002:aca:1115:0:b0:386:da5f:3fab with SMTP id 21-20020aca1115000000b00386da5f3fabmr984873oir.51.1679077939780;
        Fri, 17 Mar 2023 11:32:19 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o9-20020acad709000000b00383eaf88e75sm1132134oig.39.2023.03.17.11.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:32:19 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net>
Date:   Fri, 17 Mar 2023 13:32:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: rtw88: kernel NULL pointer dereference
Content-Language: en-US
To:     Tim K <tpkuester@gmail.com>, linux-wireless@vger.kernel.org
References: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/17/23 13:12, Tim K wrote:
> Hello again all,
> 
> I've been running a few rtw8822bu dongles in monitor mode doing a
> packet capture on an STM32, running Linux 5.15. It's been fairly
> stable over a few days, but I checked back in on it and found this in
> the log.
> 
> Any thoughts on what could have caused this? This is from lwfinger's
> GitHub repo at 4bede29 (I believe.)
> 
> [406207.728602] 8<--- cut here ---
> [406207.730533] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> [406207.740137] pgd = 40e434d7
> [406207.741665] [00000004] *pgd=00000000
> [406207.745300] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [406207.801313] CPU: 0 PID: 23145 Comm: kworker/u4:2 Tainted: G
>     O      5.15.24 #13
> [406207.809516] Hardware name: STM32 (Device Tree Support)
> [406207.814783] Workqueue: rtw88_usb: rx wq rtw_usb_rx_handler [rtw88_usb]
> [406207.821397] PC is at rtw_rx_fill_rx_status+0x40/0x278 [rtw_core]
> [406207.827604] LR is at rtw_rx_fill_rx_status+0x3c/0x278 [rtw_core]
> [406207.833666] pc : [<bf324cac>]    lr : [<bf324ca8>]    psr: 400f0113
> [406207.840043] sp : c5379e20  ip : c5379eb8  fp : 00000001
> ...
> [406208.084918] [<bf324cac>] (rtw_rx_fill_rx_status [rtw_core]) from
> [<bf3c6b44>] (rtw8822b_query_rx_desc+0x10c/0x19c [rtw_8822b])
> [406208.096524] [<bf3c6b44>] (rtw8822b_query_rx_desc [rtw_8822b]) from
> [<bf416920>] (rtw_usb_rx_handler+0x6c/0x16c [rtw88_usb])
> [406208.107820] [<bf416920>] (rtw_usb_rx_handler [rtw88_usb]) from
> [<c01455cc>] (process_one_work+0x1dc/0x588)
> [406208.117570] [<c01455cc>] (process_one_work) from [<c0145e04>]
> (worker_thread+0x5c/0x568)
> [406208.125790] [<c0145e04>] (worker_thread) from [<c014c230>]
> (kthread+0x144/0x160)
> [406208.133310] [<c014c230>] (kthread) from [<c0100130>]
> (ret_from_fork+0x14/0x24)
> ...
> [406208.186520] ---[ end trace 140c234232a74c11 ]---

Tim,

I can tell from your dump that you are not running x86_64 hardware. Is it ARM?

In any case, please run the command 'gdb rtw_core.ko' while in the rtw88 
directory, and once gdb gets started, enter the command
l *rtw_rx_fill_rx_status+0x40

Report the output. That will show the line of code that is failing. We should be 
able to figure it out from there.

Larry


