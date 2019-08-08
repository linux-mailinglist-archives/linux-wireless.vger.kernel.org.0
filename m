Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4120E8677B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfHHQvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 12:51:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44879 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHQvj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 12:51:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so89504651ljc.11
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiEWeL7H3W20lQN3jRYA1ldQhDggwawkb8Q2+D0yaUI=;
        b=EUWWiVf+MsHbZ6Hf37fv1XnXfeYn3mNoGzh8HLoysZH0qyHlba10ZDlx1QyUIv8Tcm
         UcDwO7QEHXzTutURw9n6274auOYkurtRradEZlT7eQ1mGxaqPDZ4XNvI5oqYmSQPGmgb
         vvR8SNRb3+Sm0Iz1xX5Ne0HmQ2xfH1ph+YT44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiEWeL7H3W20lQN3jRYA1ldQhDggwawkb8Q2+D0yaUI=;
        b=h5p8fJ9w2Y1OJtypmpp2vjWjvyDGlQI5suuhwtk8uivYe1ASnhfuJ6E5gnNnjPcTZl
         VNY3RZR/XAbJe1YParzBpJtY0yaVOg/biBZXIpBb6AqmdkL3mSnhujhvyRziV42RSKbT
         p/ff8SjZq6WaFyKku6HksJkz89eFybo7FYY1GzcYh/wJLS0fAXviFoi9HIJM+IcrqkE0
         jV5fRLuDrPRP2a8a5Jz+Hfrk8XvI6IcuPoR9z7k7i89+l2QR9yq5vxJKvMwv6wn9dVF1
         aF6pO+C10errr7ESaeRupF5/mSpLD+ucjcPfe3LAQkfLNtz0j7TZnP8XIWALYG9zZWHz
         jdgg==
X-Gm-Message-State: APjAAAVI/9jsbAQqF9IDVwLUkZWcJePI9rARAupNn4MAUliQX/9wkkI/
        YtV4okubjpsWVX9w4uvwAw4m50usOVU=
X-Google-Smtp-Source: APXvYqy21Vpwi7ezeN8E12d/PqnwbL75W6i5u/BKdMTwdXRWUfYw9Cq4evCyXRXZKnIULhgtokqxdQ==
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr8964540ljj.142.1565283097641;
        Thu, 08 Aug 2019 09:51:37 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d3sm17015229lfb.92.2019.08.08.09.51.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:51:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x3so13592245lfn.6
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 09:51:36 -0700 (PDT)
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr9834070lfq.44.1565283096004;
 Thu, 08 Aug 2019 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
 <20190730195703.GA224792@google.com> <F7CD281DE3E379468C6D07993EA72F84D18855BB@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18855BB@RTITMBSVM04.realtek.com.tw>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 8 Aug 2019 09:51:24 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
Message-ID: <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely@gmail.com" <jano.vesely@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 1, 2019 at 2:21 AM Tony Chuang <yhchuang@realtek.com> wrote:
> > Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
> > On Tue, Jul 30, 2019 at 07:50:14PM +0800, yhchuang@realtek.com wrote:
> > > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > > @@ -874,6 +878,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq,
> > void *dev)
> > >     if (!rtwpci->irq_enabled)
> > >             goto out;
> > >
> > > +   rtw_pci_disable_interrupt(rtwdev, rtwpci);
> >
> > Why exactly do you have to mask interrupts during the ISR? Is there a
> > race in rtw_pci_irq_recognized() or something?
>
>
> I think there is a race between SW and HW, if we do not stop the
> IRQ first, write 1 clear will make the interrupt to be lost.

This doesn't need to slow down this patch (I think v2 is fine), but I
still don't quite understand. Before this addition, the sequence is:
(a) read out your IRQ status
(b) ack the un-masked IRQs you see
(c) operate on those IRQs

Even if a new IRQ comes in the middle of (b), shouldn't it be
sufficient to move on to (c), where you're still prepared to handle
that IRQ?

Or if the IRQ comes after (b), you won't ACK it, and you should
immediately get a new IRQ after you return?

I guess that's assuming that these registers are Write 1 to Clear. But
if so, that means rtw_pci_irq_recognized() is effectively atomic, no?

Also, somewhat unrelated: but why do you unmask HIMR1, when you're not
actually handling any of its IRQ bits?

Brian

> >
> > >     rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
> > >
> > >     if (irq_status[0] & IMR_MGNTDOK)
