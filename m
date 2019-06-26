Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B04155E5F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZC3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 22:29:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZC3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 22:29:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C7A3608CE; Wed, 26 Jun 2019 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561516191;
        bh=xyfamSf7/1m5zyT/MOtwY9DG0yKj9HenxOLGrwMOsg4=;
        h=From:To:Cc:Subject:Date:From;
        b=nrBPCbQqkxdGMKys/0qh9QmNf1xJNb7BkmMdKy2OcXmvCwX3ASJV59MFnFdQP51fB
         VI88VBXi+EfpCmRyUcy49tp08bWy9l93sUNUjLd5viFK0REML21QcMt+wz+NUSTStB
         A3eZGfM0iZOQRUNejXH6TLmVgT7cCJ9hdfgYTvE0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost.localdomain (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5E8C602DC;
        Wed, 26 Jun 2019 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561516190;
        bh=xyfamSf7/1m5zyT/MOtwY9DG0yKj9HenxOLGrwMOsg4=;
        h=From:To:Cc:Subject:Date:From;
        b=Pv7RS4eB4hXiTNBBkDAq1B9ukWOZ2KlCoNTs6pNzlZQztqD3HVtncLWV0k6m6p2si
         bhE9jlPLAw1afCteWZtYrsMglKz140WZSOAWzufiew9BWFlZsaHaN8MhJmfZn39EeO
         anZX63a+vgpXgYZF0JQWxsDq7CpNUiZ2ngFsfD6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5E8C602DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: Move non-fatal warn logs to dbg level for SDIO chip
Date:   Wed, 26 Jun 2019 10:29:35 +0800
Message-Id: <1561516175-13873-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k will receive some message with invalid peer id from firmware.
reason is:
There are incoming frames to MAC hardware that NOT find relative
address search table, then peer id is invalid set by MAC hardware,
it is hardware's logic, so fix it in ath10k will be more convenient.

log:
ath10k_sdio mmc1:0001:1: Got RX ind from invalid peer: 65535

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index a20ea27..14b838f 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2082,7 +2082,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	spin_lock_bh(&ar->data_lock);
 	peer = ath10k_peer_find_by_id(ar, peer_id);
 	spin_unlock_bh(&ar->data_lock);
-	if (!peer)
+	if (!peer && peer_id != HTT_INVALID_PEERID)
 		ath10k_warn(ar, "Got RX ind from invalid peer: %u\n", peer_id);
 
 	num_mpdu_ranges = MS(__le32_to_cpu(rx->hdr.info1),
-- 
1.9.1

