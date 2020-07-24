Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6D122C6FC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXNra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNra (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 09:47:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F7C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:47:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so10069833ejb.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKANxohSxQhtS+/apUsd1XmWmc+jEgIlVplz9gCMaDc=;
        b=nQai2VK1HCGAXRA2oSFCZ0cqrsOJbHlUrxSgkNqAWpT3cRR/GOLQIyWJWMfxcABVIj
         6ZfAHzZqRcNf7VDh/q7XuqcISdAuNH/FV2O5DYEhSz/VBe73c9qDQvodGOhqi6FkqpsF
         HDpyS3ijLORnHU/o4P5MCI0V6t84Jj6x0hp8e/0Y+tomD/P12q/wev5r6GK7FfzHmHDf
         7mF1oxrdTdD5onaQaJ6yGo8S0DqJizD8LvJnsFkoc6eJixKmouCYENzB3xwyzSPj5fnk
         5NcOWdKlhoYlwshvGsJKd5Dmxnx4HZM8Nh1FsRjSyLQ/baLFRLqozMAon+Uhqpgep8dH
         mOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKANxohSxQhtS+/apUsd1XmWmc+jEgIlVplz9gCMaDc=;
        b=XNfM1t+18pFsZyxPcoCD0TOIAxnDxNIY6RhGAvf3pgyuNmgkkVjjmM6FDZqbSqHBgV
         vKXKjRV7ktzxyq2OgaCkayQ8Q9FPbjSONv/5SoRK+qkQ2yE6uGXVBV4wzNTxtHOXKDTl
         gC0NwGz0YDrKdSCuOsFMMgu9eNYxxE6397/tCiQEiw6/JWlqa0WR3oBu/R6wXKgfjH26
         04OdSpwum6rHHuplxz1J8ttSnnVsxNH48KLX6aPxo7pnXxeAwOEmWSoQsAVY2nbXxaVm
         gEzmejIqQvL9XHZY+uq0RcwVMVwDmRukZMl13A8lBTRUPR8Uha+vyBRm1WGA6ksCHoiY
         vpYw==
X-Gm-Message-State: AOAM530zNCUn57q6HAYe0n6rKmIhhhXEwQnwOsnAombw5PTbkxXD3myh
        RtmjH/en3geFdIOMJJt2TIBkd6v76UDeXV3v0TQ=
X-Google-Smtp-Source: ABdhPJxWpHUOPPtVzYAqW6wCjLh/32AR8hzQtWJ9MZJNkOtrApFqdENJsYI8hKqIMFzCPLN85nzRIu2zCpoRxfXsOpk=
X-Received: by 2002:a17:907:4003:: with SMTP id nj3mr9058263ejb.278.1595598448609;
 Fri, 24 Jul 2020 06:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Fri, 24 Jul 2020 16:47:17 +0300
Message-ID: <CA+Kvs9mV39gndidkDjMHswQGii74MH4cTDr9az1HLNOtW6PZTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] wcn36xx misc fixes
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org> wrote:
>
> This series contains various fixes for the wcn36xx driver.
> This has been tested with wcn3620, wcn3660 and wcn3680.
>
> v2: - Move TX retries change into its own commit
>     - Additional patch for sequence number assignment
>     - Reword TX ack commit log (timeout detection)
>     - Fix checkpatch issues reported by Bryan
>
> Loic Poulain (6):
>   wcn36xx: Fix multiple AMPDU sessions support
>   wcn36xx: Add TX ack support
>   wcn36xx: Increase number of TX retries
>   wcn36xx: Fix TX data path
>   wcn36xx: Fix software-driven scan
>   wcn36xx: Use sequence number allocated by mac80211
>
>  drivers/net/wireless/ath/wcn36xx/dxe.c     |  57 +++++++++-
>  drivers/net/wireless/ath/wcn36xx/main.c    | 172 +++++++++++++++--------------
>  drivers/net/wireless/ath/wcn36xx/smd.c     |  59 ++++++++--
>  drivers/net/wireless/ath/wcn36xx/smd.h     |  12 +-
>  drivers/net/wireless/ath/wcn36xx/txrx.c    |  57 ++++++----
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   7 +-
>  6 files changed, 241 insertions(+), 123 deletions(-)
>
> --
> 2.7.4
>
>
> _______________________________________________
> wcn36xx mailing list
> wcn36xx@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wcn36xx


Hi Loic,
What about upstreaming the fixes for several TP-Link AP's ?
The WCN36xx is not usable on those networks and your own tree patches seems to
be working properly.

Thanks,
Ramon.

Acked-By: Ramon Fried <rfried.dev@gmail.com>
