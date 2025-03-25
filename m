Return-Path: <linux-wireless+bounces-20797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE921A6EE01
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C02188B6DD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE991E8336;
	Tue, 25 Mar 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dEU8y4YM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76C27466
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899541; cv=none; b=Io/Pqnpr43/EP79rprrMsMWYCLMjKAt7aBcWTLtOY+qVppJCThO/QvNnEkyLpLMgNf+DyVYHWuB72LHzO2b35ae4hHExgNlP5/fg25mTr1u1lc9YYaztVRKInPQXBGcNrfRLnflEWNaun9kNVQcNaylUdecRgbzN9z4OePKhdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899541; c=relaxed/simple;
	bh=ns/J72HSeoEPmbPdsrfvy0/ByWn9+6gXChqc9hO/5eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YAYC9dVJZKWSQl/ulzVbk7V7oQ10kB8XRUJd09miwaWnQMMbq4XYESeWXW0D8pnxhBCsB9qlBPrBu4c29spc+rfDs8twjNdgL/OwWeXk0pIoHY6nOwCGXncMFzPA5jrbXLQaMQNkhOO+OpjD5Q3gUQpcvo78PxA+CYrtmB+wj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dEU8y4YM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vcP3002327;
	Tue, 25 Mar 2025 10:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s3EPz2QEYwdjZPKN4mFs86okgh0YBTCmd0u0tLZZUMc=; b=dEU8y4YMRC49zPOQ
	KSMsXIsJpTVT68pmaYtAnc3ieUfk524sdwKLzKvGRy4vvtJNTTK+ybaBW/EkosN7
	xCMBRmwANBkhxrctio4YFC4uoDZ+acFFJDPra6cSf7fG1QjS+h/EQV8oPulGRjtv
	I2+mrK0xlSAHQCStR9KOP6t/y1U7vB9Xk+D3ZADHBeeYwXD0m4ckZlL0SSdkGrIM
	ZPmy05BAlq3rEgGJdum1ugs9LfuQ2UEtqqDq76RI47dyk7LOAuQxWbbjBF7Fcei/
	rsHd55PMnyZwEha1xaHkp1L0AcbkQ0rKPRCdnpfrJYebcMr4YOyxXbO6sIEHPBTF
	REERug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wfghm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:45:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52PAjIEm029496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:45:18 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 03:45:17 -0700
Message-ID: <e0fee212-9895-43ea-bed2-b2426a6221de@quicinc.com>
Date: Tue, 25 Mar 2025 18:45:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/5] wifi: ath11k: determine PM policy based on
 machine model
To: Julian Wollrath <jwollrath@web.de>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250320023003.65028-1-quic_bqiang@quicinc.com>
 <20250320023003.65028-2-quic_bqiang@quicinc.com>
 <20250325114004.101a7c10@schienar>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250325114004.101a7c10@schienar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZqsbmXBD3jpFIaIjq0ws_iAyk5e2soH5
X-Proofpoint-ORIG-GUID: ZqsbmXBD3jpFIaIjq0ws_iAyk5e2soH5
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e2893f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ht9imkM619IzCZU5_PMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250074



On 3/25/2025 6:40 PM, Julian Wollrath wrote:
> Hi,
> 
> Am Do, 20 Mär 2025 10:29:59 +0800
> schrieb Baochen Qiang <quic_bqiang@quicinc.com>:
> 
>> To handle the Lenovo unexpected wakeup issue [1], previously we revert
>> commit 166a490f59ac ("wifi: ath11k: support hibernation"). So
>> currently WLAN target is put into WoWLAN mode during suspend. This is
>> a temporary solution as it does not work on machines where WLAN power
>> is cut off.
>>
>> The thought here is that we do WoWLAN suspend on Lenovo machines while
>> do non-WoWLAN suspend (which is done in the reverted commit) on other
>> machines. This requires us to identify Lenovo machines from others.
>> For that purpose, read board vendor and product name from DMI
>> interface, match it against all known affected machines. If there is
>> a match, choose WoWLAN suspend mode, else choose non-WoWLAN mode.
>> Save the mode in ab for later reference.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>
>> Tested-on: WCN6855 hw2.0 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c | 55
>> ++++++++++++++++++++++++++ drivers/net/wireless/ath/ath11k/core.h |
>> 7 ++++ 2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c
>> b/drivers/net/wireless/ath/ath11k/core.c index
>> 3d39ff85ba94..8657e735bf16 100644 ---
>> a/drivers/net/wireless/ath/ath11k/core.c +++
>> b/drivers/net/wireless/ath/ath11k/core.c @@ -907,6 +907,52 @@ static
>> const struct ath11k_hw_params ath11k_hw_params[] = { },
>>  };
>>  
>> +static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
>> +		},
>> +	},
> 
> including the quirk for 21K4 is not needed (at least for my machine)

hmm, I got info from OEM that 21K4 is also affected, so can not remove it.

I do hear that for same machine someone is able to hit the unexpected wakeup while someone
is not.

> but causes the interface to not come up again after putting the system
> into hibernation.

I will send v2 to address this issue in several days if everything goes fine.

> 
> 
> Cheers,
> Julian
> 
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>>  static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct
>> ath11k_base *ab) {
>>  	WARN_ON(!ab->hw_params.single_pdev_only);
>> @@ -2327,8 +2373,17 @@ EXPORT_SYMBOL(ath11k_core_pre_init);
>>  
>>  int ath11k_core_init(struct ath11k_base *ab)
>>  {
>> +	const struct dmi_system_id *dmi_id;
>>  	int ret;
>>  
>> +	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
>> +	if (dmi_id)
>> +		ab->pm_policy = (enum
>> ath11k_pm_policy)dmi_id->driver_data;
>> +	else
>> +		ab->pm_policy = ATH11K_PM_DEFAULT;
>> +
>> +	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n",
>> ab->pm_policy); +
>>  	ret = ath11k_core_soc_create(ab);
>>  	if (ret) {
>>  		ath11k_err(ab, "failed to create soc core: %d\n",
>> ret); diff --git a/drivers/net/wireless/ath/ath11k/core.h
>> b/drivers/net/wireless/ath/ath11k/core.h index
>> 1a3d0de4afde..df2b0cb2f0b5 100644 ---
>> a/drivers/net/wireless/ath/ath11k/core.h +++
>> b/drivers/net/wireless/ath/ath11k/core.h @@ -892,6 +892,11 @@ struct
>> ath11k_msi_config { u16 hw_rev;
>>  };
>>  
>> +enum ath11k_pm_policy {
>> +	ATH11K_PM_DEFAULT,
>> +	ATH11K_PM_WOW,
>> +};
>> +
>>  /* Master structure to hold the hw data which may be used in core
>> module */ struct ath11k_base {
>>  	enum ath11k_hw_rev hw_rev;
>> @@ -1058,6 +1063,8 @@ struct ath11k_base {
>>  	} testmode;
>>  #endif
>>  
>> +	enum ath11k_pm_policy pm_policy;
>> +
>>  	/* must be last */
>>  	u8 drv_priv[] __aligned(sizeof(void *));
>>  };
> 
> 
> 


