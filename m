Return-Path: <linux-wireless+bounces-16784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F299FBFFC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CACD7A22D5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048671D9324;
	Tue, 24 Dec 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ofupbe4P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92E1C5CC1
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056925; cv=none; b=UEeL1RlJFp+T38uTNqi1hPS6bydPWwjcU+OBlK2bUcbBK4PFPCBuz3nfsNwrPAV9NbpnDjeAQiM3jJCEUIFfsIzz1k5wgoXwYLtb4r3yiNGAr7UpI7OlJbjsABZmuCLcHdrx9oVgbzCsdr86hey0QFaDtlfTG4jf+zJPmjm+fYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056925; c=relaxed/simple;
	bh=hp8WfTQ4/CwkYFEoSqkMmMH6TkK7kMNDvGTA35dqcJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWkaTwPSTzaoH6pMQOY+TcqPJ6UMAJ7+hZ0NV+w9X33ZIYHAvvyBGVHMzfW8kypalGUycOAs0+hTa+zekgjpV7t7k2aFrBCnjmdhyktgbRMICxrZKFssfU/hnFl8xNZZiy1oEIWH0/vw3cBV4wsz/h70iIL3hdYe4Ve76pfg2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ofupbe4P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOFlOYq005448;
	Tue, 24 Dec 2024 16:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YyxogDMP5X0BV85D/sfbl5eM9CKAwkB3RxTOtG8g2Hc=; b=ofupbe4PpQBsf4dO
	GRnax5vw4u+4qztPTNQH6lnTHuzerfs48cPQXmNPsbqXtFLkQTOqh5fCoGgXpaSR
	QZoUUYY5l51qdLbQtj8x5w08jes3xEr9pVeDOrEkanOBTzUr8YCyxinhWO11LkYL
	+0ZOnfTPu3ERGln/xhruLOaLrcdeR4/liVIN+b0yLQPF3GgpmhG2FctQA89CrOYB
	XnKudwqCQIlAjGHR3iD3FIrRnN44tmuS1VfkuUerlUtfJsu9vdCrApcFQBkK7x7N
	VzeZE4axnipkZr0XsLMYNhkUvoPIipkMjGV9V3FLlGPt51zq7XN50ZDFN2At/6ub
	6L12Pw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qyv7r371-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 16:15:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOGFK5x012990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 16:15:20 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 08:15:18 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Subject: [PATCH v2 10/10] wifi: ath12k: Add peer extended Rx statistics debugfs support
Date: Tue, 24 Dec 2024 21:44:42 +0530
Message-ID: <20241224161442.263729-11-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224161442.263729-1-quic_periyasa@quicinc.com>
References: <20241224161442.263729-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3HGWz2gRM_Km1aKes8AhaI2NQLjdsXjs
X-Proofpoint-ORIG-GUID: 3HGWz2gRM_Km1aKes8AhaI2NQLjdsXjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240140

Currently, peer extended Rx statistics are not supported. Therefore, expose
peer extended Rx statistics support through debugfs, allowing users to
enable or disable the collection of statistics information. After that
the statistics information can be dumped through debugfs. Below are the
debugfs commands exposed.

Enable/Disable:
 echo <1/0> > /sys/kernel/debug/ieee80211/phyX/ath12k/ext_rx_stats

Dump:
 cat /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/<peer MAC addr>/rx_stats

Sample output:
==============
RX peer stats:

Num of MSDUs: 1087
Num of MSDUs with TCP L4: 0
Num of MSDUs with UDP L4: 13
Num of other MSDUs: 1074
Num of MSDUs part of AMPDU: 363
Num of MSDUs not part of AMPDU: 724
Num of MSDUs using STBC: 0
Num of MSDUs beamformed: 0
Num of MPDUs with FCS ok: 695
Num of MPDUs with FCS error: 0
preamble: 11A 395 11B 0 11N 0 11AC 0 11AX 692 11BE 0
reception type: SU 1087 MU_MIMO 0 MU_OFDMA 0 MU_OFDMA_MIMO 0
TID(0-15) Legacy TID(16):690 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 395
RX Duration:39537

DCM: 0
RU26:  0
RU52:  0
RU106: 0
RU242: 0
RU484: 0
RU996: 0

RX success packet stats:

EHT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0

HE stats:
MCS 0: 1        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
MCS 6: 66       MCS 7: 46       MCS 8: 46       MCS 9: 34       MCS 10: 28      MCS 11: 471

VHT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0
MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0

HT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0

Legacy stats:
1 Mbps: 0       2 Mbps: 0       5.5 Mbps: 0     6 Mbps: 395
9 Mbps: 0       11 Mbps: 0      12 Mbps: 0      18 Mbps: 0
24 Mbps: 0      36 Mbps: 0      48 Mbps: 0      54 Mbps: 0

NSS stats:
1x1: 1086 2x2: 0 3x3: 0 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0

GI: 0.8 us 0 0.4 us 396 1.6 us 691 3.2 us 0
BW: 20 MHz 785 40 MHz 2 80 MHz 300 160 MHz 0 320 MHz 0

20 Mhz gi 1 us 1x1 :  6:5 7:3 8:3 9:4 10:4 11:374 12:391
40 Mhz gi 1 us 1x1 :  12:2
80 Mhz gi 1 us 1x1 :  6:61 7:43 8:43 9:30 10:24 11:97 12:2

RX success byte stats:

EHT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0

HE stats:
MCS 0: 41       MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
MCS 6: 1435     MCS 7: 943      MCS 8: 697      MCS 9: 533      MCS 10: 492     MCS 11: 8159

VHT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0
MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0

HT stats:
MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0

Legacy stats:
1 Mbps: 0       2 Mbps: 0       5.5 Mbps: 0     6 Mbps: 16195
9 Mbps: 0       11 Mbps: 0      12 Mbps: 0      18 Mbps: 0
24 Mbps: 0      36 Mbps: 0      48 Mbps: 0      54 Mbps: 0

NSS stats:
1x1: 28454 2x2: 0 3x3: 0 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0

GI: 0.8 us 0 0.4 us 16236 1.6 us 12259 3.2 us 0
BW: 20 MHz 24108 40 MHz 82 80 MHz 4305 160 MHz 0 320 MHz 0

20 Mhz gi 1 us 1x1 :  6:205 7:123 8:123 9:164 10:164 11:7257 12:16031
40 Mhz gi 1 us 1x1 :  12:82
80 Mhz gi 1 us 1x1 :  6:1230 7:820 8:574 9:369 10:328 11:902 12:82

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |   2 +-
 drivers/net/wireless/ath/ath12k/core.h        |   1 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |  93 +++++
 drivers/net/wireless/ath/ath12k/debugfs.h     |   9 +
 drivers/net/wireless/ath/ath12k/debugfs_sta.c | 336 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs_sta.h |  24 ++
 drivers/net/wireless/ath/ath12k/mac.c         |  11 +-
 drivers/net/wireless/ath/ath12k/mac.h         |   4 +-
 8 files changed, 475 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index b5bb3e2599cd..8fd5ac5e1bce 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -23,7 +23,7 @@ ath12k-y += core.o \
 	    fw.o \
 	    p2p.o
 
-ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o
+ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 ath12k-$(CONFIG_PM) += wow.o
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 5b4ac0568a00..3e67cd00abf8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -559,6 +559,7 @@ struct ath12k_debug {
 	struct dentry *debugfs_pdev;
 	struct dentry *debugfs_pdev_symlink;
 	struct ath12k_dbg_htt_stats htt_stats;
+	bool extd_rx_stats;
 };
 
 struct ath12k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d4b32d1a431c..af2619db1039 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -5,6 +5,8 @@
  */
 
 #include "core.h"
+#include "dp_tx.h"
+#include "debug.h"
 #include "debugfs.h"
 #include "debugfs_htt_stats.h"
 
@@ -31,6 +33,93 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath12k_write_extd_rx_stats(struct file *file,
+					  const char __user *ubuf,
+					  size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	u32 ring_id, rx_filter = 0;
+	bool enable;
+	int ret, i;
+
+	if (kstrtobool_from_user(ubuf, count, &enable))
+		return -EINVAL;
+
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (ar->ah->state != ATH12K_HW_STATE_ON) {
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	if (enable == ar->debug.extd_rx_stats) {
+		ret = count;
+		goto exit;
+	}
+
+	if (enable) {
+		rx_filter =  HTT_RX_FILTER_TLV_FLAGS_MPDU_START;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_START;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO;
+
+		tlv_filter.rx_filter = rx_filter;
+		tlv_filter.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0;
+		tlv_filter.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1;
+		tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2;
+		tlv_filter.pkt_filter_flags3 = HTT_RX_FP_CTRL_FILTER_FLASG3 |
+			HTT_RX_FP_DATA_FILTER_FLASG3;
+	} else {
+		tlv_filter = ath12k_mac_mon_status_filter_default;
+	}
+
+	tlv_filter.offset_valid = false;
+
+	for (i = 0; i < ar->ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = ar->dp.rxdma_mon_dst_ring[i].ring_id;
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id + i,
+						       HAL_RXDMA_MONITOR_DST,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
+			goto exit;
+		}
+	}
+
+	ar->debug.extd_rx_stats = !!enable;
+	ret = count;
+exit:
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
+	return ret;
+}
+
+static ssize_t ath12k_read_extd_rx_stats(struct file *file,
+					 char __user *ubuf,
+					 size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	char buf[32];
+	int len = 0;
+
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
+	len = scnprintf(buf, sizeof(buf) - len, "%d\n",
+			ar->debug.extd_rx_stats);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_extd_rx_stats = {
+	.read = ath12k_read_extd_rx_stats,
+	.write = ath12k_write_extd_rx_stats,
+	.open = simple_open,
+};
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
@@ -92,6 +181,10 @@ void ath12k_debugfs_register(struct ath12k *ar)
 	}
 
 	ath12k_debugfs_htt_stats_register(ar);
+
+	debugfs_create_file("ext_rx_stats", 0644,
+			    ar->debug.debugfs_pdev, ar,
+			    &fops_extd_rx_stats);
 }
 
 void ath12k_debugfs_unregister(struct ath12k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..1db3e59fba71 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -12,6 +12,11 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
+
+static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
+{
+	return ar->debug.extd_rx_stats;
+}
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -29,6 +34,10 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
 {
 }
 
+static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
+{
+	return false;
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.c b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
new file mode 100644
index 000000000000..4292aacf4960
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+
+#include "debugfs_sta.h"
+#include "core.h"
+#include "peer.h"
+#include "debug.h"
+#include "debugfs_htt_stats.h"
+#include "debugfs.h"
+
+static
+u32 ath12k_dbg_sta_dump_rate_stats(u8 *buf, u32 offset, const int size,
+				   bool he_rates_avail,
+				   const struct ath12k_rx_peer_rate_stats *stats)
+{
+	static const char *legacy_rate_str[HAL_RX_MAX_NUM_LEGACY_RATES] = {
+					"1 Mbps", "2 Mbps", "5.5 Mbps", "6 Mbps",
+					"9 Mbps", "11 Mbps", "12 Mbps", "18 Mbps",
+					"24 Mbps", "36 Mbps", "48 Mbps", "54 Mbps"};
+	int mcs = 0, bw = 0, nss = 0, gi = 0, bw_num = 0;
+	u32 i, len = offset;
+	bool found;
+
+	len += scnprintf(buf + len, size - len, "\nEHT stats:\n");
+	for (i = 0; i <= HAL_RX_MAX_MCS_BE; i++)
+		len += scnprintf(buf + len, size - len,
+				   "MCS %d: %llu%s", i, stats->be_mcs_count[i],
+				   (i + 1) % 8 ? "\t" : "\n");
+
+	len += scnprintf(buf + len, size - len, "\nHE stats:\n");
+	for (i = 0; i <= HAL_RX_MAX_MCS_HE; i++)
+		len += scnprintf(buf + len, size - len,
+				   "MCS %d: %llu%s", i, stats->he_mcs_count[i],
+				   (i + 1) % 6 ? "\t" : "\n");
+
+	len += scnprintf(buf + len, size - len, "\nVHT stats:\n");
+	for (i = 0; i <= HAL_RX_MAX_MCS_VHT; i++)
+		len += scnprintf(buf + len, size - len,
+				   "MCS %d: %llu%s", i, stats->vht_mcs_count[i],
+				   (i + 1) % 5 ? "\t" : "\n");
+
+	len += scnprintf(buf + len, size - len, "\nHT stats:\n");
+	for (i = 0; i <= HAL_RX_MAX_MCS_HT; i++)
+		len += scnprintf(buf + len, size - len,
+				   "MCS %d: %llu%s", i, stats->ht_mcs_count[i],
+				   (i + 1) % 8 ? "\t" : "\n");
+
+	len += scnprintf(buf + len, size - len, "\nLegacy stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NUM_LEGACY_RATES; i++)
+		len += scnprintf(buf + len, size - len,
+				   "%s: %llu%s", legacy_rate_str[i],
+				   stats->legacy_count[i],
+				   (i + 1) % 4 ? "\t" : "\n");
+
+	len += scnprintf(buf + len, size - len, "\nNSS stats:\n");
+	for (i = 0; i < HAL_RX_MAX_NSS; i++)
+		len += scnprintf(buf + len, size - len,
+				   "%dx%d: %llu ", i + 1, i + 1,
+				   stats->nss_count[i]);
+
+	len += scnprintf(buf + len, size - len,
+			  "\n\nGI: 0.8 us %llu 0.4 us %llu 1.6 us %llu 3.2 us %llu\n",
+			  stats->gi_count[0],
+			  stats->gi_count[1],
+			  stats->gi_count[2],
+			  stats->gi_count[3]);
+
+	len += scnprintf(buf + len, size - len,
+			   "BW: 20 MHz %llu 40 MHz %llu 80 MHz %llu 160 MHz %llu 320 MHz %llu\n",
+			   stats->bw_count[0],
+			   stats->bw_count[1],
+			   stats->bw_count[2],
+			   stats->bw_count[3],
+			   stats->bw_count[4]);
+
+	for (i = 0; i < HAL_RX_BW_MAX * HAL_RX_GI_MAX * HAL_RX_MAX_NSS; i++) {
+		found = false;
+
+		for (mcs = 0; mcs <= HAL_RX_MAX_MCS_HT; mcs++) {
+			if (stats->rx_rate[bw][gi][nss][mcs]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			goto skip_report;
+
+		switch (bw) {
+		case HAL_RX_BW_20MHZ:
+			bw_num = 20;
+			break;
+		case HAL_RX_BW_40MHZ:
+			bw_num = 40;
+			break;
+		case HAL_RX_BW_80MHZ:
+			bw_num = 80;
+			break;
+		case HAL_RX_BW_160MHZ:
+			bw_num = 160;
+			break;
+		case HAL_RX_BW_320MHZ:
+			bw_num = 320;
+			break;
+		}
+
+		len += scnprintf(buf + len, size - len, "\n%d Mhz gi %d us %dx%d : ",
+				 bw_num, gi, nss + 1, nss + 1);
+
+		for (mcs = 0; mcs <= HAL_RX_MAX_MCS_HT; mcs++) {
+			if (stats->rx_rate[bw][gi][nss][mcs])
+				len += scnprintf(buf + len, size - len,
+						 " %d:%llu", mcs,
+						 stats->rx_rate[bw][gi][nss][mcs]);
+		}
+
+skip_report:
+		if (nss++ >= HAL_RX_MAX_NSS - 1) {
+			nss = 0;
+			if (gi++ >= HAL_RX_GI_MAX - 1) {
+				gi = 0;
+				if (bw < HAL_RX_BW_MAX - 1)
+					bw++;
+			}
+		}
+	}
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	return len - offset;
+}
+
+static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ieee80211_link_sta *link_sta = file->private_data;
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
+	const int size = ATH12K_STA_RX_STATS_BUF_SIZE;
+	struct ath12k_hw *ah = ahsta->ahvif->ah;
+	struct ath12k_rx_peer_stats *rx_stats;
+	struct ath12k_link_sta *arsta;
+	u8 link_id = link_sta->link_id;
+	int len = 0, i, ret = 0;
+	bool he_rates_avail;
+	struct ath12k *ar;
+
+	wiphy_lock(ah->hw->wiphy);
+
+	if (!(BIT(link_id) & ahsta->links_map)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+	if (!arsta || !arsta->arvif->ar) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ar = arsta->arvif->ar;
+
+	u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	rx_stats = arsta->rx_stats;
+	if (!rx_stats) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	len += scnprintf(buf + len, size - len, "RX peer stats:\n\n");
+	len += scnprintf(buf + len, size - len, "Num of MSDUs: %llu\n",
+			 rx_stats->num_msdu);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs with TCP L4: %llu\n",
+			 rx_stats->tcp_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs with UDP L4: %llu\n",
+			 rx_stats->udp_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of other MSDUs: %llu\n",
+			 rx_stats->other_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs part of AMPDU: %llu\n",
+			 rx_stats->ampdu_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs not part of AMPDU: %llu\n",
+			 rx_stats->non_ampdu_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs using STBC: %llu\n",
+			 rx_stats->stbc_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs beamformed: %llu\n",
+			 rx_stats->beamformed_count);
+	len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS ok: %llu\n",
+			 rx_stats->num_mpdu_fcs_ok);
+	len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS error: %llu\n",
+			 rx_stats->num_mpdu_fcs_err);
+
+	he_rates_avail = (rx_stats->pream_cnt[HAL_RX_PREAMBLE_11AX] > 1) ? true : false;
+
+	len += scnprintf(buf + len, size - len,
+			 "preamble: 11A %llu 11B %llu 11N %llu 11AC %llu 11AX %llu 11BE %llu\n",
+			 rx_stats->pream_cnt[0], rx_stats->pream_cnt[1],
+			 rx_stats->pream_cnt[2], rx_stats->pream_cnt[3],
+			 rx_stats->pream_cnt[4], rx_stats->pream_cnt[6]);
+	len += scnprintf(buf + len, size - len,
+			 "reception type: SU %llu MU_MIMO %llu MU_OFDMA %llu MU_OFDMA_MIMO %llu\n",
+			 rx_stats->reception_type[0], rx_stats->reception_type[1],
+			 rx_stats->reception_type[2], rx_stats->reception_type[3]);
+
+	len += scnprintf(buf + len, size - len, "TID(0-15) Legacy TID(16):");
+	for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
+		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->tid_count[i]);
+
+	len += scnprintf(buf + len, size - len, "\nRX Duration:%llu\n",
+			 rx_stats->rx_duration);
+
+	len += scnprintf(buf + len, size - len,
+			 "\nDCM: %llu\nRU26:  %llu\nRU52:  %llu\nRU106: %llu\nRU242: %llu\nRU484: %llu\nRU996: %llu\n",
+			 rx_stats->dcm_count, rx_stats->ru_alloc_cnt[0],
+			 rx_stats->ru_alloc_cnt[1], rx_stats->ru_alloc_cnt[2],
+			 rx_stats->ru_alloc_cnt[3], rx_stats->ru_alloc_cnt[4],
+			 rx_stats->ru_alloc_cnt[5]);
+
+	len += scnprintf(buf + len, size - len, "\nRX success packet stats:\n");
+	len += ath12k_dbg_sta_dump_rate_stats(buf, len, size, he_rates_avail,
+					      &rx_stats->pkt_stats);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	len += scnprintf(buf + len, size - len, "\nRX success byte stats:\n");
+	len += ath12k_dbg_sta_dump_rate_stats(buf, len, size, he_rates_avail,
+					      &rx_stats->byte_stats);
+
+unlock:
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	if (len)
+		ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+out:
+	wiphy_unlock(ah->hw->wiphy);
+	return ret;
+}
+
+static const struct file_operations fops_rx_stats = {
+	.read = ath12k_dbg_sta_dump_rx_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath12k_dbg_sta_reset_rx_stats(struct file *file,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	struct ieee80211_link_sta *link_sta = file->private_data;
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
+	struct ath12k_hw *ah = ahsta->ahvif->ah;
+	struct ath12k_rx_peer_stats *rx_stats;
+	struct ath12k_link_sta *arsta;
+	u8 link_id = link_sta->link_id;
+	struct ath12k *ar;
+	bool reset;
+	int ret;
+
+	ret = kstrtobool_from_user(buf, count, &reset);
+	if (ret)
+		return ret;
+
+	if (!reset)
+		return -EINVAL;
+
+	wiphy_lock(ah->hw->wiphy);
+
+	if (!(BIT(link_id) & ahsta->links_map)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+	if (!arsta || !arsta->arvif->ar) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ar = arsta->arvif->ar;
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	rx_stats = arsta->rx_stats;
+	if (!rx_stats) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	memset(rx_stats, 0, sizeof(*rx_stats));
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	ret = count;
+out:
+	wiphy_unlock(ah->hw->wiphy);
+	return ret;
+}
+
+static const struct file_operations fops_reset_rx_stats = {
+	.write = ath12k_dbg_sta_reset_rx_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath12k_debugfs_link_sta_op_add(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_link_sta *link_sta,
+				    struct dentry *dir)
+{
+	struct ath12k *ar;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	ar = ath12k_get_ar_by_vif(hw, vif, link_sta->link_id);
+	if (!ar)
+		return;
+
+	if (ath12k_debugfs_is_extd_rx_stats_enabled(ar)) {
+		debugfs_create_file("rx_stats", 0400, dir, link_sta,
+				    &fops_rx_stats);
+		debugfs_create_file("reset_rx_stats", 0200, dir, link_sta,
+				    &fops_reset_rx_stats);
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.h b/drivers/net/wireless/ath/ath12k/debugfs_sta.h
new file mode 100644
index 000000000000..90921303c741
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _ATH12K_DEBUGFS_STA_H_
+#define _ATH12K_DEBUGFS_STA_H_
+
+#include <net/mac80211.h>
+
+#include "core.h"
+
+#define ATH12K_STA_RX_STATS_BUF_SIZE		(1024 * 16)
+
+#ifdef CONFIG_ATH12K_DEBUGFS
+
+void ath12k_debugfs_link_sta_op_add(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_link_sta *link_sta,
+				    struct dentry *dir);
+
+#endif /* CONFIG_ATH12K_DEBUGFS */
+
+#endif /* _ATH12K_DEBUGFS_STA_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5b9d583d37dd..529647810f8c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -18,6 +18,7 @@
 #include "debugfs.h"
 #include "hif.h"
 #include "wow.h"
+#include "debugfs_sta.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -724,9 +725,9 @@ static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
 	return ath12k_mac_get_ar_by_chan(hw, ctx->def.chan);
 }
 
-static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif,
-					   u8 link_id)
+struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    u8 link_id)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
@@ -10284,6 +10285,10 @@ static const struct ieee80211_ops ath12k_ops = {
 	.resume				= ath12k_wow_op_resume,
 	.set_wakeup			= ath12k_wow_op_set_wakeup,
 #endif
+
+#ifdef CONFIG_ATH12K_DEBUGFS
+	.link_sta_add_debugfs           = ath12k_debugfs_link_sta_op_add,
+#endif
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 81cfb950e6cd..1b021b3e22e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -100,5 +100,7 @@ int ath12k_mac_mlo_setup(struct ath12k_hw_group *ag);
 int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag);
 void ath12k_mac_mlo_teardown(struct ath12k_hw_group *ag);
 int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
-
+struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    u8 link_id);
 #endif
-- 
2.34.1


