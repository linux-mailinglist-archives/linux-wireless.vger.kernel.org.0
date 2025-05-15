Return-Path: <linux-wireless+bounces-22981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A168CAB7D42
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3065E4A2C6F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690629346C;
	Thu, 15 May 2025 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PTDeNnnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9E1D79A0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288175; cv=none; b=p5jJskI3rJkqHhcgZYUYvRO1cCpe1+0vZzuE6yD+wkGpcIlEXsN6Wigduwl1X7T4tKlo3ziscPUZTHWgEK51m/FeB4L9gLWcongS3pKSmrR6UjPETB0kWHcyVDttjXRmOV4IysCb3bQrHeCqWXGqcsezU85uvMaMZH3N9bE4r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288175; c=relaxed/simple;
	bh=EYcMfQnmP77ygz6Ce2gFVMvRcf48aMTrsgwpDFXiZyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7JV36WjI/95lXw5MuskDIvufwzOfIW+GDtRJT0mj1MLgFWZrYB2NP++UrM9qTqN6+HzDf/lEaEinnR0CWyx3JqDj5A9g8HniYZvBpQspgnOGa+dOd1gP6BsZ/Ewig1fdgGOyoA2ppvXdJNcbWDauum7LXOVqg3nObyudVhDmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PTDeNnnf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKqpJE025440;
	Thu, 15 May 2025 05:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NEE7wcvGgLsrY2J6DDTVKpYwlk3eIVVNHQUBk1uL9s=; b=PTDeNnnfTYD2HsXT
	ONZrHbakZJrC5v+SnooJZckJYcb4/UlxgNot8K26VY8IRZUDFefEFWWZ8NDl9HMK
	z8ahIJOeeOYHJRoppoOkblnqrZE4vdsIVBSjc5YRw+o8XBRxJMsO7niD9tsmRa72
	dL4TkSZNYkK4Q1jOT5jMuZGLvDdPp3PF/X+0uMXVrc3a7LoK3dK7CGlbOOXnLQc3
	kokVB7v8zrcIF/teAVxiDayLVyCxwtsZChU49e9epPAPrZcouLCvQ+Mqv4CRBAot
	/jvghWusppkOWfqtJAF1dbBiuSRRULIxSQjSNoWNwph5VjenNBkh504f2LfLRDx7
	yzugnQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew4y8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nS86030703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:28 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:27 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 04/10] wifi: cfg80211: add statistics for providing overview for MLO station
Date: Thu, 15 May 2025 11:18:58 +0530
Message-ID: <20250515054904.1214096-5-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: lvJblOkdwq7xahfV6wCKDKUJD3of_fkj
X-Proofpoint-ORIG-GUID: lvJblOkdwq7xahfV6wCKDKUJD3of_fkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfXxDQ4Of/UOHtL
 1krwZctnCgKoa7wv0wRgkAcL8DZq5vcmMA8ZASxQHeykqP92yuIKOj2ep7fYr08UqM42fzDYZcD
 edNPP89G90Vy0FWXDTK/52hcA2axya+rIOl4fexAMyWOur8UeY+E+wHT0EXtfwWJl3K9K3Ll3Wi
 ZQk50ylLVEzdbaJHu85lZq0dSryUT9mZWO99ogvjrME1QnJmn+cz2J5ydWdFyb8rkzTrHJue8rM
 AeOmOvFoJxUKC+ij79yo3mEtiGcKAeGFqeg1w0G+uvf37EklLkavx333QQNFQM056WVQ/dvyHf+
 GTJ6HiN4f5pfFCgMz+ZXiAyH6Z7j/0OGN9KTdcUcv0ojpWt9GUo0cNjXX4EueWCdYCtCfa75+rk
 Z6/RYWSpBjs/U5MV1x4Guz2WawLBXnOHG5InXTI8oFre727dTKTWvZFgDzCT7ea55JtOw5f7
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68258069 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=_UDe_yRPNXFXODxl5TUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

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
index 7cf1db9b012d..9095a8304d1d 100644
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
+		     sinfo->bss_param.dtim_period >
+		      link_sinfo->bss_param.dtim_period)) {
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


