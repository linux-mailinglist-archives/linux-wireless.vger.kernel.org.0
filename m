Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581A03C62BD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhGLSlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhGLSlq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 14:41:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F202C0613DD
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 11:38:58 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s23so10842761oij.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZWI809EM0kWSYKdDeR8M3Ek3N/OKceTmzxiJRrMjv0=;
        b=U/qz5/PV6oqvmMd/Zt16iUeVPD3wWnzAUca3PgKD2HuN28lr4NPCgx6/NISCFp3Lvf
         6NnmIqLkvibjMtlj4qMqP4PURjO1zanRe/ubXj94xzlYNIrJ1A6uZsOF6LWwg/0dAY7M
         4ycBW0KE8kBx+CyIvNgS+m5OR9aU+vOSCtF2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZWI809EM0kWSYKdDeR8M3Ek3N/OKceTmzxiJRrMjv0=;
        b=HWyJOOUM7YexirIT5Li/ZzdSImBRofT9YlB+/rLXI2ILPBEQS+0eD2RHkMX4i1WSXb
         Q2FZ5qtuJTT9y6cuPpRO8CPoplAMqhZZlGJm60dxkIQsIYkvghqMuzR600kA71jqg2hv
         OUCjjJRkGZupmAZHGjgn6WAgrIk3vKIDcsGxNfotPyIzesw5hy+WbG8UqOqb28TmAywg
         BhpGMTqHFgKjmjwAd8XgEnMgTGLWEO/aQ6JQfYW9/0CEurRrTiK5Ob5FuvFE6ibW3RXE
         H3Rx/M6syZn63TUCjg+QkcrI9tSBOzDQv54/yzlQ8UHpPow5uzcZECYvt4xk1R2YzYKT
         pbQQ==
X-Gm-Message-State: AOAM530/DD7wL7ck/9Hw07855o+MTyVR9xQ/dOeNffn0JQBU/8p9uiQ8
        iPlzcJIs+YcU4y5otOpFpzVvWvdzelFVAA==
X-Google-Smtp-Source: ABdhPJx7/3TWoTmVeJzd6r4ipva/Lm6tl43VVZB39HcULp8NzBHkWD87WGn/Q+p8PCoEW5hVfJLshA==
X-Received: by 2002:a05:6808:d49:: with SMTP id w9mr154587oik.8.1626115137314;
        Mon, 12 Jul 2021 11:38:57 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id j30sm3265517otc.43.2021.07.12.11.38.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:38:55 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id z3so24760135oib.9
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 11:38:55 -0700 (PDT)
X-Received: by 2002:a05:6808:112:: with SMTP id b18mr3729139oie.77.1626115134537;
 Mon, 12 Jul 2021 11:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141634.6133-1-len.baker@gmx.com> <b0811e08c4a04d2093f3251c55c0edb8@realtek.com>
In-Reply-To: <b0811e08c4a04d2093f3251c55c0edb8@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 12 Jul 2021 11:38:43 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOC_dqhf84kP4LsbenJuqeDyKcNFj=EaemrvfJy1oZi_Q@mail.gmail.com>
Message-ID: <CA+ASDXOC_dqhf84kP4LsbenJuqeDyKcNFj=EaemrvfJy1oZi_Q@mail.gmail.com>
Subject: Re: [PATCH] rtw88: Fix out-of-bounds write
To:     Pkshih <pkshih@realtek.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jul 11, 2021 at 6:43 PM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: Len Baker [mailto:len.baker@gmx.com]
> >
> > In the rtw_pci_init_rx_ring function the "if (len > TRX_BD_IDX_MASK)"
> > statement guarantees that len is less than or equal to GENMASK(11, 0) or
> > in other words that len is less than or equal to 4095. However the
> > rx_ring->buf has a size of RTK_MAX_RX_DESC_NUM (defined as 512). This
> > way it is possible an out-of-bounds write in the for statement due to
> > the i variable can exceed the rx_ring->buff size.
> >
> > Fix it using the ARRAY_SIZE macro.
> >
> > Cc: stable@vger.kernel.org
> > Addresses-Coverity-ID: 1461515 ("Out-of-bounds write")

Coverity seems to be giving a false warning here. I presume it's
taking the |len| comparison as proof that |len| might be as large as
TRX_BD_IDX_MASK, but as noted below, that's not really true; the |len|
comparison is really just dead code.

> > Fixes: e3037485c68ec ("rtw88: new Realtek 802.11ac driver")
> > Signed-off-by: Len Baker <len.baker@gmx.com>

> To prevent the 'len' argument from exceeding the array size of rx_ring->buff, I
> suggest to add another checking statement, like
>
>         if (len > ARRAY_SIZE(rx_ring->buf)) {
>                 rtw_err(rtwdev, "len %d exceeds maximum RX ring buffer\n", len);
>                 return -EINVAL;
>         }

That seems like a better idea, if we really need to patch anything.

> But, I wonder if this a false alarm because 'len' is equal to ARRAY_SIZE(rx_ring->buf)
> for now.

Or to the point: rtw_pci_init_rx_ring() is only ever called with a
fixed constant -- RTK_MAX_RX_DESC_NUM (i.e., 512) -- so the alleged
overflow cannot happen.

Brian
