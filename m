Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92509362FC3
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhDQMHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhDQMHt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 08:07:49 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F8C061574
        for <linux-wireless@vger.kernel.org>; Sat, 17 Apr 2021 05:07:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p15so14408335iln.3
        for <linux-wireless@vger.kernel.org>; Sat, 17 Apr 2021 05:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WZfz6rPm5gqwRG7NgDo+h8FHauStJIlcG+L39BpIrWU=;
        b=uKwCFieb+C8SAxNE2fQ7YclTzDLdYg/seKE3URajOjZMZw4f/H09qSpjxe0P7CTf5L
         GCmm6Or/R8PixgMY1umDfWL4FuieVeVm8oyWMLv+Xu/xTuKvxdz56Cti0HwzrHdWSk41
         2FGgu08JEehAyG4Dn5ZMx63uVVB5QZ3PZcPf34CUzxKHcMh/4Lio/28haJBsqtLviE+i
         2nUJjEOUxvxjnIqwYzf7IUmUFLlYiAxuMkYw6iVfrbB0j8Gcn44gMpzXBII+tllRZA+l
         O994zJtqM1x2ueqXxoXrVTcixunM3hAOYoImnCslI+Lph81JcFjFu9+d0VcoO4e+qm9A
         XumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WZfz6rPm5gqwRG7NgDo+h8FHauStJIlcG+L39BpIrWU=;
        b=Lm7wbUBuEwZy7Ln7FN5EQKLK5t32nNzf/R3Gk8RkJOBQJV1DH/eRxQvk2UjdgpSiPo
         EV4eqYzKnq0CgTI1IiSBjukzM164swj7A88UYMucBYMw6gD38Mu9HL/S+I4hfeRgugfw
         /v7hW/gX/BKJULiVJTUskpTLAw7c5Oo7hBFffinX+vlfPnEim+KNnjIsIci6cKVgyF2n
         LqDErawG4TwJ9gzIw3YA0qZLpWls7FrQM3NFwxauk0LaK4BJlmK5HpsrjkMdhtoiOoe6
         anhxYXsE59MoNUxHFauani9ndRYdSUtKMkU/7hylbQf28HFzgPTuoq49wg4ieukqojOw
         NbjQ==
X-Gm-Message-State: AOAM530oL+ShtOCGNl5yr5SpA3Tef0C041lM3EYZWU1UIpzPsdSsoLlI
        YFnr+yE0A7Da04P74i+pRF4IRU5yeTVpsdFWOl8=
X-Google-Smtp-Source: ABdhPJxv05v77FTUrLB91LRn5/L4POevUg5swi51YWezX6OLG+CAeXHoKQ31P1dKKI8MYCFSkM+82sFGeX1fxaP1vd8=
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr10549779ilu.186.1618661242373;
 Sat, 17 Apr 2021 05:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
 <20210417085010.58522C433C6@smtp.codeaurora.org> <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2104171124280.18270@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2104171124280.18270@cbobk.fhfr.pm>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 17 Apr 2021 14:06:46 +0200
Message-ID: <CA+icZUUmEGP=DRqna7sNJ=1WZhzEVRiMSwwCt2hEQr-TkT18aw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 17, 2021 at 11:25 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 17 Apr 2021, Jiri Kosina wrote:
>
> > > This is malformed in patchwork, check the link below. Please resend, and
> > > I strongly recommend to use git send-email to avoid any format issues.
> >
> > Honestly I have no idea what you are talking about, there is no whitespace
> > damage nor anything else that I'd see to be broken. I just took the patch
> > from the mail I sent, applied with git-am, and it worked flawlessly.
> >
> > Anyway, I'll send a patch as a followup to this mail so that it could
> > hopefully be picked up by your tooling.
>
> And it seems to have appeared here:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/
>
> --
> Jiri Kosina
> SUSE Labs
>

Thanks for the patch Jiri.

This is on top of Linux v5.12-rc7+...

link="https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm"

$ b4 -d am $link

$ LC_ALL=C git apply --check --verbose
../v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
Checking patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c...

$ LC_ALL=C git apply --verbose
../v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
Checking patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c...
Applied patch drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c cleanly.

- Sedat -
