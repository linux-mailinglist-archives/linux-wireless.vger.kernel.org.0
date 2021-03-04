Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476632CC56
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhCDGI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 01:08:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhCDGIM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 01:08:12 -0500
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lHh90-0005Hz-HA
        for linux-wireless@vger.kernel.org; Thu, 04 Mar 2021 06:07:30 +0000
Received: by mail-lj1-f200.google.com with SMTP id 6so3779538ljr.11
        for <linux-wireless@vger.kernel.org>; Wed, 03 Mar 2021 22:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0f+eYtATsSsjrMI9K7JVfhIQMfZEx2gHGl9xTr7UQQ=;
        b=c+5GRDls8ioOSexuH10tJPktFFlNLAnhXAruodv+ePdNTcY//RC65cuw5hbri21nZ2
         +mhaUnX8CwH41ay5gfhC+9zo9tym1fZNnHF2BKH9egmWPtjqnRw+29ugT8n5WCGnU4tL
         RiDQAYGtCSEtvu/AKRSIu+njM5ABCuOx710cwxvmaeE6PdReCMKg0G+3mERsDaWHsoeK
         8ZSTo1IPgAqb/c+sZrG06Lr0BZW83FSJz9kePz/oKx2TVVC2t4ZKt3OrFv8yRqzX+nrF
         3O3X8v/8k/K0vIhKid0fS/FkDpNlH8/0LNlAjSGxtFZy5ULGtmoAAl4tVruNf42NhnJl
         sUyg==
X-Gm-Message-State: AOAM5314Jo4Z+6/Ph3vS/SN9T4cVDjLAcDtj3Fh1GXwM1iy1Sz/mC3Ss
        hNGsd69yKk/yRTkgt7lW/mu7H1VktgRJj1XBVjkyaxjR0yh4JnUs9AhBRHFnwSPZaXegeSNrciJ
        knhbn3CVF2og6R21+2KTmtVkMGkUEl34dXEFEPC5upMqDPAo1PKFkPy6DVQM6
X-Received: by 2002:a19:6d09:: with SMTP id i9mr1290805lfc.425.1614838049992;
        Wed, 03 Mar 2021 22:07:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9QfkXxjtv37O7vKRgjQ/96zOmvvA9rGg54zz6NkOWiL9NrVaiztc+aQ9BpHPZU7Pt9TK7skvHryZUiXUt98o=
X-Received: by 2002:a19:6d09:: with SMTP id i9mr1290788lfc.425.1614838049726;
 Wed, 03 Mar 2021 22:07:29 -0800 (PST)
MIME-Version: 1.0
References: <6db9e75e-52a7-4316-bfd8-cf44b4875f44@gmail.com> <20210226181656.GA143072@bjorn-Precision-5520>
In-Reply-To: <20210226181656.GA143072@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 4 Mar 2021 14:07:18 +0800
Message-ID: <CAAd53p62zy64gsmdNYSuV1sxOiB1Hye5R0WkY-gNFf+CKbG12A@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Convert rtw88 power cycle quirk to shutdown quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Feb 27, 2021 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 02:31:31PM +0100, Heiner Kallweit wrote:
> > On 26.02.2021 13:18, Kai-Heng Feng wrote:
> > > On Fri, Feb 26, 2021 at 8:10 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> > >>
> > >> On 26.02.2021 08:12, Kalle Valo wrote:
> > >>> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> > >>>
> > >>>> Now we have a generic D3 shutdown quirk, so convert the original
> > >>>> approach to a PCI quirk.
> > >>>>
> > >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >>>> ---
> > >>>>  drivers/net/wireless/realtek/rtw88/pci.c | 2 --
> > >>>>  drivers/pci/quirks.c                     | 6 ++++++
> > >>>>  2 files changed, 6 insertions(+), 2 deletions(-)
> > >>>
> > >>> It would have been nice to CC linux-wireless also on patches 1-2. I only
> > >>> saw patch 3 and had to search the rest of patches from lkml.
> > >>>
> > >>> I assume this goes via the PCI tree so:
> > >>>
> > >>> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> > >>
> > >> To me it looks odd to (mis-)use the quirk mechanism to set a device
> > >> to D3cold on shutdown. As I see it the quirk mechanism is used to work
> > >> around certain device misbehavior. And setting a device to a D3
> > >> state on shutdown is a normal activity, and the shutdown() callback
> > >> seems to be a good place for it.
> > >> I miss an explanation what the actual benefit of the change is.
> > >
> > > To make putting device to D3 more generic, as there are more than one
> > > device need the quirk.
> > >
> > > Here's the discussion:
> > > https://lore.kernel.org/linux-usb/00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com/
> > >
> >
> > Thanks for the link. For the AMD USB use case I don't have a strong opinion,
> > what's considered the better option may be a question of personal taste.
> > For rtw88 however I'd still consider it over-engineering to replace a simple
> > call to pci_set_power_state() with a PCI quirk.
> > I may be biased here because I find it sometimes bothering if I want to
> > look up how a device is handled and in addition to checking the respective
> > driver I also have to grep through quirks.c whether there's any special
> > handling.
>
> I haven't looked at these patches carefully, but in general, I agree
> that quirks should be used to work around hardware defects in the
> device.  If the device behaves correctly per spec, we should use a
> different mechanism so the code remains generic and all devices get
> the benefit.
>
> If we do add quirks, the commit log should explain what the device
> defect is.

So maybe it's reasonable to put all PCI devices to D3 at shutdown?

Kai-Heng

>
> Bjorn
