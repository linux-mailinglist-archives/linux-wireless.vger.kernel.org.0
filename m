Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF762B66A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKPJYD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 04:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiKPJX4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 04:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8CF0C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 01:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9592B81C55
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 09:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1470DC433C1;
        Wed, 16 Nov 2022 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668590632;
        bh=kaszeBxF7JFKhYWX2bdbySuhsKu07PhPaXI+ccjVn+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RLsfG0JFK4hPoxjW/Oq/KtIdqim3eQVi+PKDMkUIADuZCg4lmkcEVNcbVYTbFVBy+
         KSWBI0WvB5jQ1NXWaIIdSR0lOnq5s7f9schmcmGalOfQiH1P4j7GJqExa3O/2RAIit
         8AlNVr5w/Y2iqSCs7rj/2qsWZVIwgjCXdtPF+S76y6UhV3RbMZ1KnbbfLHGdrI2nq5
         FQSOHEBTtCv8ccEUUVQXUPozi9nidxLTLZUDQwoNS5YvNrveql4nqC3wN0tg5qRkxE
         rGqQATTH25H5TialzwtWe2/kw7FegUe2EuR6WHv5dRsLHhsOY77LIT5umYkwtH9aTc
         Ic5SCnMfuLNyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Check the count value of channel spec to
 prevent out-of-bounds reads
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221111075346.136376-1-linuxlovemin@yonsei.ac.kr>
References: <20221111075346.136376-1-linuxlovemin@yonsei.ac.kr>
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, aspriel@gmail.com,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166859062890.16887.3852526152218508056.kvalo@kernel.org>
Date:   Wed, 16 Nov 2022 09:23:50 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> This patch fixes slab-out-of-bounds reads in brcmfmac that occur in
> brcmf_construct_chaninfo() and brcmf_enable_bw40_2g() when the count
> value of channel specifications provided by the device is greater than
> the length of 'list->element[]', decided by the size of the 'list'
> allocated with kzalloc(). The patch adds checks that make the functions
> free the buffer and return -EINVAL if that is the case. Note that the
> negative return is handled by the caller, brcmf_setup_wiphybands() or
> brcmf_cfg80211_attach().
> 
> Found by a modified version of syzkaller.
> 
> Crash Report from brcmf_construct_chaninfo():
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in brcmf_setup_wiphybands+0x1238/0x1430
> Read of size 4 at addr ffff888115f24600 by task kworker/0:2/1896
> 
> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  print_address_description.constprop.0.cold+0x93/0x334
>  kasan_report.cold+0x83/0xdf
>  brcmf_setup_wiphybands+0x1238/0x1430
>  brcmf_cfg80211_attach+0x2118/0x3fd0
>  brcmf_attach+0x389/0xd40
>  brcmf_usb_probe+0x12de/0x1690
>  usb_probe_interface+0x25f/0x710
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_set_configuration+0x984/0x1770
>  usb_generic_driver_probe+0x69/0x90
>  usb_probe_device+0x9c/0x220
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_new_device.cold+0x463/0xf66
>  hub_event+0x10d5/0x3330
>  process_one_work+0x873/0x13e0
>  worker_thread+0x8b/0xd10
>  kthread+0x379/0x450
>  ret_from_fork+0x1f/0x30
> 
> Allocated by task 1896:
>  kasan_save_stack+0x1b/0x40
>  __kasan_kmalloc+0x7c/0x90
>  kmem_cache_alloc_trace+0x19e/0x330
>  brcmf_setup_wiphybands+0x290/0x1430
>  brcmf_cfg80211_attach+0x2118/0x3fd0
>  brcmf_attach+0x389/0xd40
>  brcmf_usb_probe+0x12de/0x1690
>  usb_probe_interface+0x25f/0x710
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_set_configuration+0x984/0x1770
>  usb_generic_driver_probe+0x69/0x90
>  usb_probe_device+0x9c/0x220
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_new_device.cold+0x463/0xf66
>  hub_event+0x10d5/0x3330
>  process_one_work+0x873/0x13e0
>  worker_thread+0x8b/0xd10
>  kthread+0x379/0x450
>  ret_from_fork+0x1f/0x30
> 
> The buggy address belongs to the object at ffff888115f24000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 1536 bytes inside of
>  2048-byte region [ffff888115f24000, ffff888115f24800)
> 
> Memory state around the buggy address:
>  ffff888115f24500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888115f24580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888115f24600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff888115f24680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888115f24700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> Crash Report from brcmf_enable_bw40_2g():
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in brcmf_cfg80211_attach+0x3d11/0x3fd0
> Read of size 4 at addr ffff888103787600 by task kworker/0:2/1896
> 
> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  print_address_description.constprop.0.cold+0x93/0x334
>  kasan_report.cold+0x83/0xdf
>  brcmf_cfg80211_attach+0x3d11/0x3fd0
>  brcmf_attach+0x389/0xd40
>  brcmf_usb_probe+0x12de/0x1690
>  usb_probe_interface+0x25f/0x710
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_set_configuration+0x984/0x1770
>  usb_generic_driver_probe+0x69/0x90
>  usb_probe_device+0x9c/0x220
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_new_device.cold+0x463/0xf66
>  hub_event+0x10d5/0x3330
>  process_one_work+0x873/0x13e0
>  worker_thread+0x8b/0xd10
>  kthread+0x379/0x450
>  ret_from_fork+0x1f/0x30
> 
> Allocated by task 1896:
>  kasan_save_stack+0x1b/0x40
>  __kasan_kmalloc+0x7c/0x90
>  kmem_cache_alloc_trace+0x19e/0x330
>  brcmf_cfg80211_attach+0x3302/0x3fd0
>  brcmf_attach+0x389/0xd40
>  brcmf_usb_probe+0x12de/0x1690
>  usb_probe_interface+0x25f/0x710
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_set_configuration+0x984/0x1770
>  usb_generic_driver_probe+0x69/0x90
>  usb_probe_device+0x9c/0x220
>  really_probe+0x1be/0xa90
>  __driver_probe_device+0x2ab/0x460
>  driver_probe_device+0x49/0x120
>  __device_attach_driver+0x18a/0x250
>  bus_for_each_drv+0x123/0x1a0
>  __device_attach+0x207/0x330
>  bus_probe_device+0x1a2/0x260
>  device_add+0xa61/0x1ce0
>  usb_new_device.cold+0x463/0xf66
>  hub_event+0x10d5/0x3330
>  process_one_work+0x873/0x13e0
>  worker_thread+0x8b/0xd10
>  kthread+0x379/0x450
>  ret_from_fork+0x1f/0x30
> 
> The buggy address belongs to the object at ffff888103787000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 1536 bytes inside of
>  2048-byte region [ffff888103787000, ffff888103787800)
> 
> Memory state around the buggy address:
>  ffff888103787500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888103787580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888103787600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff888103787680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888103787700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

Can someone review this, please?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221111075346.136376-1-linuxlovemin@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

