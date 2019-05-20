Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8301322F73
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfETIz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:28 -0400
Received: from nbd.name ([46.4.11.11]:41466 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbfETIzW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:22 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4l-0002Y7-31; Mon, 20 May 2019 10:55:19 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 6/8] ath11k: add defines for max MCS rates per phymode
Date:   Mon, 20 May 2019 10:55:06 +0200
Message-Id: <20190520085508.5888-7-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h  | 4 ++++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a7c59ea0c228..d0d960b384e7 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -46,6 +46,10 @@ enum wme_ac {
 	WME_NUM_AC
 };
 
+#define ATH11K_HT_MCS_MAX	7
+#define ATH11K_VHT_MCS_MAX	9
+#define ATH11K_HE_MCS_MAX	11
+
 static inline enum wme_ac ath11k_tid_to_ac(u32 tid)
 {
 	return (((tid == 0) || (tid == 3)) ? WME_AC_BE :
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 62820c20f7c1..e52a54cd2b79 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1705,7 +1705,7 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, void *rx_desc,
 		break;
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
-		if (rate_mcs > 7) {
+		if (rate_mcs > ATH11K_HT_MCS_MAX) {
 			ath11k_warn(ar->ab, "Received with invalid mcs in HT mode %d\n", rate_mcs);
 			break;
 		}
@@ -1717,7 +1717,7 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, void *rx_desc,
 	case RX_MSDU_START_PKT_TYPE_11AC:
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->rate_idx = rate_mcs;
-		if (rate_mcs > 9) {
+		if (rate_mcs > ATH11K_VHT_MCS_MAX) {
 			ath11k_warn(ar->ab, "Received with invalid mcs in VHT mode %d\n", rate_mcs);
 			break;
 		}
-- 
2.20.1

