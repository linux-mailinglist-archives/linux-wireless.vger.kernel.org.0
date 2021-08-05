Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD83E13F0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhHELf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbhHELf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:35:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA85C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 04:35:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so9053598ejz.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPxcG4+CwNlbnzANZW7VoHTJshHvntqkoSxrRT4OVfw=;
        b=g9GrgLS2YuPluJGvAoZ1l2cymERChCW/kwFTq8sToqmrvbUAnarD3N2IJ0eGvo6sGx
         ieaQ12aVGyBuUjpH1XGr0TBBEBcW8NIrEzR8O1xATpil6fkNAAiviW0Z9Q7ox93Z/XsT
         MxulU4qdZmYOffz20OGWJDg+vy5yVLsxEM+CDL4J6teZj/RC5FjLZ7tShchu45rDwjj+
         vgmb7GAYpR9IM3cUSQ14MdeAQ9itRfNGdfRV5Gy4yHx+7IiWJUQPOqcjxNDKQJoR8QAf
         UwCuhM2TAVKHKraM1qBCTuq4o77VM1imSbynumIzbDLQiCbb51FSQINVjgQZuT+c593E
         h4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPxcG4+CwNlbnzANZW7VoHTJshHvntqkoSxrRT4OVfw=;
        b=kt2n5KoRhlR4MZtmN1pKFKF8dOd5eXeDDIcqXY4L5OlRAGH76eT4KyAX9iKqSy4Wfe
         noqAqLQeFE6cuOSju0j7LD7EgFDGiimmTxc4uuLTOPnfMTe9Lt/P9lErislSv0KU7aqm
         iF7focGnRCRaaETws6oNwr3GrMSwLLKBjU+tw+ngX9ZQZl1gNKQQ3S2I1Woqju6CasV6
         32fPTIlQ0EK81d/qh8qr5yTwOgExKUBLd7j0+viY+1a/4Yh13hY2kSb/RBHhIM1whVm+
         90OW8dqLXZ5brjEBYt8B+eCHzalBrrLLMdli4GKIa7pI8BqyEdLb5NKccyJxgRFE+jE/
         p7hw==
X-Gm-Message-State: AOAM533YGT4qwhIwlvcHEN207r+qjUDMr94FhyVpyopagRrpYLNimta5
        h1mXk1My8UGvIO66EQNFdG3nshdOELO+yqyJAz4=
X-Google-Smtp-Source: ABdhPJwiNwCpUEm1qQ13WtAbbLzMjWLriMlxJypY5seHH+2gFR/hzxIxVYaRTvRb+Omgb2BHABjr2C8Zjo9qCUfEQ90=
X-Received: by 2002:a17:906:814:: with SMTP id e20mr4344298ejd.497.1628163312577;
 Thu, 05 Aug 2021 04:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210805093023.3465081-1-linus.walleij@linaro.org>
In-Reply-To: <20210805093023.3465081-1-linus.walleij@linaro.org>
From:   Arend van Spriel <aspriel@gmail.com>
Date:   Thu, 5 Aug 2021 13:35:03 +0200
Message-ID: <CAJ65rDx1ab8gBZRpnyp5kb__VVA+_Vy3VS-0xesYC_+VmEKchw@mail.gmail.com>
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 5, 2021 at 11:32 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
>
> Harden the firmware loading like this:
>
> - If we cannot build an alt_path (like if no board_type is
>   specified) just request the first firmware without any
>   suffix, like in the past.
>
> - If the lookup of a board specific firmware fails, we get
>   a NULL fw in the async callback, so just try again without
>   the alt_path. Use a context state variable to check that
>   we do not try this indefinitely.
>
> - Rename the brcm_fw_request_done to brcm_fw_request_done_first
>   reflecting the fact that this callback is only used for the
>   first (main) firmware file, and drop the unnecessary
>   prototype.

While implementing the firmware.c module at first I was doing every
firmware request with the 'nowait' variant hence the callback was used
repeatedly. However, I abandoned that as the reason for async request
was to avoid delay it may cause on kernel boot. Decoupling the initial
firmware request was sufficient for that and simplified things quite a
bit. As to the naming maybe 'brcmf_fw_async_request_done()' is a clear
alternative.

> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stefan Hansson <newbyte@disroot.org>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rename state variable to "tried_board_variant".
> ChangeLog v1->v2:
> - Instead of using a static variable, add a context variable
>   "tested_board_variant"
> - Collect Arend's review tag.
> - Collect Tested-by from Dmitry.
> ---
>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 31 +++++++++++++------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index adfdfc654b10..d32491fd74fe 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -428,11 +428,10 @@ struct brcmf_fw {
>         struct device *dev;
>         struct brcmf_fw_request *req;
>         u32 curpos;
> +       bool tried_board_variant;
>         void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
>  };
>
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
> -
>  #ifdef CONFIG_EFI
>  /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
>   * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
> @@ -638,11 +637,25 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>         return request_firmware(fw, cur->path, fwctx->dev);
>  }
>
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>  {
>         struct brcmf_fw *fwctx = ctx;
> +       struct brcmf_fw_item *first = &fwctx->req->items[0];
>         int ret;
>
> +       /* Something failed with the first firmware request, such as not
> +        * getting the per-board firmware. Retry this, now using the less
> +        * specific path for the first firmware item, i.e. without the board
> +        * suffix.
> +        */
> +       if (!fw && !fwctx->tried_board_variant) {
> +               fwctx->tried_board_variant = true;
> +               ret = request_firmware_nowait(THIS_MODULE, true, first->path,
> +                                             fwctx->dev, GFP_KERNEL, fwctx,
> +                                             brcmf_fw_request_done_first);
> +               return;
> +       }
> +

So here we could use the synchronous variant instead for the reason
explained earlier.

Regards,
Arend
