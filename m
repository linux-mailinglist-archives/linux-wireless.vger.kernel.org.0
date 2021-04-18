Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE5D36342B
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhDRGsj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 02:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDRGsi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 02:48:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B3C06174A
        for <linux-wireless@vger.kernel.org>; Sat, 17 Apr 2021 23:48:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x16so31792853iob.1
        for <linux-wireless@vger.kernel.org>; Sat, 17 Apr 2021 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=bNFvm387H14VR4uDavzDa2gVIhxhpAltHVFqJbI0CrI=;
        b=Mceru6Wmh9LP0QdUGO3tGz2+5PXX1/HIDxYeP32HfadxTOVhB4TtyXr/HEg9JwJMA3
         /PEqBARl7dEDUuyDxV5ImayCiq5PiBbbO6kOiUE11g69TF5ke1e4hWyDHQuNwXhbEIag
         N48OFBthBXutNK5eccYmH3dlgGRybYwQzfJ9j0j8EeBLKFNDzszRx56bYRHCW1BCqWIk
         BAbyVFBndhueB9fQIMVIPq2CYCbJKf3HDaQg6rOIgMjQxadhwWhxEiDOWpHkfuk5nVjJ
         gmMPGackfbW7qBq/iPFt0pdJ2ckFXtg34tbZHAD6lMJpbTeQ4BsG73KoVZKhf0Pw048H
         Ycmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bNFvm387H14VR4uDavzDa2gVIhxhpAltHVFqJbI0CrI=;
        b=GCS/atQw2tPlQZlqm8xrPi439uwEMCXYUV23mvqJGCpQk/+OHdTbn+YoV1oQE+K571
         Ir6ALZMiVHg4P+95vp+1DIAAi2pFzKjS3bhOEyHsQj14y6lE+I3FoQgpJmszmRSYErzs
         9yEaH+vkknJj0r41QyGVkWAHmvAyRJEk+Yqb+N0TPLK61NxlVV9kwwevElOKBRJXHwHC
         /RvRjuuDb1feeiDUo3lpZR8KW7YdEgyqACG119R4AM2w003Gpp/2PbOwH+FIg/spsEaZ
         IF0o6xs4gNaEDjUkf+UvBr+/W6jyFyzXjSG5/vS720lR/f9Tzazr6glx1iX4QRu7uQ1T
         muWQ==
X-Gm-Message-State: AOAM531D4pB5/3P+aCIzEwtJpNbWx1gUo73hJS2kAY23YIlgwNMod81x
        Bmb5k4rXEREwkL87Z21t9cRoLEmHyfSY/6yt2Uk=
X-Google-Smtp-Source: ABdhPJxg7JjeaOTZ45YpoCIYKQlJT25uttirt1GZpkDMIGAsY+mqPobPZ/Q14/JPZIhz5Jj7GARhrrxokOtE/BagcWI=
X-Received: by 2002:a02:9586:: with SMTP id b6mr2945172jai.97.1618728488488;
 Sat, 17 Apr 2021 23:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
 <20210417085010.58522C433C6@smtp.codeaurora.org> <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2104171124280.18270@cbobk.fhfr.pm> <CA+icZUUmEGP=DRqna7sNJ=1WZhzEVRiMSwwCt2hEQr-TkT18aw@mail.gmail.com>
In-Reply-To: <CA+icZUUmEGP=DRqna7sNJ=1WZhzEVRiMSwwCt2hEQr-TkT18aw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 18 Apr 2021 08:47:32 +0200
Message-ID: <CA+icZUXmNG6TOhtni6Rrs7NZVOg1H8NhYuDsDiyVASF5+VtUAQ@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 17, 2021 at 2:06 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Apr 17, 2021 at 11:25 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Sat, 17 Apr 2021, Jiri Kosina wrote:
> >
> > > > This is malformed in patchwork, check the link below. Please resend, and
> > > > I strongly recommend to use git send-email to avoid any format issues.
> > >
> > > Honestly I have no idea what you are talking about, there is no whitespace
> > > damage nor anything else that I'd see to be broken. I just took the patch
> > > from the mail I sent, applied with git-am, and it worked flawlessly.
> > >
> > > Anyway, I'll send a patch as a followup to this mail so that it could
> > > hopefully be picked up by your tooling.
> >
> > And it seems to have appeared here:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
>
> Thanks for the patch Jiri.
>
> This is on top of Linux v5.12-rc7+...
>
> link="https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm"
>
> $ b4 -d am $link
>
> $ LC_ALL=C git apply --check --verbose
> ../v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
> Checking patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c...
>
> $ LC_ALL=C git apply --verbose
> ../v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
> Checking patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c...
> Applied patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c cleanly.
>


Small nit:

Reported-by: Heiner Kallweit <hkallweit1@gmail.com

Here misses closing ">" in the email-address of Heiner.

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0 (x86-64)

- Sedat -
