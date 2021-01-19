Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075032FBFF7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbhASTXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 14:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389681AbhASTQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 14:16:14 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41033C061575
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:15:33 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id o11so20906247ote.4
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5M/xwriCvZ1ehbhOrKqRjMwNoC7bFrlBY9OQlV4JhBQ=;
        b=VWO3o72xi9hscdAVyxdDSmzYIRxLsgi6uCN7en9qrfVE7711O7MAhTXDHS/7XGm9hh
         p91gsGfWQTBnBlIWrIJqmzr00hP935pwO4oe/C03aHZJ8kvKLi5B1mqsOQccAf+U7kgI
         xH3t0UJRWdDdIeUH5fZvbFR/tFgWEBfJGkrPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5M/xwriCvZ1ehbhOrKqRjMwNoC7bFrlBY9OQlV4JhBQ=;
        b=HtIPaB1w9DnXB31QqUD/U2zuGvYmqISn0L+Qn3lurMG4/fU2PcNKJ33z/LFUZotnMD
         IS1vPXZzcJ3mU2nvlox7q/eTyxnHDc4F0XlLYUg+McSDo8vaPbtl88PIUMZw3kCASpKJ
         iC87IZA0zMuMhvD4Au6t31wADGX+HYhvT8x7Tgdk1SBWqpsBy7/x6BmVQdwM2LKD1Wr6
         mCq44DoVphMTu3uu7iXNN1JxF/jFKtBtF4nrfI/HyOYRJE0/ZKCBV8T0D/gaz8LQCHdL
         bg1RdBedcZN95oVeaA5cTBHFggDsgO8KWfvNud3hXjbN2uIsDTsPEdw1d3SwOpm+s4JP
         88FQ==
X-Gm-Message-State: AOAM530nRZ8xOOPBIROEY7CBK4VIocbzbQXB4uNVRTW5pSyh7GS9cBrZ
        pDhZfyj46sSgm+y0WGVQXo6XGwSpscU0ug==
X-Google-Smtp-Source: ABdhPJzsaN8ktPQo3ER1ttUzP6rQ8zqpLfMQhgZAeBD4rJL00gIW3q5cKfDpgAx35rtu7OBhs4aJSw==
X-Received: by 2002:a9d:4d95:: with SMTP id u21mr4431767otk.11.1611083732316;
        Tue, 19 Jan 2021 11:15:32 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id y12sm4861210oti.0.2021.01.19.11.15.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:15:31 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id f132so22332548oib.12
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 11:15:31 -0800 (PST)
X-Received: by 2002:aca:df02:: with SMTP id w2mr766754oig.77.1611083731008;
 Tue, 19 Jan 2021 11:15:31 -0800 (PST)
MIME-Version: 1.0
References: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com> <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Jan 2021 11:15:19 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPFGxKBBMU1ZKO6oSTNeSKMeZktfbDWndEqXJ1_6ojTcQ@mail.gmail.com>
Message-ID: <CA+ASDXPFGxKBBMU1ZKO6oSTNeSKMeZktfbDWndEqXJ1_6ojTcQ@mail.gmail.com>
Subject: Re: [PATCH] marvell/mwifiex: replace one-element array with
 flexible-array member.
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

One more thing, for context:

On Tue, Jan 19, 2021 at 11:11 AM Brian Norris <briannorris@chromium.org> wrote:
> On Fri, Jan 15, 2021 at 1:39 AM Jiapeng Zhong
> <abaci-bugfix@linux.alibaba.com> wrote:
> >
> > Fix the follow coccicheck warnings:
> >
> > ./drivers/net/wireless/marvell/mwifiex/fw.h: WARNING use flexible-array
> > member instead(https://www.kernel.org/doc/html/latest/process/
> > deprecated.html#zero-length-and-one-element-arrays)
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>
> Past experience unfortunately requires me to ask: did you test your
> changes? I understand that's a mostly legit warning, and a good
> deprecation notice, but that doesn't mean this is the right fix. One
> probably should instead audit the usage sites to see if they *are*
> already making proper sizeof (or other) comparisons, and if not, fix
> those first. And if any sites *are* doing correct sizeof computations
> using the existing struct layouts, then you are probably breaking
> them.
>
> Or if you have audited the usage of these structs, it's nice to make a
> small explanation of why this is correct, so I (and other readers)
> don't have to ask these questions :)

FYI, there are others who I believe are making similar blind changes
to this code:

[PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_config_scan
https://lore.kernel.org/linux-wireless/CA+ASDXPkLg2GGFJTt25YO7wae==YAHftf8JXu520pL_vZaT3ug@mail.gmail.com/

For that particular case (the 'ssid' field in
mwifiex_ie_types_wildcard_ssid_params), the previous patch-er was
incorrect, and I believe your change is a better one. But neither of
you provided useful analysis.

Brian
