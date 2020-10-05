Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BAB283DF3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJESEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgJESEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 14:04:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE08C0613CE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 11:04:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u8so13434283ejg.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQapKerqEPOfWjuVkuWjhpBPHOAY0WMdQww5oZQ+egs=;
        b=OXKb2fbfDYHdc1AbGUIMBgMPVh7d7kxEbrnogtA7tkBCFR9wFHBTnbowM3BhSEljnh
         UEswPIgw4X463SChT4PQxD9A/LlhUfYNQWfSbDf+C8TBTKfDBnzK13OEqez3jPckrVjv
         qUxSB2BhkFOZGyy2nFmMHm6nnRfP1HV8q//vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQapKerqEPOfWjuVkuWjhpBPHOAY0WMdQww5oZQ+egs=;
        b=rM0JgIRDNYFSHDdyB+mS7fkxuuHlfgVvOCZz00FWPSgXZqzTqF8EGuSCD3zLVjprPA
         yWyLpZXDQK8z3+teUW2nDiPTbRi8RXzB/xVRN8JZwosNjkuB/L/7p4I2pPf+BulKPgBG
         72oyI8hveaR7OJ2cU2ZAVrWLShHnWRuWgC6z45X/NyPQoED1Olcvvr8sclZA4sj7bz1x
         C2K7PMxEyVFm61/VaiBZmEo/8svShlKbd3lTmQb2hFQbs8/ItG3qWkkJvGQ0VeZHlu3x
         +Cv3nx1xVJgN33cqmA77uVY1Jz4CmtKlfrdKzTFqgad931A/5K7knHKV6StyxJ9wBkO8
         Kb9g==
X-Gm-Message-State: AOAM530T6ufC4qrSVfezgZlDPX1YgMF3K/zkCTkiZYzMP7zzN/p75dOo
        yjuTe3j3loJAgAacInO6SnALRAzoIf4pow==
X-Google-Smtp-Source: ABdhPJwEiM5G2EJaMReVztlgaHaw+IPLWhmju1rJ8ao4VgCYFQjfJByribv+dFRfeXUADA7BQhVWBw==
X-Received: by 2002:a17:906:940c:: with SMTP id q12mr956520ejx.195.1601921044980;
        Mon, 05 Oct 2020 11:04:04 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k13sm373095edj.92.2020.10.05.11.04.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 11:04:04 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id l24so10437271edj.8
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 11:04:04 -0700 (PDT)
X-Received: by 2002:a19:414b:: with SMTP id o72mr224618lfa.23.1601920723274;
 Mon, 05 Oct 2020 10:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201004131931.29782-1-trix@redhat.com>
In-Reply-To: <20201004131931.29782-1-trix@redhat.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 5 Oct 2020 10:58:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOrr7k73mOizNGxPxXQ=bHEMUbTtCnoEusj2vRAaRPufA@mail.gmail.com>
Message-ID: <CA+ASDXOrr7k73mOizNGxPxXQ=bHEMUbTtCnoEusj2vRAaRPufA@mail.gmail.com>
Subject: Re: [PATCH] wireless: mwifiex: fix double free
To:     trix@redhat.com
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        ndesaulniers@google.com, linville@tuxdriver.com,
        Nishant Sarmukadam <nishants@marvell.com>, rramesh@marvell.com,
        bzhao@marvell.com, Frank Huang <frankh@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 4, 2020 at 6:19 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem:
>
> sdio.c:2403:3: warning: Attempt to free released memory
>         kfree(card->mpa_rx.buf);
>         ^~~~~~~~~~~~~~~~~~~~~~~

That's some interesting static analysis for a compiler.

> When mwifiex_init_sdio() fails in its first call to
> mwifiex_alloc_sdio_mpa_buffer, it falls back to calling it
> again.  If the second alloc of mpa_tx.buf fails, the error
> handler will try to free the old, previously freed mpa_rx.buf.
> Reviewing the code, it looks like a second double free would
> happen with mwifiex_cleanup_sdio().
>
> So set both pointers to NULL when they are freed.
>
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Tom Rix <trix@redhat.com>

For whatever it's worth:

Reviewed-by: Brian Norris <briannorris@chromium.org>
