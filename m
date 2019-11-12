Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF73F9838
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLSFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 13:05:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40653 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLSFD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 13:05:03 -0500
Received: by mail-io1-f66.google.com with SMTP id p6so19722808iod.7
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOuQGT1YCvXuDYqFTJrdO5L+3bQ12BUaxUzUW1VfHCU=;
        b=aRumttPdMzm08LKuJNTTVVdNfdCUQD1jT22cNJyZ28nIai7e3ZaIlNeYYsZ4BvZk2u
         ArhaZ0EPhXOyH1UmKP6c107KYmGzfN9ekyBafFPy//NgBZKDUT7yi7e1q84ago6K5Pnc
         fwXfs/RzWxAXFB4mIVqfZ2T/JnzRrixOz14oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOuQGT1YCvXuDYqFTJrdO5L+3bQ12BUaxUzUW1VfHCU=;
        b=YXtiB+aYsHgPFbVmpWT/G8P54FGx+NIgNEs1kfV90T9TnnW9NybGXmzN9qwTAGxD63
         RRsQBd5GNGbB1dVMo7oqSAZpgvMScOTxjyIUKW2yRBR2UfNvhXYdvNKJNzgTsozXE1pL
         RdEf2OD+W+64rGWmU14bWvL7xFpmjGmbxMnZjH0lxp2KwCWrK0Qj8SzgLMzPkGKHkrkY
         S3Juntzx/NNU4BkLfkx2fnJJA3HrjMP+vVBwXZbEZkN59GmfdHECVydZYyX2z4+8CcO5
         l/yrzrPSOfj9j4K4AM+3afhvPnxUj4+6s3qd8ce1NOo+VUsDGVDf1LJOrNGmDAMI7wW5
         Fy0g==
X-Gm-Message-State: APjAAAVTT08NhMtTNzWL37NnMR/bZZhfLn+FrOrMJHGHv58MCKh+b2Qf
        pPOXhxda/Q/OA9hcUBgy/LOfs2FEKX0=
X-Google-Smtp-Source: APXvYqxoRNg3gnDB8Rwo3zWQTwR5QB2jp69mMtbHi8J3B1Q5Yt2aDv9drgsjbUDGE+z6Spn+hsei1g==
X-Received: by 2002:a02:878b:: with SMTP id t11mr31907105jai.20.1573581902265;
        Tue, 12 Nov 2019 10:05:02 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id z69sm2664862ilc.30.2019.11.12.10.05.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 10:05:01 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id q83so19770883iod.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 10:05:00 -0800 (PST)
X-Received: by 2002:a5e:9608:: with SMTP id a8mr1387619ioq.58.1573581900354;
 Tue, 12 Nov 2019 10:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-2-ulf.hansson@linaro.org> <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
 <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com>
In-Reply-To: <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Nov 2019 10:04:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VWdzqGY778SXZnC1YDyxc6EHPgRjkJ_2sOHrxHTams-w@mail.gmail.com>
Message-ID: <CAD=FV=VWdzqGY778SXZnC1YDyxc6EHPgRjkJ_2sOHrxHTams-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Nov 12, 2019 at 4:14 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > index 24c041dad9f6..2417c94c29c0 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
> > >                 return 0;
> > >         }
> > >
> > > +       if (!adapter->is_adapter_up)
> > > +               return -EBUSY;
> >
> > I'm moderately concerned that there might be cases where firmware
> > never got loaded but we could suspend/resume OK.  ...and now we never
> > will?  I'm not familiar enough with the code to know if this is a real
> > concern, so I guess we can do this and then see...
>
> There is a completion variable that is used to make sure the firmware
> is loaded, before the mwifiex driver runs ->suspend|remove(). This is
> needed, because during ->probe() the FW will be loaded asynchronously,
> hence both mwifiex_sdio_remove() and mwifiex_sdio_suspend(), may be
> called while waiting for the FW to be loaded.
>
> If a HW reset has been scheduled but not completed, which would be the
> case if mmc_hw_reset() gets called after mmc_pm_notify() with a
> PM_SUSPEND_PREPARE. This is because mmc_pm_notify() then disables the
> rescan work, but then re-kicks/enables it at PM_POST_SUSPEND (after
> the system has resumed).
>
> Returning -EBUSY, should allow the mmc rescan work to be completed
> when the system have resumed.
>
> Of course, one could also considering using pm_wakeup_event(), in case
> mmc_hw_reset() needed to schedule the reset, as to prevent the system
> for suspending for a small amount of time. As to make sure the rescan
> work, gets to run. But I am not sure that's needed here.

I was more worried that we could get into a state where we'd return
EBUSY forever, but I think I've convinced myself that this isn't
possible.  If we fail to load things then the adapter variable will be
freed anyway.


> Finally, if you want to verify that the above system suspend path
> works fine, you could change the call to "_mmc_detect_change(host, 0,
> false)" in mmc_sdio_hw_reset(), into "_mmc_detect_change(host,
> msecs_to_jiffies(30000), false)", in patch3.
>
> This should leave you a 30s window of where you can try to system
> suspend the platform, while also waiting for the scheduled reset to be
> completed.

It worked.

https://pastebin.com/NdsvAdE8
