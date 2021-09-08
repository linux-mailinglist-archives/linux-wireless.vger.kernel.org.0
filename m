Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7EC404114
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 00:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhIHWi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbhIHWi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 18:38:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA87C0613C1
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 15:37:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so5364344ioj.8
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJ3ihx4At7jgHYb3j4mYdDe9G4uE+v4pbaUUjca10is=;
        b=Q75NbNDpBphtBp+PKFLy985Z4TTGj4ihZPMVooF8G2q+TppHtpDID51jmQAp5DG4jc
         ZGHcVuPWy0owAmiNaf/M9z4/2p+UBiaOdW6CiL1yfw3ia3UJiklAankiuBOipM5srSP+
         bqi5n2KdIRWO/1X+cu2BWHrYtmVBrfhDHGbL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJ3ihx4At7jgHYb3j4mYdDe9G4uE+v4pbaUUjca10is=;
        b=6tigF1+pJ3E4HEun7uzZ9mo0RyLjkDiQQ82aBG4H18TU8634eVHG++joSek3lsxc8y
         FAM5+c4rsuzpuSYG6aXiBRpPJsxH/ZUeD44E16p59ZQzExr/9Un1IuM0SneOw7ECEY+M
         DZY7iuCWUdpGIzWbSSKEgb+pbC0G8LaY4/qjLcCxJ4Z3cYX0I/HjQP83xmNn3JX8DBQQ
         FKiLq9qhMvAkUnN4rXPRHIC8KYqwiO5phhXJCELDl2XNnraPxX5Gqt0f7A7Mh4bDHlbh
         JziuhjfbjUDm0RrHPn90LkncyqeXnHA+yK5VU9dqiekKGlRcPyYgSKMhKO2z8ZM1M2e2
         RiIg==
X-Gm-Message-State: AOAM530lm20cMz9WPax9CIyq9f8bJduiXO5sWAq53NOqZqUbmqqYSSoi
        ESD4T3LBJpfypp7Z8ow/0iqVBr1s0rj0sjaRIOtQNA==
X-Google-Smtp-Source: ABdhPJzwDblF0Ih7VdiBmyr77yCQeqfj4l4itTfLgiElnagK5TDnK04rTWAknk1pCDtaGemvtTa13cAdWAvzwWeHTxQ=
X-Received: by 2002:a05:6602:20ce:: with SMTP id 14mr478898ioz.204.1631140638724;
 Wed, 08 Sep 2021 15:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210905210400.1157870-1-swboyd@chromium.org> <YTe+a0Gu7O6MEy2d@google.com>
 <CAE-0n52d_GBh70pSDXTrVkD5S6akP4O9YcE4tVRKZcvLtLZSmg@mail.gmail.com>
In-Reply-To: <CAE-0n52d_GBh70pSDXTrVkD5S6akP4O9YcE4tVRKZcvLtLZSmg@mail.gmail.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Wed, 8 Sep 2021 15:37:07 -0700
Message-ID: <CACTWRwsRLrKHRWVoHHyrU2DEc_VkhqSi66tdD2OBWs_y8J2LPw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't always treat modem stop events as crashes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Govind Singh <govinds@codeaurora.org>,
        Youghandhar Chintala <youghand@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The way I see this, this issue is happening because of a much bigger
design constraint. On integrated(modem+wifi) solutions, if remote proc
service is shutdown, it has a trickle down effect. It deinitializes
the modem processor (which controls wifi as its subsystem) and the
wifi FW. As the fw de-initializes, we see the Delete server generated
by the wifi FW. The FW generates delete server qmi event and there is
no way on the host wifi driver to differentiate between delete event
generated from a FW crash and de-initialization due to remoteproc and
so we see the FW crash logs even during shutdown.

I would like to know what are Qualcomm's views on the design
constraint and any plans to reduce the rigidity. Also, will the FW
broadcast other qmi events(QRTR_TYPE_BYE for e.g.) during shutdown
(different from crash) ? If so then we can utilize that event and then
we don't even have to add dependency on remoteproc.

Overall this change should fix the issue, additionally I have one
comment below and would like other reviewers views.

>  #include <linux/regulator/consumer.h>
> +#include <linux/remoteproc/qcom_rproc.h>
>  #include <linux/of_address.h>
We are adding an external dependency here but since this is added in
snoc.c (which is for integrated solution only), I can expect if SNOC
is enabled, remote proc will be enabled as well, so it should be fine.

Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>

On Tue, Sep 7, 2021 at 12:48 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Matthias Kaehlcke (2021-09-07 12:32:59)
> > On Sun, Sep 05, 2021 at 02:04:00PM -0700, Stephen Boyd wrote:
> > > @@ -1740,10 +1805,19 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
> > >               goto err_fw_deinit;
> > >       }
> > >
> > > +     ret = ath10k_modem_init(ar);
> > > +     if (ret) {
> > > +             ath10k_err(ar, "failed to initialize modem notifier: %d\n", ret);
> >
> > nit: ath10k_modem_init() encapsulates/hides the setup of the notifier,
> > the error message should be inside the function, as for _deinit()
>
> Sure. I can fix it. I was also wondering if I should drop the debug
> prints for the cases that don't matter in the switch statement but I'll
> just leave that alone unless someone complains about it.
