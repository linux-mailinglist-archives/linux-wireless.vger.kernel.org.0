Return-Path: <linux-wireless+bounces-23284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D321AC07F1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8975B7B7983
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257228688C;
	Thu, 22 May 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hxq0/jDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A78289372
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904197; cv=none; b=IhIZfnAxw/0n7eY4E5ZtawGzvoQJIzKvRlztXGHDyEhiP14zvp6MYMIxSEvlYEE95Y9TIsq8DONrJskt34hprfmx34byH6bT/hJ1+PevptrX6AoYAzL2b0w/ws46jMZ6+jIwKTKHFxw/dA19OZBj0p8G2db0FtHpCGIW5Ntc9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904197; c=relaxed/simple;
	bh=XL37fcOiiE4UBA4QCUkcX6Xkwzz5lHHsb9nTN8N+7co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc0kRqCCAoGD9ym+vYNiZTAefXvWahxu8sy63E927XDNBLwhdBDZSlgPSKMzWbi/pJMy1U+WhhuxrxKhbBBgzu9eP1paQclW01mLLNZLwFYurp8VZngSOiw4kenduj0vXho4A++DNWGqOECLjiXA3ns6q6uXv0+pLbS4ELfgN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hxq0/jDu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7qpSt024810;
	Thu, 22 May 2025 08:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YPlYvv6K/dmMvING+BYY/yzukGOSU9xqVBulhcYPxXU=; b=Hxq0/jDuGw5Ovd02
	FBbNhffHXhzhp8PciexVMN8xrxMvRO+Z3dmlEQIjAjTdr8gnlrS/+rqxQJ7oANET
	Rn6i8pt9FtKx6Im2TXb2XeY6mhxNeoTqo963uV36KCFFABG63OSgJiiutuVufzS7
	qkTkuo/u51hnsrNIhsH7XizcPM1qQ6AP/sROviL44gak/xHbVOou39V5YTp3cg0x
	VKs/416yZFYguSh7tvRmsZQmX6nZPCBjj0Dvt9qBoj1SoCZHo6Z5gzcyeryNJcAv
	AQEgYARD2dqT7IeEpsl5Mya7dUF0wtNG3Hu2BTRcH9o9Grf8JALe1o+CRpGsyUeC
	mZM8GQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4wp45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8uTVY016219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:29 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:27 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 02/10] wifi: cfg80211: add link_station_info structure to support MLO statistics
Date: Thu, 22 May 2025 14:25:53 +0530
Message-ID: <20250522085601.2741458-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FnNq8vE6Xyr7fSZzR73hcDMzAKfCutdb
X-Proofpoint-ORIG-GUID: FnNq8vE6Xyr7fSZzR73hcDMzAKfCutdb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX6jQ7SoD2G/ZA
 QWBKJz6CtO3EN9f0ZvNtRQTtL0+MmLuZdL+mTaxlavGPg7Mx2hC0ZJonjJXXAgtDCRMf5zmMWXf
 nh6SLSKVKDt18jDKb13XeauOayYdDI9pn/01VN4QYSEfSYfxqq9AwPoWJCJ7MHrRBUpYrIqgi5M
 Zw+DYyil+uBnTLz+yQcbyx71y3qpqN0R5oaFXf4EkoI0rMATgSbNU+3HMA6ny4ysTlgSTuKtQAU
 ahWa1TZYayii2C/TxVj6Bf3uvkzkZEx8Sz0Ru5ygvjtomVg3JTBVd8YYd6FbZiYOi2FVdXcEKNB
 r+BVngCkS/h2Jywyyl8baKeP77kBpnf51JyMw5x3Zf9DWTfgevHsf5mMlNvViRgDGlzQlDdpU92
 DY9Hf1JpUzcwAjaH8YNDKHy5DmemsBeVAqqvn9GS3si9/x8j2b6jyDTA9YnIGwNh+ih5C/Kh
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682ee6be cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=C2RrUa7LX1Wj_Yod6t4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

Current implementation of NL80211_GET_STATION does not work for
multi-link operation(MLO) since in case of MLO only deflink (or one
of the links) is considered and not all links.

Therefore to support for MLO, add link_station_info structure
to account link level statistics for station.

Additionally, add valid_links in station_info structure to indicate
bitmap of valid links for MLO. This will be helpful to check the link
related statistics during MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..e2a41cdca4a3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2017,6 +2017,99 @@ struct cfg80211_tid_stats {
 
 #define IEEE80211_MAX_CHAINS	4
 
+/**
+ * struct link_station_info - link station information
+ *
+ * Link station information filled by driver for get_station() and
+ *	dump_station().
+ * @filled: bit flag of flags using the bits of &enum nl80211_sta_info to
+ *	indicate the relevant values in this struct for them
+ * @connected_time: time(in secs) since a link of station is last connected
+ * @inactive_time: time since last activity for link station(tx/rx)
+ *	in milliseconds
+ * @assoc_at: bootime (ns) of the last association of link of station
+ * @rx_bytes: bytes (size of MPDUs) received from this link of station
+ * @tx_bytes: bytes (size of MPDUs) transmitted to this link of station
+ * @signal: The signal strength, type depends on the wiphy's signal_type.
+ *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
+ * @signal_avg: Average signal strength, type depends on the wiphy's
+ *	signal_type. For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_
+ * @chains: bitmask for filled values in @chain_signal, @chain_signal_avg
+ * @chain_signal: per-chain signal strength of last received packet in dBm
+ * @chain_signal_avg: per-chain signal strength average in dBm
+ * @txrate: current unicast bitrate from this link of station
+ * @rxrate: current unicast bitrate to this link of station
+ * @rx_packets: packets (MSDUs & MMPDUs) received from this link of station
+ * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this link of station
+ * @tx_retries: cumulative retry counts (MPDUs) for this link of station
+ * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
+ * @rx_dropped_misc:  Dropped for un-specified reason.
+ * @bss_param: current BSS parameters
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
+ * @expected_throughput: expected throughput in kbps (including 802.11 headers)
+ *	towards this station.
+ * @rx_beacon: number of beacons received from this peer
+ * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
+ *	from this peer
+ * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
+ * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
+ * @airtime_weight: current airtime scheduling weight
+ * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
+ *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
+ *	Note that this doesn't use the @filled bit, but is used if non-NULL.
+ * @ack_signal: signal strength (in dBm) of the last ACK frame.
+ * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
+ *	been sent.
+ * @rx_mpdu_count: number of MPDUs received from this station
+ * @fcs_err_count: number of packets (MPDUs) received from this station with
+ *	an FCS error. This counter should be incremented only when TA of the
+ *	received packet with an FCS error matches the peer MAC address.
+ * @addr: For MLO STA connection, filled with address of the link of station.
+ */
+struct link_station_info {
+	u64 filled;
+	u32 connected_time;
+	u32 inactive_time;
+	u64 assoc_at;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	s8 signal;
+	s8 signal_avg;
+
+	u8 chains;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
+	s8 chain_signal_avg[IEEE80211_MAX_CHAINS];
+
+	struct rate_info txrate;
+	struct rate_info rxrate;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	struct sta_bss_parameters bss_param;
+
+	u32 beacon_loss_count;
+
+	u32 expected_throughput;
+
+	u64 tx_duration;
+	u64 rx_duration;
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
+
+	u16 airtime_weight;
+
+	s8 ack_signal;
+	s8 avg_ack_signal;
+	struct cfg80211_tid_stats *pertid;
+
+	u32 rx_mpdu_count;
+	u32 fcs_err_count;
+
+	u8 addr[ETH_ALEN] __aligned(2);
+};
+
 /**
  * struct station_info - station information
  *
@@ -2101,6 +2194,11 @@ struct cfg80211_tid_stats {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
+ *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
+ *	get_station() and dump_station() callbacks.
+ * @links: reference to Link sta entries for MLO STA, all link specific
+ *	information is accessed through links[link_id].
  */
 struct station_info {
 	u64 filled;
@@ -2165,6 +2263,9 @@ struct station_info {
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
+
+	u16 valid_links;
+	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
-- 
2.34.1


