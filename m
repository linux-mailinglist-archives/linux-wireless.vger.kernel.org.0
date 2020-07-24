Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1222C727
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXN5g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXN5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 09:57:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F8C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:57:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so10057648ejj.10
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HB2qltvpMXavYMM47PrePo5qw8dMCAncv255k3sfu9I=;
        b=EqLp7Q2iQVYcvtcgKokoXU5NTQ8tKfRPo1CuAnXxAjUB59bucXNlBwfheka60mlHja
         fB0Y2y6qlMhfE669b4cqyXzq+2yYFLtJT75PORSsMZ+RnjITjPxy+f1vQP8+FGMCWcjC
         V++c4K19kf0OnfnQHve8r0SoWQGY0mztKiU4STYt+yKF66GZMfWbOgEkE943IlXBvdeI
         qDSdWqxsmdUHGPZOc87IsAI7BjOpuz9gv8ISaQSQn5CT0owRcKQ3AZg6uO9Eb9c7Vb6F
         trrmFc4fphr1+dhI2Xg8y24sxFfmB7hQ969yqmT5nS1U6Kww/2Ix8ZbttiUah1kvQPvw
         dWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB2qltvpMXavYMM47PrePo5qw8dMCAncv255k3sfu9I=;
        b=kh/D3dDaQNNbaJorw9IrFXWQzzjaG9Chf8AFCxLzLj2xYbxTx8vF1X3HLA0zbI4Rk3
         OQUaT97wGTLqf/eu82AlrNybnOimajSGjyLfY+8KTigFtrNOHMFYx5cPaGQv525r39Eq
         SfUQIh2Np1VBi65aFkDvCXgGWHN+NKJsKrrS4/c8390j/m1sdxncPCFN57wy4SYg4PK+
         U/BmdvwvqST+3PDJnTy83wrPVsDYiT+ioVipmNpYK1XpcR8tWZIKCBX8IK1gHmuRMlWM
         5OygoULCaRBExQz/LTFmWCt8yxlAZSSCdFFxiaWZJ1f50duXJXIqZsrqrjTr01A0/Nx+
         eS5w==
X-Gm-Message-State: AOAM53141WbXO1KkmQiin5a49q8RbPvdCEr/GjbNxsKf7QJAy6BL4x/Y
        4VQIdeBrqFwJY3yIkpae5cat/6Ot5NrZ3Myz+Vcjjw==
X-Google-Smtp-Source: ABdhPJymIMUoqRqbU7Hg7UN5ICPLU4V850t7MzRw0xWn07dKnQv0o39HRPB0GQG0L+nGTX39LzGCBZBVWCssFFUDK98=
X-Received: by 2002:a17:906:2799:: with SMTP id j25mr530308ejc.466.1595599053263;
 Fri, 24 Jul 2020 06:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org> <CA+Kvs9mV39gndidkDjMHswQGii74MH4cTDr9az1HLNOtW6PZTA@mail.gmail.com>
In-Reply-To: <CA+Kvs9mV39gndidkDjMHswQGii74MH4cTDr9az1HLNOtW6PZTA@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 24 Jul 2020 16:02:24 +0200
Message-ID: <CAMZdPi8jgoYsWd6d90WE-sGD8P5LMKO+YAHoP5-xRBV+vncy=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] wcn36xx misc fixes
To:     Ramon Fried <ramon.fried@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ramon,

On Fri, 24 Jul 2020 at 15:47, Ramon Fried <ramon.fried@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > This series contains various fixes for the wcn36xx driver.
> > This has been tested with wcn3620, wcn3660 and wcn3680.
> >
> > v2: - Move TX retries change into its own commit
> >     - Additional patch for sequence number assignment
> >     - Reword TX ack commit log (timeout detection)
> >     - Fix checkpatch issues reported by Bryan
> >
> > Loic Poulain (6):
> >   wcn36xx: Fix multiple AMPDU sessions support
> >   wcn36xx: Add TX ack support
> >   wcn36xx: Increase number of TX retries
> >   wcn36xx: Fix TX data path
> >   wcn36xx: Fix software-driven scan
> >   wcn36xx: Use sequence number allocated by mac80211
> >
> >  drivers/net/wireless/ath/wcn36xx/dxe.c     |  57 +++++++++-
> >  drivers/net/wireless/ath/wcn36xx/main.c    | 172 +++++++++++++++--------------
> >  drivers/net/wireless/ath/wcn36xx/smd.c     |  59 ++++++++--
> >  drivers/net/wireless/ath/wcn36xx/smd.h     |  12 +-
> >  drivers/net/wireless/ath/wcn36xx/txrx.c    |  57 ++++++----
> >  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   7 +-
> >  6 files changed, 241 insertions(+), 123 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > wcn36xx mailing list
> > wcn36xx@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/wcn36xx
>
>
> Hi Loic,
> What about upstreaming the fixes for several TP-Link AP's ?
> The WCN36xx is not usable on those networks and your own tree patches seems to
> be working properly.

Which ones do you have in mind?
This series normally contains the most important (and clean) patches.

Cheers,
Loic
