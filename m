Return-Path: <linux-wireless+bounces-547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312B808A92
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EEAB20E38
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555541C8F;
	Thu,  7 Dec 2023 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMnidG7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C024C10EC
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 06:29:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-daf26d84100so1057501276.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 06:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701959354; x=1702564154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8s9htAHiKgThgN6TKYaR8ilXK3DAarKwO4m0C7Cgc14=;
        b=ZMnidG7o3DavObxLTIWKr7Anr/fW5ichTmw+fPYbPEEqzgh8CIe9Wp8Kk0niiYC3Fv
         9uk/MtbhIJbPPellRvyfR8iw3EVBbSfEOaXcs8uyMomWa9rhjKCqcvqxEgY9hwiIXBH4
         uRKnbEItj+0p91DcvZkaARdBTcYDpZQyReV4e3NQm0L6aG6Ct029oR6mYgY9XGd/asJc
         +N3wKXVE3M6cNkPY+5mMON683pf+ZtnuM21vzsWawHE09usyGLP/A6RlbMosPLb1lNg0
         N+DjqWil+n1SuSNdPteOvOjGKO59IxDl3Nf2yi1GTis5A4pyVD+aewFV5oluQEJWwMiZ
         /ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959354; x=1702564154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s9htAHiKgThgN6TKYaR8ilXK3DAarKwO4m0C7Cgc14=;
        b=iLCmjJgUWiu+eeQ8dOWZN2DpAMj2krT7FQJuc5BzoapegWGySSl5p/8Nl9EtiDw+3I
         Jqjw+C+8MvntAn/+JTfl4VNtCj4eaPuGhXbXHVhoSb9HWvrr816GUB5l8IJynBxDsPoi
         iP6BQ0Dnj3A4MrtWpqTgnWyaQ9UxVaKXMSqLWhf5NuGK9AhIArc87nNS43Z+xNR31jYy
         gWkgpEqkwA+lhw1PkbW1rNn5hbRhbJZFRpxbMd9UsLai0gWOPCKPaE7/R159AsTpz9OP
         WDJNalAdoXqEZY98TK/7UmPNlH8VJnnOCWJqvwnDfHg8UlUq4OT39igDB90HbA+/7b1Z
         /u+Q==
X-Gm-Message-State: AOJu0YwBssZqQzaeLQ3XuPm91UHldwb4i/90cnngLwtxaXweFuwqEkpO
	5i+Bhg0tSvZfZ5WEw9FRB7ILAJxVu5hwh6FoNLGfZg==
X-Google-Smtp-Source: AGHT+IHSVO+oL9Bc7/LHh+dKksw0voCJnFwoiex90soZj9IOHCm7vBuye1CnGqjzRyRkaEIYYigpsKozNkNUs71tbpo=
X-Received: by 2002:a25:9112:0:b0:db7:dacf:5a08 with SMTP id
 v18-20020a259112000000b00db7dacf5a08mr2507704ybl.124.1701959354652; Thu, 07
 Dec 2023 06:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
In-Reply-To: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 7 Dec 2023 22:29:03 +0800
Message-ID: <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To: Douglas Anderson <dianders@chromium.org>
Cc: ath10k@lists.infradead.org, Abhishek Kumar <kuabhs@chromium.org>, 
	Youghandhar Chintala <quic_youghand@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	John Stultz <jstultz@google.com>, Viktor Martensson <vmartensson@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Douglas

On Sat, 1 Jul 2023 at 06:19, Douglas Anderson <dianders@chromium.org> wrote:
>
> As talked about in commit d66d24ac300c ("ath10k: Keep track of which
> interrupts fired, don't poll them"), if we access the copy engine
> register at a bad time then ath10k can go boom. However, it's not
> necessarily easy to know when it's safe to access them.
>
> The ChromeOS test labs saw a crash that looked like this at
> shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
> problem could also reproduce upstream):
>
> Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> ...
> CPU: 4 PID: 6168 Comm: reboot Not tainted 5.15.111-lockdep-19350-g1d624fe6758f #1 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
> Hardware name: Google Kingoftown (DT)
> ...
> pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
> lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
> ...
> Call trace:
> ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
> ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
> ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
> ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
> ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
> ath10k_halt+0x398/0x5b0 [ath10k_core ...]
> ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
> drv_stop+0x148/0x6b4 [mac80211 ...]
> ieee80211_stop_device+0x70/0x80 [mac80211 ...]
> ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
> ieee80211_stop+0x144/0x1a0 [mac80211 ...]
> __dev_close_many+0x1e8/0x2c0
> dev_close_many+0x198/0x33c
> dev_close+0x140/0x210
> cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
> ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
> ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
> ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
> ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
> ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
> ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
> platform_shutdown+0x7c/0xa0
> device_shutdown+0x3e0/0x58c
> kernel_restart_prepare+0x68/0xa0
> kernel_restart+0x28/0x7c
>
> Though there's no known way to reproduce the problem, it makes sense
> that it would be the same issue where we're trying to access copy
> engine registers when it's not allowed.
>
> Let's fix this by changing how we "disable" the interrupts. Instead of
> tweaking the copy engine registers we'll just use disable_irq() and
> enable_irq(). Then we'll configure the interrupts once at power up
> time.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Recently during our Android build test on the Dragonboard 845c board,
with the Android Common Kernel android11-5.4-lts and android12-5.4-lts branches,

we found there are some ufshcd related changes printed,
and the serial console gets stuck, no response for input,
and the Android boot is stuck at the animation window.

The problem is reported here
    https://issuetracker.google.com/issues/314366682
You could check there for more log details.

And with some bisection, I found it's related to this commit,
when I revert this commit, the problem is gone.

So replied here, not sure if you have any idea about it,
or any suggestions on what we should do next to resolve the problem?

Thanks,
Yongqin Liu

>  drivers/net/wireless/ath/ath10k/snoc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 26214c00cd0d..2c39bad7ebfb 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -828,12 +828,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
>
>  static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
>  {
> -       ath10k_ce_disable_interrupts(ar);
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +       int id;
> +
> +       for (id = 0; id < CE_COUNT_MAX; id++)
> +               disable_irq(ar_snoc->ce_irqs[id].irq_line);
>  }
>
>  static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
>  {
> -       ath10k_ce_enable_interrupts(ar);
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +       int id;
> +
> +       for (id = 0; id < CE_COUNT_MAX; id++)
> +               enable_irq(ar_snoc->ce_irqs[id].irq_line);
>  }
>
>  static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
> @@ -1090,6 +1098,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>                 goto err_free_rri;
>         }
>
> +       ath10k_ce_enable_interrupts(ar);
> +
>         return 0;
>
>  err_free_rri:
> @@ -1253,8 +1263,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
>
>         for (id = 0; id < CE_COUNT_MAX; id++) {
>                 ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
> -                                 ath10k_snoc_per_engine_handler, 0,
> -                                 ce_name[id], ar);
> +                                 ath10k_snoc_per_engine_handler,
> +                                 IRQF_NO_AUTOEN, ce_name[id], ar);
>                 if (ret) {
>                         ath10k_err(ar,
>                                    "failed to register IRQ handler for CE %d: %d\n",
> --
> 2.41.0.255.g8b1d071c50-goog
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

