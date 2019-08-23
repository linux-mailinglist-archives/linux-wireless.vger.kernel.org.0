Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE79A8AB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbfHWHWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 03:22:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40936 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390277AbfHWHWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 03:22:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so502413qtq.7
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNHdvFqH7RmVudOUs67Jz5dt0KxwBdgyqp7eCOsiZvY=;
        b=cCYAQen27zfY6vuObP7pdRP476ty4fWcwQifaNmGZMh5VaP3+3C2tEjofU8pSrIhKZ
         iIuYrGlvI84Anb07TexEfHcNxfA7G5KwhMjI2Q6YLiSPSi979gzGLj54O+WQkiSvNayD
         5+IEoFG6/TtbD83zWfoAi0qqu7oiC12h4v6RYZmSCvZmPARnlrsXwn3uA09oXztbZzRh
         CU00yxggbMkpcOEy2pLBu4DsnTVEEgtC4X7q38wGUQoSIVcRfobDVnysASc4Tn7jSmPz
         Ri+6XWEVbkUDnGJkBO/LLPfQU6Eg3Vmf2V1OHT8GzXznYrwDnZG5zoy7Ge/A3IvFq4KM
         P/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNHdvFqH7RmVudOUs67Jz5dt0KxwBdgyqp7eCOsiZvY=;
        b=od5B9u6CxCbTVXHpIgRQX7Zdy07CBCDwQsgxKs8Z8Jna1Jg/s71r2HuHC0imVDda8w
         AvAC8vPBVDGt1EQ9rY22MAFlwCbrrqcDmAz3XBgcbxEaEuCVejHMBVRkgSR8p9IEVRTe
         GtRIviETro+ULOgkVjCSZ3Z8S6POQGtZ7d+Zh+sokAd08bS5jNXKOkLbqwjONCM3T/EA
         jbKuJrtL6I6LEiOR7DTvXGOoDGF33NSuCBNab4DLSAJmDBgZjSogBOKG9SOrp2u6L147
         vkWX9hI3OG+gkf8pkw8fM4rolfqZ/ab0vYsDNLeBwXEJDz8hIzStx1VXJuUVNRulvvxu
         5IHg==
X-Gm-Message-State: APjAAAWTeL4zbxzsxD70TORmtxA7AL5zisstfJNR90KV5shXutJPxQC3
        tFjZVyATSwYVI8XuFd8EKXSKVvlQPQdYdrsEb4Q=
X-Google-Smtp-Source: APXvYqw4FRs48iO09ajElX4qZWhBCDlmOTINQKjhJx9bbT82WDYK+FetAAFAzpslpKQazj7tg7ZPJflQHgsr9IvzXg4=
X-Received: by 2002:ac8:7445:: with SMTP id h5mr187024qtr.53.1566544949262;
 Fri, 23 Aug 2019 00:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <1565166487-22048-1-git-send-email-yhchuang@realtek.com> <20190823063728.14117-1-drake@endlessm.com>
In-Reply-To: <20190823063728.14117-1-drake@endlessm.com>
From:   =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>
Date:   Fri, 23 Aug 2019 03:22:18 -0400
Message-ID: <CA+K+NcSYKEkdx5ux6iwUs7pMidObZBrg9yDcP1zT73DcccpDPQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: pci: enable MSI interrupt
To:     Daniel Drake <drake@endlessm.com>
Cc:     Tony Chuang <yhchuang@realtek.com>, briannorris@chromium.org,
        gojun077@gmail.com, kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 23, 2019 at 2:37 AM Daniel Drake <drake@endlessm.com> wrote:
>
> > +     rtw_pci_disable_interrupt(rtwdev, rtwpci);
>
> I checked the discussion on the v1 patch thread but I still don't follow
> this.
>
> You're worried about the case where we're inside the interrupt handler and:
>  1. We read the interrupt status to note what needs to be done
>  2. <another interrupt arrives here, requiring other work to be done>
>  3. We clear the interrupt status bits
>  4. We proceed to handle the interrupt but missing any work requested by
>     the interrupt in step 2.
>
> Is that right?
>
> I'm not an expert here, but I don't think this is something that drivers
> have to worry about. Surely the interrupt controller can be expected to
> have a mechanism to "queue up" any interrupt that arrives while an
> interrupt is being handled? Otherwise handling of all types of
> edge-triggered interrupts (not just MSI) would be overly painful across the
> board.

That's my understanding as well.
entering the interrupt vector clears the IFLAG, so any interrupt will
wait until the IFLAG is restored, or delivered to a different CPU.
wouldn't it be safer to enable interrupts only _after_ registering the
handler in the "rtw_pci_request_irq" function?

regards,
Jan


>
> See e.g. https://patchwork.kernel.org/patch/3333681/ as a reference for
> what correct interrupt controller behaviour should look like.
>
> > +             ret = pci_enable_msi(pdev);
>
> pci_enable_msi() is "deprecated, don't use"
>
> Thanks
> Daniel
>
