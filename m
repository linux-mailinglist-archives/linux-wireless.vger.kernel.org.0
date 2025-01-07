Return-Path: <linux-wireless+bounces-17133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12BBA036F4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 05:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CA164B79
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AA14B094;
	Tue,  7 Jan 2025 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IriXoyIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623F18BBA8
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736223485; cv=none; b=RRso80nFm62aAAi9WbfGu5rPzxMJaPTr6CbkWUdmU7Wx7fVo1aiT5pj9D0rDcDX4lU4+drcOUGYsHkiq41jbvnHtBPsdRGgrOfC/NABvDszKhm3duaum4pFCAR9Aq3Ydj4LbTuHHiDoM7VzV32EHJcGPwRh7kHT+QggpT6KKpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736223485; c=relaxed/simple;
	bh=C6LwBxm6QG4QcIpPgs196vJzF2X7+JjnELRxVzDDE+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSh+t4UwjA6uOt/vz6/fMhbcmHHsXMx1ac7WLwKJvMk6b6aUrO8CnwT+Jk1JsvZ6L0DqBNqYfeR7bILhT6Llv2bHduDqdd89QggzDyidiuQVhAhfSTZ9LAPGz8XdEYPGN2odi6H90QuBk+Vn6Q5dqaWzFDOuLj10sDi58PSUT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IriXoyIz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073Po37006524;
	Tue, 7 Jan 2025 04:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=agL36zh4J5bfx09DV6H8AQ
	UGghUPk4mBI2MeDHAkuQY=; b=IriXoyIzJitCNGiHS4Ce2TRxS3VxgsrjmZcXwD
	n7zQiu6LBMnQNqBjoK++ih898mdo2QJ3IB49tQBMZDwNd5KEhz6uOqOrWSrHQPsw
	suChpR1jKvKYomUh3Jkr0ydVzIpufOc1FNRrvWzRsRGbG/CbBBXgUqzdL6WKyPhi
	k7JJWSA2rJUlcxvlOVmPA3i51SkwyFBZ+1gOG4XIerXl0c++LTaUCkkz12RF2nkf
	WcHfEr1N4i71bjxGCquY3IC1kfTYV4ZJvOm1r3dmb/CwuAZ9URlckoKReF1AWRxZ
	++nNztmkm8yu8YVccxan18ntYALfBowccp5LEw8qzK4P1RSQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440vbu03bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 04:17:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5074HqEH030208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 04:17:52 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 20:17:50 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo structure
Date: Tue, 7 Jan 2025 09:47:27 +0530
Message-ID: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: NnCcANiq1Rf5VOldWSSohuItNMX1rzIb
X-Proofpoint-GUID: NnCcANiq1Rf5VOldWSSohuItNMX1rzIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070031

Currently, the sinfo kernel documentation is not aligned with the
order of the sinfo structure elements. Therefore, rearrange the
kernel documentation fields to align correctly with the structure.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7790af534b7f..01b977fd38c9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2063,6 +2063,7 @@ struct cfg80211_tid_stats {
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
  * @bss_param: current BSS parameters
+ * @sta_flags: station flags mask & values
  * @generation: generation number for nl80211 dumps.
  *	This number should increase every time the list of stations
  *	changes, i.e. when a station is added or removed, so that
@@ -2072,7 +2073,6 @@ struct cfg80211_tid_stats {
  *	user space MLME/SME implementation. The information is provided for
  *	the cfg80211_new_sta() calls to notify user space of the IEs.
  * @assoc_req_ies_len: Length of assoc_req_ies buffer in octets.
- * @sta_flags: station flags mask & values
  * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @t_offset: Time offset of the station relative to this host.
  * @local_pm: local mesh STA power save mode
@@ -2080,19 +2080,19 @@ struct cfg80211_tid_stats {
  * @nonpeer_pm: non-peer mesh STA power save mode
  * @expected_throughput: expected throughput in kbps (including 802.11 headers)
  *	towards this station.
+ * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
+ * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
  * @rx_beacon: number of beacons received from this peer
  * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
  *	from this peer
  * @connected_to_gate: true if mesh STA has a path to mesh gate
- * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
- * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
- * @airtime_weight: current airtime scheduling weight
  * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
  *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
  *	Note that this doesn't use the @filled bit, but is used if non-NULL.
  * @ack_signal: signal strength (in dBm) of the last ACK frame.
  * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
  *	been sent.
+ * @airtime_weight: current airtime scheduling weight
  * @rx_mpdu_count: number of MPDUs received from this station
  * @fcs_err_count: number of packets (MPDUs) received from this station with
  *	an FCS error. This counter should be incremented only when TA of the

base-commit: b73e56f16250c6124f8975636f1844472f6fd450
-- 
2.34.1


