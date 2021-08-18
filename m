Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98CD3F0D24
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhHRVJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhHRVJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 17:09:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE06C061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 14:09:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i28so7597437lfl.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjXrcIOgVKk1mPzvCDdPM89T7IRAJPhj3erq4tB0vv8=;
        b=IAGuXZNBtJmAbMdUhqC7E8KnSq78nSFb7TeRpra2h/nIwoCi4li37yOLsIAfpFhzAG
         ElR1A1zxGPsnh/weuzxoVwIypaI7o9SkS4eLUn+znPLeUpI4k8lbZLzKsuWg6XaaTnNE
         nKVr0yMeh/s+mxNcJL5VifZx0Z388DvO8d8aEgUVVRXGJzl/XGm13d4/cRLKe5KP7Ynz
         7hjo0dTJg4VdEEOyITpL5jeFeUVLpbz0UaJM8aYEoGfizl2uWC9+/A4x3TQOKdOrpy2c
         DU7JBmblBuEaxYxvrZdpmFB/EuyrFDuASnYqGIhhHvhNJVy2dVPthUGp7peZi4L9J3bn
         TqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjXrcIOgVKk1mPzvCDdPM89T7IRAJPhj3erq4tB0vv8=;
        b=Dm/Ice+jN8bQZLsreKSDaoPm772pKUoplxECZ4258SMrNed64UOWe54HoJwiYLstyz
         bJaU0s3UP0K9VAH9cxnv9gYYuPK5JYPMaUodAPGWt8QO4UsZ5MoYHrwbZz7rUZLxxmBr
         r+mipnvieUzyPuCEr6I/VGoRhuM8t2/AUzenIoclvl89NvYGxuwdBJrsN3IqgGzht28n
         n1rSzjL9lUQoUTkR1j+RVLZKHEEOFZz1rTfOPMnuv2nGnF2O4HAeUdtOLSZRT750iHUd
         CKajzAHL3dOgbkpSegk6qZVMovYKcl3a/WjvSKcwAcU29odZvezR7djahXZbQpWV0fWI
         nxjg==
X-Gm-Message-State: AOAM5316BAXJKsjmoOENjTa9Z94vzxWPQoJFo1LtT31QjufcatWaCVZS
        mb6AnWVCwYi/xQmb/PH/jkBYaM9kY7/d6wWTKQs=
X-Google-Smtp-Source: ABdhPJyMnPkX2OEHQPBg6pvpnH5zUk/Eiteuhlum86nkFXZ4lKjx6flrkhBXLBbliC9RkX3DvkG9kJD2G4wA30j6eqU=
X-Received: by 2002:ac2:5b46:: with SMTP id i6mr7436547lfp.500.1629320952285;
 Wed, 18 Aug 2021 14:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210818150943.1630199-1-festevam@denx.de> <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
 <369c1f89-df33-455b-773e-a2e0dbf582ff@eero.com>
In-Reply-To: <369c1f89-df33-455b-773e-a2e0dbf582ff@eero.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 18:09:01 -0300
Message-ID: <CAOMZO5DQTArbXjAdxh4cmtwPfRS9UCiAiQeRQHhjqLpEOUxsyA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
To:     Peter Oh <peter.oh@eero.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, erik.stromdahl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

On Wed, Aug 18, 2021 at 2:35 PM Peter Oh <peter.oh@eero.com> wrote:
>
>
> >> Fix the problem by not calling dma_alloc_coherent() when the device
> >> is not DMA capable, such as SDIO and USB.
> >>
> ath10k calls dma_alloc_coherent multiple places including
> ath10k_htt_rx_alloc.
>
> Do SDIO and USB not use such data path function at all?

Now that I look closer:  no, SDIO and USB do not reach the
dma_alloc_coherent() inside
ath10k_htt_rx_alloc.

drivers/net/wireless/ath/ath10k/usb.c and
drivers/net/wireless/ath/ath10k/sdio.c both set:
bus_params.dev_type = ATH10K_DEV_TYPE_HL;

ath10k_htt_rx_alloc() has:

if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL)
     return 0;

So it returns early in the USB and SDIO cases and does not call
dma_alloc_coherent().

Thanks
