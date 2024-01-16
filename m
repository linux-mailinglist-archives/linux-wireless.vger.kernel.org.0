Return-Path: <linux-wireless+bounces-1957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A930482E892
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 05:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180E7283CFA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09379C1;
	Tue, 16 Jan 2024 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SCswTzkw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D8256A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G48CLI003035;
	Tue, 16 Jan 2024 04:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fwRt4ShUkKf5hBERPdC1lT0Bavy272wqYTsEgEKcGKU=; b=SC
	swTzkwhBGBXpuqyMR6GfVuvSfTfUFhdmpCv6HQU5H92yAybC3ke1d4YyssAuTQXG
	3pNd48jy3lj0NAwliY7tQD0rFBP83uEVMHD+fVZjgrxmQ81j6OwJuHoPOUAQXuKB
	qMsgwwk6Vgl8zaAlLzFwe6pSd9vBfY890tL1pxks4zg0jOaWW4rjgckS1qy1aO5l
	G11rTMcsZtRXimN7TbRibdf7FeuJ+JbO9eGh3QeXwL6DdC98zJ4C5KbMM9h3j67n
	EV3dOjfSOKrL1zr+bb0BnKDUFDim1o0WyOYmL7yBaNR54VkAiQG7HmX4W6FPb90t
	eTIU/s86RG0rNAKMMpUQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn2bjhv6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:45:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G4jxUs029630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:45:59 GMT
Received: from [10.50.41.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 20:45:57 -0800
Message-ID: <de5a4bbc-3533-7666-c079-9164ea98dd27@quicinc.com>
Date: Tue, 16 Jan 2024 10:15:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Sriram R
	<quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-2-quic_srirrama@quicinc.com>
 <aee0419e-c443-4b5d-957c-6c88dd3d4a71@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <aee0419e-c443-4b5d-957c-6c88dd3d4a71@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BcYh23J5ipajN6ibLlEM9IN6ev7gfJEN
X-Proofpoint-ORIG-GUID: BcYh23J5ipajN6ibLlEM9IN6ev7gfJEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=814 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160034


On 1/12/2024 10:33 PM, Jeff Johnson wrote:
> On 1/10/2024 8:50 PM, Sriram R wrote:
> ...
>
>> @@ -7553,10 +7553,12 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>>   
>>   static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
>>   {
>> -	struct ath12k *ar = ath12k_ah_to_ar(ah);
>> +	struct ath12k *ar;
>> +	int i;
>>   	u16 interface_modes = U16_MAX;
>>   
>> -	interface_modes &= ar->ab->hw_params->interface_modes;
>> +	for_each_ar(i, ah, ar)
>> +		interface_modes &= ar->ab->hw_params->interface_modes;
> This logic sets interface_modes to be the modes that are supported on
> every radio (starts with all modes supported and then masks off the ones
> that are not supported on a given radio). That means that if radio 0
> supports a mode that radio 1 does not support, then we don't advertise
> support for that mode. Just want to verify that is the correct logic,
> and that instead we don't want to start with no modes supported and then
> OR in the ones that are supported so that we get the list of modes that
> are supported on ANY radio instead of ALL radios.


Yes, interface_modes to be the modes that are supported on every radio 
not any radio.

Any radio support can be add in the future ath12k driver once the hw 
specific interface mode support is added in mac80211/cfg80211.


>>   
>>   	return interface_modes == U16_MAX ? 0 : interface_modes;
>>   }
>> @@ -7564,15 +7566,19 @@ static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
>>   static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
>>   					    enum nl80211_iftype type)
>>   {
>> -	struct ath12k *ar = ath12k_ah_to_ar(ah);
>> +	struct ath12k *ar;
>> +	int i;
>>   	u16 interface_modes, mode;
>>   	bool is_enable = true;
>>   
>>   	mode = BIT(type);
>> -
>> -	interface_modes = ar->ab->hw_params->interface_modes;
>> -	if (!(interface_modes & mode))
>> -		is_enable = false;
>> +	for_each_ar(i, ah, ar) {
>> +		interface_modes = ar->ab->hw_params->interface_modes;
>> +		if (!(interface_modes & mode)) {
>> +			is_enable = false;
> note that in the example I mentioned above, this logic could say a given
> mode is enabled even though the bit isn't set in the interface_modes
> listed above


The condition check "if (!(interface_modes & mode))" become true when 
the the bit isn't set in the interface_modes. So no issues.


Thanks,

Karthikeyan


