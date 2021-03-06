Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B132FCE4
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhCFTww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFTww (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 14:52:52 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32060C06174A;
        Sat,  6 Mar 2021 11:52:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u8so5718772ior.13;
        Sat, 06 Mar 2021 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SawKOOyQ1vlNQC1p3tm3qvoltBI/YC72sSTNIxokIes=;
        b=RSkUOz4afLnlz1RpuQI0tsCd9wzFn9Idr/hX26vAJuvUS8+6mAT9d5Q6Bxx8/8ri5L
         hsP8fduT6SULhq+QI1iAiMwNrYPDY3Tg3+zrwliFO61CjAe5VvtXRhNyEkBogooD5KiZ
         E0BqexAbIfnO9hbrKdS+UKw1FbXgxzRGmQiGE8mff6ARMYW9C/EEJQ2k5Ktt+TZLt7vy
         lhUJRmDAuWb4aWqDmgQQTGg4rxIv9t0/DvQaJiybmcQm1L9gHCOXU7y1wIOwpdDE1oGu
         Lxf1/ZA5ETcZeCZqtmksW+plYm+MXBhaXqfBKKd9KketX7IDd4dmhFvi0xbZgdsDG3RH
         O2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SawKOOyQ1vlNQC1p3tm3qvoltBI/YC72sSTNIxokIes=;
        b=VgN5GTW9fHWOdQubiAyGn3qLHiwgINPkceItMAY1uaXB6zfmCDlyQs8Q1kcpYf+FNk
         oC8MSUhCSMqsr5in13fH8TC16+6kwwOSPLBFrSoGojReg62rvErEnfu7XloOcanD+EyQ
         LpzcHcKXDgCzBtAiPReTsK1NK7dAQZEOJUHIgBj0Bz2fQLdRjDR4YjSKEovhK4NGFNZf
         SipMbEC3lDJhvsMzkUFw6hofxVHwcoMR9HRWazYOuvdLACDXRlNw+PUf6vJhr2dY0hV7
         sn8HNRtkCVrRvYme1hKQ0oqAxeqtMWOapEx7IkbHOBHk7zdwOBHqlrd7L+MahjLRilR4
         2eIA==
X-Gm-Message-State: AOAM530W1uNoAvz3onUjurOLj01OdVqJjyt7jvrQt/9MSs9AzpbqSYc8
        nhSwA0AJfr0FXvv5yqxv6Xf7h58rmdgioyMmfd4=
X-Google-Smtp-Source: ABdhPJyPulR39aIriEXYRN4XtFJ+f7vz0iKwNH5W8sSipGC6cLH3SSrIFVhcUDy7uJBZA8vUzGJv6Z7v+tSo7HVHxJw=
X-Received: by 2002:a02:9a0a:: with SMTP id b10mr16014069jal.132.1615060371492;
 Sat, 06 Mar 2021 11:52:51 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 20:52:15 +0100
Message-ID: <CA+icZUVedsZzJ7qk4fgSZV37M6YUjnP=sfWFK9V9f0y0KpQ4tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iwlwifi: fix DVM build regression in 5.12-rc
To:     Hugh Dickins <hughd@google.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 6, 2021 at 8:48 PM Hugh Dickins <hughd@google.com> wrote:
>
> There is no iwl_so_trans_cfg if CONFIG_IWLDVM but not CONFIG_IWLMVM:
> move the CONFIG_IWLMVM guard up before the problematic SnJ workaround
> to fix the build breakage.
>
> Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
> Signed-off-by: Hugh Dickins <hughd@google.com>

See "iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM
is disabled" in [1].

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=62541e266703549550e77fd46138422dbdc881f1

> ---
>
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- 5.12-rc2/drivers/net/wireless/intel/iwlwifi/pcie/drv.c      2021-02-28 16:58:55.082425755 -0800
> +++ linux/drivers/net/wireless/intel/iwlwifi/pcie/drv.c 2021-03-05 18:42:53.650809293 -0800
> @@ -1106,6 +1106,7 @@ static int iwl_pci_probe(struct pci_dev
>                 }
>         }
>
> +#if IS_ENABLED(CONFIG_IWLMVM)
>         /*
>          * Workaround for problematic SnJ device: sometimes when
>          * certain RF modules are connected to SnJ, the device ID
> @@ -1116,7 +1117,6 @@ static int iwl_pci_probe(struct pci_dev
>         if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_SNJ)
>                 iwl_trans->trans_cfg = &iwl_so_trans_cfg;
>
> -#if IS_ENABLED(CONFIG_IWLMVM)
>         /*
>          * special-case 7265D, it has the same PCI IDs.
>          *
