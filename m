Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2B616A80
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKBRWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiKBRWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 13:22:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619A25E99
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 10:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 058A4B8240B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 17:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E57C433C1;
        Wed,  2 Nov 2022 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409734;
        bh=IL/3iQLa6R8xJ383aPHlvPg6a1VpYruKDC3i+uDeEUA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PvjaCCZ9ByL/2YsZz6wsiYICoRVBLj/zaoUbT7O2MDrjbzr7EDoDbG/HWqJNrzTWP
         Ku0kDCNiXANx8DF1e/iISzj8YRxMIheCdFwp7GnjYVP6kVy3EVzan33RBM85GVYakI
         nT+6et5FtFDva0FShojOtX2789gJTHR+vdz3xmGBviTtlxkBULwzC+Ec0aeRz0iC9H
         YcpHsafFeXFS4wWx6AF8LdwC/BmsJwf/weohyFDobvLiR4No/J8FopIm/u5CWmsP8S
         NgYfS1QKrynLHxldS27gjZdwN0reMJRaf6YkNEzcBIJsrWCayDfNtfy4tdQJiR52BE
         r2KsdAZO51ilQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6.1] wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()
References: <20221102114803.13485-1-kvalo@kernel.org>
Date:   Wed, 02 Nov 2022 19:22:09 +0200
In-Reply-To: <20221102114803.13485-1-kvalo@kernel.org> (Kalle Valo's message
        of "Wed, 2 Nov 2022 13:48:03 +0200")
Message-ID: <87leotff0e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Wen Gong <quic_wgong@quicinc.com>
>
> (cherry picked from commit d99884ad9e3673a12879bc2830f6e5a66cccbd78 in ath-next
> as users are seeing this bug more now, also cc stable)
>
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
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> [kvalo: improve commit log]
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Manually applied to ath-current branch of ath.git.

f45cb6b29cd3 wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
