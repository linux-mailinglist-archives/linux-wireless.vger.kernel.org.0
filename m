Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4439922CE2A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXSv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXSv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 14:51:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666CC0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 11:51:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so4491321edv.13
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkqq/dTM1kv52hgARYE8pT8P7uaOvtiVtByu83nhzdU=;
        b=EP1pTUiDlNYO4WlDComc33qBRO/UcxpuLKFpZZ/5ioXdt6K2PFABeE7pTE3TYu5lV/
         WOgeCT3eFHheC2Ce38LB2S3cn6WMuld9PV20Bj1Lw1wLiNZEcnmuCVcs2J2M7nnoN3aw
         z5x54Odum5U8P4bi3ekmdR+3K24ytjQTCxIZmZTFqg3GEqJi1q8i8QUL/paF2BP/pUoz
         9CTM1S0S6FJY6Qk1FG4SsbjlnI3FP+78TCaRyn9HoxvLRBSkgrj/THvn9E2h+TgtbTFW
         iXXtaQtu7W8gMDGFTDrUs9fSE49HruNDhuvTKASRks484rBjnKDlxEK7ERjHVCNE0h0r
         GXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkqq/dTM1kv52hgARYE8pT8P7uaOvtiVtByu83nhzdU=;
        b=YBn9UHpFeeQbzYMVj6PC0z5xRhrXnW+H/H66ZMDOECvgPlFSHBNlA3SNjMDYXMhw1d
         33sstmQzi1SchVq3rQ6g407NIuPXySw7DAN+vH0J2vyjVwSxJypcT+KlHI2iBy+CPL3J
         7ha4ATdOjwQ33Vsq3w924ytYW5IrQT+riyjMTouk3wNwr5y4KfIEP9CyyKV9fHYuQRkF
         Sm5quf1tJi0DjUDnvarPMGifZ1Pbq5k3wNIRCzuilZvhMBIJM75LLC/a/N2sG/XnajDR
         QaRHObWrSnRHFLqp775E5/ZEgp6ezVHNvpM8taF5IgiL7LkK35nik+Jn+X4J5+LT+/99
         5frA==
X-Gm-Message-State: AOAM532rjf5JfVo+mi7L8fgbLtv/mlR1X+4RUqgdiVP6EWHw5m/6Wejh
        qoA8ZO3OXHbLFAg7tM5H234QqDZQ3kXxSBlu7OY=
X-Google-Smtp-Source: ABdhPJwEket0rQUzWml+3ZLvXlMyaOJyn9ThaWOuWoNc2gW7CWrVkuSNuXEmS47Xy7fxp68xocl4ioTpGcPrtzYBcrI=
X-Received: by 2002:a05:6402:12d0:: with SMTP id k16mr3425104edx.199.1595616685294;
 Fri, 24 Jul 2020 11:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
 <CA+Kvs9mV39gndidkDjMHswQGii74MH4cTDr9az1HLNOtW6PZTA@mail.gmail.com> <CAMZdPi8jgoYsWd6d90WE-sGD8P5LMKO+YAHoP5-xRBV+vncy=A@mail.gmail.com>
In-Reply-To: <CAMZdPi8jgoYsWd6d90WE-sGD8P5LMKO+YAHoP5-xRBV+vncy=A@mail.gmail.com>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Fri, 24 Jul 2020 21:51:14 +0300
Message-ID: <CA+Kvs9=0mJ4-6bZUkB3EG-R6ju8UrwJWo3_6aRxzn1tnrGiq-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] wcn36xx misc fixes
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 24, 2020 at 4:57 PM Loic Poulain <loic.poulain@linaro.org> wrote:
>
> Hi Ramon,
>
> On Fri, 24 Jul 2020 at 15:47, Ramon Fried <ramon.fried@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org> wrote:
> > >
> > > This series contains various fixes for the wcn36xx driver.
> > > This has been tested with wcn3620, wcn3660 and wcn3680.
> > >
> > > v2: - Move TX retries change into its own commit
> > >     - Additional patch for sequence number assignment
> > >     - Reword TX ack commit log (timeout detection)
> > >     - Fix checkpatch issues reported by Bryan
> > >
> > > Loic Poulain (6):
> > >   wcn36xx: Fix multiple AMPDU sessions support
> > >   wcn36xx: Add TX ack support
> > >   wcn36xx: Increase number of TX retries
> > >   wcn36xx: Fix TX data path
> > >   wcn36xx: Fix software-driven scan
> > >   wcn36xx: Use sequence number allocated by mac80211
> > >
> > >  drivers/net/wireless/ath/wcn36xx/dxe.c     |  57 +++++++++-
> > >  drivers/net/wireless/ath/wcn36xx/main.c    | 172 +++++++++++++++--------------
> > >  drivers/net/wireless/ath/wcn36xx/smd.c     |  59 ++++++++--
> > >  drivers/net/wireless/ath/wcn36xx/smd.h     |  12 +-
> > >  drivers/net/wireless/ath/wcn36xx/txrx.c    |  57 ++++++----
> > >  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   7 +-
> > >  6 files changed, 241 insertions(+), 123 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > wcn36xx mailing list
> > > wcn36xx@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/wcn36xx
> >
> >
> > Hi Loic,
> > What about upstreaming the fixes for several TP-Link AP's ?
> > The WCN36xx is not usable on those networks and your own tree patches seems to
> > be working properly.
>
> Which ones do you have in mind?
I didn't inspect each patch, I just took your tree and everything now
works as expected on  my TP-Link setup.
I did notice this patch -   "wcn36xx: Fix power-saving with some APs"
that was missing.
And there are some patches in your tree that hack the mac802111 core,
Do you think there's a way to upstream those ?

Thanks,
Ramon.


> This series normally contains the most important (and clean) patches.
>
> Cheers,
> Loic
