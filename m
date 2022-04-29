Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B65514A4F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359711AbiD2NQM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 09:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiD2NQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 09:16:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98A54BCF
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 06:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ADB8B83506
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 13:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A92C385A7;
        Fri, 29 Apr 2022 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651237970;
        bh=H+JAou60h3BMSVWtdgj5NM/ohKO0rIVR+v/1zqu+yHk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QxGhvIlf85OXHMba1VNst7zLm9x0sMzz+bLcoZhWatjO5ad4gNMauEtFgsRCH+U4f
         Uc8FSA1fPdOyQHdWzYZiIrwL7Vb0SwgMliEKP0R6qffmDYe1kw7KjUPmSJQNJa1gKw
         iCLVvJzERV5uwGEliTB4BX9niFrs6GBsUwb7A9umhviQemv/WfHPDx/p6RcA+skxoH
         GBJb1GIEVKtU/jvVAjdkEFxODoE5XQZp643V062AyTWTvzOb3/fkM0Wa8SKwwR9Iuh
         de5SwbDKWMn/+Q8glqo8CbweSDQCjHv8ZvysKU7tKC3Z7G+h18c5mOkmj+ZjiKVz6T
         glXu5iloU78Xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Don't use GFP_KERNEL in atomic context
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220427120033.1046759-1-quic_bqiang@quicinc.com>
References: <20220427120033.1046759-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165123796422.19121.14613785166933470383.kvalo@kernel.org>
Date:   Fri, 29 Apr 2022 13:12:49 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing below warning:
> ...
> kernel: [ 5720.362941] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:197
> kernel: [ 5720.362943] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/4
> kernel: [ 5720.362947] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W         5.10.90 #18 4fa489e3e5c16043994f416310c2f60eff666320
> kernel: [ 5720.362949] Hardware name: Google Nipperkin/Nipperkin, BIOS Google_Nipperkin.14316.0.0 10/30/2021
> kernel: [ 5720.362950] Call Trace:
> kernel: [ 5720.362953]  <IRQ>
> kernel: [ 5720.362959]  dump_stack+0x9c/0xe7
> kernel: [ 5720.362964]  ___might_sleep+0x14a/0x160
> kernel: [ 5720.362967]  kmem_cache_alloc+0x46/0x226
> kernel: [ 5720.362970]  ? __alloc_skb+0x6c/0x19e
> kernel: [ 5720.362972]  __alloc_skb+0x6c/0x19e
> kernel: [ 5720.362985]  cfg80211_gtk_rekey_notify+0xa2/0x21d [cfg80211 2c8b5aee0416e7d010d70c332a47990fc843c1c5]
> kernel: [ 5720.362995]  ath11k_wmi_gtk_offload_status_event+0x102/0x155 [ath11k 4c6bb5f7331c81199d56a7e37bdc10030f167838]
> kernel: [ 5720.363002]  ath11k_wmi_tlv_op_rx+0x301/0x51b [ath11k 4c6bb5f7331c81199d56a7e37bdc10030f167838]
> kernel: [ 5720.363009]  ath11k_htc_rx_completion_handler+0xee/0x3f5 [ath11k 4c6bb5f7331c81199d56a7e37bdc10030f167838]
> kernel: [ 5720.363017]  ath11k_ce_per_engine_service+0x2aa/0x32c [ath11k 4c6bb5f7331c81199d56a7e37bdc10030f167838]
> kernel: [ 5720.363024]  ath11k_pci_ce_tasklet+0x1a/0x30 [ath11k_pci 9acc399855ea172aa14a892c0bfdba0ce22d6f07]
> kernel: [ 5720.363028]  tasklet_action_common+0x8d/0x9f
> kernel: [ 5720.363032]  __do_softirq+0x163/0x29a
> kernel: [ 5720.363035]  asm_call_irq_on_stack+0x12/0x20
> kernel: [ 5720.363037]  </IRQ>
> kernel: [ 5720.363041]  do_softirq_own_stack+0x3c/0x48
> kernel: [ 5720.363043]  __irq_exit_rcu+0x9b/0x9d
> kernel: [ 5720.363046]  common_interrupt+0xc9/0x14d
> kernel: [ 5720.363049]  asm_common_interrupt+0x1e/0x40
> kernel: [ 5720.363054] RIP: 0010:cpuidle_enter_state+0x1c5/0x2ac
> kernel: [ 5720.363056] Code: 84 f6 4c 8b 75 c0 74 1e 48 c7 45 c8 00 00 00 00 9c 8f 45 c8 0f ba 65 c8 09 0f 82 d1 00 00 00 31 ff e8 4a bb 6c ff fb 45 85 e4 <78> 47 44 89 e0 48 6b d0 68 49 8b 4c 16 48 48 2b 5d b8 49 89 5d 18
> kernel: [ 5720.363058] RSP: 0018:ffffa7e640157e78 EFLAGS: 00000206
> kernel: [ 5720.363060] RAX: ffff9807ddf29b40 RBX: 00000533e033584c RCX: 00000533e033584c
> kernel: [ 5720.363062] RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000000
> kernel: [ 5720.363063] RBP: ffffa7e640157ec0 R08: 0000000000000002 R09: 00000533e171bb7a
> kernel: [ 5720.363064] R10: 0000000000000900 R11: fffffffffffffffe R12: 0000000000000003
> kernel: [ 5720.363065] R13: ffff9804c2ef6000 R14: ffffffffbe9a7bd0 R15: 0000000000000003
> kernel: [ 5720.363069]  ? cpuidle_enter_state+0x19a/0x2ac
> kernel: [ 5720.363072]  cpuidle_enter+0x2e/0x3d
> kernel: [ 5720.363074]  do_idle+0x163/0x1ee
> kernel: [ 5720.363076]  cpu_startup_entry+0x1d/0x1f
> kernel: [ 5720.363078]  secondary_startup_64_no_verify+0xb1/0xbb
> ...
> 
> This is because GFP_KERNEL is used by ath11k_wmi_gtk_offload_status_event
> while in atomic context. Fix it by using GFP_ATOMIC instead.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

eee645eccfc4 ath11k: Don't use GFP_KERNEL in atomic context

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220427120033.1046759-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

