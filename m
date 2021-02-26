Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222C532629C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhBZMTt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 07:19:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhBZMTW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 07:19:22 -0500
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lFc4t-0005fU-UA
        for linux-wireless@vger.kernel.org; Fri, 26 Feb 2021 12:18:40 +0000
Received: by mail-lj1-f198.google.com with SMTP id s25so3422756ljd.21
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 04:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEgBMKGxadvFK3yVPkKm3LoV1uTlihtQiX3IeUFAKmI=;
        b=Xk7Z1z02COvRPC0e9yW8gkO8EExbq9OFuoUdjCgVrS1cZIUTItkBlJUmOFEQ74lsL5
         fmhYemhykUNCSi87c1rGEVtki5LZNEaVNaeKWu13E4uRhFe8YzIy9+cSo38vA6+D3AHf
         GJzLtnTqmLT9qr+7aXHSpy82Ue3nL8/3QOgWmjPwFJYfIoTE6uiMZKh6hmiG811jOZqb
         lw6zjfPPkyLbTs8jmvbqKc2CWt7KYCYDNBguxju9kRgSFjAAsY3XH1iX2UDgMiQyxA+y
         +LGfvTcjIohXQXf4q/w6Zg9HZVVmJAnIAZuuSd5YwFcV/IMr3Dt8hauuDLV/UbTHDlOY
         dHLw==
X-Gm-Message-State: AOAM53216X78e2b7wMrYL6COzQfvzQGykNh12w2jCUccN+ZCf729Klk+
        pvHI/WceInsTFJ1/NmMhiRMF4AA0WIHA7JRSU5yZQowlfqDOGCZsc1OhoJOnnX6PXCmd+bQLWqs
        FyAVKzZvY0jmTkpFVTn1/O89MD7dtjHbzSCoprAJFFAnvXY7lmh5MxC7ZkXHj
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1553273ljk.402.1614341919418;
        Fri, 26 Feb 2021 04:18:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7K7NOyy2eMABgg+IO3LCoFO4nKPNgda9PdQ1NGxABulvSyhPqxk7tkqeoms87YNgHXdivQHHOs6LCSD75QZw=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1553262ljk.402.1614341919215;
 Fri, 26 Feb 2021 04:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20210225174041.405739-1-kai.heng.feng@canonical.com>
 <20210225174041.405739-3-kai.heng.feng@canonical.com> <87o8g7e20e.fsf@codeaurora.org>
 <0e8ba5a4-0029-6966-e4ab-265a538f3b3d@gmail.com>
In-Reply-To: <0e8ba5a4-0029-6966-e4ab-265a538f3b3d@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 26 Feb 2021 20:18:28 +0800
Message-ID: <CAAd53p6tWUn-QbCysL_KweREmpSNfiQa7-gHgndqGta2UWt0=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Convert rtw88 power cycle quirk to shutdown quirk
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
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

On Fri, Feb 26, 2021 at 8:10 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 26.02.2021 08:12, Kalle Valo wrote:
> > Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> >
> >> Now we have a generic D3 shutdown quirk, so convert the original
> >> approach to a PCI quirk.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >>  drivers/net/wireless/realtek/rtw88/pci.c | 2 --
> >>  drivers/pci/quirks.c                     | 6 ++++++
> >>  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > It would have been nice to CC linux-wireless also on patches 1-2. I only
> > saw patch 3 and had to search the rest of patches from lkml.
> >
> > I assume this goes via the PCI tree so:
> >
> > Acked-by: Kalle Valo <kvalo@codeaurora.org>
> >
>
> To me it looks odd to (mis-)use the quirk mechanism to set a device
> to D3cold on shutdown. As I see it the quirk mechanism is used to work
> around certain device misbehavior. And setting a device to a D3
> state on shutdown is a normal activity, and the shutdown() callback
> seems to be a good place for it.
> I miss an explanation what the actual benefit of the change is.

To make putting device to D3 more generic, as there are more than one
device need the quirk.

Here's the discussion:
https://lore.kernel.org/linux-usb/00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com/

Kai-Heng
