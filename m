Return-Path: <linux-wireless+bounces-22110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F41FA9E609
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 04:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25443B6DA1
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A77DA9C;
	Mon, 28 Apr 2025 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OlYRwfjx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFC2BD04;
	Mon, 28 Apr 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805807; cv=none; b=QDXPxcTybfA2pfO+R1ktmWgqhnwZG0QRo8fgISUUyoNvD8LjxQ7/LeLBCKG9DXnHPpe4RLgPrvtBK+y67ug7G0E5X8QYjXXf3+MBT1hrUP4SrUMjm8IZIg5JHLy6qWHZ7O4CmNn+9F9nxkfPVXnk9SX/7Wp5U/VLTV8HpzGYJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805807; c=relaxed/simple;
	bh=Re5T5HkJFL3+//qx6iiThSGteEkUA/xDo3pm7gWirxg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KHJ84SmXWbm0dQjPmkLbynOzVwosSPcKLXYlSHHuHsM47UgmDnUpD0TH232Ueh1b8uOp0fVjliq10CZDissACJBxDHlmDDP+2YbAPOHYcXiP3BOSnko5zpEp2gz22uqXE9MlRbzL+eCHxZFCc5CvfdEweM4chlD3iTARqVYhcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OlYRwfjx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RCiPpG026812;
	Mon, 28 Apr 2025 02:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ry/gvYyfmaVfNkedSDaTq+oPl2tD9g2MgdxbWL4JXFw=; b=OlYRwfjxrSXTL0TJ
	yORwWjJstKfOgTZqm5SEil9Qmw6w5QRR/8H/z5Wrm/vtMoM/LggM+w6zYcjEuJ0f
	QrrvzxfIVMdlRHDbpBqJwG4azf0tZkNj2vN1bKvzgV7DDNqKJs0b1ZEJoCGSUTXY
	7KwvLTxQh/Tr2WCGAnwLq4i15cFvdnd75gsguOxEOc+gaUHIa3hX8ZXx2l4WL6O8
	gHB8dZktSYY1lOV3pjMvOlWiqdhtmL7QD+S3+9pHgr/1t4W53vA4sEyg+wWHPTwi
	J46SuNre3UR7XoR/ztizVeVC1BCFhBiHXQzN0X175X5T0rIOdeSQRW7nNP0G9zvL
	sVuvDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rsb59m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 02:03:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S23K0A020564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 02:03:20 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 27 Apr
 2025 19:03:17 -0700
Message-ID: <4b3a18e3-14ac-4876-9b51-acee142464b3@quicinc.com>
Date: Mon, 28 Apr 2025 10:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: Fix MHI target memory reuse logic
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250425110424.2530460-1-usama.anjum@collabora.com>
 <dee649f1-0516-4a59-a70d-ba206388e568@quicinc.com>
Content-Language: en-US
In-Reply-To: <dee649f1-0516-4a59-a70d-ba206388e568@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAxNSBTYWx0ZWRfXyXy7ULkk/EtN Y3MmrYYlqKXSbjL9MTKtvQPpDyiHPfO7JAss3irAUSbnzTVt3yuM2B2UqKUqOR5mrNVa0CnIlW/ D94cCjlZxlUN+oqfae1W9HKn/ov5GpUh21tTr8xH6LWkVhpEId6FDwlB99rUkZhzZJTY9IjZoJt
 csvoKE4UGQwqe6zDDEsFI2MACmH4v7DOstmSl7mSGQZ2EWodePYe8fz3ZQq9tDCnNu/Yj7MdwIU KVq80hsimGBo7Rqb9tD83ifmcVmvACfjtdH5LMU0ryz5lh8utDeXmmNyVlZX2mlPCOmIh3g5tpV zZLtbGizSHEUB9wvUAXo9R/aM7rDS1FHolVWE7GbmyFxGZk8YoJ84c/xPrDggcOqzX2n+IwxKwb
 Iq7OjU38H9jnHJQ7gEM9r/4ohVIA+kp8WJeSje6nq9CuAZQ1RNM4A3SH4hMa3nyoCjBO/HxG
X-Proofpoint-GUID: Ig6s0WvLLKgxgO7K9ytZNOqP7T_G4Vcj
X-Proofpoint-ORIG-GUID: Ig6s0WvLLKgxgO7K9ytZNOqP7T_G4Vcj
X-Authority-Analysis: v=2.4 cv=I8ZlRMgg c=1 sm=1 tr=0 ts=680ee1e8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=OC3NTexeB3fIAc-p7tYA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280015



On 4/25/2025 7:08 PM, Baochen Qiang wrote:
> 
> 
> On 4/25/2025 7:04 PM, Muhammad Usama Anjum wrote:
>> Firmware requests 2 segments at first. The first segment is of 6799360
>> whose allocation fails due to dma remapping not available. The success
>> is returned to firmware. Then firmware asks for 22 smaller segments
>> instead of 2 big ones. Those get allocated successfully. At suspend/
>> hibernation time, these segments aren't freed as they will be reused
>> by firmware after resuming.
>>
>> After resuming, the firmware asks for the 2 segments again with the
>> first segment of 6799360 size. Since chunk->vaddr is not NULL, the
>> type and size are compared with the previous type and size to know if
>> it can be reused or not. Unfortunately, it is detected that it cannot
>> be reused and this first smaller segment is freed. Then we continue to
>> allocate 6799360 size memory which fails and ath11k_qmi_free_target_mem_chunk()
>> is called which frees the second smaller segment as well. Later success
>> is returned to firmware which asks for 22 smaller segments again. But
>> as we had freed 2 segments already, we'll allocate the first 2 new
>> smaller segments again and reuse the remaining 20. Hence 20 small
>> segments are being reused instead of 22.
>>
>> Add skip logic when vaddr is set, but size/type don't match. Use the
>> same skip and success logic as used when dma_alloc_coherent() fails.
>> By skipping, the possibility of resume failure due to kernel failing to
>> allocate memory for QMI can be avoided.
>>
>> 	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
>> 	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update description
>>
>> Changes since v2:
>> - Update description
>>
>> Changes since v3:
>> - Update description

The subject since previous is changed, but not mentioned here.

Please describe all your changes.

>> ---
>>  drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index 47b9d4126d3a9..2782f4723e413 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -1993,6 +1993,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>  			    chunk->prev_size == chunk->size)
>>  				continue;
>>  
>> +			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>> +					    chunk->size, chunk->type,
>> +					    chunk->prev_size, chunk->prev_type);
>> +				ab->qmi.target_mem_delayed = true;
>> +				return 0;
>> +			}
>> +
>>  			/* cannot reuse the existing chunk */
>>  			dma_free_coherent(ab->dev, chunk->prev_size,
>>  					  chunk->vaddr, chunk->paddr);
> 
> LGTM
> 
> Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

Withdraw above tag as I didn't notice that the patch subject is incorrect since v3.

The QMI memory has nothing to do with MHI. IMO the v1/v2 subject is good:

	wifi: ath11k: Fix memory reuse logic

while even better mention QMI:

	wifi: ath11k: Fix QMI memory reuse logic


> 


