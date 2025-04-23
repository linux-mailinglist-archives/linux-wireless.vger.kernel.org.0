Return-Path: <linux-wireless+bounces-21899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85818A97F86
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F76C3A9E6E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174E3398B;
	Wed, 23 Apr 2025 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="br1P+PVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1CDF71;
	Wed, 23 Apr 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390889; cv=none; b=C8NHn6NxFrPdwLiPi2b8gJaIdSwMCacoL09HzMxxICNwzB+tWWaYS1jK7XxFsqumCy30ef66KdS57u6b7Zg3NBBpSl8FwP/B5xVLqse3hv+XoCf2zsoFENLRv+c/D6l3vnyz4J+sdAX4mwLab+bsn9uKhQ+5ddrZAhmXG0MCgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390889; c=relaxed/simple;
	bh=Re80YO+XGpkwKCTnuHzFbdUy9d2n/brVmMl0G4abPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RGSufamy+9WKwEkBEGRzMsw22ZogN7MxjeYZ1Hs5DTR037c1XJDDiGVtFsNDtzGNTCbfucJthO0GXZggMe/Z69Y1nC/gke5if0V09K1LyMys9kF/E0fyb/9W4NZSslHTMu+jUwcQPNb5Dsds277pnBaPeyUpg1iJeWQVG64fxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=br1P+PVX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0inuw012378;
	Wed, 23 Apr 2025 06:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s7sn2Ki4lw0FDzWIxaoJbtxaZwRLg7GkANaCKPRUwqc=; b=br1P+PVXAjglsnVA
	PM7zy37doelaGr/eKpwFhLYS5EkcNEndCxeT23m3WHBNDlQJU7w3NpLVAfkqwXy2
	jHxHM+DNmI1SutIYvBq++cthWcnOSBxIKN6yEuMjpLWadhK5aE5qcqyPQqmFoiN5
	0eEMgxoagV9tXCB/jHCrRwGgbWX1aCoX2NCYkQkeTakHPPDgQpmQa3FkSMfjtlPC
	5LnB0iqLHH89/ZeEfbSN8DMA+2wMpkAnCWTQ0Asc9VVaDOTCtgLqPK2GjSqMCr6P
	zVVZpNO+jqPnkiznXeWCKejqe9PKdMly0OUInEXelfn2aCYwpZo6DpSgrDG1y6Kj
	Tjhndw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1h55x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:48:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N6m0tJ027678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:48:00 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 23:47:58 -0700
Message-ID: <38fdb314-da3c-400f-98a4-88937717619f@quicinc.com>
Date: Wed, 23 Apr 2025 14:47:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson
	<jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Anilkumar Kolli
	<quic_akolli@quicinc.com>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250418120951.94021-1-usama.anjum@collabora.com>
 <5ae72a5c-798a-4c57-b344-02b231cb881c@quicinc.com>
 <b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com>
 <6c4ae1f8-a2ea-4ee3-b67d-4a379f097d9b@quicinc.com>
 <1fc423d1-762c-4e0f-8cf1-d4610c547596@collabora.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <1fc423d1-762c-4e0f-8cf1-d4610c547596@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: daacLj_0TEYHjVq6LOV-hHCPWRSLTViD
X-Proofpoint-ORIG-GUID: daacLj_0TEYHjVq6LOV-hHCPWRSLTViD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0NCBTYWx0ZWRfXyKgEv3hmqL9T bsV0EQeqqUvwkBkzB7Bw3zbhrVqcGrvTzXCkhcA0XMBdjlNYrJdR2+VWkS2zK/xs5Gvocb07ZrA a4Q5cTevWw5oHa7ki/tfXY/JyWX7TE7z9/WwQE3i1YT/+jwwryny/QyRQDChsGO49ZZhJjVudyU
 L3215cNoUqcJgIF/Nogmcmoqh4OogLMAGfx0caG2X6fUxRqKSgM0a3NXeQsL0iPiz6euODr3Dgc Mp895ojFqIy8vdA8dv/KdOXYdWXJKrK/YW+MiQCpzQxXDDNXRjeaaKnWvfLRCQaJ1rlRR9/Cv5U MiSIt2e9i5sCHLh735UEfh9hz7yLzb8+efdUWafbKTMjbThgIeHgPuZiR8a0DaRH8SVROYfua6Z
 3Km47MzSdd00Tv4gio4tQYSBE4RC//5lHvXOohiAvMMLPbEIkCmhE4FNhNPSSTAEUmQReiEy
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=68088d21 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=S5AssN6JXeREewhyV9UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230044



On 4/23/2025 2:26 PM, Muhammad Usama Anjum wrote:
> On 4/22/25 1:01 PM, Baochen Qiang wrote:
>>
>>
>> On 4/22/2025 3:46 PM, Muhammad Usama Anjum wrote:
>>> Hi,
>>>
>>> Thank you for excellent review.
>>>
>>> On 4/22/25 7:15 AM, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 4/18/2025 8:09 PM, Muhammad Usama Anjum wrote:
>>>>> Firmware requests 2 segments at first. 1st segment is of 6799360 whose
>>>>> allocation fails and we return success to firmware. Then firmware asks
>>>>
>>>> Host won't fail in case DMA remapping is enabled. Better to rephrase to make it clear that
>>>> the big segment allocation fails in case DMA remapping is not working, usually due to
>>>> IOMMU not present or any necessary kernel config not enabled.
>>> IOMMU is turned off. I'll make description better.
>>>
>>>>
>>>>> for 22 smaller segments. Those get allocated. At suspend/hibernation
>>>>> time, these segments aren't freed as they are reused by firmware.
>>>>>
>>>>> After resume the firmware asks for 2 segments again with first segment
>>>>> of 6799360 and with same vaddr of the first smaller segment which we had
>>>>
>>>> Not follow you here. What do you mean by 'same vaddr'? firmware does not care about vaddr
>>>> at all.
>>> So we get request to allocate memory of size = 6799360 and vaddr =
>>> 0xABC). We fail it. Then we get request to allocate memory of size =
>>> 500000 and vaddr is same 0xABC which gets allocated successfully.
>>>
>>> When we resume, firmware asks again for 6799360 with 0xABC vaddr even
>>> though we had allocated memory of 500000 size at 0xABC. I'm referring to
>>> this vaddr that its same.
>>
>> OK, get your point. But like I said, firmware doesn't case about vaddr, so it is not
>> asking for a 'same vaddr'.
>>
>> IMO just mentioning vaddr is not NULL is sufficient.
> Okay. I'll update the description to avoid confusion.
> 
>>
>>>
>>>>
>>>>> allocated. Hence vaddr isn't NULL and we compare the type and size if it
>>>>> can be reused. Unfornately, we detect that we cannot reuse it and this
>>>>
>>>> s/Unfornately/Unfortunately/
>>>>
>>>>> first smaller segment is freed. Then we continue to allocate 6799360 size
>>>>> memory from dma which fails and we call ath11k_qmi_free_target_mem_chunk()
>>>>> which frees the second smaller segment as well. Later success is returned
>>>>> to firmware which asks for 22 smaller segments again. But as we had freed
>>>>> 2 segments already, we'll allocate the first 2 new segments again and
>>>>> reuse the remaining 20.
>>>>>
>>>>> This patch is correctiong the skip logic when vaddr is set, but size/type
>>>>
>>>> s/correctiong/correcting/
>>>>
>>>>> don't match. In this case, we should use the same skip and success logic
>>>>> as used when dma_alloc_coherent fails without freeing the memory area.
>>>>>
>>>>> We had got reports that memory allocation in this function failed at
>>>>
>>>> any public link to the report?
>>> There's no public report. I've attached the logs. You'll find following
>>> error logs in it:
>>>
>>> ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B
>>> type 1)
>>> ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
>>>
>>>
>>>>
>>>>> resume which made us debug why the reuse logic is wrong. Those failures
>>>>> weren't because of the bigger chunk allocation failure as they are
>>>>> skipped. Rather these failures were because of smaller chunk allocation
>>>>> failures. This patch fixes freeing and allocation of 2 smaller chunks.
>>>>
>>>> any you saying kernels fail to alloc a smaller chunk? why? is system memory exhausted or
>>>> too fragmented?
>>> Yes, the smaller chunk doesn't get allocated. I've not been able to
>>> reproduce it on my setup. Both system memory exhaustion and
>>> fragmentation are the suspects.
>>
>> so it is kernel failing to allocate the buffer, not any issue in ath12k leading to this.
>> Please help make this clear to avoid confusion.
> We caught the bug as kernel was unable to allocate memory at resume.
> Later found out that with the optimization in ath11k, we shouldn't be
> trying to allocate memory in the first place. That's why I've sent this
> patch.
> 

yeah, understand that.

> Let me update the description and send v2.
> 

looking forward to it.

> 


