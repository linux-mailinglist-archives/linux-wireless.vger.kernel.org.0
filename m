Return-Path: <linux-wireless+bounces-22946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E9AB71E2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38277A0420
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802A27E1C3;
	Wed, 14 May 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U11AbSnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF227C172
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241370; cv=none; b=YuMXjaA2GkdUiowRVqVyBJWhFHQ459BEI3ScncoB0ATXCJrvbT3riJXsuj033YZFAgbaf5rlO4wTjBXZa/PBrJNV7oGhgWTw/E0u4HX2nJMkt+SLS3AqSJJ3TT5ftRHcT5NO2x1EyQC2J5iWQsscqKI14zp/tViXLJny+SorB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241370; c=relaxed/simple;
	bh=FWGhdtc4riSrRePg5GYQsNnp0HMzMVtOdNGOqQ9eB4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyvmLmsV7zL1TxsMjK1Yppc4vNwMQHk9K/exMfSEKsOwC27wlDar0wan1cpAJD6oHQxisXjxOgmN2+5iaVnwoHQlgSAaZWC2Kf4rWkX4YEz56wJnRA5zVfIoinxY+5XpkwNc2QPuCX4OXuU7wS5h5z8/dInCSBampVf/OkuwKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U11AbSnj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuvph015927;
	Wed, 14 May 2025 16:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	icBZYqC9IA9svxKNLBN/LiQ8RCmexrdOPhZS9wZaVTY=; b=U11AbSnjy5poZJqI
	eVjXtKQfyXULIPZX/gXTDhqhqbmbOSshnhYaFTdeSQmAtkvLIc4qIN2YnKnHGSiZ
	pm7Sh0vCQmUZTvoob0IZBLyxAFDzlsSMlv5CspKgpfliGi5zaHEaqZozYCQSHtgP
	tp1zP0bV9MjUWgbalJIA1GdbQGaR42Uex5E0/7B13RAVEJfirT5qq4u7AV67gyyE
	KQ8aObV+6JRyLipl6xMtzfeqS+XMqKuX7arEu4qpzNu5mFLjVhdbY/HxY0CXP8Vm
	eb81ecfnAVYc8quHOlevTTriQyLz1877i1bh7OeCgzL6885SydMQLNbkEL4Tbw1n
	8O0K0A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmufw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnNbn026173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:23 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:22 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 02/10] wifi: cfg80211: add link_station_info structure to support MLO statistics
Date: Wed, 14 May 2025 22:18:49 +0530
Message-ID: <20250514164857.227540-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mTOnJZrqCHOQsPvCnEZrc4dDMN5uTGUb
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=6824c994 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=C2RrUa7LX1Wj_Yod6t4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mTOnJZrqCHOQsPvCnEZrc4dDMN5uTGUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX2IeHNKHqKUA3
 mXGtIZoWfPjeX9Zr8Ftc6eZUNeDg70RW3i4BiS1auFPnqSmdQr7UoYAsTKxp70I3tGJkTaiaBDP
 9N9dIxOnM13r7tEcb3vwDQwG70dbo9jxF+ZKBUVoOBOSl5WbQDAx7L6DB518WDHs2TJ4CYjZo9E
 a5tLexDXRidhEzOzOq/XuXIzInY8HPv/h/nWYZ7CWbggFed0WYriY6q8fmN6nUtxtij30tU5VZl
 fXhoH194rxvrt7aPiVk3KJL5cOukeFdnHpReOvuWo/eYXjhNChXs8D8iRnlmwbWvf7xDE2umCDn
 HWNinOJVnhrRnz0Gifj8eQwr8YRA+m98Jivie+hcWufIcJPLN4HkI3hD7KIebFpggSKlGvD33J3
 blPbxdLSgULYIvOKod/VxOXZ8CJu9fmDcS+uXTaDPxIX7nVm2429pMWeyz+exldykSjw/Sxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140151

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
 include/net/cfg80211.h | 104 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..48096a23deb2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2017,6 +2017,102 @@ struct cfg80211_tid_stats {
 
 #define IEEE80211_MAX_CHAINS	4
 
+/**
+ * struct link_station_info - link station information
+ *
+ * Link station information filled by driver for get_station() and
+ *	dump_station().
+ * @link_id: Link ID uniquely identifying the link STA. This is -1 for non-ML
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
+ **/
+
+struct link_station_info {
+	int link_id;
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
@@ -2101,6 +2197,11 @@ struct cfg80211_tid_stats {
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
@@ -2165,6 +2266,9 @@ struct station_info {
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


