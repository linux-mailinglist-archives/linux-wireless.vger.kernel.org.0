Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168C33DFE2D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhHDJk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbhHDJkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 05:40:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A2FC061798
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 02:40:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l17so1873930ljn.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dwt1pPxaPlppnEdG2BBARqg+gr0qeyGOYTvgq1+24I4=;
        b=TKYJ3vhtDJpHViw53658tSsP/2Ny7Dzfcrp16GZt7l3OPk+yTni2/0bxZjeZmzwQd7
         HrqTjcUJ59ns8m6fubf3plRKASTH8gGPywRiji0tdIvjGsgUQqwzPD3KGuLFpnh7PMsI
         X5yNWwVehSx22lbrTu99WnA9T0H7GV9G9CWKu0+EW7g6AVj8dx5ysX5uVxSpqNLRwwDX
         cTj8AowCzEDRLOd/nAT6kJfLGgvF09C6GAPX79TZVZKZlMszZlXDxE8YM0HOetbCaNo9
         Dqui4J7H3FZN2kjmtyXjlFxeZnUpuvnSc+uBFuEwgBG0gooNc7/DA4g0Bt74pWOFjvhI
         1Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dwt1pPxaPlppnEdG2BBARqg+gr0qeyGOYTvgq1+24I4=;
        b=L2h8BuxNWMP5g06n/CJ0tfhnJXY66Yr1TkTRBNbdU9pzuAND8u+KGtA9ZlQszfl7yL
         qWMG+rZ0WEJTE5XKxEGZaKh7gJ6dYaZRFdPDeoNi0bjBG+3fq3OcYU+0BhhbiQshrrac
         1R1B539NCNNLw1nknzWDI8LdjCVNbM21tQjb8JbDmCmWb/hliFBQwJkbw3skIwQYTMf5
         OomgDoO9TeNAn/VaMEb8u3SRkSBkosHDjWa6gcj+BodcBYUvxknb8CRjr9Il9FqP2t4T
         PT7UrSRixDEExEGXxHpULKZS9/V2OIvYm0zbMd2seJMnd4iXJLo5RR4kzRcbyerTLLhH
         ayIw==
X-Gm-Message-State: AOAM5307zmIgZvY7O4GOCp3/COZ+oGulT6vKAPHvodq1YjQV08+rI+r3
        itWilARNblBilPZN7Wx/M3Yl/3EzuDGTuwCRLHyKCg==
X-Google-Smtp-Source: ABdhPJx0yVHn+0/LjY8mjyTRVXlhmqLZHqwyttvFKqsMg34/DYMTPoH4VFFhU/I9ApQLOL5R/669b4+a7tzG2XXVjxE=
X-Received: by 2002:a2e:b819:: with SMTP id u25mr6449140ljo.438.1628070008760;
 Wed, 04 Aug 2021 02:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210804082348.GA32730@kili>
In-Reply-To: <20210804082348.GA32730@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 11:39:57 +0200
Message-ID: <CACRpkdYfc7oRV9OWQayATU90fcP_q0fQZEgY7C1hLBxpvszezQ@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: uninitialized variable in brcmf_fw_get_firmwares()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 4, 2021 at 10:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "ret" variable is used without being initialized when "alt_path" is
> false.
>
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan!

But yesterday I sent another patch which incidentally fixes
this too:
https://lore.kernel.org/linux-wireless/20210803232746.3389570-1-linus.walleij@linaro.org/T/#u

As you can see in the last hunk of that patch ret is now
unconditionally assigned on both forks of the
if/else-clause.

Yours,
Linus Walleij
