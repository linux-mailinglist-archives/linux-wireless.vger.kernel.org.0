Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732C75AB1DA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiIBNoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 09:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbiIBNnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 09:43:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13BF5A4
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88E14B82A9D
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 13:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E82FC433C1;
        Fri,  2 Sep 2022 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662124728;
        bh=U+StfWjaJx3Q8pTb5xgTAcDWSj97c67HkNE7F9KvhiM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dpuUrhRfChfa0AzcGf5dgsU9gienDb6agiTs8/SXnbLh7plzJf+a5SzoIywT2/EaR
         Sa5TqC9v3UUX18BT+9P0KYX9Kg2cHZCulXO9WBOIugJqIKFB3+Sw5dixOYBIKFGiwa
         iTsw5/Qn6p8mhHOiNc01P2zCIy1qvo6yAIUF9CAdaDgOpZJmDleUEbG+AE74a0RRdo
         W2bJUCxq/dx1OoQpNMmMkVcC3SRMmQxrivyXifWPEM/AOjDQSp61FxD2WDk8n9N6fp
         6U8IjkvMBGJSvv1davQvvEKY/DMaKoDLUpw8kSQIciRSqujDSjvJjVCb9eUDij0SiL
         RAc7HJ5jZXxqA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] ath11k: Enable low power mode when WLAN is not active
References: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
        <20220825111818.30869-4-quic_mpubbise@quicinc.com>
        <874jxsdeov.fsf@kernel.org>
        <c10d7988-099b-cd10-64aa-41daca1ce12b@quicinc.com>
Date:   Fri, 02 Sep 2022 16:18:43 +0300
In-Reply-To: <c10d7988-099b-cd10-64aa-41daca1ce12b@quicinc.com> (Manikanta
        Pubbisetty's message of "Thu, 1 Sep 2022 13:43:05 +0530")
Message-ID: <874jxpc3t8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 8/31/2022 1:31 PM, Kalle Valo wrote:
>
>> With this patch 3 my regression tests on WCN6855 panic:
>>
>> [  109.009427] rmmod ath11k_pci
>> [  109.437120] kworker/dying (1560) used greatest stack depth: 24704 bytes left
>> [ 109.446051] general protection fault, probably for non-canonical
>> address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
>> KASAN
>> [ 109.446133] KASAN: null-ptr-deref in range
>> [0x00000000000001f0-0x00000000000001f7]
>> [  109.446211] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc2-wt-ath+ #683
>> [ 109.446315] Hardware name: Intel(R) Client Systems
>> NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339
>> 05/28/2021
>> [  109.446393] RIP: 0010:ath11k_dp_process_rxdma_err+0x1c8/0x810 [ath11k]
>> [ 109.446486] Code: d2 48 63 d8 48 8b 4c 24 38 48 8d 04 5b 48 c1 e0
>> 04 48 8d bc 01 f4 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
>> c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2
>> 0f 85 aa
>> [  109.446557] RSP: 0018:ffffc90000007b90 EFLAGS: 00010203
>> [  109.446619] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> [  109.446677] RDX: 000000000000003e RSI: 0000000000000000 RDI: 00000000000001f4
>> [  109.446734] RBP: 0000000000000000 R08: ffff88814c0e1470 R09: ffff88814c0f6678
>> [  109.446792] R10: dffffc0000000000 R11: ffffed102981ecd0 R12: 0000000000000000
>> [  109.446903] R13: 0000000000000040 R14: 1ffff92000000f81 R15: ffff88814c0e0000
>> [ 109.446961] FS: 0000000000000000(0000) GS:ffff888233600000(0000)
>> knlGS:0000000000000000
>> [  109.447020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  109.447080] CR2: 000055570fe84cc8 CR3: 0000000152540006 CR4: 00000000003706f0
>> [  109.447136] Call Trace:
>> [  109.447194]  <IRQ>
>> [  109.447257]  ? ath11k_dp_process_reo_status+0x3ce/0x560 [ath11k]
>> [  109.447349]  ? ath11k_dp_rx_process_wbm_err+0x17d0/0x17d0 [ath11k]
>> [  109.447442]  ath11k_dp_service_srng+0x358/0xab0 [ath11k]
>> [  109.447536]  ath11k_pcic_ext_grp_napi_poll+0x40/0x1d0 [ath11k]
>> [  109.447628]  __napi_poll.constprop.0+0x97/0x350
>> [  109.447690]  net_rx_action+0x7bf/0xbb0
>> [  109.447749]  ? __napi_poll.constprop.0+0x350/0x350
>> [  109.447831]  ? ktime_get+0x101/0x2f0
>> [  109.447911]  __do_softirq+0x1ca/0x897
>> [  109.447989]  __irq_exit_rcu+0xdb/0x180
>> [  109.448049]  irq_exit_rcu+0x5/0x20
>> [  109.448109]  sysvec_apic_timer_interrupt+0x8a/0xb0
>> [  109.448168]  </IRQ>
>> [  109.448226]  <TASK>
>> [  109.448284]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [  109.448343] RIP: 0010:cpuidle_enter_state+0x1ef/0x9a0
>> [ 109.448407] Code: 00 00 8b 73 04 bf ff ff ff ff e8 8c f0 ff ff 31
>> ff e8 75 16 47 fe 80 7c 24 08 00 0f 85 a1 01 00 00 e8 75 7d 6a fe fb
>> 45 85 f6 <0f> 88 6f 02 00 00 4d 63 ee 4b 8d 44 6d 00 49 8d 44 85 00
>> 48 8d 7c
>> [  109.448477] RSP: 0018:ffffffffb9407db8 EFLAGS: 00000202
>> [  109.448540] RAX: 0000000000124987 RBX: ffff888114966400 RCX: 1ffffffff738a3e1
>> [  109.448600] RDX: 0000000000000000 RSI: ffffffffb8a71bc0 RDI: ffffffffb8bec9c0
>> [  109.448659] RBP: ffffffffb986efa0 R08: 0000000000000001 R09: ffffffffb9c54717
>> [  109.448715] R10: fffffbfff738a8e2 R11: 00000000000002ec R12: 000000197b7a6a19
>> [  109.448774] R13: 0000000000000002 R14: 0000000000000002 R15: ffff888114966404
>> [  109.448871]  ? cpuidle_enter_state+0x1eb/0x9a0
>> [  109.448947]  ? finish_task_switch.isra.0+0x120/0x870
>> [  109.449006]  cpuidle_enter+0x45/0xa0
>> [  109.449065]  cpuidle_idle_call+0x274/0x3f0
>> [  109.449125]  ? arch_cpu_idle_exit+0x30/0x30
>> [  109.449187]  ? tsc_verify_tsc_adjust+0x86/0x2d0
>> [  109.449247]  ? lockdep_hardirqs_off+0x90/0xd0
>> [  109.449306]  do_idle+0xe0/0x140
>> [  109.449363]  cpu_startup_entry+0x14/0x20
>> [  109.449423]  rest_init+0x135/0x1e0
>> [  109.449482]  arch_call_rest_init+0xa/0xb
>> [  109.449542]  start_kernel+0x391/0x3af
>> [  109.449606]  secondary_startup_64_no_verify+0xce/0xdb
>> [  109.449671]  </TASK>
>> [ 109.449729] Modules linked in: ath11k_pci(-) ath11k mac80211
>> libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
>> [  109.449846] ---[ end trace 0000000000000000 ]---
>> [  109.449927] RIP: 0010:ath11k_dp_process_rxdma_err+0x1c8/0x810 [ath11k]
>> [ 109.450073] Code: d2 48 63 d8 48 8b 4c 24 38 48 8d 04 5b 48 c1 e0
>> 04 48 8d bc 01 f4 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
>> c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2
>> 0f 85 aa
>> [  109.450147] RSP: 0018:ffffc90000007b90 EFLAGS: 00010203
>> [  109.450212] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> [  109.450275] RDX: 000000000000003e RSI: 0000000000000000 RDI: 00000000000001f4
>> [  109.450337] RBP: 0000000000000000 R08: ffff88814c0e1470 R09: ffff88814c0f6678
>> [  109.450401] R10: dffffc0000000000 R11: ffffed102981ecd0 R12: 0000000000000000
>> [  109.450465] R13: 0000000000000040 R14: 1ffff92000000f81 R15: ffff88814c0e0000
>> [ 109.450531] FS: 0000000000000000(0000) GS:ffff888233600000(0000)
>> knlGS:0000000000000000
>> [  109.450595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  109.450661] CR2: 000055570fe84cc8 CR3: 0000000152540006 CR4: 00000000003706f0
>> [  109.450723] Kernel panic - not syncing: Fatal exception in interrupt
>> [ 109.450794] Kernel Offset: 0x34e00000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [  109.450837] Rebooting in 10 seconds..
>
> Thanks for the report. From the logs, I see the system crashed during
> rmmod ath11k_pci. I have run rmmod & insmod tests several times on
> WCN6855 before sending the revised version. Probably some tests before
> rmmod would have led to this crash. Could you please let me know what
> tests does the regression suite covers? I'll try repro the bug.

This is early in the tests, IIRC there was only insmod followed by
rmmod. Do you have KASAN etc enabled?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
