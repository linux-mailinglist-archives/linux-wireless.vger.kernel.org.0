Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27220D6C3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgF2TXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgF2TWo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:44 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4955C02E2F8
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 07:33:33 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id v26so770220vkn.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNkvAElAdlylwMX22qVeO6w3DffRcKTQ6SjWLKbis1A=;
        b=flWt2co8UrsGAn5eM02MB8ewGt+er7i6cSZMso4fN8Fq6W1kWGiTyiiCwMe3Y9kVcr
         o+jJR0GQp8fWNAU8gkgJ7rGcfEMIpoyg3d1Cfas9VtcRMa9pJIE3zkVz+qW3GOh4y1VQ
         tz4wtTIW837O3y69hcCAC0FmgG92kdYfWdPf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNkvAElAdlylwMX22qVeO6w3DffRcKTQ6SjWLKbis1A=;
        b=ba5tu9BlMED2IznQmRJ8NglT9HlauB38RH6pBOhOqnDJxi4ZM1rdw4H9ch/dOZB3FL
         tuO4nRhkb6de1M8l5sZ9yG8zncHaXRZ4LLLeFQMZNgszdJ+WGzH+EMFqd8geELQubZt7
         mqTSlwOjl6pnk8Wr2mHWE/KX3AFITAAlyuuzxdlDwC1sRGkHlym99kq6cBOosPvj49Ys
         fz6UcBVf0hB4IF+EtYFONfzWpBsDaX/QHZz+VXJDrUv3sX6pwfa5/9ZlBRZ7+CT/NFU4
         FhCPevn2FindykShs+9xl/my2ZWgk/vSd4d2aCGfF3fvL+zm3OV1WKF3nnWpQOFviUHy
         FoVg==
X-Gm-Message-State: AOAM53149H1VeE/HrJ+N4Ol6s0q9XU/vPFlcTqFYeZ7xBYCKJfiDc7W3
        4f1ZpfVMek6DCuqrFChDXPFLOtRMbu4=
X-Google-Smtp-Source: ABdhPJxi7Xssbs/aYxAsO559yB3hWZxYo45xrbIVV5clhvCY6uxvsGgEjPRQ7djewIaYfhEqHys1Ew==
X-Received: by 2002:a1f:a913:: with SMTP id s19mr10205024vke.13.1593441212685;
        Mon, 29 Jun 2020 07:33:32 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 140sm18950vkx.20.2020.06.29.07.33.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:33:31 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id b13so5389720uav.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 07:33:30 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr10886058uaq.120.1593441210383;
 Mon, 29 Jun 2020 07:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
 <1593194502-13164-3-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V1C2Lu31n8xQ8HPf21fNo_Da2SLtZAeStFBEou9+geEA@mail.gmail.com> <000301d64e0e$b9e32c70$2da98550$@codeaurora.org>
In-Reply-To: <000301d64e0e$b9e32c70$2da98550$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 07:33:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_qfbCQDy7DOn8VNQU+7yNn0cjS8YD232UFTXW3w3wrw@mail.gmail.com>
Message-ID: <CAD=FV=U_qfbCQDy7DOn8VNQU+7yNn0cjS8YD232UFTXW3w3wrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ath10k: Add support for chain1 regulator supply voting
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jun 29, 2020 at 5:14 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
>
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Saturday, June 27, 2020 3:22 AM
> > To: Rakesh Pillai <pillair@codeaurora.org>; Kalle Valo
> > <kvalo@codeaurora.org>
> > Cc: ath10k@lists.infradead.org; open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-wireless <linux-
> > wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 2/2] ath10k: Add support for chain1 regulator supply
> > voting
> >
> > Hi,
> >
> > On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
> > >
> > > Add support to vote for chain-1 voltage regulator
> > > in WCN3990.
> > >
> > > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> > >
> > > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > > ---
> > >  drivers/net/wireless/ath/ath10k/snoc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath10k/snoc.c
> > b/drivers/net/wireless/ath/ath10k/snoc.c
> > > index 645ed5f..407a074 100644
> > > --- a/drivers/net/wireless/ath/ath10k/snoc.c
> > > +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> > > @@ -45,6 +45,7 @@ static const char * const ath10k_regulators[] = {
> > >         "vdd-1.8-xo",
> > >         "vdd-1.3-rfa",
> > >         "vdd-3.3-ch0",
> > > +       "vdd-3.3-ch1",
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...with the slight nit that ${SUBJECT} and description should probably
> > call it "chan1" and not "chain1".  Presumably the maintainer can fix
> > when applying.
> >
> > -Doug
>
> Hi Doug,
>
> It has to be chain1 only, not chan1.
> This is the power supply rail for the wlan-chain1

Whoa, really?  "ch1" stands for "chain1", not "chan1"?  That is
seriously weird (at least to me), but I find at least one document
that agrees with you.  Sorry for the mistake!

-Doug
