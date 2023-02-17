Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4B69B2D5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 20:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBQTGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 14:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBQTGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 14:06:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FDD62429
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 11:06:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 895E4B80CBF
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 19:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594E5C433D2;
        Fri, 17 Feb 2023 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676660776;
        bh=N//uIUiDnT2ZKZcMejglEYVKwu8V4Gq/YlUBRqjwNgc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=toZCwyY5b+k6nuuMmJO8Xafv9jv+8T9tKjNSmQw2zuX846gMm5oJ+gMYNKwTVr3Tf
         4exKArUTaCx54YRzbAPlMUYII8k+2WBake+dLTpDRmnZa1X/jyTvBuli38dn00O7qv
         2X4aemcH4dd0X0mMROo5LlsitBjKjx/d9KgX2VeLf1xBt2H0188WO9cthhIqaykdTP
         YpfyCKIKputtGrKr9VXcTdnwHiPFWv7VskHQPi2w3qbhV7Gyfrg33q1pu8pzfFthdl
         mC2PXOqA4atnVT6E6vP0j7Xkbe9t0g1Bwx4GJQdqTpt1YUZGh/dwBgFSg1ew+yFWwK
         QWNbMuXcYlcfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: PCI ops for wakeup/release MHI
References: <20230123095141.5310-1-quic_rgnanase@quicinc.com>
Date:   Fri, 17 Feb 2023 21:06:11 +0200
In-Reply-To: <20230123095141.5310-1-quic_rgnanase@quicinc.com> (Ramya
        Gnanasekar's message of "Mon, 23 Jan 2023 15:21:41 +0530")
Message-ID: <87edqot8m4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> Wakeup/release MHI is not needed before pci_read/write for QCN9274.
> Since wakeup & release MHI is enabled for all QCN9274 and
> WCN7850, below MHI assert is seen in QCN9274
>
> [  784.906613] BUG: sleeping function called from invalid context at drivers/bus/mhi/host/pm.c:989
> [  784.906633] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/3
> [  784.906637] preempt_count: 503, expected: 0
> [  784.906641] RCU nest depth: 0, expected: 0
> [  784.906644] 2 locks held by swapper/3/0:
> [  784.906646]  #0: ffff8ed348e429e0 (&ab->ce.ce_lock){+.-.}-{2:2}, at: ath12k_ce_recv_process_cb+0xb3/0x2f0 [ath12k]
> [  784.906664]  #1: ffff8ed348e491f0 (&srng->lock_key#3){+.-.}-{2:2}, at: ath12k_ce_recv_process_cb+0xfb/0x2f0 [ath12k]
> [  784.906678] Preemption disabled at:
> [  784.906680] [<0000000000000000>] 0x0
> [  784.906686] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W  O       6.1.0-rc2+ #3
> [  784.906688] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0056.2019.0506.1527 05/06/2019
> [  784.906690] Call Trace:
> [  784.906691]  <IRQ>
> [  784.906693]  dump_stack_lvl+0x56/0x7b
> [  784.906698]  __might_resched+0x21c/0x270
> [  784.906704]  __mhi_device_get_sync+0x7d/0x1c0 [mhi]
> [  784.906714]  mhi_device_get_sync+0xd/0x20 [mhi]
> [  784.906719]  ath12k_pci_write32+0x75/0x170 [ath12k]
> [  784.906729]  ath12k_hal_srng_access_end+0x55/0xc0 [ath12k]
> [  784.906737]  ath12k_ce_recv_process_cb+0x1f3/0x2f0 [ath12k]
> [  784.906776]  ? ath12k_pci_ce_tasklet+0x11/0x30 [ath12k]
> [  784.906788]  ath12k_pci_ce_tasklet+0x11/0x30 [ath12k]
> [  784.906813]  tasklet_action_common.isra.18+0xb7/0xe0
> [  784.906820]  __do_softirq+0xd0/0x4c9
> [  784.906826]  irq_exit_rcu+0x88/0xe0
> [  784.906828]  common_interrupt+0xa5/0xc0
> [  784.906831]  </IRQ>
> [  784.906832]  <TASK>
>
> Adding function callbacks for MHI wakeup and release operations.
> QCN9274 does not need wakeup/release, function callbacks are initialized
> to NULL. In case of WCN7850, shadow registers are used to access rings.
> Since, shadow register's offset is less than ACCESS_ALWAYS_OFF,
> mhi_device_get_sync() or mhi_device_put() to wakeup
> and release mhi will not be called during service ring accesses.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c

How do you submit your patches? Your patches are missing the "---" line
and the diffstat, which breaks my patchwork script. I recommend using
the git send-email tool to submit patches so that the standard format is
used.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
