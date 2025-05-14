Return-Path: <linux-wireless+bounces-22948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BBAAB71E4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5B178539
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1827EC9C;
	Wed, 14 May 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MGPs7gq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E127C172
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241373; cv=none; b=u6WZKRS/aJ4Ayogj4h0mj2NJHlKjCOLI4wwwbN+1n38rQnBa/O9XcmH6kdhMoO3tkRw4PS864aOn691q3HJqbBdZUCy5z842PBZRbRCzoAOu5pbdRV2InjraEwIS2o21g9ROxFqpGBR7OTt4e/kemAZ57nuzwFPtCu4w7k6rOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241373; c=relaxed/simple;
	bh=5I3eZRTgPyfyjpctNyohCDzzL2mnBftyDTylIc63qaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xi0V2wsFyV/jPx2muQmbQy19839Yy53mI43rfR1kOL7/j6am7mC9Q3PiMispM/+BkXg2/caxPTbBQ1jFD1yOsQoApalG8cvsnZ+q52dmF7bEAxqQGW52gdgIH2KnTEmAA6TLIAWL485xIF2y8iuhileKvH/m+/4MeotcIiOUioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MGPs7gq9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuhoN002756;
	Wed, 14 May 2025 16:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WAaqg8uhzK/nyRUufPPCDjuZd1BLPDUDie+NtI+c72E=; b=MGPs7gq9qDD8S6e2
	dxg1YItLll0axwvj2GqCi19fi33pJ8tWfCu/waoSCfcK1nYLi9w+Uq+tGEe16+Qu
	vOh8lfYtz9Bl5ZKt0o+8bJwJaA0tNYE8tmXOPCXutIZNoVEqorBFOdf/uk4+Vd5Z
	YfScc8p7Q7tRBlgWWFIycroiztOeZ05uTv2YtuLp5fd0NJI28uuBKlhBGf3i6urc
	Bc5daaYAa6eMAaSWM8YKm2WCl/D8vG9hifRSVGeZBeZz1SX2tC0krpLArHT06fQ3
	Noa2T62nnqLVE8NvcuR0Qlam/XqmiAEOMOeNbqeS4R8XTd/IGuembMUQ8IW+MyUM
	UuwP7Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpbdea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnQnC027801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:26 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:25 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 04/10] wifi: cfg80211: add statistics for providing overview for MLO station
Date: Wed, 14 May 2025 22:18:51 +0530
Message-ID: <20250514164857.227540-5-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: pb293xGVHeZJ24kSFaQoiAOf-74V86d7
X-Proofpoint-ORIG-GUID: pb293xGVHeZJ24kSFaQoiAOf-74V86d7
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=6824c997 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=_UDe_yRPNXFXODxl5TUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfXx+DUYfCP1CWo
 wc+BKQ1XFxx9wSYk9trGc+QgMAc0ZDjgOfSg3Csc2AkjVz4DihUBKBpKAznexrocrkqj6XmJOyf
 QRSL5YDDm5dK1no73EoKgqVhNgZ8H5ZNB99YgnzWmG9GovxSJKZh712fK28k7M5YsF65YYM0nqp
 qMwxqGARz5j4XWubMQGJ0mhJjBPy+QnY1LAv6in5eL1ekw8I6QunA05ejWOi+nOryvdtkjlkyDg
 YA7q6iJxHJ7xQn3BQBxCQ3QKGJCBMo/yA1WJbvAH6dzs+VpIrRKeLWS0M7Vqn0ZqGI8TWmBl0gb
 xvaq0gN+magz5Fmw5nj6rw9VaoPrx8NlFPmObWB52E6ma3cmYXl+LNj/29ICQ/r7GlnUwtxdgud
 6dQI6hDxz5dl1+4ajKDlm36WVPD0fvih36Um0c/OXLTZ4ItTe3KckrL0G9H9yA/7VxgjxLCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140151

Currently statistics are handled at link level for multi-link
operation(MLO). There is no provision to check accumulated statistics
for a multi-link(ML) station. Other statistics, such as signal, rates,
are also managed at the link level only.

Statistics such as packets, bytes, signal, rates, etc are useful to
provide overall overview for the ML stations.

Statistics such as packets, bytes are accumulated statistics at MLO level.
However, MLO statistics for rates and signal can not be accumulated since
it won't make much sense. Hence, handle other statistics such as signal,
rates, etc bit differently at MLO level.

The signal could be the best of all links-
e.g. if Link 1 has a signal strength of -70 dBm and Link 2 has -65 dBm,
the signal for MLO will be -65 dBm.

The rate could be determined based on the most recently updated link-
e.g. if link 1 has a rate of 300 Mbps and link 2 has a rate of 450 Mbps,
the MLO rate can be calculated based on the inactivity of each link.
If the inactive time for link 1 is 20 seconds and for link 2 is 10 seconds,
the MLO rate will be the most recently updated rate, which is link 2's
rate of 450 Mbps.

The inactive time, dtim_period and beacon_interval can be taken as the
least value of field from link level.

Similarly, other MLO level applicable fields are handled and the fields
which don't make much sense at MLO level, a subsequent change will handle
to embed NL message.

Hence, add accumulated and other statistics for MLO station if valid links
are present to represent comprehensive overview for the ML stations.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 185 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7cf1db9b012d..a5c760605ce9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7173,6 +7173,185 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	return -EMSGSIZE;
 }
 
+static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
+					   struct rate_info *link_sinfo_rate)
+{
+	sinfo_rate->flags = link_sinfo_rate->flags;
+	sinfo_rate->legacy = link_sinfo_rate->legacy;
+	sinfo_rate->mcs = link_sinfo_rate->mcs;
+	sinfo_rate->nss = link_sinfo_rate->nss;
+	sinfo_rate->bw = link_sinfo_rate->bw;
+	sinfo_rate->he_gi = link_sinfo_rate->he_gi;
+	sinfo_rate->he_dcm = link_sinfo_rate->he_dcm;
+	sinfo_rate->he_ru_alloc = link_sinfo_rate->he_ru_alloc;
+	sinfo_rate->n_bonded_ch = link_sinfo_rate->n_bonded_ch;
+	sinfo_rate->eht_gi = link_sinfo_rate->eht_gi;
+	sinfo_rate->eht_ru_alloc = link_sinfo_rate->eht_ru_alloc;
+}
+
+static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
+{
+	struct link_station_info *link_sinfo;
+	int link_id, init = 0;
+	u32 link_inactive_time;
+
+	sinfo->signal = -99;
+
+	for_each_valid_link(sinfo, link_id) {
+		link_sinfo = sinfo->links[link_id];
+		if (!link_sinfo)
+			continue;
+
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
+			sinfo->tx_packets += link_sinfo->tx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		}
+
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
+			sinfo->rx_packets += link_sinfo->rx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		}
+
+		if (link_sinfo->filled &
+		    (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+		     BIT_ULL(NL80211_STA_INFO_TX_BYTES64))) {
+			sinfo->tx_bytes += link_sinfo->tx_bytes;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+		}
+
+		if (link_sinfo->filled &
+		    (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+		     BIT_ULL(NL80211_STA_INFO_TX_BYTES64))) {
+			sinfo->rx_bytes += link_sinfo->rx_bytes;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_TX_RETRIES)) {
+			sinfo->tx_retries += link_sinfo->tx_retries;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED)) {
+			sinfo->tx_failed += link_sinfo->tx_failed;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC)) {
+			sinfo->rx_dropped_misc += link_sinfo->rx_dropped_misc;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_BEACON_LOSS)) {
+			sinfo->beacon_loss_count +=
+				link_sinfo->beacon_loss_count;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			sinfo->expected_throughput +=
+				link_sinfo->expected_throughput;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_TX_DURATION)) {
+			sinfo->tx_duration += link_sinfo->tx_duration;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_RX_DURATION)) {
+			sinfo->rx_duration += link_sinfo->rx_duration;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_MPDUS)) {
+			sinfo->rx_mpdu_count += link_sinfo->rx_mpdu_count;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_MPDUS);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_FCS_ERROR_COUNT)) {
+			sinfo->fcs_err_count += link_sinfo->fcs_err_count;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_FCS_ERROR_COUNT);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_BEACON_RX)) {
+			sinfo->rx_beacon += link_sinfo->rx_beacon;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
+		}
+
+		/* Update MLO signal, signal_avg as best among links */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) &&
+		    link_sinfo->signal > sinfo->signal) {
+			sinfo->signal = link_sinfo->signal;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		}
+
+		if ((link_sinfo->filled &
+			BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG)) &&
+		    link_sinfo->signal_avg > sinfo->signal_avg) {
+			sinfo->signal_avg = link_sinfo->signal_avg;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		}
+
+		/* Update MLO inactive_time, bss_param based on least
+		 * value for corresponding field of link.
+		 */
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME)) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			link_inactive_time = link_sinfo->inactive_time;
+			sinfo->inactive_time = link_sinfo->inactive_time;
+			sinfo->filled |= NL80211_STA_INFO_INACTIVE_TIME;
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM) &&
+		    (!init ||
+		     (sinfo->bss_param.dtim_period >
+		      link_sinfo->bss_param.dtim_period))) {
+			sinfo->bss_param.dtim_period =
+				link_sinfo->bss_param.dtim_period;
+			sinfo->filled |= NL80211_STA_BSS_PARAM_DTIM_PERIOD;
+			sinfo->bss_param.beacon_interval =
+				link_sinfo->bss_param.beacon_interval;
+			sinfo->filled |= NL80211_STA_BSS_PARAM_BEACON_INTERVAL;
+		}
+
+		/* Update MLO rates as per last updated link rate */
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			cfg80211_sta_set_mld_rate_info(&sinfo->txrate,
+						       &link_sinfo->txrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		}
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			cfg80211_sta_set_mld_rate_info(&sinfo->rxrate,
+						       &link_sinfo->rxrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		}
+		init++;
+	}
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -7208,6 +7387,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (err)
 			goto out_err;
 
+		if (sinfo.valid_links)
+			cfg80211_sta_set_mld_sinfo(&sinfo);
+
 		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
@@ -7256,6 +7438,9 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	}
 
+	if (sinfo.valid_links)
+		cfg80211_sta_set_mld_sinfo(&sinfo);
+
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
 				 rdev, dev, mac_addr, &sinfo) < 0) {
-- 
2.34.1


