Return-Path: <linux-wireless+bounces-17919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36123A1BE2D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3971F188E021
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992923232;
	Fri, 24 Jan 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SGNfqvEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38723C00
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737755966; cv=none; b=euLxu4X3Rg5snihj2gxp/j3w36LJ5aRyHqV7fp8wFeRjE2ioVr8X2rwKpWH2LvBhsgvPmjRqNBhuRCWIR8iRzLCdcp2GkJXxIWbnoPKULbzRkHEWnTaJmMeDnHMi2CND8BHTTjEddLRHiYiIo4arSWnpKTTTt6KpkQE/sCvJ9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737755966; c=relaxed/simple;
	bh=AFxo5jkSu9pv8D3uf5exsIVT4SL9SIo0ktsz+eorqmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tjBdt+SH8UFy/Y2FJgS/2iY0m/KsaU7KgGzQcpKtGkE9c0XW1lBZK8Wi96W2phwfU/uApn2P0f4nyUo/13CdyxLuc3Ht/wV36dmM5VBc7Oq7UdKBSKZBvQkzNDK+7/uwm/I2Jy41pQuwkV3EnlWADECqoB98HfJo3W2htje9an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SGNfqvEt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLSoo7003958;
	Fri, 24 Jan 2025 21:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41X9z30fJ7KnWKzvOWk5e9WEygJH+p4mFkvRN5ff5CQ=; b=SGNfqvEtL13sSuLh
	1D3a2fI95kb/kes1/YDGw84++x7b3dw9EaUhFw2o+qPuidlmIkcWBJEthF3bSV8M
	hRFNZYoIN3oEu+ie+TANmGvKKHrpLbe0DR5eXs/hxKKOLYcPFpgyZlXb5S6a1AVm
	/s39r9WODz74Wz6SpTknyzJFn3Yz/pIm7GXCG23T4twrbLTfBqPlsZIYeXqfHpVz
	/umbIJgLshr8uPVfz8KHfsRN+XSfgMIxWctGWoChqGW+1SHmP8/Edq1SzFKsva/f
	heRN+FQF+9yQVdQJlQT+D0HpvK/qiFM+SxSVqUep0iK5x6aPlZUYUiHAU3cgqLuo
	VkfEVQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44chfug5sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 21:59:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50OLxI6l031257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 21:59:18 GMT
Received: from [10.38.243.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 Jan
 2025 13:59:17 -0800
Message-ID: <0e2feb8f-79dd-19af-3ad9-e61d3f25e9a6@quicinc.com>
Date: Fri, 24 Jan 2025 13:59:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast handling
 in driver
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
 <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
 <D7AA0SSICNT4.3GU5SHWIXWH94@gmail.com>
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
In-Reply-To: <D7AA0SSICNT4.3GU5SHWIXWH94@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nOonKJ4xO5WVyV5LR1a0mpBUe5eZoVlF
X-Proofpoint-GUID: nOonKJ4xO5WVyV5LR1a0mpBUe5eZoVlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240151



On 1/24/2025 3:45 AM, Nicolas Escande wrote:
> On Thu Jan 9, 2025 at 7:49 PM CET, Balamurugan Mahalingam wrote:
> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index 76626d925adf..9d05fe7a870c 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -217,7 +217,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
>>   }
>>   
>>   int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>> -		 struct sk_buff *skb)
>> +		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
>>   {
>>   	struct ath12k_base *ab = ar->ab;
>>   	struct ath12k_dp *dp = &ab->dp;
>> @@ -290,13 +290,24 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>>   		msdu_ext_desc = true;
>>   	}
>>   
>> +	if (gsn_valid) {
>> +		ti.meta_data_flags =
>> +			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
>> +					HTT_TCL_META_DATA_TYPE) |
>> +			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
>> +	}
>> +
> Hello,
> 
> As ti is zeroed initilised isn't safer to do 'ti.meta_data_flags |='
> instead of 'ti.meta_data_flags ='. This way if we add another flag in
> meta_data_flag in the same func for another reason, we will have less risk of
> overriding the said flags ?
> 

Hello Nicolas,
In this case, this is an intentional reset of any previous residual 
value in ti.meta_data_flags field.
The meta_data_flags bit definition is different depending upon the 
META_DATA_TYPE bit's value.

>>   	ti.encap_type = ath12k_dp_tx_get_encap_type(arvif, skb);
>>   	ti.addr_search_flags = arvif->hal_addr_search_flags;
>>   	ti.search_type = arvif->search_type;
>>   	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
>>   	ti.pkt_offset = 0;
>>   	ti.lmac_id = ar->lmac_id;
>> -	ti.vdev_id = arvif->vdev_id;
>> +	if (gsn_valid)
>> +		ti.vdev_id = arvif->vdev_id +
>> +			     HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
>> +	else
>> +		ti.vdev_id = arvif->vdev_id;
>>   	ti.bss_ast_hash = arvif->ast_hash;
>>   	ti.bss_ast_idx = arvif->ast_idx;
>>   	ti.dscp_tid_tbl_idx = 0;

