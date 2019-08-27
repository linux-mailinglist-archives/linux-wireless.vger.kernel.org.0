Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC39E88B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfH0NCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 09:02:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46706 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0NCr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 09:02:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id y19so6925893ual.13
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KoZu/deJw/NlVxV4sAB1mkOWHaFltVntjfb4kcZq9oA=;
        b=u3QPZvvxJMpSan6eed9+9NraNySTEXwJYWaVskDG0YCPV/14fA29shOSMnrJ/POeAE
         MwV5WWpnW7vJFbbs39eKd10d+z65EtP7raPwZhtK3Zv2TRgXkcfctl7mxE7Lzk/iRn2B
         6wp1BCqQ2yWZ1cYbalDa9tQm1CqV0bMfbGuuQa5qjGr73VeY3MeG+0oepsuSqmYuCzF4
         5VyFJuEoEGvAT0Gdjd9a2UUaDdezRz+oZIv7yVR9d37eCJE15KL7dUCKg47njLFWHBDU
         OP0hOpPAuLbfrg052fn7X6Rm6vAWAB02NuLezW0po9Stt8O2C2nrpTLy12FA0Y9jh1SI
         FRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KoZu/deJw/NlVxV4sAB1mkOWHaFltVntjfb4kcZq9oA=;
        b=L6NyIF8OsvUjajuttjJOwFRmZUMQr9vyWA8msw+80PdudLcw2idv2YZkK7QD+NajG9
         asdc0sAuOGZzRRZSQbz0RO8hyQUEhdqxIyekcsScrzL9VrhMZFSYgJkOxAg7sgpvjY1j
         txxiEAasidP6i7UiDUnowhVWZ5E1JZSiGWbkvJ3VU8+M2x3QWoe+jkumBsYOSJahY1fu
         Y8IQBqKuaUMdn+kZffcbSAsqx/p3Yn4R0s8xzpaN7OSBCEZOhaiQsQDqB6WMUeMzcs8N
         8tijHG/z90VRqVmN3FiEHP3+NmineJoFFjud22uh0Apuv34Gag1dHa5qDL/dcZ+rMiK3
         dHsw==
X-Gm-Message-State: APjAAAVhoL63WrwK2gsXJqOow0+xG3aL/PyBl99MOaoCgQuXQC/UA0/2
        bJBDe82D3lvTVNTI5h7FPgoIvejp6s3AymZo5u0pTA==
X-Google-Smtp-Source: APXvYqymJZlZWZVqIafnDPxdw7EOMyk7iVnzb9WG+LHkPElnHnPIbqdbnvx1WIlDBiIEaUBDUtYRQ5SkTzJil0hXus8=
X-Received: by 2002:ab0:248a:: with SMTP id i10mr8754460uan.32.1566910965602;
 Tue, 27 Aug 2019 06:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <1565166487-22048-1-git-send-email-yhchuang@realtek.com>
 <20190823063728.14117-1-drake@endlessm.com> <CA+K+NcSYKEkdx5ux6iwUs7pMidObZBrg9yDcP1zT73DcccpDPQ@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D18AE7C8@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18AE7C8@RTITMBSVM04.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 27 Aug 2019 21:02:52 +0800
Message-ID: <CAPpJ_echMhQoKG=+rtkhMjdeFGDPbuyzE-DLBZ-7KL5+WcEVHw@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: pci: enable MSI interrupt
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "gojun077@gmail.com" <gojun077@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Daniel and J=C3=A1n,
>
>
> > From: J=C3=A1n Vesel=C3=BD > Sent: Friday, August 23, 2019 3:22 PM
> > On Fri, Aug 23, 2019 at 2:37 AM Daniel Drake <drake@endlessm.com> wrote=
:
> > >
> > > > +     rtw_pci_disable_interrupt(rtwdev, rtwpci);
> > >
> > > I checked the discussion on the v1 patch thread but I still don't fol=
low
> > > this.
> > >
> > > You're worried about the case where we're inside the interrupt handle=
r and:
> > >  1. We read the interrupt status to note what needs to be done
> > >  2. <another interrupt arrives here, requiring other work to be done>
> > >  3. We clear the interrupt status bits
> > >  4. We proceed to handle the interrupt but missing any work requested=
 by
> > >     the interrupt in step 2.
> > >
> > > Is that right?
> > >
> > > I'm not an expert here, but I don't think this is something that driv=
ers
> > > have to worry about. Surely the interrupt controller can be expected =
to
> > > have a mechanism to "queue up" any interrupt that arrives while an
> > > interrupt is being handled? Otherwise handling of all types of
> > > edge-triggered interrupts (not just MSI) would be overly painful acro=
ss the
> > > board.
> >
> > That's my understanding as well.
> > entering the interrupt vector clears the IFLAG, so any interrupt will
> > wait until the IFLAG is restored, or delivered to a different CPU.
> > wouldn't it be safer to enable interrupts only _after_ registering the
> > handler in the "rtw_pci_request_irq" function?
> >
> > regards,
> > Jan
>
>
> Yes that's not something drivers need to care about. But I think it is
> Because there's a race condition between SW/HW when clearing the ISR.
> If interrupt comes after reading ISR and before write-1-clear, the interr=
upt
> controller would have interrupt status raised, and never issue interrupt
> signal to host when other new interrupts status are raised.
>
> To avoid this, driver requires to protect the ISR write-1-clear process b=
y
> disabling the IMR.
>
>
> >
> >
> > >
> > > See e.g. https://patchwork.kernel.org/patch/3333681/ as a reference f=
or
> > > what correct interrupt controller behaviour should look like.
> > >
> > > > +             ret =3D pci_enable_msi(pdev);
> > >
> > > pci_enable_msi() is "deprecated, don't use"
>
> Do you mean I should remove this?
> But I cannot find another proper way to enable the MSI.
> Maybe pci_alloc_irq_vectors() could work but I am not sure if
> It is recommended.

According to the kernel documentation "The MSI Driver Guide HOWTO",
pci_alloc_irq_vectors, pci_irq_vector and pci_free_irq_vectors are the
functions.
https://elixir.bootlin.com/linux/v5.3-rc6/source/Documentation/PCI/msi-howt=
o.rst

Here is an example in r8169 module.
https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/net/ethernet/realt=
ek/r8169_main.c#L6603

Jian-Hong Pan
