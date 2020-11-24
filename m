Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70AE2C1A4C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 01:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKXA4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 19:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgKXA4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 19:56:54 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4782BC061A4E
        for <linux-wireless@vger.kernel.org>; Mon, 23 Nov 2020 16:56:54 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id 103so2978783uai.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Nov 2020 16:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWyEDzj+7SQMU3zDVzcHpnrchiKEujwuC1f3GM15MDw=;
        b=SAKUP9Pg2OzAX1K7q7Sj2o0s18AoPzgbz9KZLYXX2E+muvXO2twlU7gr4tlxRFbkpX
         reTk2LB4spalj0HQwGNDnQBEUwFa9DZgiMDDMhDfxQBP15M8QP3b+wBgO86m4xR3C71I
         LgbRqCHM2vlCwq1k4l/JygvoR4ic82ppJ+rus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWyEDzj+7SQMU3zDVzcHpnrchiKEujwuC1f3GM15MDw=;
        b=j0IGgtPCiHjo94qwsdBu4e2igrlkvrQyn/a2Tnqqp3qRo4wJHp1VevKHx5VuIvy4DL
         4OYaViMO0MvpAIWtIe1Pi6cFWXIBWeqfFk0IUV6Tq1H4irpSoGruLzgJvZTjgWRGq9lM
         6POuwwHwGf0t2+AX8Rd4Abh+CiwvWZczKqArWpV3tsIyM7/e0ler6TWkmKY+g0pVMHSD
         zeSOELPa/quu2Ka2ByCL8v14NWbsnR4QVwF8Y1e+EmKmP5u9FKRWdkt8LNuFbRKWJeoG
         eRmpfcAK1EBFPeWixrPAiPjKfwlOtaLatA5wm8pERR8A5W5CikIHR3WbjNctPvVKd0T0
         ixEw==
X-Gm-Message-State: AOAM531hhXORUyBZt3saHX9O7OoRvoPAQKpf53d+pk6megNZRzksiEvt
        4HVmE+vwr7xjOk9nZwqYzpcj42MYDDcuZw==
X-Google-Smtp-Source: ABdhPJzvv25PmOp0uxPKlIzBgBJjgednmZrErJ1upokRzjpDXTO8APiEtI/SnpiujwTiegNh2GzMYA==
X-Received: by 2002:ab0:274e:: with SMTP id c14mr1849167uap.109.1606179412910;
        Mon, 23 Nov 2020 16:56:52 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1sm1578616vke.21.2020.11.23.16.56.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 16:56:52 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id v8so9701176vso.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Nov 2020 16:56:51 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr2306134vsa.34.1606179411382;
 Mon, 23 Nov 2020 16:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20201112200906.991086-1-kuabhs@chromium.org> <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
In-Reply-To: <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Nov 2020 16:56:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com>
Message-ID: <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ath10k: add option for chip-id based BDF selection
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Nov 12, 2020 at 12:09 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> In some devices difference in chip-id should be enough to pick
> the right BDF. Add another support for chip-id based BDF selection.
> With this new option, ath10k supports 2 fallback options.
>
> The board name with chip-id as option looks as follows
> board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
> Tested-on: QCA6174 HW3.2 WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
> (no changes since v1)

I think you need to work on the method you're using to generate your
patches.  There are most definitely changes since v1.  You described
them in your cover letter (which you don't really need for a singleton
patch) instead of here.


> @@ -1438,12 +1439,17 @@ static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
>         }
>
>         if (ar->id.qmi_ids_valid) {
> -               if (with_variant && ar->id.bdf_ext[0] != '\0')
> +               if (with_additional_params && ar->id.bdf_ext[0] != '\0')
>                         scnprintf(name, name_len,
>                                   "bus=%s,qmi-board-id=%x,qmi-chip-id=%x%s",
>                                   ath10k_bus_str(ar->hif.bus),
>                                   ar->id.qmi_board_id, ar->id.qmi_chip_id,
>                                   variant);
> +               else if (with_additional_params)
> +                       scnprintf(name, name_len,
> +                                 "bus=%s,qmi-board-id=%x,qmi-chip-id=%x",
> +                                 ath10k_bus_str(ar->hif.bus),
> +                                 ar->id.qmi_board_id, ar->id.qmi_chip_id);

I believe this is exactly opposite of what Rakesh was requesting.
Specifically, he was trying to eliminate the extra scnprintf() but I
think he still agreed that it was a good idea to generate 3 different
strings.  I believe the proper diff to apply to v1 is:

https://crrev.com/c/255643

-Doug
