Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346632C8EC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 02:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhCDA6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 19:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbhCCVlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 16:41:40 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0369C06175F;
        Wed,  3 Mar 2021 13:40:36 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z9so12554917iln.1;
        Wed, 03 Mar 2021 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FLZrt1CW9HybSVzuG4701VEOUdH/8fHh+61eB7JCqZQ=;
        b=NTc70gGazZ/N+nSb1qqzeym7g4nUk0qJsbEhZrWmeaLKO3SgXtI9UEAfoxhTUJ60uL
         io3NaksicC34NxB16+AxkZ6YPQ1MFnrygzaGgz9lbL1LOVfylMF13zSh9uSb+wnUVHYT
         FHXsHJfWY3qeOhqKP/ugVINsgGQZQEAX328j0nhXe5FHFi5IEKvr5Zv70wV4yM9rozEx
         VrhUqaa5748N7AotPMRjWRzQeet2EKLlTaFHSomZuFAQtAY9JN+bjCNsKNq2vWpzI9Cq
         GmFSUXb9sRpG5zcZVEcerS/asePXwl+89Qc2MWRjcIT0BZKttEGVyF3tNOt2OVJTzx2B
         tyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FLZrt1CW9HybSVzuG4701VEOUdH/8fHh+61eB7JCqZQ=;
        b=PZeRoztkC/EQ6e51uVG8F+aLOvUGPXxJeEdEnIlCJALd/FXAqZ8BdexCRVkW7f0hkj
         qitcAxcC5xw/WWWlZ5KwgGf4nFbD1Y+WOSYRPKnO6yMdDFmJfJtNwkt6cHfKLuZRYA5i
         /oZvYZ2iA3JnXzFIOeprTbyy8Gw7t/mpn95RhmxrW583rAz0rQpsR92uDAtKmkAeeNXn
         d3DqlTmiZFbRYebBurKTgbcd+RMcjmXhC/VpgUEHgWhFdeai98LYnpa6iifmn9A2+2qm
         6p5kaGGpRvbpjK5fYqdJYR3Rij9Rc6QZOhPHgJkoFnV1rM02/ma5mT5bPQmzrdjZX076
         6dtw==
X-Gm-Message-State: AOAM530KT3kDimCroka6IEqrnyqjlm0+QXSIQrTvtLFsgglXGK33lY0w
        yOUR6gKtZt8ftHfrtqmOuwLMwT4snQAtAmXXtZA=
X-Google-Smtp-Source: ABdhPJw6LeoL3KWq5KgU+mXasKFmoiMQDf6e3TTmm+hOsFNnTWVtkiuaJlL24djy5G239KCoZogx8rcAJsugl0YCg40=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr1247950ilk.209.1614807635884;
 Wed, 03 Mar 2021 13:40:35 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>
 <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net>
 <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
 <7de7aa19e5ea8a856cce4193ebb3c31b4ef78ca7.camel@intel.com> <87blc192cz.fsf@codeaurora.org>
In-Reply-To: <87blc192cz.fsf@codeaurora.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 3 Mar 2021 22:39:59 +0100
Message-ID: <CA+icZUWNUp+_BiJMS45QUYZY1+AYwemY_O=uT5w_2GtzFUh5ww@mail.gmail.com>
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock
 held (was Re: Lockdep warning in iwl_pcie_rx_handle())
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 3, 2021 at 1:38 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> "Coelho, Luciano" <luciano.coelho@intel.com> writes:
>
> > On Tue, 2021-03-02 at 11:34 +0100, Jiri Kosina wrote:
> >> From: Jiri Kosina <jkosina@suse.cz>
> >>
> >> We can't call netif_napi_add() with rxq-lock held, as there is a potential
> >> for deadlock as spotted by lockdep (see below). rxq->lock is not
> >> protecting anything over the netif_napi_add() codepath anyway, so let's
> >> drop it just before calling into NAPI.
> >>
> >>  ========================================================
> >>  WARNING: possible irq lock inversion dependency detected
> >>  5.12.0-rc1-00002-gbada49429032 #5 Not tainted
> >>  --------------------------------------------------------
> >>  irq/136-iwlwifi/565 just changed the state of lock:
> >>  ffff89f28433b0b0 (&rxq->lock){+.-.}-{2:2}, at:
> >> iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
> >>  but this lock took another, SOFTIRQ-unsafe lock in the past:
> >>   (napi_hash_lock){+.+.}-{2:2}
> >>
> >>  and interrupts could create inverse lock ordering between them.
> >>
> >>  other info that might help us debug this:
> >>   Possible interrupt unsafe locking scenario:
> >>
> >>         CPU0                    CPU1
> >>         ----                    ----
> >>    lock(napi_hash_lock);
> >>                                 local_irq_disable();
> >>                                 lock(&rxq->lock);
> >>                                 lock(napi_hash_lock);
> >>    <Interrupt>
> >>      lock(&rxq->lock);
> >>
> >>   *** DEADLOCK ***
> >>
> >>  1 lock held by irq/136-iwlwifi/565:
> >>   #0: ffff89f2b1440170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at:
> >> iwl_pcie_irq_handler+0x5/0xb30
> >>
> >>  the shortest dependencies between 2nd lock and 1st lock:
> >>   -> (napi_hash_lock){+.+.}-{2:2} {
> >>      HARDIRQ-ON-W at:
> >>                        lock_acquire+0x277/0x3d0
> >>                        _raw_spin_lock+0x2c/0x40
> >>                        netif_napi_add+0x14b/0x270
> >>                        e1000_probe+0x2fe/0xee0 [e1000e]
> >>                        local_pci_probe+0x42/0x90
> >>                        pci_device_probe+0x10b/0x1c0
> >>                        really_probe+0xef/0x4b0
> >>                        driver_probe_device+0xde/0x150
> >>                        device_driver_attach+0x4f/0x60
> >>                        __driver_attach+0x9c/0x140
> >>                        bus_for_each_dev+0x79/0xc0
> >>                        bus_add_driver+0x18d/0x220
> >>                        driver_register+0x5b/0xf0
> >>                        do_one_initcall+0x5b/0x300
> >>                        do_init_module+0x5b/0x21c
> >>                        load_module+0x1dae/0x22c0
> >>                        __do_sys_finit_module+0xad/0x110
> >>                        do_syscall_64+0x33/0x80
> >>                        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>      SOFTIRQ-ON-W at:
> >>                        lock_acquire+0x277/0x3d0
> >>                        _raw_spin_lock+0x2c/0x40
> >>                        netif_napi_add+0x14b/0x270
> >>                        e1000_probe+0x2fe/0xee0 [e1000e]
> >>                        local_pci_probe+0x42/0x90
> >>                        pci_device_probe+0x10b/0x1c0
> >>                        really_probe+0xef/0x4b0
> >>                        driver_probe_device+0xde/0x150
> >>                        device_driver_attach+0x4f/0x60
> >>                        __driver_attach+0x9c/0x140
> >>                        bus_for_each_dev+0x79/0xc0
> >>                        bus_add_driver+0x18d/0x220
> >>                        driver_register+0x5b/0xf0
> >>                        do_one_initcall+0x5b/0x300
> >>                        do_init_module+0x5b/0x21c
> >>                        load_module+0x1dae/0x22c0
> >>                        __do_sys_finit_module+0xad/0x110
> >>                        do_syscall_64+0x33/0x80
> >>                        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>      INITIAL USE at:
> >>                       lock_acquire+0x277/0x3d0
> >>                       _raw_spin_lock+0x2c/0x40
> >>                       netif_napi_add+0x14b/0x270
> >>                       e1000_probe+0x2fe/0xee0 [e1000e]
> >>                       local_pci_probe+0x42/0x90
> >>                       pci_device_probe+0x10b/0x1c0
> >>                       really_probe+0xef/0x4b0
> >>                       driver_probe_device+0xde/0x150
> >>                       device_driver_attach+0x4f/0x60
> >>                       __driver_attach+0x9c/0x140
> >>                       bus_for_each_dev+0x79/0xc0
> >>                       bus_add_driver+0x18d/0x220
> >>                       driver_register+0x5b/0xf0
> >>                       do_one_initcall+0x5b/0x300
> >>                       do_init_module+0x5b/0x21c
> >>                       load_module+0x1dae/0x22c0
> >>                       __do_sys_finit_module+0xad/0x110
> >>                       do_syscall_64+0x33/0x80
> >>                       entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>    }
> >>    ... key      at: [<ffffffffae84ef38>] napi_hash_lock+0x18/0x40
> >>    ... acquired at:
> >>     _raw_spin_lock+0x2c/0x40
> >>     netif_napi_add+0x14b/0x270
> >>     _iwl_pcie_rx_init+0x1f4/0x710 [iwlwifi]
> >>     iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
> >>     iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
> >>     iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
> >>     iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
> >>     iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
> >>     _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
> >>     iwl_opmode_register+0x71/0xe0 [iwlwifi]
> >>     iwl_mvm_init+0x34/0x1000 [iwlmvm]
> >>     do_one_initcall+0x5b/0x300
> >>     do_init_module+0x5b/0x21c
> >>     load_module+0x1dae/0x22c0
> >>     __do_sys_finit_module+0xad/0x110
> >>     do_syscall_64+0x33/0x80
> >>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> [ ... lockdep output trimmed .... ]
> >>
> >> Fixes: 25edc8f259c7106 ("iwlwifi: pcie: properly implement NAPI")
> >> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >> ---
> >>
> >> v1->v2: Previous patch was not refreshed against current code-base, sorry.
> >>
> >>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >
> > Thanks, Jiri! Let's take your patch since you already sent it out.
> >
> > Kalle, can you please take this directly to wireless-drivers.git?
> >
> > Acked-by: Luca Coelho <luciano.coelho@intel.com>
>
> Ok but I don't see this either in patchwork or lore, hopefully it shows
> up later.
>

Is that intended to have a subject like...?

iwlwifi: don't call netif_napi_add() with rxq->lock held (was Re:
Lockdep warning in iwl_pcie_rx_handle())

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=295d4cd82b0181dd36b145fd535c13d623d7a335
