Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561D17B5724
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjJBPvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 11:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjJBPvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 11:51:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E8ABD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 08:51:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5772C433C7;
        Mon,  2 Oct 2023 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261894;
        bh=+B2SrbBWimw4oqZWFj446YyLdZVqab4fu390vSjipXE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cmF4nW6KN3sxUzXq7xYa30rVRyLbSOnGwAq72bTNiDYBrZVs7qpy4oY0ME769Ioiy
         yChmcl4c1azo/n5lIuafEqv7dzXm96y4WAi8EWFDRUQZ1qL8K7eSsz1b3F8w9hpm/t
         KwViVDPmfHejgFha0OKEjE2z1JPVMryqiCj+0GrTTH+3y1m85d/M/SGbj7hDLZwYrz
         7h3XLdAla0qUF7ZlegtDk66QlCSM7aesgHlC2XwuPJdryiMSk/81IzZoiobE1LUUHs
         DL/XqntkA+LWu5RZE7C0y2Vq76bfGpokcrFJPohdBH+FLRHz7msMDOdHw931xYga3R
         pXuKm2S34kQvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/13] wifi: ath11k: fix a possible dead lock caused by
 ab->base_lock
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230920082349.29111-4-quic_wgong@quicinc.com>
References: <20230920082349.29111-4-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626189059.3911795.14308656119733371331.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 15:51:32 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> spin_lock/spin_unlock are used in ath11k_reg_chan_list_event to
> acquire/release ab->base_lock, for now this is safe because that
> function is only called in soft IRQ context.
> 
> But ath11k_reg_chan_list_event() will be called from process
> context in an upcoming patch, and this can result in a deadlock if
> ab->base_lock is acquired in process context and then soft IRQ occurs
> on the same CPU and tries to acquire that lock.
> 
> Fix it by using spin_lock_bh and spin_unlock_bh instead.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 69a0fcf8a9f2 ("ath11k: Avoid reg rules update during firmware recovery")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch seems to leak memory:

unreferenced object 0xffff8881110f5840 (size 64):
  comm "softirq", pid 0, jiffies 4295335213 (age 79.445s)
  hex dump (first 32 bytes):
    32 14 82 14 50 00 17 00 00 02 00 00 82 14 d2 14  2...P...........
    50 00 17 00 08 02 00 00 72 15 62 16 a0 00 1e 00  P.......r.b.....
  backtrace:
    [<ffffffffa1f891ca>] __kmem_cache_alloc_node+0x1ca/0x2d0
    [<ffffffffa1e57950>] __kmalloc+0x50/0x1a0
    [<ffffffffc076640e>] create_ext_reg_rules_from_wmi+0x2e/0x430 [ath11k]
    [<ffffffffc07705c4>] ath11k_pull_reg_chan_list_ext_update_ev+0x1d24/0x4f30 [ath11k]
    [<ffffffffc07a4a44>] ath11k_reg_chan_list_event.isra.0+0x64/0xd0 [ath11k]
    [<ffffffffc07a562f>] ath11k_wmi_tlv_op_rx+0xb7f/0x27e0 [ath11k]
    [<ffffffffc07f3a54>] ath11k_htc_rx_completion_handler+0x3b4/0x6f0 [ath11k]
    [<ffffffffc0838b3a>] ath11k_ce_recv_process_cb+0x5da/0x920 [ath11k]
    [<ffffffffc0839b68>] ath11k_ce_per_engine_service+0xe8/0x130 [ath11k]
    [<ffffffffc084ba75>] ath11k_pcic_ce_tasklet+0x65/0x120 [ath11k]
    [<ffffffffa196df5c>] tasklet_action_common.isra.0+0x24c/0x3d0
    [<ffffffffa196e12f>] tasklet_action+0x4f/0x70
    [<ffffffffa448b355>] __do_softirq+0x1c5/0x867
unreferenced object 0xffff8881110f5f40 (size 64):
  comm "softirq", pid 0, jiffies 4295335238 (age 79.439s)
  hex dump (first 32 bytes):
    32 14 82 14 50 00 17 00 00 02 00 00 82 14 d2 14  2...P...........
    50 00 17 00 08 02 00 00 72 15 62 16 a0 00 1e 00  P.......r.b.....
  backtrace:
    [<ffffffffa1f891ca>] __kmem_cache_alloc_node+0x1ca/0x2d0
    [<ffffffffa1e57950>] __kmalloc+0x50/0x1a0
    [<ffffffffc076640e>] create_ext_reg_rules_from_wmi+0x2e/0x430 [ath11k]
    [<ffffffffc07705c4>] ath11k_pull_reg_chan_list_ext_update_ev+0x1d24/0x4f30 [ath11k]
    [<ffffffffc07a4a44>] ath11k_reg_chan_list_event.isra.0+0x64/0xd0 [ath11k]
    [<ffffffffc07a562f>] ath11k_wmi_tlv_op_rx+0xb7f/0x27e0 [ath11k]
    [<ffffffffc07f3a54>] ath11k_htc_rx_completion_handler+0x3b4/0x6f0 [ath11k]
    [<ffffffffc0838b3a>] ath11k_ce_recv_process_cb+0x5da/0x920 [ath11k]
    [<ffffffffc0839b68>] ath11k_ce_per_engine_service+0xe8/0x130 [ath11k]
    [<ffffffffc084ba75>] ath11k_pcic_ce_tasklet+0x65/0x120 [ath11k]
    [<ffffffffa196df5c>] tasklet_action_common.isra.0+0x24c/0x3d0
    [<ffffffffa196e12f>] tasklet_action+0x4f/0x70
    [<ffffffffa448b355>] __do_softirq+0x1c5/0x867

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230920082349.29111-4-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

