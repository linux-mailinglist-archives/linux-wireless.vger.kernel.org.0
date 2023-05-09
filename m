Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89806FD202
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjEIWC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIWCz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 18:02:55 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CC420A
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 15:02:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39400a8354cso1147664b6e.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 May 2023 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683669773; x=1686261773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvwee7peAg7du9VmELj0h46m+7pi1TpzKiCZRgWVz/8=;
        b=miJV2zFHAj2C7gZCqWRqCuX+z0IAEoZtT8GHuQwQgsb8+whU/CMlBvpeSfaVzxS009
         YcT8gUx41WbDPDntoFygM5r7S7wqlN5qZORSHD+DMqkwjc4aGXkBQpSNC3IyUoxXc22Y
         bc0NZo0NrYoFIiIUvajSoHTdxfLl5iq2XVmyaAMxpzFhD+i4/6xQFM9moVzxIMMU6S8i
         jhUJGgLVgAv9XC2B665MicV7oLG7NuPr1H+vO0OZvWCtcsYZ6RvehgC+RPnL6FeeXLyi
         MpF11JDFwq8kr62AlOJJJT8aYizYyD/bXy2GEErhAtRugVnV0MqnqN8dnF9k3VWveMPH
         6egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683669773; x=1686261773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lvwee7peAg7du9VmELj0h46m+7pi1TpzKiCZRgWVz/8=;
        b=WahIhRvT0xzrold0KL8Of+7Ct2jPNeB/XwOnOg6zAuwsZ/uSuGbSJjTL4Zh9iv0Mat
         u74xsBCEF0pjQzoBOhCVQVvoQXshMiDbaTqZ619TF5KtrWHC/gX5Deh4r3oyj3hu+q5G
         LBTKdHvNSXou/M3yLmXvpd3TRrZUAG0wf9LVGMhHabNKD6axG8YNmDLlucTm0MTi6Azq
         UI04aFAbqkU2pCgOiH8XtCbbpgSeRbrrFKolNXC/lULZU6V4Kdkf0q0GtVAP1KCLk/x0
         Kc0stQ+kjiLxjxVlm2cGLn7lw/qsq4G7Thi7dud2Tf1iqxxx245aat6eAp77QcD/J4ys
         aIJQ==
X-Gm-Message-State: AC+VfDxEZNu+nAW0Z/lBMWblnEwtdGrzMRdAljq6YAxrsyM0kFSNHBg/
        5z1GKvIm/7/8REGEeywMQ7A=
X-Google-Smtp-Source: ACHHUZ6MXtq28fyLrF8YOKTdpKaHn1wnHcdsPW8LDS6Ha+NeZkIPxBAUIYX0AyhP0KvYFu9df2+vuw==
X-Received: by 2002:a05:6808:4287:b0:38e:8e21:d042 with SMTP id dq7-20020a056808428700b0038e8e21d042mr1946036oib.58.1683669772728;
        Tue, 09 May 2023 15:02:52 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bm13-20020a0568081a8d00b0038bffe1332dsm1550891oib.57.2023.05.09.15.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 15:02:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <77bdcc7b-c3b2-7c3b-5146-9b7f8c3ae5a7@lwfinger.net>
Date:   Tue, 9 May 2023 17:02:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Driver for rtw8723ds
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop>
 <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
 <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net>
 <CAFBinCCdbt0OAHMnGPYA+xH8WC1nWqJPP5aBU48R=LHRu_xuew@mail.gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCCdbt0OAHMnGPYA+xH8WC1nWqJPP5aBU48R=LHRu_xuew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/8/23 15:16, Martin Blumenstingl wrote:
> This looks like an issue with the Allwinner SDIO controller. We can
> try to work around this with the attached patch.
> Please note that I've only compile-tested that patch.
> In theory it can hurt 16-bit register access (read/write) performance
> a bit (since we now require two MMC commands instead of one). Whether
> this can be measured in the real world is unknown to me. Let's see if
> it fixes the observed issue first.
> 

Martin,

I added that patch to the driver. The user reports that he was able to do a ping 
and an nslookup before it crashed with the following in the log:

[    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341 
head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NULL>
[    8.714254] ------------[ cut here ]------------
[    8.718867] kernel BUG at net/core/skbuff.c:200!
[    8.723481] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[    8.730261] Modules linked in: rtw_8723ds rtw_8723d rtw_sdio rtw_core 
mac80211 libarc4 cfg80211 rfkill ipv6
[    8.740024] CPU: 1 PID: 222 Comm: ksdioirqd/mmc1 Not tainted 6.4.0-rc1-dirty #1
[    8.747327] Hardware name: MangoPi MQ Quad (DT)
[    8.751852] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.758808] pc : skb_panic+0x58/0x5c
[    8.762391] lr : skb_panic+0x58/0x5c
[    8.765964] sp : ffff80000aa3bc20
[    8.769274] x29: ffff80000aa3bc30 x28: ffff000003e16dd8 x27: 0000000000000055
[    8.776409] x26: 000000000000e001 x25: ffff000003e94200 x24: ffff80000119f408
[    8.783543] x23: 0000000000000018 x22: ffff000003e12060 x21: ffff80000aa3bd28
[    8.790677] x20: 000000000000003a x19: ffff000003e94200 x18: 0000000000000000
[    8.797811] x17: 010006000cc00100 x16: ffff80000a22ffc0 x15: 0000000000000030
[    8.804945] x14: ffff80000a241b20 x13: 0000000000000339 x12: 0000000000000113
[    8.812079] x11: 7265766f5f626b73 x10: ffff80000a299b20 x9 : 00000000fffff000
[    8.819212] x8 : ffff80000a241b20 x7 : ffff80000a299b20 x6 : 0000000000000000
[    8.826346] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    8.833479] x2 : 0000000000000000 x1 : ffff000003d6d880 x0 : 000000000000008b
[    8.840614] Call trace:
[    8.843057]  skb_panic+0x58/0x5c
[    8.846286]  skb_find_text+0x0/0xc4
[    8.849773]  rtw_sdio_rx_skb+0x50/0xc8 [rtw_sdio]
[    8.854488]  rtw_sdio_rxfifo_recv+0x1a0/0x24c [rtw_sdio]
[    8.859803]  rtw_sdio_handle_interrupt+0xf0/0x124 [rtw_sdio]
[    8.865465]  process_sdio_pending_irqs+0x5c/0x1c4
[    8.870169]  sdio_irq_thread+0x84/0x178
[    8.874003]  kthread+0x118/0x11c
[    8.877231]  ret_from_fork+0x10/0x20
[    8.880814] Code: f90007e9 b940b108 f90003e8 97cb9ac2 (d4210000)
[    8.886903] ---[ end trace 0000000000000000 ]---
[    8.891515] note: ksdioirqd/mmc1[222] exited with irqs disabled
[    8.897478] note: ksdioirqd/mmc1[222] exited with preempt_count 1
[    8.903732] ------------[ cut here ]------------
[    8.908348] WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:128 
ct_kernel_exit.constprop.0+0x98/0xa0
[    8.917828] Modules linked in: rtw_8723ds rtw_8723d rtw_sdio rtw_core 
mac80211 libarc4 cfg80211 rfkill ipv6
[    8.927590] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D 
6.4.0-rc1-dirty #1
[    8.935758] Hardware name: MangoPi MQ Quad (DT)
[    8.940282] pstate: 200003c5 (nzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.947237] pc : ct_kernel_exit.constprop.0+0x98/0xa0
[    8.952285] lr : ct_idle_enter+0x10/0x1c
[    8.956206] sp : ffff80000a76bdd0
[    8.959516] x29: ffff80000a76bdd0 x28: 0000000000000000 x27: 0000000000000000
[    8.966650] x26: 0000000000000000 x25: ffff000002d68000 x24: 0000000000000000
[    8.973784] x23: 0000000000000000 x22: ffff80000a229b48 x21: ffff800009b8daf8
[    8.980917] x20: ffff80000a229a40 x19: ffff00003fd95a20 x18: 0000000000000000
[    8.988051] x17: 3830303030303030 x16: 3030303030303020 x15: 0000000000000001
[    8.995185] x14: 00000000000000cb x13: 0000000000000000 x12: 0000000000000001
[    9.002317] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff80000a76bd30
[    9.009452] x8 : ffff000002d68ac0 x7 : 0000000000000000 x6 : 00000000106f30a4
[    9.016584] x5 : 00ffffffffffffff x4 : 4000000000000002 x3 : ffff80000a76bdd0
[    9.023717] x2 : 4000000000000000 x1 : ffff800009b8ba20 x0 : ffff800009b8ba20
[    9.030851] Call trace:
[    9.033295]  ct_kernel_exit.constprop.0+0x98/0xa0
[    9.037998]  ct_idle_enter+0x10/0x1c
[    9.041572]  default_idle_call+0x1c/0x3c
[    9.045494]  do_idle+0x214/0x270
[    9.048724]  cpu_startup_entry+0x24/0x2c
[    9.052646]  secondary_start_kernel+0x130/0x154
[    9.057179]  __secondary_switched+0xb8/0xbc
[    9.061363] ---[ end trace 0000000000000000 ]---
[   14.048126] platform leds: deferred probe pending

Somehow skb->tail was greater than skb->end. Unfortunately I do not have access 
to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the MangoPi 
MQ Quad.

Larry


