Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4B14D35B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 00:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgA2XNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 18:13:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37786 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgA2XNV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 18:13:21 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so1801219ioc.4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCUbrUz7P+ZZOGgq2SEr224JKtlddICvuICcnGrb8wI=;
        b=SdkOg+CGhQWsyghj0M3VcH36oGpO89eNNXRye+lGikf5O5Is0N+RxBrpq/SFFroshF
         X865+RzEqL7tuwe6qQBrHRSo7IIb3mgnByPT5LO1mkE3R9BlviVxtp3u+QSA2QzOryf4
         gVPKzRsEO6gnwep19v1pcG56Mcttgie4MWpj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCUbrUz7P+ZZOGgq2SEr224JKtlddICvuICcnGrb8wI=;
        b=W113lb5Eq7AROPRCIJ6T+HNvejEWM0fNIt5f5iB3JxDbx1SjEuY/k7BkHIEEpuOeB1
         QQvL4a5cIDpcKmwl1M1yoF89I/PwLhi4UvxyrlMhjPl6fLHPLivL842McuJfZ8XWcdCy
         BG5IcUkwiot25bmTSTTPiGlNx7GnUUcsn13vnizM01Z+JB6/hj8g61bojCiYRwL/kLTD
         GXrzWNX/hA8efX2lxsit1DeaGGBR7KHcD8ncw4iBgH2Euyh9pMt5+O++XxH5SF54vD7a
         xA3EwnxQqQ5mKDt/77G5EY+5sk8YL1MDR5AqLk4Mk+H8zOVq951XI+LCT3v3nBfGR7xz
         KZCA==
X-Gm-Message-State: APjAAAWKwjfHc/mP3Zn1S1dEmMLPlPqtUu+iIlCweqDW/UBDNiJ/Mm8W
        OzM9n1vifGZMUlTXtoEsUtGOxtrfk/BdIdg4RzzoSA==
X-Google-Smtp-Source: APXvYqxHMtiCwMc6jPRHRw63xfLorZNlXp+L+Bp/WE3y4H4JqVTTE0Uo9byH9oRz6OydL59iyNlWuRq15pvmR8iqCJY=
X-Received: by 2002:a5e:c907:: with SMTP id z7mr1648711iol.88.1580339600746;
 Wed, 29 Jan 2020 15:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20200128221457.12467-1-linux@roeck-us.net> <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
 <20200129000551.GA17256@roeck-us.net> <CA+8PC_f=qCUjihwbjd3vtGaNkG-=R1qm83oS7AmgtLTy6EgjyQ@mail.gmail.com>
 <20200129180428.GA99393@google.com>
In-Reply-To: <20200129180428.GA99393@google.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Wed, 29 Jan 2020 15:12:54 -0800
Message-ID: <CA+8PC_cr8D-tFT1QwS=DSNOW1X2sW3f__Aqts33bUseu9L7yfg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: abort and release host after error
To:     Brian Norris <briannorris@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 29, 2020 at 10:04 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Franky,
>
> [I'm very unfamiliar with this driver, but I had the same questions as
> Guenter, I think:]
>
> On Tue, Jan 28, 2020 at 04:57:59PM -0800, Franky Lin wrote:
> > On Tue, Jan 28, 2020 at 4:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Tue, Jan 28, 2020 at 03:14:45PM -0800, Doug Anderson wrote:
> > > > On Tue, Jan 28, 2020 at 2:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > > > @@ -1938,6 +1938,8 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
> > > > >                         if (brcmf_sdio_hdparse(bus, bus->rxhdr, &rd_new,
> > > > >                                                BRCMF_SDIO_FT_NORMAL)) {
> > > > >                                 rd->len = 0;
> > > > > +                               brcmf_sdio_rxfail(bus, true, true);
> > > > > +                               sdio_release_host(bus->sdiodev->func1);
> > > >
> > > > I don't know much about this driver so I don't personally know if
> > > > "true, true" is the correct thing to pass to brcmf_sdio_rxfail(), but
> > > > it seems plausible.  Definitely the fix to call sdio_release_host() is
> > > > sane.
> > > >
> > > > Thus, unless someone knows for sure that brcmf_sdio_rxfail()'s
> > > > parameters should be different:
> > > >
> > > Actually, looking at brcmf_sdio_hdparse() and its other callers,
> > > I think it may not be needed at all - other callers don't do it, and
> > > there already are some calls to brcmf_sdio_rxfail() in that function.
> > > It would be nice though to get a confirmation before I submit v2.
> >
> > I think invoking rxfail with both abort and NACK set to true is the
> > right thing to do here so that the pipeline can be properly purged.
>
> Thanks for looking here. I'm not sure I totally understand your answer:
> brcmf_sdio_hdparse() already calls brcmf_sdio_rxfail() in several error
> cases. Is it really OK to call it twice in a row?

Yes. brcmf_sdio_rxglom does the same thing that calls
brcmf_sdio_rxfail again in error handling. For this instance I think
it's better using the same logic as the length mismatch block below (
calling brcmf_sdio_rxfail with true ture).

Thanks,
- Franky
