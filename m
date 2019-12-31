Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84712D765
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLaJ1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 04:27:22 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:14945 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfLaJ1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 04:27:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577784441; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=tW8Kr4b49G8QQb0Dc+pICMwIFXSYwKADVDgcVJxqh2k=; b=I5QjrFsDO2Ta7ldF70Zd62zRIUX8XC/jnGw1zBHnQLk4+xXjC9qi4otErJ9UZNajMoOyx7os
 YlZzOr7NgqxVNQdM9974XwkCSKCQGCcr3EuLQd6XfyOwrFJ5yKUrHx6Ar42dDWI/rED1rXAx
 AaoEQX+L4OY030aaEo+cPTRspDk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b1473.7f132e3cd8b8-smtp-out-n01;
 Tue, 31 Dec 2019 09:27:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D51EAC4479C; Tue, 31 Dec 2019 09:27:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95A06C43383;
        Tue, 31 Dec 2019 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95A06C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath10k: drop RX skb with invalid length for sdio
Date:   Tue, 31 Dec 2019 17:27:06 +0800
Message-Id: <20191231092706.6136-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When simulate random transfer fail for sdio write and read, it crash
sometimes.

Test steps:
1. Add config and update kernel:
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y

2. run simulate fail:
cd /sys/kernel/debug/mmc1/fail_mmc_request
echo 10 > probability
echo 10 > times # repeat until hitting issues

3. it crash, the act len of ath10k_htc_hdr is higher than allocate len, it cause panic:
[   99.723482] skbuff: skb_over_panic: text:00000000caa0f780 len:57013 put:57013 head:000000004116f24a data:0000000019ecb4dc tail:0xdef5 end:0x640 dev:<NULL>
[   99.737697] ------------[ cut here ]------------
[   99.742327] kernel BUG at /mnt/host/source/src/third_party/kernel/v4.19/net/core/skbuff.c:104!
[   99.750937] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   99.831154] Process kworker/0:2 (pid: 151, stack limit = 0x00000000728010bf)
[   99.838200] CPU: 0 PID: 151 Comm: kworker/0:2 Tainted: G W 4.19.85 #48
[   99.846022] Hardware name: MediaTek krane sku0 board (DT)
[   99.851429] Workqueue: events sdio_irq_work
[   99.855614] pstate: 60000005 (nZCv daif -PAN -UAO)
[   99.860402] pc : skb_panic+0x64/0x68
[   99.863974] lr : skb_panic+0x64/0x68
[   99.867542] sp : ffffff8008833a90
[   99.870850] x29: ffffff8008833ac0 x28: ffffffe52e337370
[   99.876159] x27: ffffffe52e328a90 x26: 000000000000e0d0
[   99.881469] x25: ffffffe52e336b60 x24: 000000000000deb5
[   99.886779] x23: ffffffe52e340680 x22: ffffffe4efd47e00
[   99.892088] x21: 000000000000deb5 x20: ffffffa516d85b4c
[   99.897397] x19: ffffffa526928037 x18: 0000000000000000
[   99.902706] x17: 000000000000003c x16: ffffffa5265b6c80
[   99.908015] x15: 0000000000000006 x14: 3a76656420303436
[   99.913325] x13: 0000000000029bf0 x12: 0000000000000000
[   99.918634] x11: 0000000000000000 x10: 0000000000000000
[   99.923943] x9 : a3b907e4b2783000 x8 : a3b907e4b2783000
[   99.929253] x7 : 0000000000000000 x6 : ffffffa526f66d76
[   99.934563] x5 : 0000000000000000 x4 : 0000000000000000
[   99.939872] x3 : 000000000002a5ab x2 : ffffffe53feed918
[   99.945182] x1 : ffffffe53fee4a08 x0 : 000000000000008e
[   99.950491] Call trace:
[   99.952937]  skb_panic+0x64/0x68
[   99.956165]  skb_put+0x7c/0x84
[   99.959224]  ath10k_sdio_irq_handler+0x740/0xbb8 [ath10k_sdio]
[   99.965055]  process_sdio_pending_irqs+0x58/0x1a4
[   99.969758]  sdio_run_irqs+0x34/0x60
[   99.973329]  sdio_irq_work+0x1c/0x28
[   99.974930] cros-ec-spi spi2.0: SPI transfer timed out
[   99.976904]  process_one_work+0x210/0x410
[   99.976911]  worker_thread+0x234/0x3dc
[   99.976923]  kthread+0x120/0x130
[   99.982090] cros-ec-spi spi2.0: spi transfer failed: -110
[   99.986054]  ret_from_fork+0x10/0x18
[   99.986063] Code: aa1403e2 2a1503e4 a90023e9 97e37d1a (d4210000)
[   99.986068] ---[ end trace cb6d948c5a0fd6c7 ]---
[  100.017250] Kernel panic - not syncing: Fatal exception
[  100.018879] cros-ec-spi spi2.0: Command xfer error (err:-110)
[  100.023659] SMP: stopping secondary CPUs
[  100.023703] Kernel Offset: 0x251dc00000 from 0xffffff8008000000
[  100.023707] CPU features: 0x0,2188200c
[  100.023709] Memory Limit: none

The simulate fail of sdio is not a real sdio transter fail, it only
set an error status in mmc_should_fail_request after the transfer end,
actually the transfer is success, then sdio_io_rw_ext_helper will
return error status and stop transfer the left data. For example,
the really RX len is 286 bytes, then it will split to 2 blocks in
sdio_io_rw_ext_helper, one is 256 bytes, left is 30 bytes, if the
first 256 bytes get an error status by mmc_should_fail_request,then
the left 30 bytes will not read in this RX operation. Then when the
next RX arrive, the left 30 bytes will be considered as the header
of the read, the top 8 bytes will be considered as ath10k_htc_hdr,
but actually the 8 bytes is not the ath10k_htc_hdr, so the act_len
from this ath10k_htc_hdr is not correct, if it is a big value, such
as 57013, it will trigger skb_panic.

Drop the skb with invalid length will be reasonable.

This patch only effect sdio chips.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change to drop the skb for invalid length.
 drivers/net/wireless/ath/ath10k/sdio.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 7b894dcaad2e..a94237ccf1be 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -642,16 +642,23 @@ static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
 
 	ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
 				 skb->data, pkt->alloc_len);
-
-	if (ret) {
-		ar_sdio->n_rx_pkts = 0;
-		ath10k_sdio_mbox_free_rx_pkt(pkt);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	htc_hdr = (struct ath10k_htc_hdr *)skb->data;
 	pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
+
+	if (pkt->act_len > pkt->alloc_len) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	skb_put(skb, pkt->act_len);
+	return 0;
+
+err:
+	ar_sdio->n_rx_pkts = 0;
+	ath10k_sdio_mbox_free_rx_pkt(pkt);
 
 	return ret;
 }
@@ -687,6 +694,11 @@ static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
 		htc_hdr = (struct ath10k_htc_hdr *)(ar_sdio->vsg_buffer + pkt_offset);
 		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
 
+		if (pkt->act_len > pkt->alloc_len ) {
+			ret = -EINVAL;
+			goto err;
+		}
+
 		skb_put_data(pkt->skb, htc_hdr, pkt->act_len);
 		pkt_offset += pkt->alloc_len;
 	}
-- 
2.23.0
