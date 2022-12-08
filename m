Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE764753A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLHR71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHR70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 12:59:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA06AD309
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 09:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8820B825BC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 17:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE01C433EF;
        Thu,  8 Dec 2022 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670522362;
        bh=146eB7MJ8GZsGaKQMGkmF5Ctt+at36Kgtgh+Sx9caBE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=acXRtS7BfzmCk2ttZtwE4q0SPWugNH+gf5xVh846s0Rr0ZpNR0NlIZwuEVlSwKbKA
         3IgE5oU/bnviHufwE2G3AmvIkFMHOwTH+mJhQooDGjjY7EaqTRcRs1yGmvrRMLbPO/
         7CNVPO0jwDmkghHZ4m8Yq7kvsm34hevAyML8uq+rw3iBiWJDgZV6oFectfupBFgpnD
         o5dFAhMjcYEhnZ9yzGmSnNEzl0qNx8eLlqCOoB1TfnIdPAQDHWtM0LrnsPzuMMJH8d
         +k80RAgJo88mETIptkNu0QMadPaQ7O0svrycGiZGT6Njd2+OnXqLA9Z8nm6AQLw5Km
         vK/lCOAfzsvHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: Fix use-after-free in ath9k_hif_usb_disconnect()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221205014308.1617597-1-linuxlovemin@yonsei.ac.kr>
References: <20221205014308.1617597-1-linuxlovemin@yonsei.ac.kr>
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, toke@toke.dk,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167052235640.20906.4467152022721762732.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 17:59:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> This patch fixes a use-after-free in ath9k that occurs in
> ath9k_hif_usb_disconnect() when ath9k_destroy_wmi() is trying to access
> 'drv_priv' that has already been freed by ieee80211_free_hw(), called by
> ath9k_htc_hw_deinit(). The patch moves ath9k_destroy_wmi() before
> ieee80211_free_hw(). Note that urbs from the driver should be killed
> before freeing 'wmi' with ath9k_destroy_wmi() as their callbacks will
> access 'wmi'.
> 
> Found by a modified version of syzkaller.
> 
> ==================================================================
> BUG: KASAN: use-after-free in ath9k_destroy_wmi+0x38/0x40
> Read of size 8 at addr ffff8881069132a0 by task kworker/0:1/7
> 
> CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: G O 5.14.0+ #131
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  dump_stack_lvl+0x8e/0xd1
>  print_address_description.constprop.0.cold+0x93/0x334
>  ? ath9k_destroy_wmi+0x38/0x40
>  ? ath9k_destroy_wmi+0x38/0x40
>  kasan_report.cold+0x83/0xdf
>  ? ath9k_destroy_wmi+0x38/0x40
>  ath9k_destroy_wmi+0x38/0x40
>  ath9k_hif_usb_disconnect+0x329/0x3f0
>  ? ath9k_hif_usb_suspend+0x120/0x120
>  ? usb_disable_interface+0xfc/0x180
>  usb_unbind_interface+0x19b/0x7e0
>  ? usb_autoresume_device+0x50/0x50
>  device_release_driver_internal+0x44d/0x520
>  bus_remove_device+0x2e5/0x5a0
>  device_del+0x5b2/0xe30
>  ? __device_link_del+0x370/0x370
>  ? usb_remove_ep_devs+0x43/0x80
>  ? remove_intf_ep_devs+0x112/0x1a0
>  usb_disable_device+0x1e3/0x5a0
>  usb_disconnect+0x267/0x870
>  hub_event+0x168d/0x3950
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? hub_port_debounce+0x2e0/0x2e0
>  ? check_irq_usage+0x860/0xf20
>  ? drain_workqueue+0x281/0x360
>  ? lock_release+0x640/0x640
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  process_one_work+0x92b/0x1460
>  ? pwq_dec_nr_in_flight+0x330/0x330
>  ? rwlock_bug.part.0+0x90/0x90
>  worker_thread+0x95/0xe00
>  ? __kthread_parkme+0x115/0x1e0
>  ? process_one_work+0x1460/0x1460
>  kthread+0x3a1/0x480
>  ? set_kthread_struct+0x120/0x120
>  ret_from_fork+0x1f/0x30
> 
> The buggy address belongs to the page:
> page:ffffea00041a44c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106913
> flags: 0x200000000000000(node=0|zone=2)
> raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 7, ts 38347963444, free_ts 41399957635
>  prep_new_page+0x1aa/0x240
>  get_page_from_freelist+0x159a/0x27c0
>  __alloc_pages+0x2da/0x6a0
>  alloc_pages+0xec/0x1e0
>  kmalloc_order+0x39/0xf0
>  kmalloc_order_trace+0x19/0x120
>  __kmalloc+0x308/0x390
>  wiphy_new_nm+0x6f5/0x1dd0
>  ieee80211_alloc_hw_nm+0x36d/0x2230
>  ath9k_htc_probe_device+0x9d/0x1e10
>  ath9k_htc_hw_init+0x34/0x50
>  ath9k_hif_usb_firmware_cb+0x25f/0x4e0
>  request_firmware_work_func+0x131/0x240
>  process_one_work+0x92b/0x1460
>  worker_thread+0x95/0xe00
>  kthread+0x3a1/0x480
> page last free stack trace:
>  free_pcp_prepare+0x3d3/0x7f0
>  free_unref_page+0x1e/0x3d0
>  device_release+0xa4/0x240
>  kobject_put+0x186/0x4c0
>  put_device+0x20/0x30
>  ath9k_htc_disconnect_device+0x1cf/0x2c0
>  ath9k_htc_hw_deinit+0x26/0x30
>  ath9k_hif_usb_disconnect+0x2d9/0x3f0
>  usb_unbind_interface+0x19b/0x7e0
>  device_release_driver_internal+0x44d/0x520
>  bus_remove_device+0x2e5/0x5a0
>  device_del+0x5b2/0xe30
>  usb_disable_device+0x1e3/0x5a0
>  usb_disconnect+0x267/0x870
>  hub_event+0x168d/0x3950
>  process_one_work+0x92b/0x1460
> 
> Memory state around the buggy address:
>  ffff888106913180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888106913200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff888106913280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                ^
>  ffff888106913300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888106913380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f099c5c9e2ba wifi: ath9k: Fix use-after-free in ath9k_hif_usb_disconnect()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221205014308.1617597-1-linuxlovemin@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

