Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D163CEE96
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbhGSVEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383786AbhGSSLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 14:11:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F551C061574
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 11:39:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a132so10993374oib.6
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDy0fHni1XQjuS9o8bwOdnCNPCFI5WZlI6P6xtJxTdE=;
        b=FYExeEMyPNPy6xlw560XH9l56JEvNFDWoXznKCvooHpOHNsBOjsB5cjte2K1L5EfQ6
         pz4LzYZeQ7l3HgIYQNHg/0JtaqjcNWh3oJgx6BUo2CYdQJDR9LrbX0YGgDB6LU+c/aa/
         r/ct0Hm8+kJsTOuNd9FD0tMBYptksoIpqywyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDy0fHni1XQjuS9o8bwOdnCNPCFI5WZlI6P6xtJxTdE=;
        b=K4iYFHn4Y70pLT0eKAIEHVV7DNqlOf4WX3W5Hsh59sZj3Hl1vlKELC5+P532ZNf/Bg
         9anIepYj981rZ4Bu9NLGcHoJRsyczKvNwnyKWvIifQPmhK7AJuqc1KwU3UgIlMDzZYUd
         PNfSK48Uptj3nx2egaIufgJ7NDxeKmTrOBqt+GLW4Bc9pCCWom7pYUkbmkSJNZ3pXIjm
         4hgs+wc6WptwfJuRIcSDiKPXpzWsI4WW6AhxZ14fYJZqITehO7HjavmIgZFYMEO3sQtV
         OPFziix+tklh6+FCDCQhpVNdueqBK1t+vCcg837p2vTRL8izSbZi7AvGvDopdaUURd6W
         JkXw==
X-Gm-Message-State: AOAM531BCLaHr+hEkeT9YO2YBRl3Pqh+wgXKeqIWlxVpwfCaPFBPMoPh
        l86j8/fLYS4lZaACGHAvV/IY1CVgEfzXIA==
X-Google-Smtp-Source: ABdhPJwAgP9Ds5ct33amET8N+9gl/xf0bWZs4YFzOajr/j2iEbldLrTlGp9sP7VW+IqOfQ8MpIylxA==
X-Received: by 2002:aca:6046:: with SMTP id u67mr23187286oib.23.1626720669895;
        Mon, 19 Jul 2021 11:51:09 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id o17sm3881729oie.56.2021.07.19.11.51.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:51:09 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id b24-20020a9d60d80000b02904d14e47202cso1801741otk.4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 11:51:08 -0700 (PDT)
X-Received: by 2002:a05:6830:3143:: with SMTP id c3mr4785837ots.229.1626720667932;
 Mon, 19 Jul 2021 11:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210429080149.7068-1-pkshih@realtek.com> <20210429080149.7068-10-pkshih@realtek.com>
 <YMFzAZUysQ5HxZlK@google.com> <45dd7da687a444d5acbc13eb67dcee97@realtek.com>
 <CA+ASDXP1aY5Mm14GDA_qPK7+7Jri2xAMZ3fYiVrhur7N5EO0mQ@mail.gmail.com> <db26751dfb02499093829a6aeecadb61@realtek.com>
In-Reply-To: <db26751dfb02499093829a6aeecadb61@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 19 Jul 2021 11:50:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO7SfuAsLhLU9hn4bANL5oTizwoYh5ifi2Wi-Mr-7zMDQ@mail.gmail.com>
Message-ID: <CA+ASDXO7SfuAsLhLU9hn4bANL5oTizwoYh5ifi2Wi-Mr-7zMDQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] rtw89: add pci files
To:     Pkshih <pkshih@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Late response)

On Wed, Jun 30, 2021 at 5:47 PM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: Pkshih

> > I read IRQ handler of rtw88 that looks much simpler, and I picture the
> > new flow:
> >
> > int_handler             int_threadfn              napi_poll
> > -----------             ------------              ---------
> >     |
> >     |
> >     | 1) dis. intr
> >     o                      |
> >                            | 2) read interrupt status locally
> >                            | 3) do TX reclaim
> >                            | 4) check if RX?
> >                            | 5) re-enable intr
> >                            |    (RX is optional)
> >                            | 6) schedule_napi
> >                            |    (if RX)
> >                            : >>>-------------------+ 7) (tasklet start immediately)
> >                            :                       |
> >                            :                       | 8) set 'doing RX' flag
> >                            :                       | 9) do RX things
> >                            :                       | 10) clear 'doing RX' flag
> >                            :                       | 11) re-enable intr of RX
> >                            :                       |
> >                            : <<<-------------------o
> >                            :
> >                            o
> >
> > Step 2) read and clear interrupt status with spin_lock_irqsave, and use local
> > variables to save the status. Then, the status will be correct, even more
> > interrupts are triggered.
> >
> > Step 8)/10) add a 'doing RX' flag we don't enable RX interrupt in this period, so
> > step 5) will not make a mistake to enable RX interrupt improperly.

BTW, I think you might be pointing out a sort of bug with rtw88 -- a
non-RX interrupt might cause RX interrupts to get re-enabled in the
midst of what's *supposed* to be a NAPI poll. It's not a fatal
functional problem or anything, but it does mean we might get excess
RX interrupts, which can defeat the purpose of polling. I suppose the
impact of such a bug depends on how frequently we're receiving other
interrupts (say, H2C?).

> > I attach the patch based on v5, and these changes will be included in v6.
> > Further suggestions are welcome.
> >
>
> Sorry, I missed the changes of pci.h, so send reference patch again.

I haven't proven to myself that every line in there is good, but I
think the general layout is better. I'm more likely to get a closer
look+test when a v6 comes around.

Thanks,
Brian
