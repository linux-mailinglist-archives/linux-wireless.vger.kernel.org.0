Return-Path: <linux-wireless+bounces-18114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8DA217A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1908F3A66A3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30991EEE6;
	Wed, 29 Jan 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hZc2GH8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472914F6C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130957; cv=none; b=iQAngi1RPCn2VATtNywupyz1Lm3CTh+hg3HUx4qSA4fUyVUu62CAcjoGRpxpsJPIHf05v6MhZB3QldabN9coBEqP+F0pORA8iXJw9aFqBQJ/OBwl5iPTZOJ0Y6drZQ2+B4CRX+3lR6uv6AWYpEYcEB0k0sh2JdfMwPJUwjrqmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130957; c=relaxed/simple;
	bh=QSmbydrpjUKsjmOibnitJCHel+qW1/G+A3KLrEmdrmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g/S5jCrbWUvGoi6IV2oX+XY0X5CTnVK/pTRnhFnQUrVihOXbBY7YrYIsA2ezqeztMahF7Do+yMyby9TnWskWOHBndJ531r0oKD//eZniM9tXGXH20sAqcHUsi8iHP3FZsmgR9WSIAHLiCng0gZspSQjncTdymSO/WEAKfrz/3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hZc2GH8f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2hbM2000301;
	Wed, 29 Jan 2025 06:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+jf7dmjR8PEkOlW1Rgh/J9k8+SMvtk6t3FDaAx2bNeM=; b=hZc2GH8fqfQMte4G
	a9PisgmmY4W+CSb2QbjBgN/I4pifC0fGREOBzC8jl+2Glf99dldUjIhUXpttCygj
	mmDTyPG6ZvYKro/HZUiIMels0YtMo0BeqwUK8UV0DHtUyy9igneyhSkRDNq2OocR
	KCX4UfxpFP+awdop/f2rhdGx/98Kp3hu7+KbMt8s4KYiT+7x37+GUxm+loHR7+vB
	I6sMfCEGYFwDWO1VRDFI9978XmOxIyssSxkNr7lgqfrJzSLIQCG0CNJ3rlSq3DpD
	vwreoo6WL7RzB+eGoQHkyEhTeAqqPuNl0zO1kZiwYyQhym5d1Lj21d9ZmqEfNGI6
	rALMow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f7fcgq4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:09:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T69CYN025704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:09:12 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 22:09:10 -0800
Message-ID: <fe1cd110-8cb5-103f-8a35-676e03398f43@quicinc.com>
Date: Wed, 29 Jan 2025 11:39:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/7] wifi: ath12k: Avoid packet offset and FCS length
 from Rx TLV
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>
References: <20250127114030.43479-1-quic_periyasa@quicinc.com>
 <20250127114030.43479-7-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127114030.43479-7-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w7e9G9GcNcQpTsYYdx2kopaVwdz1aSep
X-Proofpoint-ORIG-GUID: w7e9G9GcNcQpTsYYdx2kopaVwdz1aSep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=846
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290049



On 1/27/2025 5:10 PM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, the packet offset and FCS length are fetched from the MSDU Rx
> TLV data, a logic inherited from ath11k. However, for ath12k 802.11be
> hardware, the Rx TLV will not be present in the MSDU data. Instead, this
> information is constant. Therefore, remove the existing FCS trim and the
> packet offset fetch code. Handle the packet offset with the constant in
> the merge MSDU procedure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Tested-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 23 +++++------------------
>   drivers/net/wireless/ath/ath12k/dp_mon.h |  1 +
>   2 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 778866628a8d..b92de0f9aeda 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -1719,18 +1719,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
>   }
>   
> -static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
> -					       struct sk_buff *head_msdu,
> -					       struct sk_buff *tail_msdu)
> -{
> -	u32 rx_pkt_offset, l2_hdr_offset;
> -
> -	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
> -	l2_hdr_offset =
> -		ath12k_dp_rx_h_l3pad(ar->ab, (struct hal_rx_desc *)tail_msdu->data);
> -	skb_pull(head_msdu, rx_pkt_offset + l2_hdr_offset);
> -}
> -
>   static void
>   ath12k_dp_mon_fill_rx_stats_info(struct ath12k *ar,
>   				 struct hal_rx_mon_ppdu_info *ppdu_info,
> @@ -1846,7 +1834,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>   {
>   	struct ath12k_base *ab = ar->ab;
>   	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
> -	struct sk_buff *head_msdu, *tail_msdu;
> +	struct sk_buff *head_msdu;
>   	struct hal_rx_desc *rx_desc;
>   	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
>   	struct ieee80211_hdr_3addr *wh;
> @@ -1856,7 +1844,6 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>   
>   	mpdu_buf = NULL;
>   	head_msdu = mon_mpdu->head;
> -	tail_msdu = mon_mpdu->tail;
>   
>   	if (!head_msdu)
>   		goto err_merge_fail;
> @@ -1886,14 +1873,14 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>   	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
>   
>   	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
> -		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
> +		skb_pull(head_msdu, ATH12K_MON_RX_PKT_OFFSET);
>   
>   		prev_buf = head_msdu;
>   		msdu = head_msdu->next;
>   		head_frag_list = NULL;
>   
>   		while (msdu) {
> -			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
> +			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
>   
>   			if (!head_frag_list)
>   				head_frag_list = msdu;
> @@ -1905,7 +1892,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>   
>   		prev_buf->next = NULL;
>   
> -		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
> +		skb_trim(prev_buf, prev_buf->len);
>   		if (head_frag_list) {
>   			skb_shinfo(head_msdu)->frag_list = head_frag_list;
>   			head_msdu->data_len = frag_list_sum_len;
> @@ -1928,7 +1915,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>   		msdu = head_msdu;
>   
>   		while (msdu) {
> -			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
> +			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
>   			if (qos_pkt) {
>   				dest = skb_push(msdu, sizeof(__le16));
>   				if (!dest)
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
> index b039f6b9277c..9f3adee51cb2 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.h
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
> @@ -10,6 +10,7 @@
>   #include "core.h"
>   
>   #define ATH12K_MON_RX_DOT11_OFFSET	5
> +#define ATH12K_MON_RX_PKT_OFFSET	8
>   
>   enum dp_monitor_mode {
>   	ATH12K_DP_TX_MONITOR_MODE,

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

