Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE21403E0A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbhIHQ6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhIHQ6U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 12:58:20 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D5C061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 09:57:12 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so986265oos.10
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPnN7dR7n+u5y7QjkI7+sFJwmNUnbLvHhnWxVBaHsZk=;
        b=grxJb7Lx1iF++audW+w5h2kl0K8plqduWfxPsmaNtm8dw41QhGozp0N+LLwdSh00ho
         6QENQwdshsg2t5mH9kPlHzEKCSFarmVqihH4ACJ8wiHiEkhkoedbtlhrICtNkjm/3CJU
         iHH0JhsdvH3Rg83Eq98+Nt11Vmkovw+TEz2II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPnN7dR7n+u5y7QjkI7+sFJwmNUnbLvHhnWxVBaHsZk=;
        b=T6hOTu+DnBVya0vSf2aREOc/51BB9CXRA/0l1EcMJntM9liXPjOXoEFYzrJPqtjTB3
         XleQol07dy9+fPf56vdS96wal+H89mwfOFaixab9hXXRZKl2MogHFDwCFoV1JgdpLiy8
         DApAAFL2dSagbNdmet27GQXjbuq/HbYpzLdv8A0rn/2tYGBojw4gFltfMkveDvNf5kXd
         sUK65pyzVFx3f6nFsOvL0EYmPl8Jr3H0M3bt/9n6gfHRw0W9Y5S5DygIrCnWs4PrySBg
         LdTKm41jGz9UVg07naueIqbISJusTa+EX93bmSCDZzqYuTCpRDDuaxnwRVDXVSFgJwwG
         Z0Ig==
X-Gm-Message-State: AOAM532pzxqOTOkrABBROiTW+MHFrj2Vd1GEszQ6mMlHf3Bwb2zap/6I
        PGyqdgMcOc9jpUyNbS/AJ0XAbQe/JsJvNA==
X-Google-Smtp-Source: ABdhPJyW3mfzQWqDKlJKPf84Ai+0GFBbwffScVWBz6NxhF6EDnFKtxS2T9HCzYq9DA/YsvuzyDP5PA==
X-Received: by 2002:a4a:b64b:: with SMTP id f11mr3738257ooo.18.1631120230934;
        Wed, 08 Sep 2021 09:57:10 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id q22sm569623ots.64.2021.09.08.09.57.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:57:09 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so3799210otg.11
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 09:57:09 -0700 (PDT)
X-Received: by 2002:a9d:7d90:: with SMTP id j16mr4002766otn.186.1631120228931;
 Wed, 08 Sep 2021 09:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
In-Reply-To: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 8 Sep 2021 09:56:57 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPXL78rxJWjqvVZVAjb6ryYKbY=QP3EZ0N0kfhaFH9CeA@mail.gmail.com>
Message-ID: <CA+ASDXPXL78rxJWjqvVZVAjb6ryYKbY=QP3EZ0N0kfhaFH9CeA@mail.gmail.com>
Subject: Re: mwifiex cmd timeout on one pci variant
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 7, 2021 at 9:52 PM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
> This is probably more a question for the maker.. But maybe someone will
> know.

Last I knew, at least one of the CC'd is still employed by the owner
of this IP (NXP now), but I don't know that much. But then, they
haven't been giving out a lot of free support lately, AFAIK.

> I've got a mwifiex M.2 pci module that won't take any wifi command and
> hang right away (dmesg below). Bluetooth through serial works.
>
>
> Context:
> I've got a board with an i.MX8MP chip, and three different marvell W8997
> M.2 modules -- one from laird which works fine, and two from azurewave
> which are labeled exactly the same AW-CM276MA 2276MA PCIE-UART except
> one works and not the other.
> The inscription on the chip itself are slightly different, one saying
> it's a W8997-M1216 from marvell (works) and the other having AW-CM276NF
> azurewave mark. The electronics around are also different.

FWIW, I've only ever worked with the PCIe-USB variant of this chip.
And it had tons of bugs that resulted in "command timeouts" along the
way, and it took a lot of co-working with Marvell to get the firmware
fixed. I don't know their release model well enough to know whether
the PCIe-UART variant will have all the same bugs (and bugfixes). But
in case it helps, here's our firmware history:
https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+log/HEAD/mrvl/pcieusb8997_combo_v4.bin
*Most* of those should align pretty closely with what was published to
linux-firmware.git, but it's not guaranteed, since Marvell didn't
always follow our upstream-first guidelines there.

> I could say it's just a bad chip, but I've actually got two of each
> (samples) which act the same... And I've tried it in another device
> where it works with the same kernel/firmware, so there must be something
> wrong on the board as well as the wifi card works elsewhere.

I've seen something as small as the "wrong" kind of noise cause the
firmware to grind to a halt, so there could be a firmware bug that
gets tickled by the particular layout or antenna configuration of the
board in question. I suppose that's not a very helpful guess, but at
least it might validate your observations.

> Anyway, if someone knows how to get around to debugging this, I'd
> appreciate a pointer! I can't see anything wrong with the tools I have
> here.
> If nothing else, I can't read /sys/class/devcoredump/devcd*/data that I
> saw Amitkumar Karwar request somewhere else, so just deciphering this
> would be great help.

I've never had success with that, but I haven't tried very hard. My
understanding is that it's something equivalent to a register and
state dump of the proprietary firmware, so you won't really learn much
from it without proprietary knowledge.

Good luck,
Brian
