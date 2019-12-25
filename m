Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3E12A866
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2019 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYPOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Dec 2019 10:14:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34753 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYPOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Dec 2019 10:14:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so8149957oig.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2019 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Aqdscs588lY4i7HDXEbNZYDFxUNRhq25hsL4hnvxXs=;
        b=imS9vn64hqsYHK913rD73T92+rvmM94DC5ySY4aaB/YBAitGEjlW73QHuUDYLwrmWM
         Ak+SiKXrlUVpJJt/3/m167+TsY5NPRTKKLWhiB2HKJafyd7cIS1VIjhO7bp/++QUOSNO
         tjHKFHUvb6ni4vDXfDJNxefEteRWGrPDwpU3TaHxEIiSS2W1LewlVTBju80DxMaYeS+G
         T+2EIT94GltL47waRWqgewd6hzoflk1WlelUkvQ6MYx9wNwURaebkz0qalRCfQYAehF5
         ZVKm/rasOIVcBwBoiT+NtkUuVqaTV/jzlWVqw8r4/riXdlu8gyTt+3Beg5Mm1eNmHonT
         kC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Aqdscs588lY4i7HDXEbNZYDFxUNRhq25hsL4hnvxXs=;
        b=TTu6hTrnG1pO1WJ5PPhCQeNqTLFCwMKWcaiMhpCsifv+25LFApRfbywrigjuxtlWHO
         CrorWu+GlmEvb/HON+wOlY1jDH8lN26Ha/RSMO9COdkZesyCjwd9Cp5GWeXSdHM69nIw
         dVp3A2nPbG2xsx9OaW1PyCZZgBrOHjIQQVk0Bcq36q9sgDRhXkXK01LWUVaq0xcep8PG
         95QnfWDNqubYEYFPo0FXu6CCWCS53ISDAJiGjKvN+I33MzgEWLeiPiHSYXB1LLArI6Qy
         tvcTbt7M13dFlbHAL1ayLCmXoX5xpWHgfI725xijwQ97fuu0npqmA2uXhOqPja1KpCp5
         2rMw==
X-Gm-Message-State: APjAAAWlejmpz5cZsf4cOu57ImRCWX+Ho3MvrwFYRJ58T8JhvtddZLRc
        doJ16AKfPdvZR2ktbHLudK35v/klDcMJpvb0l5Y=
X-Google-Smtp-Source: APXvYqzpP+fvEZUxl4b0VHahIOCrBk+neYQOSum4pwCIEMizKu1QFC+S7CxMHunN+21jr7CLGphOIZqjPSH1yOhSVNM=
X-Received: by 2002:aca:f305:: with SMTP id r5mr1662822oih.174.1577286891473;
 Wed, 25 Dec 2019 07:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20191225120002.11163-1-wgong@codeaurora.org> <20191225120002.11163-2-wgong@codeaurora.org>
In-Reply-To: <20191225120002.11163-2-wgong@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 25 Dec 2019 07:14:38 -0800
Message-ID: <CAMrEMU-p3+HRZYW6TzXwZSwhxj9oJ9JW1Rg=ZysJ3fr0rm45Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ath10k: add refcount for ath10k_core_restart
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This does not only effect SDIO.

Why a semaphore / count? Could the conf_mutex be held earlier, or
perhaps change the state to ATH10K_STATE_RESTARTING first?
ath10k_reconfig_complete is also called in mac.c when channel is changed so

On Wed, Dec 25, 2019 at 4:01 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> When it has more than one restart_work queued meanwhile, the 2nd
> restart_work is very esay to break the 1st restart work and lead
> recovery fail.
>
> Add a ref count to allow only one restart work running untill
> device successfully recovered.
>
> This patch only effect sdio chips.
>
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 8 ++++++++
>  drivers/net/wireless/ath/ath10k/core.h | 2 ++
>  drivers/net/wireless/ath/ath10k/mac.c  | 1 +
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 91f131b87efc..4e0e8c86bdd4 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct work_struct *work)
>  {
>         struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>         int ret;
> +       int restart_count;
> +
> +       restart_count = atomic_inc_and_test(&ar->restart_count);
> +       if (restart_count > 1) {
> +               ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
> +               atomic_dec(&ar->restart_count);
> +               return;
> +       }
>
>         set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index e57b2e7235e3..810c99f2dc0e 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -982,6 +982,8 @@ struct ath10k {
>         /* protected by conf_mutex */
>         u8 ps_state_enable;
>
> +       atomic_t restart_count;
> +
>         bool nlo_enabled;
>         bool p2p;
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 3856edba7915..bc1574145e66 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -7208,6 +7208,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
>                 ath10k_info(ar, "device successfully recovered\n");
>                 ar->state = ATH10K_STATE_ON;
>                 ieee80211_wake_queues(ar->hw);
> +               atomic_dec(&ar->restart_count);
>         }
>
>         mutex_unlock(&ar->conf_mutex);
> --
> 2.23.0
