Return-Path: <linux-wireless+bounces-22980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64242AB7D41
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B431C9E0B88
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2E292901;
	Thu, 15 May 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="puzH6tmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5629346C
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288174; cv=none; b=ROeaR/NCpmVATUjGYvlcyEN2ZmnAiAf94k2v4WLNfGY3v2AkFB/K2RrlKTCXCzCccdbKqzsO4UQcuDQM6N7dlWkDI10UPSs7eV52/kiRadJCfBMX86QgzD6cK/XRs0Ob6rvG0BUEJqTDYR5N8sShylpnbHueiUXrXJMNM+lfHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288174; c=relaxed/simple;
	bh=JzjEMVvhvETzTB+MjY8ZmId5ODvECu0lMH1y4C4ShCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di3s45WmgYt4fmt6ojCmrz9UuYYAlBh8q1K/TlsQc42S+mkYHXtHkPvWeow8D1USP4eeYprju+d94og0dXmiXXi+hvSV4UR2iad+Jw1qmsCZ7O2MuxFAEwTH/d0QLIvsHtvTxoO85aKUgxvyefiNI4AaH8jNEZ8zEokt635bkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=puzH6tmj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ELSc8H015169;
	Thu, 15 May 2025 05:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JWHFDIE0pYnuSFvcq7LhqbOW4ZmIoEAMDhJJB7wUXrE=; b=puzH6tmjSwHR0G5l
	JbiLfaeb60yJkUyewVrrQGHWHINCgLsXfDMxhSPK01NWy6vB4OIPccmeV3rE7/nM
	udeUH3duw5ejoIPwpTCQEDL/Y5cEW+MRn5td2cgjWa6SQgM4WJAMf5Fk4/8oNBiP
	gF4g0GzLVKDFkj0ugmSvXn48Ok8owDwNpgt1572yiSl4AYhlqB2yraW+rmSbOyt5
	VpbVtDzat6p/wyiXCCkE02+soa9OUA5ctvLRYACKaPSHIlc9ZuLhAI7HJ9AyppgQ
	IJmYnoStbwOCh9JerX33dA7BbQv3islmG8Dm0bPQk2iwHLMllAubvNyfZpI/Ae0U
	oNDmww==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr4x46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nRIe010517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:27 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:25 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed link level statistics in NL message
Date: Thu, 15 May 2025 11:18:57 +0530
Message-ID: <20250515054904.1214096-4-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5g6FCrXIfMvAGFl0AkuSUo933uuZb-gV
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=68258068 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=7-IUW0_vBe_i1FHhtu4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5g6FCrXIfMvAGFl0AkuSUo933uuZb-gV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX6TsrklDpMil2
 favEj2jPJFxjbboDRYURqitwBwCODed/1Jr/XhGyFAz0N+DdoBfm332eZKAeH82l9GDq6JOmcUr
 TixhYnPwp+kL2xDqv7u2YvmPp51r9A4rqdC6hjo60ASTNDrFSggNfTNmHkXSjRlcib61T5KK46G
 Uyjp6+KRg+zWwDJpd4kCYkY6cBGcYEsvueHa3oiOfwdg0HLpOdc4fFWxFUFV1k8C57vFbwDdMfW
 CeEwgiSdKOl1IFwiIDX/WMMGxsEycaV0Nl4//AEN2pZe9Wykyo5uXyIvb2Q0OYM7sPwQdCtRr7T
 CFpxAg4I7K8Nhf1GVzLROnL6EsGPTWQFUUPo658lqv5Lac2lXXnDUWZLbP8uHuaU1dKMIou2S1g
 tRG+uco3JAWiPwCVDsh1eJXVpPsSCX+vbHGCI78sxX8NgQH3D1zWVUUMCjBGHeMy3ONSQZCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=932
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

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
 net/wireless/nl80211.c | 215 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 214 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..7cf1db9b012d 100644
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
@@ -6880,7 +7062,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
-	if (sinfo->pertid) {
+	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_TID_STATS)) &&
+	    sinfo->pertid) {
 		struct nlattr *tidsattr;
 		int tid;
 
@@ -6950,6 +7133,36 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
+	if (sinfo->valid_links) {
+		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!links)
+			goto nla_put_failure;
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sinfo = sinfo->links[link_id];
+			link = nla_nest_start(msg, link_id + 1);
+			if (!link)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+				       link_id))
+				goto nla_put_failure;
+
+			if (link_sinfo &&
+			    !is_zero_ether_addr(link_sinfo->addr) &&
+			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				    link_sinfo->addr))
+				goto nla_put_failure;
+
+			if (link_sinfo && nl80211_fill_link_station(msg, rdev,
+								    link_sinfo))
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


