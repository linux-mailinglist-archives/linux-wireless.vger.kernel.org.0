Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5BA4A48EF
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiAaOGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 09:06:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48632 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiAaOGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 09:06:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15431612B3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC58FC340E8;
        Mon, 31 Jan 2022 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637972;
        bh=RehkVb9GUDbdHgogqM4yC+GXYopkgh3U5EXoxsSSebQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Wi1C0WZFy5AMrPfvg4I/PVV0ujo01T6smA37Qy9U1OUIPAIDgLqIw3uA6fz2oUJ7y
         TlgJ1qy7bKOGn/9C2VRZkMSwsdKoxrmxNC3tjNfaFrupfNvrBcJWk2z10TCU4EVVeT
         9pZE6yWwl+6jctFpQPR6tGRpz7nU6XvDC9zOZ/F6FIaVklpyi9vCfGRUAK0fxncFxB
         CcrxxabMfMmD/xeUYUcyxifZJ4KGKp7+xHVrZ9KcSrzGh4IXmoH+MJnvfH8roZTghU
         RwkN4Rm/FtO88zPmbb7bgYoDaau7PUqJY94f8ep3QSudH+XQlc99tlPsdCCRzLcrkK
         KUlzDw0mwjx4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix missing rx_desc_get_ldpc_support in
 wcn6855_ops
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220126010144.2090-1-quic_bqiang@quicinc.com>
References: <20220126010144.2090-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164363796976.10147.12702596481318620970.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 14:06:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> rx_desc_get_ldpc_support is missing in wcn6855_ops, resulting on WCN6855 a
> kernel crash after connecting to an AP and waiting for few minutes. Fix it by
> implementing WCN6855's version of this field and adding it to wcn6855_ops.
> 
> Crash stack:
> [  184.862605] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  184.862615] #PF: supervisor instruction fetch in kernel mode
> [  184.862620] #PF: error_code(0x0010) - not-present page
> [  184.862626] PGD 0 P4D 0
> [  184.862634] Oops: 0010 [#1] PREEMPT SMP PTI
> [  184.862642] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted 5.16.0-wt-ath+ #1
> [  184.862651] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0059.2019.1112.1124 11/12/2019
> [  184.862656] RIP: 0010:0x0
> [  184.862669] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [  184.862673] RSP: 0018:ffff9eedc003cca8 EFLAGS: 00010202
> [  184.862680] RAX: 0000000000000000 RBX: ffff9eedc003cd30 RCX: 0000000000000002
> [  184.862686] RDX: 0000000000000002 RSI: ffffffffc1773458 RDI: ffff8eb5843de240
> [  184.862692] RBP: ffff8eb59685a0e0 R08: 0000000000000001 R09: ffff8eb6fef2b000
> [  184.862700] R10: ffff9eedc003cd70 R11: ffff8eb5880a9ff0 R12: ffff8eb5843de240
> [  184.862707] R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000003
> [  184.862714] FS:  0000000000000000(0000) GS:ffff8eb6f6c40000(0000) knlGS:0000000000000000
> [  184.862723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  184.862733] CR2: ffffffffffffffd6 CR3: 000000002f60a001 CR4: 00000000003706e0
> [  184.862743] Call Trace:
> [  184.862751]  <IRQ>
> [  184.862759]  ath11k_dp_rx_h_ppdu+0x210/0x350 [ath11k]
> [  184.862841]  ath11k_dp_rx_process_received_packets+0x1e6/0x6b0 [ath11k]
> [  184.862891]  ath11k_dp_process_rx+0x32d/0x3e0 [ath11k]
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Fixes: b3febdccde3e ("ath11k: add LDPC FEC type in 802.11 radiotap header")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

648ab4720cb7 ath11k: Fix missing rx_desc_get_ldpc_support in wcn6855_ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220126010144.2090-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

