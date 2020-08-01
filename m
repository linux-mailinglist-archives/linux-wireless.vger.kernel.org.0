Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27F234F42
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Aug 2020 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHABbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 21:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgHABbp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 21:31:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79CC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 18:31:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so24486965qtt.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5hs4CNSdR7fBcs1oGUPKpLdocqk8/qQSUjfBk/TvWE=;
        b=oC77DcWBFdF3fXleFDJWdR5GXpak41S3u3jRxZbLbSetON6j+xbSdnyUkyMlB+kXYl
         39ijl2NY/bCAfc6MSrmC2JkY3Biwl5ep9gwqKCxObpIIT6SFLSxsH/ds3rMdEVx3KqBu
         VbHz8f1Emz320uLthuzNcP1Wyb/v5C88ts0RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5hs4CNSdR7fBcs1oGUPKpLdocqk8/qQSUjfBk/TvWE=;
        b=dewyXosrXr60Fwe58CwQ4nRZCN8eFRSLUU1i0WT+pyKPvCtxadlFz4m/bsaehygI1l
         l9hbPperdUkpQr/vOXIm3X2yqcGBHOUZ723HEsdsyWrLyJDRVHbHs9ha+xG+gkZ4S6nH
         03s11AQUvvAnoLensZ6X25RPuB6GWINjnySAnGerqaBGZnCdW4MXnk5pBIUtelZfbwZL
         FR169i6Q8aUcI/Wo+rtmPsXAU3faq56DCVuB7Xu17RklJaCcG/UkGJ5xBC/RH8RcpAxU
         22aEIGIDJLBqBfeHxPORAkrNIqCRgrC3KI305X4UYAyrdP/nYCXGvLY2sVxkMORyhrxR
         649w==
X-Gm-Message-State: AOAM530rx//ezgeexPtDueXhWwDG9gbhhWAOZgwy2I/vFdRfOCPbHd7w
        LB3uULq1BluI6LS1321QrTd8egaa+Ak=
X-Google-Smtp-Source: ABdhPJxZfi0PwwPWoasgFn8k3Ksi+KoARfMJICakhUWcXwAwEow6jz1a2Z5eGS1Rq7q1U/IqXOUVRw==
X-Received: by 2002:ac8:e89:: with SMTP id v9mr6579251qti.100.1596245503242;
        Fri, 31 Jul 2020 18:31:43 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id q126sm9442856qke.34.2020.07.31.18.31.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 18:31:41 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id l13so8651784qvt.10
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 18:31:40 -0700 (PDT)
X-Received: by 2002:a05:6214:1143:: with SMTP id b3mr6968406qvt.84.1596245499947;
 Fri, 31 Jul 2020 18:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
 <1576684108-30177-2-git-send-email-kvalo@codeaurora.org> <1576748692.7758.17.camel@realtek.com>
 <20191219154828.GA12287@w1.fi> <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
 <20191219185522.GA16010@w1.fi> <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
 <871rpqly6a.fsf@kamboji.qca.qualcomm.com> <e8908eafd8e6050eef8782c6a7019e318d14f65f.camel@sipsolutions.net>
 <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com>
 <87lfjjx0o7.fsf@codeaurora.org> <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
 <87y2n9clhj.fsf@codeaurora.org> <c3ef60c2263a6840d21f6a797ad3ffb685a728b8.camel@sipsolutions.net>
In-Reply-To: <c3ef60c2263a6840d21f6a797ad3ffb685a728b8.camel@sipsolutions.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 31 Jul 2020 18:31:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOwARX86GzMsSL4N94-jQ-TqAhe07f0AZOQcdKpPyJEgw@mail.gmail.com>
Message-ID: <CA+ASDXOwARX86GzMsSL4N94-jQ-TqAhe07f0AZOQcdKpPyJEgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Jouni Malinen <j@w1.fi>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 30, 2020 at 6:24 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> > Good, I was just checking that we all are on the same page.
>
> But are we? ;-)

I think you were deferring to, "how would user space use it?" And,
"would a common API really help anyone?" (And then you implied
"anyone" = "Chrome OS.")

I expressed a moderate benefit from a common API, but I'd settle for a
non-common (but upstream) one instead. I also doubt many
non-hardware-customized Linux distributions will make use of this any
time soon.

I don't think that implied you were truly on a different page. But
your response below may say otherwise:

> I don't really see anything in the new proposal [1] that really explains
> why the common API that we've sort of vaguely outlined in this thread
> couldn't work? It just speaks of technical difficulties ("need a
> reporting API too"), but should we let that stop us?
>
> [1] https://patchwork.kernel.org/patch/11686317/

Indeed, I don't see any reason beyond technical difficulties.

I'd love to have a few extra hours in my day to spend on writing such
an API, if that would really unblock months of deadlock.
Unfortunately, those hours tend to get eaten by all sorts of other
things these days, so an honest assessment would probably say I won't
get around to it soon. SAR regulatory concerns aren't really sexy
enough to convince me to spend my weekends on it... (...oh wait, it's
Friday evening already. Hmm.)

Regards,
Brian
