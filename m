Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D367969F23B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjBVJwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 04:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBVJw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 04:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E0392A6
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 01:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01AE612CA
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 09:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71167C433EF;
        Wed, 22 Feb 2023 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677059399;
        bh=Zy/AB927e7zLKu8tj4qqSZ2Xc8kOQYgoE8Tdr5LY5KY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HBa6Rt3WEcuoSAyKUw4BrluCsWSbStnifO6Ce3RPYV1bWohYp3ToV6Ej/tHYJJ9EN
         tyRobhrHBBedoSag7pS0MOxjGVLT1NgAAwxKflm5MxxBJBNrIZo/Md9jJNijb1R24G
         RZLIA2+BvkHyqUCDpj2uiIKj5gZd6juycblroldtsYLKmeN+ovTWzisZe00OQgituj
         1daEOy6DCaQlOeBe3bdgtjAOB8Sd+EL3iUqzv51NYXQ0EhwRRge7IwCz5/mdRw6ssD
         B6Z93XjVEhBB+FunhiM/rkFKZo9M5bk3GVDE6Bq1c41niWxjHjcjXKaz+m2Ce3X/Yn
         +5D8fX9/i+aLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Handle lock during peer_id find
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230122014936.3594-1-quic_rgnanase@quicinc.com>
References: <20230122014936.3594-1-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167705939219.25767.17573630915379659088.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 09:49:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> ath12k_peer_find_by_id() requires that the caller hold the
> ab->base_lock. Currently the WBM error path does not hold
> the lock and calling that function, leads to the
> following lockdep_assert()in QCN9274:
> 
> [105162.160893] ------------[ cut here ]------------
> [105162.160916] WARNING: CPU: 3 PID: 0 at drivers/net/wireless/ath/ath12k/peer.c:71 ath12k_peer_find_by_id+0x52/0x60 [ath12k]
> [105162.160933] Modules linked in: ath12k(O) qrtr_mhi qrtr mac80211 cfg80211 mhi qmi_helpers libarc4 nvme nvme_core [last unloaded: ath12k(O)]
> [105162.160967] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W  O       6.1.0-rc2+ #3
> [105162.160972] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0056.2019.0506.1527 05/06/2019
> [105162.160977] RIP: 0010:ath12k_peer_find_by_id+0x52/0x60 [ath12k]
> [105162.160990] Code: 07 eb 0f 39 68 24 74 0a 48 8b 00 48 39 f8 75 f3 31 c0 5b 5d c3 48 8d bf b0 f2 00 00 be ff ff ff ff e8 22 20 c4 e2 85 c0 75 bf <0f> 0b eb bb 66 2e 0f 1f 84 00 00 00 00 00 41 54 4c 8d a7 98 f2 00
> [105162.160996] RSP: 0018:ffffa223001acc60 EFLAGS: 00010246
> [105162.161003] RAX: 0000000000000000 RBX: ffff9f0573940000 RCX: 0000000000000000
> [105162.161008] RDX: 0000000000000001 RSI: ffffffffa3951c8e RDI: ffffffffa39a96d7
> [105162.161013] RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000000
> [105162.161017] R10: ffffa223001acb40 R11: ffffffffa3d57c60 R12: ffff9f057394f2e0
> [105162.161022] R13: ffff9f0573940000 R14: ffff9f04ecd659c0 R15: ffff9f04d5a9b040
> [105162.161026] FS:  0000000000000000(0000) GS:ffff9f0575600000(0000) knlGS:0000000000000000
> [105162.161031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [105162.161036] CR2: 00001d5c8277a008 CR3: 00000001e6224006 CR4: 00000000003706e0
> [105162.161041] Call Trace:
> [105162.161046]  <IRQ>
> [105162.161051]  ath12k_dp_rx_process_wbm_err+0x6da/0xaf0 [ath12k]
> [105162.161072]  ? ath12k_dp_rx_process_err+0x80e/0x15a0 [ath12k]
> [105162.161084]  ? __lock_acquire+0x4ca/0x1a60
> [105162.161104]  ath12k_dp_service_srng+0x263/0x310 [ath12k]
> [105162.161120]  ath12k_pci_ext_grp_napi_poll+0x1c/0x70 [ath12k]
> [105162.161133]  __napi_poll+0x22/0x260
> [105162.161141]  net_rx_action+0x2f8/0x380
> [105162.161153]  __do_softirq+0xd0/0x4c9
> [105162.161162]  irq_exit_rcu+0x88/0xe0
> [105162.161169]  common_interrupt+0xa5/0xc0
> [105162.161174]  </IRQ>
> [105162.161179]  <TASK>
> [105162.161184]  asm_common_interrupt+0x22/0x40
> 
> Handle spin lock/unlock in WBM error path to hold the necessary lock
> expected by ath12k_peer_find_by_id().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

95a389e2ff32 wifi: ath12k: Handle lock during peer_id find

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230122014936.3594-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

