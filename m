Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B945A234754
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgGaOGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgGaOGi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 10:06:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51677C061574
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 07:06:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so22443574edr.5
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XeMSOu/cNN2dWpBgsvaLCWuwiunaIF0Gm0EXR6KiSA=;
        b=zWfvmpLdagwNE3esm2rxRXRkB7YZAvW42qd61qngQSFkgbm9SewSHX22BoF7ipqbNt
         G4UoBxHJzbuYcKP546F+nKl0Tm1VBBsz9AJj0jHuhC1Z2sUYRpV1iO+g44OxfARTFVg+
         w7lXJxyQR83d7PltKgdRUMB4QbAb28onDm/BMZuAnLPrxKgz28tNrbRFH/iXGDDx7rQk
         waXf99LtdFBkaCV2w/rwA/xqUwJdTRepqnxUOgJ6hJp8eNmRYqxI8yljrmggpH/aj/7Y
         wAyNr0axK5jLmj5tW1oeqFYHQYM0gmnGyqcHeLvl0NBhTY64U/IKRjXk57lwhAgTkaXB
         vQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XeMSOu/cNN2dWpBgsvaLCWuwiunaIF0Gm0EXR6KiSA=;
        b=pAP6HyqKEyjodAEX9x4f1yNrW5Fl1ikBE6UwrYelzW7TxUbJmXsE+aNCPNv1LHUg5l
         K4xAFlD/P2IHYFuC57Elrv03dfG9TULGWf7GIgkRe691MME4LPATHFWaWi2uES/T05vz
         FB5VfzPU0FR92Wir138Dkwe8EOK9mI8Dq8e960tP1JH6SvIoLCJ9CKKyc69GTUg7aZAI
         bYYzx4n3Clto/ZnYsl0LIuc5Ner7zLuAf4pGmlD9XYL4xauwcJI2A1RYPGIm9v7srFFg
         2TkO6jRq8QtJjHvlbfKpy69gQ3bqwpUty+0bJmBq77orDmtyIX/bPcqFDG9u3EJdvt1g
         yvsg==
X-Gm-Message-State: AOAM532xuF2o99hUkFsckIpnfja6vknNJb4dG8DNCH0Z18Xoh8I0Rgoc
        sK6d1jC70bbeZqL4MXZHMikMMHnarNiAoFN5bKKcYu+1
X-Google-Smtp-Source: ABdhPJwv59u44/W6eUKRt6Youj1KSym9oeOj9Ak7FCnevKtp7rg/VbYd7p52YG8tannsVP/T3lHDeZJcHEkgTE3DYoU=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr3925942eds.212.1596204397008;
 Fri, 31 Jul 2020 07:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200731020157.744145-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20200731020157.744145-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 31 Jul 2020 16:11:21 +0200
Message-ID: <CAMZdPi-ZOHHa_nckdKrGEXG3d2ZtP=hPThp+FSNQrViWH1WDOw@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Set sw-scan chan to 0 when not associated
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 31 Jul 2020 at 04:01, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> A patch in ath/pending rewrites the software scan for the wcn36xx to
> accommodate multiplexing with data, link monitoring and so on.
>
> However if a device disassociates from an AP then the last operating
> channel will not be re-scanned.
>
> After some discussion and testing on this topic
>
> https://www.spinics.net/lists/linux-wireless/msg201242.html
> https://www.spinics.net/lists/linux-wireless/msg201254.html
>
> this patch implements a relatively simple fix. It sets the initial software
> scan channel to 0 if we are not associated with an AP or to the current
> operating channel if we are assciated with an AP.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

That looks good to me, that will force regular scanning on all channels
when disconnected from AP.

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
