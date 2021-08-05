Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E245E3E1123
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhHEJSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhHEJST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 05:18:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED8C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 02:18:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so9807862lft.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4uLXn1AGtC/+MfcLgiyTSI/T9I40ie2kMxk/wKlyuPw=;
        b=k7XnMiTF7VyVC+yB8C3p7B3wtRyHrB/mEIJFIdGcPgk6uCuLxgicTTaekDqJr20aoK
         vrvzNK9b16scOqPJO1e3KivprKsRFi2s0YaXnoAFlLqZjhQvD7MHhQws2InhJz7NeUIo
         1Tc+aNzckUCbqJXByRvvrT0KtIweizo0QumEZSCKioGBf6IxINArlxqdcxbnWoWD/uRm
         6NXogGfL25sYjqMITbT8zorcYkuxFF8falI0Wc1M0aVXG1CCuCuY69SA+WmjP4SF202W
         H8nFP7R0YKO/Pl0YrOt6S2dq27j2Q20dxoYFcEYrBpUth0kIrPh08NYjU+OPNVaBuNkG
         zg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4uLXn1AGtC/+MfcLgiyTSI/T9I40ie2kMxk/wKlyuPw=;
        b=tIrm0gdaG5VEqBuWeYEwsFnLehz9mRusp5+v/prXB3wnygoKC6aS1AiTW89bpk1yLM
         mSEp91LZ/w5l7oWqFJ4gEG8KenQb5qwtIKM5rSMrVZzUQyznCIjrqkVXwRlOCAtr4Zi8
         hzpfog2UYgkqoLwtpqFEBOOYzbyjxajxET6mln3jkhf8DMpXaYXbabxYQ4vArwdSKfn8
         lxUNdtTU4u1em1ERtGDubis2knlzZTtTOHUaWzyxKAcZxs5zGMHbkAD9CL7OPQN2/mX2
         N7Tgw019jTT+3wlX9suhQIDj8z5ti7IBUkSmZ/Kicdqiu/uoBHSuszILHL47pMnlT12P
         VqnQ==
X-Gm-Message-State: AOAM533vc+Xwgf9UVr0xnGzbcJbDoUBjUJsCRiThQ+ETggZVgfYozdmc
        0l/9YZj0VjEunWmC7uPNoyDooCTuswjREFYYSTvHaA==
X-Google-Smtp-Source: ABdhPJyr4mBQsHi7eKjcLElt6HnWGpdqyEZ6sAX02TmFUR4yAw4zcypyKhmyePAqmIyKAvBM/kLQg9EAiXJnMMNdhKI=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr2844915lfk.157.1628155083038;
 Thu, 05 Aug 2021 02:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210804153434.3429348-1-linus.walleij@linaro.org> <74e24409-aeb2-5297-6888-7af2b1126ccd@gmail.com>
In-Reply-To: <74e24409-aeb2-5297-6888-7af2b1126ccd@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 11:17:51 +0200
Message-ID: <CACRpkdam=PzCf4ojxb4ASjyPBmVM8ZDWDFXqX+BukhQ+f38J0A@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: firmware: Fix firmware loading
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 5, 2021 at 3:35 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 04.08.2021 18:34, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +     bool tested_board_variant;
>
> What about s/tested/tried/?

OK that is clearer, I fix!

> > -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx=
)
> > +static void brcmf_fw_request_done_first(const struct firmware *fw, voi=
d *ctx)
>
> Is it really worthwhile to rename this function? There is no "done_second=
".

It is to reflect the actual use, because it fooled me as it could
be interpreted (intuitively) as "this is called when all firmware requests
are done" since it doesn't specify. But that is not the case, it is
only called when done with the first first firmware in the list.
Hence the name change.

The philosophy is in line with Rusty Russell's API design hierarchy:
http://sweng.the-davies.net/Home/rustys-api-design-manifesto

Yours,
Linus Walleij
