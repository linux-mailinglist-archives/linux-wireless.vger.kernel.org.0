Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2C6544FC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiLVQRv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 11:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiLVQRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 11:17:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4BB275F8
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:17:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B941B81E64
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE73C433D2;
        Thu, 22 Dec 2022 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671725862;
        bh=LoYHKg0wmTNX4rw+dBdcQWCt9aspFY+V+Xdqxm8sb/I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hS56MBLbZk96GpBwo/JOg+N+f1Y7XrLJHMs+USjpydLYIl5siL68yIDT0ap1YQc9l
         nuHEgsHqZypD/GiK9vlsWSLzSyBjXnKb9hDufqhjuuwrUEAMnESSwnCMnvXrDQJ+GN
         G8BS0wiUeBrhLxl18k3QTG3fNG3Fs6WFEplXK+5ZCQehAIaCuHro+t4ajgFfKog2jr
         AbTyJzPCXhUW56UuuyO76FT4efwgH3Ipt7av0nKoeXu2cTs2MtIDXZB2njp9Eckpel
         ot4m5/7zQdwwaMhD2TsCLtETqGrtxdsV8dg9g05HcGsnvWoKWgpcerr2Eu+F8z7QFG
         Sy/TZyPLdIrZg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        <linux-wireless@vger.kernel.org>, <dokyungs@yonsei.ac.kr>,
        <jisoo.jang@yonsei.ac.kr>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential slab-out-of-bounds read in brcmf_inform_single_bss()
References: <20221116145821.544266-1-linuxlovemin@yonsei.ac.kr>
        <167172452509.8231.8186319479061770376.kvalo@kernel.org>
        <1853a9d00b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date:   Thu, 22 Dec 2022 18:17:38 +0200
In-Reply-To: <1853a9d00b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        (Arend Van Spriel's message of "Thu, 22 Dec 2022 17:14:06 +0100")
Message-ID: <87bknvza3h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On December 22, 2022 4:55:31 PM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:
>>
>>> This patch fixes a slab-out-of-bounds read in brcmfmac that occurs in
>>> cfg80211_find_elem_match() called from brcmf_inform_single_bss() when
>>> the offset and length values of information elements provided by the
>>> device exceed the boundary of the escan buffer that contains information
>>> elements. The patch adds a check that makes the function return -EINVAL
>>> if that is the case. Note that the negative return is handled by the
>>> caller, brcmf_inform_bss().
>>>
>>> Found by a modified version of syzkaller.
>>>
>>> ==================================================================
>>> BUG: KASAN: slab-out-of-bounds in cfg80211_find_elem_match+0x164/0x180
>>> Read of size 1 at addr ffff888018f0fde9 by task kworker/0:2/1896
>>>
>>> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #139
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>>> Workqueue: events brcmf_fweh_event_worker
>>> Call Trace:
>>> dump_stack_lvl+0x8e/0xd1
>>> print_address_description.constprop.0.cold+0x93/0x334
>>> ? cfg80211_find_elem_match+0x164/0x180
>>> kasan_report.cold+0x79/0xd5
>>> ? cfg80211_find_elem_match+0x164/0x180
>>> cfg80211_find_elem_match+0x164/0x180
>>> cfg80211_get_bss_channel+0x69/0x320
>>> cfg80211_inform_single_bss_data+0x1a6/0x1060
>>> ? cfg80211_bss_update+0x1e20/0x1e20
>>> ? rcu_read_lock_sched_held+0xa1/0xd0
>>> ? rcu_read_lock_bh_held+0xb0/0xb0
>>> ? find_held_lock+0x2d/0x110
>>> ? cfg80211_inform_bss_data+0xcb/0x160
>>> cfg80211_inform_bss_data+0xcb/0x160
>>> ? cfg80211_parse_mbssid_data+0x1540/0x1540
>>> ? kvm_clock_get_cycles+0x14/0x20
>>> ? ktime_get_with_offset+0x2b9/0x450
>>> brcmf_inform_single_bss+0x36d/0x4d0
>>> ? brcmf_notify_mic_status+0xb0/0xb0
>>> ? __lock_acquire+0x181f/0x5790
>>> ? brcmf_p2p_cancel_remain_on_channel+0x30/0x30
>>> brcmf_inform_bss+0x131/0x210
>>> brcmf_cfg80211_escan_handler+0x779/0xd20
>>> ? rcu_read_lock_bh_held+0xb0/0xb0
>>> ? lock_acquire+0x19d/0x4e0
>>> ? find_held_lock+0x2d/0x110
>>> ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
>>> ? brcmf_fweh_event_worker+0x249/0xc00
>>> ? mark_held_locks+0x9f/0xe0
>>> ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>>> ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
>>> brcmf_fweh_call_event_handler.isra.0+0x90/0x100
>>> brcmf_fweh_event_worker+0x117/0xc00
>>> ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
>>> ? rcu_read_lock_sched_held+0xa1/0xd0
>>> ? rcu_read_lock_bh_held+0xb0/0xb0
>>> ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>>> process_one_work+0x92b/0x1460
>>> ? pwq_dec_nr_in_flight+0x330/0x330
>>> ? rwlock_bug.part.0+0x90/0x90
>>> worker_thread+0x95/0xe00
>>> ? __kthread_parkme+0x115/0x1e0
>>> ? process_one_work+0x1460/0x1460
>>> kthread+0x3a1/0x480
>>> ? set_kthread_struct+0x120/0x120
>>> ret_from_fork+0x1f/0x30
>>>
>>> The buggy address belongs to the page:
>>> page:ffffea000063c000 refcount:1 mapcount:0
>>> mapping:0000000000000000 index:0x0 pfn:0x18f00
>>> head:ffffea000063c000 order:4 compound_mapcount:0 compound_pincount:0
>>> flags: 0x100000000010000(head|node=0|zone=1)
>>> raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
>>> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>>> page dumped because: kasan: bad access detected
>>> page_owner tracks the page as allocated
>>> page last allocated via order 4, migratetype Unmovable, gfp_mask
>>> 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 1896, ts
>>> 44510886600, free_ts 0
>>> prep_new_page+0x1aa/0x240
>>> get_page_from_freelist+0x159a/0x27c0
>>> __alloc_pages+0x2da/0x6a0
>>> alloc_pages+0xec/0x1e0
>>> kmalloc_order+0x39/0xf0
>>> kmalloc_order_trace+0x19/0x120
>>> brcmf_cfg80211_attach+0x5c9/0x3fd0
>>> brcmf_attach+0x389/0xd40
>>> brcmf_usb_probe+0x12de/0x1690
>>> usb_probe_interface+0x2aa/0x760
>>> really_probe+0x205/0xb70
>>> __driver_probe_device+0x311/0x4b0
>>> driver_probe_device+0x4e/0x150
>>> __device_attach_driver+0x1cc/0x2a0
>>> bus_for_each_drv+0x156/0x1d0
>>> __device_attach+0x23f/0x3a0
>>> page_owner free stack trace missing
>>>
>>> Memory state around the buggy address:
>>> ffff888018f0fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff888018f0fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> ffff888018f0fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe fe fe
>>>                                                  ^
>>> ffff888018f0fe00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>>> ffff888018f0fe80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>>> ==================================================================
>>>
>>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
>>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
>>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>>
>> Can someone review this?
>
> Will have to see the bigger picture. Probably have time to do that
> later today.

Thanks, and no rush.

> What's the deadline? ;-)

After looking at the crystall ball[1] I would say around February 5th to
get this to v6.3 via -next ;)

[1] https://phb-crystal-ball.sipsolutions.net/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
