Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892A51C3EC1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEDPl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 11:41:26 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58265 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgEDPl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 11:41:26 -0400
Received: from legolas.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 25687580242;
        Mon,  4 May 2020 17:41:24 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] ath11k: use cumulative survey statistics
Date:   Mon,  4 May 2020 17:41:22 +0200
Message-Id: <20200504154122.91862-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k currently reports survey results for the last interval between each
invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
can lead to unexpectedly small results, e.g. when hostapd uses survey
data and iw survey dump is invoked in parallel. Fix this by returning
cumulative results, that don't depend on the last invocation. Other
drivers, e.g. ath9k or mt76 also use this behavior.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a972377687..322ddfda5bfd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5610,16 +5610,16 @@ ath11k_pdev_bss_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 	survey = &ar->survey[idx];
 
-	survey->noise     = bss_ch_info_ev.noise_floor;
-	survey->time      = div_u64(total, cc_freq_hz);
-	survey->time_busy = div_u64(busy, cc_freq_hz);
-	survey->time_rx   = div_u64(rx_bss, cc_freq_hz);
-	survey->time_tx   = div_u64(tx, cc_freq_hz);
-	survey->filled   |= (SURVEY_INFO_NOISE_DBM |
-			     SURVEY_INFO_TIME |
-			     SURVEY_INFO_TIME_BUSY |
-			     SURVEY_INFO_TIME_RX |
-			     SURVEY_INFO_TIME_TX);
+	survey->noise      = bss_ch_info_ev.noise_floor;
+	survey->time      += div_u64(total, cc_freq_hz);
+	survey->time_busy += div_u64(busy, cc_freq_hz);
+	survey->time_rx   += div_u64(rx_bss, cc_freq_hz);
+	survey->time_tx   += div_u64(tx, cc_freq_hz);
+	survey->filled    |= (SURVEY_INFO_NOISE_DBM |
+			      SURVEY_INFO_TIME |
+			      SURVEY_INFO_TIME_BUSY |
+			      SURVEY_INFO_TIME_RX |
+			      SURVEY_INFO_TIME_TX);
 exit:
 	spin_unlock_bh(&ar->data_lock);
 	complete(&ar->bss_survey_done);
-- 
2.26.2

