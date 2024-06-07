Return-Path: <linux-wireless+bounces-8691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714C900581
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7651C20B3C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDD192B89;
	Fri,  7 Jun 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AgdrmL/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B1194AD6
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768161; cv=none; b=dw83Ousf4OzgiPUfyVxCEpVaAR3zxP2fuCHMsfimGsJjJYcMdKSHiUy41F2RAkp82Ro2gW8EGRXmJF2+MG5ksVHaZuswwQIWZabkpdnVSaC/OYVkfi2Odh+F50+hDX43b+P18rftEAwIMOt1eLVETSMsABxBSZdPmll78fpyL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768161; c=relaxed/simple;
	bh=vctVhuXr55CzSVonemQhTTFl6CBvgexYrotbMyFRnXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U6MqrO/g3JKVkZu3FqURofLL6FMoxna+cZg8twuozyZj3Mc8/lXJcTHwpkQTjPOxIMyZtCaJSTL3h2qE7Nr8WhMTnfS+RZy/Y+9oB2VXCpYwjK6hlEjDIcuXv6X5SFzGxInOPwnGqLZlczYASfqCyHRpc99cGz7eX0qxEwVALGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AgdrmL/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457BhMPW003956;
	Fri, 7 Jun 2024 13:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w5vzucxF6WdEu6M6aGj9WlMkNG162ITtnAQLJ2fiHtI=; b=AgdrmL/AE469So6S
	LCHtllHlAmZ0xwm0AD3YhgFGa08/Ma8925SvI+0evH6AhPIbkraGLXy3oCMmPPGW
	awO6reJpwcpI5Ih2GFVjj6YKhu0vHm96/l3LuYLMeFwn6U7AYe74BteEe9a1KhBc
	0tTIpr/kQNEYhgP8VjhxhouKj+luy2qhlXf0eOsaWx3YiH0hXC5tV80jEPaJYMVf
	KgR9+KotlnusOZ9FJB+BlYi6yS9OEvBc+hb54tZtscFTHARATReJTeAHCzJ5g/CC
	6fsNBFjN3HMlW3HVWC7PQ9MSPfofuIDsgosYCQx48inxEMSEjfZzFFRP9zY77Ial
	dVyYwQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjxxavqft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 13:49:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457DnEW9016043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 13:49:14 GMT
Received: from [10.216.36.52] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 06:49:12 -0700
Message-ID: <dd2488bb-43f9-d546-7617-2a54ca3d1a1d@quicinc.com>
Date: Fri, 7 Jun 2024 19:19:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v8 7/8] wifi: ath12k: refactor core start based on
 hardware group
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
 <20240531180411.1149605-8-quic_hprem@quicinc.com> <87plsuql2y.fsf@kernel.org>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <87plsuql2y.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vjGuiJLIxhgI1S_jgsB9nrsn7ZuLdfhp
X-Proofpoint-GUID: vjGuiJLIxhgI1S_jgsB9nrsn7ZuLdfhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=983 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070101



On 6/6/2024 6:34 PM, Kalle Valo wrote:
> Harshitha Prem <quic_hprem@quicinc.com> writes:
> 
>> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>
>> Currently, mac allocate/register and core_pdev_create are initiated
>> immediately when QMI firmware ready event is received for a particular
>> device.
>>
>> With hardware device group abstraction, QMI firmware ready event can be
>> received simultaneously for different devices in the group and so, it
>> should not be registered immediately rather it has to be deferred until
>> all devices in the group has received QMI firmware ready.
>>
>> To handle this, refactor the code of core start to move the following
>> apis inside a wrapper ath12k_core_hw_group_start()
>>          * ath12k_mac_allocate()
>>          * ath12k_core_pdev_create()
>>          * ath12k_core_rfkill_config()
>>          * ath12k_mac_register()
>>          * ath12k_hif_irq_enable()
>>
>> similarly, move the corresponding destroy/unregister/disable apis
>> inside wrapper ath12k_core_hw_group_stop()
>>
>> Add the device flags to indicate pdev created and IRQ enabled which would
>> be helpful for device clean up during failure cases.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 210 +++++++++++++++++++------
>>   drivers/net/wireless/ath/ath12k/core.h |  32 ++++
>>   2 files changed, 191 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index ebe31cbb6435..90c70dbfc50a 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -563,6 +563,9 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
>>   
>>   static void ath12k_core_stop(struct ath12k_base *ab)
>>   {
>> +	clear_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
>> +	ath12k_dec_num_core_started(ab);
>> +
>>   	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
>>   		ath12k_qmi_firmware_stop(ab);
>>   
>> @@ -689,11 +692,15 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
>>   		return ret;
>>   	}
>>   
>> +	set_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
>> +
>>   	return 0;
>>   }
>>   
>>   static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
>>   {
>> +	clear_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
>> +
>>   	ath12k_dp_pdev_free(ab);
>>   }
>>   
>> @@ -702,6 +709,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
>>   {
>>   	int ret;
>>   
>> +	lockdep_assert_held(&ab->core_lock);
>> +
>>   	ret = ath12k_wmi_attach(ab);
>>   	if (ret) {
>>   		ath12k_err(ab, "failed to attach wmi: %d\n", ret);
>> @@ -795,6 +804,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
>>   		/* ACPI is optional so continue in case of an error */
>>   		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
>>   
>> +	if (!test_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags)) {
>> +		/* Indicate the core start in the appropriate group */
>> +		ath12k_inc_num_core_started(ab);
>> +		set_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
>> +	}
>> +
>>   	return 0;
>>   
>>   err_reo_cleanup:
>> @@ -806,6 +821,108 @@ static int ath12k_core_start(struct ath12k_base *ab,
>>   	return ret;
>>   }
>>   
>> +static void ath12k_core_device_cleanup(struct ath12k_base *ab)
>> +{
>> +	mutex_lock(&ab->core_lock);
>> +
>> +	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
>> +		ath12k_hif_irq_disable(ab);
>> +
>> +	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
>> +		ath12k_core_pdev_destroy(ab);
>> +
>> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
>> +		ath12k_mac_unregister(ab);
>> +		ath12k_mac_destroy(ab);
>> +	}
>> +
>> +	mutex_unlock(&ab->core_lock);
>> +}
> 
> This patch is just abusing flags and because of that we have spaghetti
> code. I have been disliking use of enum ath12k_dev_flags before but this
> is just looks too much. I am wondering do we need to cleanup the ath12k
> architecture first, reduce the usage of flags and then revisit this
> patchset?
> 
yeah., more dev flags :( but flags were needed for the race conditions 
when multiple devices where involved in a group, some devices would have 
completed till pdev create some might not. Some crashes were seen 
because hif_irq_disable was called for a device in a group but that 
device was not even at the stage of core register. Will check the 
possibility to  reduce the flag usage but it seemed necessary for 
multiple device group clean up.

Thanks,
Harshitha

