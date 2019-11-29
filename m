Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E1E10D0A7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 04:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfK2Ddm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 22:33:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36948 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfK2Ddm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 22:33:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so24417541qkf.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2019 19:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adXcxNA7Td+R/yELM43Y8VQUIIxQWn12s4q7DlInxeM=;
        b=Thl1P+NZ9XgjE8B4U58VUKEXT0CTd7cETlskO0AWwwdcKS/8vvg9y1cMHBRJI1fpbS
         Py0NwOzPdn6u4MbGfyw2LnoLJEj+SartxzmURmhKIS/FbmVqT+b9oVQuDU2W0Cp1ZwEX
         qpMwvzun1VauF15Ou16krDNGtfKWCi/MWMiiwiEdGijUrqeLgRCfNwt4PAnQCSsk/986
         DqB13my8FGc9xFyNJrAHtEVa6wlC4hX+uTWee+A+J4AQgwdFD6OFHjTLIdFhfUWmuGeD
         Tmge8La9ksvSN4qT0xKGfOWpakEbQT++U1NPjUFX9sSA2HAvNAHpbfXzLCIMybUqH9Rb
         dXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adXcxNA7Td+R/yELM43Y8VQUIIxQWn12s4q7DlInxeM=;
        b=kds12M/GKQ3cgLG7ONLnsIIZ6U3L4gcTLrEttcpdwq2ZtjBryYNZlSUy3RU0hOq6s/
         h2oTMjp98HS3DYcBEdb/6LasxGMnQhgWMzd6jiU99t8OcNjYcllmP+jrpA+DZuSF8LxR
         hxN54Pl/T/mXchDb1AVI73afuk4pOuDB6rp5rC9ziUXUvgw9HJAyQMD/cWp+rMagAkX3
         ByNqDrlITT/K/mn/m9082UFAc7Ewsgtqyp/Acpd050/MzErIWuLD4VnWXz465+ActRu6
         KXWnoKrgHkFKhkB5AYHEK/Dn6pWOlT7VMOFegGgnS6udtXiqQEs1KHkcwHXqJUpmnhVf
         mTqg==
X-Gm-Message-State: APjAAAWlX5lmPE+aJpabun/PxJvNnmifMhOZMYeg/JSbPtW3zn4zDbCM
        h5nVpBMxGncvPnGJ+nLxSoWh2P+Z0XiE3DnxFfcSbA==
X-Google-Smtp-Source: APXvYqx6WkCcek4QnCWeB+FRZMEcG/Gytk4o1HtHihMDYvYGv6ilT1KPUprR3FubYtn9KnotqEUQA2HKukH5GQz4O9g=
X-Received: by 2002:a37:5256:: with SMTP id g83mr12597197qkb.366.1574998420488;
 Thu, 28 Nov 2019 19:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20191128121907.6178-1-yhchuang@realtek.com> <20191128121907.6178-3-yhchuang@realtek.com>
In-Reply-To: <20191128121907.6178-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 29 Nov 2019 11:33:29 +0800
Message-ID: <CAB4CAwfoGxxZfuDJnbrxBNGXgxfsJzFNtqCXv4ZpEQx23eZRmQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] rtw88: pci: reset dma when reset pci trx ring
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 28, 2019 at 8:19 PM <yhchuang@realtek.com> wrote:
>
> From: Chin-Yen Lee <timlee@realtek.com>
>
> When pci trx ring is reset, hw dma setting should be reset together.
> Otherswise, the rx_tag of rx flow is not synchronous to hw.
>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 068f1bec88e6..78971cefb948 100644
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
Just a little curious about that the rtw_pci_dma_reset() is already in
rtw_pci_start(), then is it really necessary to do it in _setup? Or
maybe the rtw_pci_dma_reset() in rtw_pci_start should be removed?

Chris

>  static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
>  {
>         struct rtw_pci_tx_ring *tx_ring;
> --
> 2.17.1
>
