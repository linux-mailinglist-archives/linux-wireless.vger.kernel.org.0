Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3C5F9C12
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiJJJi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJJJit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:38:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002B69F55
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC34BCE10D1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7CBC433D7;
        Mon, 10 Oct 2022 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665394721;
        bh=8KZLPndei0SJtrdqxp0cnPnc7Efw0GxPCNx9YT/+z1o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q+TJu8yc33XhXodU074NkxAceGcsZmT0AnyKSimMaAV7gsE6RMUI9zr5v7V+R5t9W
         HVKGmcfCjHp26/kG1vSJO0jX2Mxx5fs+yboB8dGXdBHawHfwSMHziU0c+JLPqthZqC
         NuU9UQLKZw5Hz1WQie27SRTM2BRL5ZxNMXiTvYIJcoI9w8ykDXZkcHzkEfFATgvW3a
         EQMgSxtG9qXsudeKWRccnxBK9e+4RSV89Djk4OuEedAWURHkOrBVfvv2O24NMVl3sl
         I73Q8MSEG04tXIX95NNKBv5daSdekfOk2SgUGrrg/y1g81IUrU6BB0FpGAt1ACrTZl
         OtqYUORswol3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: avoid deadlock during regulatory update in
 ath11k_regd_update()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221006151747.13757-1-kvalo@kernel.org>
References: <20221006151747.13757-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166539471639.12656.4045155375066520132.kvalo@kernel.org>
Date:   Mon, 10 Oct 2022 09:38:40 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Running this test in a loop it is easy to reproduce an rtnl deadlock:
> 
> iw reg set FI
> ifconfig wlan0 down
> 
> What happens is that thread A (workqueue) tries to update the regulatory:
> 
>     try to acquire the rtnl_lock of ar->regd_update_work
> 
>     rtnl_lock+0x17/0x20
>     ath11k_regd_update+0x15a/0x260 [ath11k]
>     ath11k_regd_update_work+0x15/0x20 [ath11k]
>     process_one_work+0x228/0x670
>     worker_thread+0x4d/0x440
>     kthread+0x16d/0x1b0
>     ret_from_fork+0x22/0x30
> 
> And thread B (ifconfig) tries to stop the interface:
> 
>     try to cancel_work_sync(&ar->regd_update_work) in ath11k_mac_op_stop().
>     ifconfig  3109 [003]  2414.232506: probe:
> 
>     ath11k_mac_op_stop: (ffffffffc14187a0)
>     drv_stop+0x30 ([mac80211])
>     ieee80211_do_stop+0x5d2 ([mac80211])
>     ieee80211_stop+0x3e ([mac80211])
>     __dev_close_many+0x9e ([kernel.kallsyms])
>     __dev_change_flags+0xbe ([kernel.kallsyms])
>     dev_change_flags+0x23 ([kernel.kallsyms])
>     devinet_ioctl+0x5e3 ([kernel.kallsyms])
>     inet_ioctl+0x197 ([kernel.kallsyms])
>     sock_do_ioctl+0x4d ([kernel.kallsyms])
>     sock_ioctl+0x264 ([kernel.kallsyms])
>     __x64_sys_ioctl+0x92 ([kernel.kallsyms])
>     do_syscall_64+0x3a ([kernel.kallsyms])
>     entry_SYSCALL_64_after_hwframe+0x63 ([kernel.kallsyms])
>     __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.23.so)
> 
> The sequence of deadlock is:
> 
> 1. Thread B calls rtnl_lock().
> 
> 2. Thread A starts to run and calls rtnl_lock() from within
>    ath11k_regd_update_work(), then enters wait state because the lock is owned by
>    thread B.
> 
> 3. Thread B continues to run and tries to call
>    cancel_work_sync(&ar->regd_update_work), but thread A is in
>    ath11k_regd_update_work() waiting for rtnl_lock(). So cancel_work_sync()
>    forever waits for ath11k_regd_update_work() to finish and we have a deadlock.
> 
> Fix this by switching from using regulatory_set_wiphy_regd_sync() to
> regulatory_set_wiphy_regd(). Now cfg80211 will schedule another workqueue which
> handles the locking on it's own. So the ath11k workqueue can simply exit without
> taking any locks, avoiding the deadlock.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> [kvalo: improve commit log]
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d99884ad9e36 wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221006151747.13757-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

