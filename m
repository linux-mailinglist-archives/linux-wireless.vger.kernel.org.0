Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3110D6194F3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 11:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiKDK7D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiKDK7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 06:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104122EC
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 03:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB6D62122
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 10:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FECC433D6;
        Fri,  4 Nov 2022 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667559541;
        bh=auV9rttpJXBNhLX8v9wikrmLVlgVi3wnPa3LJ+ZBcvs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CExUt7lcISuRbfOqw7jmtiWmH9akrWcp3Oz6Pwc5XJSrtUHb+VqhNu3shRRz/X5WN
         vj9Ep+HFQnIAU2fgkHPkscaUCgv65eD0oOHpWmqXwg6k0I4DAiZRzh98CpK7psAAQs
         Q/IXaopNkxA+mHzqOisD6A9knNco6pp3ozj7Fes8isIJuCnwzzOVar9vPoy5OS3MqQ
         RHjCohxDURx/+/hJAQGm6vOGBdHk8hUDjtdB05MCAtpgG7t0hXmUwbrGrwTkDiUOfo
         RbjGGfZsht72b20NCbzLyKqnpC2rxyGX7AKcqVasMyHxFs4oXKK8csOliPKz7N3rMw
         r1wASRzeVvPBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Fix potential shift-out-of-bounds in
 brcmf_fw_alloc_request()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221024071329.504277-1-linuxlovemin@yonsei.ac.kr>
References: <20221024071329.504277-1-linuxlovemin@yonsei.ac.kr>
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, aspriel@gmail.com,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166755953410.3283.17967838091783315923.kvalo@kernel.org>
Date:   Fri,  4 Nov 2022 10:58:59 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> This patch fixes a shift-out-of-bounds in brcmfmac that occurs in
> BIT(chiprev) when a 'chiprev' provided by the device is too large.
> It should also not be equal to or greater than BITS_PER_TYPE(u32)
> as we do bitwise AND with a u32 variable and BIT(chiprev). The patch
> adds a check that makes the function return NULL if that is the case.
> Note that the NULL case is later handled by the bus-specific caller,
> brcmf_usb_probe_cb() or brcmf_usb_reset_resume(), for example.
> 
> Found by a modified version of syzkaller.
> 
> UBSAN: shift-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> shift exponent 151055786 is too large for 64-bit type 'long unsigned int'
> CPU: 0 PID: 1885 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_shift_out_of_bounds.cold+0x53/0xdb
>  ? lock_chain_count+0x20/0x20
>  brcmf_fw_alloc_request.cold+0x19/0x3ea
>  ? brcmf_fw_get_firmwares+0x250/0x250
>  ? brcmf_usb_ioctl_resp_wait+0x1a7/0x1f0
>  brcmf_usb_get_fwname+0x114/0x1a0
>  ? brcmf_usb_reset_resume+0x120/0x120
>  ? number+0x6c4/0x9a0
>  brcmf_c_process_clm_blob+0x168/0x590
>  ? put_dec+0x90/0x90
>  ? enable_ptr_key_workfn+0x20/0x20
>  ? brcmf_common_pd_remove+0x50/0x50
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  brcmf_c_preinit_dcmds+0x673/0xc40
>  ? brcmf_c_set_joinpref_default+0x100/0x100
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lock_acquire+0x19d/0x4e0
>  ? find_held_lock+0x2d/0x110
>  ? brcmf_usb_deq+0x1cc/0x260
>  ? mark_held_locks+0x9f/0xe0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  ? _raw_spin_unlock_irqrestore+0x47/0x50
>  ? trace_hardirqs_on+0x1c/0x120
>  ? brcmf_usb_deq+0x1a7/0x260
>  ? brcmf_usb_rx_fill_all+0x5a/0xf0
>  brcmf_attach+0x246/0xd40
>  ? wiphy_new_nm+0x1476/0x1d50
>  ? kmemdup+0x30/0x40
>  brcmf_usb_probe+0x12de/0x1690
>  ? brcmf_usbdev_qinit.constprop.0+0x470/0x470
>  usb_probe_interface+0x25f/0x710
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  ? usb_match_id.part.0+0x88/0xc0
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  ? driver_allows_async_probing+0x120/0x120
>  bus_for_each_drv+0x123/0x1a0
>  ? bus_rescan_devices+0x20/0x20
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  ? trace_hardirqs_on+0x1c/0x120
>  __device_attach+0x207/0x330
>  ? device_bind_driver+0xb0/0xb0
>  ? kobject_uevent_env+0x230/0x12c0
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  ? __mutex_unlock_slowpath+0xe7/0x660
>  ? __fw_devlink_link_to_suppliers+0x550/0x550
>  usb_set_configuration+0x984/0x1770
>  ? kernfs_create_link+0x175/0x230
>  usb_generic_driver_probe+0x69/0x90
>  usb_probe_device+0x9c/0x220
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  ? driver_allows_async_probing+0x120/0x120
>  bus_for_each_drv+0x123/0x1a0
>  ? bus_rescan_devices+0x20/0x20
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  ? trace_hardirqs_on+0x1c/0x120
>  __device_attach+0x207/0x330
>  ? device_bind_driver+0xb0/0xb0
>  ? kobject_uevent_env+0x230/0x12c0
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  ? __fw_devlink_link_to_suppliers+0x550/0x550
>  usb_new_device.cold+0x463/0xf66
>  ? hub_disconnect+0x400/0x400
>  ? _raw_spin_unlock_irq+0x24/0x30
>  hub_event+0x10d5/0x3330
>  ? hub_port_debounce+0x280/0x280
>  ? __lock_acquire+0x1671/0x5790
>  ? wq_calc_node_cpumask+0x170/0x2a0
>  ? lock_release+0x640/0x640
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  process_one_work+0x873/0x13e0
>  ? lock_release+0x640/0x640
>  ? pwq_dec_nr_in_flight+0x320/0x320
>  ? rwlock_bug.part.0+0x90/0x90
>  worker_thread+0x8b/0xd10
>  ? __kthread_parkme+0xd9/0x1d0
>  ? process_one_work+0x13e0/0x13e0
>  kthread+0x379/0x450
>  ? _raw_spin_unlock_irq+0x24/0x30
>  ? set_kthread_struct+0x100/0x100
>  ret_from_fork+0x1f/0x30
> 
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

Patch applied to wireless-next.git, thanks.

81d17f6f3331 wifi: brcmfmac: Fix potential shift-out-of-bounds in brcmf_fw_alloc_request()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221024071329.504277-1-linuxlovemin@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

