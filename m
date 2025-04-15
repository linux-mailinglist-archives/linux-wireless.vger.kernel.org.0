Return-Path: <linux-wireless+bounces-21531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA780A892C9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CAA3B7052
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C02DFA51;
	Tue, 15 Apr 2025 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RwhLPq7b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF021ABC6
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690881; cv=none; b=mliSO1ispkBzV0QoxBqBQvzB29PTMiYSg4+QqyDmmvylwO4gtHWV3Ds6U+Y9T8q0L3uf61lezEWS7rBMN2PjRU9hWmW1JXH09tmcJ2C39ymRoWl4GpjfU4HRKE/vUp4LhTfSNdIlrew51k1DQCgDRCVHA/dOOX2i1K87XJUkPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690881; c=relaxed/simple;
	bh=tJPHMceRSLZiWNM3ISsdGCWWBINOolgyMvde3H8siy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIfGQa4wf6aIaFL605nopxnC7+5I4p0WTZKUsxDN0WL9enMMVX349oPllSRIqypLNfIzTxjM/H9zcdk9n74KnK8UEBOc1uRoih1j5MQOxbZvbTI6sCH+xNCXywJ+sCqaWbp8/CLRLCrPyrXNb2JwBARXgUH+5hleey03KsM5LBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RwhLPq7b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15PSv021432;
	Tue, 15 Apr 2025 04:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+aLl+F3z0DNtgW5YtFJ+MTWrkSLCoyZyxq4pCFf9Fbc=; b=RwhLPq7bweOquahi
	2/gP8WQXBUKs1ya3UgnTI/RKxqC9+Yv2t5Zng2hVLgnDALD1EA9BreqC6Pm0boyn
	iezeQkkD9mqvPccnfUIr+YWeCUk/efWXieVhEXDlvs6+ZHgM6yAfl7zR3bUo6AyH
	4tb1ZitxH7uFtzuE8/H+93wKOQVmGFaG+Rt2BOb/OjCLyA28YPA63Ye3TV8XPbQk
	lWjS0xsIaaki91P+P3ZvwvuxFu+NQOu/6+Ae6B/aLhMHCdh+RCg4tBMfGcOl+PO9
	A73IShjW9LqG8ZplygLz4J9GDzUDe6TvOigRkZLCuC/J8vkJJzbO5bPG2HRzp55Q
	dPO3BQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69pnxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4LCrD015129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:12 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:11 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 07/11] wifi: cfg80211: add accumulated statistics for MLO links
Date: Tue, 15 Apr 2025 09:50:26 +0530
Message-ID: <20250415042030.1246187-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: rt9kmEzOdRnJg40rSt-oG3PJc-v2JUYO
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fddeb9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=XUm5qFwBoBtGpB19QqgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rt9kmEzOdRnJg40rSt-oG3PJc-v2JUYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

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

The statistics will be embedded into NL message as below:
For MLO:
cmd ->
    NL80211_ATTR_IFINDEX
    NL80211_ATTR_MAC
    NL80211_ATTR_GENERATION
    ......etc
    NL80211_ATTR_STA_INFO | nested
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
        NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nested
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
                ..........etc.
        link_id-2 | nested
        NL80211_ATTR_MLO_LINK_ID,
        NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nest flag
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
                .........etc

The output of iw dev wlan0 station dump for MLO will look like below:

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
    rx drop misc:   0
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
 include/net/cfg80211.h | 20 ++++++++++
 net/wireless/nl80211.c | 87 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 22edd98cea25..6c179d6179db 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2185,6 +2185,16 @@ struct link_station_info {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @rx_packets: total packets (MSDUs & MMPDUs) received from this station
+ * @tx_packets: total packets (MSDUs & MMPDUs) transmitted to this station
+ * @rx_bytes: total bytes (size of MPDUs) received from this station
+ * @tx_bytes: total bytes (size of MPDUs) transmitted to this station
+ * @tx_retries: cumulative retry counts (MPDUs)
+ * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
+ * @rx_dropped_misc: Dropped for un-specified reason.
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
+ * @expected_throughput: aggregated expected throughput in kbps (including
+ *	802.11 headers) towards this station.
  * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
  *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
  *	get_station() and dump_station() callbacks.
@@ -2220,6 +2230,16 @@ struct station_info {
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
 
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	u32 beacon_loss_count;
+	u32 expected_throughput;
+
 	u16 valid_links;
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0fc59e0d0f1d..36e8c45d8750 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6871,6 +6871,25 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static int nl80211_fill_mld_station(struct sk_buff *msg,
+				    struct station_info *sinfo)
+{
+	PUT_SINFO(RX_PACKETS, rx_packets, u32);
+	PUT_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_SINFO_U64(RX_BYTES, rx_bytes);
+	PUT_SINFO_U64(TX_BYTES, tx_bytes);
+	PUT_SINFO(TX_RETRIES, tx_retries, u32);
+	PUT_SINFO(TX_FAILED, tx_failed, u32);
+	PUT_SINFO(RX_DROP_MISC, rx_dropped_misc, u32);
+	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
@@ -6919,9 +6938,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	if ((rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS) &&
 	    sinfo->valid_links) {
-		/* TODO: Add accumulated stats for packets, bytes for
-		 *	 better representation at MLO level.
-		 */
+		if (nl80211_fill_mld_station(msg, sinfo))
+			goto nla_put_failure;
 
 		/* Closing nested STA_INFO as MLO links ATTR should not
 		 * be in nested STA_INFO
@@ -7000,6 +7018,65 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
+static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
+{
+	struct link_station_info *link_sinfo;
+	int link_id;
+
+	for_each_valid_link(sinfo, link_id) {
+		link_sinfo = sinfo->links[link_id];
+		if (!link_sinfo)
+			continue;
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
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC)) {
+			sinfo->rx_dropped_misc += link_sinfo->rx_dropped_misc;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BEACON_LOSS)) {
+			sinfo->beacon_loss_count += link_sinfo->beacon_loss_count;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			sinfo->expected_throughput += link_sinfo->expected_throughput;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+		}
+	}
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -7035,6 +7112,8 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (err)
 			goto out_err;
 
+		cfg80211_sta_set_mld_sinfo(&sinfo);
+
 		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
@@ -7077,6 +7156,8 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	cfg80211_sta_set_mld_sinfo(&sinfo);
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		cfg80211_sinfo_release_content(&sinfo);
-- 
2.34.1


