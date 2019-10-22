Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFCE06AD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfJVOrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 10:47:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46699 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOrS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 10:47:18 -0400
Received: by mail-il1-f195.google.com with SMTP id m16so9264555iln.13
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtR0PWo1dnvCC8sVNqIrEQULx6YseetGPasRYtSEfgU=;
        b=MhxylbhKkpmyjYOkefoLAam3gigL71xHU7w6C3RixbGIvY/htZLZ3NLPukRnCrP3tb
         EQ/HSW2Pf9P7GEFdQvHA7IkPm+joLGn+EnOslY9EhkKYD7B47a5V+ks4rnpudK5oQytn
         78uU9PCAmnihBor54R6P4YKJ3jC1Qdq4YKuNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtR0PWo1dnvCC8sVNqIrEQULx6YseetGPasRYtSEfgU=;
        b=T6SB1pKEqJvpFwuHtkbO7BHxbvS4mqyb3mBRXt/9TP7lp7kfU0tnVdYLNEv4bidvYB
         eNui9Im3mID2P/9yeeBRjtYciZ7q8RdTVCnykbxiqRT+E62TamOCZGWm+PYpkJ2OMneJ
         /tRRaQWaT8QOSI4d6399Mb9hcUYi5YPM8paQeNCtngzXTihvuKaTHxPlBvmPklO47ez3
         ZYg+8dnw/Q80XNCajuXoUunIB+nWiISi8pn5/S+3WSr/MmMJuQjHYtYKNRlbnrnUcwoz
         REPMlBf5C2Bpl1WGQi5Zll0k6RABrvvLdkSj2eZItiMy2MMjJUhCIOfdb0zLpbUhICE0
         +t/A==
X-Gm-Message-State: APjAAAVOJS+hPGYVo5/4y/Mwx7YmfDToz93I0Q9wv+xH7fe2y/WFcTsE
        /xjWrR+b4eDXYULMJZpq96Tz3t8rOi8=
X-Google-Smtp-Source: APXvYqyLVaKQWFfFki5uvCDP9NL/8tENUoApisrKm4W1CDgVwOZVdRfcBjvaBDpnTHHHRE8KGbpRtw==
X-Received: by 2002:a92:d145:: with SMTP id t5mr5478799ilg.35.1571755637109;
        Tue, 22 Oct 2019 07:47:17 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id d6sm6529260ilc.39.2019.10.22.07.47.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:47:16 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id s75so5920407ilc.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 07:47:15 -0700 (PDT)
X-Received: by 2002:a92:1e03:: with SMTP id e3mr8267234ile.168.1571755634923;
 Tue, 22 Oct 2019 07:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com> <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
In-Reply-To: <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Oct 2019 07:47:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
Message-ID: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
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

Hi,

On Mon, Oct 21, 2019 at 11:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > The problem I see here is that callers of this reset function aren't
> > expecting it to work this way.  Look specifically at
> > mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> > things like shutdown / reinit.  Now it's true that the old
> > mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> > also had SDIO bluetooth, but presumably it worked OK on systems
> > without SDIO Bluetooth.  I don't think it'll work so well now.
>
> Good point!
>
> I guess I was hoping that running through ->remove() and then
> ->probe() for the SDIO func drivers should simply take care of
> whatever that may be needed. In some way this makes the driver broken
> already in regards to this path, but never mind.

Yeah, probably true.  I guess if anyone actually expected to use one
of these cards as a removable SDIO card (I have seen such dev boards
long ago) then it would always have been possible for someone to
remove the card at just the wrong time and break things.


> > Testing shows that indeed your patch breaks mwifiex reset worse than
> > it was before (AKA WiFi totally fails instead of it just killing
> > Bluetooth).
> >
> > I think it may be better to add a new API call rather than trying to
> > co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> > make people move away from it, or something?
>
> Thanks again for testing and for valuable feedback! Clearly this needs
> a little more thinking.
>
> An additional concern I see with the "hotplug approach" implemented in
> $subject patch, is that it becomes unnecessary heavy when there is
> only one SDIO func driver bound.
>
> In one way I am tempted to try to address that situation, as it seems
> a bit silly to do full hotplug dance when it isn't needed.

True, though I kinda like the heavy solution here.  At least in the
mwifiex case this isn't a part of the normal flow.  AKA: we don't call
this function during normal bootup nor during any normal operations.
It's much more of an "oh crap, something's not working and we don't
know what to do" type solution.  I mean, I guess it's still not
uncommon that we end up in this code path due to the number of bugs in
Marvell firmware, but I'm just trying to say that it's an error code
path and not a normal one.  In my mind that means the more things we
can re-init the better.

If this was, on the other hand, a reset that we were supposed to
always assert when doing a normal operation (like it wants us to reset
it when we switch modes, or something) then a lighter operation would
make more sense.

-Doug
