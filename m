Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851B91F2686
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 01:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgFHX0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 19:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732015AbgFHX0o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 19:26:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897742072F;
        Mon,  8 Jun 2020 23:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658803;
        bh=CW+S2I9j3FWtgNNgKAVdRFjVBnucE7ZH77BuXJM6opA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skzpsOPcskjL4emzul0v8yqnKidI+E866p7PkFvNxnioTGlcVzhif3k/jdIAkK2P/
         ejzpqCU5YqYRso10mJJmth5qIf8zHjTsdOL1MhEUMwh+lWy7gInEUzR5r++DANbhhV
         AsjLFJiEmTxKWuxiM8kuNVaIXfedI6dbN5DoVmxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/50] ath9k: Fix use-after-free Write in ath9k_htc_rx_msg
Date:   Mon,  8 Jun 2020 19:25:52 -0400
Message-Id: <20200608232640.3370262-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit e4ff08a4d727146bb6717a39a8d399d834654345 ]

Write out of slab bounds. We should check epid.

The case reported by syzbot:
https://lore.kernel.org/linux-usb/0000000000006ac55b05a1c05d72@google.com
BUG: KASAN: use-after-free in htc_process_conn_rsp
drivers/net/wireless/ath/ath9k/htc_hst.c:131 [inline]
BUG: KASAN: use-after-free in ath9k_htc_rx_msg+0xa25/0xaf0
drivers/net/wireless/ath/ath9k/htc_hst.c:443
Write of size 2 at addr ffff8881cea291f0 by task swapper/1/0

Call Trace:
 htc_process_conn_rsp drivers/net/wireless/ath/ath9k/htc_hst.c:131
[inline]
ath9k_htc_rx_msg+0xa25/0xaf0
drivers/net/wireless/ath/ath9k/htc_hst.c:443
ath9k_hif_usb_reg_in_cb+0x1ba/0x630
drivers/net/wireless/ath/ath9k/hif_usb.c:718
__usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
expire_timers kernel/time/timer.c:1449 [inline]
__run_timers kernel/time/timer.c:1773 [inline]
__run_timers kernel/time/timer.c:1740 [inline]
run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786

Reported-and-tested-by: syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200404041838.10426-4-hqjagain@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index fd85f996c554..257b6ee51e54 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -114,6 +114,9 @@ static void htc_process_conn_rsp(struct htc_target *target,
 
 	if (svc_rspmsg->status == HTC_SERVICE_SUCCESS) {
 		epid = svc_rspmsg->endpoint_id;
+		if (epid < 0 || epid >= ENDPOINT_MAX)
+			return;
+
 		service_id = be16_to_cpu(svc_rspmsg->service_id);
 		max_msglen = be16_to_cpu(svc_rspmsg->max_msg_len);
 		endpoint = &target->endpoint[epid];
-- 
2.25.1

