Return-Path: <linux-wireless+bounces-17279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C641A0862C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF91B1888078
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30872063E4;
	Fri, 10 Jan 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pDgylDKI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9E126C10
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483166; cv=none; b=fuXYZpyC2DduutyN4ZYfAp0JS4pGpFXGp7JAPzkyDyIm9TH5fexjLKAephKHecmVmWLk47wL/0e+jLG4UOEyb2oqDpdWh74Du1KriGn1+9edsuzvpMIO4Gkd1rt+NoPwa0INmSgh+GMPBNko7JDHkE5bFaicGwN2aM568a5CUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483166; c=relaxed/simple;
	bh=VWp46MBrIaZYonBOBR9LrQrncnpbz3OCTeOZ/e8RcXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQ9aBKfHdB+BS5gWhQO+hvzAU8xTiZTJ2ce7yw860CEA9+rMFFnvCXN9hKSVfbZamHLoHwN/GaynDQs8w5GYXhGr63pal1o92/cHMMiA9jHMebJLAA1oML6ZVYeGYcrB9OW98NkxpWwRW/qEudwztheXgFi9GWDFFOUlv7fkI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pDgylDKI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3vWSq016225;
	Fri, 10 Jan 2025 04:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pukuwWpLrCdyIy3wbKkUTDSjEz89WUi7SrjL9OffzMQ=; b=pDgylDKI9+QuTmoJ
	HJOPGWgchpBXCyjvOmKD6BpkyPp2j4vvjaxWyTugbrOd32usSKd9IqLULQ0Px3/h
	2E8yG4+hyb7lcofGSkg1nrOecrPYCaChrN/2WhdiQHt9xSpyufCBDm/pifulTTm2
	9/Hw+29wl6fE9d2CtJyi6xMTjE+J2MjG5vhIztF6VqETrqWJm01lKNBUVQ+NvcNz
	c2DWYN0TmdlEyNzDel6cY9iH3gMSWZJDB3ummAg/DeuPc7TKa0q4nwsFMzCRwoE7
	KMNpHNkE7Eys8QTtanPG/Iv+1+Z8tM9Oum8gUE3J80YZPdgnrVPItu8SmivgY1tT
	ZRWtPw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442v3rg1ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4Pi9t010989
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:44 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:42 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 4/7] wifi: cfg80211: add accumulated statistics for MLO links
Date: Fri, 10 Jan 2025 09:54:46 +0530
Message-ID: <20250110042449.1158789-5-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: IaTqILDyDCx0AzyBWxAxNIwpcnkix2WK
X-Proofpoint-ORIG-GUID: IaTqILDyDCx0AzyBWxAxNIwpcnkix2WK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

Currently statistics are handled at link level for multi-link
operation(MLO). There is no provision to check accumulated statistics
for a multi-link(ML) station. Accumulated statistics are useful to
provide comprehensive overview for the ML stations.

Statistics such as packets and bytes are useful for observing the
total packets sent and received at the station level. However,
MLO statistics for rates and signal can not be accumulated since it
won't make much sense. Hence, a subsequent change will handle signal
and rates bit differently at MLO level.

Hence, add accumulated statistics for MLO station. Also, for non-ML
station accumulated statistics make no sense.

The statistics could be embedded into NL message as below:
For MLO:
cmd ->
	NL80211_ATTR_IFINDEX
	NL80211_ATTR_MAC
	NL80211_ATTR_GENERATION
	......etc
	NL80211_ATTR_STA_INFO | nest flag
		NL80211_STA_INFO_CONNECTED_TIME,
		NL80211_STA_INFO_STA_FLAGS,
		NL80211_STA_INFO_RX_BYTES, //accumulated data
		NL80211_STA_INFO_TX_BYTES,
		......etc
	NL80211_ATTR_MLO_LINK_ID,
	NL80211_ATTR_MLD_ADDR,
	NL80211_ATTR_MLO_LINKS | nested
		link_id-1 | nested
		NL80211_ATTR_MLO_LINK_ID,
		NL80211_ATTR_MLD_ADDR,
			NL80211_ATTR_STA_INFO | nest flag
				NL80211_STA_INFO_RX_BYTES,
				NL80211_STA_INFO_TX_BYTES,
				..........etc.
		link_id-2 | nested
		NL80211_ATTR_MLO_LINK_ID,
		NL80211_ATTR_MLD_ADDR,
			NL80211_ATTR_STA_INFO | nest flag
				NL80211_STA_INFO_RX_BYTES,
				NL80211_STA_INFO_TX_BYTES,
				.........etc

The output of iw dev wlan0 station dump for MLO could look like below:

Station 00:03:7f:04:31:78 (on wlan0)
	authorized:     yes
	authenticated:  yes
	associated:     yes
	preamble:       long
	WMM/WME:        yes
	MFP:            yes
	TDLS peer:      no
	connected time: 383 seconds
	associated at [boottime]:       93.740s
	associated at:  93685 ms
        rx bytes:       1439
        rx packets:     15
        tx bytes:       1538
        tx packets:     8
        tx retries:     0
        tx failed:      0
	current time:   474340 ms
        MLD address: 00:03:7f:04:31:78
        Link 0:
                Address: 00:03:7f:04:31:78
                inactive time:  330120 ms
                rx bytes:       116
                rx packets:     3
                tx bytes:       0
                tx packets:     0
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -95 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2669 us
                rx duration:    0 us
                DTIM period:    2
                beacon interval:100
        Link 1:
                Address: 00:03:7f:04:31:79
                inactive time:  81268 ms
                rx bytes:       1323
                rx packets:     12
                tx bytes:       1538
                tx packets:     8
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -95 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2669 us
                rx bitrate:     6.0 MBit/s
	        rx duration:    0 us
                DTIM period:    2
                beacon interval:100

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h  | 13 +++++++++++
 net/mac80211/sta_info.c | 50 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c  | 36 ++++++++++++++++++++++++++---
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5b0ec0394715..ac038903d53e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2174,6 +2174,12 @@ struct link_station_info {
  * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
  *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
  *	get_station() and dump_station() callbacks.
+ * @rx_packets: packets (MSDUs & MMPDUs) received from this station
+ * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @rx_bytes: bytes (size of MPDUs) received from this station
+ * @tx_bytes: bytes (size of MPDUs) transmitted to this station
+ * @tx_retries: cumulative retry counts (MPDUs)
+ * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @deflink: This holds the default link STA information, for non MLO STA
  *	all link specific STA information is accessed through @deflink.
  * @links: reference to Link sta entries for MLO.
@@ -2206,6 +2212,13 @@ struct station_info {
 	size_t assoc_resp_ies_len;
 
 	u16 valid_links;
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+
 	struct link_station_info deflink;
 	/* TODO: Need to check and add protection access to links memory */
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6be5c05b686a..f4492174d2c4 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2836,6 +2836,55 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	}
 }
 
+static void sta_set_mld_sinfo(struct station_info *sinfo, struct sta_info *sta)
+{
+	struct link_station_info *link_sinfo;
+	struct link_sta_info *link_sta;
+	int link_id;
+
+	for_each_valid_link(sinfo, link_id) {
+		link_sta =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+		if (!link_sta)
+			continue;
+
+		link_sinfo = sinfo->links[link_id];
+
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
+			sinfo->tx_packets += link_sinfo->tx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		}
+
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
+			sinfo->rx_packets += link_sinfo->rx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		}
+
+		if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+					   BIT_ULL(NL80211_STA_INFO_TX_BYTES64))) {
+			sinfo->tx_bytes += link_sinfo->tx_bytes;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+		}
+
+		if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+					   BIT_ULL(NL80211_STA_INFO_TX_BYTES64))) {
+			sinfo->rx_bytes += link_sinfo->rx_bytes;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES)) {
+			sinfo->tx_retries += link_sinfo->tx_retries;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED)) {
+			sinfo->tx_failed += link_sinfo->tx_failed;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		}
+	}
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -2905,6 +2954,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
 			sinfo->links[link_id] = link_sinfo;
 		}
+		sta_set_mld_sinfo(sinfo, sta);
 	} else {
 		link_sinfo = &sinfo->deflink;
 		link_sinfo->link_id = -1;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 37a8cbb1022a..06688aa1780f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6838,6 +6838,36 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 	return 0;
 }
 
+static int nl80211_fill_mld_station(struct sk_buff *msg,
+				    struct station_info *sinfo)
+{
+#define PUT_SINFO(attr, memb, type) do {				\
+	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
+			     sinfo->memb))				\
+		return -EMSGSIZE;					\
+	} while (0)
+#define PUT_SINFO_U64(attr, memb) do {					\
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
+			      sinfo->memb, NL80211_STA_INFO_PAD))	\
+		return -EMSGSIZE;					\
+	} while (0)
+
+	PUT_SINFO(RX_PACKETS, rx_packets, u32);
+	PUT_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_SINFO_U64(RX_BYTES, rx_bytes);
+	PUT_SINFO_U64(TX_BYTES, tx_bytes);
+	PUT_SINFO(TX_RETRIES, tx_retries, u32);
+	PUT_SINFO(TX_FAILED, tx_failed, u32);
+
+#undef PUT_SINFO
+#undef PUT_SINFO_U64
+
+	return 0;
+}
+
 static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
@@ -6912,9 +6942,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO_U64
 
 	if (sinfo->valid_links) {
-		/* TODO: Add accumulated stats for packets, bytes for
-		 *	 better representation at MLO level.
-		 */
+		ret = nl80211_fill_mld_station(msg, sinfo);
+		if (ret)
+			goto nla_put_failure;
 
 		/* Closing nested STA_INFO as MLO links ATTR should not
 		 * be in nested STA_INFO
-- 
2.34.1


