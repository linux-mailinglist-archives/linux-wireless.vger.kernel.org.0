Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E3409FB4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbhIMWeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:34:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22791 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245114AbhIMWeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:34:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572373; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OT7lG+YAywW0QxLjHxbvayV2kLN53nvLz2ZE1PbFnw8=; b=EcdYbkuhGLVpGIlBfdQXHgwkQixmDBD/w8iC8PFFOAFknFn3bvdwkI/2VsZ4mSsGZe3KPeZt
 7fTJLHJzkl1FNHHQ2lwMv632uMGRbEMSRMMxyrW2Zon9WykXoXqVbDy/wJrakmBX0YslQmp9
 NLORfwXg6E+xMDVFnRRttov74Hk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 613fd17ab585cc7d24092677 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:26
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AC05C43460; Mon, 13 Sep 2021 22:32:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D53DC43616;
        Mon, 13 Sep 2021 22:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9D53DC43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/5] ath11k: add HTT stats support for new stats
Date:   Tue, 14 Sep 2021 01:31:48 +0300
Message-Id: <20210913223148.208026-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913223148.208026-1-jouni@codeaurora.org>
References: <20210913223148.208026-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Add HTT stats support for,

29-ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS:
Used to dump the control path txrx stats for each connected peer.
Usage:
echo 29 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
cat /sys/kernel/debug/ieee80211/phyx/netdev\:wlan0/stations/
<sta mac>/htt_peer_stats.

31-ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF_STATS:
Used to dump the per pdev tx rate txbf stats.
Usage:
echo 31 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats

32-ATH11k_DBG_HTT_EXT_STATS_TXBF_OFDMA:
Used to dump the TXBF ofdma stats for all ofdma users.
Usage:
echo 32 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats

37-ATH11K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS:
Used to dump the mac and phy txrx counts and phy stats like per chain rssi
and ANI level.
Usage:
echo 37 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00486-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs.h     |   4 +
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 368 +++++++++++++++++-
 .../wireless/ath/ath11k/debugfs_htt_stats.h   | 172 ++++++++
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |   8 +-
 4 files changed, 548 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 7b9c5e465208..f719f5d6b2ee 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -38,6 +38,10 @@ enum ath11k_dbg_htt_ext_stats_type {
 	ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO           =  22,
 	ATH11K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	    =  23,
 	ATH11K_DBG_HTT_EXT_STATS_RING_BACKPRESSURE_STATS    =  24,
+	ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS  =  29,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF_STATS    =  31,
+	ATH11K_DBG_HTT_EXT_STATS_TXBF_OFDMA		    =  32,
+	ATH11K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	    =  37,
 
 	/* keep this last */
 	ATH11K_DBG_HTT_NUM_EXT_STATS,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 9efce25a067e..4484235bcda4 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -3639,6 +3639,334 @@ static inline void htt_print_backpressure_stats_tlv_v(const u32 *tag_buf,
 	}
 }
 
+static inline
+void htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_txrate_txbf_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PDEV_TX_RATE_TXBF_STATS:\n");
+
+	len += scnprintf(buf + len, buf_len - len, "tx_ol_mcs = ");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ol_mcs[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_ibf_mcs = ");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ibf_mcs[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_txbf_mcs =");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_txbf_mcs[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_ol_nss = ");
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ol_nss[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_ibf_nss = ");
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ibf_nss[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_txbf_nss = ");
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_txbf_nss[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_ol_bw = ");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ol_bw[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_ibf_bw = ");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_ibf_bw[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\ntx_txbf_bw = ");
+	for (i = 0; i < HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "%d:%u,", i, htt_stats_buf->tx_su_txbf_bw[i]);
+	len--;
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_txbf_ofdma_ndpa_stats_tlv(const void *tag_buf,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_txbf_ofdma_ndpa_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_NDPA_STATS_TLV:\n");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndpa_queued_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndpa_queued[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndpa_tried_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndpa_tried[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndpa_flushed_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndpa_flushed[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndpa_err_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndpa_err[i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_txbf_ofdma_ndp_stats_tlv(const void *tag_buf,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_txbf_ofdma_ndp_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_NDP_STATS_TLV:\n");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndp_queued_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndp_queued[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndp_tried_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndp_tried[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndp_flushed_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndp_flushed[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_ndp_err_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_ndp_err[i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_txbf_ofdma_brp_stats_tlv(const void *tag_buf,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_txbf_ofdma_brp_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_BRP_STATS_TLV:\n");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_brpoll_queued_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_brpoll_queued[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_brpoll_tried_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_brpoll_tried[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_brpoll_flushed_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_brpoll_flushed[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_brp_err_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_brp_err[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_brp_err_num_cbf_rcvd_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_brp_err_num_cbf_rcvd[i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_txbf_ofdma_steer_stats_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_txbf_ofdma_steer_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_STEER_STATS_TLV:\n");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_num_ppdu_steer_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_num_ppdu_steer[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_num_ppdu_ol_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_num_ppdu_ol[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_num_usrs_prefetch_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_num_usrs_prefetch[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_num_usrs_sound_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_num_usrs_sound[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_num_usrs_force_sound_user%d = %u\n",
+				 i, htt_stats_buf->ax_ofdma_num_usrs_force_sound[i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_phy_counters_tlv(const void *tag_buf,
+				struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_phy_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_COUNTERS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rx_ofdma_timing_err_cnt = %u\n",
+			 htt_stats_buf->rx_ofdma_timing_err_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_cck_fail_cnt = %u\n",
+			 htt_stats_buf->rx_cck_fail_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mactx_abort_cnt = %u\n",
+			 htt_stats_buf->mactx_abort_cnt);
+	len += scnprintf(buf + len, buf_len - len, "macrx_abort_cnt = %u\n",
+			 htt_stats_buf->macrx_abort_cnt);
+	len += scnprintf(buf + len, buf_len - len, "phytx_abort_cnt = %u\n",
+			 htt_stats_buf->phytx_abort_cnt);
+	len += scnprintf(buf + len, buf_len - len, "phyrx_abort_cnt = %u\n",
+			 htt_stats_buf->phyrx_abort_cnt);
+	len += scnprintf(buf + len, buf_len - len, "phyrx_defer_abort_cnt = %u\n",
+			 htt_stats_buf->phyrx_defer_abort_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_adj_lstf_event_cnt = %u\n",
+			 htt_stats_buf->rx_gain_adj_lstf_event_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_adj_non_legacy_cnt = %u\n",
+			 htt_stats_buf->rx_gain_adj_non_legacy_cnt);
+
+	for (i = 0; i < HTT_MAX_RX_PKT_CNT; i++)
+		len += scnprintf(buf + len, buf_len - len, "rx_pkt_cnt[%d] = %u\n",
+				 i, htt_stats_buf->rx_pkt_cnt[i]);
+
+	for (i = 0; i < HTT_MAX_RX_PKT_CRC_PASS_CNT; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_pkt_crc_pass_cnt[%d] = %u\n",
+				 i, htt_stats_buf->rx_pkt_crc_pass_cnt[i]);
+
+	for (i = 0; i < HTT_MAX_PER_BLK_ERR_CNT; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "per_blk_err_cnt[%d] = %u\n",
+				 i, htt_stats_buf->per_blk_err_cnt[i]);
+
+	for (i = 0; i < HTT_MAX_RX_OTA_ERR_CNT; i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ota_err_cnt[%d] = %u\n",
+				 i, htt_stats_buf->rx_ota_err_cnt[i]);
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_phy_stats_tlv(const void *tag_buf,
+			     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_phy_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_STATS_TLV:\n");
+
+	for (i = 0; i < HTT_STATS_MAX_CHAINS; i++)
+		len += scnprintf(buf + len, buf_len - len, "nf_chain[%d] = %d\n",
+				 i, htt_stats_buf->nf_chain[i]);
+
+	len += scnprintf(buf + len, buf_len - len, "false_radar_cnt = %u\n",
+			 htt_stats_buf->false_radar_cnt);
+	len += scnprintf(buf + len, buf_len - len, "radar_cs_cnt = %u\n",
+			 htt_stats_buf->radar_cs_cnt);
+	len += scnprintf(buf + len, buf_len - len, "ani_level = %d\n",
+			 htt_stats_buf->ani_level);
+	len += scnprintf(buf + len, buf_len - len, "fw_run_time = %u\n",
+			 htt_stats_buf->fw_run_time);
+
+	stats_req->buf_len = len;
+}
+
+static inline
+void htt_print_peer_ctrl_path_txrx_stats_tlv(const void *tag_buf,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_peer_ctrl_path_txrx_stats_tlv *htt_stat_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	int i;
+	const char *mgmt_frm_type[ATH11K_STATS_MGMT_FRM_TYPE_MAX - 1] = {
+		"assoc_req", "assoc_resp",
+		"reassoc_req", "reassoc_resp",
+		"probe_req", "probe_resp",
+		"timing_advertisement", "reserved",
+		"beacon", "atim", "disassoc",
+		"auth", "deauth", "action", "action_no_ack"};
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG:\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "peer_mac_addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
+			 htt_stat_buf->peer_mac_addr[0], htt_stat_buf->peer_mac_addr[1],
+			 htt_stat_buf->peer_mac_addr[2], htt_stat_buf->peer_mac_addr[3],
+			 htt_stat_buf->peer_mac_addr[4], htt_stat_buf->peer_mac_addr[5]);
+
+	len += scnprintf(buf + len, buf_len - len, "peer_tx_mgmt_subtype:\n");
+	for (i = 0; i < ATH11K_STATS_MGMT_FRM_TYPE_MAX - 1; i++)
+		len += scnprintf(buf + len, buf_len - len, "%s:%u\n",
+				 mgmt_frm_type[i],
+				 htt_stat_buf->peer_rx_mgmt_subtype[i]);
+
+	len += scnprintf(buf + len, buf_len - len, "peer_rx_mgmt_subtype:\n");
+	for (i = 0; i < ATH11K_STATS_MGMT_FRM_TYPE_MAX - 1; i++)
+		len += scnprintf(buf + len, buf_len - len, "%s:%u\n",
+				 mgmt_frm_type[i],
+				 htt_stat_buf->peer_rx_mgmt_subtype[i]);
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -3990,6 +4318,30 @@ static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 	case HTT_STATS_RING_BACKPRESSURE_STATS_TAG:
 		htt_print_backpressure_stats_tlv_v(tag_buf, user_data);
 		break;
+	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
+		htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_NDPA_STATS_TAG:
+		htt_print_txbf_ofdma_ndpa_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_NDP_STATS_TAG:
+		htt_print_txbf_ofdma_ndp_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_BRP_STATS_TAG:
+		htt_print_txbf_ofdma_brp_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_STEER_STATS_TAG:
+		htt_print_txbf_ofdma_steer_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_PHY_COUNTERS_TAG:
+		htt_print_phy_counters_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_PHY_STATS_TAG:
+		htt_print_phy_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG:
+		htt_print_peer_ctrl_path_txrx_stats_tlv(tag_buf, stats_req);
+		break;
 	default:
 		break;
 	}
@@ -4077,8 +4429,7 @@ static ssize_t ath11k_write_htt_stats_type(struct file *file,
 	if (type >= ATH11K_DBG_HTT_NUM_EXT_STATS)
 		return -E2BIG;
 
-	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET ||
-	    type == ATH11K_DBG_HTT_EXT_STATS_PEER_INFO)
+	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET)
 		return -EPERM;
 
 	ar->debug.htt_stats.type = type;
@@ -4139,6 +4490,15 @@ static int ath11k_prep_htt_stats_cfg_params(struct ath11k *ar, u8 type,
 	case ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO:
 		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS;
 		break;
+	case ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS:
+		cfg_params->cfg0 = HTT_STAT_PEER_INFO_MAC_ADDR;
+		cfg_params->cfg1 |= FIELD_PREP(GENMASK(7, 0), mac_addr[0]);
+		cfg_params->cfg1 |= FIELD_PREP(GENMASK(15, 8), mac_addr[1]);
+		cfg_params->cfg1 |= FIELD_PREP(GENMASK(23, 16), mac_addr[2]);
+		cfg_params->cfg1 |= FIELD_PREP(GENMASK(31, 24), mac_addr[3]);
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(7, 0), mac_addr[4]);
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(15, 8), mac_addr[5]);
+		break;
 	default:
 		break;
 	}
@@ -4196,7 +4556,9 @@ static int ath11k_open_htt_stats(struct inode *inode, struct file *file)
 	u8 type = ar->debug.htt_stats.type;
 	int ret;
 
-	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET)
+	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET ||
+	    type == ATH11K_DBG_HTT_EXT_STATS_PEER_INFO ||
+	    type == ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS)
 		return -EPERM;
 
 	mutex_lock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index 95ab8505ae5f..dc210c54d131 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -102,6 +102,14 @@ enum htt_tlv_tag_t {
 	HTT_STATS_PDEV_OBSS_PD_TAG                          = 88,
 	HTT_STATS_HW_WAR_TAG				    = 89,
 	HTT_STATS_RING_BACKPRESSURE_STATS_TAG		    = 90,
+	HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG		    = 101,
+	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		    = 108,
+	HTT_STATS_TXBF_OFDMA_NDPA_STATS_TAG		    = 113,
+	HTT_STATS_TXBF_OFDMA_NDP_STATS_TAG		    = 114,
+	HTT_STATS_TXBF_OFDMA_BRP_STATS_TAG		    = 115,
+	HTT_STATS_TXBF_OFDMA_STEER_STATS_TAG		    = 116,
+	HTT_STATS_PHY_COUNTERS_TAG			    = 121,
+	HTT_STATS_PHY_STATS_TAG				    = 122,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1750,6 +1758,170 @@ struct htt_ring_backpressure_stats_tlv {
 	u32 backpressure_hist[5];
 };
 
+#define HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS 14
+#define HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS 5
+#define HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS 8
+
+struct htt_pdev_txrate_txbf_stats_tlv {
+	/* SU TxBF TX MCS stats */
+	u32 tx_su_txbf_mcs[HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS];
+	/* Implicit BF TX MCS stats */
+	u32 tx_su_ibf_mcs[HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS];
+	/* Open loop TX MCS stats */
+	u32 tx_su_ol_mcs[HTT_TX_TXBF_RATE_STATS_NUM_MCS_COUNTERS];
+	/* SU TxBF TX NSS stats */
+	u32 tx_su_txbf_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	/* Implicit BF TX NSS stats */
+	u32 tx_su_ibf_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	/* Open loop TX NSS stats */
+	u32 tx_su_ol_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	/* SU TxBF TX BW stats */
+	u32 tx_su_txbf_bw[HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS];
+	/* Implicit BF TX BW stats */
+	u32 tx_su_ibf_bw[HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS];
+	/* Open loop TX BW stats */
+	u32 tx_su_ol_bw[HTT_TX_TXBF_RATE_STATS_NUM_BW_COUNTERS];
+};
+
+struct htt_txbf_ofdma_ndpa_stats_tlv {
+	/* 11AX HE OFDMA NDPA frame queued to the HW */
+	u32 ax_ofdma_ndpa_queued[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame sent over the air */
+	u32 ax_ofdma_ndpa_tried[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame flushed by HW */
+	u32 ax_ofdma_ndpa_flushed[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame completed with error(s) */
+	u32 ax_ofdma_ndpa_err[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+};
+
+struct htt_txbf_ofdma_ndp_stats_tlv {
+	/* 11AX HE OFDMA NDP frame queued to the HW */
+	u32 ax_ofdma_ndp_queued[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame sent over the air */
+	u32 ax_ofdma_ndp_tried[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame flushed by HW */
+	u32 ax_ofdma_ndp_flushed[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA NDPA frame completed with error(s) */
+	u32 ax_ofdma_ndp_err[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+};
+
+struct htt_txbf_ofdma_brp_stats_tlv {
+	/* 11AX HE OFDMA MU BRPOLL frame queued to the HW */
+	u32 ax_ofdma_brpoll_queued[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA MU BRPOLL frame sent over the air */
+	u32 ax_ofdma_brpoll_tried[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA MU BRPOLL frame flushed by HW */
+	u32 ax_ofdma_brpoll_flushed[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA MU BRPOLL frame completed with error(s) */
+	u32 ax_ofdma_brp_err[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* Number of CBF(s) received when 11AX HE OFDMA MU BRPOLL frame
+	 * completed with error(s).
+	 */
+	u32 ax_ofdma_brp_err_num_cbf_rcvd[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS + 1];
+};
+
+struct htt_txbf_ofdma_steer_stats_tlv {
+	/* 11AX HE OFDMA PPDUs that were sent over the air with steering (TXBF + OFDMA) */
+	u32 ax_ofdma_num_ppdu_steer[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA PPDUs that were sent over the air in open loop */
+	u32 ax_ofdma_num_ppdu_ol[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA number of users for which CBF prefetch was
+	 * initiated to PHY HW during TX.
+	 */
+	u32 ax_ofdma_num_usrs_prefetch[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA number of users for which sounding was initiated during TX */
+	u32 ax_ofdma_num_usrs_sound[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+	/* 11AX HE OFDMA number of users for which sounding was forced during TX */
+	u32 ax_ofdma_num_usrs_force_sound[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+};
+
+#define HTT_MAX_RX_PKT_CNT 8
+#define HTT_MAX_RX_PKT_CRC_PASS_CNT 8
+#define HTT_MAX_PER_BLK_ERR_CNT 20
+#define HTT_MAX_RX_OTA_ERR_CNT 14
+#define HTT_STATS_MAX_CHAINS 8
+#define ATH11K_STATS_MGMT_FRM_TYPE_MAX 16
+
+struct htt_phy_counters_tlv {
+	/* number of RXTD OFDMA OTA error counts except power surge and drop */
+	u32 rx_ofdma_timing_err_cnt;
+	/* rx_cck_fail_cnt:
+	 * number of cck error counts due to rx reception failure because of
+	 * timing error in cck
+	 */
+	u32 rx_cck_fail_cnt;
+	/* number of times tx abort initiated by mac */
+	u32 mactx_abort_cnt;
+	/* number of times rx abort initiated by mac */
+	u32 macrx_abort_cnt;
+	/* number of times tx abort initiated by phy */
+	u32 phytx_abort_cnt;
+	/* number of times rx abort initiated by phy */
+	u32 phyrx_abort_cnt;
+	/* number of rx defered count initiated by phy */
+	u32 phyrx_defer_abort_cnt;
+	/* number of sizing events generated at LSTF */
+	u32 rx_gain_adj_lstf_event_cnt;
+	/* number of sizing events generated at non-legacy LTF */
+	u32 rx_gain_adj_non_legacy_cnt;
+	/* rx_pkt_cnt -
+	 * Received EOP (end-of-packet) count per packet type;
+	 * [0] = 11a; [1] = 11b; [2] = 11n; [3] = 11ac; [4] = 11ax; [5] = GF
+	 * [6-7]=RSVD
+	 */
+	u32 rx_pkt_cnt[HTT_MAX_RX_PKT_CNT];
+	/* rx_pkt_crc_pass_cnt -
+	 * Received EOP (end-of-packet) count per packet type;
+	 * [0] = 11a; [1] = 11b; [2] = 11n; [3] = 11ac; [4] = 11ax; [5] = GF
+	 * [6-7]=RSVD
+	 */
+	u32 rx_pkt_crc_pass_cnt[HTT_MAX_RX_PKT_CRC_PASS_CNT];
+	/* per_blk_err_cnt -
+	 * Error count per error source;
+	 * [0] = unknown; [1] = LSIG; [2] = HTSIG; [3] = VHTSIG; [4] = HESIG;
+	 * [5] = RXTD_OTA; [6] = RXTD_FATAL; [7] = DEMF; [8] = ROBE;
+	 * [9] = PMI; [10] = TXFD; [11] = TXTD; [12] = PHYRF
+	 * [13-19]=RSVD
+	 */
+	u32 per_blk_err_cnt[HTT_MAX_PER_BLK_ERR_CNT];
+	/* rx_ota_err_cnt -
+	 * RXTD OTA (over-the-air) error count per error reason;
+	 * [0] = voting fail; [1] = weak det fail; [2] = strong sig fail;
+	 * [3] = cck fail; [4] = power surge; [5] = power drop;
+	 * [6] = btcf timing timeout error; [7] = btcf packet detect error;
+	 * [8] = coarse timing timeout error
+	 * [9-13]=RSVD
+	 */
+	u32 rx_ota_err_cnt[HTT_MAX_RX_OTA_ERR_CNT];
+};
+
+struct htt_phy_stats_tlv {
+	/* per chain hw noise floor values in dBm */
+	s32 nf_chain[HTT_STATS_MAX_CHAINS];
+	/* number of false radars detected */
+	u32 false_radar_cnt;
+	/* number of channel switches happened due to radar detection */
+	u32 radar_cs_cnt;
+	/* ani_level -
+	 * ANI level (noise interference) corresponds to the channel
+	 * the desense levels range from -5 to 15 in dB units,
+	 * higher values indicating more noise interference.
+	 */
+	s32 ani_level;
+	/* running time in minutes since FW boot */
+	u32 fw_run_time;
+};
+
+struct htt_peer_ctrl_path_txrx_stats_tlv {
+	/* peer mac address */
+	u8 peer_mac_addr[ETH_ALEN];
+	u8 rsvd[2];
+	/* Num of tx mgmt frames with subtype on peer level */
+	u32 peer_tx_mgmt_subtype[ATH11K_STATS_MGMT_FRM_TYPE_MAX];
+	/* Num of rx mgmt frames with subtype on peer level */
+	u32 peer_rx_mgmt_subtype[ATH11K_STATS_MGMT_FRM_TYPE_MAX];
+};
+
 #ifdef CONFIG_ATH11K_DEBUGFS
 
 void ath11k_debugfs_htt_stats_init(struct ath11k *ar);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 270c0edbb10f..fecd9718f5ce 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -419,15 +419,21 @@ ath11k_dbg_sta_open_htt_peer_stats(struct inode *inode, struct file *file)
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
 	struct ath11k *ar = arsta->arvif->ar;
 	struct debug_htt_stats_req *stats_req;
+	int type = ar->debug.htt_stats.type;
 	int ret;
 
+	if ((type != ATH11K_DBG_HTT_EXT_STATS_PEER_INFO &&
+	     type != ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS) ||
+	    type == ATH11K_DBG_HTT_EXT_STATS_RESET)
+		return -EPERM;
+
 	stats_req = vzalloc(sizeof(*stats_req) + ATH11K_HTT_STATS_BUF_SIZE);
 	if (!stats_req)
 		return -ENOMEM;
 
 	mutex_lock(&ar->conf_mutex);
 	ar->debug.htt_stats.stats_req = stats_req;
-	stats_req->type = ATH11K_DBG_HTT_EXT_STATS_PEER_INFO;
+	stats_req->type = type;
 	memcpy(stats_req->peer_addr, sta->addr, ETH_ALEN);
 	ret = ath11k_debugfs_htt_stats_req(ar);
 	mutex_unlock(&ar->conf_mutex);
-- 
2.25.1

