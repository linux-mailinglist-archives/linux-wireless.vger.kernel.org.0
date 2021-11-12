Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCB44E2A6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 08:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhKLHzs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 02:55:48 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:52945 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhKLHzr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 02:55:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636703577; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Usv1bhvG2ZJ5h/PsIIAjd8vLEElJgpWNXsgDlDvRsY0=;
 b=NorY1VeZWobNOkF8jWzloN7l7X62kO7jtoLCm4ofhVVBbfsIE/BUkv0AbwChYMdu8hFnFjyR
 DPaRcUwVvDkZlt4lACuAuQpZamVpMOLg27rOfgvrlmHH75QVn2R8Qp2D2mcWXvQQvZJRLF3v
 oT5yQciRzmACVbyZWjeGmsPnQPg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 618e1d4fa445961e72863cd7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 07:52:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DBD20C4360C; Fri, 12 Nov 2021 07:52:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A70FFC4338F;
        Fri, 12 Nov 2021 07:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A70FFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] ath11k: process full monitor mode rx support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210721171905.61838-4-jouni@codeaurora.org>
References: <20210721171905.61838-4-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163670356167.27466.16885352465690914644.kvalo@codeaurora.org>
Date:   Fri, 12 Nov 2021 07:52:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> From: Anilkumar Kolli <akolli@codeaurora.org>
> 
> In full monitor mode, monitor destination ring is read before monitor
> status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. Add
> all the MPDUs to list. Start processing the status ring, if PPDU id in
> status ring is lagging behind, reap the status ring, once the PPDU ID
> matches, deliver the MSDU to upper layer. If status PPDU id leading,
> reap the mon_dst_ring. The advantage with full monitor mode is hardware
> has status buffers available for all the MPDUs in mon_dst_ring.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>

I changed the commit log to this to better describe how this patch helps:

    ath11k: process full monitor mode rx support
    
    In full monitor mode, monitor destination ring is read before monitor
    status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. Add
    all the MPDUs to list. Start processing the status ring, if PPDU id in
    status ring is lagging behind, reap the status ring, once the PPDU ID
    matches, deliver the MSDU to upper layer. If status PPDU id leading,
    reap the mon_dst_ring.
    
    The advantage with full monitor mode is hardware has status buffers available
    for all the MPDUs in mon_dst_ring, which makes it possible to deliver more
    frames to be seen on sniffer.
    
    Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

But now I see a new warning with QCA6390 caused by patch 3. Please fix that and submit v2.

[  108.354361] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
[  108.354547] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id 
[  110.995359] INFO: trying to register non-static key.
[  110.995429] The code is fine but needs lockdep annotation, or maybe
[  110.995489] you didn't initialize this object before use?
[  110.995546] turning off the locking correctness validator.
[  110.995604] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G        W         5.15.0-wt-ath+ #522
[  110.995664] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  110.995720] Call Trace:
[  110.995774]  <IRQ>
[  110.995828]  dump_stack_lvl+0x57/0x7d
[  110.995887]  register_lock_class+0x1604/0x17e0
[  110.995945]  ? check_prev_add+0x7bb/0x20f0
[  110.996002]  ? is_dynamic_key+0x1a0/0x1a0
[  110.996058]  ? validate_chain+0xac3/0x1b30
[  110.996127]  __lock_acquire+0x96/0x1870
[  110.996196]  ? check_prev_add+0x20f0/0x20f0
[  110.996266]  ? sched_clock_cpu+0x15/0x1b0
[  110.996339]  ? mark_lock+0xd0/0x14a0
[  110.996401]  lock_acquire.part.0+0x117/0x340
[  110.996470]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 [ath11k]
[  110.996553]  ? rcu_read_unlock+0x40/0x40
[  110.996622]  ? rcu_read_lock_sched_held+0x3a/0x70
[  110.996685]  ? lock_acquire+0x1a8/0x210
[  110.996751]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 [ath11k]
[  110.996831]  _raw_spin_lock_bh+0x34/0x80
[  110.996892]  ? ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 [ath11k]
[  110.996971]  ath11k_dp_rx_mon_dest_process.constprop.0+0x13a/0x6e0 [ath11k]
[  110.997071]  ? ath11k_dp_rxbufs_replenish+0x7a0/0x7a0 [ath11k]
[  110.997187]  ? mark_held_locks+0xa5/0xe0
[  110.997272]  ? ath11k_hal_rx_parse_mon_status_tlv+0x6d7/0x1880 [ath11k]
[  110.997389]  ? ath11k_hal_rx_parse_mon_status+0xed/0x170 [ath11k]
[  110.997506]  ath11k_dp_rx_process_mon_rings+0x3f9/0x580 [ath11k]
[  110.997600]  ? ath11k_dp_rx_pdev_alloc+0xd50/0xd50 [ath11k]
[  110.997680]  ath11k_dp_service_mon_ring+0x67/0xe0 [ath11k]
[  110.997759]  ? ath11k_dp_rx_process_mon_rings+0x580/0x580 [ath11k]
[  110.997835]  call_timer_fn+0x167/0x4a0
[  110.997903]  ? add_timer_on+0x3b0/0x3b0
[  110.997967]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
[  110.998031]  __run_timers.part.0+0x539/0x8b0
[  110.998123]  ? ath11k_dp_rx_process_mon_rings+0x580/0x580 [ath11k]
[  110.998228]  ? call_timer_fn+0x4a0/0x4a0
[  110.998314]  ? clockevents_program_event+0xdd/0x280
[  110.998408]  ? recalibrate_cpu_khz+0x10/0x10
[  110.998496]  ? ktime_get+0x119/0x2f0
[  110.998579]  ? hrtimer_interrupt+0x32f/0x770
[  110.998679]  run_timer_softirq+0x97/0x180
[  110.998764]  __do_softirq+0x276/0x86a
[  110.998850]  __irq_exit_rcu+0x11c/0x180
[  110.998934]  irq_exit_rcu+0x5/0x20
[  110.999017]  sysvec_apic_timer_interrupt+0x8e/0xc0
[  110.999100]  </IRQ>
[  110.999181]  <TASK>
[  110.999261]  asm_sysvec_apic_timer_interrupt+0x12/0x20

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210721171905.61838-4-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

