Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB34631498B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBIHe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:34:59 -0500
Received: from so15.mailgun.net ([198.61.254.15]:48995 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBIHey (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:34:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612856069; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uLPhv5m60UI7IBZqE1r66mltJyO8pbEkuGp22l+LNdE=;
 b=P8Nqt+6Nhmm9cq3FaDRfZOXr3LVnIxvraoGrPWJw0pIWIzTITkzbp0UOuYGl1V0+ILFPIrLj
 IXhwopr1mUW+OVR20jIhILOwg2oxlvBVj2C2XhLFnHHAxDcIvzjKsun5Y+UFla/I29Y2dETH
 0sicNubqTsKPP3p40w1UzqtbQTE=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60223ae9830f898bac88929b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:34:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2BA0C433CA; Tue,  9 Feb 2021 07:34:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8E33C433C6;
        Tue,  9 Feb 2021 07:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8E33C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210209073400.F2BA0C433CA@smtp.codeaurora.org>
Date:   Tue,  9 Feb 2021 07:34:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Kernel panic every time in kernel when running below case:
> steps:
> 1. connect to an AP with good signal strength
> 2. echo 0x7f > /sys/kernel/debug/ieee80211/phy0/ath10k/pktlog_filter
> 3. echo 0xffff 0 > /sys/kernel/debug/ieee80211/phy0/ath10k/fw_dbglog
> 4. echo 0 > /sys/module/ath10k_core/parameters/debug_mask
> 5. sudo trace-cmd record  -e ath10k
> 6. run "iperf -c 192.168.1.1 -u -b 100m -i 1 -t 30"
> 7. kernel panic immeditely
> 
> It always crash at trace_event_raw_event_ath10k_xxx, below is 2 sample:
> 
> dmesg 1:
> [   58.038310] Unable to handle kernel paging request at virtual address 003130393837363d
> [   58.038325] Mem abort info:
> [   58.038330]   ESR = 0x96000004
> [   58.038336]   Exception class = DABT (current EL), IL = 32 bits
> [   58.038340]   SET = 0, FnV = 0
> [   58.038345]   EA = 0, S1PTW = 0
> [   58.038349] Data abort info:
> [   58.038353]   ISV = 0, ISS = 0x00000004
> [   58.038358]   CM = 0, WnR = 0
> [   58.038363] [003130393837363d] address between user and kernel address ranges
> [   58.038370] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   58.038377] Modules linked in: rfcomm algif_hash algif_skcipher
> [   58.038385] Unable to handle kernel paging request at virtual address 003938373635343b
> [   58.038386]  af_alg uinput cros_ec_rpmsg mtk_dip mtk_mdp3
> [   58.038395] Mem abort info:
> [   58.038403]   ESR = 0x96000004
> [   58.038412]   Exception class = DABT (current EL), IL = 32 bits
> [   58.038419]   SET = 0, FnV = 0
> [   58.038427]   EA = 0, S1PTW = 0
> [   58.038434] Data abort info:
> [   58.038442]   ISV = 0, ISS = 0x00000004
> [   58.038449]   CM = 0, WnR = 0
> [   58.038457] [003938373635343b] address between user and kernel address ranges
> [   58.038486] Process kworker/u16:1 (pid: 141, stack limit = 0x000000009bd6ba2e)
> [   58.038496] CPU: 1 PID: 141 Comm: kworker/u16:1 Not tainted 4.19.139 #162
> [   58.038501] Hardware name: MediaTek krane sku176 board (DT)
> [   58.038515] Workqueue: ath10k_sdio_wq ath10k_sdio_write_async_work [ath10k_sdio]
> [   58.038523] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [   58.038536] pc : filter_match_preds+0x20/0x94
> [   58.038546] lr : trace_event_buffer_commit+0x150/0x22c
> [   58.038550] sp : ffffff80088a39f0
> [   58.038555] x29: ffffff80088a3a20 x28: 000000000000000c
> [   58.038561] x27: 000000000000000c x26: 0000000000000001
> [   58.038567] x25: ffffffdfd96ef008 x24: 0000000000000000
> [   58.038573] x23: 0000000000000000 x22: ffffffe03b006c00
> [   58.038580] x21: ffffffdfd96ef000 x20: 3231303938373635
> [   58.038586] x19: ffffffe02de9b160 x18: 0000000000000020
> [   58.038592] x17: 0000000000100000 x16: ffffffa4e67937f0
> [   58.038598] x15: 0000000000100000 x14: 0000393837363534
> [   58.038604] x13: 3332313039383736 x12: 3534333231303938
> [   58.038611] x11: 3736353433323130 x10: 3938373635343332
> [   58.038617] x9 : 3130393837363534 x8 : 000000000000040b
> [   58.038623] x7 : 3534333231303938 x6 : ffffffdfd96fb2d1
> [   58.038629] x5 : 0000000000000000 x4 : 0000000000000000
> [   58.038635] x3 : 000000000000c2cd x2 : ffffffffffffffc0
> [   58.038641] x1 : ffffffdfd96ef008 x0 : ffffffdfd96f7080
> [   58.038648] Call trace:
> [   58.038655]  filter_match_preds+0x20/0x94
> [   58.038661]  trace_event_buffer_commit+0x150/0x22c
> [   58.038698]  trace_event_raw_event_ath10k_log_dbg_dump+0x208/0x240 [ath10k_core]
> [   58.038716]  ath10k_dbg_dump+0x1bc/0x21c [ath10k_core]
> [   58.038724]  ath10k_sdio_write+0xc8/0xe8 [ath10k_sdio]
> [   58.038730]  ath10k_sdio_write_async_work+0x11c/0x1f4 [ath10k_sdio]
> [   58.038738]  process_one_work+0x210/0x418
> [   58.038744]  worker_thread+0x234/0x3dc
> [   58.038751]  kthread+0x120/0x140
> [   58.038758]  ret_from_fork+0x10/0x18
> [   58.038766] Code: 9100c3fd b40002e0 f9400014 b40002b4 (f9400680)
> [   58.038773] ---[ end trace 8b9d2463f441eb7f ]---
> [   58.051846] Kernel panic - not syncing: Fatal exception
> [   58.051864] SMP: stopping secondary CPUs
> 
> dmesg 2:
> [  228.692905] Unable to handle kernel paging request at virtual address 0033323130393837
> [  228.692913] Mem abort info:
> [  228.692920]   ESR = 0x96000004
> [  228.692927]   Exception class = DABT (current EL), IL = 32 bits
> [  228.692933]   SET = 0, FnV = 0
> [  228.692938]   EA = 0, S1PTW = 0
> [  228.692943] Data abort info:
> [  228.692953]   ISV = 0, ISS = 0x00000004
> [  228.692965]   CM = 0, WnR = 0
> [  228.692975] [0033323130393837] address between user and kernel address ranges
> [  228.692983] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  228.693078] Process kworker/u16:2 (pid: 144, stack limit = 0x000000009f882493)
> [  228.693088] CPU: 6 PID: 144 Comm: kworker/u16:2 Tainted: G        W         4.19.139 #162
> [  228.693095] Hardware name: MediaTek krane sku176 board (DT)
> [  228.693125] Workqueue: ath10k_tx_complete_wq ath10k_htc_tx_complete_work [ath10k_core]
> [  228.693137] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [  228.693152] pc : filter_match_preds+0x38/0x94
> [  228.693164] lr : trace_event_buffer_commit+0x150/0x22c
> [  228.693170] sp : ffffff80088b3b20
> [  228.693175] x29: ffffff80088b3b50 x28: 0000000000000402
> [  228.693183] x27: fffffff040001f60 x26: ffffff9d4ba34000
> [  228.693191] x25: fffffff040af5004 x24: 0000000000000000
> [  228.693198] x23: 0000000000000000 x22: fffffff040af7100
> [  228.693205] x21: 0000000000000000 x20: fffffff040af7100
> [  228.693212] x19: fffffff040af5004 x18: 0000000000000000
> [  228.693219] x17: 000000000000003c x16: ffffff9d4da649d8
> [  228.693226] x15: 0000000000000006 x14: 3837363534333231
> [  228.693233] x13: fffffff01514fc00 x12: 0000000000000000
> [  228.693240] x11: 0000000000000000 x10: fffffff040af5004
> [  228.693247] x9 : 0000000000000000 x8 : 0000000000000000
> [  228.693254] x7 : 646b686064ff6e68 x6 : 0000800000000000
> [  228.693261] x5 : 0000000000000000 x4 : 0000000000000000
> [  228.693268] x3 : 000000000000002c x2 : 0000000000000000
> [  228.693275] x1 : fffffff040af5004 x0 : 3433323130393837
> [  228.693282] Call trace:
> [  228.693291]  filter_match_preds+0x38/0x94
> [  228.693299]  trace_event_buffer_commit+0x150/0x22c
> [  228.693321]  trace_event_raw_event_ath10k_txrx_tx_unref+0x164/0x198 [ath10k_core]
> [  228.693344]  ath10k_txrx_tx_unref+0x1c0/0x36c [ath10k_core]
> [  228.693365]  ath10k_htt_htc_tx_complete+0xe4/0x114 [ath10k_core]
> [  228.693386]  ath10k_htc_notify_tx_completion+0xe4/0x124 [ath10k_core]
> [  228.693407]  ath10k_htc_tx_complete_work+0xb8/0xf0 [ath10k_core]
> [  228.693418]  process_one_work+0x210/0x418
> [  228.693425]  worker_thread+0x234/0x3dc
> [  228.693433]  kthread+0x120/0x140
> [  228.693441]  ret_from_fork+0x10/0x18
> [  228.693451] Code: aa0103f3 aa1f03e8 2a1f03f5 aa1403f6 (f9400009)
> [  228.693459] ---[ end trace 187b0ae372e7515c ]---
> [  228.711074] Kernel panic - not syncing: Fatal exception
> [  228.711086] SMP: stopping secondary CPUs
> [  228.711254] Kernel Offset: 0x1d45600000 from 0xffffff8008000000
> [  228.711259] CPU features: 0x0,2188200c
> [  228.711262] Memory Limit: none
> 
> The value of prog in filter_match_preds of kernel/trace/trace_events_filter.c
> is overwrite to the content of the UDP packets's content like this
> 0x0039383736353433, it is a invalid address, so crash.
> 
> Content of udp tx packets with iperf:
> 0000   00 03 7f 46 c4 49 40 49 0f 2f f9 09 08 00 45 00   ...F.I@I./....E.
> 0010   05 da 18 00 40 00 40 11 99 4a c0 a8 01 77 c0 a8   ....@.@..J...w..
> 0020   01 01 9c 7d 13 89 05 c6 89 a0 00 00 01 8b 5d 69   ...}..........]i
> 0030   98 9a 00 0a 55 b8 00 00 00 00 00 00 00 01 00 00   ....U...........
> 0040   13 89 00 00 00 00 00 00 00 00 ff ff f4 48 05 f5   .............H..
> 0050   e1 00 30 31 32 33 34 35 36 37 38 39 30 31 32 33   ..01234567890123
> 0060   34 35 36 37 38 39 30 31 32 33 34 35 36 37 38 39   4567890123456789
> 0070   30 31 32 33 34 35 36 37 38 39 30 31 32 33 34 35   0123456789012345
> 0080   36 37 38 39 30 31 32 33 34 35 36 37 38 39 30 31   6789012345678901
> 0090   32 33 34 35 36 37 38 39 30 31 32 33 34 35 36 37   2345678901234567
> 00a0   38 39 30 31 32 33 34 35 36 37 38 39 30 31 32 33   8901234567890123
> 00b0   34 35 36 37 38 39 30 31 32 33 34 35 36 37 38 39   4567890123456789
> ...
> 05b0   34 35 36 37 38 39 30 31 32 33 34 35 36 37 38 39   4567890123456789
> 05c0   30 31 32 33 34 35 36 37 38 39 30 31 32 33 34 35   0123456789012345
> 05d0   36 37 38 39 30 31 32 33 34 35 36 37 38 39 30 31   6789012345678901
> 05e0   32 33 34 35 36 37 38 39                           23456789
> 
> ath10k_htc_send_bundle_skbs allocate skb with size 49792(1556*32), it
> is bigger than PAGE_SIZE which is normally 4096, then ath10k_sdio_write
> call ath10k_dbg_dump to trace the large size skb and corrupt the trace
> data of tracing and lead crash. When disable the TX bundle of SDIO, it
> does not crash, but TX bundle is for improve throughput, so it is enabled
> by default. It is useless to call ath10k_dbg_dump to trace the large
> bundled skb, so this patch trace the top part of large bundled skb.
> 
> I also did another try with below change, it is move the ath10k_dbg_dump
> from ath10k_sdio_write to ath10k_sdio_mbox_rx_fetch_bundle, it also
> crash immediately when run iperf UDP RX traffic, RX bundle is enabled
> by default for SDIO, so the virt_pkt_len of ath10k_sdio_mbox_rx_fetch_bundle
> is large, max value is 57344(1792*32), so it crashed same with upper test.
> 
> Change of try:
> 
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -336,7 +336,6 @@ static int ath10k_sdio_write(struct ath10k *ar, u32 addr, const void *buf, size_
> 
>         ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio write addr 0x%x buf 0x%p len %zu\n",
>                    addr, buf, len);
> -       ath10k_dbg_dump(ar, ATH10K_DBG_SDIO_DUMP, NULL, "sdio write ", buf, len);
> 
>  out:
>         sdio_release_host(func);
> @@ -692,6 +691,8 @@ static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
>                 goto err;
>         }
> 
> +       ath10k_dbg_dump(ar, ATH10K_DBG_SDIO_DUMP, NULL, "sdio read vsg", ar_sdio->vsg_buffer, virt_pkt_len);
> +
>         pkt_offset = 0;
>         for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
>                 pkt = &ar_sdio->rx_pkts[i];
> 
> dmesg of try:
> [  170.621318] Unable to handle kernel paging request at virtual address 0036353433323138
> [  170.621336] Mem abort info:
> [  170.621341]   ESR = 0x96000004
> [  170.621347]   Exception class = DABT (current EL), IL = 32 bits
> [  170.621352]   SET = 0, FnV = 0
> [  170.621357]   EA = 0, S1PTW = 0
> [  170.621362] Data abort info:
> [  170.621367]   ISV = 0, ISS = 0x00000004
> [  170.621371]   CM = 0, WnR = 0
> [  170.621377] [0036353433323138] address between user and kernel address ranges
> [  170.621385] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  170.621479] Process kworker/0:1 (pid: 14, stack limit = 0x00000000c6fcfb2a)
> [  170.621489] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.139 #162
> [  170.621494] Hardware name: MediaTek krane sku176 board (DT)
> [  170.621511] Workqueue: events sdio_irq_work
> [  170.621519] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [  170.621529] pc : filter_match_preds+0x20/0x94
> [  170.621540] lr : trace_event_buffer_commit+0x150/0x22c
> [  170.621545] sp : ffffff80080f37d0
> [  170.621550] x29: ffffff80080f3800 x28: 000000000000000c
> [  170.621556] x27: 000000000000000c x26: 0000000000000001
> [  170.621563] x25: fffffff118eb8008 x24: 0000000000000000
> [  170.621569] x23: 0000000000000000 x22: fffffff17b007900
> [  170.621576] x21: fffffff118eb8000 x20: 3736353433323130
> [  170.621583] x19: fffffff178645790 x18: 0000000000000020
> [  170.621589] x17: 000000000000003c x16: ffffff91fe3937f0
> [  170.621596] x15: 0000000000000006 x14: 00000636000ad8b0
> [  170.621602] x13: 0000000000000000 x12: 0000000000000000
> [  170.621608] x11: 0000000000000000 x10: 0000000000000000
> [  170.621615] x9 : 0000000000000000 x8 : 000000000000040b
> [  170.621621] x7 : 0000000000000000 x6 : fffffff118ec6052
> [  170.621628] x5 : 0000000000000000 x4 : 0000000000000000
> [  170.621634] x3 : 000000000000e04e x2 : ffffffffffffffc0
> [  170.621640] x1 : fffffff118eb8008 x0 : fffffff118ec1f00
> [  170.621648] Call trace:
> [  170.621655]  filter_match_preds+0x20/0x94
> [  170.621662]  trace_event_buffer_commit+0x150/0x22c
> [  170.621704]  trace_event_raw_event_ath10k_log_dbg_dump+0x208/0x240 [ath10k_core]
> [  170.621724]  ath10k_dbg_dump+0x1bc/0x21c [ath10k_core]
> [  170.621734]  ath10k_sdio_readsb+0xdc/0xfc [ath10k_sdio]
> [  170.621742]  ath10k_sdio_irq_handler+0x6f8/0xca8 [ath10k_sdio]
> [  170.621749]  process_sdio_pending_irqs+0x60/0x1b4
> [  170.621756]  sdio_run_irqs+0x34/0x60
> [  170.621762]  sdio_irq_work+0x1c/0x28
> [  170.621769]  process_one_work+0x210/0x418
> [  170.621775]  worker_thread+0x234/0x3dc
> [  170.621783]  kthread+0x120/0x140
> [  170.621791]  ret_from_fork+0x10/0x18
> [  170.621799] Code: 9100c3fd b40002e0 f9400014 b40002b4 (f9400680)
> [  170.621807] ---[ end trace b52c34b9c8deb8e3 ]---
> [  170.624123] Unable to handle kernel paging request at virtual address dffd74685cec003c
> [  170.624134] Mem abort info:
> [  170.624138]   ESR = 0x96000004
> [  170.624143]   Exception class = DABT (current EL), IL = 32 bits
> [  170.624146]   SET = 0, FnV = 0
> [  170.624150]   EA = 0, S1PTW = 0
> [  170.624153] Data abort info:
> [  170.624157]   ISV = 0, ISS = 0x00000004
> [  170.624160]   CM = 0, WnR = 0
> [  170.624165] [dffd74685cec003c] address between user and kernel address ranges
> [  170.634352] Kernel panic - not syncing: Fatal exception
> [  170.634370] SMP: stopping secondary CPUs
> [  171.711302] SMP: failed to stop secondary CPUs 0,4
> [  171.711310] Kernel Offset: 0x11f6200000 from 0xffffff8008000000
> [  171.711316] CPU features: 0x0,2188200c
> [  171.711321] Memory Limit: none
> [  171.723885] SMP: stopping secondary CPUs
> [  172.800814] SMP: failed to stop secondary CPUs 0,4
> 
> trace_event_raw_event_ath10k_log_dbg_dump is generated by compiler, it
> call trace_event_buffer_reserve got get a struct pointer *entry, its
> type is trace_event_raw_ath10k_log_dbg_dump which is also generated by
> compiler, trace_event_buffer_reserve of kernel/trace/trace_events.c
> call trace_event_buffer_lock_reserve to get ring_buffer_event.
> 
> In function trace_event_buffer_lock_reserve of kernel/trace/trace.c,
> the ring_buffer_time_stamp_abs is false and trace_file->flags is 0x40b
> which is set bit of EVENT_FILE_FL_FILTERED by debugging, so it use the
> temp buffer this_cpu_read(trace_buffered_event), and the buffer size
> is 1 page size which allocatee in trace_buffered_event_enable by
> alloc_pages_node, and then ath10k pass the buffer size > 1 page trigger
> overflow and crash.
> 
> Based on upper test, try and debugging, pass large buff size to function
> trace_ath10k_log_dbg_dump cause crash, and it has ath10k_dbg in
> ath10k_sdio_write to print the length of skb/buffer, it is not necessary
> to trace all content of the large skb.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

Failed to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath10k/sdio.c:336
error: drivers/net/wireless/ath/ath10k/sdio.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612839593-2308-1-git-send-email-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

