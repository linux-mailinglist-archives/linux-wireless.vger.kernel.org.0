Return-Path: <linux-wireless+bounces-18786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E0A31693
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F15A188529E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD92638B0;
	Tue, 11 Feb 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQZj6F7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191826562D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305526; cv=none; b=Mn7qo0zc7nphvoExK9E19vLxeUmxyhxwSxwfLnD0z9MbjluecS59+Sx8Za0eVdDzlBx3QFd2N56BStCQ5UQcEgrFSeseNqK2hly57lZWHHA7WME46PxFqBVfEOTsEk+z51nTUl9QBO4KllR9K//v9TraTUGvvv1LaftWRbB0DBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305526; c=relaxed/simple;
	bh=J2dl+d2A4BVq5gzn9WGtKNS+1+5YLQrsV86hJx0H1/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPIO1OvmFblZuA+1BLV6Aac45MGQ9DhBAzBuLTI1jEJVbkf+qW1H4GzxPdKJESh2Af/+dxP0b/E7rNCUFPM++GynfRaLxYObX1zaQz8Vl+Qbq7OgKK4eGH3MUKjOxRY2MzissM7o69rMNzmIKahb5o40bwo/IxUwvr5QlovmyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQZj6F7Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDNQb6008646
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 20:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WVp4l79JTOrFioYOgijFlVrrBfCuuLfKQTL
	xf0QkJis=; b=QQZj6F7QKYQN1rex03Wtpc46qgzr74COfh4c5HRYIOTLXCcoN4H
	hHOnkXQ2tylLyiniv1iql+465HFQVSnC8vV8i8hwbvoYh8mPB66eCTMLzeYXg94Z
	0M0emSX35eJw5QZ3nRZxXpvQEbDKwVr4tOHhxeelpcDBVBJix9iUxwQ/kqdi3wRe
	7RwkBH+bhywycVNxM7UNutbMq2HlkipV1eVoa8dGhMf2Yh7ZrfKqSZeCxTi2FC3n
	o+TKX5vvbJMXMfSSGAa3pAR0arDfLrPVfOt/+KXi9I9LCeVGdD5Rv3LiZx71DfWG
	RKNM/G1FYjMqtJqZJvpYK6TruhHKqjTSsCA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qy4dak9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 20:25:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f40f40788so137708875ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 12:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305522; x=1739910322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVp4l79JTOrFioYOgijFlVrrBfCuuLfKQTLxf0QkJis=;
        b=r5w0jO7nNePG63efT+offCFGRYMF7jKBdxEOr5yomIAzPN6w7NU8xl18VPpH5AR1n/
         RD3bsM9S3ARhM9EXAqmc1OgtvXprONbkeyLZD8a0Ga37nLbhXUMKxGNZLRBF2sHQffSw
         YjqLCpYJ6f80P/P8s8UBvxDeXqEjn7auAlzLh2IuqQ8wH3wrN+oVqw/BeaOpxaJIwL9X
         ZyVY1IlxB0NqtrBD7AgYrmTwxf3kahn0Zz1p+Qx+m8/vWTfuK918yrHrf7ai7pU4U6C3
         9umcP1msNbfkjMcRR+4N0Zu8OH+CDo6n8jfyMaSf9J/2EzTgRO6VCRca8crLUrcXkMLN
         HNKg==
X-Gm-Message-State: AOJu0YzlOIVgRmEGxl/QD4ZroOVYRgI0lv/8D97bb9PGg03uPxAA7rX4
	MJDngRYtb9jZ5JCgh2nOLk73jb3Dzu0I1soLbGOe7cO9h7Aqx2tQJJzKj+nNLQcSS5MGA48ufIn
	2b6vFkkexRBnLt67OCA4yfh6YIiHowOFA9q92jTttyoW6yS5BDJ47Se5x7chkMF8MYGJhtC+jhQ
	==
X-Gm-Gg: ASbGncvewUqXxP8T9evLGSPb1MAYccQQb7qHyxFud+c8DdEGVDdjDLbgBmxTqWjwdci
	Je44MWylqtP6si5PvJ9m2bFB1NqDNc37v7F2YfEhXK8roJceuanvx2VOT/sTH8nM85MgWFIn3Sg
	eDeId49dE75QbQVBmW32Fssx+kwlr4K+MHUXAEDX5Y7vZEUA9SUAuOVnlVIspatdn/5kCp1iPBr
	d8ITljS96dTHiLKD7J3t3znJrogJoeCSs+dKeQ+jDdII/qL/5szt50THhKjvilZPUuLHlgDV3a3
	CSLmVOxLIthv60K1FTPTd1pIemk9B0CY2zWFSyujEl8HDoMTrood/D770vY+Aw==
X-Received: by 2002:a05:6a21:681:b0:1ea:ddd1:2fb6 with SMTP id adf61e73a8af0-1ee5c850dd0mr1204500637.30.1739305522238;
        Tue, 11 Feb 2025 12:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3HnTYV+LMD6ByfJK4sfCpq+EOyMkr+qgtwJV7l7XACrTWyKZk+JbiTebRH71/ut/VQ+7eZA==
X-Received: by 2002:a05:6a21:681:b0:1ea:ddd1:2fb6 with SMTP id adf61e73a8af0-1ee5c850dd0mr1204458637.30.1739305521793;
        Tue, 11 Feb 2025 12:25:21 -0800 (PST)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm4494949a12.61.2025.02.11.12.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:25:21 -0800 (PST)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH v2] wifi: mac80211: Add support for management frames stats
Date: Tue, 11 Feb 2025 12:25:18 -0800
Message-Id: <20250211202518.126305-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k37eXYDtoNqeIy-fNa-1MzMvUV97Yrlc
X-Proofpoint-GUID: k37eXYDtoNqeIy-fNa-1MzMvUV97Yrlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110133

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

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

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v2:
 - posting as a PATCH instead of RFC
 - updated signoff emails to new email accounts

---
 net/mac80211/debugfs.c     | 64 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h | 26 ++++++++++++++++
 net/mac80211/rx.c          |  2 ++
 net/mac80211/status.c      |  4 +++
 net/mac80211/tx.c          |  2 ++
 5 files changed, 98 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index bf0a2902d93c..43e6d0f54c8e 100644
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
index e7dc3f0cfc9a..a4903adc1892 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1560,8 +1560,19 @@ struct ieee80211_local {
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
 
@@ -2800,4 +2811,19 @@ void ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
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
index 1e28efe4203c..dfbe32f59180 100644
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


