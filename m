Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98D3E1144
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhHEJ15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHEJ15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 05:27:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E103C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 02:27:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a7so6171037ljq.11
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hL26yHOhw1C0P6uqdCGDAIN4iA8hDZQju3wZ2sJAocQ=;
        b=Mq8L8ExV56AclIfwXPGNPai4cblMb9qaQctaht+oXMrpbY/vvHcqiYr/V9+tvRvFp2
         8j8IOL4Tf79OWLuk4kGdy5NF6E10Kp2yyrA2NIH4hGFT0ZHz8i1hmIIMXdHZtEv0Kmed
         ArXh0I9aWOwgfLZKLsD6LFPjTpFQ2JL7Em2UclFwWmhCyd3p46d5Z5eaEMKnTpe7hxzB
         VHu8EOVZJfJKeT8C2pkcQ8i29Ym9zbEAqZk89n7WX5mZwSY63v72aCNEMPszX962rVlo
         uqzdPw8YnnSlppj8wfnJPi7JHmTWceAA/llIP36FXGRl9OXZFHpHOnomF2tWRyXrMgzS
         tu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hL26yHOhw1C0P6uqdCGDAIN4iA8hDZQju3wZ2sJAocQ=;
        b=QJVXpRpMVz1gAk5VuJxVKIMLx3vKrkuAn74xrvq3FDRwKH6847LOhWuxZ+KjJ7DbPx
         meYNXTJm6DxxXuSvHF4njzCqACKrT/fUF5jAJUbhTR3kZJO8zhNasSj+A54KfcoLXvEw
         Y5e5TNNEj6GoU2BdYnh9uWQj5R6OccCVzbXVJUwu6kuiKQj8NpZ23mAK/NPV6OGBhpaX
         hhkCr3z1oaCZD90iqURgfaIPW1+jOTY+2x+GvT5zmGNncJ2Fx3MwDF5OmXKFukeoZq+W
         4a0bvFW8Dc0UH6TxtWFf1ok4PFQUOuOSxmKz95aREqUXqTdEdTp78HS+UziMbYAjvRzh
         EX0w==
X-Gm-Message-State: AOAM530lTXaHgwK3u1BkwDtYMlwqPa3y37LtTdQCox1XGishCW2B7WsI
        81LS8dAYSTDa+c7NXMvQjaEKW76Lf0TK8E5BDwjWOg==
X-Google-Smtp-Source: ABdhPJzM6pI6v9xQQr4g18oEm/HYbjw8QzWXL1izSg1JLY+52wNvR1FNhDLLtvEdknIJFVS4UPe9IbjzAvuS7pED5GE=
X-Received: by 2002:a2e:7c04:: with SMTP id x4mr2540382ljc.273.1628155661827;
 Thu, 05 Aug 2021 02:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210804153434.3429348-1-linus.walleij@linaro.org> <0f439074-83ea-087d-7eec-aa6d4d3d4689@gmail.com>
In-Reply-To: <0f439074-83ea-087d-7eec-aa6d4d3d4689@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 11:27:30 +0200
Message-ID: <CACRpkdY_PrEus+DQ7PKH=1E5eMsDAS=M6ObB97TKUeP-vzeFZg@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 3:44 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> 04.08.2021 18:34, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +             fwctx->tested_board_variant =3D false;
>
> This shouldn't be really needed, isn't it?

It is true in the sense that fwctx is allocated with kzalloc.

But it is done in a different function brcmf_fw_alloc_request()
and it is not entirely clear that the allocated struct is not reused,
and if someone refactors the code they could reuse it, so I add
this just to be 100% sure that this gets set to false.

Usually in the kernel when we have functions named *alloc*
it is allocating objects that can later be reused several times
(see the block layer for example), so I try to follow that pattern
here and assume that fwctx can be reused.

The only time I really rely on fields being zero is when the
allocation is in the same base block, e.g. inside probe() or
so.

> > +     } else {
> > +             fwctx->tested_board_variant =3D true;
> >               ret =3D request_firmware_nowait(THIS_MODULE, true, first-=
>path,
> >                                             fwctx->dev, GFP_KERNEL, fwc=
tx,
> > -                                           brcmf_fw_request_done);
> > +                                           brcmf_fw_request_done_first=
);
> >       }
> >       if (ret < 0)
> > -             brcmf_fw_request_done(NULL, fwctx);
> > +             brcmf_fw_request_done_first(NULL, fwctx);
>
> This "else" can be replaced with:
>
> if (!alt_path || ret < 0)
>         brcmf_fw_request_done(NULL, fwctx);

Sorry I don't quite get this... both branches of the if/else clause will
assign ret also if alt_path is set request_firmware_nowait() can return
nonzero and then brcmf_fw_request_done() needs to get
called?

Yours,
Linus Walleij
