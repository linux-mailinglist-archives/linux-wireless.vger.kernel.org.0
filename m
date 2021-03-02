Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2732AF50
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhCCARJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbhCBCBD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 21:01:03 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB30C061756
        for <linux-wireless@vger.kernel.org>; Mon,  1 Mar 2021 17:51:18 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n14so20051925iog.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Mar 2021 17:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChiCCkiCsXQxiUixofhODiitqcy5zpCs8hKaFZVKRjI=;
        b=XH9FrLA/2st5+fTiC6HJTOSf1MwNIWxkjsihf73fTh7kndO6L7cbplAGk5wrk3f+Bd
         J65pMiwHsVzExSIZAIqmYrj64nyh2BDfz+hwVYfokEn0+0RtC0wVX3/5YWF1x9TlyfXi
         qHM1MDkz3jgzQTAo5gqt8jAd0mGP+w3XT4U14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChiCCkiCsXQxiUixofhODiitqcy5zpCs8hKaFZVKRjI=;
        b=KHGW2Wj6XshW/mhpcm2IOoeqxSi2vX0PA2r5mtUinF9jHy2Ixwdyd+GOfEHG/Grt0G
         raNkoCllBx8m9KQx0YbVr4KFvV2hxUwTcicLPuJXsaIp+9+1/FQI7fZ2fbp9wR03FFLT
         8yZy3R3I5w4kmU/JlmgmwzF7tdM6Hh4wO7YMqsBIME+fNwJCThhoLZ9Le7WAu1vz6MQQ
         lLpoRv5/LphwAxLtUsPeXRG7NRSOYjlzv6AFbtIS6kNLskb2WZM40CoVL8Mxq9H1dF3K
         KjgDnC+UzDHWuqu6c/Ue26zMNCk1WjsPrHrVq0GG+S8m5DB7O1idV3jmn5xRky6+YXZZ
         FZ0g==
X-Gm-Message-State: AOAM533pzBaiixqiqKKdfJA7Io+H8MNamwZhDMHVtoHZwW9/jhcNfyCm
        ay+6zL6QjctB+MV4mJ+xlKtAxEe99Srv+9AUaN9+sw==
X-Google-Smtp-Source: ABdhPJz3J7j717c/uTMNBy/qHIbiLcuAWjx+u4Udcm5tqf42hVMrgjAO+VnjYWDCI+qnDYI83S2kk8HmE46Ww7MQ2FE=
X-Received: by 2002:a02:1704:: with SMTP id 4mr19127370jah.121.1614649877502;
 Mon, 01 Mar 2021 17:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20210223142908.23374-1-youghand@codeaurora.org>
In-Reply-To: <20210223142908.23374-1-youghand@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Mon, 1 Mar 2021 17:51:05 -0800
Message-ID: <CACTWRwti94_VXpFZZhZKJhhJ_YUb1mCWjR2AtD_Rqwe6-GOGHQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: skip the wait for completion to recovery in
 shutdown path
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        ath10k-review.external@qti.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch seems to address the comments on v2. Overall this patch LGTM.

Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>

On Tue, Feb 23, 2021 at 6:29 AM Youghandhar Chintala
<youghand@codeaurora.org> wrote:
>
> Currently in the shutdown callback we wait for recovery to complete
> before freeing up the resources. This results in additional two seconds
> delay during the shutdown and thereby increase the shutdown time.
>
> As an attempt to take less time during shutdown, remove the wait for
> recovery completion in the shutdown callback and added an API to freeing
> the reosurces in which they were common for shutdown and removing
> the module.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
> Change-Id: I65bc27b5adae1fedc7f7b367ef13aafbd01f8c0c
> ---
> Changes from v2:
> -Corrected commit text and added common API for freeing the
>  resources for shutdown and unloading the module
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 29 ++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 84666f72bdfa..70b3f2bd1c81 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1781,17 +1781,11 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int ath10k_snoc_remove(struct platform_device *pdev)
> +static int ath10k_snoc_free_resources(struct ath10k *ar)
>  {
> -       struct ath10k *ar = platform_get_drvdata(pdev);
>         struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>
> -       ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc remove\n");
> -
> -       reinit_completion(&ar->driver_recovery);
> -
> -       if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> -               wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);
> +       ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc free resources\n");
>
>         set_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
>
> @@ -1805,12 +1799,29 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int ath10k_snoc_remove(struct platform_device *pdev)
> +{
> +       struct ath10k *ar = platform_get_drvdata(pdev);
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +
> +       ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc remove\n");
> +
> +       reinit_completion(&ar->driver_recovery);
> +
> +       if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> +               wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);
> +
> +       ath10k_snoc_free_resources(ar);
> +
> +       return 0;
> +}
> +
>  static void ath10k_snoc_shutdown(struct platform_device *pdev)
>  {
>         struct ath10k *ar = platform_get_drvdata(pdev);
>
>         ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc shutdown\n");
> -       ath10k_snoc_remove(pdev);
> +       ath10k_snoc_free_resources(ar);
>  }
>
>  static struct platform_driver ath10k_snoc_driver = {
> --
> 2.29.0
>
