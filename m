Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5375A6E2203
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNL0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNL0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 07:26:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0FB759
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 04:26:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EAuWev024850;
        Fri, 14 Apr 2023 11:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ZouQOujp0D4IqMyqlFDg4S49LRS3FeD3GosaN+Gmfik=;
 b=mI55EdaCleurUlXiKu4fDL69EA+Y+mz/0q2irVlJaPe70yJ/zGvx+lMHZ5MxJTeGaJOQ
 f3hqRVynkBqXAeD8LTvRBo6gs/z4Dzk7y9YsYwbx8i0Gq9agrU8Q/t4hHkEpJv1Dxil3
 sRpAAlBFwVfIG3IwcgMaJUN1zrEIGG/yANewk33aKihOAGuSMXGlzR+X3mvOQqk41kwc
 piw8t8s5yOJIpbrYm2NA2QmzxOIUEGaFngrBLIxWbpJdlBaSntWxnDjfFP7em/c+rEE2
 D9gsHqLHrmpgxOMJv4GniFhnRWRWLMdFqY7eUI3rTdrr8Pd6X+D9Tysq95mfSrSbxRqP AQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxdtek4c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:26:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EBQMZU002440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:26:22 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 04:26:19 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: Add rx histogram stats
Date:   Fri, 14 Apr 2023 16:56:03 +0530
Message-ID: <20230414112603.601199-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uitpGD2G3fPcXZY-kt9RxpztBta_ATUm
X-Proofpoint-GUID: uitpGD2G3fPcXZY-kt9RxpztBta_ATUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140103
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add peer specific debugfs support to store and
display peer rx stats info like HE, VHT, HT,
legacy and NSS.
Also, add a debugfs knob to reset rx stats
specific to the peer.

This helps  to debug the throughput related
issues in the UL traffic(STA to AP) by getting
the segregated rx_stats info like HE, VHT, HT etc,.

There is no addition of new debugfs_file here to get
these segregated stats. The exising rx_stats is enhanced
to get these stats.

Usage:

To print rx stats:
echo 1 > /sys/kernel/debug/ieee80211/phyX/ath11k/ext_rx_stats
cat /sys/kernel/debug/ieee80211/phyX/netdev\:wlanX/stations/
        <peer_mac>/rx_stats

To reset rx stats:
echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev\:wlanX/stations/
        <peer_mac>/reset_rx_stats

Output:

RX peer stats:
Num of MSDUs: 116
Num of MSDUs with TCP L4: 0
Num of MSDUs with UDP L4: 0
Num of MSDUs part of AMPDU: 0
Num of MSDUs not part of AMPDU: 116
Num of MSDUs using STBC: 0
Num of MSDUs beamformed: 0
Num of MPDUs with FCS ok: 116
Num of MPDUs with FCS error: 0
BCC 5 LDPC 111
preamble: 11A 5 11B 0 11N 0 11AC 111 11AX 0
reception type: SU 116 MU_MIMO 0 MU_OFDMA 0 MU_OFDMA_MIMO 0
TID(0-15) Legacy TID(16):0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5
RX Duration:6459

RX success packet stats:

HE packet stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0

VHT packet stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 111
MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0

HT packet stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0

Legacy rate packet stats:
1Mbps: 0        2Mbps: 0        5.5Mbps: 0      6Mbps: 5
9Mbps: 0        11Mbps: 0       12Mbps: 0       18Mbps: 0
18Mbps: 0       24Mbps: 0       36Mbps: 0       48Mbps: 0

NSS packet stats:
1x1: 5 2x2: 0 3x3: 111 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0

GI: 0.8us 5 0.4us 111 1.6us 0 3.2us 0
BW: 20Mhz 5 40Mhz 0 80Mhz 111 160Mhz 0

Rate Table (packets):
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0             111               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0

RX success byte stats:

HE byte stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0

VHT byte stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 12742
MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0

HT byte stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0

Legacy rate byte stats:
1Mbps: 0        2Mbps: 0        5.5Mbps: 0      6Mbps: 346
9Mbps: 0        11Mbps: 0       12Mbps: 0       18Mbps: 0
18Mbps: 0       24Mbps: 0       36Mbps: 0       48Mbps: 0

NSS byte stats:
1x1: 346 2x2: 0 3x3: 12742 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0

GI: 0.8us 346 0.4us 12742 1.6us 0 3.2us 0
BW: 20Mhz 346 40Mhz 0 80Mhz 12742 160Mhz 0

Rate Table (bytes):
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0           12742               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0
         0               0               0               0               0               0               0               0

DCM: 0
RU: 26: 117 52: 0 106: 0 242: 0 484: 0 996: 0

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Signed-off-by: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---

v2:
* Addressed Kalle's comment on mailing list of patchset v1.
 Now we have sent this patch v2 to correct mailing list.

 drivers/net/wireless/ath/ath11k/core.h        |  28 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 247 ++++++++++++++++--
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  91 ++++++-
 drivers/net/wireless/ath/ath11k/dp_rx.h       |  22 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c      |  78 ++++--
 drivers/net/wireless/ath/ath11k/hal_rx.h      |  22 ++
 drivers/net/wireless/ath/ath11k/hw.c          |  16 ++
 drivers/net/wireless/ath/ath11k/hw.h          |   1 +
 8 files changed, 446 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0830276e5028..d62ad2c66fee 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -51,6 +51,17 @@
 /* The magic used by QCA spec */
 #define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
 
+#define RATE_TABLE_INDEX_N_AC(mcs_idx, nss_idx, bw_idx, gi_idx) \
+			     (((mcs_idx) * 8) + ((nss_idx) * 80) + ((bw_idx) * 2) + (gi_idx))
+#define RATE_TABLE_INDEX_AX(mcs_idx, nss_idx, bw_idx, gi_idx) \
+			   (((mcs_idx) * 12) + ((nss_idx) * 144) + ((bw_idx) * 3) + (gi_idx))
+
+/* rx rate table size up to 11ac (RATE_TABLE_INDEX_N_AC(max_mcs,max_nss,max_bw,max_gi) + 1) */
+#define ATH11K_RX_RATE_TABLE_NUM 320
+
+/* rx rate table size up to 11ax (RATE_TABLE_INDEX_AX(mcs_idx, nss_idx, bw_idx, gi_idx) +1) */
+#define ATH11K_RX_RATE_TABLE_11AX_NUM 576
+
 extern unsigned int ath11k_frame_mode;
 
 #define ATH11K_SCAN_TIMEOUT_HZ (20 * HZ)
@@ -374,6 +385,17 @@ struct ath11k_vif_iter {
 	struct ath11k_vif *arvif;
 };
 
+struct ath11k_rx_peer_rate_stats {
+	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT];
+	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT];
+	u64 he_mcs_count[HAL_RX_MAX_MCS_HE];
+	u64 nss_count[HAL_RX_MAX_NSS];
+	u64 bw_count[HAL_RX_BW_MAX];
+	u64 gi_count[HAL_RX_GI_MAX];
+	u64 legacy_count[HAL_RX_MAX_NUM_LEGACY_RATES];
+	u64 rx_rate[ATH11K_RX_RATE_TABLE_11AX_NUM];
+};
+
 struct ath11k_rx_peer_stats {
 	u64 num_msdu;
 	u64 num_mpdu_fcs_ok;
@@ -385,10 +407,6 @@ struct ath11k_rx_peer_stats {
 	u64 non_ampdu_msdu_count;
 	u64 stbc_count;
 	u64 beamformed_count;
-	u64 mcs_count[HAL_RX_MAX_MCS + 1];
-	u64 nss_count[HAL_RX_MAX_NSS];
-	u64 bw_count[HAL_RX_BW_MAX];
-	u64 gi_count[HAL_RX_GI_MAX];
 	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
 	u64 tid_count[IEEE80211_NUM_TIDS + 1];
 	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
@@ -396,6 +414,8 @@ struct ath11k_rx_peer_stats {
 	u64 rx_duration;
 	u64 dcm_count;
 	u64 ru_alloc_cnt[HAL_RX_RU_ALLOC_TYPE_MAX];
+	struct ath11k_rx_peer_rate_stats pkt_stats;
+	struct ath11k_rx_peer_rate_stats byte_stats;
 };
 
 #define ATH11K_HE_MCS_NUM       12
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 9cc4ef28e751..83824b094d9d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -10,6 +10,7 @@
 #include "peer.h"
 #include "debug.h"
 #include "dp_tx.h"
+#include "dp_rx.h"
 #include "debugfs_htt_stats.h"
 
 void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
@@ -238,6 +239,40 @@ static const struct file_operations fops_tx_stats = {
 	.llseek = default_llseek,
 };
 
+const char *legacy_rate_str(int legacy_rate_idx)
+{
+	switch (legacy_rate_idx) {
+	case 0:
+		return "1Mbps";
+	case 1:
+		return "2Mbps";
+	case 2:
+		return "5.5Mbps";
+	case 3:
+		return "6Mbps";
+	case 4:
+		return "9Mbps";
+	case 5:
+		return "11Mbps";
+	case 6:
+		return "12Mbps";
+	case 7:
+		return "18Mbps";
+	case 8:
+		return "18Mbps";
+	case 9:
+		return "24Mbps";
+	case 10:
+		return "36Mbps";
+	case 11:
+		return "48Mbps";
+	case 12:
+		return "54Mbps";
+	default:
+		return "invalid legacy rate index";
+	}
+}
+
 static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 					    char __user *user_buf,
 					    size_t count, loff_t *ppos)
@@ -247,8 +282,12 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 	struct ath11k *ar = arsta->arvif->ar;
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
 	int len = 0, i, retval = 0;
-	const int size = 4096;
+	int size;
 	char *buf;
+	int he_rates_avail;
+	int rate_table_len;
+
+	size = ATH11K_HTT_STATS_BUF_SIZE;
 
 	if (!rx_stats)
 		return -ENOENT;
@@ -257,6 +296,16 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
+	if (rx_stats->pream_cnt[HAL_RX_PREAMBLE_11AX] > 1)
+		he_rates_avail = 1;
+	else
+		he_rates_avail = 0;
+
+	if (he_rates_avail)
+		rate_table_len = ATH11K_RX_RATE_TABLE_11AX_NUM;
+	else
+		rate_table_len = ATH11K_RX_RATE_TABLE_NUM;
+
 	mutex_lock(&ar->conf_mutex);
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -279,14 +328,6 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 			 rx_stats->num_mpdu_fcs_ok);
 	len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS error: %llu\n",
 			 rx_stats->num_mpdu_fcs_err);
-	len += scnprintf(buf + len, size - len,
-			 "GI: 0.8us %llu 0.4us %llu 1.6us %llu 3.2us %llu\n",
-			 rx_stats->gi_count[0], rx_stats->gi_count[1],
-			 rx_stats->gi_count[2], rx_stats->gi_count[3]);
-	len += scnprintf(buf + len, size - len,
-			 "BW: 20Mhz %llu 40Mhz %llu 80Mhz %llu 160Mhz %llu\n",
-			 rx_stats->bw_count[0], rx_stats->bw_count[1],
-			 rx_stats->bw_count[2], rx_stats->bw_count[3]);
 	len += scnprintf(buf + len, size - len, "BCC %llu LDPC %llu\n",
 			 rx_stats->coding_count[0], rx_stats->coding_count[1]);
 	len += scnprintf(buf + len, size - len,
@@ -301,16 +342,149 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 	len += scnprintf(buf + len, size - len, "TID(0-15) Legacy TID(16):");
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
 		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->tid_count[i]);
-	len += scnprintf(buf + len, size - len, "\nMCS(0-11) Legacy MCS(12):");
-	for (i = 0; i < HAL_RX_MAX_MCS + 1; i++)
-		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->mcs_count[i]);
-	len += scnprintf(buf + len, size - len, "\nNSS(1-8):");
-	for (i = 0; i < HAL_RX_MAX_NSS; i++)
-		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->nss_count[i]);
-	len += scnprintf(buf + len, size - len, "\nRX Duration:%llu ",
+	len += scnprintf(buf + len, size - len, "\nRX Duration:%llu\n",
 			 rx_stats->rx_duration);
+
+	len += scnprintf(buf + len, size - len, "\nRX success packet stats:\n");
+	len += scnprintf(buf + len, size - len, "\nHE packet stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_HE; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->pkt_stats.he_mcs_count[i]);
+		if ((i + 1) % 6)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nVHT packet stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_VHT; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->pkt_stats.vht_mcs_count[i]);
+		if ((i + 1) % 5)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nHT packet stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_HT; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->pkt_stats.ht_mcs_count[i]);
+		if ((i + 1) % 8)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nLegacy rate packet stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NUM_LEGACY_RATES; i++) {
+		len += scnprintf(buf + len, size - len, "%s: %llu", legacy_rate_str(i),
+				 rx_stats->pkt_stats.legacy_count[i]);
+		if ((i + 1) % 4)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nNSS packet stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NSS; i++)
+		len += scnprintf(buf + len, size - len, "%dx%d: %llu ", i + 1, i + 1,
+				 rx_stats->pkt_stats.nss_count[i]);
+	len += scnprintf(buf + len, size - len,
+			 "\n\nGI: 0.8us %llu 0.4us %llu 1.6us %llu 3.2us %llu\n",
+			 rx_stats->pkt_stats.gi_count[0],
+			 rx_stats->pkt_stats.gi_count[1],
+			 rx_stats->pkt_stats.gi_count[2],
+			 rx_stats->pkt_stats.gi_count[3]);
+	len += scnprintf(buf + len, size - len,
+			 "BW: 20Mhz %llu 40Mhz %llu 80Mhz %llu 160Mhz %llu\n",
+			 rx_stats->pkt_stats.bw_count[0],
+			 rx_stats->pkt_stats.bw_count[1],
+			 rx_stats->pkt_stats.bw_count[2],
+			 rx_stats->pkt_stats.bw_count[3]);
+	len += scnprintf(buf + len, size - len, "\nRate Table (packets):\n");
+	for (i = 0; i < rate_table_len; i++) {
+		len += scnprintf(buf + len, size - len, "%10llu",
+				 rx_stats->pkt_stats.rx_rate[i]);
+		if (he_rates_avail) {
+			if ((i + 1) % 12)
+				len += scnprintf(buf + len, size - len, "%s", "\t");
+			else
+				len += scnprintf(buf + len, size - len, "%s", "\n");
+		} else {
+			if ((i + 1) % 8)
+				len += scnprintf(buf + len, size - len, "%s", "\t");
+			else
+				len += scnprintf(buf + len, size - len, "%s", "\n");
+		}
+	}
+	len += scnprintf(buf + len, size - len, "\nRX success byte stats:\n");
+	len += scnprintf(buf + len, size - len, "\nHE byte stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_HE; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->byte_stats.he_mcs_count[i]);
+		if ((i + 1) % 6)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nVHT byte stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_VHT; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->byte_stats.vht_mcs_count[i]);
+		if ((i + 1) % 5)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nHT byte stats:\n");
+	for (i = 0; i < HAL_RX_MAX_MCS_HT; i++) {
+		len += scnprintf(buf + len, size - len, "MCS %d: %llu", i,
+				 rx_stats->byte_stats.ht_mcs_count[i]);
+		if ((i + 1) % 8)
+			len += scnprintf(buf + len, size - len, "%s", "\t");
+		else
+			len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nLegacy rate byte stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NUM_LEGACY_RATES; i++) {
+		len += scnprintf(buf + len, size - len, "%s: %llu", legacy_rate_str(i),
+				 rx_stats->byte_stats.legacy_count[i]);
+	if ((i + 1) % 4)
+		len += scnprintf(buf + len, size - len, "%s", "\t");
+	else
+		len += scnprintf(buf + len, size - len, "%s", "\n");
+	}
+	len += scnprintf(buf + len, size - len, "\nNSS byte stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NSS; i++)
+		len += scnprintf(buf + len, size - len, "%dx%d: %llu ", i + 1, i + 1,
+				 rx_stats->byte_stats.nss_count[i]);
+	len += scnprintf(buf + len, size - len,
+			 "\n\nGI: 0.8us %llu 0.4us %llu 1.6us %llu 3.2us %llu\n",
+			 rx_stats->byte_stats.gi_count[0],
+			 rx_stats->byte_stats.gi_count[1],
+			 rx_stats->byte_stats.gi_count[2],
+			 rx_stats->byte_stats.gi_count[3]);
 	len += scnprintf(buf + len, size - len,
-			 "\nDCM: %llu\nRU: 26 %llu 52: %llu 106: %llu 242: %llu 484: %llu 996: %llu\n",
+			 "BW: 20Mhz %llu 40Mhz %llu 80Mhz %llu 160Mhz %llu\n",
+			 rx_stats->byte_stats.bw_count[0],
+			 rx_stats->byte_stats.bw_count[1],
+			 rx_stats->byte_stats.bw_count[2],
+			 rx_stats->byte_stats.bw_count[3]);
+	len += scnprintf(buf + len, size - len, "\nRate Table (bytes):\n");
+	for (i = 0; i < rate_table_len; i++) {
+		len += scnprintf(buf + len, size - len, "%10llu",
+				 rx_stats->byte_stats.rx_rate[i]);
+		if (he_rates_avail) {
+			if ((i + 1) % 12)
+				len += scnprintf(buf + len, size - len, "%s", "\t");
+			else
+				len += scnprintf(buf + len, size - len, "%s", "\n");
+		} else {
+			if ((i + 1) % 8)
+				len += scnprintf(buf + len, size - len, "%s", "\t");
+			else
+				len += scnprintf(buf + len, size - len, "%s", "\n");
+		}
+	}
+	len += scnprintf(buf + len, size - len,
+			 "\nDCM: %llu\nRU: 26: %llu 52: %llu 106: %llu 242: %llu 484: %llu 996: %llu\n",
 			 rx_stats->dcm_count, rx_stats->ru_alloc_cnt[0],
 			 rx_stats->ru_alloc_cnt[1], rx_stats->ru_alloc_cnt[2],
 			 rx_stats->ru_alloc_cnt[3], rx_stats->ru_alloc_cnt[4],
@@ -744,6 +918,40 @@ ath11k_write_htt_peer_stats_reset(struct file *file,
 	return ret;
 }
 
+static ssize_t ath11k_dbg_sta_reset_rx_stats(struct file *file,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	int ret, reset;
+
+	if (!arsta->rx_stats)
+		return -ENOENT;
+
+	ret = kstrtoint_from_user(buf, count, 0, &reset);
+	if (ret)
+		return ret;
+
+	if (!reset || reset > 1)
+		return -EINVAL;
+
+	spin_lock_bh(&ar->ab->base_lock);
+	memset(arsta->rx_stats, 0, sizeof(*arsta->rx_stats));
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	ret = count;
+	return ret;
+}
+
+static const struct file_operations fops_reset_rx_stats = {
+	.write = ath11k_dbg_sta_reset_rx_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static const struct file_operations fops_htt_peer_stats_reset = {
 	.write = ath11k_write_htt_peer_stats_reset,
 	.open = simple_open,
@@ -855,9 +1063,12 @@ void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vi
 	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
 		debugfs_create_file("tx_stats", 0400, dir, sta,
 				    &fops_tx_stats);
-	if (ath11k_debugfs_is_extd_rx_stats_enabled(ar))
+	if (ath11k_debugfs_is_extd_rx_stats_enabled(ar)) {
 		debugfs_create_file("rx_stats", 0400, dir, sta,
 				    &fops_rx_stats);
+		debugfs_create_file("reset_rx_stats", 0600, dir, sta,
+				    &fops_reset_rx_stats);
+	}
 
 	debugfs_create_file("htt_peer_stats", 0400, dir, sta,
 			    &fops_htt_peer_stats);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 99859b59138e..4b1a9501f3f8 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2733,10 +2733,40 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	return total_msdu_reaped;
 }
 
+static void
+ath11k_dp_rx_update_peer_rate_table_stats(struct ath11k_rx_peer_stats *rx_stats,
+					  struct hal_rx_mon_ppdu_info *ppdu_info,
+					  u32 num_msdu)
+{
+	u32 rate_idx = 0;
+	u32 mcs_idx = ppdu_info->mcs;
+	u32 nss_idx = ppdu_info->nss - 1;
+	u32 bw_idx = ppdu_info->bw;
+	u32 gi_idx = ppdu_info->gi;
+
+	if (mcs_idx > HAL_RX_MAX_MCS_HE || nss_idx >= HAL_RX_MAX_NSS ||
+	    bw_idx >= HAL_RX_BW_MAX || gi_idx >= HAL_RX_GI_MAX)
+		return;
+
+	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11N ||
+	    ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AC) {
+		rate_idx = RATE_TABLE_INDEX_N_AC(mcs_idx, nss_idx, bw_idx, gi_idx);
+	} else if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AX) {
+		gi_idx = ath11k_he_gi_to_nl80211_he_gi(ppdu_info->gi);
+		rate_idx = RATE_TABLE_INDEX_AX(mcs_idx, nss_idx, bw_idx, gi_idx);
+	} else {
+		return;
+	}
+
+	rx_stats->pkt_stats.rx_rate[rate_idx] += num_msdu;
+	rx_stats->byte_stats.rx_rate[rate_idx] += ppdu_info->mpdu_len;
+}
+
 static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 					   struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
+	struct ath11k *ar = arsta->arvif->ar;
 	u32 num_msdu;
 	int i;
 
@@ -2746,6 +2776,9 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	arsta->rssi_comb = ppdu_info->rssi_comb;
 	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 
+	if (!ath11k_debugfs_is_extd_rx_stats_enabled(ar))
+		return;
+
 	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
 		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
 
@@ -2762,18 +2795,6 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 		ppdu_info->tid = IEEE80211_NUM_TIDS;
 	}
 
-	if (ppdu_info->nss > 0 && ppdu_info->nss <= HAL_RX_MAX_NSS)
-		rx_stats->nss_count[ppdu_info->nss - 1] += num_msdu;
-
-	if (ppdu_info->mcs <= HAL_RX_MAX_MCS)
-		rx_stats->mcs_count[ppdu_info->mcs] += num_msdu;
-
-	if (ppdu_info->gi < HAL_RX_GI_MAX)
-		rx_stats->gi_count[ppdu_info->gi] += num_msdu;
-
-	if (ppdu_info->bw < HAL_RX_BW_MAX)
-		rx_stats->bw_count[ppdu_info->bw] += num_msdu;
-
 	if (ppdu_info->ldpc < HAL_RX_SU_MU_CODING_MAX)
 		rx_stats->coding_count[ppdu_info->ldpc] += num_msdu;
 
@@ -2802,8 +2823,6 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	rx_stats->dcm_count += ppdu_info->dcm;
 	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
 
-	arsta->rssi_comb = ppdu_info->rssi_comb;
-
 	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
 			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
 
@@ -2812,6 +2831,50 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 
 	rx_stats->rx_duration += ppdu_info->rx_duration;
 	arsta->rx_duration = rx_stats->rx_duration;
+
+	if (ppdu_info->nss > 0 && ppdu_info->nss <= HAL_RX_MAX_NSS) {
+		rx_stats->pkt_stats.nss_count[ppdu_info->nss - 1] += num_msdu;
+		rx_stats->byte_stats.nss_count[ppdu_info->nss - 1] += ppdu_info->mpdu_len;
+	}
+
+	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11N &&
+	    ppdu_info->mcs < HAL_RX_MAX_MCS_HT) {
+		rx_stats->pkt_stats.ht_mcs_count[ppdu_info->mcs] += num_msdu;
+		rx_stats->byte_stats.ht_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
+		/* To fit into rate table for HT packets */
+		ppdu_info->mcs = ppdu_info->mcs % 8;
+	}
+
+	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AC &&
+	    ppdu_info->mcs < HAL_RX_MAX_MCS_VHT) {
+		rx_stats->pkt_stats.vht_mcs_count[ppdu_info->mcs] += num_msdu;
+		rx_stats->byte_stats.vht_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
+	}
+
+	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AX &&
+	    ppdu_info->mcs < HAL_RX_MAX_MCS_HE) {
+		rx_stats->pkt_stats.he_mcs_count[ppdu_info->mcs] += num_msdu;
+		rx_stats->byte_stats.he_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
+	}
+
+	if ((ppdu_info->preamble_type == HAL_RX_PREAMBLE_11A ||
+	     ppdu_info->preamble_type == HAL_RX_PREAMBLE_11B) &&
+	     ppdu_info->rate < HAL_RX_LEGACY_RATE_INVALID) {
+		rx_stats->pkt_stats.legacy_count[ppdu_info->rate] += num_msdu;
+		rx_stats->byte_stats.legacy_count[ppdu_info->rate] += ppdu_info->mpdu_len;
+	}
+
+	if (ppdu_info->gi < HAL_RX_GI_MAX) {
+		rx_stats->pkt_stats.gi_count[ppdu_info->gi] += num_msdu;
+		rx_stats->byte_stats.gi_count[ppdu_info->gi] += ppdu_info->mpdu_len;
+	}
+
+	if (ppdu_info->bw < HAL_RX_BW_MAX) {
+		rx_stats->pkt_stats.bw_count[ppdu_info->bw] += num_msdu;
+		rx_stats->byte_stats.bw_count[ppdu_info->bw] += ppdu_info->mpdu_len;
+	}
+
+	ath11k_dp_rx_update_peer_rate_table_stats(rx_stats, ppdu_info, num_msdu);
 }
 
 static struct sk_buff *ath11k_dp_rx_alloc_mon_status_buf(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 623da3bf9dc8..eaf75c86f955 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -20,6 +20,9 @@
 #define DP_RX_MPDU_ERR_MPDU_LEN			BIT(6)
 #define DP_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
 
+/* rx histogram buf size */
+#define ATH11K_RX_HISTOGRAM_BUF_SIZE	(4 * 4096)
+
 enum dp_rx_decap_type {
 	DP_RX_DECAP_TYPE_RAW,
 	DP_RX_DECAP_TYPE_NATIVE_WIFI,
@@ -41,6 +44,25 @@ struct ath11k_dp_rfc1042_hdr {
 	__be16 snap_type;
 } __packed;
 
+static inline u32 ath11k_he_gi_to_nl80211_he_gi(u8 sgi)
+{
+	u32 ret = 0;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_HE_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_HE_GI_3_2;
+		break;
+	}
+
+	return ret;
+}
+
 int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
 			     struct ieee80211_ampdu_params *params);
 int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index b9939c5a4ecd..316a5cfb1b93 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -871,6 +871,49 @@ static u16 ath11k_hal_rx_mpduinfo_get_peerid(struct ath11k_base *ab,
 	return ab->hw_params.hw_ops->mpdu_info_get_peerid(mpdu_info);
 }
 
+static u32 ath11k_hal_rx_mpduinfo_get_mpdu_len(struct ath11k_base *ab,
+					       struct hal_rx_mpdu_info *mpdu_info)
+{
+	return ab->hw_params.hw_ops->mpdu_info_get_mpdu_len(mpdu_info);
+}
+
+static enum hal_rx_legacy_rate fw_to_legacy_rate(u8 rate)
+{
+	switch (rate) {
+	case 1:
+		return HAL_RX_LEGACY_RATE_1_MBPS;
+	case 2:
+	case 5:
+		return HAL_RX_LEGACY_RATE_2_MBPS;
+	case 3:
+	case 6:
+		return HAL_RX_LEGACY_RATE_5_5_MBPS;
+	case 4:
+	case 7:
+		return HAL_RX_LEGACY_RATE_11_MBPS;
+	case 8:
+		return HAL_RX_LEGACY_RATE_48_MBPS;
+	case 9:
+		return HAL_RX_LEGACY_RATE_24_MBPS;
+	case 10:
+		return HAL_RX_LEGACY_RATE_12_MBPS;
+	case 11:
+		return HAL_RX_LEGACY_RATE_6_MBPS;
+	case 12:
+		return HAL_RX_LEGACY_RATE_54_MBPS;
+	case 13:
+		return HAL_RX_LEGACY_RATE_36_MBPS;
+	case 14:
+		return HAL_RX_LEGACY_RATE_18_MBPS;
+	case 15:
+		return HAL_RX_LEGACY_RATE_9_MBPS;
+
+	default:
+		break;
+	}
+	return HAL_RX_LEGACY_RATE_INVALID;
+}
+
 static enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -977,44 +1020,31 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->is_stbc = FIELD_GET(HAL_RX_HT_SIG_INFO_INFO1_STBC,
 					       info1);
 		ppdu_info->ldpc = FIELD_GET(HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING, info1);
-		ppdu_info->gi = info1 & HAL_RX_HT_SIG_INFO_INFO1_GI;
-
-		switch (ppdu_info->mcs) {
-		case 0 ... 7:
-			ppdu_info->nss = 1;
-			break;
-		case 8 ... 15:
-			ppdu_info->nss = 2;
-			break;
-		case 16 ... 23:
-			ppdu_info->nss = 3;
-			break;
-		case 24 ... 31:
-			ppdu_info->nss = 4;
-			break;
-		}
-
-		if (ppdu_info->nss > 1)
-			ppdu_info->mcs = ppdu_info->mcs % 8;
 
+		ppdu_info->gi = FIELD_GET(HAL_RX_HT_SIG_INFO_INFO1_GI, info1);
+		ppdu_info->nss = (ppdu_info->mcs >> 3) + 1;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 		break;
 	}
 	case HAL_PHYRX_L_SIG_B: {
 		struct hal_rx_lsig_b_info *lsigb =
 			(struct hal_rx_lsig_b_info *)tlv_data;
+		u8 fw_rate;
 
-		ppdu_info->rate = FIELD_GET(HAL_RX_LSIG_B_INFO_INFO0_RATE,
-					    __le32_to_cpu(lsigb->info0));
+		fw_rate = FIELD_GET(HAL_RX_LSIG_B_INFO_INFO0_RATE,
+				    __le32_to_cpu(lsigb->info0));
+		ppdu_info->rate = fw_to_legacy_rate(fw_rate);
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 		break;
 	}
 	case HAL_PHYRX_L_SIG_A: {
 		struct hal_rx_lsig_a_info *lsiga =
 			(struct hal_rx_lsig_a_info *)tlv_data;
+		u8 fw_rate;
 
-		ppdu_info->rate = FIELD_GET(HAL_RX_LSIG_A_INFO_INFO0_RATE,
-					    __le32_to_cpu(lsiga->info0));
+		fw_rate = FIELD_GET(HAL_RX_LSIG_A_INFO_INFO0_RATE,
+				    __le32_to_cpu(lsiga->info0));
+		ppdu_info->rate = fw_to_legacy_rate(fw_rate);
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 		break;
 	}
@@ -1472,6 +1502,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
 		if (peer_id)
 			ppdu_info->peer_id = peer_id;
+		ppdu_info->mpdu_len +=
+			ath11k_hal_rx_mpduinfo_get_mpdu_len(ab, mpdu_info);
 		break;
 	}
 	case HAL_RXPCU_PPDU_END_INFO: {
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 47e8208b22e1..3bb426296cf3 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -19,7 +19,11 @@ struct hal_rx_wbm_rel_info {
 #define VHT_SIG_SU_NSS_MASK 0x7
 
 #define HAL_RX_MAX_MCS 12
+#define HAL_RX_MAX_MCS_HT 32
+#define HAL_RX_MAX_MCS_VHT 10
+#define HAL_RX_MAX_MCS_HE 12
 #define HAL_RX_MAX_NSS 8
+#define HAL_RX_MAX_NUM_LEGACY_RATES 12
 
 struct hal_rx_mon_status_tlv_hdr {
 	u32 hdr;
@@ -103,6 +107,22 @@ struct hal_rx_user_status {
 	u32 mpdu_err_byte_count;
 };
 
+enum hal_rx_legacy_rate {
+	HAL_RX_LEGACY_RATE_1_MBPS,
+	HAL_RX_LEGACY_RATE_2_MBPS,
+	HAL_RX_LEGACY_RATE_5_5_MBPS,
+	HAL_RX_LEGACY_RATE_6_MBPS,
+	HAL_RX_LEGACY_RATE_9_MBPS,
+	HAL_RX_LEGACY_RATE_11_MBPS,
+	HAL_RX_LEGACY_RATE_12_MBPS,
+	HAL_RX_LEGACY_RATE_18_MBPS,
+	HAL_RX_LEGACY_RATE_24_MBPS,
+	HAL_RX_LEGACY_RATE_36_MBPS,
+	HAL_RX_LEGACY_RATE_48_MBPS,
+	HAL_RX_LEGACY_RATE_54_MBPS,
+	HAL_RX_LEGACY_RATE_INVALID,
+};
+
 #define HAL_TLV_STATUS_PPDU_NOT_DONE    HAL_RX_MON_STATUS_PPDU_NOT_DONE
 #define HAL_TLV_STATUS_PPDU_DONE        HAL_RX_MON_STATUS_PPDU_DONE
 #define HAL_TLV_STATUS_BUF_DONE         HAL_RX_MON_STATUS_BUF_DONE
@@ -127,6 +147,7 @@ struct hal_rx_mon_ppdu_info {
 	u32 num_mpdu_fcs_ok;
 	u32 num_mpdu_fcs_err;
 	u32 preamble_type;
+	u32 mpdu_len;
 	u16 chan_num;
 	u16 tcp_msdu_count;
 	u16 tcp_ack_msdu_count;
@@ -402,6 +423,7 @@ struct hal_rx_phyrx_rssi_legacy_info {
 } __packed;
 
 #define HAL_RX_MPDU_INFO_INFO0_PEERID	GENMASK(31, 16)
+#define HAL_RX_MPDU_INFO_INFO1_MPDU_LEN	GENMASK(13, 0)
 #define HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855	GENMASK(15, 0)
 #define HAL_RX_MPDU_INFO_INFO1_MPDU_LEN		GENMASK(13, 0)
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 6b4355a68e26..7bbe7dadc5ab 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -867,6 +867,20 @@ ath11k_hw_wcn6855_mpdu_info_get_peerid(struct hal_rx_mpdu_info *mpdu_info)
 	return peer_id;
 }
 
+static u32
+ath11k_hw_ipq8074_mpdu_info_get_mpdu_len(struct hal_rx_mpdu_info *mpdu_info)
+{
+	return FIELD_GET(HAL_RX_MPDU_INFO_INFO1_MPDU_LEN,
+			 __le32_to_cpu(mpdu_info->u.ipq8074.info1));
+}
+
+static u32
+ath11k_hw_qcn9074_mpdu_info_get_mpdu_len(struct hal_rx_mpdu_info *mpdu_info)
+{
+	return FIELD_GET(HAL_RX_MPDU_INFO_INFO1_MPDU_LEN,
+			 __le32_to_cpu(mpdu_info->u.qcn9074.info1));
+}
+
 static bool ath11k_hw_wcn6855_rx_desc_get_ldpc_support(struct hal_rx_desc *desc)
 {
 	return FIELD_GET(RX_MSDU_START_INFO2_LDPC,
@@ -935,6 +949,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
 	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
+	.mpdu_info_get_mpdu_len = ath11k_hw_ipq8074_mpdu_info_get_mpdu_len,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -1132,6 +1147,7 @@ const struct ath11k_hw_ops wcn6750_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_wcn6855_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.mpdu_info_get_mpdu_len = ath11k_hw_qcn9074_mpdu_info_get_mpdu_len,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 	.get_ring_selector = ath11k_hw_wcn6750_get_tcl_ring_selector,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 68380f2ccab5..907d08400084 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -265,6 +265,7 @@ struct ath11k_hw_ops {
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 	void (*reo_setup)(struct ath11k_base *ab);
 	u16 (*mpdu_info_get_peerid)(struct hal_rx_mpdu_info *mpdu_info);
+	u32 (*mpdu_info_get_mpdu_len)(struct hal_rx_mpdu_info *mpdu_info);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 	u32 (*get_ring_selector)(struct sk_buff *skb);
-- 
2.25.1

