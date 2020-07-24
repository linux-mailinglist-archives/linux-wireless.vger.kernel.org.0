Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091B422C6E3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXNnY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXNnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 09:43:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94218C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:43:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so7039098edz.12
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zI9RmphuNB5Op5Sy+Tz6CXNF6y5ajeijEVpHy2PDqwE=;
        b=b3g5rALrRSIPOlh1kYuQr55V7bHikBt5PHDM1sMcCNEEIxfXNJBHCKpL3Ws2EV8jgQ
         rT6R4dZKv2yU87s7lMUlvcGri7uUukB+Z49u24dFkt+ChO+dNvuoNpLzwra19MfRIkS6
         i+uE1KpqUrgZvVXJCk+ZSbGMFQBXElJWG/0qYEMzNEThELRQ15MUfgiPYyLFNQZ9Yg3y
         cDelIjZxJ4awNpOtzDhBSYpz47pRIOx3umiSr0Yg3rBYoznrMlEL6Ovofn7lsDtUN/9J
         JZpvYCa2gxb9h3C+55vnov6LJ+QPRLCLLG8lUETopJrx1t5y2smik3IXt/B1V53WH2uk
         /MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI9RmphuNB5Op5Sy+Tz6CXNF6y5ajeijEVpHy2PDqwE=;
        b=a96mSFpan7feR1q7awRO+JEovUoYr7kspzl/q2WBhh372zaPhb4HM6ewJNH4k+Qvau
         thkuFj2HzABH3rG8GPEtKv/QwlQpPaJD7Hwz96WeN1e7U+IblqYL2PGdsWymP19UKKeN
         +YAiJrAgBlQxDJ0Qfa8izsVB5XzvQ+ZjAw3ehQJVYJ/fYk9cr5Z4AgxzsqOgL2GSE0RS
         GP/xW6xBlp1SXQE1VNOhYXXsY9ppaCClRGQrBYHThR2zhot2XPwVco62PytpxZXsECB5
         YUkGebztKLk5AITC9Mgyf3ch80F5nwht0vmtAnJYRd42Qv/Tdd4XUwwPlB0jBd+0lDpR
         axHg==
X-Gm-Message-State: AOAM530jkqIqQ2sTO27eEVvGvTx1D2ZSBMBL9gRhIQp8mXB4gGOcI83y
        unEjA5CPS30uKqC4jzMw+Rv39amvOYaVOogl9gM=
X-Google-Smtp-Source: ABdhPJzwEVXNmV8MPoUc33aYU+xhAYl8ljrT09qQJWPNlRhIjBo8Taa3a8pti4/31xLV9LFO57LmCThf4STJQGLsGWc=
X-Received: by 2002:a05:6402:1659:: with SMTP id s25mr1769451edx.153.1595598202269;
 Fri, 24 Jul 2020 06:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
 <1595586052-16081-4-git-send-email-loic.poulain@linaro.org>
 <CA+Kvs9nZm+uoRJfjq33s1_nTbPt82NnEKmgYCWk0q5vH+-ca9w@mail.gmail.com> <877dut5a60.fsf@codeaurora.org>
In-Reply-To: <877dut5a60.fsf@codeaurora.org>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Fri, 24 Jul 2020 16:43:10 +0300
Message-ID: <CA+Kvs9mZ=7TtptfKmrapSqvsM=XeNuyUKJ6zbzgBQb9zHZjewA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] wcn36xx: Increase number of TX retries
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes. small glitch. sorry.


On Fri, Jul 24, 2020 at 4:12 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Ramon Fried <ramon.fried@gmail.com> writes:
>
> > On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org>
> > wrote:
> >
> >     Increase the short/long retry limit to 15 in order to impove TX
> >     robustness in noisy/busy environment. 15 is the default value
> >     defined in the downstream driver. Observed number of ack timeout
> >     is reduced with this change.
> >
> >     Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> >     ---
> >     drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++--
> >     1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >     diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c
> >     b/drivers/net/wireless/ath/wcn36xx/smd.c
> >     index 59f9f53..908cc6c 100644
> >     --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> >     +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> >     @@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[]
> >     = {
> >     WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
> >     WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
> >     WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
> >     - WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
> >     - WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
> >     + WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
> >     + WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
> >     WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
> >     WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
> >     WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
> >     --
> >     2.7.4
> >
> >
> >
> >
> > These set of patches fixed my connectivity issues with TP-Link DECO
> > routers.
> > Acked-By: Ramon Fried <rfried.dev@gmail.com>
>
> HTML emails are dropped by the list, please use text/plain only.
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
