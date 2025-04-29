Return-Path: <linux-wireless+bounces-22179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9DAA0172
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E0188A682
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FE1922F4;
	Tue, 29 Apr 2025 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="StuKZdx+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490434409
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901834; cv=none; b=O1oapC8gyuGbWKg0w3qz2JG4fyNHHQuUOgq+q/kOBU4d3N56EkXxjqj+FrgS7ReIQkDl+2G6YvCQtq0WTSoNJ7xRvrv535qyh9p6P9u3YDCQyLw0GN29ljq7o/JMEEdSL7qFPGOeI++ES5+UKCBrlwxiKEqroN9OG9JjKpR3rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901834; c=relaxed/simple;
	bh=5GPjdUWW+vDwed51rIKldRNzHWv7uSwnI12THgN87fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T68XtDSFXXZ4T9kX1ctlw91Vn4AnmMk3GoEPNfWvr8xlECtMkhbJcLcs0ASd7TKS8JU9DqPArnV+1K9JmVOILW8RJGfQP1tqDgjXl/T0EL1Gh9aj6LeB0sEOgA8OWe9qi7oCuVErJn+/z/cOdJCf9rTVpBSRh6N8aQSdABmqtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=StuKZdx+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq3pL012818;
	Tue, 29 Apr 2025 04:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQiDQ3Wj8f6Mkhdu1WsvHm9cqL93mewNDdZuDN5leQM=; b=StuKZdx+BYJER9V2
	mbzPDflxkWkmGYl/NecbleMxg66jgbj6wxLd7qby5vCwcqQe9DyD7/hZlpuZItwu
	GPsdl9LVV4pgccNRhuicRGuu6+x7oZo7bwJvUfZhwbgEDbekd6hqrlQoBGTyrNUL
	1L5Ne4187FaqCK7wZ7sOuWH71wljwNTDLgwVeF+MEn+UxLKQBETOykOj5cRH8+2H
	N2dSuXi5ms9SlrJpwBZ5tB14Ew20nyT9Hum14YuyadEtNGiHzpsLLsgYCVKzF4Ix
	mfSihav+E12wENBfFOm6Teb6hCf4v7HY9fa86L6yFKE7wg+YIml0JVzMaHFaxK7m
	UC3kLA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rnn25fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:43:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4hoR8024651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:43:50 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:43:48 -0700
Message-ID: <dac71b79-bf6d-4a2a-9c7c-31c52874fcb6@quicinc.com>
Date: Tue, 29 Apr 2025 10:13:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable AST index based address
 search in Station Mode
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>
References: <20250422094255.131226-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250422094255.131226-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1vzTER77Z6nsFR1Y-9gs3MltlFiYvqEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfX9kpX3/K56v1Q ZZz92+kvgJkg+TwJMFgtIadbkbNAXp2EECaI+t9AeHkeqaaXNOuHGAZjPCyVC8hKj1YOQ8A6dsT HmYi8imBIArGCEx1aKuoCBQZ7D9nLkCZFmMKUhzzjkyJzCJlaTN4DDwDQEi/AA0UJxRIs3ajiPk
 QFTl/SALjo6FFfk5+7sOrs5UorJB7XAYA3eLCEAbTM+QzP36JjjDQfHwlTLajYBSnfPh40WoVNj oJVkO1AOwCnOh/IcejdgpkcA+BBotTmiyto04iMrYaccyeZOi6Xjp6RrlbywDjzDxLJX28/1iCw zFJxUkz5TeOx5tGcrtkb/Vj6OzptRc6BCeJqL5LiBch82Ef4ub9LZPLXWQ0d+HpbHM61HqBpWUp
 gi3azFAtPHZzTn/kWI0UYo7NNOJjGcsQO4ndKk4ZczGebroRbDaTyohDpA1O1F97UvVYW6E/
X-Proofpoint-GUID: 1vzTER77Z6nsFR1Y-9gs3MltlFiYvqEd
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=68105906 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=l_I2kL9VWpTzgr9iVmoA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/22/2025 3:12 PM, Nithyanantham Paramasivam wrote:
> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> 
> Currently, TCL performs the TX address search for each entry during
> transmission, which may lead to packet delays.
> 
> To mitigate this issue, enable AST index-based address search during
> transmission in station mode. This AST index-based search is not
> enabled in AP mode due to the complexity involved in fetching peer
> information.
> 
> Implement changes to retrieve the offset of ast_idx/ast_hash values
> from the PEER_MAP3 event, update the vdev search type to ADDRX, and
> enable AST lookup in the bank configuration.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.c    | 10 +++++-----
>  drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
>  drivers/net/wireless/ath/ath12k/dp_rx.c |  6 +++++-
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index ad873013e46c..0291fbea6312 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -354,7 +354,10 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
>  			u32_encode_bits(0, HAL_TX_BANK_CONFIG_EPD);
>  
>  	/* only valid if idx_lookup_override is not set in tcl_data_cmd */
> -	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
> +	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
> +		bank_config |= u32_encode_bits(1, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
> +	else
> +		bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
>  
>  	bank_config |= u32_encode_bits(arvif->hal_addr_search_flags & HAL_TX_ADDRX_EN,
>  					HAL_TX_BANK_CONFIG_ADDRX_EN) |
> @@ -1107,11 +1110,8 @@ static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
>  {
>  	switch (arvif->ahvif->vdev_type) {
>  	case WMI_VDEV_TYPE_STA:
> -		/* TODO: Verify the search type and flags since ast hash
> -		 * is not part of peer mapv3
> -		 */
>  		arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
> -		arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
> +		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
>  		break;
>  	case WMI_VDEV_TYPE_AP:
>  	case WMI_VDEV_TYPE_IBSS:
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index 706d766d8c81..e3923ff02dbd 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -1330,6 +1330,8 @@ struct htt_t2h_version_conf_msg {
>  #define HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16	GENMASK(15, 0)
>  #define HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID	GENMASK(31, 16)
>  #define HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL	GENMASK(15, 0)
> +#define HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID	GENMASK(15, 0)
> +#define HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL	GENMASK(31, 16)
>  #define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M	BIT(16)
>  #define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S	16
>  
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 1abfbd15f13c..f83e34db83c0 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1802,8 +1802,12 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
>  					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
>  		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
>  				       peer_mac_h16, mac_addr);
> +		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
> +					 HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL);
> +		hw_peer_id = le32_get_bits(resp->peer_map_ev.info2,
> +					   HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID);
>  		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
> -				      peer_id);
> +				      hw_peer_id);
>  		break;
>  	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
>  	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
> 
> base-commit: d33705bb41ff786b537f8ed50a187a474db111c1

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


