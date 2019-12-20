Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F818127606
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLTHAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 02:00:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63913 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfLTHAk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 02:00:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576825239; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=hIDIjSSQRnwt5zNUyDEe33gHy0/s9mfSFCaV/3ewgAg=; b=gFeQft/Sp+0KhwYy7TI2/OfOuiWCHGGI5/nEClxY1hm8Z2IHSubI0281ewOZ+I/8PUjEPmO/
 mn4ZRFaNO2/UjQIRSSieYFo4ECJN+xDOCOAscSCwIOizki42yFoFE0W+vejcpsbJZ2ABt7XT
 AK/ZskFP0/tZ+ZAbG02URTwDN7o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc7192.7f53355cef80-smtp-out-n01;
 Fri, 20 Dec 2019 07:00:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59944C447A4; Fri, 20 Dec 2019 07:00:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE6D9C447A2;
        Fri, 20 Dec 2019 07:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE6D9C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: start recovery process when payload length exceeds max htc length for sdio
Date:   Fri, 20 Dec 2019 15:00:21 +0800
Message-Id: <20191220070021.12103-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When simulate random transfer fail for sdio write and read, it happened
"payload length exceeds max htc length" and recovery later sometimes.

Test steps:
1. Add config and update kernel:
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y

2. Run simulate fail:
cd /sys/kernel/debug/mmc1/fail_mmc_request
echo 10 > probability
echo 10 > times # repeat until hitting issues

3. It happened payload length exceeds max htc length.
[  199.935506] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088
....
[  264.990191] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088

4. after some time, such as 60 seconds, it start recovery which triggered
by wmi command timeout for periodic scan.
[  269.229232] ieee80211 phy0: Hardware restart was requested
[  269.734693] ath10k_sdio mmc1:0001:1: device successfully recovered

The simulate fail of sdio is not a real sdio transter fail, it only
set an error status in mmc_should_fail_request after the transfer end,
actually the transfer is success, then sdio_io_rw_ext_helper will
return error status and stop transfer the left data. For example,
the really RX len is 286 bytes, then it will split to 2 blocks in
sdio_io_rw_ext_helper, one is 256 bytes, left is 30 bytes, if the
first 256 bytes get an error status by mmc_should_fail_request,then
the left 30 bytes will not read in this RX operation. Then when the
next RX arrive, the left 30 bytes will be considered as the header
of the read, the top 4 bytes of the 30 bytes will be considered as
lookaheads, but actually the 4 bytes is not the lookaheads, so the len
from this lookaheads is not correct, it exceeds max htc length 4088
sometimes. When happened exceeds, the buffer chain is not matched between
firmware and ath10k, then it need to start recovery ASAP. Recently then
recovery will be started by wmi command timeout, but it will be long time
later, for example, it is 60+ seconds later from the periodic scan, if
it does not have periodic scan, it will be longer.

Start recovery when it happened "payload length exceeds max htc length"
will be reasonable, when it happened this, it will happened immediately
continuously after the 1st time, so it need a flag can_recovery to
prevent it queue more than one restart_work. If it has more than one
restart_work queued, the 2nd restart_work is very esay to break the
1st restart_work and lead recovery fail.

This patch only effect sdio chips.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 9 +++++++++
 drivers/net/wireless/ath/ath10k/sdio.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 7b894dcaad2e..2c07fd533c32 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -557,6 +557,13 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 				    le16_to_cpu(htc_hdr->len),
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
+
+			if (ar_sdio->can_recovery && ar->state == ATH10K_STATE_ON) {
+				ar_sdio->can_recovery = false;
+				queue_work(ar->workqueue, &ar->restart_work);
+				ath10k_warn(ar, "exceeds length, start recovery\n");
+			}
+
 			goto err;
 		}
 
@@ -1801,6 +1808,8 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
 	if (ret)
 		return ret;
 
+	ar_sdio->can_recovery = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index 1c987494ad22..3f8c35aa279c 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -218,6 +218,7 @@ struct ath10k_sdio {
 	spinlock_t wr_async_lock;
 
 	struct work_struct async_work_rx;
+	bool can_recovery;
 };
 
 static inline struct ath10k_sdio *ath10k_sdio_priv(struct ath10k *ar)
-- 
2.23.0
