Return-Path: <linux-wireless+bounces-19494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2324A467F6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4F53B159F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE05224AFA;
	Wed, 26 Feb 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ldwW9sbJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DE21CA1B;
	Wed, 26 Feb 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590627; cv=none; b=HJHGN34Ye0rWE6ME2G12twJHXxQLBpdT6l7S233ZMWlzDjZ9Cd00X28Fm5vO8dMd5XWeAAgu4a2DsBuVlDvRzmaZ8Dq8s2BxWfaija0YVv9Nxz2zBanai06rui5tH3vVM5Ke+9lkNcN+TzzrGwjnLUKLS40w89VG50+BvaIGeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590627; c=relaxed/simple;
	bh=HGwnlz6pv/Fb7lL2quyyqZ4JE/enMKnRrNzyVvBqoiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a7dM7O+jlLsiJqaqIrs6pYM+J3FOSnCM11txlVy8I8/JKyI3CZ5TVFRPZta26s9wn+cItM+ODW6rBGjItQD2my6ttiIN9pDdZZQFuIZfCyOUHi86iqPfYKkt66KM943a9PvDsgwLxCSxj2+WMNfSzlbBZVnv8ryiNy/wMY/SAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ldwW9sbJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9o1M0015555;
	Wed, 26 Feb 2025 17:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nEdct1oFohxhIryKjdAIwPhbqyjIFSucHG1dtgoTYW8=; b=ldwW9sbJdK8eVdTb
	Y1qjMT6hmMa6r1EwpjOQBILpl9C5irTB9Ue30CgjgG2JbNu6SHXULSok6QLY7jcd
	rPyeaJvWl03/hu8OLA2CpV+kW5F2E8B3bx8+UCtiDS4kBLGqSmt388QKqZas+7GN
	a6kKLUxF3ApoGDLtKeDtfuQwhNNR6CSSQSPS1PRXZFophbIN07NUn9+6GTCWAtWF
	1LBerOpzNi/bmab2A/oMAOM29YbYB++tfkK5TZn4oNk65t0ActhOYCuD8vH1pv//
	88gHL6rQO45TQyWyUAd8tsphqu2FAhgesi9pwBFTAya4WNX7t5D6tCxbuNUGxXw2
	3e0bTw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnjser-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 17:23:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QHNaDp019195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 17:23:36 GMT
Received: from [10.216.2.27] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 09:23:32 -0800
Message-ID: <cedf59c5-dd2a-4d1e-960e-d76e45d9c215@quicinc.com>
Date: Wed, 26 Feb 2025 22:53:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] wifi: ath12k: Enable IPQ5424 WiFi device support
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Saravanakumar Duraisamy
	<quic_saradura@quicinc.com>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
 <20250130051838.1924079-6-quic_rajkbhag@quicinc.com>
 <20250130-offbeat-sparkling-nyala-042b72@krzk-bin>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250130-offbeat-sparkling-nyala-042b72@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lkeT0pJan9TQ6_etFbuLf8TCvP01r3Iy
X-Proofpoint-ORIG-GUID: lkeT0pJan9TQ6_etFbuLf8TCvP01r3Iy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260137

On 1/30/2025 2:09 PM, Krzysztof Kozlowski wrote:
> On Thu, Jan 30, 2025 at 10:48:38AM +0530, Raj Kumar Bhagat wrote:
>> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>>
>> Currently, ath12k AHB (in IPQ5332) uses SCM calls to authenticate the
>> firmware image to bring up userpd. From IPQ5424 onwards, Q6 firmware can
>> directly communicate with the Trusted Management Engine - Lite (TME-L),
>> eliminating the need for SCM calls for userpd bring-up.
>>
>> Hence, to enable IPQ5424 device support, use qcom_mdt_load_no_init() and
>> skip the SCM call as Q6 will directly authenticate the userpd firmware.
>>
>> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Co-developed-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
>> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/ahb.c | 80 +++++++++++++++++----------
>>  drivers/net/wireless/ath/ath12k/ahb.h |  9 +++
>>  2 files changed, 61 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
>> index d502b59a78d8..75767915dec3 100644
>> --- a/drivers/net/wireless/ath/ath12k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
>> @@ -21,6 +21,9 @@ static const struct of_device_id ath12k_ahb_of_match[] = {
>>  	{ .compatible = "qcom,ipq5332-wifi",
>>  	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
>>  	},
>> +	{ .compatible = "qcom,ipq5424-wifi",
>> +	  .data = (void *)ATH12K_HW_IPQ5424_HW10,
>> +	},
>>  	{ }
>>  };
>>  
>> @@ -398,8 +401,8 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>>  		ATH12K_AHB_UPD_SWID;
>>  
>>  	/* Load FW image to a reserved memory location */
>> -	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
>> -			    &mem_phys);
>> +	ret = ab_ahb->ahb_ops->mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys,
>> +					mem_size, &mem_phys);
>>  	if (ret) {
>>  		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
>>  		goto err_fw;
>> @@ -430,11 +433,13 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>>  		goto err_fw2;
>>  	}
>>  
>> -	/* Authenticate FW image using peripheral ID */
>> -	ret = qcom_scm_pas_auth_and_reset(pasid);
>> -	if (ret) {
>> -		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>> -		goto err_fw2;
>> +	if (ab_ahb->scm_auth_enabled) {
>> +		/* Authenticate FW image using peripheral ID */
>> +		ret = qcom_scm_pas_auth_and_reset(pasid);
>> +		if (ret) {
>> +			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>> +			goto err_fw2;
>> +		}
>>  	}
>>  
>>  	/* Instruct Q6 to spawn userPD thread */
>> @@ -491,13 +496,15 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>>  
>>  	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
>>  
>> -	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>> -		ATH12K_AHB_UPD_SWID;
>> -	/* Release the firmware */
>> -	ret = qcom_scm_pas_shutdown(pasid);
>> -	if (ret)
>> -		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
>> -			   ab_ahb->userpd_id, ret);
>> +	if (ab_ahb->scm_auth_enabled) {
>> +		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>> +			 ATH12K_AHB_UPD_SWID;
>> +		/* Release the firmware */
>> +		ret = qcom_scm_pas_shutdown(pasid);
>> +		if (ret)
>> +			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
>> +				   ab_ahb->userpd_id);
>> +	}
>>  }
>>  
>>  static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
>> @@ -707,6 +714,14 @@ static int ath12k_ahb_map_service_to_pipe(struct ath12k_base *ab, u16 service_id
>>  	return 0;
>>  }
>>  
>> +static const struct ath12k_ahb_ops ahb_ops_ipq5332 = {
>> +	.mdt_load = qcom_mdt_load,
>> +};
>> +
>> +static const struct ath12k_ahb_ops ahb_ops_ipq5424 = {
>> +	.mdt_load = qcom_mdt_load_no_init,
>> +};
>> +
>>  static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
>>  	.start = ath12k_ahb_start,
>>  	.stop = ath12k_ahb_stop,
>> @@ -1041,19 +1056,9 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
>>  	struct device_node *mem_node;
>>  	struct ath12k_ahb *ab_ahb;
>>  	enum ath12k_hw_rev hw_rev;
>> -	u32 addr, userpd_id;
>> +	u32 addr;
>>  	int ret;
>>  
>> -	hw_rev = ath12k_ahb_get_hw_rev(pdev);
>> -	switch (hw_rev) {
>> -	case ATH12K_HW_IPQ5332_HW10:
>> -		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
>> -		userpd_id = ATH12K_IPQ5332_USERPD_ID;
>> -		break;
>> -	default:
>> -		return -EOPNOTSUPP;
>> -	}
> 
> You just added this code in previous patchset, why are you moving it?
> 

In the v6 of dependent series ([PATCH v6 00/13] wifi: ath12k: add Ath12k AHB driver
support for IPQ5332), we have moved this part of the code in the required position.
In the next version the above hunk will not be required.

>> -
>>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
>> @@ -1067,13 +1072,32 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	ab_ahb = ath12k_ab_to_ahb(ab);
>> +	ab_ahb->ab = ab;
>> +
>> +	hw_rev = ath12k_ahb_get_hw_rev(pdev);
>> +	switch (hw_rev) {
>> +	case ATH12K_HW_IPQ5332_HW10:
>> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
>> +		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
>> +		ab_ahb->scm_auth_enabled = true;
>> +		ab_ahb->ahb_ops = &ahb_ops_ipq5332;
>> +		break;
>> +	case ATH12K_HW_IPQ5424_HW10:
>> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
>> +		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
>> +		ab_ahb->scm_auth_enabled = false;
>> +		ab_ahb->ahb_ops = &ahb_ops_ipq5424;
> 
> Why you cannot store just proper driver data structure in match data?
> This entire switch is redundant.
> 

Thanks for this optimization suggestion. Will implement this in the next version.


