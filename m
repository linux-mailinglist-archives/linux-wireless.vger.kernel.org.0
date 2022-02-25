Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A93B4C3DE9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 06:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiBYFdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 00:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiBYFdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 00:33:49 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD764B40C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 21:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645767197; x=1677303197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/9OvoEtnUf6JA3f6wddkGTyhrIk7VryxysdmIEhLqhY=;
  b=hWMre2joLMca9EtlX0IUnxcrAIgk00kdI5/HFI06rhayw0utqG838Est
   fNRxKd6uaEJbXfkje6njmGdVg4CfrRznVCSS7ZK9zQvhf73qDRugACIM9
   xHiVTnGckAqt5rw/Y8pg1D7GRO/YDEyg37sVvgPCBa5dauq4dUm1a9uun
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 21:33:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 21:33:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 21:33:16 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 21:33:15 -0800
Message-ID: <0b9b0406-ecd5-95ac-39d8-3528f069df6d@quicinc.com>
Date:   Fri, 25 Feb 2022 13:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 0/6] ath11k: add feature for device recovery
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220209060012.32478-1-quic_wgong@quicinc.com>
 <87v8x8wmga.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87v8x8wmga.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Kalle.

I have found the reason of the warning.

I will send a new path together with the patches 4-6.

On 2/21/2022 6:20 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> Currently recovery is work success for QCA6390/WCN6855 without the RDDM dump feature,
>> because patch "ath11k: configure RDDM size to mhi for recovery by firmware"
>> added in v5.
> The firmware restart works now but I get warnings, see log below. I
> applied patches 1-3, but patches 4-6 need more work. I'm using:
>
> ath11k_pci 0000:06:00.0: MSI vectors: 32
> ath11k_pci 0000:06:00.0: qca6390 hw2.0
> ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> ath11k_pci 0000:06:00.0: fw_version 0x10121492 fw_build_timestamp 2021-11-04 11:23 fw_build_id
>
> Here's the log:
>
> [ 1965.642121] ath11k_pci 0000:06:00.0: simulating firmware assert crash
> [ 1968.471364] ieee80211 phy0: Hardware restart was requested
> [ 1968.511305] ------------[ cut here ]------------
> [ 1968.511368] WARNING: CPU: 3 PID: 1546 at drivers/bus/mhi/core/pm.c:505 mhi_pm_disable_transition+0xb37/0xda0 [mhi]
> [ 1968.511443] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
> [ 1968.511563] CPU: 3 PID: 1546 Comm: kworker/u17:0 Kdump: loaded Tainted: G        W         5.17.0-rc3-wt-ath+ #579
> [ 1968.511629] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [ 1968.511704] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> [ 1968.511787] RIP: 0010:mhi_pm_disable_transition+0xb37/0xda0 [mhi]
> [ 1968.511870] Code: a9 fe ff ff 4c 89 ff 44 89 04 24 e8 03 46 f6 e5 44 8b 04 24 41 83 f8 01 0f 84 21 fe ff ff e9 4c fd ff ff 0f 0b e9 af f8 ff ff <0f> 0b e9 5c f8 ff ff 48 89 df e8 da 9e ee e3 e9 12 fd ff ff 4c 89
> [ 1968.511923] RSP: 0018:ffffc900024efbf0 EFLAGS: 00010286
> [ 1968.511969] RAX: 00000000ffffffff RBX: ffff88811d241250 RCX: ffffffffc0176922
> [ 1968.512014] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888118a90a24
> [ 1968.512059] RBP: ffff888118a90800 R08: 0000000000000000 R09: ffff888118a90a27
> [ 1968.512102] R10: ffffed1023152144 R11: 0000000000000001 R12: ffff888118a908ac
> [ 1968.512229] R13: ffff888118a90928 R14: dffffc0000000000 R15: ffff888118a90a24
> [ 1968.512310] FS:  0000000000000000(0000) GS:ffff888234200000(0000) knlGS:0000000000000000
> [ 1968.512405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1968.512493] CR2: 00007f5538f443a8 CR3: 000000016dc28001 CR4: 00000000003706e0
> [ 1968.512587] Call Trace:
> [ 1968.512672]  <TASK>
> [ 1968.512751]  ? _raw_spin_unlock_irq+0x1f/0x40
> [ 1968.512859]  mhi_pm_st_worker+0x3ac/0x790 [mhi]
> [ 1968.512959]  ? mhi_pm_mission_mode_transition.isra.0+0x7d0/0x7d0 [mhi]
> [ 1968.513063]  process_one_work+0x86a/0x1400
> [ 1968.513184]  ? pwq_dec_nr_in_flight+0x230/0x230
> [ 1968.513312]  ? move_linked_works+0x125/0x290
> [ 1968.513416]  worker_thread+0x6db/0xf60
> [ 1968.513536]  ? process_one_work+0x1400/0x1400
> [ 1968.513627]  kthread+0x241/0x2d0
> [ 1968.513733]  ? kthread_complete_and_exit+0x20/0x20
> [ 1968.513821]  ret_from_fork+0x22/0x30
> [ 1968.513924]  </TASK>
> [ 1968.514000] irq event stamp: 38683
> [ 1968.514079] hardirqs last  enabled at (38691): [<ffffffffa3c6eb52>] __up_console_sem+0x62/0x70
> [ 1968.514185] hardirqs last disabled at (38700): [<ffffffffa3c6eb37>] __up_console_sem+0x47/0x70
> [ 1968.514266] softirqs last  enabled at (37928): [<ffffffffc01740ac>] mhi_reset_chan+0x76c/0xaa0 [mhi]
> [ 1968.514356] softirqs last disabled at (37924): [<ffffffffc0173a71>] mhi_reset_chan+0x131/0xaa0 [mhi]
> [ 1968.514448] ---[ end trace 0000000000000000 ]---
> [ 1968.844604] mhi mhi0: Requested to power ON
> [ 1968.845578] mhi mhi0: Power on setup success
> [ 1969.152617] mhi mhi0: Wait for device to enter SBL or Mission mode
> [ 1969.268367] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [ 1969.268441] ath11k_pci 0000:06:00.0: fw_version 0x10121492 fw_build_timestamp 2021-11-04 11:23 fw_build_id
> [ 1969.293648] ath11k_pci 0000:06:00.0: Last interrupt received for each CE:
> [ 1969.293712] ath11k_pci 0000:06:00.0: CE_id 0 pipe_num 0 126895ms before
> [ 1969.293803] ath11k_pci 0000:06:00.0: CE_id 1 pipe_num 1 19337ms before
> [ 1969.293851] ath11k_pci 0000:06:00.0: CE_id 2 pipe_num 2 3648ms before
> [ 1969.293913] ath11k_pci 0000:06:00.0: CE_id 3 pipe_num 3 3649ms before
> [ 1969.293974] ath11k_pci 0000:06:00.0: CE_id 5 pipe_num 5 126895ms before
> [ 1969.294034] ath11k_pci 0000:06:00.0: CE_id 7 pipe_num 7 1668238ms before
> [ 1969.294095] ath11k_pci 0000:06:00.0: CE_id 8 pipe_num 8 1668238ms before
> [ 1969.294279] ath11k_pci 0000:06:00.0: #012[ 1969.294279] Last interrupt received for each group:
> [ 1969.294343] ath11k_pci 0000:06:00.0: group_id 0 6782ms before
> [ 1969.294408] ath11k_pci 0000:06:00.0: group_id 1 1668239ms before
> [ 1969.294473] ath11k_pci 0000:06:00.0: group_id 2 1668239ms before
> [ 1969.294535] ath11k_pci 0000:06:00.0: group_id 3 1668239ms before
> [ 1969.295035] ath11k_pci 0000:06:00.0: group_id 4 1668239ms before
> [ 1969.295103] ath11k_pci 0000:06:00.0: group_id 5 1668239ms before
> [ 1969.295390] ath11k_pci 0000:06:00.0: group_id 6 1668240ms before
> [ 1969.295442] ath11k_pci 0000:06:00.0: group_id 7 1668240ms before
> [ 1969.295518] ath11k_pci 0000:06:00.0: group_id 8 6783ms before
> [ 1969.295579] ath11k_pci 0000:06:00.0: group_id 9 1668240ms before
> [ 1969.295640] ath11k_pci 0000:06:00.0: group_id 10 1668240ms before
> [ 1969.295715] ath11k_pci 0000:06:00.0: dst srng id 0 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 1668240ms
> [ 1969.295783] ath11k_pci 0000:06:00.0: dst srng id 1 tp 208, cur hp 208, cached hp 208 last hp 208 napi processed before 6783ms
> [ 1969.295845] ath11k_pci 0000:06:00.0: dst srng id 2 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 1668240ms
> [ 1969.295908] ath11k_pci 0000:06:00.0: dst srng id 3 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 1668240ms
> [ 1969.295971] ath11k_pci 0000:06:00.0: dst srng id 4 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 6782ms
> [ 1969.296038] ath11k_pci 0000:06:00.0: src srng id 5 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 1668240ms
> [ 1969.296103] ath11k_pci 0000:06:00.0: src srng id 8 hp 350, reap_hp 350, cur tp 180, cached tp 180 last tp 180 napi processed before 814ms
> [ 1969.296239] ath11k_pci 0000:06:00.0: dst srng id 9 tp 468, cur hp 468, cached hp 468 last hp 468 napi processed before 6783ms
> [ 1969.296290] ath11k_pci 0000:06:00.0: src srng id 16 hp 120, reap_hp 120, cur tp 120, cached tp 112 last tp 112 napi processed before 6801ms
> [ 1969.296356] ath11k_pci 0000:06:00.0: src srng id 24 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 1668241ms
> [ 1969.296419] ath11k_pci 0000:06:00.0: dst srng id 25 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 1668241ms
> [ 1969.296483] ath11k_pci 0000:06:00.0: src srng id 32 hp 12, reap_hp 8, cur tp 12, cached tp 12 last tp 8 napi processed before 126898ms
> [ 1969.296544] ath11k_pci 0000:06:00.0: src srng id 35 hp 28, reap_hp 24, cur tp 28, cached tp 28 last tp 24 napi processed before 3654ms
> [ 1969.296605] ath11k_pci 0000:06:00.0: src srng id 36 hp 48, reap_hp 44, cur tp 48, cached tp 48 last tp 44 napi processed before 126484ms
> [ 1969.296667] ath11k_pci 0000:06:00.0: src srng id 39 hp 0, reap_hp 124, cur tp 0, cached tp 0 last tp 0 napi processed before 1668241ms
> [ 1969.296728] ath11k_pci 0000:06:00.0: src srng id 57 hp 0, reap_hp 0, cur tp 4, cached tp 4 last tp 4 napi processed before 19339ms
> [ 1969.296791] ath11k_pci 0000:06:00.0: src srng id 58 hp 792, reap_hp 792, cur tp 796, cached tp 796 last tp 796 napi processed before 3650ms
> [ 1969.296853] ath11k_pci 0000:06:00.0: src srng id 61 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 126898ms
> [ 1969.296916] ath11k_pci 0000:06:00.0: dst srng id 81 tp 8, cur hp 8, cached hp 8 last hp 8 napi processed before 19340ms
> [ 1969.296977] ath11k_pci 0000:06:00.0: dst srng id 82 tp 1592, cur hp 1592, cached hp 1592 last hp 1592 napi processed before 3650ms
> [ 1969.297058] ath11k_pci 0000:06:00.0: dst srng id 85 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 126898ms
> [ 1969.297125] ath11k_pci 0000:06:00.0: src srng id 104 hp 65532, reap_hp 65532, cur tp 0, cached tp 0 last tp 0 napi processed before 126999ms
> [ 1969.297256] ath11k_pci 0000:06:00.0: src srng id 105 hp 0, reap_hp 504, cur tp 0, cached tp 0 last tp 0 napi processed before 1668242ms
> [ 1969.297321] ath11k_pci 0000:06:00.0: dst srng id 106 tp 176, cur hp 176, cached hp 176 last hp 176 napi processed before 6784ms
> [ 1969.297388] ath11k_pci 0000:06:00.0: dst srng id 109 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 6784ms
> [ 1969.297824] ath11k_pci 0000:06:00.0: src srng id 128 hp 24, reap_hp 24, cur tp 4182, cached tp 4182 last tp 4182 napi processed before 6784ms
> [ 1969.297888] ath11k_pci 0000:06:00.0: src srng id 129 hp 0, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 1668242ms
> [ 1969.297951] ath11k_pci 0000:06:00.0: src srng id 132 hp 20, reap_hp 20, cur tp 22, cached tp 22 last tp 22 napi processed before 4ms
> [ 1969.298014] ath11k_pci 0000:06:00.0: dst srng id 133 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 6784ms
> [ 1969.298079] ath11k_pci 0000:06:00.0: src srng id 144 hp 0, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 1668242ms
> [ 1969.298191] ath11k_pci 0000:06:00.0: src srng id 147 hp 110, reap_hp 110, cur tp 112, cached tp 112 last tp 112 napi processed before 5ms
> [ 1969.298255] ath11k_pci 0000:06:00.0: dst srng id 148 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 1668243ms
> [ 1970.945274] ath11k_pci 0000:06:00.0: Already processed, so ignoring dma ring caps
> [ 1973.850557] ath11k_pci 0000:06:00.0: pdev 0 successfully recovered
>
