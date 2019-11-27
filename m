Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946B710A911
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 04:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfK0DdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 22:33:15 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:38114
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfK0DdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 22:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574825594;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=wruCPXhY6VQj0usJBvMxQ4PAP/jyoMAOrAQz3oD7BRY=;
        b=aHTnPsteA73tQ3uy+MqCSmSPF/uoIOdeQqWpBXkm14NgwqNrCj8e/Bgl2H4UBzPV
        ftQWlmuDazYRwVCk9gZZhHtwvvSZHSfPlHn48IFRtTQOV1/VBUQl17igI+Eg6zW4cDi
        D+C93voMLKfjq345NOzJ6Nszir+7PWQI8aLeStoM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574825594;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=wruCPXhY6VQj0usJBvMxQ4PAP/jyoMAOrAQz3oD7BRY=;
        b=EFEjCKIK0LZhots5Woq+HEQYCX8YN2vfmmqED2qXMV5im+GhE75hrjcQz0ame0oQ
        dKtLW89H9YIAJQI+rDlcHKpn/0NjvWfRKNesACnHJ7Oy4G53E7kDzZobzULLHie355g
        lvmZSFSaM9uerBEN+z6rfNFkpp7vBS9ktOPrai4c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B05C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: change log level for mpdu status of sdio chip
Date:   Wed, 27 Nov 2019 03:33:14 +0000
Message-ID: <0101016eaaeb8dba-59b83dae-1133-48b3-8aab-a51f765322bf-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.27-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change log level from warn to dbg level of mpdu status
of sdio chip.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 4490ffb53d24..283ffac56b1a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2203,8 +2203,8 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	    HTT_RX_IND_MPDU_STATUS_OK &&
 	    mpdu_ranges->mpdu_range_status !=
 	    HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR) {
-		ath10k_warn(ar, "MPDU range status: %d\n",
-			    mpdu_ranges->mpdu_range_status);
+		ath10k_dbg(ar, ATH10K_DBG_HTT, "htt mpdu_range_status %d\n",
+			   mpdu_ranges->mpdu_range_status);
 		goto err;
 	}
 
-- 
2.23.0

