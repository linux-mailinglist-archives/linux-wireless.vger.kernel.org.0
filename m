Return-Path: <linux-wireless+bounces-17637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A489A14F95
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89789168510
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE461FF1B2;
	Fri, 17 Jan 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TvaoEY+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74B1FECB8
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117989; cv=none; b=Niw3iKlNZ5WHtMtwZ7zEcoVCLHBk7rJ0EhREshNAjs+mYQAOzK2YNNeW4NvV+a8Ntm/KmLG439t8UBhjflPeJXMg4JvRF88i26lQmOaeK9cn7lC4Hg2La2gfWaRZzz9YIROAVfY8vuuChpc+QDjdn0/wE8qwa8m7xyMZd6MWNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117989; c=relaxed/simple;
	bh=3gNowETp2T5A6zYcjNux+Hkf4lG+vTl8QDUq2WHHUCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRx6jcbQErZSeLR3mmZx6sf6N/MRzh7IQ51BkqX2w7mTjr7Ji0mNOjt7+X8GOZCbE9fGno/+oODAVsH6D9dXf4bZ0/A6Iq3ow9XNyLAuPIBf6JEUBwOv0gCQZ9GaP+hmb5SwEPNqOmwI5qJ8Y9cXJStRNeSZ0KSKZoKZAFjNnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TvaoEY+Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HALjni005042;
	Fri, 17 Jan 2025 12:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z87gomJ1DnwoYbgZte+98/SbfkZOUOMwLZWzn354b4E=; b=TvaoEY+QhNQLSmBy
	h+8coyKh3cDdhAHWGZwauk61wDQGVDSMQ/rp5PYd7SaqXaNMMA9X7sfzR5xgvuWO
	vpCnVbMfXdbAoK1zEom21iMOK6zPUsmiw8q/rvM3erLlo10WIX3aBLKNOP4Oud5S
	w+em+BliYYjFqgksIQaqPXpoz4ptJNb4fLVaHxuQnqX0eGixAnfgKBzRhyofI2G/
	Moq+Bzd0Kax4jMefEgr++fTtnXcgcboaIv+khlwvlEBdv10a1gCMAisFOGbem/Te
	xpuP/ZBUYFKwuqFOi0FswZ7xQQ6/FOOYIhRZ1Lod1448xnfcnzz5Wxn2GbcZ+ekK
	v0fNrg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447ncsgb7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkMwV031034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:22 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:21 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 01/12] wifi: cfg80211: reorg sinfo structure elements for mesh
Date: Fri, 17 Jan 2025 18:15:43 +0530
Message-ID: <20250117124554.3719808-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UmrGBd8eCZK5hkythiiPHs4EimaiAw9r
X-Proofpoint-GUID: UmrGBd8eCZK5hkythiiPHs4EimaiAw9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170103

Currently, as multi-link operation(MLO) is not supported for mesh,
reorganize the sinfo structure for mesh-specific fields and embed
mesh related NL attributes together in organized view.
This will allow for the simplified reorganization of sinfo structure
for link level in a subsequent patch to add support for MLO station
statistics.
No functionality changes added.

Pahole summary before the reorg of sinfo structure:
 - size: 256, cachelines: 4, members: 50
 - sum members: 239, holes: 4, sum holes: 17
 - paddings: 2, sum paddings: 2
 - forced alignments: 1, forced holes: 1, sum forced holes: 1

Pahole summary after the reorg of sinfo structure:
 - size: 248, cachelines: 4, members: 50
 - sum members: 239, holes: 4, sum holes: 9
 - paddings: 2, sum paddings: 2
 - forced alignments: 1, last cacheline: 56 bytes

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 43 +++++++++++++++++++++---------------------
 net/wireless/nl80211.c | 11 ++++++-----
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7790af534b7f..77f72a46ce42 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2045,9 +2045,6 @@ struct cfg80211_tid_stats {
  * @assoc_at: bootime (ns) of the last association
  * @rx_bytes: bytes (size of MPDUs) received from this station
  * @tx_bytes: bytes (size of MPDUs) transmitted to this station
- * @llid: mesh local link id
- * @plid: mesh peer link id
- * @plink_state: mesh peer link state
  * @signal: The signal strength, type depends on the wiphy's signal_type.
  *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
  * @signal_avg: Average signal strength, type depends on the wiphy's signal_type.
@@ -2067,14 +2064,20 @@ struct cfg80211_tid_stats {
  *	This number should increase every time the list of stations
  *	changes, i.e. when a station is added or removed, so that
  *	userspace can tell whether it got a consistent snapshot.
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @assoc_req_ies: IEs from (Re)Association Request.
  *	This is used only when in AP mode with drivers that do not use
  *	user space MLME/SME implementation. The information is provided for
  *	the cfg80211_new_sta() calls to notify user space of the IEs.
  * @assoc_req_ies_len: Length of assoc_req_ies buffer in octets.
  * @sta_flags: station flags mask & values
- * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @t_offset: Time offset of the station relative to this host.
+ * @llid: mesh local link id
+ * @plid: mesh peer link id
+ * @plink_state: mesh peer link state
+ * @connected_to_gate: true if mesh STA has a path to mesh gate
+ * @connected_to_as: true if mesh STA has a path to authentication server
+ * @airtime_link_metric: mesh airtime link metric.
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
@@ -2083,7 +2086,6 @@ struct cfg80211_tid_stats {
  * @rx_beacon: number of beacons received from this peer
  * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
  *	from this peer
- * @connected_to_gate: true if mesh STA has a path to mesh gate
  * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
  * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
  * @airtime_weight: current airtime scheduling weight
@@ -2097,8 +2099,6 @@ struct cfg80211_tid_stats {
  * @fcs_err_count: number of packets (MPDUs) received from this station with
  *	an FCS error. This counter should be incremented only when TA of the
  *	received packet with an FCS error matches the peer MAC address.
- * @airtime_link_metric: mesh airtime link metric.
- * @connected_to_as: true if mesh STA has a path to authentication server
  * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
  *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
  *	MLD's MLME/SME is offload to driver. Drivers won't fill this
@@ -2125,9 +2125,6 @@ struct station_info {
 	u64 assoc_at;
 	u64 rx_bytes;
 	u64 tx_bytes;
-	u16 llid;
-	u16 plid;
-	u8 plink_state;
 	s8 signal;
 	s8 signal_avg;
 
@@ -2147,36 +2144,38 @@ struct station_info {
 
 	int generation;
 
+	u32 beacon_loss_count;
+
 	const u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
-	u32 beacon_loss_count;
 	s64 t_offset;
+	u16 llid;
+	u16 plid;
+	u8 plink_state;
+	u8 connected_to_gate;
+	u8 connected_to_as;
+	u32 airtime_link_metric;
 	enum nl80211_mesh_power_mode local_pm;
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
 	u32 expected_throughput;
 
-	u64 tx_duration;
-	u64 rx_duration;
-	u64 rx_beacon;
-	u8 rx_beacon_signal_avg;
-	u8 connected_to_gate;
+	u16 airtime_weight;
 
-	struct cfg80211_tid_stats *pertid;
 	s8 ack_signal;
 	s8 avg_ack_signal;
+	struct cfg80211_tid_stats *pertid;
 
-	u16 airtime_weight;
+	u64 tx_duration;
+	u64 rx_duration;
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
 
 	u32 rx_mpdu_count;
 	u32 fcs_err_count;
 
-	u32 airtime_link_metric;
-
-	u8 connected_to_as;
-
 	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8789d8b73f0f..d90033e03dd6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6726,9 +6726,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	PUT_SINFO_U64(RX_BYTES64, rx_bytes);
 	PUT_SINFO_U64(TX_BYTES64, tx_bytes);
-	PUT_SINFO(LLID, llid, u16);
-	PUT_SINFO(PLID, plid, u16);
-	PUT_SINFO(PLINK_STATE, plink_state, u8);
 	PUT_SINFO_U64(RX_DURATION, rx_duration);
 	PUT_SINFO_U64(TX_DURATION, tx_duration);
 
@@ -6772,13 +6769,18 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(TX_RETRIES, tx_retries, u32);
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
 	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+
+	PUT_SINFO(LLID, llid, u16);
+	PUT_SINFO(PLID, plid, u16);
+	PUT_SINFO(PLINK_STATE, plink_state, u8);
+	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
 	PUT_SINFO(LOCAL_PM, local_pm, u32);
 	PUT_SINFO(PEER_PM, peer_pm, u32);
 	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
 	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
 	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
+	PUT_SINFO_U64(T_OFFSET, t_offset);
 
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
@@ -6806,7 +6808,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	PUT_SINFO_U64(T_OFFSET, t_offset);
 	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
 	PUT_SINFO_U64(BEACON_RX, rx_beacon);
 	PUT_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
-- 
2.34.1


