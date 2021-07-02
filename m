Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39D3BA380
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGBRLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGBRLj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 13:11:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE5C061762
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jul 2021 10:09:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a133so12026709oib.13
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jul 2021 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nxdBDfNX60hKJ+e+rBALTSVeUgPUceH0CQEIupFXOc=;
        b=EK9G2YGKB7Oh//kTnOKM/NNt0eQGcLLVN+oyIR6IreHAriSRDVXNOM5O7RYGmFZgbN
         qvPc86qFBllCgk3645ehse2XSqukgTqcoy2xz1tgmslLmjrefirlZ8k6iQGx8qs7D6c9
         zyQ2PpMgrtOh5e7zrtOO3zlw5AWLLCNdiJzIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nxdBDfNX60hKJ+e+rBALTSVeUgPUceH0CQEIupFXOc=;
        b=LY1joxTLN6/CaDojEpdN4IgQsGeOddMnYd5cnE1ALUgXx8yAQ+8NUfVSAAS+RDHcAZ
         m5RAdYyzHrM6KLmrn5kOxvGfG7/q4LnckwrsUVUZLqHpWaaQvctecNZBwXrLHJ1nmuYT
         UEa8gPgJK2U1PLJShemYT7qK0kXsnvd/A0bSveyGyHrWHypNnGfIRF8PVLo4knBh+EIs
         84yvaBQ/5PNuCg/S4kof2ZA1Mte0dSNSczt0rgiJO5O6RmHGbdrsxvr/UwSPA1ATBneZ
         D0+hurK/lzsjHvxs1zqrM3E2+7dZGmJl+cjzvoHwjb559dtpXtQZhgpna2zpL+72iaZj
         sKKQ==
X-Gm-Message-State: AOAM530/RDgMvfmJb2sASMYyqAG9belcbyq/R22yAwzD4v0VXBvUuqQq
        TxxCwyH6KY8JVf4UQjkf0y+F72/zr+ip/g==
X-Google-Smtp-Source: ABdhPJy2YIys7R2NUnZWX+0cSTn3wNdFlf8dlGlPhxmDKNHvd1Is/wLb4d2ZEY3Kqw9E2MOJT3iWtQ==
X-Received: by 2002:aca:3dc4:: with SMTP id k187mr450717oia.147.1625245746493;
        Fri, 02 Jul 2021 10:09:06 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id v7sm726220ooj.46.2021.07.02.10.09.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:09:05 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id t80so12082720oie.8
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jul 2021 10:09:05 -0700 (PDT)
X-Received: by 2002:a54:481a:: with SMTP id j26mr619047oij.117.1625245744933;
 Fri, 02 Jul 2021 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210618064625.14131-1-pkshih@realtek.com> <20210618064625.14131-5-pkshih@realtek.com>
 <20210702072308.GA4184@pengutronix.de>
In-Reply-To: <20210702072308.GA4184@pengutronix.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 2 Jul 2021 10:08:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNjHJoXgRAM4E7TcLuz9zBmQkaBMuhK2DEVy3dnE-3XcA@mail.gmail.com>
Message-ID: <CA+ASDXNjHJoXgRAM4E7TcLuz9zBmQkaBMuhK2DEVy3dnE-3XcA@mail.gmail.com>
Subject: Re: [PATCH 04/24] rtw89: add debug files
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 2, 2021 at 12:23 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> On Fri, Jun 18, 2021 at 02:46:05PM +0800, Ping-Ke Shih wrote:
> > +#ifdef CONFIG_RTW89_DEBUGMSG
> > +unsigned int rtw89_debug_mask;
> > +EXPORT_SYMBOL(rtw89_debug_mask);
> > +module_param_named(debug_mask, rtw89_debug_mask, uint, 0644);
> > +MODULE_PARM_DESC(debug_mask, "Debugging mask");
> > +#endif
>
>
> For dynamic debugging we usually use ethtool msglvl.
> Please, convert all dev_err/warn/inf.... to netif_ counterparts

Have you ever looked at a WiFi driver? I haven't seen a single one
that uses netif_*() for logging. On the other hand, almost every
single one has a similar module parameter or debugfs knob for enabling
different types of debug messages.

As it stands, the NETIF_* categories don't really align at all with
the kinds of message categories most WiFi drivers support. Do you
propose adding a bunch of new options to the netif debug feature?

Brian
