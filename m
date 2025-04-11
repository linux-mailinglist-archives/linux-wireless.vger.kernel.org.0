Return-Path: <linux-wireless+bounces-21413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA481A853C8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6769C211A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C727EC8A;
	Fri, 11 Apr 2025 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dSGCcJ6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8A27F4CE
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350790; cv=none; b=hOop4Mn8OHlOSIXp8J57vACBGhI9m5asxfnayKtZVeq4y1vb1u2Vje+U5Vg8SVozbWjnUuuVKu/LVto2k6k6Zdhm7kYtCkgxfTsaFAYSQIs1d9M70gSBEscjj0JuRFt02ba8gYQtKobFQoDzI3zyO4H0L/3Nc45ajAt/8jyTwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350790; c=relaxed/simple;
	bh=e4sqov5lazVpufIgAnufE3TUmxY0QCXa49k4vSAu5NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=asbfiMUEFhVavapYUYDZwo13bIlHA19bVfYE5GaW8rXu0b/1J5PmxzrU1iFhiDag3nt5bR1st6o3aaINgljkQAAXiFbsHHfyDPXTxj8JKDj5BYZ97voovfDo1xpP3Tk4rl4yauP2i2L4eurvxZy7sTE8Zmgnk+7cQda4dluAcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dSGCcJ6c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGndrV030663;
	Fri, 11 Apr 2025 05:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pX/EOzdWAusHdfhP7CSb/7MaMVKXXFRKLNjMaH5ZfI4=; b=dSGCcJ6cUTVYsg8w
	TZcYJ3tRfgHvnS/or0AOTEzAXjIMiHUczA7PlEjmAC6ClxZiRq2NG5FHvsSRS7dq
	Z8jdoP/sSBBoio0uL/YdzN2yHhdMySYEc2QOSO1Ltm2zB962MxYSHw6D/GUkbrcF
	sjqU/xXWIf+15AC99cBmAyK4VzhdO6xb+xkrhtrab5htfuiyDDjdKBfrjeawAqJQ
	njq+MCY23gW8EOLB2MY85Cbbg+LVwyDDMNH0bPzJRX8mJ5bH2rovtlmsEZ52IOGS
	NpHNSXok8miR2HXTzJAxZAUYAX/A3ZzIjc9rkKcpCA7PTJwuGe+hNROUw1SnVZiA
	h4o0cQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfts3v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 05:53:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B5r38V022086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 05:53:03 GMT
Received: from [10.50.62.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Apr
 2025 22:53:02 -0700
Message-ID: <1b3c2ff7-89c3-41fa-9cae-20cf854a7b91@quicinc.com>
Date: Fri, 11 Apr 2025 11:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: using msdu end descriptor to
 check for rx multicast packets
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250408130132.2919329-1-quic_sarishar@quicinc.com>
 <20250408130132.2919329-2-quic_sarishar@quicinc.com>
 <cb37ecfe-c737-de97-0729-af2c87062058@quicinc.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <cb37ecfe-c737-de97-0729-af2c87062058@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f8ae40 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=jwzHO7tdmTva_yWHhpUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Fh9PFaTAWj8i3Setqxk2BEYS5AbpuruJ
X-Proofpoint-ORIG-GUID: Fh9PFaTAWj8i3Setqxk2BEYS5AbpuruJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=882
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110040

On 4/9/2025 12:16 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/8/2025 6:31 PM, Sarika Sharma wrote:
>> Currently, the RX multicast broadcast packet check is performed using
>> bit 15 from the info6 field of the MPDU start descriptor. This check
>> can also be done using bit 9 from the info5 field of the MSDU end
>> descriptor. However, in some scenarios multicast bit is not set when
>> fetched from MPDU start descriptor.
>> Therefore, checking the RX multicast broadcast packet from the MSDU
>> end descriptor is more reliable as it is per MSDU.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/hal.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/ 
>> wireless/ath/ath12k/hal.c
>> index d00869a33fea..d961392bb981 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>> @@ -449,8 +449,8 @@ static u8 
>> *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
>>   static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc 
>> *desc)
>>   {
>> -    return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
>> -           RX_MPDU_START_INFO6_MCAST_BCAST;
>> +    return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
>> +           RX_MSDU_END_INFO5_DA_IS_MCBC;
>>   }
>>   static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct 
>> hal_rx_desc *desc,
>> @@ -902,8 +902,8 @@ static u8 
>> *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc
>>   static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct 
>> hal_rx_desc *desc)
>>   {
>> -    return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
>> -           RX_MPDU_START_INFO6_MCAST_BCAST;
>> +    return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
>> +           RX_MSDU_END_INFO5_DA_IS_MCBC;
> 
> hal.c:905:16: warning: cast to restricted __le32
> hal.c:905:16: warning: cast from restricted __le16
> 
> Pls address the above warning.

Sure, let me correct it and send new version.

> 
> Vasanth



