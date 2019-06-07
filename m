Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A720393EE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfFGSGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 14:06:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40759 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbfFGSGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 14:06:30 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so3055173itc.5
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLehMSYkK3XfUc0NYuOTQwZFYDyQEwqS9DQD1R1eHAk=;
        b=Htkn/o8Z18DC5jDpDQXQDKkSRSOkZr8DK1ynqG68Nsu83En9ojGIOff8TmkqZBRGpK
         CQjm63dpKUi/As2mwytCiEIv2F3dYXc/C26x5ekX0J67olxPg0C/uU6Azrdhx5oMfivO
         ANn2R3YckbO8MIPG6fFFFz7JF7EApgtYNH71E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLehMSYkK3XfUc0NYuOTQwZFYDyQEwqS9DQD1R1eHAk=;
        b=iE2cTD5o12vD+Imkz6F4BzkecP5DYYBnKYsNKN3RpfqGeJygyVOAu4luJN2mVSkF5X
         zyxITKeenmEAXhDfXNkZIAHZABAXVxYzIbFpsorkg/DYPwbsrazZT9JwTXvU7N4vjG2Z
         FI6hB+K80lIP/MA5ITJsootRG7yFh8mb3xnF/g88z5SayZPfvd0lsSVLTP8HBwXHUwfO
         B2AxIs7Fc9CynVLBd5im4ggqN+DVGvpX1mXxL6uRq8nAdbc4gImygz4/t1MbTj9U0OWC
         wQVATFSXKbQynEgmuSz16F+H9gVYhawOD+/YxeqyXVgHKReAvDGdGPO4bR/mUSZKDM8u
         UgsQ==
X-Gm-Message-State: APjAAAWV70mSEgGSwuFdAECY6Q0L+iWAdKZKupx4y/tiJP3GmxByYsMQ
        du3+dhMAw1O4WBlaHK1Gx6g+bKITCF0=
X-Google-Smtp-Source: APXvYqyvbxTIvBlBZMGhGL6Rt7zgzjYLBa3WLyMRpqf4EyvexuDaWfPGBTdLRkLzx5fIu2NgeTAn3g==
X-Received: by 2002:a05:660c:48b:: with SMTP id a11mr5368194itk.11.1559930789467;
        Fri, 07 Jun 2019 11:06:29 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id n17sm778030iog.63.2019.06.07.11.06.28
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:06:28 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r185so2098940iod.6
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 11:06:28 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr872549iop.168.1559930787784;
 Fri, 07 Jun 2019 11:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org> <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
 <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
 <16b305a7110.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <ff0e7b7a-6a58-8bec-b182-944a8b64236d@intel.com> <16b3223dea0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <16b3223dea0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jun 2019 11:06:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XVmCYWe9rtTFakq8yu67R-97EPyAHWck+o3dRXzHCchQ@mail.gmail.com>
Message-ID: <CAD=FV=XVmCYWe9rtTFakq8yu67R-97EPyAHWck+o3dRXzHCchQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 7, 2019 at 6:32 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 7, 2019 2:40:04 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> > On 7/06/19 8:12 AM, Arend Van Spriel wrote:
> >> On June 6, 2019 11:37:22 PM Doug Anderson <dianders@chromium.org> wrote:
> >>>
> >>> In the case of dw_mmc, which I'm most familiar with, we don't have any
> >>> sort of automated or timed-based retuning.  ...so we'll only re-tune
> >>> when we see the CRC error.  If I'm understanding things correctly then
> >>> that for dw_mmc my solution and yours behave the same.  That means the
> >>> difference is how we deal with other retuning requests, either ones
> >>> that come about because of an interrupt that the host controller
> >>> provided or because of a timer.  Did I get that right?
> >>
> >> Right.
> >>
> >>> ...and I guess the reason we have to deal specially with these cases
> >>> is because any time that SDIO card is "sleeping" we don't want to
> >>> retune because it won't work.  Right?  NOTE: the solution that would
> >>> come to my mind first to solve this would be to hold the retuning for
> >>> the whole time that the card was sleeping and then release it once the
> >>> card was awake again.  ...but I guess we don't truly need to do that
> >>> because tuning only happens as a side effect of sending a command to
> >>> the card and the only command we send to the card is the "wake up"
> >>> command.  That's why your solution to hold tuning while sending the
> >>> "wake up" command works, right?
> >>
> >> Yup.
> >>
> >>> ---
> >>>
> >>> OK, so assuming all the above is correct, I feel like we're actually
> >>> solving two problems and in fact I believe we actually need both our
> >>> approaches to solve everything correctly.  With just your patch in
> >>> place there's a problem because we will clobber any external retuning
> >>> requests that happened while we were waking up the card.  AKA, imagine
> >>> this:
> >>>
> >>> A) brcmf_sdio_kso_control(on=True) gets called; need_retune starts as 0
> >>>
> >>> B) We call sdio_retune_hold_now()
> >>>
> >>> C) A retuning timer goes off or the SD Host controller tells us to retune
> >>>
> >>> D) We get to the end of brcmf_sdio_kso_control() and clear the "retune
> >>> needed" since need_retune was 0 at the start.
> >>>
> >>> ...so we dropped the retuning request from C), right?
> >>>
> >>>
> >>> What we truly need is:
> >>>
> >>> 1. CRC errors shouldn't trigger a retuning request when we're in
> >>> brcmf_sdio_kso_control()
> >>>
> >>> 2. A separate patch that holds any retuning requests while the SDIO
> >>> card is off.  This patch _shouldn't_ do any clearing of retuning
> >>> requests, just defer them.
> >>>
> >>>
> >>> Does that make sense to you?  If so, I can try to code it up...
> >>
> >> FWIW it does make sense to me. However, I am still not sure if our sdio
> >> hardware supports retuning. Have to track down an asic designer who can tell
> >> or dive into vhdl myself.
> >
> > The card supports re-tuning if is handles CMD19, which it does.  It is not
> > the card that does any tuning, only the host.  The card just helps by
> > providing a known data pattern in response to CMD19.  It can be that a card
> > provides good enough signals that the host should not need to re-tune.  I
> > don't know if that can be affected by the board design though.
>
> Right. I know it supports initial tuning, but I'm not sure about subsequent
> retuning initiated by the host controller.

My evidence says that it supports subsequent tuning.  In fact, without
this series my logs would be filled with:

  dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to XYZ

...where the phase varied by a few degrees each time.  AKA: it was
retuning over and over again and getting sane results which implies
that the tuning was working just fine.

The whole point of this series is not that the retuning was actually
broken or anything it was just pointless and blocking the bus while it
happened.  On rk3288 dw_mmc ports we also currently do pretty
extensive tuning, trying _lots_ of phases.  Thus the re-tuning was
blocking the bus for a significant amount of time.

-Doug
