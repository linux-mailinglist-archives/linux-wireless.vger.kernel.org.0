Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C5491953
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbiARCxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiARCtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:49:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FADC061762;
        Mon, 17 Jan 2022 18:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96514B81261;
        Tue, 18 Jan 2022 02:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5198C36AF2;
        Tue, 18 Jan 2022 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473701;
        bh=mMVMuisXCIt+zCi8F5XYc+fsmSAixmNaldXMRbfRe4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNczL+gIxOZj8WvuS6EdSjeA/Q74XvQCmG1KzrJjqUFEKw1CxrEraND6zGvHbmHE/
         S4/G78vAyUbHq3TOpigD6npzrT2j68kcWtPfr83tj6XRnjOoQNCRxQRaLSf7+Q9guu
         IUCxlBB/NBeUk3YKC/AXun8xEqMEuAiNEU+LTf4WcBZjpPA/vcKZDSEhD6bZdcP/so
         Ht9mZvyVzR2QDcCI0szsYz1FHCxP8P0Wfo/wB5UirH7g6zI4tX7qQBYSD3nGzj5IKR
         Dm08pj27VTSmbuQRwz9CaPrWq5vAwmv2Gr+QmQT7AzhNzxjjN2w+m18HW152T99ieC
         1vhbKw6e/0yZw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zekun Shen <bruceshenzk@gmail.com>,
        Brendan Dolan-Gavitt <brendandg@nyu.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 031/116] mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
Date:   Mon, 17 Jan 2022 21:38:42 -0500
Message-Id: <20220118024007.1950576-31-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024007.1950576-1-sashal@kernel.org>
References: <20220118024007.1950576-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zekun Shen <bruceshenzk@gmail.com>

[ Upstream commit 04d80663f67ccef893061b49ec8a42ff7045ae84 ]

Currently, with an unknown recv_type, mwifiex_usb_recv
just return -1 without restoring the skb. Next time
mwifiex_usb_rx_complete is invoked with the same skb,
calling skb_put causes skb_over_panic.

The bug is triggerable with a compromised/malfunctioning
usb device. After applying the patch, skb_over_panic
no longer shows up with the same input.

Attached is the panic report from fuzzing.
skbuff: skb_over_panic: text:000000003bf1b5fa
 len:2048 put:4 head:00000000dd6a115b data:000000000a9445d8
 tail:0x844 end:0x840 dev:<NULL>
kernel BUG at net/core/skbuff.c:109!
invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 PID: 198 Comm: in:imklog Not tainted 5.6.0 #60
RIP: 0010:skb_panic+0x15f/0x161
Call Trace:
 <IRQ>
 ? mwifiex_usb_rx_complete+0x26b/0xfcd [mwifiex_usb]
 skb_put.cold+0x24/0x24
 mwifiex_usb_rx_complete+0x26b/0xfcd [mwifiex_usb]
 __usb_hcd_giveback_urb+0x1e4/0x380
 usb_giveback_urb_bh+0x241/0x4f0
 ? __hrtimer_run_queues+0x316/0x740
 ? __usb_hcd_giveback_urb+0x380/0x380
 tasklet_action_common.isra.0+0x135/0x330
 __do_softirq+0x18c/0x634
 irq_exit+0x114/0x140
 smp_apic_timer_interrupt+0xde/0x380
 apic_timer_interrupt+0xf/0x20
 </IRQ>

Reported-by: Brendan Dolan-Gavitt <brendandg@nyu.edu>
Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/YX4CqjfRcTa6bVL+@Zekuns-MBP-16.fios-router.home
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 9736aa0ab7fd4..8f01fcbe93961 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -130,7 +130,8 @@ static int mwifiex_usb_recv(struct mwifiex_adapter *adapter,
 		default:
 			mwifiex_dbg(adapter, ERROR,
 				    "unknown recv_type %#x\n", recv_type);
-			return -1;
+			ret = -1;
+			goto exit_restore_skb;
 		}
 		break;
 	case MWIFIEX_USB_EP_DATA:
-- 
2.34.1

