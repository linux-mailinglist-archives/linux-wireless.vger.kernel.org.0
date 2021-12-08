Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5378F46D429
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 14:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhLHNQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 08:16:50 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:46555 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhLHNQu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 08:16:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638969198; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sTx0MtBJ4inRlPHwvpvExn9xfCtfs8hitgBHLNByoOs=;
 b=TdYL3m72n+Hjr5dR+K843HAoNBTKnQm1ZpB8c7jiLUcS9zLOtUc71ksvqrpnd2+v5DYxrLm+
 +ftQf+akt5oNsuw3hwmNKyDB/nx+zPASAYouLjZAt/olk63IlwUQ7kleLfWgxClBH1SDbwxx
 8aMEJUyEm9iA/REP1r+RVLnu08Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61b0af6eecc4b367f7e945e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Dec 2021 13:13:18
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9C59C4360D; Wed,  8 Dec 2021 13:13:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E8BC4338F;
        Wed,  8 Dec 2021 13:13:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Dec 2021 18:43:16 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] ath11k: process full monitor mode rx support
In-Reply-To: <163670356167.27466.16885352465690914644.kvalo@codeaurora.org>
References: <20210721171905.61838-4-jouni@codeaurora.org>
 <163670356167.27466.16885352465690914644.kvalo@codeaurora.org>
Message-ID: <d5783c3c4bc4c4fb25113ba7df9fd7b6@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-12 13:22, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> wrote:
> 
>> From: Anilkumar Kolli <akolli@codeaurora.org>
>> 
>> In full monitor mode, monitor destination ring is read before monitor
>> status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. Add
>> all the MPDUs to list. Start processing the status ring, if PPDU id in
>> status ring is lagging behind, reap the status ring, once the PPDU ID
>> matches, deliver the MSDU to upper layer. If status PPDU id leading,
>> reap the mon_dst_ring. The advantage with full monitor mode is 
>> hardware
>> has status buffers available for all the MPDUs in mon_dst_ring.
>> 
>> Tested-on: QCN9074 hw1.0 PCI 
>> WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> 
> I changed the commit log to this to better describe how this patch 
> helps:
> 
>     ath11k: process full monitor mode rx support
> 
>     In full monitor mode, monitor destination ring is read before 
> monitor
>     status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. 
> Add
>     all the MPDUs to list. Start processing the status ring, if PPDU id 
> in
>     status ring is lagging behind, reap the status ring, once the PPDU 
> ID
>     matches, deliver the MSDU to upper layer. If status PPDU id 
> leading,
>     reap the mon_dst_ring.
> 
>     The advantage with full monitor mode is hardware has status
> buffers available
>     for all the MPDUs in mon_dst_ring, which makes it possible to 
> deliver more
>     frames to be seen on sniffer.
> 
>     Tested-on: QCN9074 hw1.0 PCI 
> WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
> 
> But now I see a new warning with QCA6390 caused by patch 3. Please fix
> that and submit v2.
> 
> [  108.354361] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb
> board_id 0xff soc_id 0xffffffff
> [  108.354547] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc
> fw_build_timestamp 2020-06-24 19:50 fw_build_id
> [  110.995359] INFO: trying to register non-static key.
> [  110.995429] The code is fine but needs lockdep annotation, or maybe
> [  110.995489] you didn't initialize this object before use?
> [  110.995546] turning off the locking correctness validator.
> [  110.995604] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G
>       W         5.15.0-wt-ath+ #522
> [  110.995664] Hardware name: Intel(R) Client Systems
> NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [  110.995720] Call Trace:
> [  110.995774]  <IRQ>
> [  110.995828]  dump_stack_lvl+0x57/0x7d
> [  110.995887]  register_lock_class+0x1604/0x17e0
> [  110.995945]  ? check_prev_add+0x7bb/0x20f0
> [  110.996002]  ? is_dynamic_key+0x1a0/0x1a0
> [  110.996058]  ? validate_chain+0xac3/0x1b30
> [  110.996127]  __lock_acquire+0x96/0x1870
> [  110.996196]  ? check_prev_add+0x20f0/0x20f0
> [  110.996266]  ? sched_clock_cpu+0x15/0x1b0
> [  110.996339]  ? mark_lock+0xd0/0x14a0
> [  110.996401]  lock_acquire.part.0+0x117/0x340
> [  110.996470]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 
> [ath11k]
> [  110.996553]  ? rcu_read_unlock+0x40/0x40
> [  110.996622]  ? rcu_read_lock_sched_held+0x3a/0x70
> [  110.996685]  ? lock_acquire+0x1a8/0x210
> [  110.996751]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 
> [ath11k]
> [  110.996831]  _raw_spin_lock_bh+0x34/0x80
> [  110.996892]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 
> [ath11k]
> [  110.996971]  ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 
> [ath11k]
> [  110.997071]  ? ath11k_dp_rxbufs_replenish+0x7a0/0x7a0 [ath11k]
> [  110.997187]  ? mark_held_locks+0xa5/0xe0
> [  110.997272]  ? ath11k_hal_rx_parse_mon_status_tlv+0x6d7/0x1880 
> [ath11k]
> [  110.997389]  ? ath11k_hal_rx_parse_mon_status+0xed/0x170 [ath11k]
> [  110.997506]  ath11k_dp_rx_process_mon_rings+0x3f9/0x580 [ath11k]
> [  110.997600]  ? ath11k_dp_rx_pdev_alloc+0xd50/0xd50 [ath11k]
> [  110.997680]  ath11k_dp_service_mon_ring+0x67/0xe0 [ath11k]
> [  110.997759]  ? ath11k_dp_rx_process_mon_rings+0x580/0x580 [ath11k]
> [  110.997835]  call_timer_fn+0x167/0x4a0
> [  110.997903]  ? add_timer_on+0x3b0/0x3b0
> [  110.997967]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
> [  110.998031]  __run_timers.part.0+0x539/0x8b0
> [  110.998123]  ? ath11k_dp_rx_process_mon_rings+0x580/0x580 [ath11k]
> [  110.998228]  ? call_timer_fn+0x4a0/0x4a0
> [  110.998314]  ? clockevents_program_event+0xdd/0x280
> [  110.998408]  ? recalibrate_cpu_khz+0x10/0x10
> [  110.998496]  ? ktime_get+0x119/0x2f0
> [  110.998579]  ? hrtimer_interrupt+0x32f/0x770
> [  110.998679]  run_timer_softirq+0x97/0x180
> [  110.998764]  __do_softirq+0x276/0x86a
> [  110.998850]  __irq_exit_rcu+0x11c/0x180
> [  110.998934]  irq_exit_rcu+0x5/0x20
> [  110.999017]  sysvec_apic_timer_interrupt+0x8e/0xc0
> [  110.999100]  </IRQ>
> [  110.999181]  <TASK>
> [  110.999261]  asm_sysvec_apic_timer_interrupt+0x12/0x20

I have posted v2 patch. With v2, I did not see the issue with QCA6390 
during the bootup.

Thanks
Anil
