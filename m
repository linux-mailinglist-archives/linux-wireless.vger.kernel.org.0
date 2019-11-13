Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FEFB313
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfKMPA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 10:00:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34884 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfKMPA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 10:00:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id k15so1545776vsp.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18QPHmOseXT+yzsFwAer/TbjlpYB5o9UBaAP9/d9pUE=;
        b=GLJS4YyNw1JPNotlqgFZOM8VcQAD3ZVZLhiii8V0hbXP94GlRKCJ469G3NMKdY7Pfr
         004DqpiT8ITxKKZLi/ucgwFHVeKqzTqlFZOGkvmbMONa/06MaWEUwGgNfWVJGvrzyAAO
         wctEGsJhuN2Lc2nam60lMoCYAgT1qRuRlrd7e3/kHV25RDeHAuy4TrHHQAwz8taGxYPQ
         2LVD/KhvvzufAex4I3xjLV07+LS+fbBxDPl+Oetc6ufjv0VmEkiMnR8+uDk6iIgdPm6/
         431d5rOvc5vMPSPCwawPYuJ6Oj07QdltIa2vu9X9Ckc6+OGAIDZ9opO+sJXFoor4joU2
         UV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18QPHmOseXT+yzsFwAer/TbjlpYB5o9UBaAP9/d9pUE=;
        b=KT+AM9zSH11Ep6bnzTPHN84D5JWhw5XLP3rhwCexJ8UaeY5iZQMuB8W7zMX1t++vsF
         waN4YK5pO/PejXwKhcUxHlK+9MMzVE0eFZy3JXuIkQFu/D+M+SDy5eFBr3MTFXT9aqNX
         YYlVK8gm6sfgDfh0KgQmXsd+pgQtNWYpxsgGjsjsNmlUGoFwn2vUZVp1uuQyVgvkzztz
         mbT7INStdc0IziuSOAFFHZaN8yNahXj2rFPZosdnzh0Y1s+O8X527VOth1RrE/gDNvTh
         SlteeOsqEdEAFuhHxFSWbUv4oPHmrEqEBkno7Y3Ee1P9TRlFWQ6/BXWDnWYqpJ1b5hZ1
         bzqw==
X-Gm-Message-State: APjAAAU9RLohm6U1SqWg+fW8iZDuLO4xYnu2mMPXxTkztzRij37QCIiN
        93g3Ps7UqN310qcIicAFBddxebI22aKjHnaswqjwfQ==
X-Google-Smtp-Source: APXvYqyuVsKw1hxxOrfbrro4rOldCyXuIdYgmON1Ze1BYkf6ZoLctTL/jjZGyEOVIodkjH/epFXAKbozJM7fdv7uNJ8=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr2230043vsa.34.1573657256572;
 Wed, 13 Nov 2019 07:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-2-ulf.hansson@linaro.org> <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
 <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com> <CAD=FV=VWdzqGY778SXZnC1YDyxc6EHPgRjkJ_2sOHrxHTams-w@mail.gmail.com>
In-Reply-To: <CAD=FV=VWdzqGY778SXZnC1YDyxc6EHPgRjkJ_2sOHrxHTams-w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Nov 2019 16:00:20 +0100
Message-ID: <CAPDyKFoz_RTC=PLbsGgOZi15uwqBT618zEjBzRZgvd3HFQPEWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
To:     Doug Anderson <dianders@chromium.org>
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

On Tue, 12 Nov 2019 at 19:05, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Nov 12, 2019 at 4:14 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > index 24c041dad9f6..2417c94c29c0 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
> > > >                 return 0;
> > > >         }
> > > >
> > > > +       if (!adapter->is_adapter_up)
> > > > +               return -EBUSY;
> > >
> > > I'm moderately concerned that there might be cases where firmware
> > > never got loaded but we could suspend/resume OK.  ...and now we never
> > > will?  I'm not familiar enough with the code to know if this is a real
> > > concern, so I guess we can do this and then see...
> >
> > There is a completion variable that is used to make sure the firmware
> > is loaded, before the mwifiex driver runs ->suspend|remove(). This is
> > needed, because during ->probe() the FW will be loaded asynchronously,
> > hence both mwifiex_sdio_remove() and mwifiex_sdio_suspend(), may be
> > called while waiting for the FW to be loaded.
> >
> > If a HW reset has been scheduled but not completed, which would be the
> > case if mmc_hw_reset() gets called after mmc_pm_notify() with a
> > PM_SUSPEND_PREPARE. This is because mmc_pm_notify() then disables the
> > rescan work, but then re-kicks/enables it at PM_POST_SUSPEND (after
> > the system has resumed).
> >
> > Returning -EBUSY, should allow the mmc rescan work to be completed
> > when the system have resumed.
> >
> > Of course, one could also considering using pm_wakeup_event(), in case
> > mmc_hw_reset() needed to schedule the reset, as to prevent the system
> > for suspending for a small amount of time. As to make sure the rescan
> > work, gets to run. But I am not sure that's needed here.
>
> I was more worried that we could get into a state where we'd return
> EBUSY forever, but I think I've convinced myself that this isn't
> possible.  If we fail to load things then the adapter variable will be
> freed anyway.
>
>
> > Finally, if you want to verify that the above system suspend path
> > works fine, you could change the call to "_mmc_detect_change(host, 0,
> > false)" in mmc_sdio_hw_reset(), into "_mmc_detect_change(host,
> > msecs_to_jiffies(30000), false)", in patch3.
> >
> > This should leave you a 30s window of where you can try to system
> > suspend the platform, while also waiting for the scheduled reset to be
> > completed.
>
> It worked.
>
> https://pastebin.com/NdsvAdE8

Great, thanks for confirming!

Kind regards
Uffe
