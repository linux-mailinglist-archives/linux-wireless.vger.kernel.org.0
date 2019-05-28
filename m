Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A868B2BD36
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfE1C1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 22:27:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfE1C1T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 22:27:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8600E609F3; Tue, 28 May 2019 02:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559010438;
        bh=y9wrH93AEtY/dSSBGwE2/AeQp/kcOUnUyK/HjZpO2TQ=;
        h=From:To:Cc:Subject:Date:From;
        b=L2PsX31e3C6cZzjQO/Hd82mhgxrkyYAKS0Hb4gcHCXV2Wg2O0qn/TF4CrWAhDAugy
         4bqmQnDiSEEgc3KIBCtu/ImuzXy32peYKPR5EwLqbr8iBpQ0qr3zho0J6XnXBsM4Z/
         0//ltIQvS3w3CBeKrsNr+j4qzFeB1marjLygTr+A=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48D88602F2;
        Tue, 28 May 2019 02:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559010438;
        bh=y9wrH93AEtY/dSSBGwE2/AeQp/kcOUnUyK/HjZpO2TQ=;
        h=From:To:Cc:Subject:Date:From;
        b=L2PsX31e3C6cZzjQO/Hd82mhgxrkyYAKS0Hb4gcHCXV2Wg2O0qn/TF4CrWAhDAugy
         4bqmQnDiSEEgc3KIBCtu/ImuzXy32peYKPR5EwLqbr8iBpQ0qr3zho0J6XnXBsM4Z/
         0//ltIQvS3w3CBeKrsNr+j4qzFeB1marjLygTr+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48D88602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add report MIC error for sdio chip
Date:   Tue, 28 May 2019 10:27:12 +0800
Message-Id: <1559010432-1005-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware will report flag with HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR
if MIC error, the flag will be used in mac80211.

ieee80211_rx_h_michael_mic_verify will check the flag and start TKIP
countermeasures.

Now countermeasure tests pass both with WPA only and WPA2/WPA mixed
mode.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index a20ea27..c0b0061 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2101,7 +2101,9 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 			    num_mpdu_ranges);
 
 	if (mpdu_ranges->mpdu_range_status !=
-	    HTT_RX_IND_MPDU_STATUS_OK) {
+	    HTT_RX_IND_MPDU_STATUS_OK &&
+	    mpdu_ranges->mpdu_range_status !=
+	    HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR) {
 		ath10k_warn(ar, "MPDU range status: %d\n",
 			    mpdu_ranges->mpdu_range_status);
 		goto err;
@@ -2162,6 +2164,9 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 				   RX_FLAG_MMIC_STRIPPED;
 	}
 
+	if (mpdu_ranges->mpdu_range_status == HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR)
+		rx_status->flag |= RX_FLAG_MMIC_ERROR;
+
 	ieee80211_rx_ni(ar->hw, skb);
 
 	/* We have delivered the skb to the upper layers (mac80211) so we
-- 
1.9.1

