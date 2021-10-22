Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF2437966
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhJVO4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhJVO4j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:56:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B6C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:54:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u6so2885177ple.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faZSUxBeynSunNbj8PIrTz1NWp8g+6bh+uZl7AsmRKw=;
        b=O+NrNnGIeL4SZfMppYh2ILCmAbmQAEFFyGldi83JMjKwiYV+8UGEqikmIOwG9GtZpj
         EvZSYZBF3hHecS2Mb8aPX0MSyqYh8oBX6dymVJZv4rqHJYffLlhbwi0aZZB9MJ7pK1kG
         MjZZ7emrmjhXMVmqUZXppb9JvaBBHfoJN+qW7Ko+Ma8JUVLh+/F8YfdJFGwKRcqEUIFx
         k+jyLECMHxoiGYdhPKRd/0qsmgiSNzerFurYdwxwXwBEBvEvaZNHkZ9Vkdu2WqYr/PU8
         +oGd/GNKEYV3aadwtsCMfwz7hm824Z2n5xiO12cH4rItOXnwA6EbsK0O6F+/brtP8vja
         UByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faZSUxBeynSunNbj8PIrTz1NWp8g+6bh+uZl7AsmRKw=;
        b=mmC8t8o6Zt33QjHAvD77q4hC2I8vGQrCwmlBmZST4bRaEs1AnFoqABgOS+jqiswxVl
         +1uNHBGortwVnEA7NRXLL1eM32P8NKQaRMDk58VAxqzobYT9Fgu8K2TVZpLlWSfMdwpR
         egGAlD2YrCniOveZeYwlL/XUms7KdabMtp7kqaTP8602Gx716GT7XZG8wxQBf1N++OBB
         aZFHYT7wALK8DrzLe1lVaRV+PfnV+vUHlcc6CXDgEdCBTosCMX8UBytnkQJn2e6rNd8/
         X7QAGe0bK/WQTWFnb0/ZQjqx8k4zRV6OKh9WT6toEcmis75GM5gkMvp4ifFBVqF9k0BA
         XhmQ==
X-Gm-Message-State: AOAM530MCH8E8LIrAW8vLN9OtCU5btrXffEA43ugBNNRYJ9eO4A4RBCy
        NT2tsLZY5CaxIGIQFGzUDAMSqYtT+rpqArATjLZ/ZX4aHj4VxQ==
X-Google-Smtp-Source: ABdhPJyKByG+BZ9bBP9CFmXuH56/wyBafGcnczMWg1+q/1hLzvgFzYfq/gookNaZ0WN9tWm59M0XguLHUl+G63t7Rfk=
X-Received: by 2002:a17:902:e801:b0:13f:2212:d641 with SMTP id
 u1-20020a170902e80100b0013f2212d641mr272881plg.87.1634914461041; Fri, 22 Oct
 2021 07:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org> <20211022141008.2846454-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20211022141008.2846454-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 22 Oct 2021 17:05:17 +0200
Message-ID: <CAMZdPi-muvfLNb4Zv5b9C+Sg8MQcC6GYyQSt_yhfB7=XB75YPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "wcn36xx: Enable firmware link monitoring"
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, Benjamin Li <benl@squareup.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 22 Oct 2021 at 16:08, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Benjamin Li <benl@squareup.com>

Should it get a 'Fixes' tag?

Regards,
Loic

> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index dd8810fd76a3d..fd8b2753da7dd 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1334,7 +1334,6 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
>         ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
>         ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
>         ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
> -       ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
>
>         wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
>                 BIT(NL80211_IFTYPE_AP) |
> --
> 2.33.0
>
