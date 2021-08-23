Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072333F528C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhHWVHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 17:07:37 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03184C061575
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 14:06:53 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i3-20020a056830210300b0051af5666070so30295016otc.4
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLL6TsZ0p1BxQUf3mIJkFGmI1A6NCb0FMhavacPJRyg=;
        b=SIEteore6KBkjf1V/T0XrUBvgjsGHQ3CRmC/jfX6gFyKTum7UR3ll9NRZTJvK+k0cx
         +VL+anTu0sQ4h8bhc012Lty0DVtyjowmnQR8wmCf7q/YYeUj7qbvuDJXrFdcYxW6/U1a
         JjfR4fEDz4vqS4kw73NZZZh0iJ4CHLnjANXwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLL6TsZ0p1BxQUf3mIJkFGmI1A6NCb0FMhavacPJRyg=;
        b=WKwysXe9R2ua/OKCHy3h4WGAHmG/O2IqbhpaXu1mFy41mWcP8BHnpVErH7LzbE6WWg
         nWNIvDpA6SXOyhFMQeetfO8u6JMuPKF02K87/X7OaSiQaBn/QVsCsP8AbthRT7bDH0np
         d3pXMTIiaQTWE8vhHoFUsceOMqXIW8NsNd6l0aMFhhC8AnEC4QCpdCI/jWAGPK/HuOGH
         ZfMW4Fc5FpXioVvQfMlxOYK20jQmTGZuZDewdyjUA45guo/9d3V++62QAOccLl2G9CRK
         xMFkFLBdla+vIPbKC6lJRPmthoB/b3KpbociXoxidR363yNKgBR+WkI32bBV2FOM1R9O
         qsTw==
X-Gm-Message-State: AOAM5318D+DrLzAmzLFw28FrykhJAPqc6Y6L05EOv2ZjoRwjDWoY4dHe
        O0/WlpWpmKGM9wqlzwDWIQH3av0WLEeJkA==
X-Google-Smtp-Source: ABdhPJwiW6kl//I2ZpuaYatSvx3dTnqx7VhaX138kVcdGaD4/Gq5GcD8uP4S/C6HjwOD6WEnuux/+A==
X-Received: by 2002:aca:acd5:: with SMTP id v204mr421111oie.124.1629752812320;
        Mon, 23 Aug 2021 14:06:52 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id c3sm1309538oiy.30.2021.08.23.14.06.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 14:06:51 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso25205136ota.8
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 14:06:51 -0700 (PDT)
X-Received: by 2002:a9d:2278:: with SMTP id o111mr16276286ota.229.1629752810696;
 Mon, 23 Aug 2021 14:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <YSJ//ki/A1EgfLga@skv.local> <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
 <YSQC32TygIq2SHJR@skv.local>
In-Reply-To: <YSQC32TygIq2SHJR@skv.local>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 Aug 2021 14:06:39 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
Message-ID: <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 23, 2021 at 1:19 PM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
> On 21-08-23 10:23, Brian Norris wrote:
> > Maybe it needs an Nth person to submit a revert?
>
> Later (Dec 23, 2020) said "Actually I don't see how I could apply the
> revert due to the regulatory problems explained by Jouni". [1]
> I think this could be the date when your patch was marked as Rejected.
>
> 1. http://lists.infradead.org/pipermail/ath10k/2020-December/012370.html

Oh wow, I almost forgot about that... Too many threads. I also forgot
that I already replied, expressing my disagreement:
http://lists.infradead.org/pipermail/ath10k/2020-December/012372.html

But I guess it's not really expected that mainline Linux really works
as-is on most products, unfortunately, and the maintainers don't have
enough time or energy to provide constructive paths forward on real
issues like this :(

Brian
