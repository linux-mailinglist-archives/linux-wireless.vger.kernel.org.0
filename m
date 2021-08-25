Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27203F7EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhHYWtT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhHYWtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 18:49:19 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D17C061757
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 15:48:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y128so1633194oie.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlRDH55EiWQLk3rB82Bp9s+nmfPSNiAJf1+J1DgMoGg=;
        b=UXJEWMe2pj4mdJwOedV1Q5Tmbcz4di5xMzVoDoJDuEjNgDhPpImmem1iykHb6Z/Ttu
         0xtaqj/S9ibvNyF25dPzNEb7P9Lgr5AQB+6G5lr5knGT0PmCCZi2tKWr88Q2vjh9CDJI
         3P0mqVGp4QDExhNaPwHWlTew/yZaGNwK0F+QEEilYGj52ohYaDiGpXsUcWcljdAcCyaa
         HrgWzA7UdUut9yI4PmGYeFnFFrulwWRA3Tlhi/yBOluZQWga49d3d+E4T78zuye01fI5
         94OO82G09jhPEEW/Ssn8EvuyhMo0k3GFnq8MB82AFS/uxXzTtj9Y7BqTwYyK7Ej8qN0L
         05RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlRDH55EiWQLk3rB82Bp9s+nmfPSNiAJf1+J1DgMoGg=;
        b=BfdGUeJQvKhYAV8Y81iah8Dyp6rJHkRBhIVXZl/z0CEBg1RAsVU2ytXXpwimUHpSaI
         vmU+0SPAAICyWYazfW2DxqyNZh5U6O2DI1aaEGiiApL6OQhqkLS7GGrR3Vy28xsM7USz
         OnsYJA7GrG2oZ1IRmx5xGcsO+dpxjzVxv1+cxqwDcqA58s0yzX+ZbXyltcY2K3N8uX+m
         9PtOuRM/qw9zTNrduREUAvEQu6VC8WO6NKoR/gS6y7Bx71dFU1kQxOfdsBInPRo4hjqf
         9pXZ1PPltMsPvkHKqXF1s2UEAvCOqwsSyr2s7g0OCDbAu4vowQVd3mGm8uJGHsFl+Z52
         TUYQ==
X-Gm-Message-State: AOAM530IdP6uogXDmbTZuAPO+ExwSUPT11/C0tg63th7LHeTWpE0Gxzh
        etvp28qWtl6yX/gf2OZyt+Y8lP7LvUQHCWNFF35Idk7KGf0=
X-Google-Smtp-Source: ABdhPJyJWJOaG/AEozXkFYl/RustOM7ngWw90Ks1ffUMb3VNWeAXxLYNNm2nrVdrxumT6LoCArwQ45cnNk/4PxnDDw8=
X-Received: by 2002:aca:6541:: with SMTP id j1mr275224oiw.146.1629931712159;
 Wed, 25 Aug 2021 15:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org> <1629884277-18759-8-git-send-email-ppranees@codeaurora.org>
In-Reply-To: <1629884277-18759-8-git-send-email-ppranees@codeaurora.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 26 Aug 2021 01:49:02 +0300
Message-ID: <CAHNKnsSkDtos-9f1Er-Gkc-Mi4gt9V_Nhtu0VDH-6W9ZcNZ9tg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] ath11k: add branch predictors in process_rx
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 25, 2021 at 12:39 PM P Praneesh <ppranees@codeaurora.org> wrote:
> In datapath, add branch predictors where required in the process rx().
> This protects high value rx path without having performance overhead.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index e105bdc..5d805881 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2535,13 +2535,13 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
>         rcu_read_lock();
>
>         ar = ab->pdevs[mac_id].ar;
> -       if (!rcu_dereference(ab->pdevs_active[mac_id])) {
> +       if (unlikely(!rcu_dereference(ab->pdevs_active[mac_id]))) {
>                 __skb_queue_purge(msdu_list);
>                 rcu_read_unlock();
>                 return;
>         }

The pointer that is returned by the rcu_dereference() is not
dereferenced, so it is preferable to use rcu_access_pointer() here.

And since rcu_access_pointer() did not require the RCU protection, the
whole block with check and list purging could be moved before the
rcu_read_lock() call.

-- 
Sergey
