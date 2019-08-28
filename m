Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE79FB1B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfH1HEm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 03:04:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35844 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfH1HEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 03:04:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so1898118qtc.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2019 00:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5WYDQGBr72uC1iZWzAcRPmXL6XyAAfTwXX6nty/xZU=;
        b=klmT9L0XlssqErq3yRPe3YA8ohQqSkM8HY/V4GvWT0J30jrPGJjclljJlq0oQq4MsJ
         +0Bt+pxMQa/jbubXlgs4jwTbwh23inzWvgKFOlBdKmQaj8r4UyDqJRwGeq1HBtqdYMua
         lwJCWkSrl4gFFGfCcsAPF2caNmrdxVbQIDTJI32Pt6L+Tk4llwYzBJw5YZIXnjBL6Pq8
         XkESnVW+r8JU7/kj5FKyjeLOBmkB9wx9Jh0egEw9MXb8z3NffOhkcv9PYEpq0mT65cEx
         m5oTcO/kh5C06FMGEzn8dTteDnYsnNyRm4Y+TzcrkxYappjX99FBfbHRTs3i8EyqMmiG
         /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5WYDQGBr72uC1iZWzAcRPmXL6XyAAfTwXX6nty/xZU=;
        b=HNlJY73AjbibU1H/hMxLy9PsIXyJEQLU3cO61kSFYedaq+sKleiR9NacVIs9Jg7iTq
         3vjij7FIs5B9QcLEvKdUsRjg95iU5kZwqo3TEdTd46aAK/SON/Pzw2P+3DwGTJhHO52e
         ILkwpj2rvoxOzRWEewPLJNWHDMBSKfWfU7BO0qEkHEwoeKnqJZ/QZzQGgw+4S5Cz3Rg5
         kS7E8xBvpcfvpWSnNu5u1DpqfepOGeP50Lb5vlRCNhY+TxW3MuFGlLtvLFBEwFnnSLvF
         QmDnx7Y8nyUL4x3swaq+q6kOpHP0MrbaeLx48mhbJB6mnNVwIY65xVrSeUm2gpN1MKuU
         Q6Jw==
X-Gm-Message-State: APjAAAUJ7+c/bsfKgWCvWm8Oy0P9tZkM6TyOfzY3KLVGFpOWpxjQA811
        vVORT5WZMCCqWy6afDxo1kBDhwjZFvFKnNU3PrC8HA==
X-Google-Smtp-Source: APXvYqxzq0kw92o8/VFrXogdt3BMnl1G7hSpCAntVNGwtI6w/kqQk8NWv4beL2f9kDUyqAfl/+IzhSAAvnNiraMUvsI=
X-Received: by 2002:a0c:d84b:: with SMTP id i11mr1781901qvj.86.1566975880595;
 Wed, 28 Aug 2019 00:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1565166487-22048-1-git-send-email-yhchuang@realtek.com>
 <20190823063728.14117-1-drake@endlessm.com> <CA+K+NcSYKEkdx5ux6iwUs7pMidObZBrg9yDcP1zT73DcccpDPQ@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D18AE7C8@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18AE7C8@RTITMBSVM04.realtek.com.tw>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 28 Aug 2019 15:04:29 +0800
Message-ID: <CAD8Lp46=Adn3GWAkHspdqBHVjz6sekET9nzNOCnW7sCFGtoeDQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: pci: enable MSI interrupt
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "gojun077@gmail.com" <gojun077@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 27, 2019 at 8:11 PM Tony Chuang <yhchuang@realtek.com> wrote:
> Because there's a race condition between SW/HW when clearing the ISR.
> If interrupt comes after reading ISR and before write-1-clear, the interrupt
> controller would have interrupt status raised, and never issue interrupt
> signal to host when other new interrupts status are raised.
>
> To avoid this, driver requires to protect the ISR write-1-clear process by
> disabling the IMR.

Just to be clear with an example of two interrupts in quick
succession, first ROK then MGNTDOK. I would expect the hardware to
behave as follows:

1. Interrupts are enabled in HIMR reg. MSI is in use.
--- Hardware needs to flag RX condition. It sets IMR_ROK flag in HISR,
then raises a MSI interrupt.
--- Interrupt controller receives this and begins handling it:
2. rtw88 interrupt handler begins execution
3. rtw_pci_irq_recognized()  reads HISR values. ROK is the only bit set.
--- Hardware needs to flag MGNTDOK condition, so it sets the MGNTDOK
bit in HISR and raises another interrupt.
--- Interrupt controller queues this interrupt since it's in the
middle of handling the original ROK interrupt.
4. Back in rtw_pci_irq_recognized(), the HISR values from earlier are
written back to clear them. In this case just the ROK bit is written
back to unset the interrupt. MGNTDOK interrupt is left pending (not
yet noticed by the driver)
5. Interrupt handler continues & finishes handling the RX event.
6. With the first interrupt done, interrupt controller handles the
queued interrupt and causes rtw88 interrupt handler to execute again
7. rtw88 interrupt handler handles and MGNTDOK interrupt.


But are you saying it does not do this, and the behaviour (without
your change) is instead:

1. Interrupts are enabled in HIMR reg. MSI is in use.
--- Hardware needs to flag RX condition. It sets IMR_ROK flag in HISR,
then raises a MSI interrupt.
--- Interrupt controller receives this and begins handling it:
2. rtw88 interrupt handler begins execution
3. rtw_pci_irq_recognized()  reads HISR values. ROK is the only bit set.
--- Hardware needs to flag MGNTDOK condition, so it sets the MGNTDOK
bit in HISR. However it does NOT raise an interrupt since other bits
in HISR were still set at this time.
4. Back in rtw_pci_irq_recognized(), the HISR values from earlier are
written back. In this case just the ROK bit is written back to unset
the interrupt. MGNTDOK interrupt is left pending (not yet noticed by
the driver)
5. Interrupt handler continues & finishes handling the RX event.
6. MGNTDOK interrupt is left pending, and no more interrupts will be
generated by the hardware because even if it sets more HISR bits, the
MGNTDOK bit was already set so it doesn't raise more interrupts.

i.e. you're effectively saying that the hardware will *only* generate
an interrupt when *all* HISR bits were zero immediately before the new
interrupt HISR bit is set?


And then with your change applied it would look like this:

1. Interrupts are enabled in HIMR reg. MSI is in use.
--- Hardware needs to flag RX condition. It sets IMR_ROK flag in HISR,
then raises a MSI interrupt.
--- Interrupt controller receives this and begins handling it:
2. rtw88 interrupt handler begins execution
3. Interrupts are disabled in HIMR reg.
4. rtw_pci_irq_recognized()  reads HISR values. ROK is the only bit set.
--- Hardware needs to flag MGNTDOK condition, however because
interrupts are disabled in HIMR, it simply queues this condition
internally, without affecting HISR values, without generating another
interrupt.
4. Back in rtw_pci_irq_recognized(), the HISR values from earlier are
written back. In this case just the ROK bit is written back to unset
the interrupt. HISR is now value 0.
5. Interrupt handler handles the RX event.
6. Interrupt handler re-enables interrupts in HIMR just before finishing.
--- In response, hardware checks its internal queue and realises that
a MGNTDOK condition is pending. It sets the MGNTDOK bit in HISR and
raises a new interrupt.

Is that right? It seems like strange behaviour on the hardware side.

> Do you mean I should remove this?
> But I cannot find another proper way to enable the MSI.
> Maybe pci_alloc_irq_vectors() could work but I am not sure if
> It is recommended.

Yes, I think you should switch to pci_alloc_irq_vectors() which is the
recommended, documented way.

Thanks,
Daniel
