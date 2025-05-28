Return-Path: <linux-wireless+bounces-23456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B8AC615D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB783B0690
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B31FDA8C;
	Wed, 28 May 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ji+0sdxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4720C038
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411092; cv=none; b=b8KxYRwLk9Qm3gMD58cWALhkTmfxkpym1TTNIurmJgTmgC4eRCODNK/0Egd6+hotlhJyd0r8AY9Ji3vkp74duCeVsk2gCHTM7GEj0xwV70KjBppE/cwoZdoaHCyOp8Iyzf9NQ0lo/jvTCz1LPHJnLDr6C4Jq7i6PmDxHMgLmNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411092; c=relaxed/simple;
	bh=tp0V/RPMediJm3u28zsQJi1D1PFF6P9wP6BMBGHkhps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coDBI6DScCO7ah1aJnka6JkklCqi+nQAcpkrLNz1xFYt4erLU//mGHHmrWxCnt/Sj1+ljC3v/mlqAE8TmB2oUcBcVIfUJzOQbG5bwVLH5bk88IE1C+UclTLpgP2I4YHxLo4vJ4wiL2lB4k7qVNH4U3rM0CIb2HjUrfzjT08r+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ji+0sdxP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RIBS1J002357;
	Wed, 28 May 2025 05:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JiXFkPIyu+4366MywoMmlafSc/YRK+88/8JNCPQdboc=; b=Ji+0sdxPd5JKGQmw
	1bY/EaFfXcSr73Dm0liuaVtOCZLeagMvMBHUrxBgG9GiXf5QF/kXzG4EPHF4tl4K
	CieHbRGSrKGFsq2ONFzQbbfK7AUlpe/W2cSjsOXDK3/Ha8hHqG48y7rhOr5xwaA+
	mP0LFtvlu4yrIyCcpARvbSAxByTaNNGAwa/MfhOEKtlV/vY2EgKQJWazaoHCx917
	/+6el3iBDjj9J3CWF9yZojiFnJiICO1heuoX6X1NLRye0rxWqSyH1+ooXOUNEjUl
	lLfTQY3IWt6RH/aGJjV2pFdqiN/XG1KXeMfc8BfCi25bwi/5zSC2A2nY3BRg9NZ1
	GGgSdg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavktx2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5ijGn031254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:45 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:44 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 04/10] wifi: cfg80211: add statistics for providing overview for MLO station
Date: Wed, 28 May 2025 11:14:14 +0530
Message-ID: <20250528054420.3050133-5-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: sip0I_s6q3HCUPpewb4u6MAqUc3ovUnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfX3BT4NwjenSO8
 HjC4y9mmh4X0L2xB4dy8cXhwf91+XFXH8eR0Jt0RYHt1logf/S47oQ/DeaAfXy/xf1hqrmU5BnJ
 tglxWAxsvni8FwNtWPvqDVWnjPpTlLQjEcUEWepZSEvnf+6yxcLlasl1br9TGkfOr4inx2wg3Rf
 n+toLMf2PnD7thM8+1NTbBXpNitzZacd02oA0Ba6fKIMZu4AFvBSac6nVJE2I3UBz+IMajW4ghd
 XVjQJKXkP+KersGTTeNI+QbVB24UkBfRAD4xYlnVzeIPlAjCNd3hjSyCVDjEt+j6BBok96R2Asc
 Dp1L4vJFC29ysFJsc/QlM0LXipBNwFJzJuwccg1gM0fUAIXnWyk7DfstYTTGeCL/GZ3ixKVrs6L
 Hn5pFlhivtOSHeIpwcS1TVrDaMSQR18SMjewo1UQQdrN3Q2stkH5DqzmbOvWRxg815pNegAL
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6836a2ce cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=_UDe_yRPNXFXODxl5TUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sip0I_s6q3HCUPpewb4u6MAqUc3ovUnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280049

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
 net/wireless/nl80211.c | 188 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4307d732c11f..42f35a5d550f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7176,6 +7176,188 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	return -EMSGSIZE;
 }
 
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
+			sinfo->txrate = link_sinfo->txrate;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		}
+		if ((link_sinfo->filled &
+		     BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			sinfo->rxrate = link_sinfo->rxrate;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		}
+
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_TX_DURATION) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			sinfo->tx_duration += link_sinfo->tx_duration;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+		}
+		if (link_sinfo->filled &
+		    BIT_ULL(NL80211_STA_INFO_RX_DURATION) &&
+		    (!init ||
+		     link_inactive_time > link_sinfo->inactive_time)) {
+			sinfo->rx_duration += link_sinfo->rx_duration;
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+		}
+		init++;
+
+		/* pertid stats accumulate for rx/tx fields */
+		if (sinfo->pertid) {
+			sinfo->pertid->rx_msdu +=
+				link_sinfo->pertid->rx_msdu;
+			sinfo->pertid->tx_msdu +=
+				link_sinfo->pertid->tx_msdu;
+			sinfo->pertid->tx_msdu_retries +=
+				link_sinfo->pertid->tx_msdu_retries;
+			sinfo->pertid->tx_msdu_failed +=
+				link_sinfo->pertid->tx_msdu_failed;
+
+			sinfo->pertid->filled |=
+				BIT(NL80211_TID_STATS_RX_MSDU) |
+				BIT(NL80211_TID_STATS_TX_MSDU) |
+				BIT(NL80211_TID_STATS_TX_MSDU_RETRIES) |
+				BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
+		}
+	}
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -7211,6 +7393,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (err)
 			goto out_err;
 
+		if (sinfo.valid_links)
+			cfg80211_sta_set_mld_sinfo(&sinfo);
+
 		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
@@ -7259,6 +7444,9 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
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


