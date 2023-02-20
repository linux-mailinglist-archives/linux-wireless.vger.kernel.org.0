Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A311269C701
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBTIus (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 03:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjBTIur (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 03:50:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2780EC5B
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 00:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9311660CF7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 08:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D588C4339B;
        Mon, 20 Feb 2023 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676883000;
        bh=lHxpA9XkZ4PEv6H1Lpx/c5H4ZABU76dYoVDkMU8ROtI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eozHnGbQqKI+9KvghHb3Gmljxrd8AAqQ6T0fZ6UgoZ1CAk8B6CtDvPVij3TAkY8UZ
         N3kn6hWsSntEHV3zV4kax/ULXrlDGIXAg8DoyLF+EDmyjUJ+H1eV4hyqL8pKvj8qel
         Uf+0vjYR3X3VB48RcQDlyHu2RB7OV+5drHTxn66fHCRKz7oDNfgz++3gzqrzDiI6ud
         XUH4gFg8LeLv+czeioa7KuQqOXNTkjgmP6c1FMIxZTGCWkSEiPgo6y4/m/XxshxFDc
         EkNmPlJTSWVzAj8+PitvBb9UcWz5kofiEbY56jwzYxqDE7cb5rszGn6xr/iGvCzbl9
         /hnV9pCTOwZ0w==
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
Message-ID: <167688299637.21606.14456364352693722616.kvalo@kernel.org>
Date:   Mon, 20 Feb 2023 08:49:58 +0000 (UTC)
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

This patch added new warnings:

drivers/net/wireless/ath/ath12k/pci.h:90: code indent should use tabs where possible
drivers/net/wireless/ath/ath12k/pci.h:90: please, no spaces at the start of a line
drivers/net/wireless/ath/ath12k/pci.h:91: code indent should use tabs where possible
drivers/net/wireless/ath/ath12k/pci.h:91: please, no spaces at the start of a line

I fixex them in the pending branch, but in the future please use ath12k-check.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230123095141.5310-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

