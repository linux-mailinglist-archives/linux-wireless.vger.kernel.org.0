Return-Path: <linux-wireless+bounces-16666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89F9F9D10
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 00:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D29F1695BD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 23:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ADE22576D;
	Fri, 20 Dec 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QzDK1akJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EA215F74
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736599; cv=none; b=k63NUA5HqZfq4dyy8dMEP2xzvOdtOvpXxnvmDoWZWDs6ez6P1AaGgNkSK3nJDfWYcTBrHsRC3mEQD510BGD0ukYTg1+5lgRrQHvw2o6TQ/65gbyGyFldHCRE+j1w5ij3KO8yVc0SY1tdqooK3nCxnJA9HXQmGxjTXOjVgmLPyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736599; c=relaxed/simple;
	bh=gMOgjXP1o0snHV/Myy5u5F28iX2u4ZeGMzMZ4eGxhRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLyn2Xebss7R8LHEAmeBOOXYJ6pGdhVOZll+Bpnv6N5b8+FyMrOIZUEcKkEn8heapWsjB821FZSS7U8RzaIbdKX4R5WhdWXjPPld42As2Argi787+KkPVBTYHNBatRNmPE6Ys5rMx0VPnKRIhKAuBvcMurEtOwRVs1QKK5RoKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QzDK1akJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKJdS00023353;
	Fri, 20 Dec 2024 23:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bp4hkwjzNP6TG/ze0zt+Do
	braCj5zv7PMF3tgy92RyQ=; b=QzDK1akJr8DE3xVmwezN7JH8Msdj7SihPgeaR4
	I1pMGPmSZP7Ay9iuBkvz2n7dOdpfnAILP9VcyEulJDTeYd1/ra04jeLsruv074Kt
	80e6hINxTON060GKb/YZc6+HZZMHiW09cogThIs2xkktfmg3juPNwXmdIaTEXfBF
	ykcn/Gdq/XndQrN1vPZhvCZ8MoEVkqoQuICJGkYsm5X9jpbAh3czIGl7Q6Ww/IyF
	Gd4FT8BbJJfPVzL9Ni9ZIVtbuqs1/0XEyFZp/WHCXkynFSJAS1fGWY4RUAA/j0wo
	w7r2vXw/mi/mTbzRkjGbVSF75QUp+H7js3OaaZPqlw6H+3Ww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43newf8b55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 23:16:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKNGTfg019851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 23:16:29 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 15:16:28 -0800
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Ramya Gnanasekar
	<quic_rgnanase@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH RFC] wifi: mac80211: Add support for management frames stats
Date: Fri, 20 Dec 2024 15:16:11 -0800
Message-ID: <20241220231611.1870613-1-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UDWZ7n3BUkUppmOWSmBIR9h47pWAo4OJ
X-Proofpoint-ORIG-GUID: UDWZ7n3BUkUppmOWSmBIR9h47pWAo4OJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200189

From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

Currently there aren't statistics in mac80211 that keep track of the
management frames that are processed in both Tx and Rx. This type of
statistics is useful in tracking if management frames are successfully
transmitted or are dropped. These statistics are also needed to
provide information regarding how many management frames are received.

Add support to track number of management frames that are processed
in mac80211 driver and maintain counters for management Tx completion
status. These statistics are to be included as part of "Extra
statistics for TX/RX debugging". In order to enable them,
CONFIG_MAC80211_DEBUG_COUNTERS needs to be enabled in kernel
configuration.

This stat is a per phy device stat. It can be dumped using the below
command:

cat /sys/kernel/debug/ieee80211/phyX/statistics/mgmt_frame

When executing this command, dump management stats for all the virtual
interfaces of that particular phy device.

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/debugfs.c     | 64 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h | 26 ++++++++++++++++
 net/mac80211/rx.c          |  2 ++
 net/mac80211/status.c      |  4 +++
 net/mac80211/tx.c          |  2 ++
 5 files changed, 98 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index be2e486907f9..4f1d3c4fab7d 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -633,6 +633,69 @@ DEBUGFS_DEVSTATS_FILE(dot11RTSFailureCount);
 DEBUGFS_DEVSTATS_FILE(dot11FCSErrorCount);
 DEBUGFS_DEVSTATS_FILE(dot11RTSSuccessCount);
 
+#ifdef CONFIG_MAC80211_DEBUG_COUNTERS
+static ssize_t mgmt_frame_read(struct file *file, char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	int size = 1000;
+	int i, len = 0;
+	static const char *mgmt_frame[IEEE80211_MGMT_FRM_TYPE_NUM_MAX - 1] = {
+		"ASSOC REQ", "ASSOC RESP",
+		"REASSOC REQ", "REASSOC RESP",
+		"PROBE REQ", "PROBE RESP",
+		"TIMING ADV", NULL,
+		"BEACON", "ATIM",
+		"DISASSOC", "AUTH",
+		"DEAUTH", "ACTION",
+		"ACTION NO ACK"};
+
+	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len, "Tx mgmt stats:\n");
+	for (i = 0; i < IEEE80211_MGMT_FRM_TYPE_NUM_MAX - 1; i++) {
+		if (!mgmt_frame[i])
+			continue;
+		len += scnprintf(buf + len, size - len, "%s\t%u\n",
+				 mgmt_frame[i], local->tx_mgmt_pkts[i]);
+	}
+
+	len += scnprintf(buf + len, size - len, "\nRx mgmt stats:\n");
+	for (i = 0; i < IEEE80211_MGMT_FRM_TYPE_NUM_MAX - 1; i++) {
+		if (!mgmt_frame[i])
+			continue;
+		len += scnprintf(buf + len, size - len, "%s\t%u\n",
+				 mgmt_frame[i], local->rx_mgmt_pkts[i]);
+	}
+
+	len += scnprintf(buf + len, size - len, "\nTx mgmt completion success:\n");
+	for (i = 0; i < IEEE80211_MGMT_FRM_TYPE_NUM_MAX - 1; i++) {
+		if (!mgmt_frame[i])
+			continue;
+		len += scnprintf(buf + len, size - len, "%s\t%u\n",
+				 mgmt_frame[i], local->mgmt_tx_compl_succ[i]);
+	}
+
+	len += scnprintf(buf + len, size - len, "\nTx mgmt completion failure:\n");
+	for (i = 0; i < IEEE80211_MGMT_FRM_TYPE_NUM_MAX - 1; i++) {
+		if (!mgmt_frame[i])
+			continue;
+		len += scnprintf(buf + len, size - len, "%s\t%u\n",
+				 mgmt_frame[i], local->mgmt_tx_compl_fail[i]);
+	}
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations stats_mgmt_frame_ops = {
+	.read = mgmt_frame_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+#endif
+
 void debugfs_hw_add(struct ieee80211_local *local)
 {
 	struct dentry *phyd = local->hw.wiphy->debugfsdir;
@@ -692,6 +755,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_STATS_ADD(rx_expand_skb_head_defrag);
 	DEBUGFS_STATS_ADD(rx_handlers_fragments);
 	DEBUGFS_STATS_ADD(tx_status_drop);
+	DEBUGFS_DEVSTATS_ADD(mgmt_frame);
 #endif
 	DEBUGFS_DEVSTATS_ADD(dot11ACKFailureCount);
 	DEBUGFS_DEVSTATS_ADD(dot11RTSFailureCount);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f0db39b28ff..8418acb8333f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1547,8 +1547,19 @@ struct ieee80211_local {
 	unsigned int rx_expand_skb_head_defrag;
 	unsigned int rx_handlers_fragments;
 	unsigned int tx_status_drop;
+
+	/* Management Frame statistics */
+#define IEEE80211_MGMT_FRM_TYPE_NUM_MAX	16
+	u32 tx_mgmt_pkts[IEEE80211_MGMT_FRM_TYPE_NUM_MAX];
+	u32 rx_mgmt_pkts[IEEE80211_MGMT_FRM_TYPE_NUM_MAX];
+	u32 mgmt_tx_compl_succ[IEEE80211_MGMT_FRM_TYPE_NUM_MAX];
+	u32 mgmt_tx_compl_fail[IEEE80211_MGMT_FRM_TYPE_NUM_MAX];
+
+#define I802_DEBUG_MGMT_STATS(_skb, _local, _type) \
+	ieee80211_mgmt_stats_update(_skb, (_local)->(_type))
 #define I802_DEBUG_INC(c) (c)++
 #else /* CONFIG_MAC80211_DEBUG_COUNTERS */
+#define I802_DEBUG_MGMT_STATS(skb, local, type) do { } while (0)
 #define I802_DEBUG_INC(c) do { } while (0)
 #endif /* CONFIG_MAC80211_DEBUG_COUNTERS */
 
@@ -2781,4 +2792,19 @@ void ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
 #define VISIBLE_IF_MAC80211_KUNIT static
 #endif
 
+#ifdef CONFIG_MAC80211_DEBUG_COUNTERS
+static inline void ieee80211_mgmt_stats_update(struct sk_buff *skb,
+					       u32 *mgmt_stats_type)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	u16 stype;
+
+	if (!ieee80211_is_mgmt(mgmt->frame_control))
+		return;
+
+	stype = le16_get_bits(mgmt->frame_control, IEEE80211_FCTL_STYPE);
+	mgmt_stats_type[stype]++;
+}
+#endif
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2bec18fc1b03..acc40aa3e3e4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3427,6 +3427,8 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
 		return RX_DROP_MONITOR;
 
+	I802_DEBUG_MGMT_STATS(rx->skb, rx->local, rx_mgmt_pkts);
+
 	/* drop too small action frames */
 	if (ieee80211_is_action(mgmt->frame_control) &&
 	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 5f28f3633fa0..d4ccf3cb484b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1063,6 +1063,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			if (retry_count > 1)
 				I802_DEBUG_INC(local->dot11MultipleRetryCount);
 		}
+		I802_DEBUG_MGMT_STATS(skb, local, mgmt_tx_compl_succ);
 
 		/* This counter shall be incremented for an acknowledged MPDU
 		 * with an individual address in the address 1 field or an MPDU
@@ -1075,6 +1076,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	} else {
 		if (ieee80211_is_first_frag(hdr->seq_ctrl))
 			I802_DEBUG_INC(local->dot11FailedCount);
+		I802_DEBUG_MGMT_STATS(skb, local, mgmt_tx_compl_fail);
 	}
 
 	if (ieee80211_is_any_nullfunc(fc) &&
@@ -1238,6 +1240,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 
 	if (acked || noack_success) {
 		I802_DEBUG_INC(local->dot11TransmittedFrameCount);
+		I802_DEBUG_MGMT_STATS(skb, local, mgmt_tx_compl_succ);
 		if (!pubsta)
 			I802_DEBUG_INC(local->dot11MulticastTransmittedFrameCount);
 		if (retry_count > 0)
@@ -1246,6 +1249,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			I802_DEBUG_INC(local->dot11MultipleRetryCount);
 	} else {
 		I802_DEBUG_INC(local->dot11FailedCount);
+		I802_DEBUG_MGMT_STATS(skb, local, mgmt_tx_compl_succ);
 	}
 
 free:
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..173cdbca01ab 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1833,6 +1833,8 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 		return -1;
 	}
 
+	I802_DEBUG_MGMT_STATS(tx->skb, tx->local, tx_mgmt_pkts);
+
 	return 0;
 }
 
-- 
2.34.1


