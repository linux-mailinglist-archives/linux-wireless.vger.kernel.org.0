Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E225491B92
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbiARDHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 22:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiARC5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425FC06136C;
        Mon, 17 Jan 2022 18:46:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1079AB8124F;
        Tue, 18 Jan 2022 02:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F6FC36AEB;
        Tue, 18 Jan 2022 02:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473972;
        bh=Y61sEYe89JMN62S2d5pSk0ZMtlqtnSfDmA0d2mMjqnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5ck87nP0dUiskW9E3YhBt1TjgGNqBNvwe3IIwCzix+9845KgGz4Hy2Sw5nA5zLNz
         Bu3CfputLZXllg1w9x+3LhJZ71htFDRsKB3teclm3+iQjMPdLfz+sVSxOfeW4RAId4
         2t6Mubm65ODjBBcz9DE+Sl75g99rTyPuoPY5d0MRSPuUYjoyaUCc+Hrs+EJgDqSeKt
         8Cewpd0FwDB6Lq41hzeRJg76D0BJtpEaZkltv/pSUDOR60NMRBi3+pCFILZIBmaDEG
         Xy6qGD/bQmvt42Zn9RotTpb8OXJqUmCSq5XDctpepkuVHe8g6OMx0sFhsPYhLCzoaT
         GzBbJrT+zxs2w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zekun Shen <bruceshenzk@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, ath9k-devel@qca.qualcomm.com,
        kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 48/73] ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream
Date:   Mon, 17 Jan 2022 21:44:07 -0500
Message-Id: <20220118024432.1952028-48-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024432.1952028-1-sashal@kernel.org>
References: <20220118024432.1952028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zekun Shen <bruceshenzk@gmail.com>

[ Upstream commit 6ce708f54cc8d73beca213cec66ede5ce100a781 ]

Large pkt_len can lead to out-out-bound memcpy. Current
ath9k_hif_usb_rx_stream allows combining the content of two urb
inputs to one pkt. The first input can indicate the size of the
pkt. Any remaining size is saved in hif_dev->rx_remain_len.
While processing the next input, memcpy is used with rx_remain_len.

4-byte pkt_len can go up to 0xffff, while a single input is 0x4000
maximum in size (MAX_RX_BUF_SIZE). Thus, the patch adds a check for
pkt_len which must not exceed 2 * MAX_RX_BUG_SIZE.

BUG: KASAN: slab-out-of-bounds in ath9k_hif_usb_rx_cb+0x490/0xed7 [ath9k_htc]
Read of size 46393 at addr ffff888018798000 by task kworker/0:1/23

CPU: 0 PID: 23 Comm: kworker/0:1 Not tainted 5.6.0 #63
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
Workqueue: events request_firmware_work_func
Call Trace:
 <IRQ>
 dump_stack+0x76/0xa0
 print_address_description.constprop.0+0x16/0x200
 ? ath9k_hif_usb_rx_cb+0x490/0xed7 [ath9k_htc]
 ? ath9k_hif_usb_rx_cb+0x490/0xed7 [ath9k_htc]
 __kasan_report.cold+0x37/0x7c
 ? ath9k_hif_usb_rx_cb+0x490/0xed7 [ath9k_htc]
 kasan_report+0xe/0x20
 check_memory_region+0x15a/0x1d0
 memcpy+0x20/0x50
 ath9k_hif_usb_rx_cb+0x490/0xed7 [ath9k_htc]
 ? hif_usb_mgmt_cb+0x2d9/0x2d9 [ath9k_htc]
 ? _raw_spin_lock_irqsave+0x7b/0xd0
 ? _raw_spin_trylock_bh+0x120/0x120
 ? __usb_unanchor_urb+0x12f/0x210
 __usb_hcd_giveback_urb+0x1e4/0x380
 usb_giveback_urb_bh+0x241/0x4f0
 ? __hrtimer_run_queues+0x316/0x740
 ? __usb_hcd_giveback_urb+0x380/0x380
 tasklet_action_common.isra.0+0x135/0x330
 __do_softirq+0x18c/0x634
 irq_exit+0x114/0x140
 smp_apic_timer_interrupt+0xde/0x380
 apic_timer_interrupt+0xf/0x20

I found the bug using a custome USBFuzz port. It's a research work
to fuzz USB stack/drivers. I modified it to fuzz ath9k driver only,
providing hand-crafted usb descriptors to QEMU.

After fixing the value of pkt_tag to ATH_USB_RX_STREAM_MODE_TAG in QEMU
emulation, I found the KASAN report. The bug is triggerable whenever
pkt_len is above two MAX_RX_BUG_SIZE. I used the same input that crashes
to test the driver works when applying the patch.

Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/YXsidrRuK6zBJicZ@10-18-43-117.dynapool.wireless.nyu.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 2ed98aaed6fb5..c8c7afe0e343e 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -590,6 +590,13 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 			return;
 		}
 
+		if (pkt_len > 2 * MAX_RX_BUF_SIZE) {
+			dev_err(&hif_dev->udev->dev,
+				"ath9k_htc: invalid pkt_len (%x)\n", pkt_len);
+			RX_STAT_INC(skb_dropped);
+			return;
+		}
+
 		pad_len = 4 - (pkt_len & 0x3);
 		if (pad_len == 4)
 			pad_len = 0;
-- 
2.34.1

