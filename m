Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEE4728C6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbhLMKOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 05:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbhLMKCo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 05:02:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D6C07E5C1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 01:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E1E1B80E16
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F83C00446;
        Mon, 13 Dec 2021 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639388972;
        bh=ZAuXXhRRivDY+SR5zroPQoE2OpCCJQZznPmGkYEuTWw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B2WMD4fdcClodMh8rSnVgEsVFhKlQcdAhfaSy+Lp4C/+oUWLudwT54Pr17lTkc7Ot
         DhTzlIXWDpHRjUvC8qYqzrtkgCHhLvZcrmoYIixgMVCmyZprVPMXfC5o9NGe/ZywAs
         XpwC6at2YEhbCZgUymXxXeYd6P6xozPP9lQ2NJbvkWRyhoRGQTO/3Lp7APpdsjA93L
         WPOvaOBa08i/TjtKpePnhP8D/nLsS1iogyH1jjO/zOcPzg4dy+37C6lqLP38SzFh1h
         XELorOQpkH7LosMLOGuccHFwbFsxtNa6ZCUTSKzTag536GlRz0ZqJQgjZh2xQDNKMd
         Q4PznPCyEMl5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Avoid false DEADLOCK warning reported by lockdep
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211209011949.151472-1-quic_bqiang@quicinc.com>
References: <20211209011949.151472-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163938896986.20609.1805294276865570934.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 09:49:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> With CONFIG_LOCKDEP=y and CONFIG_DEBUG_SPINLOCK=y, lockdep reports
> below warning:
> 
> [  166.059415] ============================================
> [  166.059416] WARNING: possible recursive locking detected
> [  166.059418] 5.15.0-wt-ath+ #10 Tainted: G        W  O
> [  166.059420] --------------------------------------------
> [  166.059421] kworker/0:2/116 is trying to acquire lock:
> [  166.059423] ffff9905f2083160 (&srng->lock){+.-.}-{2:2}, at: ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
> [  166.059440]
>                but task is already holding lock:
> [  166.059442] ffff9905f2083230 (&srng->lock){+.-.}-{2:2}, at: ath11k_dp_process_reo_status+0x95/0x2d0 [ath11k]
> [  166.059491]
>                other info that might help us debug this:
> [  166.059492]  Possible unsafe locking scenario:
> 
> [  166.059493]        CPU0
> [  166.059494]        ----
> [  166.059495]   lock(&srng->lock);
> [  166.059498]   lock(&srng->lock);
> [  166.059500]
>                 *** DEADLOCK ***
> 
> [  166.059501]  May be due to missing lock nesting notation
> 
> [  166.059502] 3 locks held by kworker/0:2/116:
> [  166.059504]  #0: ffff9905c0081548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1f6/0x660
> [  166.059511]  #1: ffff9d2400a5fe68 ((debug_obj_work).work){+.+.}-{0:0}, at: process_one_work+0x1f6/0x660
> [  166.059517]  #2: ffff9905f2083230 (&srng->lock){+.-.}-{2:2}, at: ath11k_dp_process_reo_status+0x95/0x2d0 [ath11k]
> [  166.059532]
>                stack backtrace:
> [  166.059534] CPU: 0 PID: 116 Comm: kworker/0:2 Kdump: loaded Tainted: G        W  O      5.15.0-wt-ath+ #10
> [  166.059537] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0059.2019.1112.1124 11/12/2019
> [  166.059539] Workqueue: events free_obj_work
> [  166.059543] Call Trace:
> [  166.059545]  <IRQ>
> [  166.059547]  dump_stack_lvl+0x56/0x7b
> [  166.059552]  __lock_acquire+0xb9a/0x1a50
> [  166.059556]  lock_acquire+0x1e2/0x330
> [  166.059560]  ? ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
> [  166.059571]  _raw_spin_lock_bh+0x33/0x70
> [  166.059574]  ? ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
> [  166.059584]  ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
> [  166.059594]  ath11k_dp_tx_send_reo_cmd+0x3f/0x130 [ath11k]
> [  166.059605]  ath11k_dp_rx_tid_del_func+0x221/0x370 [ath11k]
> [  166.059618]  ath11k_dp_process_reo_status+0x22f/0x2d0 [ath11k]
> [  166.059632]  ? ath11k_dp_service_srng+0x2ea/0x2f0 [ath11k]
> [  166.059643]  ath11k_dp_service_srng+0x2ea/0x2f0 [ath11k]
> [  166.059655]  ath11k_pci_ext_grp_napi_poll+0x1c/0x70 [ath11k_pci]
> [  166.059659]  __napi_poll+0x28/0x230
> [  166.059664]  net_rx_action+0x285/0x310
> [  166.059668]  __do_softirq+0xe6/0x4d2
> [  166.059672]  irq_exit_rcu+0xd2/0xf0
> [  166.059675]  common_interrupt+0xa5/0xc0
> [  166.059678]  </IRQ>
> [  166.059679]  <TASK>
> [  166.059680]  asm_common_interrupt+0x1e/0x40
> [  166.059683] RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70
> [  166.059686] Code: 83 c7 18 e8 2a 95 43 ff 48 89 ef e8 22 d2 43 ff 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 63 2e 40 ff 65 8b 05 8c 59 97 5c 85 c0 74 0a 5b 5d c3 e8 00 6a
> [  166.059689] RSP: 0018:ffff9d2400a5fca0 EFLAGS: 00000206
> [  166.059692] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 0000000000000006
> [  166.059694] RDX: 0000000000000000 RSI: ffffffffa404879b RDI: 0000000000000001
> [  166.059696] RBP: ffff9905c0053000 R08: 0000000000000001 R09: 0000000000000001
> [  166.059698] R10: ffff9d2400a5fc50 R11: 0000000000000001 R12: ffffe186c41e2840
> [  166.059700] R13: 0000000000000001 R14: ffff9905c78a1c68 R15: 0000000000000001
> [  166.059704]  free_debug_processing+0x257/0x3d0
> [  166.059708]  ? free_obj_work+0x1f5/0x250
> [  166.059712]  __slab_free+0x374/0x5a0
> [  166.059718]  ? kmem_cache_free+0x2e1/0x370
> [  166.059721]  ? free_obj_work+0x1f5/0x250
> [  166.059724]  kmem_cache_free+0x2e1/0x370
> [  166.059727]  free_obj_work+0x1f5/0x250
> [  166.059731]  process_one_work+0x28b/0x660
> [  166.059735]  ? process_one_work+0x660/0x660
> [  166.059738]  worker_thread+0x37/0x390
> [  166.059741]  ? process_one_work+0x660/0x660
> [  166.059743]  kthread+0x176/0x1a0
> [  166.059746]  ? set_kthread_struct+0x40/0x40
> [  166.059749]  ret_from_fork+0x22/0x30
> [  166.059754]  </TASK>
> 
> Since these two lockes are both initialized in ath11k_hal_srng_setup,
> they are assigned with the same key. As a result lockdep suspects that
> the task is trying to acquire the same lock (due to same key) while
> already holding it, and thus reports the DEADLOCK warning. However as
> they are different spinlock instances, the warning is false positive.
> 
> On the other hand, even no dead lock indeed, this is a major issue for
> upstream regression testing as it disables lockdep functionality.
> 
> Fix it by assigning separate lock class key for each srng->lock.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

767c94caf0ef ath11k: Avoid false DEADLOCK warning reported by lockdep

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211209011949.151472-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

