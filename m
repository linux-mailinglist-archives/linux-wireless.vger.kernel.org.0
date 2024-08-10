Return-Path: <linux-wireless+bounces-11235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672B94DA21
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 04:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D654B22AC7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219749641;
	Sat, 10 Aug 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E6Asb0GG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7BA48;
	Sat, 10 Aug 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723256484; cv=none; b=YNo5dS4bjBZaNkxjsuXWdSaQD4CdJOBKiyZEHcpLeN/oOawXLlwxk6XJ+BfbE/Yzft+9GAbe38ZjhLIHmNk6JJ4284Vph/LLg2Pt0/9cCbngfUuPMvgWg+gutVlNTdrUDZYJySeMc71Xcx3ErRXn/CMhYPK5OkAEUHIUEgcIlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723256484; c=relaxed/simple;
	bh=c8XOrfbLn4szTf8GfdDJDvKMldI5+D24v2UFaIrfRls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mTzqdg5icx4LH52kJv8q6UWowWmW292/9SUF/0bRQ5gfvCs/pdaKfs1RUcmCnqPfa25dCQ+Xl0t5KAh3tyEaOfGV0xTJYUTuwZhytui/M56F3ltxUlsWvua5K9FbhdfSuipvwhjqlDQ8YQouMSf+JvEorF8G5wqAdSKDlDJsw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E6Asb0GG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47A0Xjqu032443;
	Sat, 10 Aug 2024 02:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	98RgCUpNJYLjdc9KHu/DCjP9Nu3Ihp6wUSaZA+69PCo=; b=E6Asb0GG+7f5sL14
	8ls8bpDZ5zB4CTFcrr9joR2GsomJ3FjHBu5l878PQGHPkPPe5DDcMPXOOJKqXirw
	kG8RonmovXXZRL2RIbDO202SfbJ+VmPonDazXc8xudOpGxlsSdI/OMDIowkcn05g
	Og740XDHIonkp6tyc0V/J1TVB8Zm+4dM0XoRxSxwyrAKx8ItAKUOYYfaqc5hg3If
	KBUGTPHFdZd25LfMvKWAkV2OQbEbTg5EDxqrjJrszVrCICKjUhrjdO4WUNUb6odL
	P44ZGkY8uQrwEX+UKWmYUjyeXFS35Hm07Thg00YGG2jwb+eNYqLR0OrDdPY94Q80
	5mCz7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40wwjn03uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 02:21:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 47A2LBgC012871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 02:21:11 GMT
Received: from [10.111.178.37] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 19:21:11 -0700
Message-ID: <8d31adac-fd43-4cf9-8fc8-655b359a573c@quicinc.com>
Date: Fri, 9 Aug 2024 19:21:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: ath11k: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <ZrZB3Rjswe0ZXtug@cute>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <ZrZB3Rjswe0ZXtug@cute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xvaVOjwy3M799k-1WttWrW3yKTBXUBF7
X-Proofpoint-ORIG-GUID: xvaVOjwy3M799k-1WttWrW3yKTBXUBF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408100016

On 8/9/2024 9:20 AM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ieee80211_chanctx_conf` is a flexible structure --a
> structure that contains a flexible-array member.
> 
> Also, remove a couple of unused structures.
> 
> Fix the following warnings:
> drivers/net/wireless/ath/ath11k/core.h:409:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/ath/ath11k/dp.h:1309:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/ath/ath11k/dp.h:1368:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.h |  4 +++-
>  drivers/net/wireless/ath/ath11k/dp.h   | 23 -----------------------
>  2 files changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index df24f0e409af..e283415dccf3 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -406,11 +406,13 @@ struct ath11k_vif {
>  	bool wpaie_present;
>  	bool bcca_zero_sent;
>  	bool do_not_send_tmpl;
> -	struct ieee80211_chanctx_conf chanctx;
>  	struct ath11k_arp_ns_offload arp_ns_offload;
>  	struct ath11k_rekey_data rekey_data;
>  
>  	struct ath11k_reg_tpc_power_info reg_tpc_info;
> +
> +	/* Must be last - ends in a flexible-array member. */
> +	struct ieee80211_chanctx_conf chanctx;

there is something illogical about this since the vif is allocated using
sizeof() and hence there will never be memory allocated for the flexible
array, and it is assigned using either struct assignment or memcpy using the
struct size which (fortunately) would not transfer the flexible array contents:
		arvif->chanctx = *ctx;

		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));

since ath11k doesn't actually use the drv_priv[] I guess this change is OK, it
is just strange to me.

also makes me wonder why ath11k keeps a copy of the chanctx instead of just
getting it from the underlying ieee80211_link_data. but that is outside the
scope of this discussion.

>  };
>  
>  struct ath11k_vif_iter {
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
> index 2f6dd69d3be2..65d2bc0687c8 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -1305,18 +1305,6 @@ struct htt_ppdu_stats_user_rate {
>  #define HTT_TX_INFO_PEERID(_flags) \
>  			FIELD_GET(HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M, _flags)
>  
> -struct htt_tx_ppdu_stats_info {
> -	struct htt_tlv tlv_hdr;
> -	u32 tx_success_bytes;
> -	u32 tx_retry_bytes;
> -	u32 tx_failed_bytes;
> -	u32 flags; /* %HTT_PPDU_STATS_TX_INFO_FLAGS_ */
> -	u16 tx_success_msdus;
> -	u16 tx_retry_msdus;
> -	u16 tx_failed_msdus;
> -	u16 tx_duration; /* united in us */
> -} __packed;
> -
>  enum  htt_ppdu_stats_usr_compln_status {
>  	HTT_PPDU_STATS_USER_STATUS_OK,
>  	HTT_PPDU_STATS_USER_STATUS_FILTERED,
> @@ -1364,17 +1352,6 @@ struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
>  	u32 success_bytes;
>  } __packed;
>  
> -struct htt_ppdu_stats_usr_cmn_array {
> -	struct htt_tlv tlv_hdr;
> -	u32 num_ppdu_stats;
> -	/* tx_ppdu_stats_info is filled by multiple struct htt_tx_ppdu_stats_info
> -	 * elements.
> -	 * tx_ppdu_stats_info is variable length, with length =
> -	 *     number_of_ppdu_stats * sizeof (struct htt_tx_ppdu_stats_info)
> -	 */
> -	struct htt_tx_ppdu_stats_info tx_ppdu_info[];
> -} __packed;
> -
>  struct htt_ppdu_user_stats {
>  	u16 peer_id;
>  	u32 tlv_flags;

the second part if definitely ok.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


