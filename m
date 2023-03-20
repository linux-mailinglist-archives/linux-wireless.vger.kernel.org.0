Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7526C08E1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 03:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCTCOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Mar 2023 22:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTCOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Mar 2023 22:14:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68919F22
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 19:14:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k14-20020a056830150e00b0069f156d4ce9so1390439otp.6
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679278485;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtga78JsJrZzNCFia6XIK3/Lhck7mYJMoklYloiPgRY=;
        b=WY+/GXAR2RPU5KpIt04nzMzq8/JipAA2U6RDfDh7KU1aK22lJ23pSU0Jj2ciFjepYs
         WZ7s6cAnR3ekS9ShAgxdCzhNxz79mZzhp3tWemCEiiuHxnVp7khuKjnpXGqoeGz8s4nE
         toAijmw/c2aDr8SIlFUUcdYyyQJea6bzxV1LUlxxb2jTKl9FQ37IYDEYQMPAW5Pvjsd+
         YGLsK2jlhm5YwcqDQlzn8F94HfYMu7x9rWi5Ho+c1yA2AFXNR0agvRFcRCzLxKCqAXnv
         YmiJKsjnLgCe62eMHLPpz0in2NTEqh4vQPhigSDrxp/A9AsNWErmt6/WT/6aM7kuwqlj
         Q9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679278485;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtga78JsJrZzNCFia6XIK3/Lhck7mYJMoklYloiPgRY=;
        b=TrBaKIRgC/5C0DhwmRk/1J9AX9JctK9bUyZ405Io4+pE/PmUiFi22gNpvEu9h22Pdi
         G7hEIvMrOx5Oa8b4IOAJjUN2IVTCU3Gl2uG1EbaUvl6Gem6D+9gBgw+OlTrXylMzswYZ
         3fGCjs2c7+y7QsYsbTA1KHQZbinu7YxMwvTnYT+rvgOPL81Nw4kmxx5DeFvyBsQFlvQk
         fOfYoCgTxWcYjthJ+UajkLHR9uzub3hcTlGoXv1ulZvvjgDEYW49YDMVhGavWh91qeeB
         UtFcohFsozC3ik627fAM1nYF8TzWcQWbQGOUEQaXbQG2DII4vsXX/Ly9CDp/D2TK/13c
         9KXQ==
X-Gm-Message-State: AO0yUKXTIS7+XI8q7y4s28XLEsWoNVmLPvdEBOeewkRepcdkzCqKvGy+
        QvhNCExbQbBNyZpsxCqw8bRfr8fIOgo=
X-Google-Smtp-Source: AK7set8f6j03cTT1WSlSQwJ+arDOx6YjTxSnvW63pNiXnicdS+zZx+rFmqmSB9s5hL8/l9hsFRuwIA==
X-Received: by 2002:a05:6830:198:b0:69b:4f8a:7bcd with SMTP id q24-20020a056830019800b0069b4f8a7bcdmr3576920ota.35.1679278485454;
        Sun, 19 Mar 2023 19:14:45 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l2-20020a0568301d6200b0068d59d15a93sm2666993oti.40.2023.03.19.19.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 19:14:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9640df2b-1241-8ddd-8a59-a0578ff08ebf@lwfinger.net>
Date:   Sun, 19 Mar 2023 21:14:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtw88: kernel NULL pointer dereference
To:     Tim K <tpkuester@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
 <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net>
 <CA+shoWRY+wqj=5rFpM5obNB0t0=vKCJHzR0hAkf2Wz1D0ap0bw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+shoWRY+wqj=5rFpM5obNB0t0=vKCJHzR0hAkf2Wz1D0ap0bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/17/23 14:11, Tim K wrote:
> Larry,
> 
> Yes, it's an arm system. (ARMv7 rev5, if it's of use.) Here is the
> output from GDB:
> 
> Reading symbols from rtw88/rtw_core.ko...done.
>>>> l *rtw_rx_fill_rx_status+0x40
> 0x8cac is in rtw_rx_fill_rx_status (/home/tkuester/code/rtw88/rx.c:159).
> 154    {
> 155        struct ieee80211_hw *hw = rtwdev->hw;
> 156        u8 path;
> 157
> 158        memset(rx_status, 0, sizeof(*rx_status));
> 159        rx_status->freq = hw->conf.chandef.chan->center_freq;
> 160        rx_status->band = hw->conf.chandef.chan->band;
> 161        if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_SCAN_OFFLOAD) &&
> 162            test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
> 163            rtw_set_rx_freq_by_pktstat(pkt_stat, rx_status);
> 
> Please let me know if I can be of any more assistance!
> 
> - Tim
> 
> On Fri, Mar 17, 2023 at 2:32 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> On 3/17/23 13:12, Tim K wrote:
>>> Hello again all,
>>>
>>> I've been running a few rtw8822bu dongles in monitor mode doing a
>>> packet capture on an STM32, running Linux 5.15. It's been fairly
>>> stable over a few days, but I checked back in on it and found this in
>>> the log.
>>>
>>> Any thoughts on what could have caused this? This is from lwfinger's
>>> GitHub repo at 4bede29 (I believe.)
>>>
>>> [406207.728602] 8<--- cut here ---
>>> [406207.730533] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000004
>>> [406207.740137] pgd = 40e434d7
>>> [406207.741665] [00000004] *pgd=00000000
>>> [406207.745300] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>> [406207.801313] CPU: 0 PID: 23145 Comm: kworker/u4:2 Tainted: G
>>>      O      5.15.24 #13
>>> [406207.809516] Hardware name: STM32 (Device Tree Support)
>>> [406207.814783] Workqueue: rtw88_usb: rx wq rtw_usb_rx_handler [rtw88_usb]
>>> [406207.821397] PC is at rtw_rx_fill_rx_status+0x40/0x278 [rtw_core]
>>> [406207.827604] LR is at rtw_rx_fill_rx_status+0x3c/0x278 [rtw_core]
>>> [406207.833666] pc : [<bf324cac>]    lr : [<bf324ca8>]    psr: 400f0113
>>> [406207.840043] sp : c5379e20  ip : c5379eb8  fp : 00000001
>>> ...
>>> [406208.084918] [<bf324cac>] (rtw_rx_fill_rx_status [rtw_core]) from
>>> [<bf3c6b44>] (rtw8822b_query_rx_desc+0x10c/0x19c [rtw_8822b])
>>> [406208.096524] [<bf3c6b44>] (rtw8822b_query_rx_desc [rtw_8822b]) from
>>> [<bf416920>] (rtw_usb_rx_handler+0x6c/0x16c [rtw88_usb])
>>> [406208.107820] [<bf416920>] (rtw_usb_rx_handler [rtw88_usb]) from
>>> [<c01455cc>] (process_one_work+0x1dc/0x588)
>>> [406208.117570] [<c01455cc>] (process_one_work) from [<c0145e04>]
>>> (worker_thread+0x5c/0x568)
>>> [406208.125790] [<c0145e04>] (worker_thread) from [<c014c230>]
>>> (kthread+0x144/0x160)
>>> [406208.133310] [<c014c230>] (kthread) from [<c0100130>]
>>> (ret_from_fork+0x14/0x24)
>>> ...
>>> [406208.186520] ---[ end trace 140c234232a74c11 ]---
>>
>> Tim,

Tim,

I happen to have an RTW8822BU device that I have been beating up all weekend 
without triggering your kernel BUG. I did find one in my back journalctl logs, 
but no new ones. The test was ping-ponging 6.22GB files from/to my nfs server 
using rsync without compression. The download speeds were between 24 and 31 
MB/s, and upload speeds were about 50 MB/s. My AP is ax1500 with a 1Gb/s 
connection between the AP and the server.

Your traceback shows the NULL pointer is in routine rtw_rx_fill_rx_status(), 
which is only a couple of routines removed from rtw_usb_rx_handler(). The error 
is in the statement
rx_status->freq = hw->conf.chandef.chan->center_freq;

As rx_status is local to the routine, the error has to be in the right-hand side 
of the statement. As hw->conf.....->center_freq is apparently OK most of the 
time, I think you are getting a spurious RX interrupt. I have pushed a patch 
that will show if hw is NULL, and quit the routine. Do a 'git pull', make... and 
let me know what you see in the log.

Larry
