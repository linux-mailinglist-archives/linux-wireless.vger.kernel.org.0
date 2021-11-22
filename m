Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800B6459171
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 16:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhKVPfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhKVPfw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 10:35:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C32C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 07:32:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso227306pjb.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWDyTNcT8WcAnoe7soRCvrakCJQbX9U0rVhDBNYZFS0=;
        b=L7xZgki9KnfvpXp3Xlc5sQjykUZuZ5AUQVeHU/0YwM621agJI2xh5dUjuBAV/R/ro1
         yLFvseX6nBZbgHUcLo7OpKd9PboSM/HBwJTICn2TNu+338QSg7fBuNlp89xs+CDp0eUV
         LK1OVwqGJcFWvbPOtOhtc4fRD8f6ldCTvjRS4m5msHsTEFQ/mOp65yNXyjvX3aN9oACc
         NR25izJgurQhk23RQZ41Ajd9GKEJ4bkaPWeP4dDxH73py5iUtdDrG+WwY5obmfzST32l
         0S7y2Yv41oEq9wLZ3mmDhOfg/dLFKr8p3dFi8OyeiuMJ8lb4WSa3NGasI0vNz6RVX45P
         XrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWDyTNcT8WcAnoe7soRCvrakCJQbX9U0rVhDBNYZFS0=;
        b=akQQx1mmmr7q/ZgJSTDz+0DUonR3rk/BSEU3zOrdhpQlCObhrmSAHrnoJOJosdMlyT
         mxoqRG4AIOrlTYxUe2XeCKdmysMcHW2y8kfYZMG1WqzpWRCD1G8wsDRfDHnASgVTNnbT
         s1L/fuFF3EuMZUk+uqkI2BnSciF+L0y6CfxrBarI51NHN+NSbm0n+SseFUj8jZ1C4Rlj
         uAdT91pjOnqzwX9uB3CFHgUYB+bAkuuyv/lA6lJYA+tii9Pz9FIg7e4C556O2ru6oTZK
         r46JE2JSWy/zX3MrSq8GP8zIV+oU9P08VtxU+Yrg18RFQlVXpp07jP2wbIOIN7G/h2Y+
         /CcQ==
X-Gm-Message-State: AOAM530gfKfc78ZgpaIbW68IEkFpqIrT9yaHYK4o+QTQBiSAI/b/iNFc
        qCPLka7cYklqA4jCssqj4ex7Qi7a6lZ2zbkPcXek+A==
X-Google-Smtp-Source: ABdhPJzgjjFdn6NeBAtc63d+u475nCuSVIfDh44bvv49KZ3cQXrQH/1jhCXc6kFZp/v6Zb1HiLM2CbANsouBmo0eA1E=
X-Received: by 2002:a17:90b:4d0c:: with SMTP id mw12mr32328085pjb.209.1637595165959;
 Mon, 22 Nov 2021 07:32:45 -0800 (PST)
MIME-Version: 1.0
References: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org>
 <8735nobgje.fsf@codeaurora.org> <CAMZdPi9xWdJU_-k9mJxTkeyctsEmNCuzvBpdR-FMg=onEim+9w@mail.gmail.com>
 <87sfvo8e1a.fsf@codeaurora.org>
In-Reply-To: <87sfvo8e1a.fsf@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 22 Nov 2021 16:43:21 +0100
Message-ID: <CAMZdPi-exG5vtm0qMPptK_NcRiHN3A3T9jExM9Qu=bE-GS91hA@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Configure keep-alive packet on suspend
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 22 Nov 2021 at 15:23, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Loic Poulain <loic.poulain@linaro.org> writes:
>
> > Hi Kalle,
> >
> > On Mon, 22 Nov 2021 at 12:01, Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Loic Poulain <loic.poulain@linaro.org> writes:
> >>
> >> > When system enter suspend, there is no more wireless traffic, and
> >> > if there is no incoming data, most of the AP kick-out the client
> >> > station after few minutes because of inactivity.
> >> >
> >> > The usual way to prevent this is to submit a Null function frame
> >> > periodically as a keep-alive. This is supported by brcm controllers
> >> > and can be configured via the mkeep_alive IOVAR.
> >>
> >> This is with brcmfmac in client mode, right?
> >
> > Right, it's in client mode.
> >
> >> Wouldn't it make more sense to disconnect entirely during suspend?
> >> Nobody is processing the data packets anyway during suspend.
> >
> > Disconnect is performed automatically when wowlan is not enabled,
> > otherwise we may want to wake-up on events (disconnect,
> > 4-way-handshake) or data packets (magic, unicast, etc...). Some
> > devices use suspend aggressively such as Android in which the network
> > link is expected to be maintained.
>
> Sure, for wowlan it makes sense but you didn't mention that in the
> commit log so I assumed that was disabled.

Ah right, I'll do that in V2.

Thanks,
Loic
