Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F331323EB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgAGKkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 05:40:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33086 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgAGKkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 05:40:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so54074925otp.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2020 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOSsP5w7ArOQdKi1+vWZxS/I1CmqWkexlUqev11qtoc=;
        b=Nih3GoPMshrT5wTqgo7vz2a5hUIeqntNNrQec+ktEP5JH7LSHBcHVN9QR+BCh1YyYp
         97PfwktOgxCC1Lsn8Bp7JJU52BvpcXkaB6fxJAkL3kMWG1AmvF+ty7DQi10feuHmANxg
         FsZYyPFJRoISC3SizuNritOPKTd91H/+w/4EpE/UgFj6GfVbV1FzNvR31d6E6Cl9x0On
         oowFU0ONstOfrne3lW6SB7U8LJZNwhOu+zoWuz2ZbOJmD050GsEdXstgoaAMVULvgWtp
         vkS3mVBJv5+UpHyrWhvI8AzQr6Nn0rD8sPd6guKhtylvaJhT1sO5z6M31SGbr3E2fqU0
         Kqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOSsP5w7ArOQdKi1+vWZxS/I1CmqWkexlUqev11qtoc=;
        b=qnXYzkpRIR856hmnHHBnXeyq1FeLOnFZkV+kBk3gM9OURJUZylz6Yd84Ps2izeeCiw
         NOTpkWayHtX0RK2j9QzHf6OP5ojwpdWtpJJuWZdtr9Ba/fXm1c55moR2/0Mx/XgRCMt4
         GXlMsJUNduka8ajnol0brivZMNyt6xo4ccd6ofV19GKzuJD/PIHF8olFjqMiP6xWIZ8F
         vDVCr7pKIYI0EhFeXwoZBm2xHAcxe1Y+WnzdaLbpgfrDVWPFjE0nqX4g5t4m6RUDjwae
         iou6QhrT1Q4fu/TTDkE1E1ksdIhC4LLmzEMMUwg1htxaeA9KelTI4BuZSGLMNKNbVdCs
         ATCg==
X-Gm-Message-State: APjAAAUC6KVWRM/I5AI4u4IiNcnvQ84WUnp7il4rVdlrwPPobahSEG1j
        j7M1N80coE0Ibjp5loEIMYXemeaPujI+Xv7TRIzh2w==
X-Google-Smtp-Source: APXvYqwQrWpoFybDJu8Hn14uxn76c4kUMf+Ev2xRshKBdwqksbprYAItOzcBNnD0zSZQV65uTkqruxsro4omB6wl/xg=
X-Received: by 2002:a05:6830:1689:: with SMTP id k9mr125365761otr.311.1578393634943;
 Tue, 07 Jan 2020 02:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20200107080807.14433-1-yhchuang@realtek.com>
In-Reply-To: <20200107080807.14433-1-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 7 Jan 2020 18:40:24 +0800
Message-ID: <CAB4CAwfxQJzsJfxScVE+Y_xYbdSigTf567b9Xv-LFyQQnOXEAA@mail.gmail.com>
Subject: Re: [PATCH] rtw88: fix potential NULL skb access in TX ISR
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        mikhail.v.gavrilov@gmail.com, rtereguloff@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 7, 2020 at 4:08 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Sometimes the TX queue may be empty and we could possible
> dequeue a NULL pointer, crash the kernel. If the skb is NULL
> then there is nothing to do, just leave the ISR.
>
> And the TX queue should not be empty here, so print an error
> to see if there is anything wrong for DMA ring.
>
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index a58e8276a41a..a6746b5a9ff2 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -832,6 +832,11 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
>
>         while (count--) {
>                 skb = skb_dequeue(&ring->queue);
> +               if (!skb) {
> +                       rtw_err(rtwdev, "failed to dequeue %d skb TX queue %d, BD=0x%08x, rp %d -> %d\n",
> +                               count, hw_queue, bd_idx, ring->r.rp, cur_rp);
> +                       break;
> +               }
>                 tx_data = rtw_pci_get_tx_data(skb);
>                 pci_unmap_single(rtwpci->pdev, tx_data->dma, skb->len,
>                                  PCI_DMA_TODEVICE);
> --
> 2.17.1
>

Maybe we can simply do 'while (count -- &&
!skb_queue_empty(&ring->queue))' to achieve the same thing?
I don't think it worths to raise an error unless the count is expected
to exactly match the queue length in any
circumstances.

Chris
