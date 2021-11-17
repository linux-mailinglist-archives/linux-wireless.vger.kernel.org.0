Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C354541DA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhKQHdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:33:14 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:32284 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234140AbhKQHdM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:33:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134214; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SiQ6SRP+sHIIIKbcxSblqmxN1NkeZRUYfcGWgIfUKMk=;
 b=jizbzONBNjgw5UIEOXXrXdNylVf8FLGPluBXA32Ctyzq0Ea/T7AYkOerxz6+8xPPlI6SzNIZ
 FP1wmk27WWd6n1INZ3XCc+Z8/cdp/H5TzTi3yx2C8tLKk3fm4dh9U1T4UTyHuj1tp/1CwlXA
 05PrqgX585VbunN04xUjIX0IYJA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6194af82638a2f4d6117da63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:30:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB4F6C4338F; Wed, 17 Nov 2021 07:30:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6036CC43460;
        Wed, 17 Nov 2021 07:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6036CC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix crash caused by uninitialized TX ring
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211026011605.58615-1-quic_bqiang@quicinc.com>
References: <20211026011605.58615-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713420664.31320.4169502829779343934.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:30:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Commit 31582373a4a8 ("ath11k: Change number of TCL rings to one for
> QCA6390") avoids initializing the other entries of dp->tx_ring cause
> the corresponding TX rings on QCA6390/WCN6855 are not used, but leaves
> those ring masks in ath11k_hw_ring_mask_qca6390.tx unchanged. Normally
> this is OK because we will only get interrupts from the first TX ring
> on these chips and thus only the first entry of dp->tx_ring is involved.
> 
> In case of one MSI vector, all DP rings share the same IRQ. For each
> interrupt, all rings have to be checked, which means the other entries
> of dp->tx_ring are involved. However since they are not initialized,
> system crashes.
> 
> Fix this issue by simply removing those ring masks.
> 
> crash stack:
> [  102.907438] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [  102.907447] #PF: supervisor read access in kernel mode
> [  102.907451] #PF: error_code(0x0000) - not-present page
> [  102.907453] PGD 1081f0067 P4D 1081f0067 PUD 1081f1067 PMD 0
> [  102.907460] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
> [  102.907465] CPU: 0 PID: 3511 Comm: apt-check Kdump: loaded Tainted: G            E     5.15.0-rc4-wt-ath+ #20
> [  102.907470] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS RCD1005E 10/08/2020
> [  102.907472] RIP: 0010:ath11k_dp_tx_completion_handler+0x201/0x830 [ath11k]
> [  102.907497] Code: 3c 24 4e 8d ac 37 10 04 00 00 4a 8d bc 37 68 04 00 00 48 89 3c 24 48 63 c8 89 83 84 18 00 00 48 c1 e1 05 48 03 8b 78 18 00 00 <8b> 51 08 89 d6 83 e6 07 89 74 24 24 83 fe 03 74 04 85 f6 75 63 41
> [  102.907501] RSP: 0000:ffff9b7340003e08 EFLAGS: 00010202
> [  102.907505] RAX: 0000000000000001 RBX: ffff8e21530c0100 RCX: 0000000000000020
> [  102.907508] RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: ffff8e21530c1938
> [  102.907511] RBP: ffff8e21530c0000 R08: 0000000000000001 R09: 0000000000000000
> [  102.907513] R10: ffff8e2145534c10 R11: 0000000000000001 R12: ffff8e21530c2938
> [  102.907515] R13: ffff8e21530c18e0 R14: 0000000000000100 R15: ffff8e21530c2978
> [  102.907518] FS:  00007f5d4297e740(0000) GS:ffff8e243d600000(0000) knlGS:0000000000000000
> [  102.907521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  102.907524] CR2: 0000000000000028 CR3: 00000001034ea000 CR4: 0000000000350ef0
> [  102.907527] Call Trace:
> [  102.907531]  <IRQ>
> [  102.907537]  ath11k_dp_service_srng+0x5c/0x2f0 [ath11k]
> [  102.907556]  ath11k_pci_ext_grp_napi_poll+0x21/0x70 [ath11k_pci]
> [  102.907562]  __napi_poll+0x2c/0x160
> [  102.907570]  net_rx_action+0x251/0x310
> [  102.907576]  __do_softirq+0x107/0x2fc
> [  102.907585]  irq_exit_rcu+0x74/0x90
> [  102.907593]  common_interrupt+0x83/0xa0
> [  102.907600]  </IRQ>
> [  102.907601]  asm_common_interrupt+0x1e/0x40
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

273703ebdb01 ath11k: Fix crash caused by uninitialized TX ring

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211026011605.58615-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

