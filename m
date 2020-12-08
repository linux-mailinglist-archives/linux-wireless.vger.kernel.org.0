Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6342D36BD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgLHXK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 18:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbgLHXK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 18:10:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72FC0611CF;
        Tue,  8 Dec 2020 15:09:15 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e2so5300835pgi.5;
        Tue, 08 Dec 2020 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2v4ewJaopHSzDI+DwTqOHMuKOxJL31/waRJy0KATXk=;
        b=N3i3PhIr+jNJYBGrCo2zIv9HEv4hatrFtdys1BL4Ant4wyVpMRiHmWMdJcMd+Sgk5+
         lYdPi1muwdjfCrMuc999QvZmNvNKCYP7bQsoZoZtglUzmVFcMknaJfiBQFcH6vwH6jil
         6yG+POfIzZLV+Qzdpby269NEXsXDEAS/h4Kxn6La5Mq15EDgaJn6nGs6sixBjkEN8tou
         5c4ajVsbL7dR6LGCa0rSZ+1Y5KSIkbP5VUO76KCiLqJY37gKe1ZZkd8+9kXsZX7d6yt5
         LSN4vcJAQF4wrSGFeirPkzJ9sRGQF6eecTMtmDReD13QSilY1cfwI0MzPj2WTPIpwrSB
         xegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2v4ewJaopHSzDI+DwTqOHMuKOxJL31/waRJy0KATXk=;
        b=sG6ye4zFEJ5OBNizu7XLtlOse7/OSE11Tc2EeEUvGI8XKVeEGw5918N4PY3Lm5wzNP
         CuuYToAzM+khz5cLrCtUeuQYAIXGN8eDxXFYxcXwbT2TRBFMav2TmcAfb+tI+Z9M3K00
         4U0DEK3f65IriERt2b3qLVJ0WptAzJPvHtjeEWg/wdNhkOchiTFfJ0FBoFt2tvn1j8Rd
         z13SeaLeHDfe5feeBVBnkr7lOnuq5wnMbtj/2Bi9gxQnfTtkA5lDRQpK+/oDsoXqqVN0
         q8o6v+lKi1/UGQSe41DlimPokXmXwzfAlrtTocqw8tw3y8xFOv/IZgznlspFwFFWGOu1
         wzqA==
X-Gm-Message-State: AOAM533k1uPRAKb94QvKA11ZoeyQGz3Kc4XiybsTHxDD46IPDjCIp0Ws
        MWPgToiv6Fiv7NZqlTwHxAUCm0hmgiCo/lGJWg==
X-Google-Smtp-Source: ABdhPJz8g6xTSM7AKTfGX9fbLOhKNrljyr0sBtTMIjTK4Tck1XKVHMaoCQWc8d0ZBhlgcJi4uIAJoUma4tR5Tu5PbiQ=
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr41508pjb.148.1607468955364;
 Tue, 08 Dec 2020 15:09:15 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <20201208080559.6131e8da@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201208080559.6131e8da@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 8 Dec 2020 23:09:04 +0000
Message-ID: <CALjTZvZzdYSpZtsfV18YGrqrUMc0NcuzPOffLLnBAEpi9+6+fg@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     luciano.coelho@intel.com, johannes.berg@intel.com,
        mordechay.goodstein@intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxwifi@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Jakub,

On Tue, 8 Dec 2020 at 16:06, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Just to confirm - is this a regression in 5.10-rc? Does 5.9 work
> smoothly in the problematic scenario?

Good question. It's definitely a regression, though I don't remember
exactly the last working version I had. I *think* 5.9 was working, but
I can't be sure without testing.

Thanks,
Rui
