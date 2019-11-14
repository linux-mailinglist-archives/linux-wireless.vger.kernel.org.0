Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825D2FC9C6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfKNPVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:21:22 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45717 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKNPVW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:21:22 -0500
Received: by mail-vs1-f66.google.com with SMTP id n9so4082813vsa.12
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTj31BsHt77pizQHfqTXcG4Y8Xqz7vH9lp04XnwoX3Y=;
        b=kMF2SGDqPqEyc4bWjv3jPz9VdcJgEbLrQpHazCmkk0/sHjASd7K28ntsBujBJlG2vR
         pEFdJGa4JYiI8L23DcMG7UpifvZr9Id3qyiD4Es6ZeyRlVPMPZvL+/6mcBcBCCUYf4Gh
         BU3X6ZKlpDAmTmJaMUguZ35VD9ExfS8kLBjn4crjaDHAxoYMylGIRnhj3pxQR69tflNX
         hjz4j9p70Po8DwuJbe7yWQt5YjQlH8GTLRPtz3Z1dm/amd8LKk/b8EFw4CO/W2LB9nhP
         DaagLnoD6IeMhck5J8S02M193rYvKzgz51GAL5e7FxAbjGbJxTnsDb6okXXOHGkPCQTe
         BHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTj31BsHt77pizQHfqTXcG4Y8Xqz7vH9lp04XnwoX3Y=;
        b=eSA2FFB+Y6bzBHr/9C7Be9VWyGaYoBHUy7vCH0ezEq6ZebVfGbwygy/z/3nGX5rkI1
         nM6wio11qIoEeQG422gk5MrCViCEnyYNW8szg9sDjCBcnsnKAZmb9f0TRuHO3A4YNDgk
         D1gAQNgtsaZ/WWYqSwEj+fXTekc48Hf7cKmAILFPS6jlBqtThALaHd6Ziy8qphN+LEvs
         9b1sJ/ZTuAyBWHaXPjxCvA+PYd5fxObsNxOskv2kTyWmFDokOzthPyrDDgAoT6ThrptJ
         IekYrJyvkt/RUjl4N7IxmoEEluDKaqig07dAeNlcB3sWsObTMN6oppNwdBk8YB2LXMet
         k5Lg==
X-Gm-Message-State: APjAAAXk5rYGnUBmLs+rBJlcjUqK+Gaan5lPE/Mb+pOzenmwvFS+V/Vr
        6s68fdMhXiHCLgaeM1Vhf9u7aVJxk6UDkuCBaNmTdQ==
X-Google-Smtp-Source: APXvYqxiuvpRYMsGYY6NuJLDwUZLkTNqUqEcN0OQx17Yoi7RMRREZpQQticclmMj8odDs6Qd3B1VL7irV7+oTA8d4+g=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr6254116vsa.34.1573744880931;
 Thu, 14 Nov 2019 07:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20191112124021.8718-1-ulf.hansson@linaro.org> <20191112124021.8718-2-ulf.hansson@linaro.org>
 <87zhgybids.fsf@tynnyri.adurom.net>
In-Reply-To: <87zhgybids.fsf@tynnyri.adurom.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 16:20:44 +0100
Message-ID: <CAPDyKFrjEcsGKOwtRtns4a3dWExTvpbe2_16Gp9rwwxGbxynAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mwifiex: Re-work support for SDIO HW reset
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 14 Nov 2019 at 16:13, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> > when the SDIO card is shared with another SDIO func driver. This is the
> > case when the Bluetooth btmrvl driver is being used in combination with
> > mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> > the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> > point, the btmrvl driver will fail to communicate with the SDIO card.
> >
> > This is a generic problem for SDIO func drivers sharing an SDIO card, which
> > are about to be addressed in subsequent changes to the mmc core and the
> > mmc_hw_reset() interface. In principle, these changes means the
> > mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> > the SDIO card, as to indicate to the caller that the reset needed to be
> > scheduled asynchronously through a hotplug mechanism of the SDIO card.
> >
> > Let's prepare the mwifiex driver to support the upcoming new behaviour of
> > mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> > support the asynchronous SDIO HW reset path. This also means, we need to
> > allow the ->remove() callback to run, without waiting for the FW to be
> > loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> > called when a reset has been scheduled, but waiting to be executed. In this
> > scenario let's simply return -EBUSY to abort the suspend process, as to
> > allow the reset to be completed first.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Look good to me. Ulf, I assume you are going to take this so here's my
> ack:
>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

Thanks, I have queued it via my tree this time.

Kind regards
Uffe
