Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB5299F80
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 01:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441353AbgJ0AWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 20:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410335AbgJZXzj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE6D22384;
        Mon, 26 Oct 2020 23:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756538;
        bh=0ae7PabnxCOKNlt1cA/HXiMihXNfOWTEJTsGHrkhhTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4hTpqUyb7LLniV4lsNJtAohwEG5QaMLX1aBRolpUj5qcmVB4z1vAxQCauATqSWxb
         SX9XfvOFk09Pmjw3tOchHn6KtKnq4UnyU8Np/eqPlzgO57uY7hLDL2s2VSEqUviwjn
         pLgDRBsbY0GHiZkGLTPcFaGrgPXdRL0iNZEeAZfI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/80] ath10k: start recovery process when payload length exceeds max htc length for sdio
Date:   Mon, 26 Oct 2020 19:54:13 -0400
Message-Id: <20201026235516.1025100-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

[ Upstream commit 2fd3c8f34d08af0a6236085f9961866ad92ef9ec ]

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
will be reasonable.

This patch only effect sdio chips.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200108031957.22308-3-wgong@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 8fe626deadeb0..24b1927a07518 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -550,6 +550,10 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 				    le16_to_cpu(htc_hdr->len),
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
+
+			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_warn(ar, "exceeds length, start recovery\n");
+
 			goto err;
 		}
 
-- 
2.25.1

