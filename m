Return-Path: <linux-wireless+bounces-3450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A57851360
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395731F275A6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680139FCE;
	Mon, 12 Feb 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C+Q28egM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602739AE6
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740195; cv=none; b=irIdLaCL0lRmPedE/9VPDdDMV6sPq573io7cRnFKqrpw0Iyu9h+FK3BnvxhmAAoOJupaQ6NnHVPoJbV+CCMNwLrnNMD5TmHw4t759FaK/7fgBN/nX4SNwzzw2jpd2MxPKqTS2edMNyDTN8F9JTP78tLFA4OyuCmIlBqmARGJ1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740195; c=relaxed/simple;
	bh=UvWPx0Bz7Pewc3IeABmd7Oo1eKsz3qtDKm6RNUG/lOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGR1RH0dlSSJuyAvb6Ds6fZEuQVgPV+dnnfoONl9QSHC0O3NNMEmVfN13KTXZ66GCYfLBBh16nIHu6+PfGqItOaBu05s3FrfDkysWm4cEjzD8Ev6CS130trLHnqM2WhIaO+ctbLh67umnqZ26YvzVR8bMYWCtk4N76+IcpKc/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C+Q28egM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBh5ZP031091;
	Mon, 12 Feb 2024 12:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=1drBpVu
	cm/RsRC/T5MBVXmf/WaVXqHdXD0EdI0N2Pk4=; b=C+Q28egMWfWOeAZCGWfphPC
	EnFmohFrVoo81zpO3gjU5d6ROJBykvmXPqSkIJ1/DFpLEX9SM18oyitGcfD55nRX
	rf8zlmKaW8bZL9dmIqjWUO5NhjGsacztjOgqN2KqwiuC1ptqcC6dZY0qhfnT+0bq
	1oyx9JluBIGcqnCOGge+KHJ3Xv8VHJ1R/UkUxVmloPCiGe1/HwkHA/ipwF8ry1KW
	++34CW8BIcSV2a3/bwlZXo1Tzjgj7nn+bAlt+Ysok8gclNWzLVjD+UzOrwhrEFTo
	b5k7GE93tkRt1MHcKz5VScJoSE47iTsFbqun1Z6Au1cUdMEfhBFGIFrKPGCfCPA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps37hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:28 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41CCGPbk002176;
	Mon, 12 Feb 2024 12:16:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3w627kpp81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:25 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CCGPRY002170;
	Mon, 12 Feb 2024 12:16:25 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-haric-blr.qualcomm.com [10.131.39.39])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41CCGPBL002168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:25 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 3844793)
	id DE67741211; Mon, 12 Feb 2024 17:46:24 +0530 (+0530)
From: Hari Chandrakanthan <quic_haric@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211: Add support to rx retry stats
Date: Mon, 12 Feb 2024 17:46:15 +0530
Message-Id: <20240212121616.3683197-2-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212121616.3683197-1-quic_haric@quicinc.com>
References: <20240212121616.3683197-1-quic_haric@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UZzwAN_kOHXYsLvdlw6gIR_R3zN8WpoV
X-Proofpoint-GUID: UZzwAN_kOHXYsLvdlw6gIR_R3zN8WpoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120093

Add support to count station level rx retries.
It denotes the number of data frames(MPDUs) with rx retry bit set.

The rx retry stats helps in understanding the medium
during UL transmission.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..0623942b1f09 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1995,6 +1995,7 @@ struct cfg80211_tid_stats {
  * @rxrate: current unicast bitrate to this station
  * @rx_packets: packets (MSDUs & MMPDUs) received from this station
  * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @rx_retries: number of rx packets(MPDUs) from this station with retry bit set.
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
@@ -2075,6 +2076,7 @@ struct station_info {
 	struct rate_info rxrate;
 	u32 rx_packets;
 	u32 tx_packets;
+	u32 rx_retries;
 	u32 tx_retries;
 	u32 tx_failed;
 	u32 rx_dropped_misc;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dced2c49daec..5eee77409f00 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3846,6 +3846,8 @@ enum nl80211_sta_bss_param {
  *	of STA's association
  * @NL80211_STA_INFO_CONNECTED_TO_AS: set to true if STA has a path to a
  *	authentication server (u8, 0 or 1)
+ * @NL80211_STA_INFO_RX_RETRIES: number of rx packets(MPDUs) from this station
+ *	with retry bit set (u32)
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3894,6 +3896,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
 	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
 	NL80211_STA_INFO_CONNECTED_TO_AS,
+	NL80211_STA_INFO_RX_RETRIES,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..4aca00520bff 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6613,6 +6613,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	PUT_SINFO(RX_PACKETS, rx_packets, u32);
 	PUT_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_SINFO(RX_RETRIES, rx_retries, u32);
 	PUT_SINFO(TX_RETRIES, tx_retries, u32);
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-- 
2.34.1


