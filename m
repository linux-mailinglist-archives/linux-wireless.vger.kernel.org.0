Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B003E10F4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhHEJPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 05:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhHEJPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 05:15:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5857C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 02:14:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x9so4199312ljj.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fFXN1GDx+ZY9KtgSWo8Ue+Fd8NB20QdYpM/y0IVYDbk=;
        b=cBiXIjV2mnr0k8pAM8Nrz0D+Ru82yIscVI5XOIrTwmvCcuovZIPLz964rmtrnT4Tf5
         UTZXYMS4am7p0yo2N+6SouOvZk9h/N8WJDXXNeByaYVPK97kvGRW1Gc4F8mBsiQy2JcP
         GJYzPYGh//0nHeteH8OZx3odyqQYtsW4APl+vPDFrg6f3Fmxphg042H7eZ8sq9SvIoJ1
         FwyDRGRmshBHvBZJOVUz1MM3DUhEfiB50xWm0EN77rJk5xHPC6tGrVVfLymXYKFCxbUf
         lWEfmz6OhHdzgIPJd9LZJl1G0zFyvhsNStTV3IMlVrAbSP8mW8/6Bd0+N6emm2/UGjxw
         3ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fFXN1GDx+ZY9KtgSWo8Ue+Fd8NB20QdYpM/y0IVYDbk=;
        b=KxUwOMKgTpi/HwjyHnGlDn2OD3p/YKWNwvueDjIlkUtoJ2yISBmzO5S5CMb5wThNRC
         hI/v7mml5lCXSuNnWg7J8d79SYcenk2Giw+xVSDZpmSHlRZMreDFhOKgDKnNSko4mxa3
         IYloJxwDIcE9B1w8NUoh+BJ10AlQ+UVsypsRF8R2yO39tnMp1WBTJwD6ZRsAK9S1JzXk
         JkH/HndwrdqV0tbI2lw8gSVenjMdr06xjLAzqjX/6G+lKM8F8W9GZLPFdZ8nh/CPzhnE
         e/GZDTyVMK+G/WaA3JT8oLI7dqBnsp1IGM/O0ERJh8n97xmAqrX87Fl72jvrSKQn40L7
         23jQ==
X-Gm-Message-State: AOAM533t9drjhDEvhY0+qdb2z0zYfDdW736DuEBjfW75nLsfYmFf3F90
        pHTlZRIUIShWQggcgV6ruLmVNuvA/raKcWslmtrRTg==
X-Google-Smtp-Source: ABdhPJyLpUwapWwaaef2IJDSLgnKOxm9QR3qNDKinFingvDlLlotPP5pEeuvIhtSrZk1WedT+d1iytHOd9IlJ4PhklA=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr2476741lja.200.1628154891272;
 Thu, 05 Aug 2021 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210804153434.3429348-1-linus.walleij@linaro.org> <67ba8440-8f39-daa0-ef39-e506007fd46a@gmail.com>
In-Reply-To: <67ba8440-8f39-daa0-ef39-e506007fd46a@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 11:14:40 +0200
Message-ID: <CACRpkda+4CTeBpdFru82ekkF=PcN-5yGQtPBWuwXhE3biewoLA@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 3:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 04.08.2021 18:34, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +static void brcmf_fw_request_done_first(const struct firmware *fw, voi=
d *ctx)
> >  {
> >       struct brcmf_fw *fwctx =3D ctx;
> > +     struct brcmf_fw_item *first =3D &fwctx->req->items[0];
> >       int ret;
> >
> > +     /* Something failed with the first firmware request, such as not
> > +      * getting the per-board firmware. Retry this, now using the less
> > +      * specific path for the first firmware item, i.e. without the bo=
ard
> > +      * suffix.
> > +      */
> > +     if (!fw && !fwctx->tested_board_variant) {
> > +             fwctx->tested_board_variant =3D true;
> > +             ret =3D request_firmware_nowait(THIS_MODULE, true, first-=
>path,
> > +                                           fwctx->dev, GFP_KERNEL, fwc=
tx,
> > +                                           brcmf_fw_request_done_first=
);
> > +             return;
>
> The original code was proceeding on error. Is this a typo here?

No, we are testing specifically for fw being NULL and in that case we issue
a new request_firmware_nowait() call with ourselves as "done" callback,
so we really need to return here.

The worker will call the same function again after this but now
tested_board_variant is true.

Yours,
Linus Walleij
