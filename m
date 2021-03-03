Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7F32C12F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhCCVRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:18 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:28274 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhCCQAu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 11:00:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614787217; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=63uD1rKESWU1WACrRV+OsLIaFjlY+XnAo1HvrwgjRqY=;
 b=stC6+EqPPZgy0JQCGKMf2HP1vRE1qG4J4l5NjbMa5xluO8jX5ccI2uq8OveIt6TE/a6rhL0z
 AdT50/2cMEq6UQzVhh1Mr0nyrjUKvXznhqPSA3CS3jt+yYK2GT4HTZgZYcrLW0sukH2Y/1Jb
 wkKoYwj5gB626bbm5BaR1MecpW8=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 603fb26d1a5c93533fec4c0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 15:59:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0819C433ED; Wed,  3 Mar 2021 15:59:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1A31C433CA;
        Wed,  3 Mar 2021 15:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1A31C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock
 held
 (was Re: Lockdep warning in iwl_pcie_rx_handle())
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210303155940.C0819C433ED@smtp.codeaurora.org>
Date:   Wed,  3 Mar 2021 15:59:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> We can't call netif_napi_add() with rxq-lock held, as there is a potential
> for deadlock as spotted by lockdep (see below). rxq->lock is not
> protecting anything over the netif_napi_add() codepath anyway, so let's
> drop it just before calling into NAPI.
> 
>  ========================================================
>  WARNING: possible irq lock inversion dependency detected
>  5.12.0-rc1-00002-gbada49429032 #5 Not tainted
>  --------------------------------------------------------
>  irq/136-iwlwifi/565 just changed the state of lock:
>  ffff89f28433b0b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
>  but this lock took another, SOFTIRQ-unsafe lock in the past:
>   (napi_hash_lock){+.+.}-{2:2}
> 
>  and interrupts could create inverse lock ordering between them.
> 
>  other info that might help us debug this:
>   Possible interrupt unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(napi_hash_lock);
>                                 local_irq_disable();
>                                 lock(&rxq->lock);
>                                 lock(napi_hash_lock);
>    <Interrupt>
>      lock(&rxq->lock);
> 
>   *** DEADLOCK ***
> 
>  1 lock held by irq/136-iwlwifi/565:
>   #0: ffff89f2b1440170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at: iwl_pcie_irq_handler+0x5/0xb30
> 
>  the shortest dependencies between 2nd lock and 1st lock:
>   -> (napi_hash_lock){+.+.}-{2:2} {
>      HARDIRQ-ON-W at:
>                        lock_acquire+0x277/0x3d0
>                        _raw_spin_lock+0x2c/0x40
>                        netif_napi_add+0x14b/0x270
>                        e1000_probe+0x2fe/0xee0 [e1000e]
>                        local_pci_probe+0x42/0x90
>                        pci_device_probe+0x10b/0x1c0
>                        really_probe+0xef/0x4b0
>                        driver_probe_device+0xde/0x150
>                        device_driver_attach+0x4f/0x60
>                        __driver_attach+0x9c/0x140
>                        bus_for_each_dev+0x79/0xc0
>                        bus_add_driver+0x18d/0x220
>                        driver_register+0x5b/0xf0
>                        do_one_initcall+0x5b/0x300
>                        do_init_module+0x5b/0x21c
>                        load_module+0x1dae/0x22c0
>                        __do_sys_finit_module+0xad/0x110
>                        do_syscall_64+0x33/0x80
>                        entry_SYSCALL_64_after_hwframe+0x44/0xae
>      SOFTIRQ-ON-W at:
>                        lock_acquire+0x277/0x3d0
>                        _raw_spin_lock+0x2c/0x40
>                        netif_napi_add+0x14b/0x270
>                        e1000_probe+0x2fe/0xee0 [e1000e]
>                        local_pci_probe+0x42/0x90
>                        pci_device_probe+0x10b/0x1c0
>                        really_probe+0xef/0x4b0
>                        driver_probe_device+0xde/0x150
>                        device_driver_attach+0x4f/0x60
>                        __driver_attach+0x9c/0x140
>                        bus_for_each_dev+0x79/0xc0
>                        bus_add_driver+0x18d/0x220
>                        driver_register+0x5b/0xf0
>                        do_one_initcall+0x5b/0x300
>                        do_init_module+0x5b/0x21c
>                        load_module+0x1dae/0x22c0
>                        __do_sys_finit_module+0xad/0x110
>                        do_syscall_64+0x33/0x80
>                        entry_SYSCALL_64_after_hwframe+0x44/0xae
>      INITIAL USE at:
>                       lock_acquire+0x277/0x3d0
>                       _raw_spin_lock+0x2c/0x40
>                       netif_napi_add+0x14b/0x270
>                       e1000_probe+0x2fe/0xee0 [e1000e]
>                       local_pci_probe+0x42/0x90
>                       pci_device_probe+0x10b/0x1c0
>                       really_probe+0xef/0x4b0
>                       driver_probe_device+0xde/0x150
>                       device_driver_attach+0x4f/0x60
>                       __driver_attach+0x9c/0x140
>                       bus_for_each_dev+0x79/0xc0
>                       bus_add_driver+0x18d/0x220
>                       driver_register+0x5b/0xf0
>                       do_one_initcall+0x5b/0x300
>                       do_init_module+0x5b/0x21c
>                       load_module+0x1dae/0x22c0
>                       __do_sys_finit_module+0xad/0x110
>                       do_syscall_64+0x33/0x80
>                       entry_SYSCALL_64_after_hwframe+0x44/0xae
>    }
>    ... key      at: [<ffffffffae84ef38>] napi_hash_lock+0x18/0x40
>    ... acquired at:
>     _raw_spin_lock+0x2c/0x40
>     netif_napi_add+0x14b/0x270
>     _iwl_pcie_rx_init+0x1f4/0x710 [iwlwifi]
>     iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
>     iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
>     iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
>     iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
>     iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
>     _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
>     iwl_opmode_register+0x71/0xe0 [iwlwifi]
>     iwl_mvm_init+0x34/0x1000 [iwlmvm]
>     do_one_initcall+0x5b/0x300
>     do_init_module+0x5b/0x21c
>     load_module+0x1dae/0x22c0
>     __do_sys_finit_module+0xad/0x110
>     do_syscall_64+0x33/0x80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [ ... lockdep output trimmed .... ]
> 
> Fixes: 25edc8f259c7106 ("iwlwifi: pcie: properly implement NAPI")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

295d4cd82b01 iwlwifi: don't call netif_napi_add() with rxq->lock held (was Re: Lockdep warning in iwl_pcie_rx_handle())

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

