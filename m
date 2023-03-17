Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6566BF17B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 20:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCQTMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCQTMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 15:12:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0ABD7C20
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 12:12:09 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z83so6862266ybb.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF/EjTXtMNo2Wk+yqfJUJ4xReRnaBXRT4eUaUUoynM=;
        b=RAp8aUqwoFtxK8XqPyvRAC4WIZqFv9HwRqDpfrML+WMb1w72lp35LloaKrLwEmhQw3
         L6eoc3B4Kkpq1KqsyIwvV80gr1YSXNdnJ9bgxiogc9ZYMuyVubF+FsTYR7rS4BNT/PMc
         pRwPx+qIpeG0ICzpm3kwhNbxcWvbK192w7g9HDPN+d+2HZ/zzENjL2Bpt+oU8a233yrp
         kPi/lqUbV+NozurwCh77z7wT540EmCglQNflvz/nfNVPenTJnx0HrJ7pFnNjo4d13g7E
         24/3+Hu5QYwVwnZ6b0HNlYLYY3x0kI1XbTqobtkPYh3Dac/xMniqkyMYkDEpjC3TZxVu
         T5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYF/EjTXtMNo2Wk+yqfJUJ4xReRnaBXRT4eUaUUoynM=;
        b=fXDBReAJz+7dtlSxGVfSah4Cwbf/+Yex6rpruWW3WCFUb9izqFKvLAgy+cheTdqwRt
         00VozNbvSBtqW6lOTbwNat86L89H5gP7d6DBeElo3eDrqgZBENQIuaN4w+9yQdBzb/yb
         RNYDPfWWV7qHFHCCpKpBVy9b5yeiulHiW/iw30aV25A6TF85Vm7hrNEHwkKjer4A0p3E
         neIQk5Jvj4KnJ51bsubfkm0QXLaI0c+57Lt7Xe3M59DOCqPcnrMKx4u1AlBELD3SaF9G
         evz0Dez415zvJXz9H2jHCtV0RSFWpzH6zYkGYwz/p4TfVWCPteSHIoJqDnMh54+CW+qV
         ViNw==
X-Gm-Message-State: AO0yUKXpNIqkUCTSGHhRb2rF0o3UKn39ZIvASQyi2NgJld15EqtKIf9q
        4FBVe3dsIHJGFG1ba1MYrSZCORUHBbz27/h3oq1ljXSkIw==
X-Google-Smtp-Source: AK7set8DYpqyNPE8HfrqyRgrDJXvyG7OlqCZWzhKONMntIb3rG0EoCwsmmvFALITET9FmBG8rpY4VLWB8mQiPfk6uo0=
X-Received: by 2002:a05:6902:704:b0:ac2:ffe:9cc9 with SMTP id
 k4-20020a056902070400b00ac20ffe9cc9mr500637ybt.3.1679080328347; Fri, 17 Mar
 2023 12:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
 <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net>
In-Reply-To: <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net>
From:   Tim K <tpkuester@gmail.com>
Date:   Fri, 17 Mar 2023 15:11:55 -0400
Message-ID: <CA+shoWRY+wqj=5rFpM5obNB0t0=vKCJHzR0hAkf2Wz1D0ap0bw@mail.gmail.com>
Subject: Re: rtw88: kernel NULL pointer dereference
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry,

Yes, it's an arm system. (ARMv7 rev5, if it's of use.) Here is the
output from GDB:

Reading symbols from rtw88/rtw_core.ko...done.
>>> l *rtw_rx_fill_rx_status+0x40
0x8cac is in rtw_rx_fill_rx_status (/home/tkuester/code/rtw88/rx.c:159).
154    {
155        struct ieee80211_hw *hw =3D rtwdev->hw;
156        u8 path;
157
158        memset(rx_status, 0, sizeof(*rx_status));
159        rx_status->freq =3D hw->conf.chandef.chan->center_freq;
160        rx_status->band =3D hw->conf.chandef.chan->band;
161        if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_SCAN_OFFLOAD) &=
&
162            test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
163            rtw_set_rx_freq_by_pktstat(pkt_stat, rx_status);

Please let me know if I can be of any more assistance!

- Tim

On Fri, Mar 17, 2023 at 2:32=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> On 3/17/23 13:12, Tim K wrote:
> > Hello again all,
> >
> > I've been running a few rtw8822bu dongles in monitor mode doing a
> > packet capture on an STM32, running Linux 5.15. It's been fairly
> > stable over a few days, but I checked back in on it and found this in
> > the log.
> >
> > Any thoughts on what could have caused this? This is from lwfinger's
> > GitHub repo at 4bede29 (I believe.)
> >
> > [406207.728602] 8<--- cut here ---
> > [406207.730533] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000004
> > [406207.740137] pgd =3D 40e434d7
> > [406207.741665] [00000004] *pgd=3D00000000
> > [406207.745300] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> > [406207.801313] CPU: 0 PID: 23145 Comm: kworker/u4:2 Tainted: G
> >     O      5.15.24 #13
> > [406207.809516] Hardware name: STM32 (Device Tree Support)
> > [406207.814783] Workqueue: rtw88_usb: rx wq rtw_usb_rx_handler [rtw88_u=
sb]
> > [406207.821397] PC is at rtw_rx_fill_rx_status+0x40/0x278 [rtw_core]
> > [406207.827604] LR is at rtw_rx_fill_rx_status+0x3c/0x278 [rtw_core]
> > [406207.833666] pc : [<bf324cac>]    lr : [<bf324ca8>]    psr: 400f0113
> > [406207.840043] sp : c5379e20  ip : c5379eb8  fp : 00000001
> > ...
> > [406208.084918] [<bf324cac>] (rtw_rx_fill_rx_status [rtw_core]) from
> > [<bf3c6b44>] (rtw8822b_query_rx_desc+0x10c/0x19c [rtw_8822b])
> > [406208.096524] [<bf3c6b44>] (rtw8822b_query_rx_desc [rtw_8822b]) from
> > [<bf416920>] (rtw_usb_rx_handler+0x6c/0x16c [rtw88_usb])
> > [406208.107820] [<bf416920>] (rtw_usb_rx_handler [rtw88_usb]) from
> > [<c01455cc>] (process_one_work+0x1dc/0x588)
> > [406208.117570] [<c01455cc>] (process_one_work) from [<c0145e04>]
> > (worker_thread+0x5c/0x568)
> > [406208.125790] [<c0145e04>] (worker_thread) from [<c014c230>]
> > (kthread+0x144/0x160)
> > [406208.133310] [<c014c230>] (kthread) from [<c0100130>]
> > (ret_from_fork+0x14/0x24)
> > ...
> > [406208.186520] ---[ end trace 140c234232a74c11 ]---
>
> Tim,
>
> I can tell from your dump that you are not running x86_64 hardware. Is it=
 ARM?
>
> In any case, please run the command 'gdb rtw_core.ko' while in the rtw88
> directory, and once gdb gets started, enter the command
> l *rtw_rx_fill_rx_status+0x40
>
> Report the output. That will show the line of code that is failing. We sh=
ould be
> able to figure it out from there.
>
> Larry
>
>
