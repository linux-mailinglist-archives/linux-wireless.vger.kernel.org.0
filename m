Return-Path: <linux-wireless+bounces-23293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB13AC0829
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D913AFA27
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA47286893;
	Thu, 22 May 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QpOZQGnO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F288C13
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904602; cv=none; b=ipOSHPw1iKk+z8FoscH603fZ4/oN18Ji++iqSKLOucBe5RgschJZ9gE1LGAxM5dofs8O3ZnWwCJYPbyIbOq3pk494wrbzTNjGmTGuxURqNXIPqu8RtTyBMqLPoCK871hQK0fCAIUs6snmMe6j2bTECgVRY3WLXPsz2Pj6i3zf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904602; c=relaxed/simple;
	bh=A3WRakn6m/DgVYB7Hffvp6hzw6pyDdnDLXw2LAuabRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4ob7HEIHC8lYabGjK1jfGmdqk5ZuS8QHZNK1gnvKzZ9oBkpDFjdhXHUVLIFZ01AmhM4PiOoGjaqWYOwzG3z1vaPwlpcrsXxM5c8rZcAlxU3FaOavBtYBGQH0GSs0tFEewBnW4H1sRqlxLz+akun6TPaZMX3gMfUlWIwiYtHg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QpOZQGnO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7c2BH029153;
	Thu, 22 May 2025 09:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o2ZZ6xAyHgA906cYqKqmH1P+SsmwKSSR4vQwpWYeUUs=; b=QpOZQGnOniLp6Fhy
	NxbLgjIG6L1GzrUHmLJUrj/sAB8iX0U9HOOulMjBbBdv7tgSuaX18MirccQcx+92
	N1Dtcr36Ny7StKw+Le9unCcDa5YOstDWXXqp0Oacw7qUyvrWIuGxDQuwG/mQtAKj
	UFgSaubFaYH31Cjy5nMLtUjO113J0NyFkt0EkvIfUUQYtL2/1hTKAHOE85hK9iMv
	EL0tf3+PqQ0w6PbE5uz+EQFuws8UnUqgkpyQKNnQ3EXEdP14u2CBa9++pyK1/GSZ
	ZI8jMwDqJEsfj1M4NqQmwhIfRIu/kBMXKfrKgFJqSnKYeiMVSWM9ZXFUkdjBFuW4
	8CNU0g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf45t5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:03:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M93BRG017644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:03:11 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 02:03:10 -0700
Message-ID: <9be5a453-730f-4ed9-b9fc-1e703f38f9f0@quicinc.com>
Date: Thu, 22 May 2025 14:33:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
 <20250522085601.2741458-4-quic_sarishar@quicinc.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <20250522085601.2741458-4-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5MCBTYWx0ZWRfX+Y2vRcPmczjw
 GTrun1d6XU/TN6Sy533B0qxAyC//PGjETuAU243t0BVeR3Q2bQ3fsb8gpXhDSDyMUcy9TOyK50U
 GHfOjkJoB0qn+Uwh879nhRqcficA+R1IrHcjKO7tKxOcrfobRjqpWe7x5NSLfV3hPGji+ULsjOE
 XyVGnVp8MiE6ZjHlPAA3PVP4m9oxYZTxYUEBpTPsP1mOUf9X0NAZB/7sv2UbwW1SxHMk8/JHH/4
 NK9woKtmFAGCPaWX5TW8elRKTqveyzkfTZaQr6yOTjgxDK9EBQmpaUAWycmSH95ZP9xoLvVcJoC
 LEJ6vHKUFO13uHZiLvfhyx+Lf/E9noI5aX0QkAMqTTHcJMb9kupUWl7zBwofcHSkvzzs6Fbgv10
 qZtG/AZN8sydhFH/x2DW1HIBDdK5Sww49ER1tL7cw5WBmT5hcjqDFOcYNOxfIvrZv1T/WLeF
X-Proofpoint-GUID: CWfVsYJilODiw97o2cJ5FYk2vo3mhhIl
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682ee84f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=zko5S5bi7CymWpR6Y5wA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CWfVsYJilODiw97o2cJ5FYk2vo3mhhIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220090

On 5/22/2025 2:25 PM, Sarika Sharma wrote:
> Currently, statistics is supported at deflink( or one of the links)
> level for station. This has problems when applied to multi-link(ML)
> connections.
> 
> Hence, add changes to support link level statistics to embed NL message
> with link related information if valid links are present.
> 
> This will be helpful to check the link related statistics during MLO.
> 
> The statistics will be embedded into NL message as below:
> For non-ML:
> cmd->
>      NL80211_ATTR_IFINDEX
>      NL80211_ATTR_MAC
>      NL80211_ATTR_GENERATION
>      ....etc
>      NL80211_ATTR_STA_INFO | nested
>          NL80211_STA_INFO_CONNECTED_TIME,
>          NL80211_STA_INFO_STA_FLAGS,
>          NL80211_STA_INFO_RX_BYTES,
>          NL80211_STA_INFO_TX_BYTES,
>          .........etc
> 
> For MLO:
> cmd ->
>      NL80211_ATTR_IFINDEX
>      NL80211_ATTR_MAC
>      NL80211_ATTR_GENERATION
>      .......etc
>      NL80211_ATTR_STA_INFO | nested
>          NL80211_STA_INFO_CONNECTED_TIME,
>          NL80211_STA_INFO_STA_FLAGS,
>          ........etc
>      NL80211_ATTR_MLO_LINK_ID,
>      NL80211_ATTR_MLD_ADDR,
>      NL80211_ATTR_MLO_LINKS | nested
>          link_id-1 | nested
>              NL80211_ATTR_MLO_LINK_ID,
>              NL80211_ATTR_MAC,
>              NL80211_ATTR_STA_INFO | nested
>                  NL80211_STA_INFO_RX_BYTES,
>                  NL80211_STA_INFO_TX_BYTES,
>                 NL80211_STA_INFO_CONNECTED_TIME,
>                 ..........etc.
>          link_id-2 | nested
>              NL80211_ATTR_MLO_LINK_ID,
>              NL80211_ATTR_MAC,
>              NL80211_ATTR_STA_INFO | nested
>                  NL80211_STA_INFO_RX_BYTES,
>                  NL80211_STA_INFO_TX_BYTES,
>                 NL80211_STA_INFO_CONNECTED_TIME,
>                  .........etc
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
>   net/wireless/nl80211.c | 216 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 216 insertions(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index fd5f79266471..676f028a44ce 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -6728,6 +6728,185 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
>   	return true;
>   }
>   
> +static int nl80211_fill_link_station(struct sk_buff *msg,
> +				     struct cfg80211_registered_device *rdev,
> +				     struct link_station_info *link_sinfo)
> +{
> +	struct nlattr *bss_param, *link_sinfoattr;
> +
> +#define PUT_LINK_SINFO(attr, memb, type) do {				\
> +	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
> +	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
> +			     link_sinfo->memb))				\
> +		goto nla_put_failure;					\
> +	} while (0)
> +#define PUT_LINK_SINFO_U64(attr, memb) do {				\
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
> +	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
> +			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
> +		goto nla_put_failure;					\
> +	} while (0)
> +
> +	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
> +	if (!link_sinfoattr)
> +		goto nla_put_failure;
> +
> +	PUT_LINK_SINFO(INACTIVE_TIME, inactive_time, u32);
> +
> +	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
> +			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
> +	    nla_put_u32(msg, NL80211_STA_INFO_RX_BYTES,
> +			(u32)link_sinfo->rx_bytes))
> +		goto nla_put_failure;
> +
> +	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
> +			     BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
> +	    nla_put_u32(msg, NL80211_STA_INFO_TX_BYTES,
> +			(u32)link_sinfo->tx_bytes))
> +		goto nla_put_failure;
> +
> +	PUT_LINK_SINFO_U64(RX_BYTES64, rx_bytes);
> +	PUT_LINK_SINFO_U64(TX_BYTES64, tx_bytes);
> +	PUT_LINK_SINFO_U64(RX_DURATION, rx_duration);
> +	PUT_LINK_SINFO_U64(TX_DURATION, tx_duration);
> +
> +	if (wiphy_ext_feature_isset(&rdev->wiphy,
> +				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
> +		PUT_LINK_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
> +
> +	switch (rdev->wiphy.signal_type) {
> +	case CFG80211_SIGNAL_TYPE_MBM:
> +		PUT_LINK_SINFO(SIGNAL, signal, u8);
> +		PUT_LINK_SINFO(SIGNAL_AVG, signal_avg, u8);
> +		break;
> +	default:
> +		break;
> +	}
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
> +		if (!nl80211_put_signal(msg, link_sinfo->chains,
> +					link_sinfo->chain_signal,
> +					NL80211_STA_INFO_CHAIN_SIGNAL))
> +			goto nla_put_failure;
> +	}
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
> +		if (!nl80211_put_signal(msg, link_sinfo->chains,
> +					link_sinfo->chain_signal_avg,
> +					NL80211_STA_INFO_CHAIN_SIGNAL_AVG))
> +			goto nla_put_failure;
> +	}
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
> +		if (!nl80211_put_sta_rate(msg, &link_sinfo->txrate,
> +					  NL80211_STA_INFO_TX_BITRATE))
> +			goto nla_put_failure;
> +	}
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
> +		if (!nl80211_put_sta_rate(msg, &link_sinfo->rxrate,
> +					  NL80211_STA_INFO_RX_BITRATE))
> +			goto nla_put_failure;
> +	}
> +
> +	PUT_LINK_SINFO(RX_PACKETS, rx_packets, u32);
> +	PUT_LINK_SINFO(TX_PACKETS, tx_packets, u32);
> +	PUT_LINK_SINFO(TX_RETRIES, tx_retries, u32);
> +	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
> +	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
> +	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
> +
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
> +		bss_param = nla_nest_start_noflag(msg,
> +						  NL80211_STA_INFO_BSS_PARAM);
> +		if (!bss_param)
> +			goto nla_put_failure;
> +
> +		if (((link_sinfo->bss_param.flags &
> +		      BSS_PARAM_FLAGS_CTS_PROT) &&
> +		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_CTS_PROT)) ||
> +		    ((link_sinfo->bss_param.flags &
> +		      BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
> +		     nla_put_flag(msg,
> +				  NL80211_STA_BSS_PARAM_SHORT_PREAMBLE)) ||
> +		    ((link_sinfo->bss_param.flags &
> +		      BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
> +		     nla_put_flag(msg,
> +				  NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME)) ||
> +		    nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
> +			       link_sinfo->bss_param.dtim_period) ||
> +		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
> +				link_sinfo->bss_param.beacon_interval))
> +			goto nla_put_failure;
> +
> +		nla_nest_end(msg, bss_param);
> +	}
> +
> +	PUT_LINK_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
> +	PUT_LINK_SINFO_U64(BEACON_RX, rx_beacon);
> +	PUT_LINK_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
> +	PUT_LINK_SINFO(RX_MPDUS, rx_mpdu_count, u32);
> +	PUT_LINK_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
> +	if (wiphy_ext_feature_isset(&rdev->wiphy,
> +				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
> +		PUT_LINK_SINFO(ACK_SIGNAL, ack_signal, u8);
> +		PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
> +	}
> +
> +#undef PUT_LINK_SINFO
> +#undef PUT_LINK_SINFO_U64
> +
> +	if (link_sinfo->pertid) {
> +		struct nlattr *tidsattr;
> +		int tid;
> +
> +		tidsattr = nla_nest_start_noflag(msg,
> +						 NL80211_STA_INFO_TID_STATS);
> +		if (!tidsattr)
> +			goto nla_put_failure;
> +
> +		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
> +			struct cfg80211_tid_stats *tidstats;
> +			struct nlattr *tidattr;
> +
> +			tidstats = &link_sinfo->pertid[tid];
> +
> +			if (!tidstats->filled)
> +				continue;
> +
> +			tidattr = nla_nest_start_noflag(msg, tid + 1);
> +			if (!tidattr)
> +				goto nla_put_failure;
> +
> +#define PUT_TIDVAL_U64(attr, memb) do {					\
> +	if (tidstats->filled & BIT(NL80211_TID_STATS_ ## attr) &&	\
> +	    nla_put_u64_64bit(msg, NL80211_TID_STATS_ ## attr,		\
> +			      tidstats->memb, NL80211_TID_STATS_PAD))	\
> +		goto nla_put_failure;					\
> +	} while (0)
> +
> +			PUT_TIDVAL_U64(RX_MSDU, rx_msdu);
> +			PUT_TIDVAL_U64(TX_MSDU, tx_msdu);
> +			PUT_TIDVAL_U64(TX_MSDU_RETRIES, tx_msdu_retries);
> +			PUT_TIDVAL_U64(TX_MSDU_FAILED, tx_msdu_failed);
> +
> +#undef PUT_TIDVAL_U64
> +			if ((tidstats->filled &
> +			     BIT(NL80211_TID_STATS_TXQ_STATS)) &&
> +			    !nl80211_put_txq_stats(msg, &tidstats->txq_stats,
> +						   NL80211_TID_STATS_TXQ_STATS))
> +				goto nla_put_failure;
> +
> +			nla_nest_end(msg, tidattr);
> +		}
> +
> +		nla_nest_end(msg, tidsattr);
> +	}
> +
> +	nla_nest_end(msg, link_sinfoattr);
> +	return 0;
> +
> +nla_put_failure:
> +	return -EMSGSIZE;
> +}
> +
>   static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
>   				u32 seq, int flags,
>   				struct cfg80211_registered_device *rdev,
> @@ -6736,6 +6915,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
>   {
>   	void *hdr;
>   	struct nlattr *sinfoattr, *bss_param;
> +	struct link_station_info *link_sinfo;
> +	struct nlattr *links, *link;
> +	int link_id;
>   
>   	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
>   	if (!hdr) {
> @@ -6950,6 +7132,40 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
>   			goto nla_put_failure;
>   	}
>   
> +	if (sinfo->valid_links) {
> +		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
> +		if (!links)
> +			goto nla_put_failure;
> +
> +		for_each_valid_link(sinfo, link_id) {
> +			link_sinfo = sinfo->links[link_id];
> +
> +			if (!link_sinfo)
> +				continue;

I have removed the WARN_ON_ONCE() check for !link_sinfo because 
link_sinfo can be NULL during sta_destroy.
It appears that nl80211_dump_station is being invoked during sta 
destroy, though it's not very clear why this happens in that context.
Introduced in patch " mac80211: avoid excessive stack usage in sta_info".

Since link_sinfo memory isn't allocated during sta_destroy, there's a 
valid chance it remains uninitialized,
which triggers the WARN_ON_ONCE() and causes hw_sim test cases to fail.

Let me know if I am missing the requirement to allocate link_sinfo 
memory during sta destroy.

> +
> +			if (!is_valid_ether_addr(link_sinfo->addr))
> +				continue;
> +
> +			link = nla_nest_start(msg, link_id + 1);
> +			if (!link)
> +				goto nla_put_failure;
> +
> +			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
> +				       link_id))
> +				goto nla_put_failure;
> +
> +			if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
> +				    link_sinfo->addr))
> +				goto nla_put_failure;
> +
> +			if (nl80211_fill_link_station(msg, rdev, link_sinfo))
> +				goto nla_put_failure;
> +
> +			nla_nest_end(msg, link);
> +		}
> +		nla_nest_end(msg, links);
> +	}
> +
>   	cfg80211_sinfo_release_content(sinfo);
>   	genlmsg_end(msg, hdr);
>   	return 0;


