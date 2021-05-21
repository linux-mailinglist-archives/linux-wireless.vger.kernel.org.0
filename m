Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2942D38C5F0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhEULq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhEULqu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 07:46:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F2C061574
        for <linux-wireless@vger.kernel.org>; Fri, 21 May 2021 04:45:26 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i29so4477633vsr.11
        for <linux-wireless@vger.kernel.org>; Fri, 21 May 2021 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUqGCt9taRX6PyEnCOKnq8JQtI9Kwhdrem2iqtGlg4M=;
        b=SEFLuS1U5hYfqoREJO9tqK/ELftITohb7vG9Rqh9wGAg2GLCH58O5w4LCOaj4bbdIp
         fovJ63xJvf5iFZkjZ5Sc1kElYZgh7lxj5JY7B6hPRr0ctKOIrlkgZ0SPjAREyElrdGjb
         Z07q8VzmoR6FkLFTAINS0ivPgHKDzLhQY1Dd5TaBZDSJZDCBysj8qFv/Jdyr7jrVren3
         r9MVYYGStKITeyaOpHUUV+l5fcs5EiuUVTj/ZAqh18OjKZgNuoKj/85K7Xp2FQMaQkml
         U9nEPvPHB/BJxFXH7zhTF6EpvoCJMLsxVNWDmcC/lEaRmg5DxOwvLjl2VZZr0AWb1BeL
         EL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUqGCt9taRX6PyEnCOKnq8JQtI9Kwhdrem2iqtGlg4M=;
        b=dHVIz7E9C54/QCb0AUA1sVaZtMelyRlRltXHOLp/GUyLVKqwrKrUrZxVqyduHOm5ey
         nqkSyGOeRQ4XOY5Sqd1gG3uySTkdM2h+xlpJVp/P+zAHAljx+uYMRJEv2euflVdAwd+k
         6i+s9i0MVFxvlisIEKEwIzDldYN0+mUgf/uYq1BpJOV1U2NvsDOLfUumkuHwFp6yS3W0
         H3h/unL8oHL+H7mM8phT6UTtmFFG/zUu/bg4zDjERXwe+FLklyUGfYKoQrhqoH+pNFjN
         8blI+yjZ2FW5rjYbFteKJtbaLsA7crC0z9IJYDUlCsOo3eQwzr5Lws3umiubLb4vB0Pi
         bjjA==
X-Gm-Message-State: AOAM533Ki8dx6wC++Ei/ezdVKT2nZdVN9V7C5AO1yF9j0TrDrgzfnCFy
        XdUvEIGOTZ+sReXdh3Dy6xEaWUxE6CSGTXGQG/zSQQ==
X-Google-Smtp-Source: ABdhPJzou/tWFI0Qb/PieiHr3Gco7ieWEDhoDsl7glidbDx4H+lTCsmnOCwITqldXxcMTlE5OPnF+Xnz14KoEVDDNYs=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr9553392vsg.19.1621597525574;
 Fri, 21 May 2021 04:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210509224226.348127-1-linus.walleij@linaro.org>
 <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com> <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
 <30a7bbeb-d588-4780-bd6c-d99f72898138@broadcom.com> <CAPDyKFpiXWygrBBHzGXBU2dC3SuxC3Uj868BAgagbv8FMmyGeQ@mail.gmail.com>
 <CACRpkdY9RUc78dj7sw5_A5XJwpbYROzaq1ziYmN2=cqs_AJfrw@mail.gmail.com>
In-Reply-To: <CACRpkdY9RUc78dj7sw5_A5XJwpbYROzaq1ziYmN2=cqs_AJfrw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 May 2021 13:44:49 +0200
Message-ID: <CAPDyKFr3YbHJG4+ZUiwQym54udEERSygj8=QA0FoL6U5x3S7Dw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Obtain reset GPIO
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 20 May 2021 at 01:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 11, 2021 at 10:48 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > I think this boils down to that to allow the mmc core to detect and
> > initialize the SDIO card, it needs to manage potential reset pins as
> > well.
> >
> > In cases when the SDIO func driver may need to execute a reset, the
> > mmc core provides two APIs, mmc_hw|sw_reset().
> >
> > Does this make sense to you?
>
> I think so, in this case (Samsung Janice on Ux500) the boot loader
> desserts reset so we are fine, but I think it should be utilized properly
> somehow, the vendor went to lots of trouble to put this reset line
> there physically.
>
> What is my next step? :D

Have a look at the mmc-pwrseq simple DT bindings.
Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml

If things are as simple as I hope/think, all you should need to do is
to add a mmc-pwrseq node where you specify the GPIO reset line. Then
from the mmc controller node, just add a phandle to the mmc-pwrseq
node and things should just work. :-)

git grep mmc-pwrseq should give you a bunch of references of existing users.

Kind regards
Uffe
