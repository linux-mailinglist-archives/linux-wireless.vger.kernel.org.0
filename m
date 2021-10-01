Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D641F34A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhJARmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJARmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 13:42:37 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D38C061775
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 10:40:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u22so12382520oie.5
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4CMfjMCnX/ZB3C8VVZwoZ3b3lz5uItUaYxGDPP4gT4=;
        b=kOYazPkAVXf6WE8zWvzoo8XMyMIN3sfGCfHSy1HyIQvJeInQSKruAqd93WbM/R26zd
         Ak0/IChOUbRDKuaAKMUuKMt9vKy0VrFrvVtJxQFfhAh0jcoY0NOc1yKa7oF/Ems9Qh5K
         eeUamWeGTee9Ro+9qabaXqDoiYyEEUTq3PYnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4CMfjMCnX/ZB3C8VVZwoZ3b3lz5uItUaYxGDPP4gT4=;
        b=mEgArYntFqJodaL+xNJCS+VEdRhy0z7qfLyyUaNB0xvOc1ZDj4iQXc0Nc6yUjTEO0N
         ByCK5buJeQswtTpvYvZRRRAcvejEWwAQ71WLOiSiAMFKGloLrrqV6rkOI/L2gARiJgCV
         X7GEUfprFvIYqQQNJjWYod2CUX2oE0/56HETV1JlOpsHsXylJaJeFmTromnrUS3kVBqh
         XNhG0xbvBmekOpqRuY/0U6gkGsjKjubD8YkndoWOQXT8oDyXAmUiC3j5FtRCiVE/6B/s
         PO5mUEd6gGVAtZaUTw0XAQ2gD9dJKqtGqtnD68Eq7LnjpKEwc6gsO525hT3iDnp2dCm7
         PLzQ==
X-Gm-Message-State: AOAM532oS9BAqKxWffwa5prwFNvn2HjwoHbs5FuKE6CchXy9IPOGgLL5
        KBdx2p6qtGtCAwqNdJah92rLMT6vMeT1Uw==
X-Google-Smtp-Source: ABdhPJwHYSNGjNhfUp+CGr8QEKJydZ4HJB2nmIutr4yV6u5TcaWQ3KN5ZTb3PY97PHBHAQn+9NhGyA==
X-Received: by 2002:aca:1b09:: with SMTP id b9mr4853752oib.55.1633110051467;
        Fri, 01 Oct 2021 10:40:51 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id j23sm1249845oih.30.2021.10.01.10.40.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 10:40:50 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id x124so12310973oix.9
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 10:40:50 -0700 (PDT)
X-Received: by 2002:aca:2802:: with SMTP id 2mr4667845oix.105.1633110050328;
 Fri, 01 Oct 2021 10:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043538.12424-1-pkshih@realtek.com> <20210820043538.12424-3-pkshih@realtek.com>
 <87sfxkix5e.fsf@codeaurora.org>
In-Reply-To: <87sfxkix5e.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 1 Oct 2021 10:40:39 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMX2Kw9JLBtzAvEJr=qFD9rq4L6+zFeHeYCPUeOc=u7pw@mail.gmail.com>
Message-ID: <CA+ASDXMX2Kw9JLBtzAvEJr=qFD9rq4L6+zFeHeYCPUeOc=u7pw@mail.gmail.com>
Subject: Small driver submissions and long feedback cycles
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[[ changing subject, as this is less about rtw89; it used to be:
  Re: [PATCH v6 02/24] rtw89: add BT coexistence files ]]

On Fri, Oct 1, 2021 at 8:26 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> A small tip for future drivers, try to remove all the optional features
> from the driver as much possible and keep only the absolutely needed
> features to get ping working. For example this file was pain to review
> and I suspect coex support could have been submitted separately.

I find that a bit of a tall order. You haven't looked at this driver
for 9-10 months:

https://lore.kernel.org/linux-wireless/20201230044223.14085-1-pkshih@realtek.com/

Do you expect people to just live with a feature-less driver (read:
unusable) for all that time? As noted in other parts of this thread,
quite a few people are already using this driver; so your suggestion
implies people should submit a completely different driver to you
(i.e., more or less non-working) than the one everybody else wants to
use -- or else suffer for those 9-10 months.

For the record, Realtek _did_ try this for rtw88, where they
partitioned their driver work into stages, submitting you only the
first stuff over the period of 9 months before you merged it:

rtw88 RFC v2; I couldn't find v1:
https://lore.kernel.org/linux-wireless/1538553748-26364-1-git-send-email-yhchuang@realtek.com/
Committed about 9 months later:
https://git.kernel.org/linus/e3037485c68ec1a299ff41160d8fedbd4abc29b9

But it was several months after that before the rest of the
really-usable features were submitted and actually landed properly.

So it sounds like with your suggested approach (like rtw88), it can
take over a year to get a usable driver merged. For this approach, I
guess it's 9+ months (TBD; but you seemed more or less happy with this
version, minus some small comments). I can see why folks would choose
the latter.

Or maybe, those timelines sound altogether bad [1], and we should
consider some alternative. If the review and feedback (or merge) cycle
was quicker, I'm sure people would be happier to split work into
bite-sized chunks. But when it's slow and lacking in transparency,
people are instead incentivized to just publish everything at once. Do
you need additional help? A reviewer team? I do occasionally try to
help things a lot with review on-list, but it's not clear that it has
any bearing on time-to-acceptance, so I don't exactly stretch myself.

Brian

[1] They do to me.
