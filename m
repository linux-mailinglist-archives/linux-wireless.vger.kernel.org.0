Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB200491701
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbiARCha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:37:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiARCdV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:33:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05346B811FF;
        Tue, 18 Jan 2022 02:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC47C36AE3;
        Tue, 18 Jan 2022 02:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473197;
        bh=hqOSIFfEPM25jf3JyI4blFrW5FBGZ6DQgxd28kjbXpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2FAcVzjLRYsAAaAgdUZMvwGcmwm97ky5uT5BfIe37KhZb9G+4ZxHG43G98Tl4vWJ
         8zT6ITqJBpVVGJFeAKWLB50n9i0GhZXJkm7S0tksSnu12xw+id7tmTJXl/aUCVOIAc
         YKWUp9GtuTEw3Bzb3oAw6wBvZA1gtiiET8rrHaJC895153OqOO5ZG+K2mu8fNVViXh
         SB5X08Z8PbOUoFeYwKVLrga1tVkrNUg70uPURyUECu8pRh5QqXyW6mezoAnJgP0QOf
         oi4gn8zIqHLPtzt6AfMObm8Wi6OveLCSVYb6Z+AoGtePdokkbS5pQrG6iECIGsA9E0
         rq+9SIP85dCPw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baochen Qiang <bqiang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 022/188] ath11k: Fix crash caused by uninitialized TX ring
Date:   Mon, 17 Jan 2022 21:29:06 -0500
Message-Id: <20220118023152.1948105-22-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118023152.1948105-1-sashal@kernel.org>
References: <20220118023152.1948105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

[ Upstream commit 273703ebdb01b6c5f1aaf4b98fb57b177609055c ]

Commit 31582373a4a8 ("ath11k: Change number of TCL rings to one for
QCA6390") avoids initializing the other entries of dp->tx_ring cause
the corresponding TX rings on QCA6390/WCN6855 are not used, but leaves
those ring masks in ath11k_hw_ring_mask_qca6390.tx unchanged. Normally
this is OK because we will only get interrupts from the first TX ring
on these chips and thus only the first entry of dp->tx_ring is involved.

In case of one MSI vector, all DP rings share the same IRQ. For each
interrupt, all rings have to be checked, which means the other entries
of dp->tx_ring are involved. However since they are not initialized,
system crashes.

Fix this issue by simply removing those ring masks.

crash stack:
[  102.907438] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  102.907447] #PF: supervisor read access in kernel mode
[  102.907451] #PF: error_code(0x0000) - not-present page
[  102.907453] PGD 1081f0067 P4D 1081f0067 PUD 1081f1067 PMD 0
[  102.907460] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[  102.907465] CPU: 0 PID: 3511 Comm: apt-check Kdump: loaded Tainted: G            E     5.15.0-rc4-wt-ath+ #20
[  102.907470] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS RCD1005E 10/08/2020
[  102.907472] RIP: 0010:ath11k_dp_tx_completion_handler+0x201/0x830 [ath11k]
[  102.907497] Code: 3c 24 4e 8d ac 37 10 04 00 00 4a 8d bc 37 68 04 00 00 48 89 3c 24 48 63 c8 89 83 84 18 00 00 48 c1 e1 05 48 03 8b 78 18 00 00 <8b> 51 08 89 d6 83 e6 07 89 74 24 24 83 fe 03 74 04 85 f6 75 63 41
[  102.907501] RSP: 0000:ffff9b7340003e08 EFLAGS: 00010202
[  102.907505] RAX: 0000000000000001 RBX: ffff8e21530c0100 RCX: 0000000000000020
[  102.907508] RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: ffff8e21530c1938
[  102.907511] RBP: ffff8e21530c0000 R08: 0000000000000001 R09: 0000000000000000
[  102.907513] R10: ffff8e2145534c10 R11: 0000000000000001 R12: ffff8e21530c2938
[  102.907515] R13: ffff8e21530c18e0 R14: 0000000000000100 R15: ffff8e21530c2978
[  102.907518] FS:  00007f5d4297e740(0000) GS:ffff8e243d600000(0000) knlGS:0000000000000000
[  102.907521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.907524] CR2: 0000000000000028 CR3: 00000001034ea000 CR4: 0000000000350ef0
[  102.907527] Call Trace:
[  102.907531]  <IRQ>
[  102.907537]  ath11k_dp_service_srng+0x5c/0x2f0 [ath11k]
[  102.907556]  ath11k_pci_ext_grp_napi_poll+0x21/0x70 [ath11k_pci]
[  102.907562]  __napi_poll+0x2c/0x160
[  102.907570]  net_rx_action+0x251/0x310
[  102.907576]  __do_softirq+0x107/0x2fc
[  102.907585]  irq_exit_rcu+0x74/0x90
[  102.907593]  common_interrupt+0x83/0xa0
[  102.907600]  </IRQ>
[  102.907601]  asm_common_interrupt+0x1e/0x40

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211026011605.58615-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d9596903b0a58..3e92cc7cfe4c9 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1015,8 +1015,6 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074 = {
 const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390 = {
 	.tx  = {
 		ATH11K_TX_RING_MASK_0,
-		ATH11K_TX_RING_MASK_1,
-		ATH11K_TX_RING_MASK_2,
 	},
 	.rx_mon_status = {
 		0, 0, 0, 0,
-- 
2.34.1

