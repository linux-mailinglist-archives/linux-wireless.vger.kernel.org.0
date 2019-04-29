Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACB4E123
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfD2LRZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 07:17:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LRY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 07:17:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54174608D4; Mon, 29 Apr 2019 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556536644;
        bh=G7qmYnFyZ7SZtqYRxNkY37C+3IDBvulY8cS6uCDp7X8=;
        h=From:To:Cc:Subject:Date:From;
        b=LjWWUe+NxkWXukKecssUaZxI1bTiKPZ2cjdcPHWGksuURQpIZAXlLKADUxPJmRn8L
         IJIiW5IelK+m9Z+oBceNkQW69fsCXwa/nXYX933GgHd9FG/xRqvKdo8fk3OqNKcGLq
         s1PI36vwbbLWsuOO4kXaTXcyyAKCTYggVQmicexI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 139B960863;
        Mon, 29 Apr 2019 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556536644;
        bh=G7qmYnFyZ7SZtqYRxNkY37C+3IDBvulY8cS6uCDp7X8=;
        h=From:To:Cc:Subject:Date:From;
        b=LjWWUe+NxkWXukKecssUaZxI1bTiKPZ2cjdcPHWGksuURQpIZAXlLKADUxPJmRn8L
         IJIiW5IelK+m9Z+oBceNkQW69fsCXwa/nXYX933GgHd9FG/xRqvKdo8fk3OqNKcGLq
         s1PI36vwbbLWsuOO4kXaTXcyyAKCTYggVQmicexI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 139B960863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath10k: add peer id check in ath10k_peer_find_by_id
Date:   Mon, 29 Apr 2019 19:17:12 +0800
Message-Id: <1556536632-19433-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some SDIO chip, the peer id is 65535 for MPDU with error status,
then test_bit will trigger buffer overflow for peer's memory, if kasan
enabled, it will report error.

Reason is when station is in disconnecting status, firmware do not delete
the peer info since it not disconnected completely, meanwhile some AP will
still send data packet to station, then hardware will receive the packet
and send to firmware, firmware's logic will report peer id of 65535 for
MPDU with error status.

Add check for overflow the size of peer's peer_ids will avoid the buffer
overflow access.

Call trace of kasan:
dump_backtrace+0x0/0x2ec
show_stack+0x20/0x2c
__dump_stack+0x20/0x28
dump_stack+0xc8/0xec
print_address_description+0x74/0x240
kasan_report+0x250/0x26c
__asan_report_load8_noabort+0x20/0x2c
ath10k_peer_find_by_id+0x180/0x1e4 [ath10k_core]
ath10k_htt_t2h_msg_handler+0x100c/0x2fd4 [ath10k_core]
ath10k_htt_htc_t2h_msg_handler+0x20/0x34 [ath10k_core]
ath10k_sdio_irq_handler+0xcc8/0x1678 [ath10k_sdio]
process_sdio_pending_irqs+0xec/0x370
sdio_run_irqs+0x68/0xe4
sdio_irq_work+0x1c/0x28
process_one_work+0x3d8/0x8b0
worker_thread+0x508/0x7cc
kthread+0x24c/0x264
ret_from_fork+0x10/0x18

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: changed from BITS_PER_BYTE to BITS_PER_TYPE
 drivers/net/wireless/ath/ath10k/txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 23606b6..3b837b8 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -157,6 +157,9 @@ struct ath10k_peer *ath10k_peer_find_by_id(struct ath10k *ar, int peer_id)
 {
 	struct ath10k_peer *peer;
 
+	if (peer_id >= BITS_PER_TYPE(peer->peer_ids))
+		return NULL;
+
 	lockdep_assert_held(&ar->data_lock);
 
 	list_for_each_entry(peer, &ar->peers, list)
-- 
1.9.1

