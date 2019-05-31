Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F64312FA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfEaQrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 12:47:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33366 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfEaQrt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 12:47:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so8460710lfe.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 May 2019 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umRgW7C+tO4b3P+SNMV0Rx/bJLg4L2IeD7Igx4rfhs4=;
        b=N7KaoI1rtdwVdRLo2srZXPg1dAzOva/R606WNk8BGKcFLmoQXMKvyjUqI0Uk7K42/e
         sWAoQZF5wJva1QB382HoWSuWS2PfZ8lY71z1frUeCt3+2emHU3YGuazy7UMIwQKb6BbS
         MdIWBb8kb1/M6Kc2Nsz8vyqIAan9wHtNMvaJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umRgW7C+tO4b3P+SNMV0Rx/bJLg4L2IeD7Igx4rfhs4=;
        b=TTLc8WTdUjnlxz6NtNPFRrmUoAUXMLJ8l3wOVJRy0IcxWRydTPdaO4bWunJHtmwMJg
         1yeU7w5itzvCHtAbVXUucu47dhBMy8/uYXUWrZBgs3+WimctWmNgodSByuPQF8axn9ZL
         JniCXl9MP/TADFMWKk2xcuOr74uR7yRb5dRXe+x+tfll8zIhzzHyDJqJCirmoMyfBWUB
         9R/pWXmDr2GPCBe1fGqEBZtpjRX1JLrTl56+iC98vgyA3r9koAElr38sE9RhsdkQr2bv
         Iq57l/w10ghpLCR07idN/1UfjIwKG2rua3o7fvNh31sLZZzMhjn5WKXuqcU7R31ApUKZ
         tYaQ==
X-Gm-Message-State: APjAAAXPQLbhqWdGuE6iuzLcdAl5FxPUJmnrwaVG48KgufubEOqER5Ub
        znTAmCGmzWKJHYYkGvlgY4CCk5nG3f4=
X-Google-Smtp-Source: APXvYqyI9L/EMVtIXqKoeydMjVExrVVN2v4C/UVXEhdTxTkLlO18u3bK3V2nOSlEqRmb2U0a26Uj7g==
X-Received: by 2002:ac2:4286:: with SMTP id m6mr6356534lfh.150.1559321266745;
        Fri, 31 May 2019 09:47:46 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a4sm1274564lfj.31.2019.05.31.09.47.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:45 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j24so10292001ljg.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 May 2019 09:47:45 -0700 (PDT)
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr6490072ljh.167.1559321264696;
 Fri, 31 May 2019 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1559209955-10089-1-git-send-email-gbhat@marvell.com> <MN2PR18MB26379DF16EADA38F72A87412A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB26379DF16EADA38F72A87412A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 31 May 2019 09:47:33 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPDtr7jo=Tt=53VaLNYFwz2MgoSAFxTMLvxvVOMTuL2Cg@mail.gmail.com>
Message-ID: <CA+ASDXPDtr7jo=Tt=53VaLNYFwz2MgoSAFxTMLvxvVOMTuL2Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: add support for host wakeup via PCIE wake#
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(You really should re-send your patches, as they didn't make it to the
list. But while you're here:)

On Thu, May 30, 2019 at 3:01 AM Ganapathi Bhat <gbhat@marvell.com> wrote:
> > From: Sharvari Harisangam <sharvari@marvell.com>
> >
> > PCIE WAKE# is asserted by firmware, when WoWLAN conditions are
> > matched. Current driver does not enable PME bit needed for WAKE#
> > assertion, causing host to remain in sleep even after WoWLAN conditions are
> > matched. This commit fixes it by enabling wakeup (PME bit) in suspend
> > handler.

Are you sure said devices actually have their 'wakeup' attribute set
to 'enabled' (e.g., in sysfs)? I think the PCI core should probably be
taking care of this for you already. See below.

> > Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
> > Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/pcie.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c
> > b/drivers/net/wireless/marvell/mwifiex/pcie.c
> > index 3fe81b2..0bd81d4 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
...
> > @@ -181,6 +180,10 @@ static int mwifiex_pcie_suspend(struct device *dev)
> >       set_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
> >       clear_bit(MWIFIEX_IS_HS_ENABLING, &adapter->work_flags);
> >
> > +     pci_enable_wake(pdev, pci_choose_state(pdev, state), 1);
> > +     pci_save_state(pdev);
> > +     pci_set_power_state(pdev, pci_choose_state(pdev, state));

From Documentation/power/pci.txt:

"""
3.1.2. suspend()
...
This callback is expected to quiesce the device and prepare it to be put into a
low-power state by the PCI subsystem.  It is not required (in fact it even is
not recommended) that a PCI driver's suspend() callback save the standard
configuration registers of the device, prepare it for waking up the system, or
put it into a low-power state.  All of these operations can very well be taken
care of by the PCI subsystem, without the driver's participation.

However, in some rare case it is convenient to carry out these operations in
a PCI driver. [...]
"""

I think you need to do a little more work to justify why you are one
of those rare cases.

On a related note: some of the existing "configure wakeup" stuff we do
here should probably be gated behind a call to device_may_wakeup().
That would help make it more obvious that such configuration is
futile, if the device was marked as wake-disabled.

Brian

> > +
> >       return 0;
> >  }
> >
