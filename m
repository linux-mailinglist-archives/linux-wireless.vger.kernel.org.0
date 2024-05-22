Return-Path: <linux-wireless+bounces-7934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BD8CBBCB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C62F28212E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2A56448;
	Wed, 22 May 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cNd+wkT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5602233A
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362141; cv=none; b=JaeYbQHsgzzEvBEPjag5y1evcN18FlPjSBbnvNjlYRDiPsHRkGADylmB7xfCagHGp6hL7LR35+RC+3ZEBE9aNRbV0gNqqBhfq7Pg4j402rIpRo9XCARS7vytEVEwkSsrzxK/f/bsVIVaaliZYBC8kKzbSWSzn39DOXLsG92ZniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362141; c=relaxed/simple;
	bh=RLzFy1HWbH8NQB04D1B5Dl4qcykaNniECOeU/TWZh04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J1S62Nd9p+SP/dFykQ1mB3uJJwsd9vj3lSTfIx30w2SFcEyELhYiaeC9wzPFjT+b+NHq/mHLPsRxmdTETn5WpmzNyoNipqWLJWcHsyZOr2jzETOk87eutFA2Rp9ftWmuWbryNU8JJKheb/4cb5t7mUwecUvNKrnEqcvAkZmlAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cNd+wkT3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M05QvM008814;
	Wed, 22 May 2024 07:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vzUzrX/LNPuxUvUqwfWKebP0lXXR0PgGNnddI0sfHbg=; b=cN
	d+wkT3PL9BvLxWxtqCz8NUlesNShOw5vDy+BO1LWf8LwBAOxf/0lRjrg9sh4lmA4
	yw0ZeP4uF25GLSOXdS0IOmdghpDJPgGOaUA+GwzFeYc21ZVtkYCek+T3+WOpQIXv
	j59J3/FZ7qZKD7srK3mXR91O3LDRf7WYYuYLgXBuUjFztEw8kaYc87N21OhwhIrh
	idlDFDYnOhIpGBZQ8C6cVwKC873wQT8QsFc3u5T0uGcgFhRb0tPDhqxDS1ur8Tlg
	qCugNVY1qJT8Kaw+ZiA3M4ZR3GGOcPJJxPDQC1WJNH+HtU25Fo69dWKCg0LS3nuo
	EONffCS0LDARDW5jgu9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gg3sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 07:15:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M7FVM8020667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 07:15:31 GMT
Received: from [10.50.28.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 00:15:29 -0700
Message-ID: <e8e4a015-3610-4f12-9ed8-e8281af8bf4f@quicinc.com>
Date: Wed, 22 May 2024 12:45:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo reinject
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-4-quic_ppranees@quicinc.com>
 <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
Content-Language: en-US
From: Praneesh P <quic_ppranees@quicinc.com>
In-Reply-To: <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CfNI3NDXlAGEW_vqdKqjD-trzLHQQtaY
X-Proofpoint-ORIG-GUID: CfNI3NDXlAGEW_vqdKqjD-trzLHQQtaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_03,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220052



On 5/21/2024 2:20 PM, Nicolas Escande wrote:
> On Mon May 20, 2024 at 9:00 AM CEST, P Praneesh wrote:
>> When handling fragmented packets, the ath12k driver reassembles each
>> fragment into a normal packet and then reinjects it into the HW ring.
>> However, a firmware crash occurs during this reinjection process.
>> The issue arises because the driver populates peer metadata in
>> reo_ent_ring->queue_addr_lo, while the firmware expects the physical
>> address obtained from the corresponding peer’s queue descriptor. Fix it
>> by filling peer's queue descriptor's physical address in queue_addr_lo.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_rx.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> index 2bfcc19d15ea..2adb6c7d4a42 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> @@ -2967,7 +2967,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
>>   	struct hal_srng *srng;
>>   	dma_addr_t link_paddr, buf_paddr;
>>   	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
>> -	u32 cookie, hal_rx_desc_sz, dest_ring_info0;
>> +	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
>>   	int ret;
>>   	struct ath12k_rx_desc_info *desc_info;
>>   	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
>> @@ -3060,13 +3060,11 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
>>   	reo_ent_ring->rx_mpdu_info.peer_meta_data =
>>   		reo_dest_ring->rx_mpdu_info.peer_meta_data;
>>   
>> -	/* Firmware expects physical address to be filled in queue_addr_lo in
>> -	 * the MLO scenario and in case of non MLO peer meta data needs to be
>> -	 * filled.
>> -	 * TODO: Need to handle for MLO scenario.
>> -	 */
>> -	reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
>> -	reo_ent_ring->info0 = le32_encode_bits(dst_ind,
>> +	reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
>> +	queue_addr_hi = upper_32_bits(rx_tid->paddr);
> Shouldn't there be a cpu_to_le32 somewhere here ? It just seems asymetrical
> between the two values extracted from rx_tid->paddr
le32_encode_bits of queue_addr_hi does that conversion, so there is no 
need to explicitly convert cpu_to_le32 while fetching rx_tid->paddr's 
upper 32 bits.
>> +	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
>> +					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
>> +			      le32_encode_bits(dst_ind,
>>   					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
>>   
>>   	reo_ent_ring->info1 = le32_encode_bits(rx_tid->cur_sn,
> 

