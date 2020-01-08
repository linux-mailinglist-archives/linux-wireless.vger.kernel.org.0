Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3713415C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAHMCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 07:02:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45083 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgAHMCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 07:02:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so2342423oie.12
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2020 04:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+4ekRz0HS4SHBbvZctSkuL3O7+gGpKDr+t7B4bqj6Y=;
        b=r4VU/ksCnzNHMh0zR08v1hz8zZwHgRi0UJxiHPc0fKlFcrwRp4KWeCZLSXo6rASudc
         9lH8W5HtDsIjSBEf+AaQtXEkTPDjflf4AO71AfCdKVr1MINNB/QMGeeIbQwjsD6b+LpJ
         XuemmdSawH1x2WN26ddDyOzBPdBZjphJgqDokv9CO5aoUPTm8cDpb5uW33s9yGA7iAXo
         Akkqi06MCQf64twoQjHIcR//X7uWgxFYaEBV38ngRDPHQO35idRX5oIyTS1qDetkzBAK
         QRxsJ4NZ5TDObHPg/PfPOC2tTqrg3P/FPj3Kc78DCpapu2JlpBne+TltGmCxoGzHX7Ye
         FHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+4ekRz0HS4SHBbvZctSkuL3O7+gGpKDr+t7B4bqj6Y=;
        b=lvVrqljJTEdzxCZ/zbSsqfa3X49xB8CX2xfTwf5gTNqbClRNoPFha0WSf4z+kS78ax
         IsVbPWnKtRfVs9fZvGAPv0Qg8ekmMGjPSGOQPQ/Cwr54DTDHyqmlThMI5lnvCnmw4B5e
         ur86KtmQmtA852EZTGJdCcJnn4xbyiIqNr93OQhHed6M1sWDg6ecUIV97M7SKYk0liAZ
         bc09/Ze32ng2d0rizmNNEJyqTee1SYcUalr6FBhwUl4fsBw6+oJ+CWi9NYJ4didFVdBZ
         RqaQ+ZGdIq5asMOYQGs8ZnAoBA6xp9ptM2ffRpWdarPmZ50C5wzwZfMqlplY5Ph8GDCb
         JsVg==
X-Gm-Message-State: APjAAAVRCmSLMUnYZVAfDjY+8deFRkVYY4kG5jsELtoxfS1m6yK9pG7e
        +AYb2AzD57JWU3si+g4yH8NXaIKM9tQNetnzc2o46R45tAHTiQ==
X-Google-Smtp-Source: APXvYqyWl/oDeXA1kB34IRJknI45nNof2KCrLrrPmZHH2Wp71YXKB2KoEayjedgosaCIcsub5mNj5pezYFwvfNpEXpM=
X-Received: by 2002:a05:6808:3c2:: with SMTP id o2mr2729856oie.145.1578484933910;
 Wed, 08 Jan 2020 04:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20200108031957.22308-1-wgong@codeaurora.org> <20200108031957.22308-2-wgong@codeaurora.org>
In-Reply-To: <20200108031957.22308-2-wgong@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 8 Jan 2020 04:02:02 -0800
Message-ID: <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I think this might break the "wedged" state.

Would simply not taking action unless STATE ON avoid the problems with
multiple calls to _restart? ie:

diff --git a/drivers/net/wireless/ath/ath10k/core.c
b/drivers/net/wireless/ath/ath10k/core.c
index 5ec16ce19b69..a6c11b2bc97c 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2198,11 +2198,8 @@ static int ath10k_init_hw_params(struct ath10k *ar)
  return 0;
 }

-static void ath10k_core_restart(struct work_struct *work)
+static void inline _ath10k_core_restart(struct ath10k *ar)
 {
- struct ath10k *ar = container_of(work, struct ath10k, restart_work);
- int ret;
-
  set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);

  /* Place a barrier to make sure the compiler doesn't reorder
@@ -2232,14 +2229,28 @@ static void ath10k_core_restart(struct
work_struct *work)
  */
  cancel_work_sync(&ar->set_coverage_class_work);

+ ath10k_halt(ar);
+ ath10k_scan_finish(ar);
+ ieee80211_restart_hw(ar->hw);
+
+ ret = ath10k_coredump_submit(ar);
+ if (ret)
+ ath10k_warn(ar, "failed to send firmware crash dump via devcoredump:
%d", ret);
+
+ complete(&ar->driver_recovery);
+}
+
+static void ath10k_core_restart(struct work_struct *work)
+{
+ struct ath10k *ar = container_of(work, struct ath10k, restart_work);
+ int ret;
+
  mutex_lock(&ar->conf_mutex);

  switch (ar->state) {
  case ATH10K_STATE_ON:
  ar->state = ATH10K_STATE_RESTARTING;
- ath10k_halt(ar);
- ath10k_scan_finish(ar);
- ieee80211_restart_hw(ar->hw);
+ _ath10k_core_restart(ar);
  break;
  case ATH10K_STATE_OFF:
  /* this can happen if driver is being unloaded
@@ -2262,13 +2273,6 @@ static void ath10k_core_restart(struct work_struct *work)
  }

  mutex_unlock(&ar->conf_mutex);
-
- ret = ath10k_coredump_submit(ar);
- if (ret)
- ath10k_warn(ar, "failed to send firmware crash dump via devcoredump: %d",
-     ret);
-
- complete(&ar->driver_recovery);
 }

 static void ath10k_core_set_coverage_class_work(struct work_struct *work)

On Tue, Jan 7, 2020 at 7:20 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> When it has more than one restart_work queued meanwhile, the 2nd
> restart_work is very esay to break the 1st restart work and lead
> recovery fail.
>
> Add a ref count to allow only one restart work running untill
> device successfully recovered.
>
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 13 +++++++++++++
>  drivers/net/wireless/ath/ath10k/core.h |  2 ++
>  drivers/net/wireless/ath/ath10k/mac.c  |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 91f131b87efc..0e31846e6c89 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct work_struct *work)
>  {
>         struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>         int ret;
> +       int restart_count;
> +
> +       restart_count = atomic_add_return(1, &ar->restart_count);
> +       if (restart_count > 1) {
> +               ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
> +               atomic_dec(&ar->restart_count);
> +               return;
> +       }
>
>         set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
>
> @@ -2231,6 +2239,11 @@ static void ath10k_core_restart(struct work_struct *work)
>
>         mutex_lock(&ar->conf_mutex);
>
> +       if (ar->state != ATH10K_STATE_ON) {
> +               ath10k_warn(ar, "state is not on: %d\n", ar->state);
> +               atomic_dec(&ar->restart_count);
> +       }
> +
>         switch (ar->state) {
>         case ATH10K_STATE_ON:
>                 ar->state = ATH10K_STATE_RESTARTING;
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
