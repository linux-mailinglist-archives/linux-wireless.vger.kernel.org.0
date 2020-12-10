Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209BC2D64A4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403993AbgLJSPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 13:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404038AbgLJSOm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 13:14:42 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF8C0613D6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 10:14:02 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w3so5751373otp.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYa3QwHjcr9KvgYh2cWR2ObRxXNVCxcMJKU5e9f8sD8=;
        b=numcK5p0fC6i0qHz1HrhREaD7+WeZR49j5Ld8oazdIWYJjGMor8RpCWz6WEkvH0SS+
         UlJYu/zIOO+mGE3A2M3CsowAbX/TuO3db5uEQkhqW1AIzEQlhcn0NLDHs0f1QYGqjWO6
         s4pU9wOxBze02RZqscoOgYQ1YRCTvJMyALiqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYa3QwHjcr9KvgYh2cWR2ObRxXNVCxcMJKU5e9f8sD8=;
        b=re3rfntV84BLnOwE42t0NH2Nl1ybxoZvJqaLb4DZ+VTijww3V79Ah+kTWkd2sVBYjg
         vdP6Dwn/xOyIbIv9dpXe3mB7M7oKF9KJnqGGx1nlHWrbhub1P3tZu8Z8g3YUBk1tmJtE
         5u4acJflW3QynmuQ59WKMfq+5R6I+brMQ2wGP27KyO8cANYrIFJfnJ+h05xehf8JhzPG
         RaG5u8fVuUd+nFmhfqSeoz8nFM+jY3IKRXDKpDhBZyPB4K557TkQPv0cKkYm6Ho+Vq4+
         5bDxlwbeI7ebRnaV5OYBzwJhFiaFaUZqefKYlJ6dkT1Wt3kyXLUX5ZGhh8osjNShhE1Q
         ltVA==
X-Gm-Message-State: AOAM530YxT0eNTutIXGaqjxEQk8dtwAVAY4gwEWsjT5sT0tEfJRwq1I8
        s9+OQRE+BDx+4rlAcileke8WzRCPzp1KKA==
X-Google-Smtp-Source: ABdhPJwSpcn8QOX4k4phhQjuCyGIGuuRZkW0pCDbVVrFZwCtTO0pec8tPuCAEbzrjIv7cQHgRH/f4Q==
X-Received: by 2002:a05:6830:191:: with SMTP id q17mr6426029ota.57.1607624040503;
        Thu, 10 Dec 2020 10:14:00 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id 63sm542538otx.2.2020.12.10.10.13.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 10:13:58 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id w124so3619997oia.6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 10:13:58 -0800 (PST)
X-Received: by 2002:aca:6502:: with SMTP id m2mr6058702oim.105.1607624038142;
 Thu, 10 Dec 2020 10:13:58 -0800 (PST)
MIME-Version: 1.0
References: <1607612975-5756-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1607612975-5756-1-git-send-email-pillair@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Dec 2020 10:13:46 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
Message-ID: <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Remove voltage regulator votes during wifi disable
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>, kuabhs@chromium.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 10, 2020 at 7:09 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1045,14 +1085,18 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>         ret = ath10k_snoc_init_pipes(ar);
>         if (ret) {
>                 ath10k_err(ar, "failed to initialize CE: %d\n", ret);
> -               goto err_wlan_enable;
> +               goto err_free_rri;
>         }
>
>         return 0;
>
> -err_wlan_enable:
> +err_free_rri:
> +       ath10k_ce_free_rri(ar);

This change in the error path seems to be an unrelated (but correct)
fix. It deserves its own patch, I think.

Brian

>         ath10k_snoc_wlan_disable(ar);
>
> +err_hw_power_off:
> +       ath10k_hw_power_off(ar);
> +
>         return ret;
>  }
>
