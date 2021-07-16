Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A73CBAD7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGPRBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGPRBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 13:01:17 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B9C061764
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 09:58:21 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so10504255otf.9
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zF6RFynJImZVZ9iauRKVrADk1+eSALtVWbPASLHhoSw=;
        b=CYfZq/00WLjjWY1y5nRSBmHv2gLKV/HPnda9tFP2NnVUU0Wmm+FGSaRVjx7ugR8Wu8
         gVqOAn49/fcLFt2j5zQor/oTx+Jc8rdVjMNfSyuGOUUPuFt7FC/Ok1UjIuCgrVE4R1wQ
         g97bIBeGzSYqzNZwtdBTzPpYJlV55FMfIxS5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zF6RFynJImZVZ9iauRKVrADk1+eSALtVWbPASLHhoSw=;
        b=aOtL0hkqVXo4BsmPC4zPKdCltSNjTqmJZfYomABJ0dLCMWp6C8z25E1kIVVEt1rf/y
         uYLBanaREJAf+4yswZpCMhcDyEmBB9c1uFRVfmBXhjs65WtNETySaD/MPEFWrr/DNptZ
         xsUKzb64FU+yOZ97337R7hApCBW217l/wHPyENxJ2O1L7mFq1Hyqi8eHSaJjPc1x4N7w
         cLMhRrYf9bi4f5MOL2zZ05jrnd3QjJKBXnYK62+If/cWXy0BKFZSrYfoUUDincd/5Tkp
         +T0MGzpDcruCFdPdJgCqBXhI9rN83oau26c1OALd14yyKVtZdWAXpHs2tv3sAWsnCcwr
         maiQ==
X-Gm-Message-State: AOAM5329mjlVhLr+NzAKS+NciZEUyCNT9/0tHG+xkSfK8yMX6wLDUh7J
        7xRT+hnf94Fmln9k3l+uRgPbTKWsUfhPPQ==
X-Google-Smtp-Source: ABdhPJwp/BFipmIPMpyefAZFp6LOUo/QDUCU3lkC99ZOtU6YJ76nNG0ypZv5LONVFHpYhzZhWu+hww==
X-Received: by 2002:a05:6830:40b6:: with SMTP id x54mr4797152ott.290.1626454700478;
        Fri, 16 Jul 2021 09:58:20 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id r16sm1083839otu.26.2021.07.16.09.58.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id p67so11637683oig.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
X-Received: by 2002:aca:304f:: with SMTP id w76mr11034037oiw.77.1626454698098;
 Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210716155311.5570-1-len.baker@gmx.com>
In-Reply-To: <20210716155311.5570-1-len.baker@gmx.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 16 Jul 2021 09:58:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPSL4bFpyjRYGEOG=Df8dOXc19LYBO06wdFN_k8OkiwKQ@mail.gmail.com>
Message-ID: <CA+ASDXPSL4bFpyjRYGEOG=Df8dOXc19LYBO06wdFN_k8OkiwKQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: Fix out-of-bounds write
To:     Len Baker <len.baker@gmx.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 16, 2021 at 8:54 AM Len Baker <len.baker@gmx.com> wrote:
>
> In the rtw_pci_init_rx_ring function the "if (len > TRX_BD_IDX_MASK)"
> statement guarantees that len is less than or equal to GENMASK(11, 0) or
> in other words that len is less than or equal to 4095. However the
> rx_ring->buf has a size of RTK_MAX_RX_DESC_NUM (defined as 512). This
> way it is possible an out-of-bounds write in the for statement due to
> the i variable can exceed the rx_ring->buff size.
>
> However, this overflow never happens due to the rtw_pci_init_rx_ring is
> only ever called with a fixed constant of RTK_MAX_RX_DESC_NUM. But it is
> better to be defensive in this case and add a new check to avoid
> overflows if this function is called in a future with a value greater
> than 512.
>
> Cc: stable@vger.kernel.org

This kinda seems excessive, considering we absolutely know this is not
currently a bug. But then, LWN nicely highlighted this thread, which
reminds me that even without the Cc stable, this is likely to
unnecessarily get picked up:

https://lwn.net/ml/linux-kernel/YO0zXVX9Bx9QZCTs@kroah.com/

And I guess silencing Coverity is a desirable goal in many cases, even
if Coverity is being a bit trigger-happy.

So, *shrug*.

> Addresses-Coverity-ID: 1461515 ("Out-of-bounds write")
> Fixes: e3037485c68ec ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Changelog v1 -> v2
> - Remove the macro ARRAY_SIZE from the for loop (Pkshih, Brian Norris).
> - Add a new check for the len variable (Pkshih, Brian Norris).

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.
