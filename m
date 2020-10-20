Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161A292EA9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgJSTmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgJSTm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 15:42:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D29C0613DA
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 12:42:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o9so313189plx.10
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
        b=vqIoQqfPtCUD7ceHGEmbvFqqUZd/9dE0IpLQQ4p4nyONBXQMSFxBG5OzgCaJfT8eu8
         Ez0DMwUntzcU9c2WJzs/WqMvxG3bzlj0mstlcz+E4fW0gt02sZNjrL1HdU6SHVwmCE5R
         WFeHYzJRJuPZspqj8YJ2wlUmUN4Mc8MNrI6kLekCJ8yejCepkvkgEUeb7TbpDze1NnEh
         TP2SjhqdakZDUedR00qYjd62k5W2m7FgfHIpcuS/rhjqMGxVL3Apppn+UDRO/ftdIfoh
         duvoKavmXDacw9mysFV+xdp1Tg4QxCPiDxNSeCeZyO+34Y2S1kYSdX61NJzSKhmGsX5T
         HLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
        b=e8Zkpj+E5DoWNWlyCpiqoijxuEXZjY+pXwvocX48ON7AlD5j6Sc+DN7z57brW3ggih
         dm5y+qAE4RuvNOZXbDxu1FRY5n94tr3OPHZNmP8EVk9vdGQlsEj0D6fKsK3Wo6x8MUUA
         hLU545/rUsUvMkd7B8Pa216l13wR2nhlbm2rJlCysfCYc1AmMdn9QSNrUi1hgFeRq9aK
         PR2ee4PVb/0PSaH0h5GNT0JQxM6fTBTFJiEd01pUPT4WYSlH4huh6AKKdVAR848aB39i
         fpAu7cnLEkOJ763HL/EUgFE4zZHM6ipeEHIjrL80ZwomHcrUgCK6j71lmw1KnUePgM94
         KfLQ==
X-Gm-Message-State: AOAM532+1ygKHl8P3LOyQEfye9Ni5jg0TkOvOG/CyWKPaZLrf8uKe1Kq
        HFCk9YTWAYvMk8ntLd61dtubtTsesEjgDRBQ+7znNQ==
X-Google-Smtp-Source: ABdhPJxy4K+2uRaBuhFTeTSlHPetqrP1uAAP7dKvm6UBZz10SCa23PJUxb54E5JJmlle9J/y892Qp+TTrKvO4GeNXIk=
X-Received: by 2002:a17:90a:ee87:: with SMTP id i7mr921476pjz.25.1603136546933;
 Mon, 19 Oct 2020 12:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com> <20201018054332.GB593954@kroah.com>
In-Reply-To: <20201018054332.GB593954@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Oct 2020 12:42:15 -0700
Message-ID: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To:     Tom Rix <trix@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        industrypack-devel@lists.sourceforge.net,
        linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        storagedev@microchip.com, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        bpf <bpf@vger.kernel.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        alsa-devel@alsa-project.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 17, 2020 at 10:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > This is a upcoming change to clean up a new warning treewide.
> > I am wondering if the change could be one mega patch (see below) or
> > normal patch per file about 100 patches or somewhere half way by collecting
> > early acks.
>
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.
>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...

Tom,
If you're able to automate this cleanup, I suggest checking in a
script that can be run on a directory.  Then for each subsystem you
can say in your commit "I ran scripts/fix_whatever.py on this subdir."
 Then others can help you drive the tree wide cleanup.  Then we can
enable -Wunreachable-code-break either by default, or W=2 right now
might be a good idea.

Ah, George (gbiv@, cc'ed), did an analysis recently of
`-Wunreachable-code-loop-increment`, `-Wunreachable-code-break`, and
`-Wunreachable-code-return` for Android userspace.  From the review:
```
Spoilers: of these, it seems useful to turn on
-Wunreachable-code-loop-increment and -Wunreachable-code-return by
default for Android
...
While these conventions about always having break arguably became
obsolete when we enabled -Wfallthrough, my sample turned up zero
potential bugs caught by this warning, and we'd need to put a lot of
effort into getting a clean tree. So this warning doesn't seem to be
worth it.
```
Looks like there's an order of magnitude of `-Wunreachable-code-break`
than the other two.

We probably should add all 3 to W=2 builds (wrapped in cc-option).
I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
follow up on.
-- 
Thanks,
~Nick Desaulniers
