Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F369F23C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjBVJxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 04:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjBVJwk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 04:52:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C73A86D
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 01:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415E6B8114B
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 09:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE0C433EF;
        Wed, 22 Feb 2023 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677059463;
        bh=J4Rdt/UTPBYVv3Psrg0L5jzWK/A8zDA7m7xO+uuzOKQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ULvBjhZn4DPulCdA77rdKBi2bG1I786puKiAQ0INmKJl/qMOx7BgNpielSrtlYCFB
         I/H+smNZOs8tNxELiFD0DvnN96fkOnX0uB/jlmoxPLKq+IbPKe7TLYZjw9nYOGcpsQ
         WRQT+m72GK5KyiOUXIvouC40T3udc+DSpclILSbPCrngWFt3D8bXiGjIIE5qOIru5m
         NRYL8yYpXdJpqjZ2bwi0hsvlTzSn3a+H2z6MciPwnVbgEnPn/2KauF6AyJ2xc40huc
         6xtQ3CmL+PUoLau3Sxg4Y2q6qct7wZOSkbIUlwdEQdIan82nMUpkH6MhA1Lz9fitrd
         7bTB7ER2DoVJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: PCI ops for wakeup/release MHI
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230123095141.5310-1-quic_rgnanase@quicinc.com>
References: <20230123095141.5310-1-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167705946127.25767.8864744237899074037.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 09:51:02 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

80e396586d0a wifi: ath12k: PCI ops for wakeup/release MHI

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230123095141.5310-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

