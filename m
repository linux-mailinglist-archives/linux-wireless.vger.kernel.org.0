Return-Path: <linux-wireless+bounces-7054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B041B8B7A73
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6603928745E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604B17335B;
	Tue, 30 Apr 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XoWuE+dJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328BF171E64
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488300; cv=none; b=cWBrJi4yp7KZ5k34ji3+RAI1EPVjdI7L7/xrf5NocnrfpGO7vy2s9FHAwehvIxuqF9V1LGisv+MOcoljP6hqTz8Vck1ewKihWlpg7U9pQhHsFIowU/cQ+QyZNzobCwuR6fxgIXF+1PPlIAQJ6C0Wrqyx7gqWsy9MR3dkmZWgs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488300; c=relaxed/simple;
	bh=hWNNrS4kF+TKdqc35c/lGb0GwG93duHdUc1K7gyTPSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axNa2vAn+P/rc7/6vf/dJJ3hdEilS+sPgkgzbeh9zgUkTI2pWtdzEyRTnJXDNAXpcZVEaYXQsf0r1e4I0llVHoU6gbjWKoicnrkP6RI3v1uXtXatDGpCLJU4ZrWlEhMRZKompGWoNOoh06JyHe3Pdl0kBnKg8sdtP2z95TXZH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XoWuE+dJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U8Ju8V021317;
	Tue, 30 Apr 2024 14:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lb5Kge/ki5tuI5nBnJoyQhKVnS6GzKIc3t+1KhVGqVg=; b=Xo
	WuE+dJQMmAYL4jQrDUTkx5Wt/CPvEMcr7VAvEQNhzGMRqly45GPNMCFmwi+4wsrv
	ug1gk5YX59PrlEwqQzO+NsiQLIZX1orzoGFs7ntM1rrMhresFaRr248hkr3PQjb8
	iWM6iKzE/iJAO6VLvIERCqgJ5eTGwLQD5IrDnGdCXCnWXzoEGwpmJCkQ4ZQXCXDg
	vNIqFFCJrCrso1H1JP9HmSc7wFFDl3lZ2lk8VAbEgYu16Z2m0EhLjVrnHyd8Ze/y
	WGlOxspXJbd+Xvo61I8KpH92DRihlSEM45ezxdr6RwYw5f26qVAYIPtdqwFusaCO
	3OTbSOW5WFLGrBQAfKrA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hgyjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:44:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEiMOC015827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:44:22 GMT
Received: from [10.50.39.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 07:44:19 -0700
Message-ID: <305a93c9-c5f0-a2a2-86c6-95a3f7f218d7@quicinc.com>
Date: Tue, 30 Apr 2024 20:14:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
 <35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
 <87cyq7ota5.fsf@kernel.org>
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
In-Reply-To: <87cyq7ota5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bpSVjZVAfOpe_jXAcQ_pNx4y46LmqZO0
X-Proofpoint-ORIG-GUID: bpSVjZVAfOpe_jXAcQ_pNx4y46LmqZO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300105

On 4/30/2024 7:18 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 4/29/2024 12:36 AM, Tamizh Chelvam Raja wrote:
>>
>>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>>
>>> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
>>> we don't process the status ring until STATUS_BUFFER_DONE set
>>> for that status ring entry.
>>>
>>> During LMAC reset it may happen that hardware will not write
>>> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
>>> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
>>> status ring.
>>>
>>> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
>>> is not done and if HP + 2 entry's DMA done is set,
>>> replenish HP + 1 entry and start processing in next interrupt.
>>> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
>>> done to be set.
>>>
>>> Also, during monitor attach HP points to the end of the ring and
>>> TP(Tail Pointer) points to the start of the ring.
>>> Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
>>> for the very first interrupt. Since, HW starts writing buffer from TP.
>>>
>>> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
>>> calling ath11k_hal_srng_src_peek().
>>>
>>> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> however note...
>>
>>> +
>>> +				/* If done status is missing:
>>> +				 * 1. As per MAC team's suggestion,
>>> +				 *    when HP + 1 entry is peeked and if DMA
>>> +				 *    is not done and if HP + 2 entry's DMA done
>>> +				 *    is set. skip HP + 1 entry and
>>> +				 *    start processing in next interrupt.
>>> +				 * 2. If HP + 2 entry's DMA done is not set,
>>> +				 *    poll onto HP + 1 entry DMA done to be set.
>>> +				 *    Check status for same buffer for next time
>>> +				 *    dp_rx_mon_status_srng_process
>>> +				 */
>>> +
>>> + reap_status = ath11k_dp_rx_mon_handle_status_buf_done(ab, srng,
>>> + rx_ring);
>>
>> ath11k-check reports:
>>
>> drivers/net/wireless/ath/ath11k/dp_rx.c:3116: line length of 95 exceeds 90 columns
>> drivers/net/wireless/ath/ath11k/dp_rx.c:3117: line length of 95 exceeds 90 columns
> 
> Tamizh, please ALWAYS run ath11k-check. We are wasting time for trivial
> stuff like this.
Sure Kalle.
> 
>> Kalle, in this case we may want to make an exception since I don't think there
>> is a clean way to fix this other than refactoring.
> 
> The new function name looked quite long so I shortened it to
> ath11k_dp_rx_mon_buf_done() and the warning is now gone. Does that look
> reasonable name?
> 
> Also I removed one unrelated change and removed unnecessary else. Please
> check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e88d559268779107715008c51e006f7a5f62045
Change looks good!
> 
> But now I noticed that the warning message needs some work:
> 
> ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
> 	    FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
> 	    buf_id);
> 

> Please use understandable warning and error messages in plain english.
> Any suggestions? I can edit the commit in the pending branch.
>
"hal rx status buffer done is not set in tlv %lx buf_id %d" -> is this fine?
 
>> FWIW I'd like to see this function refactored to avoid the excessive
>> indentation, but that should be a separate exercise.
> 
> Indeed, the indentation in this function is getting close to the limit.
> 


Tamizh

