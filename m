Return-Path: <linux-wireless+bounces-14943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD219BD926
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 23:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284041C22535
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 22:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AD216423;
	Tue,  5 Nov 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NkqsY98q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9C1F80C4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847193; cv=none; b=hNX2uDKZbVsEoLrnF/MITRGKz3o2jp7y0ifMB/IHAo4mvhztDZixKj5Av/kAkjpby04k2yUoo+moCv7r6juK8yzIq0pkx09kYK/fTHQhDEpX5pm5KfD6FtovBzEGD2imEe2XAHV3V5zXanlVv2BfUPoyVoVT9Hwy6syvQOPKbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847193; c=relaxed/simple;
	bh=hK2afHbjBQpG5io5SS18XDHVCKCpWJNl/1Ii33SkZE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q1n+MGHcnM8hwk1wrlBV1DG1p7ZCvI9IHo+aljbpBSXKDFhpKVtr2snykOONQcAakCWjil6Y5Aebn2ePwMSWxOotTwn/GyHrqIOAUr3NWaABI4xRI1Dw9QUzzTY8Y0lGhNOZUm5AE0OOCXqawWdIEX7wOZ6use0Tbh18hrU5JKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NkqsY98q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5JEklw005250;
	Tue, 5 Nov 2024 22:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U8KZrQ9SzrIXe6mpOV31i+8xcneG5LKBNyK1DAv7sx0=; b=NkqsY98qO16aYNAO
	sKTteQcH9zgMPNwItMIYCl2vsYR9lFkebYTa/reZXaK9EbltLPQWS7XN08GyuRMY
	rEO15+CdiiZwdiehIu1uZyD6SIyGaK6s2+zf7Ui1agQ9VsKmt1p1Fr7/WnMWkJew
	IXiISvHVPMyTV+2LqEKO8gUIPcSRvcwiGW/stz+hlTwKWSUwfPaVyd7r1/Irpv3m
	eai1vGglRraORDzDQprEa58wo942vQrqushywd/dRKY6s6q7y4RhZ/zsbLA4RiEh
	gVIXNzdV9RVCaAZ8ig0sp7sS1luy06pz7dfAp1escZvfkrjLGrOGM9pk04gMIAhz
	CkDY7A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc718en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 22:53:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5Mr7WV025898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 22:53:07 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 14:53:07 -0800
Message-ID: <c0d7fe37-e04e-4a13-b86b-7b9db27c169c@quicinc.com>
Date: Tue, 5 Nov 2024 14:53:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] wifi: ath12k: Support SoC Common Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241105045406.2098436-1-quic_rdevanat@quicinc.com>
 <20241105045406.2098436-4-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241105045406.2098436-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 53RpVXGB_fJQTIeQWkOe_cbvaYR0oD87
X-Proofpoint-GUID: 53RpVXGB_fJQTIeQWkOe_cbvaYR0oD87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050177

On 11/4/2024 8:54 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request SoC stat from firmware through HTT stat
> type 38. This stat gives drop count of SoC.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support tag HTT_STATS_SOC_TXRX_STATS_COMMON_TAG(125).
> 
> Sample output:
> -------------
> echo 38 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_SOC_COMMON_STATS_TLV:
> soc_drop_count = 0x0000000000000000
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 23 +++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  7 ++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 732e600d33fa..8f89ba2db8c7 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -2859,6 +2859,26 @@ ath12k_htt_print_phy_tpc_stats_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_soc_txrx_stats_common_tlv(const void *tag_buf, u16 tag_len,
> +					   struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_t2h_soc_txrx_stats_common_tlv *htt_stats_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +
> +	if (tag_len < sizeof(*htt_stats_buf))
> +		return;
> +
> +	len += scnprintf(buf + len, buf_len - len, "HTT_SOC_COMMON_STATS_TLV:\n");
> +	len += scnprintf(buf + len, buf_len - len, "soc_drop_count = 0x%08x%08x\n\n",
> +			 le32_to_cpu(htt_stats_buf->inv_peers_msdu_drop_count_hi),
> +			 le32_to_cpu(htt_stats_buf->inv_peers_msdu_drop_count_lo));

perhaps use ath12k_le32hilo_to_u64() to convert to u64 and then print in
decimal instead of hex? just a suggestion, no need to respin if you disagree

> +
> +	stats_req->buf_len = len;
> +}
> +
>  static void
>  ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
>  				      struct debug_htt_stats_req *stats_req)
> @@ -3204,6 +3224,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>  	case HTT_STATS_PHY_TPC_STATS_TAG:
>  		ath12k_htt_print_phy_tpc_stats_tlv(tag_buf, len, stats_req);
>  		break;
> +	case HTT_STATS_SOC_TXRX_STATS_COMMON_TAG:
> +		ath12k_htt_print_soc_txrx_stats_common_tlv(tag_buf, len, stats_req);
> +		break;
>  	case HTT_STATS_DMAC_RESET_STATS_TAG:
>  		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
>  		break;
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index 10d7ca9c02f4..c07b60636c22 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
>  	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
>  	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
> +	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
>  	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
>  	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
> @@ -201,6 +202,7 @@ enum ath12k_dbg_htt_tlv_tag {
>  	HTT_STATS_PHY_STATS_TAG				= 122,
>  	HTT_STATS_PHY_RESET_COUNTERS_TAG		= 123,
>  	HTT_STATS_PHY_RESET_STATS_TAG			= 124,
> +	HTT_STATS_SOC_TXRX_STATS_COMMON_TAG		= 125,
>  	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
>  	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
>  	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
> @@ -1183,6 +1185,11 @@ struct ath12k_htt_phy_tpc_stats_tlv {
>  	__le32 sub_band_txpower[ATH12K_HTT_MAX_CH_PWR_INFO_SIZE];
>  } __packed;
>  
> +struct ath12k_htt_t2h_soc_txrx_stats_common_tlv {
> +	__le32 inv_peers_msdu_drop_count_hi;
> +	__le32 inv_peers_msdu_drop_count_lo;
> +} __packed;
> +
>  struct ath12k_htt_dmac_reset_stats_tlv {
>  	__le32 reset_count;
>  	__le32 reset_time_lo_ms;


