Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C552283F0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgGUPhe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgGUPhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 11:37:34 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B15C061794
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 08:37:33 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id q15so6372572uap.4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWncqL+S0JRCizmsP5rH0IHxLZuIk79rLB6DbhdOm9I=;
        b=T3dGBYsTOIpcHNQoowJYtKuYY0MZO/UhYOaNQu3Qc2UgihSHCcGkaq0xMl5uqUy7yh
         zTeMTnL/JkLkX4/67imzIFGXXVXP1WPuX15rGKq7zlPhzmmka7ZJIpqYlb3SRMTLQceT
         djxthG6Nuz+/gp17xBeTM3AVDGu0MVNlq8M9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWncqL+S0JRCizmsP5rH0IHxLZuIk79rLB6DbhdOm9I=;
        b=Yf/EQmWa6z9ZSRD5az10h3pkP0T4yeWHk2Y0e0FKthB38DXOkrQzBMDabLAcQTiQI0
         DIWtDUL1XpoccHzsH2dDWsixVnuuihQbtj92ZORps2JxhzabyKBgVsK62qQW99XN0ese
         YR/qqj1uYs0aiBL52TjdAr6kANU2Uz3r08AyKsvzCp1Uiy6bUir8gf3LmJBHUTNtnxsH
         HpO9FwP7khWI9Tu5jjflsUy7p87FDCR428VzoEdoc0NBE4H1BVxIjODC582Wa/cu1FJq
         Vq71LSvwAgXEbyBjXKQbb9gO/2mCgfMPEyHxhlj8YsaENQ+XNqHw6ohisbNVfclTuHR2
         yLkQ==
X-Gm-Message-State: AOAM531kp0VwjZ30/eVBfhpKYq2L9ETEsDxgedN3bpazn7YM9brbd0dT
        HsvnSL6eJipm3bnvN95sCpCfs9DBiwc=
X-Google-Smtp-Source: ABdhPJwWBew1lpfiReoHH/OIHyhhwDoyLuANPi1O3tMPnRp6dYhITzSDVwkkxR38vyUjJ32j5bbDvA==
X-Received: by 2002:ab0:2408:: with SMTP id f8mr20139935uan.91.1595345852771;
        Tue, 21 Jul 2020 08:37:32 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id p7sm2561023vsl.25.2020.07.21.08.37.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:37:31 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id p6so6342441uaq.12
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 08:37:31 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr21464631uaj.104.1595345851301;
 Tue, 21 Jul 2020 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
 <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
 <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
 <871rlcx8uv.fsf@codeaurora.org> <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
 <CALhWmc3i9Z+KiG1cJNvpSWNsiFhOa5jBw=XfcFz_gKwi_5QibA@mail.gmail.com>
 <CALhWmc1B0+SONV6_AF+nUzgxZdekPD3sZuhrsmwVQx1Q-cgT_g@mail.gmail.com>
 <CALhWmc0qF5stKRcikjwbeFmE-32hNCDazgQdqTMidUyt7u-T1Q@mail.gmail.com>
 <CALhWmc0JtQZE5CfLPb1WnwhE9wCYsjE-53kYWbwtFCs1k7FrCQ@mail.gmail.com> <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
In-Reply-To: <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jul 2020 08:37:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdeQTxbgitY3cQc+s8Pc7Lna7TWpAfzJdfXz-whjX1Qg@mail.gmail.com>
Message-ID: <CAD=FV=UdeQTxbgitY3cQc+s8Pc7Lna7TWpAfzJdfXz-whjX1Qg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Peter Oh <peter.oh@eero.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 6:32 PM Peter Oh <peter.oh@eero.com> wrote:
>
> I'll take my word back.
> It's not this patch problem, but by others.
> I have 2 extra patches before the 3 patches so my system looks like
>
> backports from ath.git 5.6-rc1 + linux kernel 4.4 (similar to OpenWrt)
> On top of the working system, I cherry-picked these 5.
>
> #1.
> ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
> ath.git commit 521fc37be3d879561ca5ab42d64719cf94116af0
> #2.
> ath10k: Fix NULL pointer dereference in AHB device probe
> wireless-drivers.git commit 1cfd3426ef989b83fa6176490a38777057e57f6c
> #3.
> ath10k: Add interrupt summary based CE processing
> https://patchwork.kernel.org/patch/11628299/
> #4.
> ath10k: Keep track of which interrupts fired, don't poll them
> https://patchwork.kernel.org/patch/11654631/
> #5.
> ath10k: Get rid of "per_ce_irq" hw param
> https://patchwork.kernel.org/patch/11654633/
>
> The error "[  14.226184] ath10k_ahb a000000.wifi: failed to receive
> initialized event from target: 80000000" is because of #1 and #2,
> since this happens even after I reverted #3~#5.
> Once I reverted all except #1 I got another crash.
>
> [   11.179595] !#%&PageFault P<__ath10k_ce_rx_post_buf+0x14/0x98
> [ath10k_core]> L<0x4bc00> F<005> [0000000c]
> [   11.179643] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000c
> [   11.439207] [<7f15a69c>] (__ath10k_ce_rx_post_buf [ath10k_core])
> from [<7f15a874>] (ath10k_ce_rx_post_buf+0x3c/0x50 [ath10k_core])
> [   11.447204] [<7f15a874>] (ath10k_ce_rx_post_buf [ath10k_core]) from
> [<7f2889a4>] (ath10k_pci_diag_read_mem+0x104/0x2a8 [ath10k_pci])
> [   11.458706] [<7f2889a4>] (ath10k_pci_diag_read_mem [ath10k_pci])
> from [<7f288b68>] (ath10k_pci_diag_read32+0x1c/0x2c [ath10k_pci])
> [   11.470767] [<7f288b68>] (ath10k_pci_diag_read32 [ath10k_pci]) from
> [<7f28abe8>] (ath10k_pci_init_config+0x2c/0x290 [ath10k_pci])
> [   11.482314] [<7f28abe8>] (ath10k_pci_init_config [ath10k_pci]) from
> [<7f28d160>] (ath10k_ahb_hif_power_up+0x7c/0xe8 [ath10k_pci])
> [   11.494153] [<7f28d160>] (ath10k_ahb_hif_power_up [ath10k_pci])
> from [<7f135348>] (ath10k_core_register_work+0x84/0x8f8 [ath10k_core])
> [   11.505766] [<7f135348>] (ath10k_core_register_work [ath10k_core])
> from [<8023b614>] (process_one_work+0x1c0/0x2f8)
> [   11.517594] [<8023b614>] (process_one_work) from [<8023c650>]
> (worker_thread+0x280/0x3c0)
> [   11.527919] [<8023c650>] (worker_thread) from [<802408f8>]
> (kthread+0xd8/0xe8)
> [   11.536247] [<802408f8>] (kthread) from [<80209ce8>]
> (ret_from_fork+0x14/0x2c)
>
> When I revert #1 eventually, my system is back to working.
> So I'm blaming the #1 and #2 could have potential bugs or require
> ath.git branch up-to-date.

You caught me just as I was signing off yesterday evening, but just to
confirm that you are now fairly certain that none of the 3 patches I
was involved with[*] are related to your problems.  If that's wrong
and there's an action I need to take on the patches then let me know!
:-)

[*] The three patches I was involved with:

ath10k: Add interrupt summary based CE processing
https://patchwork.kernel.org/patch/11628299/

ath10k: Keep track of which interrupts fired, don't poll them
https://patchwork.kernel.org/patch/11654631/

ath10k: Get rid of "per_ce_irq" hw param
https://patchwork.kernel.org/patch/11654633/

-Doug
