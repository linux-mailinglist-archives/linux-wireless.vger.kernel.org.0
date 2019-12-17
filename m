Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550B6123249
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfLQQVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:21:46 -0500
Received: from nbd.name ([46.4.11.11]:49734 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfLQQVq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:21:46 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihFbT-0003dj-Md; Tue, 17 Dec 2019 17:21:44 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] ath11k: enable HE tlvs in ppdu stats for pktlog lite
Date:   Tue, 17 Dec 2019 17:21:40 +0100
Message-Id: <20191217162140.2102-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

This patch enables HE tlvs in ppdu stats for pktlog lite mode.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath11k/dp.h    |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 2311e08d0889..078486c32dca 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -1129,7 +1129,22 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 			    HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER |
 			    HTT_RX_FILTER_TLV_FLAGS_ATTENTION;
 	} else if (mode == ATH11K_PKTLOG_MODE_LITE) {
+		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
+							  HTT_PPDU_STATS_TAG_PKTLOG);
+		if (ret) {
+			ath11k_err(ar->ab, "failed to enable pktlog lite: %d\n", ret);
+			goto out;
+		}
+
 		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE;
+	} else {
+		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
+							  HTT_PPDU_STATS_TAG_DEFAULT);
+		if (ret) {
+			ath11k_err(ar->ab, "failed to send htt ppdu stats req: %d\n",
+				   ret);
+			goto out;
+		}
 	}
 
 	tlv_filter.rx_filter = rx_filter;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 00ce7747d595..87114082b9b6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -519,6 +519,14 @@ enum htt_ppdu_stats_tag_type {
 				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_FLUSH) \
 				   | BIT(HTT_PPDU_STATS_TAG_USR_COMMON_ARRAY))
 
+#define HTT_PPDU_STATS_TAG_PKTLOG  (BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_64) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_256) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_64) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_256) | \
+				    BIT(HTT_PPDU_STATS_TAG_INFO) | \
+				    BIT(HTT_PPDU_STATS_TAG_TX_MGMTCTRL_PAYLOAD) | \
+				    HTT_PPDU_STATS_TAG_DEFAULT)
+
 /* HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG Message
  *
  * details:
-- 
2.20.1

