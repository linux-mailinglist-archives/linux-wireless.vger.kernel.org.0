Return-Path: <linux-wireless+bounces-23455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4F1AC615C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F87A8D35
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C851C84B2;
	Wed, 28 May 2025 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQlBQrhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A1FDA8C
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411091; cv=none; b=lLxOES2m7JOFKH0mOH5GxBvijtbf83WeEi2ViIkjkchG4DacuKOAl61gOBc6IeNOOi98/Hh2k1xrrQsLW+YLY2IryyQQ1Jfk3J82wtYZYxhYyjzufxBc+Qz6ipTkF9OXOxldqBrtuPwjjgEgODbYggVO+0MPmFuzFLT0U0igOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411091; c=relaxed/simple;
	bh=omYrAMPWdfvAlqv4qswqNcys31uV3Mjv/Mqw3AkAIqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz73CxMuvjLtf5ETiNGTognSDOHX22Dkd0vkXNKN66whJXuPWY7UZAa6LXVgIHbd4N1NG/UmG/r3RUfsLrzHt9n5HiC7v28jkIBFLBOD90sE11MHxqinNtjRnFnTwcHnTa0HKWbU8/7Y98Yh69I4c6hZslbxYvlwChWAfjn0Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQlBQrhW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RIHwBi000710;
	Wed, 28 May 2025 05:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgiTqKM6XGL7q3fVy27MNaYSV2Mtb5INZBOgwtFFQxY=; b=LQlBQrhWxyVPks2c
	abwVZO167mSLjFZ02qrgJlStcpkPonV7SMJ45I4EvSn9jNUkXSLiFz3/O17SAN0S
	zDwt8H01N076i6eT29c0PJCHIFjF7xa4DQmOuuR2pIADIl0j+jnylRhfERkk2KNW
	EIqGN32cVR7VUMQWrPEnNES6mR3GBEhGq5CidISShtha9aAst3lF6Tv1zafpyIwc
	zJLu2l6zf/3ER5QTCqvjVlBQ9YqLky0Mf71X98T07zbMTm539LNfa4aIMB3LKBdr
	AvxMVWcpAWsMehESt6auVBISqISZSLwl8kqGuZEplOGJ5oHmiU0XOkWgMVszZxhz
	iWKo9Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g9160t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5ihCG010082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:44 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:42 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 03/10] wifi: cfg80211: extend to embed link level statistics in NL message
Date: Wed, 28 May 2025 11:14:13 +0530
Message-ID: <20250528054420.3050133-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6836a2cc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=7-IUW0_vBe_i1FHhtu4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -iF6QT2SV_gJgOdoeduWlc8QuUcbe7-o
X-Proofpoint-GUID: -iF6QT2SV_gJgOdoeduWlc8QuUcbe7-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfXyJDH+89KnEQY
 r4jEdIPfnEMRZUiBmMvuMc0Dda5c6yN94E6XRi1fSDsmtHvQfFk0vt2Xf0Hz63IeZRF8WoYUBCE
 OGoaSL8IftUpt0VMxBVrLrT4qzPBhKnlH9FNHp8hiIEbIKqFq5hn+PO7hyglvxF8YkWEVztGqmf
 KH96NyMNRnl9NThW3TY7JKp6H+mIpMO+y12m13vaTsoKKN53Bp2iFNyY1J5QUmKvECrCsTmnk3x
 8dN1ZlzDZYjtXtmKGAo9qWaecFFi6KIIpmR7lr2qJG8C574++jNSTJ8u0Uz9OGMvHp3Jsx85qQ4
 FuWluTMf8c3KC4Sfx4/m9iOukNPu0rNip3oQf4mYeeyz1G3tpyzUDCMp13VpvXTfvObnB4uIu/f
 mxfpGXv1stG7OKzvygvF/K0gL/HflqrYlueiz21gVLMfkFVjTmfwDYuTCZtFcZQ9P+M8i/+k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=956
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280049

Currently, statistics is supported at deflink( or one of the links)
level for station. This has problems when applied to multi-link(ML)
connections.

Hence, add changes to support link level statistics to embed NL message
with link related information if valid links are present.

This will be helpful to check the link related statistics during MLO.

The statistics will be embedded into NL message as below:
For non-ML:
cmd->
    NL80211_ATTR_IFINDEX
    NL80211_ATTR_MAC
    NL80211_ATTR_GENERATION
    ....etc
    NL80211_ATTR_STA_INFO | nested
        NL80211_STA_INFO_CONNECTED_TIME,
        NL80211_STA_INFO_STA_FLAGS,
        NL80211_STA_INFO_RX_BYTES,
        NL80211_STA_INFO_TX_BYTES,
        .........etc

For MLO:
cmd ->
    NL80211_ATTR_IFINDEX
    NL80211_ATTR_MAC
    NL80211_ATTR_GENERATION
    .......etc
    NL80211_ATTR_STA_INFO | nested
        NL80211_STA_INFO_CONNECTED_TIME,
        NL80211_STA_INFO_STA_FLAGS,
        ........etc
    NL80211_ATTR_MLO_LINK_ID,
    NL80211_ATTR_MLD_ADDR,
    NL80211_ATTR_MLO_LINKS | nested
        link_id-1 | nested
            NL80211_ATTR_MLO_LINK_ID,
            NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nested
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
               NL80211_STA_INFO_CONNECTED_TIME,
               ..........etc.
        link_id-2 | nested
            NL80211_ATTR_MLO_LINK_ID,
            NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nested
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
               NL80211_STA_INFO_CONNECTED_TIME,
                .........etc

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 216 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..4307d732c11f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6728,6 +6728,185 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 	return true;
 }
 
+static int nl80211_fill_link_station(struct sk_buff *msg,
+				     struct cfg80211_registered_device *rdev,
+				     struct link_station_info *link_sinfo)
+{
+	struct nlattr *bss_param, *link_sinfoattr;
+
+#define PUT_LINK_SINFO(attr, memb, type) do {				\
+	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
+			     link_sinfo->memb))				\
+		goto nla_put_failure;					\
+	} while (0)
+#define PUT_LINK_SINFO_U64(attr, memb) do {				\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
+			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
+		goto nla_put_failure;					\
+	} while (0)
+
+	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	if (!link_sinfoattr)
+		goto nla_put_failure;
+
+	PUT_LINK_SINFO(INACTIVE_TIME, inactive_time, u32);
+
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
+	    nla_put_u32(msg, NL80211_STA_INFO_RX_BYTES,
+			(u32)link_sinfo->rx_bytes))
+		goto nla_put_failure;
+
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+			     BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
+	    nla_put_u32(msg, NL80211_STA_INFO_TX_BYTES,
+			(u32)link_sinfo->tx_bytes))
+		goto nla_put_failure;
+
+	PUT_LINK_SINFO_U64(RX_BYTES64, rx_bytes);
+	PUT_LINK_SINFO_U64(TX_BYTES64, tx_bytes);
+	PUT_LINK_SINFO_U64(RX_DURATION, rx_duration);
+	PUT_LINK_SINFO_U64(TX_DURATION, tx_duration);
+
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+		PUT_LINK_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
+
+	switch (rdev->wiphy.signal_type) {
+	case CFG80211_SIGNAL_TYPE_MBM:
+		PUT_LINK_SINFO(SIGNAL, signal, u8);
+		PUT_LINK_SINFO(SIGNAL_AVG, signal_avg, u8);
+		break;
+	default:
+		break;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal,
+					NL80211_STA_INFO_CHAIN_SIGNAL))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal_avg,
+					NL80211_STA_INFO_CHAIN_SIGNAL_AVG))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->txrate,
+					  NL80211_STA_INFO_TX_BITRATE))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->rxrate,
+					  NL80211_STA_INFO_RX_BITRATE))
+			goto nla_put_failure;
+	}
+
+	PUT_LINK_SINFO(RX_PACKETS, rx_packets, u32);
+	PUT_LINK_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_LINK_SINFO(TX_RETRIES, tx_retries, u32);
+	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
+	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
+	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
+		bss_param = nla_nest_start_noflag(msg,
+						  NL80211_STA_INFO_BSS_PARAM);
+		if (!bss_param)
+			goto nla_put_failure;
+
+		if (((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_CTS_PROT) &&
+		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_CTS_PROT)) ||
+		    ((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
+		     nla_put_flag(msg,
+				  NL80211_STA_BSS_PARAM_SHORT_PREAMBLE)) ||
+		    ((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
+		     nla_put_flag(msg,
+				  NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME)) ||
+		    nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
+			       link_sinfo->bss_param.dtim_period) ||
+		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
+				link_sinfo->bss_param.beacon_interval))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, bss_param);
+	}
+
+	PUT_LINK_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
+	PUT_LINK_SINFO_U64(BEACON_RX, rx_beacon);
+	PUT_LINK_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
+	PUT_LINK_SINFO(RX_MPDUS, rx_mpdu_count, u32);
+	PUT_LINK_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
+		PUT_LINK_SINFO(ACK_SIGNAL, ack_signal, u8);
+		PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
+	}
+
+#undef PUT_LINK_SINFO
+#undef PUT_LINK_SINFO_U64
+
+	if (link_sinfo->pertid) {
+		struct nlattr *tidsattr;
+		int tid;
+
+		tidsattr = nla_nest_start_noflag(msg,
+						 NL80211_STA_INFO_TID_STATS);
+		if (!tidsattr)
+			goto nla_put_failure;
+
+		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
+			struct cfg80211_tid_stats *tidstats;
+			struct nlattr *tidattr;
+
+			tidstats = &link_sinfo->pertid[tid];
+
+			if (!tidstats->filled)
+				continue;
+
+			tidattr = nla_nest_start_noflag(msg, tid + 1);
+			if (!tidattr)
+				goto nla_put_failure;
+
+#define PUT_TIDVAL_U64(attr, memb) do {					\
+	if (tidstats->filled & BIT(NL80211_TID_STATS_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_TID_STATS_ ## attr,		\
+			      tidstats->memb, NL80211_TID_STATS_PAD))	\
+		goto nla_put_failure;					\
+	} while (0)
+
+			PUT_TIDVAL_U64(RX_MSDU, rx_msdu);
+			PUT_TIDVAL_U64(TX_MSDU, tx_msdu);
+			PUT_TIDVAL_U64(TX_MSDU_RETRIES, tx_msdu_retries);
+			PUT_TIDVAL_U64(TX_MSDU_FAILED, tx_msdu_failed);
+
+#undef PUT_TIDVAL_U64
+			if ((tidstats->filled &
+			     BIT(NL80211_TID_STATS_TXQ_STATS)) &&
+			    !nl80211_put_txq_stats(msg, &tidstats->txq_stats,
+						   NL80211_TID_STATS_TXQ_STATS))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, tidattr);
+		}
+
+		nla_nest_end(msg, tidsattr);
+	}
+
+	nla_nest_end(msg, link_sinfoattr);
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
@@ -6736,6 +6915,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 {
 	void *hdr;
 	struct nlattr *sinfoattr, *bss_param;
+	struct link_station_info *link_sinfo;
+	struct nlattr *links, *link;
+	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6950,6 +7132,40 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
+	if (sinfo->valid_links) {
+		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!links)
+			goto nla_put_failure;
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sinfo = sinfo->links[link_id];
+
+			if (WARN_ON_ONCE(!link_sinfo))
+				continue;
+
+			if (!is_valid_ether_addr(link_sinfo->addr))
+				continue;
+
+			link = nla_nest_start(msg, link_id + 1);
+			if (!link)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+				       link_id))
+				goto nla_put_failure;
+
+			if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				    link_sinfo->addr))
+				goto nla_put_failure;
+
+			if (nl80211_fill_link_station(msg, rdev, link_sinfo))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, link);
+		}
+		nla_nest_end(msg, links);
+	}
+
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
2.34.1


