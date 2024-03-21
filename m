Return-Path: <linux-wireless+bounces-5071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE04881B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 03:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3C3B21FDE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 02:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D74C8C;
	Thu, 21 Mar 2024 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDqe1HTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EE2900
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989746; cv=none; b=l70NvsDt2NuMjvPzgcOXfWsstphx9iZ7uaXr5DogI/CxsLNLyekJuJloYQ0aLsZ+nNXlcVU1VBTv/ej0KI/d+DSw7bHA4k6AAdEtAsh1/eqtLh4KEJj5L5DxdQMOeU8RPeEtOLclOeERRywMXvk4LrIqo6gGi952h8ztraroQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989746; c=relaxed/simple;
	bh=XVv3Nz2tudCr+l04XlEBxOIAeiF7gBzXnX9rS+FKMXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gh4scI0YQGaFR+OXHjHJtj579JrMIh6H4tTPLdZUh1GEumIOozfi5kwm3Fsd6j+/FU5FFi/DMfKL78GUt4v5+60mV6SYEJw2SZAbbPE+F7yrDMZ2XI7/8sUv7lq6OhyM1sQZeEFpI4ddZY4R7bRSn+CuXkRmfjV+46E03Quj0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WDqe1HTk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L1u4DT017430;
	Thu, 21 Mar 2024 02:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JP3CJvzB68AL2eNTCfS0fR/NdaIV2BOHr1dcun4WeRE=; b=WD
	qe1HTk/zxiYeXRL9L1ga5T8GtkAnh3tpMf+7oQFKKxtgYI9/uCGFHfT11zKVoZsF
	N3UZ5/B5WppOjb9TDLYZQo26vvzreshxK5hHktqTPIuzvnxa1TLfLdSdPlkjZ7TZ
	X3U2zFN1ZutIScIkEcFSewWIUfL6UKXZRiURJZjwUsLyeRfu20AsmX3BiVG8fK+x
	BEpWcnXAMv9mcnrqINCBX5DEBcnwI8tthGSEG2kxXgOPrZ7zq6ZnoPU13BLPWONu
	EHGHt1EDZMVvQOsjkbY1ySPkavwSGFZ4WgAPSpywxLquKV2KH6Y5ItPfTZhHU48G
	HKlaIzVQYaiDxGFTZfvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x038xs5g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 02:55:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L2tb2X008490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 02:55:37 GMT
Received: from [10.110.69.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 19:55:36 -0700
Message-ID: <2ef372a8-7d9f-4a9e-a664-cb8170487911@quicinc.com>
Date: Thu, 21 Mar 2024 10:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal strength in station mode
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
 <171034681684.2322265.9660346495295315212.kvalo@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <171034681684.2322265.9660346495295315212.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eofo4WGdy1UcS_H-e0zJ_VHrP4-iG_Mj
X-Proofpoint-ORIG-GUID: Eofo4WGdy1UcS_H-e0zJ_VHrP4-iG_Mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_14,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=982
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210020

On 2024/3/14 0:20, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> wrote:
> 
>> Currently, the calculation of the average signal strength in station mode
>> is incorrect.
>>
>> This is because before calculating the average signal strength, ath11k need
>> to determine whether the hardware and firmware support db2dbm, if the
>> hardware and firmware support db2dbm, do not need to add noise floor,
>> otherwise, need to add noise floor.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> What about AP chipsets like QCN9074, do they also work similarly?
> 

yes, i asked WIN's colleague Ashok Raj Nagarajan for helping to test 
this patch.
they work similarly.

Best regards
Lingbo Kong

