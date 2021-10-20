Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18E434DD5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJTOcs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhJTOcg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 10:32:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38FC061769
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 07:30:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y26so15444382lfa.11
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V8w9KrLOh1e4/GeU4pCFQml0fcDuxEzceReSFQbl/RY=;
        b=Z4SbQud7ZO2doXmNbDxU8eh364WpB+CytVG+jjq/n2wOGTwGgEyHbkVSFNxfBA1v5K
         Tez31O/2/krC7zuzCiFYCeyyVGeTTfK9iTRzgdFEKuYsrF0upefHM0JNNFfoFX++j9Yt
         ygq/expCumks7h7y+U2H1zsz3Svs5/gzVwsAqw/ljPpbFiJOwuUOQHtHdJPY4gaDaTRo
         o3Lx0zImErdtRXIBOe7xQwqWqo+KFQ0ow1EvsMXjlPl3H2ZDEyO6r45EEAjJFNOYj0+x
         1UkBmJewQAMB1n8URyzu9DIcA2Xb4nzwxd9qfvX3rKedFfrNtErMbJnbJVQfYMGUeBw7
         gbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V8w9KrLOh1e4/GeU4pCFQml0fcDuxEzceReSFQbl/RY=;
        b=kz25HDBu8ovJg83zqPTVpitPksAUQGxnV4fDa4EPUPWe0rIoHZAhTzLjEmughY3Qfa
         sT043c4BJGGFI6dXfPHq+0KUp2KX2SyX2wIdJLr+FL/zu54z+uryuklacy+jrxVkM1XN
         1bI+xj3cz7LuP0rYsf+mtXCrEhzj9LydqAlArpU9AWgXDuPRRXoMwYGoeBWPtXQVopLj
         9kJ9vUtX9kmr7Ecldm6ySaUH4kXx2hLAak48XyV9RZCBPlEwuIALtZX4gsAxsc2wOcWy
         Nor9yjFhfqElTd8Jv6vm15llBVpRbbLqU5xkBKGvCvmNGyggS972PUkRjaJDYw3/Qhyb
         CCyg==
X-Gm-Message-State: AOAM530YyQXZfokL0Eg4qht88tXNIq7RAI0og155HDCnxPD4spBB73yb
        OUVgrE6pKCNvfvUzAbycEbvn1h7hG0sadTCJb6Y/sA==
X-Google-Smtp-Source: ABdhPJyiRYwjpNbimgCBc8Bb0ImqExuF52wcmQN7YkfkIuNEmX2BOdjiQfUP3MJSXgo9cLEPYL8sBG21S/UfXH7Bx/w=
X-Received: by 2002:ac2:5e3c:: with SMTP id o28mr135613lfg.184.1634740220385;
 Wed, 20 Oct 2021 07:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com> <20211014143031.1313783-3-Jerome.Pouiller@silabs.com>
In-Reply-To: <20211014143031.1313783-3-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Oct 2021 16:29:44 +0200
Message-ID: <CAPDyKFpr0kpRXoUACNNSwe8pL1S9wJPjnX+GFGS1PNezKCDYzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mmc: allow to match the device tree to apply quirks
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 14 Oct 2021 at 16:30, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> MMC subsystem provides a way to apply quirks when a device match some
> properties (VID, PID, etc...) Unfortunately, some SDIO devices does not
> comply with the SDIO specification and does not provide reliable VID/PID
> (eg. Silabs WF200).
>
> So, the drivers for these devices rely on device tree to identify the
> device.
>
> This patch allows the MMC to also rely on the device tree to apply a
> quirk.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> ---
>  drivers/mmc/core/card.h   |  3 +++
>  drivers/mmc/core/quirks.h | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 7bd392d55cfa..2f73f8567e14 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -59,6 +59,9 @@ struct mmc_fixup {
>         /* for MMC cards */
>         unsigned int ext_csd_rev;
>
> +       /* Match against functions declared in device tree */
> +       const char *const *of_compatible;

const char is probably sufficient.

> +
>         void (*vendor_fixup)(struct mmc_card *card, int data);
>         int data;
>  };
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c7ef2d14b359..ef368386e711 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -10,6 +10,7 @@
>   *
>   */
>
> +#include <linux/of.h>
>  #include <linux/mmc/sdio_ids.h>
>
>  #include "card.h"
> @@ -145,6 +146,20 @@ static const struct mmc_fixup __maybe_unused sdio_fi=
xup_methods[] =3D {
>         END_FIXUP
>  };
>
> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
> +                                                const char *const *compa=
t_list)
> +{
> +       struct device_node *of_node;
> +       int i;
> +
> +       for (i =3D 0; i < 7; i++) {

We need to iterate up '8', to cover all functional devices.

The function numbers are from 1->7, while we use '0' for the
"mmc-card" compatible.

> +               of_node =3D mmc_of_find_child_device(card->host, i);
> +               if (of_node && of_device_compatible_match(of_node, compat=
_list))
> +                       return true;
> +       }

Another option, which would avoid doing the iteration over and over
again in mmc_of_find_child_device(), would be to simply do the parsing
of the compatible in the child nodes, right here. In other words, just
use for_each_child_of_node().

> +       return false;
> +}
> +
>  static inline void mmc_fixup_device(struct mmc_card *card,
>                                     const struct mmc_fixup *table)
>  {
> @@ -173,6 +188,9 @@ static inline void mmc_fixup_device(struct mmc_card *=
card,
>                         continue;
>                 if (rev < f->rev_start || rev > f->rev_end)
>                         continue;
> +               if (f->of_compatible !=3D NULL &&
> +                   !mmc_fixup_of_compatible_match(card, f->of_compatible=
))
> +                       continue;
>
>                 dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
>                 f->vendor_fixup(card, f->data);

Kind regards
Uffe
