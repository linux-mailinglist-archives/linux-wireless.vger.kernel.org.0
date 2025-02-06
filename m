Return-Path: <linux-wireless+bounces-18552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C942A29E69
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 02:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D07A3C88
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7671E487;
	Thu,  6 Feb 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YpXVPxc7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FC14286
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805752; cv=none; b=iLO1gBNLj3wgl0oCDWFJJIbokjHl71mtXLZKMUQLq8MhBp3yXu1YbvS7ONOf3DutPMKABXZj/9zTmN46k0QAZIkPfdEU95EkUPrDRUbzQA0xtQbhiLjiDvygispzB+EXeRvPhmCNtyXGcAHLvXwO+I8MxfoJD56o0BV8z0DB5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805752; c=relaxed/simple;
	bh=YSiADRmwRhosLU3+vluEeS7e2iJjUAfyDxEcNLDZBgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m7h+mthevnqJ2xgAjTwkeJkU5zEZLa7/mlC+NMbRbqxlY/u2WwtW7iww+ldno/6bQ8gjdfuQ6bqjfU3ERku18bHTxa0eitP0Z5R9iEkCSoXLHHCe5im53SXSqLwACz35i3LJ7kXwGmk/+KlF6wFZbxJb8429bKrV7Q5m7yEUxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YpXVPxc7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515ErWuD010956;
	Thu, 6 Feb 2025 01:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wckn86K8Bl+dln2gtn/vP5qqVU/AFRcUiThat0sRwPA=; b=YpXVPxc76X4Fj6qC
	YKrWZUh6aLjWKwj0u59vtzR5E/dVNq7qqkkRQpZCFcE4PoBHkK50l6Qu/Ur4Mjes
	ok1WF6SQ0e9DCy9LzgOoQzMUYn3kTFTzOdYXRVr6HhRlHkkfOQd18N1BJWony6nt
	5+jWD0dCf3mOOAAVzBUpGEzTBXngzAcysfgQXxE5Oszg1iLSyNfl1Q1Hzg2iewcn
	dla35tuptFjgkGEVxrPiZ0XMKo7+1DeG81c8pMCutw21oIAhras0l01+5mjbBFKk
	oOfbrX8x97xgvYwnC7tMCfKxG15RTcK7xTR65MjKxVWKM8S+4WKki4gZQLaRSTMJ
	Apk8WA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ma599c52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 01:35:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5161Zisb012540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 01:35:45 GMT
Received: from [10.216.27.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Feb 2025
 17:35:42 -0800
Message-ID: <bef80a7f-1175-e820-2bf6-7b7eaf4f38a5@quicinc.com>
Date: Thu, 6 Feb 2025 07:05:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
 <20250204035718.3227726-2-quic_periyasa@quicinc.com>
 <414ca414-d6a4-4228-acb3-dde4bb71624d@oss.qualcomm.com>
 <0f7885ad-a360-2ff1-eb0b-51454de2eeb0@quicinc.com>
 <924677f8-b1bd-472d-aca6-60d23899e455@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <924677f8-b1bd-472d-aca6-60d23899e455@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QmCAXSrhJMx-5R6cGEFt1NyqEetykFpX
X-Proofpoint-ORIG-GUID: QmCAXSrhJMx-5R6cGEFt1NyqEetykFpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=793 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060010



On 2/6/2025 6:38 AM, Jeff Johnson wrote:
> On 2/4/2025 5:02 PM, Karthikeyan Periyasamy wrote:
>>
>>
>> On 2/5/2025 3:59 AM, Jeff Johnson wrote:
>>> On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
>>>> Currently, monitor is not enabled. However, in the future, the monitor
>>>> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
>>>> parsing support in monitor Rx path, which help to populate the EHT
>>>> radiotap data.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>
>>>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
>>>
>>> Normally your S-O-B should be the last tag. Any tags you collect should come
>>> before it.
>>
>> Oh my bad, if you want to re-spin ?
>> will fix it in the next version of the path.
>>
> 
> yes, please re-spin

sure

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

