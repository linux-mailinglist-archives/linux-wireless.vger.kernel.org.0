Return-Path: <linux-wireless+bounces-11650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674FB957B2E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FF4284DBC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A0A94F;
	Tue, 20 Aug 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z0r20mEW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63217BD5
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118706; cv=none; b=WMcFKU07pEyBFZ23Pr/X4ySG4QullMe15AxdOTWbJUbeOldL0rMii8rfl2SWOk3KFU3upMwhq31txufjLqqPa+4av0fB3LnHv0md+G6B+zZ0Naq6cUOK0LUp9VeTVJZdxlzysFRTfnv1BcVn7gaBlhxFLZJWIvyKB9dLbYPyU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118706; c=relaxed/simple;
	bh=onHytgF3kXtujzIz/eYkxvgv4EUqUHo8K8meOX+xirg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SR8uZeGyEQ4bXBCRiKhiT4QJQMdcZLPjsJRlOLJB3fz6Bfkdq6Wv0m5tWoOtzYcmyQWn7fzmDZv8zScMo4ICtMiSnnnK+wQxJRn+4kJ2dsBzNFvaNaQ53XeS7w5VN8LPtOrfTJ3aOfmb4qopJyJdPHjP8FZYOhhL2J3eNkGfXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z0r20mEW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JNe4Ce002613;
	Tue, 20 Aug 2024 01:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NdAxZncuXoxty+k24YBc+NkgmXgq0kwW8375hpCMQxE=; b=Z0r20mEWpdBUqCbO
	xTRCgVMF9UpwLFu5pYRIJh0POSBPIFwsOjKR8xXH/6Vy4pfyKci7MBDSjTQM+5Wp
	iyddQWaPvaRgtqIO4vwjLe6omyrieLmxMjRMP6GyuY6xYN2dbHNJzS+VkDbU+5iA
	1M0HZ839uEwd0xzU6+MWiIOg1gfjUzhG+xZOgqhRascXjANsqAQxGkpeD2V0kUNu
	/nIiRXbaXKy7yvQDEY/4s/yGy6g0vUO91E9uyat2PlCnADm9P8VX/28gC9dpV7y2
	ASidl80fC7+fFA9cwIVAa8nrO58sthZcdvG3su6jQQevj/ungHZhQ8YPNV6pLPM5
	YALEHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg3q5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 01:51:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K1pVsf032599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 01:51:31 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 18:51:30 -0700
Message-ID: <c16ca5e3-8d1b-4690-82b0-50827ce8b932@quicinc.com>
Date: Tue, 20 Aug 2024 09:51:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
To: James Prestwood <prestwoj@gmail.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
 <64c8a9c6-9da7-4e25-9245-490c9e7e21d2@gmail.com>
 <e49b05be-7fdd-4007-9137-e46703812fa1@quicinc.com>
 <6e93a6c8-015f-4649-8c72-d21fa9f9fde9@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <6e93a6c8-015f-4649-8c72-d21fa9f9fde9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JH1c5Nr0VIj-sYSf3jXYyJ2taKwlvAMd
X-Proofpoint-GUID: JH1c5Nr0VIj-sYSf3jXYyJ2taKwlvAMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200013



On 8/19/2024 7:47 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 8/19/24 2:45 AM, Baochen Qiang wrote:
>>
>> On 8/14/2024 11:46 PM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> On 7/15/24 5:38 AM, James Prestwood wrote:
>>>> Hi Baochen,
>>>>
>>>> I've compiled both changes and so far those messages are gone.
>>>>
>>>> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2
>>> I just noticed another one actually:
>>>
>>> invalid vht params rate 585 100kbps nss 1 mcs 4
>> Ah :(
>>
>> James, could you share some info about this? like hardware target, firmware version, AP model, and any specific steps to hit this.
> 
> This is running with your fixes in this patch set, which did fix the majority of the "invalid vht params" messages, but then recently I noticed some others.
> 
> The hardware:
> 
> kernel: ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 168c:3363
> kernel: ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
> 
> And its actually a few more than I thought:
> 
> ath10k_pci 0000:02:00.0: invalid vht params rate 900 100kbps nss 3 mcs 4
> ath10k_pci 0000:02:00.0: invalid vht params rate 867 100kbps nss 2 mcs 6
> ath10k_pci 0000:02:00.0: invalid vht params rate 540 100kbps nss 3 mcs 3
> ath10k_pci 0000:02:00.0: invalid vht params rate 1500 100kbps nss 3 mcs 7
> 
> I unfortunately don't have a way to reproduce it. We just see this now somewhat rarely, e.g. 13 of the above in the last 3 days. I assume its just when the MCS/NSS changes and we hit a rate that isn't mapped right like the few you fixed.
> 
Thank you for the info. will try to reproduce internally.

> Thanks,
> 
> James
> 
> 
>>
>>> Thanks,
>>>
>>> James
>>>
>>>> On 7/10/24 7:03 PM, Baochen Qiang wrote:
>>>>> supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host do not
>>>>> align with firmware's definitions, resulting in some warnings. Fix them.
>>>>>
>>>>> Baochen Qiang (2):
>>>>>     wifi: ath10k: fix invalid VHT parameters in
>>>>>       supported_vht_mcs_rate_nss1
>>>>>     wifi: ath10k: fix invalid VHT parameters in
>>>>>       supported_vht_mcs_rate_nss2
>>>>>
>>>>>    drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

