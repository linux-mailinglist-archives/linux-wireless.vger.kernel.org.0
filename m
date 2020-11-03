Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985E2A3771
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 01:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgKCAGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 19:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgKCAGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 19:06:32 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA39C061A47
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 16:06:32 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l28so19765474lfp.10
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHMOmkhlRWyq97AfxS2rXTffakjk5zbzZZUU7niR7ko=;
        b=hv08MmKqPW2kwHXqrNQp2ucUSP5RIUEfSR109ZFv/+GCfvLMMs748r0m1pga8q2tP7
         NKctrAbp0S6uaLSATDuyAfO2MPnGC4c4ilXwVCDYmawkODWJXJ/TkvVBDFuStFWWuL1R
         ySxawLXlGOyaudd+de2xvN3RGV4tNKoNyIGq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHMOmkhlRWyq97AfxS2rXTffakjk5zbzZZUU7niR7ko=;
        b=aup6QEEAZIjPSyrpzwPCk+LQ0QHezBPaU5feYYgpsq0kGWKSZoES3jn+Iq9RVSyxM8
         xCefxKncPRZMqt6Brip0Hf3mJSqhIv0VR7OK8b5XXu8hZTTBKA2GpqOp34ZLtc5gT3o4
         OUj7OFIoVToyVcN+P3UtSChqwqLH1GAJlttOD4fz2TZ6fhAGNCe9fH4Rmdb+C7CoNyF2
         Vj089/Ep95R9LSy/ejuL5yh9H3FPCXIy28nnZjktGt8Ts6unOxnqLKXxBcUp7BPiop7p
         Yk0XzN4q2H95IWdC/TBvZzSBtPSE53l5yMgjhxxZO2UQvARsVLmXiJzk+FsHnWmX/7vu
         KsXg==
X-Gm-Message-State: AOAM533GU+ZIaeHBvB8Slkg0NIg7D7Ysg7wQDiHFMTQTPfTwM036f3bM
        X4x15bFnSXpZL1HAeGUSqPEicodeBJTDbw==
X-Google-Smtp-Source: ABdhPJxu2KGpLvVWhkpZf6kP3O8B+eAv1g8EV2XUOrcFUie2kxyZdH7XsNLC0vRF/hQepQ5oIoJokQ==
X-Received: by 2002:ac2:59de:: with SMTP id x30mr6271373lfn.19.1604361990399;
        Mon, 02 Nov 2020 16:06:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t66sm2912418lff.85.2020.11.02.16.06.28
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 16:06:29 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 141so19809922lfn.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 16:06:28 -0800 (PST)
X-Received: by 2002:a19:41d7:: with SMTP id o206mr7188801lfa.396.1604361987822;
 Mon, 02 Nov 2020 16:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20201102112410.1049272-1-lee.jones@linaro.org> <20201102112410.1049272-42-lee.jones@linaro.org>
In-Reply-To: <20201102112410.1049272-42-lee.jones@linaro.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 2 Nov 2020 16:06:15 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOobW1_qL5SCGS86aoGvhKDMoBzjxbAwn+QjHfkqZhukw@mail.gmail.com>
Message-ID: <CA+ASDXOobW1_qL5SCGS86aoGvhKDMoBzjxbAwn+QjHfkqZhukw@mail.gmail.com>
Subject: Re: [PATCH 41/41] realtek: rtw88: pci: Add prototypes for .probe,
 .remove and .shutdown
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 2, 2020 at 3:25 AM Lee Jones <lee.jones@linaro.org> wrote:
> --- a/drivers/net/wireless/realtek/rtw88/pci.h
> +++ b/drivers/net/wireless/realtek/rtw88/pci.h
> @@ -212,6 +212,10 @@ struct rtw_pci {
>         void __iomem *mmap;
>  };
>
> +int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
> +void rtw_pci_remove(struct pci_dev *pdev);
> +void rtw_pci_shutdown(struct pci_dev *pdev);
> +
>

These definitions are already in 4 other header files:

drivers/net/wireless/realtek/rtw88/rtw8723de.h
drivers/net/wireless/realtek/rtw88/rtw8821ce.h
drivers/net/wireless/realtek/rtw88/rtw8822be.h
drivers/net/wireless/realtek/rtw88/rtw8822ce.h

Seems like you should be moving them, not just adding yet another duplicate.

Brian
