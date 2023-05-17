Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FD706AB3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjEQON1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjEQONY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 10:13:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B926BA
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 07:13:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HDpmkL032382;
        Wed, 17 May 2023 14:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9gRvQO1FPvOWPsJJ065EOBHKM69TNarijBjpZF3epHk=;
 b=YYRgOwfjov1+tt3qQWJ7nJU3bK3hjm/nCxco05EUga7zMppb5v5VH2IVMkamDJ3yiQvc
 j7YST0SYhT2ATuSij7HF1tf15eaZtuTzzTxsmXJPTynaoWtxVzeC6WLfM4hw+x7on9oB
 61qBAGGgj8hzKdwZjBuTDm3vzjnKc1KS/shnnSU5F1AraHVvgaSgdGkMrW3Lxu88kzno
 FgFgR9MHocMc/ewwNB80iemMR072a8095bQEY+ZTW//8W117Pk4Sb7sE4Xgw5i8Nwu61
 REv97rLLgQuSngkhXF7lnXE7WW78p42Q6LfIlGXLRvV4EK9c/eBWH5OrahUGSo2NQ7wA Lg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmt5grwnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:13:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HED73J002225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:13:07 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 07:13:05 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Nidhi Jain <quic_nidhjain@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH] wifi: ath11k: Add HTT stats for PHY reset case
Date:   Wed, 17 May 2023 19:42:42 +0530
Message-ID: <20230517141242.2754293-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H-uF2wag_J3sB4UDKXLcxjAJy_o7wXpY
X-Proofpoint-ORIG-GUID: H-uF2wag_J3sB4UDKXLcxjAJy_o7wXpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nidhi Jain <quic_nidhjain@quicinc.com>

New HTT stats are added with stats type 37 to
provide PHY reset stats and PHY reset counter stats.

PHY reset stats are used to display the current
PHY-related operation information such as band, CCA
threshold, current operating channel etc.,

PHY reset counter stats are used to display the
PHY reset counter values like calibration counts,
temperature based recalibration counts etc.,

Usage:
echo 37 > /sys/kernel/debug/ieee80211/phyX/ath11k/htt_stats_type
cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats

Output:

HTT_PHY_RESET_STATS_TLV:
pdev_id = 0
chan_mhz = 5180
chan_band_center_freq1 = 5210
chan_band_center_freq2 = 0
chan_phy_mode = 18
chan_flags = 0x8
chan_num = 36
reset_cause = 0x50000
prev_reset_cause = 0x50000
phy_warm_reset_src = 0x0
rx_gain_tbl_mode = 0
xbar_val = 0xfac688
force_calibration = 0
phyrf_mode = 0
phy_homechan = 0
phy_tx_ch_mask = 0x3
phy_rx_ch_mask = 0x3
phybb_ini_mask = 0x5
phyrf_ini_mask = 0x0
phy_dfs_en_mask = 0x0
phy_sscan_en_mask = 0x0
phy_synth_sel_mask = 0x0
phy_adfs_freq = 0
cck_fir_settings = 0x0
phy_dyn_pri_chan = 6
cca_thresh = 0x26232020
dyn_cca_status = 0
rxdesense_thresh_hw = 0xcfe0afe
rxdesense_thresh_sw = 0xcfe0afe

HTT_PHY_RESET_COUNTERS_TLV:
pdev_id = 0
cf_active_low_fail_cnt = 0
cf_active_low_pass_cnt = 0
phy_off_through_vreg_cnt = 0
force_calibration_cnt = 0
rf_mode_switch_phy_off_cnt = 0

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nidhi Jain <quic_nidhjain@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 114 ++++++++++++++++++
 .../wireless/ath/ath11k/debugfs_htt_stats.h   |  43 +++++++
 2 files changed, 157 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index b3efca6bd7dd..0207fc4910f3 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -4011,6 +4011,114 @@ void htt_print_phy_stats_tlv(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static inline void
+htt_print_phy_reset_counters_tlv(const void *tag_buf,
+				 u16 tag_len,
+				 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_phy_reset_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_RESET_COUNTERS_TLV:\n");
+
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 htt_stats_buf->pdev_id);
+	len += scnprintf(buf + len, buf_len - len, "cf_active_low_fail_cnt = %u\n",
+			 htt_stats_buf->cf_active_low_fail_cnt);
+	len += scnprintf(buf + len, buf_len - len, "cf_active_low_pass_cnt = %u\n",
+			 htt_stats_buf->cf_active_low_pass_cnt);
+	len += scnprintf(buf + len, buf_len - len, "phy_off_through_vreg_cnt = %u\n",
+			 htt_stats_buf->phy_off_through_vreg_cnt);
+	len += scnprintf(buf + len, buf_len - len, "force_calibration_cnt = %u\n",
+			 htt_stats_buf->force_calibration_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rf_mode_switch_phy_off_cnt = %u\n",
+			 htt_stats_buf->rf_mode_switch_phy_off_cnt);
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_phy_reset_stats_tlv(const void *tag_buf,
+			      u16 tag_len,
+			      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_phy_reset_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_RESET_STATS_TLV:\n");
+
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 htt_stats_buf->pdev_id);
+	len += scnprintf(buf + len, buf_len - len, "chan_mhz = %u\n",
+			 htt_stats_buf->chan_mhz);
+	len += scnprintf(buf + len, buf_len - len, "chan_band_center_freq1 = %u\n",
+			 htt_stats_buf->chan_band_center_freq1);
+	len += scnprintf(buf + len, buf_len - len, "chan_band_center_freq2 = %u\n",
+			 htt_stats_buf->chan_band_center_freq2);
+	len += scnprintf(buf + len, buf_len - len, "chan_phy_mode = %u\n",
+			 htt_stats_buf->chan_phy_mode);
+	len += scnprintf(buf + len, buf_len - len, "chan_flags = 0x%0x\n",
+			 htt_stats_buf->chan_flags);
+	len += scnprintf(buf + len, buf_len - len, "chan_num = %u\n",
+			 htt_stats_buf->chan_num);
+	len += scnprintf(buf + len, buf_len - len, "reset_cause = 0x%0x\n",
+			 htt_stats_buf->reset_cause);
+	len += scnprintf(buf + len, buf_len - len, "prev_reset_cause = 0x%0x\n",
+			 htt_stats_buf->prev_reset_cause);
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset_src = 0x%0x\n",
+			 htt_stats_buf->phy_warm_reset_src);
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_tbl_mode = %d\n",
+			 htt_stats_buf->rx_gain_tbl_mode);
+	len += scnprintf(buf + len, buf_len - len, "xbar_val = 0x%0x\n",
+			 htt_stats_buf->xbar_val);
+	len += scnprintf(buf + len, buf_len - len, "force_calibration = %u\n",
+			 htt_stats_buf->force_calibration);
+	len += scnprintf(buf + len, buf_len - len, "phyrf_mode = %u\n",
+			 htt_stats_buf->phyrf_mode);
+	len += scnprintf(buf + len, buf_len - len, "phy_homechan = %u\n",
+			 htt_stats_buf->phy_homechan);
+	len += scnprintf(buf + len, buf_len - len, "phy_tx_ch_mask = 0x%0x\n",
+			 htt_stats_buf->phy_tx_ch_mask);
+	len += scnprintf(buf + len, buf_len - len, "phy_rx_ch_mask = 0x%0x\n",
+			 htt_stats_buf->phy_rx_ch_mask);
+	len += scnprintf(buf + len, buf_len - len, "phybb_ini_mask = 0x%0x\n",
+			 htt_stats_buf->phybb_ini_mask);
+	len += scnprintf(buf + len, buf_len - len, "phyrf_ini_mask = 0x%0x\n",
+			 htt_stats_buf->phyrf_ini_mask);
+	len += scnprintf(buf + len, buf_len - len, "phy_dfs_en_mask = 0x%0x\n",
+			 htt_stats_buf->phy_dfs_en_mask);
+	len += scnprintf(buf + len, buf_len - len, "phy_sscan_en_mask = 0x%0x\n",
+			 htt_stats_buf->phy_sscan_en_mask);
+	len += scnprintf(buf + len, buf_len - len, "phy_synth_sel_mask = 0x%0x\n",
+			 htt_stats_buf->phy_synth_sel_mask);
+	len += scnprintf(buf + len, buf_len - len, "phy_adfs_freq = %u\n",
+			 htt_stats_buf->phy_adfs_freq);
+	len += scnprintf(buf + len, buf_len - len, "cck_fir_settings = 0x%0x\n",
+			 htt_stats_buf->cck_fir_settings);
+	len += scnprintf(buf + len, buf_len - len, "phy_dyn_pri_chan = %u\n",
+			 htt_stats_buf->phy_dyn_pri_chan);
+	len += scnprintf(buf + len, buf_len - len, "cca_thresh = 0x%0x\n",
+			 htt_stats_buf->cca_thresh);
+	len += scnprintf(buf + len, buf_len - len, "dyn_cca_status = %u\n",
+			 htt_stats_buf->dyn_cca_status);
+	len += scnprintf(buf + len, buf_len - len, "rxdesense_thresh_hw = 0x%x\n",
+			 htt_stats_buf->rxdesense_thresh_hw);
+	len += scnprintf(buf + len, buf_len - len, "rxdesense_thresh_sw = 0x%x\n",
+			 htt_stats_buf->rxdesense_thresh_sw);
+
+	stats_req->buf_len = len;
+}
+
 static inline
 void htt_print_peer_ctrl_path_txrx_stats_tlv(const void *tag_buf,
 					     struct debug_htt_stats_req *stats_req)
@@ -4425,6 +4533,12 @@ static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 	case HTT_STATS_PHY_STATS_TAG:
 		htt_print_phy_stats_tlv(tag_buf, stats_req);
 		break;
+	case HTT_STATS_PHY_RESET_COUNTERS_TAG:
+		htt_print_phy_reset_counters_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PHY_RESET_STATS_TAG:
+		htt_print_phy_reset_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG:
 		htt_print_peer_ctrl_path_txrx_stats_tlv(tag_buf, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index 0bbd58a380de..96219301f05b 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -111,6 +111,8 @@ enum htt_tlv_tag_t {
 	HTT_STATS_TXBF_OFDMA_STEER_STATS_TAG		    = 116,
 	HTT_STATS_PHY_COUNTERS_TAG			    = 121,
 	HTT_STATS_PHY_STATS_TAG				    = 122,
+	HTT_STATS_PHY_RESET_COUNTERS_TAG		    = 123,
+	HTT_STATS_PHY_RESET_STATS_TAG			    = 124,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1964,6 +1966,47 @@ struct htt_phy_stats_tlv {
 	u32 fw_run_time;
 };
 
+struct htt_phy_reset_counters_tlv {
+	u32 pdev_id;
+	u32 cf_active_low_fail_cnt;
+	u32 cf_active_low_pass_cnt;
+	u32 phy_off_through_vreg_cnt;
+	u32 force_calibration_cnt;
+	u32 rf_mode_switch_phy_off_cnt;
+};
+
+struct htt_phy_reset_stats_tlv {
+	u32 pdev_id;
+	u32 chan_mhz;
+	u32 chan_band_center_freq1;
+	u32 chan_band_center_freq2;
+	u32 chan_phy_mode;
+	u32 chan_flags;
+	u32 chan_num;
+	u32 reset_cause;
+	u32 prev_reset_cause;
+	u32 phy_warm_reset_src;
+	u32 rx_gain_tbl_mode;
+	u32 xbar_val;
+	u32 force_calibration;
+	u32 phyrf_mode;
+	u32 phy_homechan;
+	u32 phy_tx_ch_mask;
+	u32 phy_rx_ch_mask;
+	u32 phybb_ini_mask;
+	u32 phyrf_ini_mask;
+	u32 phy_dfs_en_mask;
+	u32 phy_sscan_en_mask;
+	u32 phy_synth_sel_mask;
+	u32 phy_adfs_freq;
+	u32 cck_fir_settings;
+	u32 phy_dyn_pri_chan;
+	u32 cca_thresh;
+	u32 dyn_cca_status;
+	u32 rxdesense_thresh_hw;
+	u32 rxdesense_thresh_sw;
+};
+
 struct htt_peer_ctrl_path_txrx_stats_tlv {
 	/* peer mac address */
 	u8 peer_mac_addr[ETH_ALEN];
-- 
2.25.1

