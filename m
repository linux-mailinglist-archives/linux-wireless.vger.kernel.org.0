Return-Path: <linux-wireless+bounces-21832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C8A9606E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A5B3A2808
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7E245016;
	Tue, 22 Apr 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bRpaVvDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210E230273;
	Tue, 22 Apr 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308925; cv=none; b=foz74QEtdc5i9APtMADf9vPr9krdf/tSNwhyZYkLqRhvLsdID0AdYfzYIyrSnIM2kgpX6dK8iuOHb+V7zn5P/6XVpfYkidyKuXlur2xD2wRs9BsT9MoK3sl0VFUlzpObnSWJtdEXGjmpING2MKYifF/1US+ozMLAIL/FtiseGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308925; c=relaxed/simple;
	bh=62f+HM3BKRX8wxzWvdN59ZALCUZ2KQ0fsdvYeGqlztI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hl4yvoQjShKPK+q1xzJDdA1YHp9M95Grq2rUkZkydqso57QM5knaFAomJRYDy+ojXgYrsod968nZMp+dMdkQWCBVh4Uard/eqx0EgpG0L25sQJoYS2wqEiH56o8yCW4EmCHSpABIWSWGysO4D/FBqT9YqThKVtAYb6Bv1maYe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bRpaVvDL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OrMP011409;
	Tue, 22 Apr 2025 08:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q8kYuCu4DSKyBc/5Kb6zYROcKumgaRaR0Lku9VXPPCI=; b=bRpaVvDLaMb9R7yT
	OODGzlz9ZQSSwF2dOMNFPs2mtOBvCULG1Wbo72VLOBCg15aliBsUsEulMQIRcAmB
	wQ33e4vn95CCBgVdVz22ye5Th9BzESWBk+Q1rPMiMkbgLRMSOlTwp+C6tGGEypO/
	1Yib8CMEi/6L9N3PmUIP5K5GB8utlBDQ1j3/F2Gc77fko80ID81EiN29cpUdWlmr
	8Q2sEk1YsYoxHb0ROmEm7+D73jn+5JofWEpYDkucXrNqA7Z1oxBhaZkYFtG9YK+r
	WdF0QoNK56jbdlDSv2zl4+gqd+6KgNj8mjq9YvdQtOyLivWT6TvQWR51lbNqK5el
	dDJhxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46450peg4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:01:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M81uMI013820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:01:56 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 01:01:53 -0700
Message-ID: <6c4ae1f8-a2ea-4ee3-b67d-4a379f097d9b@quicinc.com>
Date: Tue, 22 Apr 2025 16:01:48 +0800
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68074cf5 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=Jd9q7DufAxoOQdnjySsA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: C9foz-2M2pY1pPCJPyoF1Ii7njwVIT5f
X-Proofpoint-ORIG-GUID: C9foz-2M2pY1pPCJPyoF1Ii7njwVIT5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220059



On 4/22/2025 3:46 PM, Muhammad Usama Anjum wrote:
> Hi,
> 
> Thank you for excellent review.
> 
> On 4/22/25 7:15 AM, Baochen Qiang wrote:
>>
>>
>> On 4/18/2025 8:09 PM, Muhammad Usama Anjum wrote:
>>> Firmware requests 2 segments at first. 1st segment is of 6799360 whose
>>> allocation fails and we return success to firmware. Then firmware asks
>>
>> Host won't fail in case DMA remapping is enabled. Better to rephrase to make it clear that
>> the big segment allocation fails in case DMA remapping is not working, usually due to
>> IOMMU not present or any necessary kernel config not enabled.
> IOMMU is turned off. I'll make description better.
> 
>>
>>> for 22 smaller segments. Those get allocated. At suspend/hibernation
>>> time, these segments aren't freed as they are reused by firmware.
>>>
>>> After resume the firmware asks for 2 segments again with first segment
>>> of 6799360 and with same vaddr of the first smaller segment which we had
>>
>> Not follow you here. What do you mean by 'same vaddr'? firmware does not care about vaddr
>> at all.
> So we get request to allocate memory of size = 6799360 and vaddr =
> 0xABC). We fail it. Then we get request to allocate memory of size =
> 500000 and vaddr is same 0xABC which gets allocated successfully.
> 
> When we resume, firmware asks again for 6799360 with 0xABC vaddr even
> though we had allocated memory of 500000 size at 0xABC. I'm referring to
> this vaddr that its same.

OK, get your point. But like I said, firmware doesn't case about vaddr, so it is not
asking for a 'same vaddr'.

IMO just mentioning vaddr is not NULL is sufficient.

> 
>>
>>> allocated. Hence vaddr isn't NULL and we compare the type and size if it
>>> can be reused. Unfornately, we detect that we cannot reuse it and this
>>
>> s/Unfornately/Unfortunately/
>>
>>> first smaller segment is freed. Then we continue to allocate 6799360 size
>>> memory from dma which fails and we call ath11k_qmi_free_target_mem_chunk()
>>> which frees the second smaller segment as well. Later success is returned
>>> to firmware which asks for 22 smaller segments again. But as we had freed
>>> 2 segments already, we'll allocate the first 2 new segments again and
>>> reuse the remaining 20.
>>>
>>> This patch is correctiong the skip logic when vaddr is set, but size/type
>>
>> s/correctiong/correcting/
>>
>>> don't match. In this case, we should use the same skip and success logic
>>> as used when dma_alloc_coherent fails without freeing the memory area.
>>>
>>> We had got reports that memory allocation in this function failed at
>>
>> any public link to the report?
> There's no public report. I've attached the logs. You'll find following
> error logs in it:
> 
> ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B
> type 1)
> ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
> 
> 
>>
>>> resume which made us debug why the reuse logic is wrong. Those failures
>>> weren't because of the bigger chunk allocation failure as they are
>>> skipped. Rather these failures were because of smaller chunk allocation
>>> failures. This patch fixes freeing and allocation of 2 smaller chunks.
>>
>> any you saying kernels fail to alloc a smaller chunk? why? is system memory exhausted or
>> too fragmented?
> Yes, the smaller chunk doesn't get allocated. I've not been able to
> reproduce it on my setup. Both system memory exhaustion and
> fragmentation are the suspects.

so it is kernel failing to allocate the buffer, not any issue in ath12k leading to this.
Please help make this clear to avoid confusion.

> 
>>
>>>
>>> Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> QCNFA765 is not an official chip name. please use WCN6855.
> Okay. I'll fix all of these mistakes.
> 
>>
>>>
>>> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
>>
>> I don't think a Fixes tag apply here. As IMO this is not really an issue, it is just not
>> doing well.
>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>>> index 47b9d4126d3a9..3c26f4dcf5d29 100644
>>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>>> @@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>>  		 */
>>>  		if (chunk->vaddr) {
>>>  			if (chunk->prev_type == chunk->type &&
>>> -			    chunk->prev_size == chunk->size)
>>> +			    chunk->prev_size == chunk->size) {
>>>  				continue;
>>> +			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>>> +					    chunk->size, chunk->type,
>>> +					    chunk->prev_size, chunk->prev_type);
>>> +				ab->qmi.target_mem_delayed = true;
>>> +				return 0;
>>> +			}
>>>  
>>>  			/* cannot reuse the existing chunk */
>>>  			dma_free_coherent(ab->dev, chunk->prev_size,
>>
>> actual code change LGTM.
>>
>>
> 
> 


