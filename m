Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878341356CE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgAIK0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 05:26:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41893 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAIK0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 05:26:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so5395407oie.8
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQJKMw2DKrzoM93kVfwLvG1Z80enNY4bvse02ifcw+s=;
        b=BiTyM1FDl619QUQWYpQcAUivNguZDOkZ+h3LezLx7CrRiUjuR7hD0x6TQH+xZ0hkf6
         ++Itr7fcj7Fl1a7UJ3VEG1bO0dpisFVWea7IuP6IgchtxT2CihBw8zAb4weMgEN1fqcG
         RLOIfSxgEoMfpTxkcf+xJ6pJNDLXZI1tfsW2EZZUton6hV+x4vx1axO9I2axspnbepH6
         AeAg+IjFVPs+ROYPqhMaoXxMDJBxW8dkDRxapIWoQZSoACtBXtytSMKoHZzki000Z4DP
         Cw/lly5j/7tRin7LQuqZRZ9eA9+tWg+HBwYnoFWZfC5iYDftmNzdm0R9tU4WqyU21Im6
         KuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQJKMw2DKrzoM93kVfwLvG1Z80enNY4bvse02ifcw+s=;
        b=p3oooPMF4YFSOA3pZCfzfHPWP2fTQ0jB8vfdVjuU1Nlvf6pg6/2fEes7YvKxvRtKh1
         AnKvRjs6GSYyxYGxB3GIl1Ldk5YAj0vS+lZkKJTqDnioGutvBN7PW3q8VgdsBs1ufoo7
         79TbulfZUHif+nOBk9uMiruvHbg1AjlQQFdH+zQ+lIuBJcQfnAxWrmd6AhoMXwEjHSWj
         dzSfYQ/bh6Z6b5tnQD2JGoNR9mNTS5yhGrPvheZhYTSF9qLKXPXK6dH44Lxj2upPv4IM
         CIvUmR3vLaV67Se6TUSS/SmR7crZQr853ehmF49N8RyIq+dIDlRsHB7CAQnnzVuTQm5n
         c54A==
X-Gm-Message-State: APjAAAUvNpAUJlFwZa2YwNfanML0AICEPp9/3w5ps1jQcfdmBABFY0Nd
        yHgWNPRoF/61h9crzfqsu6GAYnrfNxf7YWKnEpi5Dw==
X-Google-Smtp-Source: APXvYqw6evGvP8dEMTdVrloslQxYJ/4Bck9WOhSWXFg94ke+rCAnDN3DDpOYYHf8bEZUvGRNnjBb2h1cP9SW3eCqwG0=
X-Received: by 2002:aca:5e02:: with SMTP id s2mr2474761oib.80.1578565600133;
 Thu, 09 Jan 2020 02:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20200107080807.14433-1-yhchuang@realtek.com> <CAB4CAwfxQJzsJfxScVE+Y_xYbdSigTf567b9Xv-LFyQQnOXEAA@mail.gmail.com>
 <5ffa570167b34b77ab05cdf490812a59@realtek.com>
In-Reply-To: <5ffa570167b34b77ab05cdf490812a59@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 9 Jan 2020 18:26:29 +0800
Message-ID: <CAB4CAwf0G6HMaZwPGSXm3uxUGxipzKp-OS4bpanF6f6xZw1fjQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: fix potential NULL skb access in TX ISR
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>,
        "rtereguloff@gmail.com" <rtereguloff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 7, 2020 at 7:21 PM Tony Chuang <yhchuang@realtek.com> wrote:
>
> From: Chris Chiu
> > Subject: Re: [PATCH] rtw88: fix potential NULL skb access in TX ISR
> >
> > On Tue, Jan 7, 2020 at 4:08 PM <yhchuang@realtek.com> wrote:
> > >
> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > >
> > > Sometimes the TX queue may be empty and we could possible
> > > dequeue a NULL pointer, crash the kernel. If the skb is NULL
> > > then there is nothing to do, just leave the ISR.
> > >
> > > And the TX queue should not be empty here, so print an error
> > > to see if there is anything wrong for DMA ring.
> > >
> > > Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> > > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > > ---
> > >  drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> > b/drivers/net/wireless/realtek/rtw88/pci.c
> > > index a58e8276a41a..a6746b5a9ff2 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > > @@ -832,6 +832,11 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev,
> > struct rtw_pci *rtwpci,
> > >
> > >         while (count--) {
> > >                 skb = skb_dequeue(&ring->queue);
> > > +               if (!skb) {
> > > +                       rtw_err(rtwdev, "failed to dequeue %d skb TX
> > queue %d, BD=0x%08x, rp %d -> %d\n",
> > > +                               count, hw_queue, bd_idx, ring->r.rp,
> > cur_rp);
> > > +                       break;
> > > +               }
> > >                 tx_data = rtw_pci_get_tx_data(skb);
> > >                 pci_unmap_single(rtwpci->pdev, tx_data->dma,
> > skb->len,
> > >                                  PCI_DMA_TODEVICE);
> > > --
> > > 2.17.1
> > >
> >
> > Maybe we can simply do 'while (count -- &&
> > !skb_queue_empty(&ring->queue))' to achieve the same thing?
> > I don't think it worths to raise an error unless the count is expected
> > to exactly match the queue length in any
> > circumstances.
> >
>
> Yes, I expected that the queue length should match with the DMA ring.
> And so I printed an error to see why the count mismatched.
>
> Yan-Hsuan

Maybe you can spin lock around skb_dequeue and skb_enqueue to prevent
some possible race conditions?

Chris
