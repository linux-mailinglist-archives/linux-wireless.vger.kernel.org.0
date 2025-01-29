Return-Path: <linux-wireless+bounces-18167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91281A223FE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B347A043D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DE1DFE2C;
	Wed, 29 Jan 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VmYAGITo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB81DE8A9;
	Wed, 29 Jan 2025 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175673; cv=none; b=rUo7XLE32M4D/gHy0ZZmrZVb4wM5IpUf9LlNaouVDQSGKZOx3HJJNcOJpn7GRgGMkjM/8X6+89qYnwRfCZDPX8FjXKWqa4cs1G36pVDM7acM7cPieQeN6NzJRdOGBIOuIMI3NQCdBYpgqNuni61oxJ7W2mkORdHVHnBIt5ULdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175673; c=relaxed/simple;
	bh=xstGUppIkpVfhiT9Zro69zSLNWDI5QRPTvOhYOx8414=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mHFsy0vZCRzjvdZN4Gp7Jc7RPI/Xs1hdOxgPrIkMSBERdSxKfbDZTT8umTBh3iMVVAC8BcgP07iQt5nPantL0iLggLdB5qYvl3u50lNZ1gIsupwS89LeOAX41A9fU/hlG43spT9udrdSuOlbAiY9VxBgONWbW1dezb1GgL8vTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VmYAGITo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T97Mkt026772;
	Wed, 29 Jan 2025 18:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i8zo7JP0yu8porO7pBG/6wKxZHbPij8pNRsbn09HkVA=; b=VmYAGITog1yjxjQH
	/doPScrIR6R0P5J3Vgldr/Wpegcf9n0ahHStaae2Ot/bikqblvv94mUsgtA2eE7n
	XGIAR9Y5LRX4Z8mMJfxOl+Mgu5DYB5yuJVhri50LJaeFfnaxhe645e+juAgTifMR
	LGGHtmwp8xk63w+SOEPdQvvFxm4u2IaUA9pQ3WqDK3JkH5NnZJhjIGVYKJuv/qC0
	FrcLowm0oC+Nhn0xxxll1hCRHi29SoQUY+/NUMB1vHgpRskDq6YVn5nTCGVswXKF
	n6FEMPwl5+Dcm40RpfaksoJQsoQRWVhNdRhpGzcWh89ENJ50DKQfM6T7FswlLUJB
	3GT2Xg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fhdq94dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:34:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TIYOsl003725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:34:24 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 10:34:20 -0800
Message-ID: <89d1793e-069a-41b7-bf49-28da4acc7ea2@quicinc.com>
Date: Thu, 30 Jan 2025 00:04:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] wifi: ath12k: Power up userPD
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-12-quic_rajkbhag@quicinc.com>
 <bd3f7586-4119-47f5-bbf6-a43bd02088b8@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <bd3f7586-4119-47f5-bbf6-a43bd02088b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LYZIGWQfRlwNFzD2LCXk7-6V5cRhKSDJ
X-Proofpoint-GUID: LYZIGWQfRlwNFzD2LCXk7-6V5cRhKSDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290146

On 12/10/2024 8:22 PM, Krzysztof Kozlowski wrote:
> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>> +
>> +	time_left = wait_for_completion_timeout(&ab_ahb->userpd_ready,
>> +						ATH12K_USERPD_READY_TIMEOUT);
>> +	if (!time_left) {
>> +		ath12k_err(ab, "UserPD ready wait timed out\n");
>> +		ret = -ETIMEDOUT;
>> +		goto err_fw2;
>> +	}
>> +
>> +	qcom_smem_state_update_bits(ab_ahb->spawn_state, BIT(ab_ahb->spawn_bit), 0);
>> +
>> +	ath12k_info(ab, "UserPD%d is now UP\n", ab_ahb->userpd_id);
> 
> Don't bug users with success messages. Your driver is supposed to be
> silent on success.
> 

sure, will move this to ath12k_dbg() print.

>> +
>> +err_fw2:
>> +	release_firmware(fw2);
>> +err_fw:
>> +	release_firmware(fw);
>> +	return ret;
>> +}
>> +
>>  static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
>>  {
>>  	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
>> @@ -557,6 +694,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
>>  	.irq_enable = ath12k_ahb_ext_irq_enable,
>>  	.irq_disable = ath12k_ahb_ext_irq_disable,
>>  	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
>> +	.power_up = ath12k_ahb_power_up,
>>  };
>>  
>>  static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
>> diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
>> index 0999e2bbe970..0dbbbfd45eab 100644
>> --- a/drivers/net/wireless/ath/ath12k/ahb.h
>> +++ b/drivers/net/wireless/ath/ath12k/ahb.h
>> @@ -19,7 +19,15 @@
>>  #define ATH12K_PCI_IRQ_CE0_OFFSET		3
>>  #define ATH12K_ROOTPD_READY_TIMEOUT		(5 * HZ)
>>  #define ATH12K_RPROC_AFTER_POWERUP		QCOM_SSR_AFTER_POWERUP
>> -
> 
> Why? You just added this line in previous commits.
> 

will take care in next version.

>> +#define ATH12K_AHB_FW_PREFIX			"q6_fw"
>> +#define ATH12K_AHB_FW_SUFFIX			".mdt"
> Best regards,
> Krzysztof


