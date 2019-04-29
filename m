Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6DDB79
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 07:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfD2FUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 01:20:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44482 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfD2FUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 01:20:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id s10so10556578qtc.11
        for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2019 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJLIG7dxc1t4keHoNZMHwMCy4fC2upZVRrvXxBwgyGg=;
        b=A+HcLXWXR4GLpxqnbNa7AYORB4uD/vxTr52KYNmE9V/5Gfy2Ai+VCyTPCGPz45KOfx
         cMQqnUlNB/P7YqdEtTGN/zA2hjZ+rsT0oG44wiLOdTSVQh+Yjlem4PLHn7p31JCPM9al
         v90CEFpbu9KBXf1VWN+2d17t9QtKua8OeYEj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJLIG7dxc1t4keHoNZMHwMCy4fC2upZVRrvXxBwgyGg=;
        b=n1hTLMXXVt1+0VPFf1HCyQTo2nXD50M5ZnEgbtI3XFmiJTm8OIhscOXjt59RS31aMh
         OPQM67GuXmccuFUOBT762wNkp1M8OVynla3kz1bN9FrSRhY1a6xT8s4V40oVbUuL7z5l
         HBXGNOx8FblK2c9koA/Ox2GFabf2yF5+Lz+b6y6hz85llLhPODAnCaFlu0JC5DpgzUKn
         sKbWh3z0kU6hsmgOdql4Euf+Bcr3L6pFAjab9ub7MyJ1cdJc9zBW+kyOQIJTtGFJRsxM
         fiZZ/Fj420IyurkOrfQOeXC3ypsJVRGqZay0qFcIb0Wfa5+hX0fwq1pErMUKA0LmOBYO
         Im+A==
X-Gm-Message-State: APjAAAWJj78ze2lmWe3sd6jYOiZICOzzO5k8ExgQm0ER7tnImkGrlCMI
        yIgyRG4uS8Ijxo4f/aAF9m8MzgkT2an2IquHThoy4w==
X-Google-Smtp-Source: APXvYqwifI3CyAt8MRjCNDp5oYY8bGALtL6BDz5mb1hMPM3vu7NPiC844k4QbTQrLxBw1hNcs8UgEKjVkLb08zWEJ3c=
X-Received: by 2002:ac8:362e:: with SMTP id m43mr29209080qtb.339.1556515247704;
 Sun, 28 Apr 2019 22:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <1555406865-21514-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1555406865-21514-1-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 29 Apr 2019 13:20:36 +0800
Message-ID: <CANMq1KBjupZeuw3hmQHbYui4G9+Ni7SPPE1SNqG9=89iVhFjgg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add support for simulate crash on SDIO chip
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 16, 2019 at 5:28 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> The command to simulate firmware crash:
> echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
>
> It will send WMI_FORCE_FW_HANG_ASSERT to firmware, then it will trigger
> CPU interrupt status register for SDIO chip, ath10k driver need to
> configure it while enable SDIO interrupt, otherwise ath10k driver will
> not get the assert error info.
>
> After this change, it will success for simulate firmware crash.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/hw.h   | 1 +
>  drivers/net/wireless/ath/ath10k/sdio.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
> index 7131499..60521ed 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -1095,6 +1095,7 @@ struct ath10k_hw_ops {
>  #define MBOX_CPU_INT_STATUS_ENABLE_ADDRESS     0x00000819
>  #define MBOX_CPU_INT_STATUS_ENABLE_BIT_LSB     0
>  #define MBOX_CPU_INT_STATUS_ENABLE_BIT_MASK    0x000000ff
> +#define MBOX_CPU_STATUS_ENABLE_ASSERT_MASK 0x00000001
>  #define MBOX_ERROR_STATUS_ENABLE_ADDRESS       0x0000081a
>  #define MBOX_ERROR_STATUS_ENABLE_RX_UNDERFLOW_LSB  1
>  #define MBOX_ERROR_STATUS_ENABLE_RX_UNDERFLOW_MASK 0x00000002
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index fae56c6..78a2f3b 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -850,6 +850,8 @@ static int ath10k_sdio_mbox_proc_cpu_intr(struct ath10k *ar)
>
>  out:
>         mutex_unlock(&irq_data->mtx);
> +       ath10k_err(ar, "firmware crashed!\n");
> +       queue_work(ar->workqueue, &ar->restart_work);

Err, so you consider _any_ CPU interrupt to be caused by the FW
crashing? Is that correct? If so, please at least add a comment.

Otherwise, maybe you should run this only if
MBOX_CPU_STATUS_ENABLE_ASSERT_MASK is set in cpu_int_status?

>         return ret;
>  }
>
> @@ -1495,8 +1497,10 @@ static int ath10k_sdio_hif_enable_intrs(struct ath10k *ar)
>         regs->int_status_en |=
>                 FIELD_PREP(MBOX_INT_STATUS_ENABLE_MBOX_DATA_MASK, 1);
>
> -       /* Set up the CPU Interrupt status Register */
> -       regs->cpu_int_status_en = 0;
> +       /* Set up the CPU Interrupt Status Register, enable CPU sourced interrupt #0
> +        * #0 is used for report assertion from target
> +        */
> +       regs->cpu_int_status_en = FIELD_PREP(MBOX_CPU_STATUS_ENABLE_ASSERT_MASK, 1);
>
>         /* Set up the Error Interrupt status Register */
>         regs->err_int_status_en =
> --
> 1.9.1
>
