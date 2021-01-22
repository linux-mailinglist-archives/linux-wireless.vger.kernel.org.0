Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6030107A
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbhAVW6y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbhAVW6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 17:58:47 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B9C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 14:58:05 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k8so6727731otr.8
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSUKlI/TxVBvxZgA/TlBu/ByfooAEXi29488BkAHmgg=;
        b=her47CZtywcmkgnxSKcIXXOzayKDZ7uq45J4nZNex3NN7Jh3PeeUJeKVVEcFCVtSn4
         cU0wrjtCdLwplyCGrvqBNC+1UJoIG1mWF/Df3/eCwJHGPtPCKFXSTDCeNsNz0PkrQLzy
         ibcwcEG9nO6oz9+QmRyl55v4NKGCvRwgGKNXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSUKlI/TxVBvxZgA/TlBu/ByfooAEXi29488BkAHmgg=;
        b=NQPm1+bxLHqChmW14+FE9DzxksemEq/aN9Rb3C1X1qXZ9QQiVKVrwuEtmk3DTjiDhx
         B6nqqCoRvmY9SXIUfU+EgdXCW9pyGZ37z+0w2d/x6t6FKXOFk8dGySHVh1W0AFvgEMFS
         Y5FMzBpU3WuRfyCP6ZPqGeMavewsEvkC1Kns3rAHeHnaMixw6CbUbSBrS+kUEBG6d9Zu
         OrdZYFbRURLFosHh6THOr2pmFqYopknbCgpGLx1pW1X+/PGPpb9vdQJoDiy7s0eSywd7
         C4HQHr13of60bHYvAE4ejv78du2mAm82dbxIfakVpoX5Zv0Qo/N6K7hHtIAFEB7iHzK4
         +NeQ==
X-Gm-Message-State: AOAM530YiFwA50JmIDf2YzAMJFBGgsiI04jqUgTRLKqZ4izjj0YY7Ej/
        sOCE2jmO2Qv+DAQ4x9P/er+gy1kP1lKg4Q==
X-Google-Smtp-Source: ABdhPJxVRNeom12CNrGQIHhqx8HN9JnKIAygrCAKH6maxYxMDsA2i7vzP7urFz3aylqf00Z4gEScSQ==
X-Received: by 2002:a9d:3ef6:: with SMTP id b109mr5094265otc.288.1611356284232;
        Fri, 22 Jan 2021 14:58:04 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 68sm1951817otr.16.2021.01.22.14.58.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 14:58:02 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id q205so7780899oig.13
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 14:58:01 -0800 (PST)
X-Received: by 2002:aca:ab14:: with SMTP id u20mr4732447oie.117.1611356281258;
 Fri, 22 Jan 2021 14:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20210115092405.8081-1-pkshih@realtek.com> <20210115092405.8081-4-pkshih@realtek.com>
In-Reply-To: <20210115092405.8081-4-pkshih@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Jan 2021 14:57:49 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com>
Message-ID: <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] rtw88: add napi support
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        phhuang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 15, 2021 at 1:26 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -935,16 +935,49 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
>         ring->r.rp = cur_rp;
>  }
>
> -static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
> +static void rtw_pci_rx_isr(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
> +       struct napi_struct *napi = &rtwpci->napi;
> +
> +       napi_schedule(napi);

I don't claim to be all that familiar with NAPI, but my understanding
is that you are scheduling a NAPI poll, but immediately after you
return here, you're re-enabling your RX interrupt. That doesn't sound
like how NAPI is supposed to work -- you're supposed to wait to
re-enable your interrupt until you're done with your polling function.
Ref: https://wiki.linuxfoundation.org/networking/napi

> +}
...
> +static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
>                            u8 hw_queue)
...

Are you sure you don't want any locking in rtw_pci_rx_napi()?
Previously, you held irq_lock for the entirety of rtw_pci_rx_isr(),
but now all the RX work is being deferred to a NAPI context, without
any additional lock. IIUC, that means you can be both handling RX and
other ISR operations at the same time. Is that intentional?

> +static int rtw_pci_napi_poll(struct napi_struct *napi, int budget)
> +{
> +       struct rtw_pci *rtwpci = container_of(napi, struct rtw_pci, napi);
> +       struct rtw_dev *rtwdev = container_of((void *)rtwpci, struct rtw_dev,
> +                                             priv);
> +       int work_done = 0;
> +
> +       while (work_done < budget) {
> +               u32 work_done_once;
> +
> +               work_done_once = rtw_pci_rx_napi(rtwdev, rtwpci,
> +                                                RTW_RX_QUEUE_MPDU);
> +               if (work_done_once == 0)
> +                       break;
> +               work_done += work_done_once;
> +       }
> +       if (work_done < budget) {
> +               napi_complete_done(napi, work_done);
> +               /* When ISR happens during polling and before napi_complete
> +                * while no further data is received. Data on the dma_ring will
> +                * not be processed immediately. Check whether dma ring is
> +                * empty and perform napi_schedule accordingly.
> +                */
> +               if (rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci, NULL, NULL))
> +                       napi_schedule(napi);
> +       }
> +
> +       return work_done;
> +}
> +
> +static void rtw_pci_napi_init(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
> +
> +       init_dummy_netdev(&rtwpci->netdev);
> +       netif_napi_add(&rtwpci->netdev, &rtwpci->napi, rtw_pci_napi_poll,
> +                      RTW_NAPI_WEIGHT_NUM);
> +       napi_enable(&rtwpci->napi);
> +}
...
> @@ -1547,6 +1624,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
>                 goto err_destroy_pci;
>         }
>
> +       rtw_pci_napi_init(rtwdev);

You're initializing NAPI after you've already established your ISR,
and your ISR might start scheduling NAPI. Even if that's unlikely
(because you haven't initiated any RX traffic yet), it seems like an
ordering problem -- shouldn't you initialize the NAPI device, then set
up the ISR, and only then call napi_enable()?

Brian

> +
>         return 0;
>
>  err_destroy_pci:
