Return-Path: <linux-wireless+bounces-16370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F09F0830
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 10:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E83281043
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F611B21A6;
	Fri, 13 Dec 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nEsnhNIx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A018FDDF
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082912; cv=none; b=c9m7SDVLAvmrfxMo6gEqcoJrDygn2N5Wl8EF11efuNVOlCHBHAfoOfDa1SrMcgPEOdmJql3G6eaeVHEhSy8c73Eh/06u6pDFxp6YAD+whMvkNN5H4/ZIfOUdEWVULJVXKeYXIAJhPhrjg7CUAGmSl/k4JjqfFDw3ZUewYCJbnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082912; c=relaxed/simple;
	bh=FeSSoE6JzS7E1MTnloTbK3jDOwkoUZ2IYWfKoXIDY5k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dm/hXg6NH3IwvrNxJDyICzbeCH0G735MFI/N0BJ/K/Jn45Vs6YJOaxd7J/bJCTJluxkC3N/Pf4pE6BVVi8fP14KgvWR2psXMTzWPu4TfPtAerYnuAUGJL4OvCGYvPW/15tYHwP2WMklKxb2V3NUJG8F+JuEI+5D5XZ2sVbCGysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nEsnhNIx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8L5AI029044;
	Fri, 13 Dec 2024 09:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24BYILVT/Zs6+TuyQSs4DW1InOShX0TlW2jQJBf0hos=; b=nEsnhNIxugIFsMPS
	/AV2WiyLUr46u1EX5b5q7HNtEUB3xTVg3W8vwff6QYIc0EjHhAORwpip0qn/lR9d
	E/3+2fnOpzRGQj9+rYMvI+4Iu/wGwqQRvJhgolTDe7QOKKjt9Npckd/+zmU2Oq6n
	gLzuEuluGCpAIhTUFYkDsMz8lHUjYi1KHgQdepLTFobxgFW6UAzJG8igq/ET6/Is
	ZroBuwuL8zC7H5hnvUTvX8N0VaVwsbRq67hLYbZhIspLAXGPsXondepjRD4Ttr10
	SutVU0ZfjVh8X4+lBv2ie/9f92yT+AG39DpvrmA9dryqF4JLWEX3EYi9jI/BdWsx
	D3ZeUQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xwsr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:41:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9fjc7015200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:41:45 GMT
Received: from [10.253.79.249] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 01:41:43 -0800
Message-ID: <e0d2d1ce-0443-4eea-b3c3-ed7423875d11@quicinc.com>
Date: Fri, 13 Dec 2024 17:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: ath11k: add srng->lock for ath11k_hal_srng_*
 in monitor mode
From: Kang Yang <quic_kangyang@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241008053744.1070-1-quic_kangyang@quicinc.com>
 <20241008053744.1070-3-quic_kangyang@quicinc.com> <87ttb9nea6.fsf@kernel.org>
 <79910df2-a7fd-4880-bd32-4f2927341654@quicinc.com>
Content-Language: en-US
In-Reply-To: <79910df2-a7fd-4880-bd32-4f2927341654@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PLBe9Ns9d-UlH8GSWt8Y76czhkZLzLG0
X-Proofpoint-GUID: PLBe9Ns9d-UlH8GSWt8Y76czhkZLzLG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=944 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130065



On 12/13/2024 2:17 PM, Kang Yang wrote:
> 
> 
> On 12/12/2024 10:53 PM, Kalle Valo wrote:
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>>
>>> ath11k_hal_srng_* should be used with srng->lock to protect srng data.
>>>
>>> For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
>>> they use ath11k_hal_srng_* for many times but never call srng->lock.
>>>
>>> So when running (full) monitor mode, warning will occur:
>>> RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
>>> Call Trace:
>>>   ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
>>>   ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
>>>   ? idr_alloc_u32+0x97/0xd0
>>>   ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
>>>   ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
>>>   ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
>>>   __napi_poll+0x30/0x1f0
>>>   net_rx_action+0x198/0x320
>>>   __do_softirq+0xdd/0x319
>>>
>>> So add srng->lock for them to avoid such warnings.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125- 
>>> QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>>
>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax 
>>> devices")
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>
>> [...]
>>
>>> @@ -5607,7 +5609,7 @@ static int ath11k_dp_full_mon_process_rx(struct 
>>> ath11k_base *ab, int mac_id,
>>>       struct hal_sw_mon_ring_entries *sw_mon_entries;
>>>       struct ath11k_pdev_mon_stats *rx_mon_stats;
>>>       struct sk_buff *head_msdu, *tail_msdu;
>>> -    void *mon_dst_srng = &ar->ab->hal.srng_list[dp- 
>>> >rxdma_mon_dst_ring.ring_id];
>>> +    struct hal_srng *mon_dst_srng;
>>>       void *ring_entry;
>>>       u32 rx_bufs_used = 0, mpdu_rx_bufs_used;
>>>       int quota = 0, ret;
>>> @@ -5623,6 +5625,9 @@ static int ath11k_dp_full_mon_process_rx(struct 
>>> ath11k_base *ab, int mac_id,
>>>           goto reap_status_ring;
>>>       }
>>> +    mon_dst_srng = &ar->ab->hal.srng_list[dp- 
>>> >rxdma_mon_dst_ring.ring_id];
>>> +    spin_lock_bh(&mon_dst_srng->lock);
>>
>> Why initialise mon_dst_srng differently? The commit message mentions
>> nothing about this change.
> 
> 
> Because need to fetch spin lock inside 'struct hal_srng'. If still use 
> 'void *mon_dst_srng', need to perform a variable type cast.
> 
> Bur 'struct hal_srng' will make this line too long:
> 'struct hal_srng *mon_dst_srng = &ar->ab->hal.srng_list[dp- 
>  >rxdma_mon_dst_ring.ring_id];'
> So I separated the definition and initialization.
> 
> ath11k_dp_rx_reap_mon_status_ring()/ath11k_dp_process_rx and others ring 
> process function is the same.
> 

Do i need to send a new version for this?

> 
> 
>>
> 
> 


