Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCF117E0A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLJDFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 22:05:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34936 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfLJDFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 22:05:18 -0500
Received: by mail-qv1-f67.google.com with SMTP id d17so3605732qvs.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 19:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3giDwDeC6cFrb5tnzxmVe/3PcTDv/YyjRzIsUh0/m0=;
        b=fb6wAlfBN9S5OqrA8G8R+GZh3sUmQ8hpXCtJxP43NbH/caw7lt+9HHbrAUmUUdxWAf
         5cxxgSFIxwctPRQPbtTYdKO6tZpfIw5Cqgh7e/nenw+PvLhuqYxHxvUONwQ3NWaiks0T
         cv13srMxykkgEs5oWw1XnMZoRGjC6+HrtEG0PaCPhTsmi3trOv2uMBJD9sT84oif9TbQ
         /nQ78LHqi2JANImrr3Ovt5xsqn6xI/texDM2b+cVHL2egfRBJP+DkKtLhgi/lgAAeoiQ
         g2VRNj2uwldWvWOv1qUjryd+40QdvVEu7m4iZul8QPPytSQ7oB2v3LonuaH4bE4LE2AX
         zfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3giDwDeC6cFrb5tnzxmVe/3PcTDv/YyjRzIsUh0/m0=;
        b=VJyZcYj7Nh30bC4fNZcuRKyTQpZAD4ylm1L8AkrJcdVZBmkcl3CoDwLp54BTf20Hwb
         ToQxYvArQffOwEF6zhAorQ1bX6/8xsHKqFvk3ywKPL+NbutKzTMy/CMS2OhosR6RqT8L
         3/J7gqhdM1JB1o3zi3JeWOoguBqICcks5Ofcc8s/ifa3TwFnkzfiq07GQpY0s5+fBmJM
         JfaK5VoHULEfxvX9/rSlxv3QAYNSXe0rkHfSKts69PdQO5aLkqnJTfrJIov1R2fQeeUC
         BEuh0IhHBO6BFYKJBehlKQ/8x+hcCYeqDbE+O0O9MCqfD0zTe81vhq8EvczPIVJVQl8K
         cALQ==
X-Gm-Message-State: APjAAAWkZVgj1xzGCVT7LBRl7IA2TarcU0g1Se+VyqIn0j9nTJfPog8O
        X9hja8WofyqJfR6HgU8AMb5163Fe418hlF1PqpCubA==
X-Google-Smtp-Source: APXvYqxfJeeKA0eXKA5CNUY00PO9XUzDRkF4LKfapwPKJPnY0IpI13h+Bhmc7x5uDIfXBnfzuDfKUDkt3Ss6NnmilSE=
X-Received: by 2002:a0c:a563:: with SMTP id y90mr27397803qvy.234.1575947117318;
 Mon, 09 Dec 2019 19:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20191209072139.26068-1-yhchuang@realtek.com> <20191209072139.26068-3-yhchuang@realtek.com>
In-Reply-To: <20191209072139.26068-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 10 Dec 2019 11:05:06 +0800
Message-ID: <CAB4CAwfUQ1M0vbaXw7Hc05nvHU7fN-_Z6Ykmbq4b+DebV5ATzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rtw88: pci: reset dma when reset pci trx ring
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 9, 2019 at 3:21 PM <yhchuang@realtek.com> wrote:
>
> From: Chin-Yen Lee <timlee@realtek.com>
>
> When PCI trx rings are reset, the DMA engine should also be reset.
> Otherswise, the rx_tag of rx flow is not synchronous to hw.
>
> Remove DMA reset when rtw_pci_start() as we added it in
> rtw_pci_setup().
>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>
>
> v1 -> v2
>  * remove duplicated rtw_pci_dma_reset()
>
>  drivers/net/wireless/realtek/rtw88/pci.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 068f1bec88e6..c394df494c95 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -486,13 +486,6 @@ static void rtw_pci_disable_interrupt(struct rtw_dev *rtwdev,
>         rtwpci->irq_enabled = false;
>  }
>
> -static int rtw_pci_setup(struct rtw_dev *rtwdev)
> -{
> -       rtw_pci_reset_trx_ring(rtwdev);
> -
> -       return 0;
> -}
> -
>  static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
>  {
>         /* reset dma and rx tag */
> @@ -501,6 +494,16 @@ static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
>         rtwpci->rx_tag = 0;
>  }
>
> +static int rtw_pci_setup(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
> +
> +       rtw_pci_reset_trx_ring(rtwdev);
> +       rtw_pci_dma_reset(rtwdev, rtwpci);
> +
> +       return 0;
> +}
> +
>  static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
>  {
>         struct rtw_pci_tx_ring *tx_ring;
> @@ -518,8 +521,6 @@ static int rtw_pci_start(struct rtw_dev *rtwdev)
>         struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
>         unsigned long flags;
>
> -       rtw_pci_dma_reset(rtwdev, rtwpci);
> -
>         spin_lock_irqsave(&rtwpci->irq_lock, flags);
>         rtw_pci_enable_interrupt(rtwdev, rtwpci);
>         spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
> --
> 2.17.1
>
