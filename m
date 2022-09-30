Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384815F04D8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiI3Ge3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiI3Ge2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 02:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F306200B20
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 23:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8FF62249
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 06:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E1C433D6;
        Fri, 30 Sep 2022 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664519666;
        bh=t0vpNSK6/kdyjJIP+8iqT91dTJoiKNWOU0u4QS6i3FE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TB4cyElNhP1S9ImHXgcfT4yhJFGD8ABWe3MprTf6GQ1TGNZ/8VMtHHdP9Yf+Y22UY
         0kEUCEZR3ZQ3il3AejN8Tm6hTnOaHLtgUHdk42OTdIxdbxkk9lhbmRa+UKUD84Gsx3
         fpGKpylKq+e7Qjs9JwROXnda1jouHkJQqaoZGOLZm3ADsJP/p7TWh/Oax2Ze/OEgMk
         iE2WvL6moL5rjdvHlfEMnagXOLMTV0lN6wdjuiHFgEbqix2bhWnbbGkwrIjhr9WP1D
         ha3K50Pw5bXwTHZkMuixO49wqnb1Xw6ks288oJlaXF/X1A/Yv+IvoNPIykmCVQlQG0
         WSJvz9yo8+Arw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix warning in dma_free_coherent() of
 memory
 chunks while recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220928073832.16251-1-quic_wgong@quicinc.com>
References: <20220928073832.16251-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166451966286.6083.5664956819797133445.kvalo@kernel.org>
Date:   Fri, 30 Sep 2022 06:34:24 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Commit 26f3a021b37c ("ath11k: allocate smaller chunks of memory for
> firmware") and commit f6f92968e1e5 ("ath11k: qmi: try to allocate a
> big block of DMA memory first") change ath11k to allocate the memory
> chunks for target twice while wlan load. It fails for the 1st time
> because of large memory and then changed to allocate many small chunks
> for the 2nd time sometimes as below log.
> 
> 1st time failed:
> [10411.640620] ath11k_pci 0000:05:00.0: qmi firmware request memory request
> [10411.640625] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 6881280
> [10411.640630] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 3784704
> [10411.640658] ath11k_pci 0000:05:00.0: qmi dma allocation failed (6881280 B type 1), will try later with small size
> [10411.640671] ath11k_pci 0000:05:00.0: qmi delays mem_request 2
> [10411.640677] ath11k_pci 0000:05:00.0: qmi respond memory request delayed 1
> 2nd time success:
> [10411.642004] ath11k_pci 0000:05:00.0: qmi firmware request memory request
> [10411.642008] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642012] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642014] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642016] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642018] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642020] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642022] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642024] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642027] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642029] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> [10411.642031] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 458752
> [10411.642033] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 131072
> [10411.642035] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642037] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642039] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642041] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642043] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642045] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
> [10411.642047] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 491520
> [10411.642049] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
> 
> And then commit 5962f370ce41 ("ath11k: Reuse the available memory after
> firmware reload") skip the ath11k_qmi_free_resource() which frees the
> memory chunks while recovery, after that, when run recovery test on
> WCN6855, a warning happened every time as below and finally leads fail
> for recovery.
> 
> [  159.570318] BUG: Bad page state in process kworker/u16:5  pfn:33300
> [  159.570320] page:0000000096ffdbb9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33300
> [  159.570324] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [  159.570329] raw: 000fffffc0000000 0000000000000000 dead000000000122 0000000000000000
> [  159.570332] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [  159.570334] page dumped because: nonzero _refcount
> [  159.570440]  firewire_ohci syscopyarea sysfillrect psmouse sdhci_pci ahci sysimgblt firewire_core fb_sys_fops libahci crc_itu_t cqhci drm sdhci e1000e wmi video
> [  159.570460] CPU: 2 PID: 217 Comm: kworker/u16:5 Kdump: loaded Tainted: G    B             5.19.0-rc1-wt-ath+ #3
> [  159.570465] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW (1.33 ) 07/29/2011
> [  159.570467] Workqueue: qmi_msg_handler qmi_data_ready_work [qmi_helpers]
> [  159.570475] Call Trace:
> [  159.570476]  <TASK>
> [  159.570478]  dump_stack_lvl+0x49/0x5f
> [  159.570486]  dump_stack+0x10/0x12
> [  159.570493]  bad_page+0xab/0xf0
> [  159.570502]  check_free_page_bad+0x66/0x70
> [  159.570511]  __free_pages_ok+0x530/0x9a0
> [  159.570517]  ? __dev_printk+0x58/0x6b
> [  159.570525]  ? _dev_printk+0x56/0x72
> [  159.570534]  ? qmi_decode+0x119/0x470 [qmi_helpers]
> [  159.570543]  __free_pages+0x91/0xd0
> [  159.570548]  dma_free_contiguous+0x50/0x60
> [  159.570556]  dma_direct_free+0xe5/0x140
> [  159.570564]  dma_free_attrs+0x35/0x50
> [  159.570570]  ath11k_qmi_msg_mem_request_cb+0x2ae/0x3c0 [ath11k]
> [  159.570620]  qmi_invoke_handler+0xac/0xe0 [qmi_helpers]
> [  159.570630]  qmi_handle_message+0x6d/0x180 [qmi_helpers]
> [  159.570643]  qmi_data_ready_work+0x2ca/0x440 [qmi_helpers]
> [  159.570656]  process_one_work+0x227/0x440
> [  159.570667]  worker_thread+0x31/0x3d0
> [  159.570676]  ? process_one_work+0x440/0x440
> [  159.570685]  kthread+0xfe/0x130
> [  159.570692]  ? kthread_complete_and_exit+0x20/0x20
> [  159.570701]  ret_from_fork+0x22/0x30
> [  159.570712]  </TASK>
> 
> The reason is because when wlan start to recovery, the type, size and
> count is not same for the 1st and 2nd QMI_WLFW_REQUEST_MEM_IND message,
> Then it leads the parameter size is not correct for the dma_free_coherent().
> For the chunk[1], the actual dma size is 524288 which allocate in the
> 2nd time of the initial wlan load phase, and the size which pass to
> dma_free_coherent() is 3784704 which is got in the 1st time of recovery
> phase, then warning above happened.
> 
> Change to use prev_size of struct target_mem_chunk for the paramter of
> dma_free_coherent() since prev_size is the real size of last load/recovery.
> Also change to check both type and size of struct target_mem_chunk to
> reuse the memory to avoid mismatch buffer size for target. Then the
> warning disappear and recovery success. When the 1st QMI_WLFW_REQUEST_MEM_IND
> for recovery arrived, the trunk[0] is freed in ath11k_qmi_alloc_target_mem_chunk()
> and then dma_alloc_coherent() failed caused by large size, and then
> trunk[1] is freed in ath11k_qmi_free_target_mem_chunk(), the left 18
> trunks will be reuse for the 2nd QMI_WLFW_REQUEST_MEM_IND message.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f74878433d5a wifi: ath11k: fix warning in dma_free_coherent() of memory chunks while recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220928073832.16251-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

