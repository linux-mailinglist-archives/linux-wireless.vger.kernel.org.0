Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA663D44
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfGIV0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 17:26:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40283 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIV0T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 17:26:19 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so122973iom.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZp2EA1uWuI2cCMBWCElkOzxAGzZZIpu6+eVMhVKNTo=;
        b=Wb0mr0smeI2S+YK0huBgJ4nHSzTmixun8WgmZZQeqIBbAmwdyQSNJL0D6EhbTD3TXi
         VNWEPT3tRWEpJPoT3V7ELnYpFadkamKkd7ZdfIvyXaw0M4T3RehL7yHyx4CTRX9UGKqh
         3CRWQJTOzH93oGmzTySTboEDszbvS874tRDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZp2EA1uWuI2cCMBWCElkOzxAGzZZIpu6+eVMhVKNTo=;
        b=XCVNbF6m3UC1mFmUAmYSK/QbJ+rLuv6G41BQgfqUaSyFjNqlfb1OO+m7UvHji0JDQO
         W3UnXcEHG6Lak6oS0mONzZ99HoH8I7RWPrPnKhT5EwGybgq6YRaXNw3PPzx+B+QskdJU
         o4nMQAaTSduL5PVz13V5T5x6LpQYNcJDJm6d7MNHGrADqQNt8D3hEVdOpLPc/IuVd4d+
         VtjR71knzgTAEO2sAfHmi1u21OYqeZNdG2rBoXFezI2lvJQRk6r0a+ksJ5P+MlAlDtHK
         pM9xPabuhV5NPqEiI8e+OF9lsOeBDiPoNuVyJLN3veOTmacoRi+kNaBZIIXvG+scfYA6
         Me4w==
X-Gm-Message-State: APjAAAWI9DhwQrPBJhljJsJ2AV976ghF//HMl+e39Ap93pyuo8KUV6Rt
        tHBFeWpyQ5NFaW+/C8RO5Dgmx8Apw7E=
X-Google-Smtp-Source: APXvYqysan00g/WRSBKIDTh6TRfZCFYl2regldRCM1//O27hHaHO6M/K47EQX4FOtUPI6RlFCmaB/Q==
X-Received: by 2002:a02:914c:: with SMTP id b12mr31501815jag.105.1562707578639;
        Tue, 09 Jul 2019 14:26:18 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id p63sm23078166iof.45.2019.07.09.14.26.17
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:26:18 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id s7so79205iob.11
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:26:17 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr2520003iok.52.1562707577690;
 Tue, 09 Jul 2019 14:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-6-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-6-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:26:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uss6B2nHPz_pQJFCXm2G=f_rpfqK6xVG1SCDHYb12jmw@mail.gmail.com>
Message-ID: <CAD=FV=Uss6B2nHPz_pQJFCXm2G=f_rpfqK6xVG1SCDHYb12jmw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: sdio: Don't re-initialize powered-on removable
 SDIO cards at resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It looks like the original idea behind always doing a re-initialization of
> a removable SDIO card during system resume in mmc_sdio_resume(), is to try
> to play safe to detect whether the card has been removed.
>
> However, this seems like a really a bad idea as it will most likely screw
> things up, especially when the card is expected to remain powered on during
> system suspend by the SDIO func driver.
>
> Let's fix this, simply by trusting that the detect work checks if the card
> is alive and inserted, which is being scheduled at the PM_POST_SUSPEND
> notification anyway.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I'm not sure if it's even worth mentioning since the device I tested
was rk3288-veyron (both WiFi variants) and we have a non-removable,
powered-in-suspend, wakeup-disabled card.  That means it isn't
affected at all by your change.  ...but I suppose I can at least
confirm that your change didn't break me if that's worth anything.
:-P

Tested-by: Douglas Anderson <dianders@chromium.org>

I would also say that, though I don't have any history here, your
patch seems reasonable to me.  So you can add a:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
