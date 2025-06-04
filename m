Return-Path: <linux-wireless+bounces-23672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D12EACD77A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 07:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D8D1775A5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35747BE4E;
	Wed,  4 Jun 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NYlVCjvc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E4139B;
	Wed,  4 Jun 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015145; cv=none; b=A5lMvq1u3NYqZcMmAWhue4lJOh1Qb4JHg7eFLRJocR63wsO2tporDP2bMYVRtYdHWgPxl+ILPhoOAx65PQMkf413roQp3m2YWL8bcRS7L+0l9K//tEuSUX9AJVJHuaqMOmmbwp+Kg4cRWxPenQ6MCuFBxX7uuXWRKZ33fwoT4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015145; c=relaxed/simple;
	bh=paq82hmzuKDr0OwBTH32Usw6XlIIv+C/W0tMHOqjm9g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=UTEwT92/brEc9iPSSKeA+yIQU99py1Ia6IWUmA77HmGAURa5RWb9MS7DtBrdR4lyg1ue04pvBbbHoSBPjNzzaDcxtOpi2ZdXKtAmrsWerealPuLf/PzlGcUeEqofIm2HDqseoY0TeM0mhyZZsuKsEAzuILnQHK0eNTVr8gfaF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NYlVCjvc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5540FGnn013323;
	Wed, 4 Jun 2025 05:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qCqkv7UIG3GLW1mbMtCLAQnW+VWrOS+08dSxfpBmZco=; b=NYlVCjvc/jOzbpMI
	/y/NN32WoxbZtb8FXj5YYMqlZFHq2eKImbd2s4P6Rg43qzuZfGrME+CQKWxhPQWG
	In0aCkKX+6HP0KpxFF/Jy8zJTEdXGdedonAPjW9dtVc/kw3JET4rnD3rnv+dWAB7
	/Gahdfno6Dr9lQRQJdPyfwkeBo/TVKhMJM2LV/1VUwYuGIWFejyak33BfNYWBZYd
	ZBdNBdY5sYXrVbLvVum+/N7Vf4flPPp1JcPjjqftsS7iEO6jpsQPo5lg2aoBSoGd
	1Z9dhFRIkNLZq4RyZXWAtRwEUKe2kUPxfD7NJ4c2VF+B5dXTceg7R+Um9TYQR+lH
	UMbhew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be80n67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 05:32:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5545WD7k007882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 05:32:13 GMT
Received: from [10.133.33.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Jun 2025
 22:32:11 -0700
Message-ID: <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>
Date: Wed, 4 Jun 2025 13:32:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: Johan Hovold <johan@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
Content-Language: en-US
In-Reply-To: <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=683fda5e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=l3RNslKZv-DLmWWPsjIA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5CzFIJzzY7eQU4d1_924Wcko4y-5WK1_
X-Proofpoint-ORIG-GUID: 5CzFIJzzY7eQU4d1_924Wcko4y-5WK1_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA0NCBTYWx0ZWRfX2FHJO/Td95ZZ
 eQfZ7Y/x9wjgG1bLUp3CA3BCSPsPnNN/uWSCK8HlpGKtnAXy3DYeFvhXwb8icnTUKsqjCyxjn/W
 5XUT/loFkXgD+KHLysFAgn70GMvuvJsjfq4LgIJ/OLLhJmKuMsrxtbwr+75MNTqwVGwsy+6geum
 3cWrXfLcwtJhFuqxLlVzUPsSVhklk07sigc4QQDvXgfoDz3XyV6o2qVB6UzLEPfpIeGHkCnGla4
 PunX6QkEDyKWblDtt5lxYDGRYhrE7wZanYdLPMxVocs4JI3UaFVtdvfcGVjFun1sese8x94+AzL
 xbDepyedus7DEAea5N85eD2tNcED5mNB3xPMZ7UrzkRcBA7duDG4UzipkV+mkirFANEYbBo3QTY
 1JUHF4QPYiLWbLCZNIz1bv5217Ecz2XHIpXLRL/UB/TjDtDthFfPjwjWH9d0xAlnUF7Zm4gE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=603 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040044



On 6/4/2025 10:34 AM, Miaoqing Pan wrote:
> 
> 
> On 6/3/2025 7:51 PM, Johan Hovold wrote:
>> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
>>> On 6/2/2025 4:03 PM, Johan Hovold wrote:
>>
>>>> No, the barrier is needed between reading the head pointer and 
>>>> accessing
>>>> descriptor fields, that's what matters.
>>>>
>>>> You can still end up with reading stale descriptor data even when
>>>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to 
>>>> speculation
>>>> (that's what happens on the X13s).
>>>
>>> The fact is that a dma_rmb() does not even prevent speculation, no 
>>> matter where it is
>>> placed, right?
>>
>> It prevents the speculated load from being used.
>>
>>> If so the whole point of dma_rmb() is to prevent from compiler 
>>> reordering
>>> or CPU reordering, but is it really possible?
>>>
>>> The sequence is
>>>
>>>     1# reading HP
>>>         srng->u.dst_ring.cached_hp = READ_ONCE(*srng- 
>>> >u.dst_ring.hp_addr);
>>>
>>>     2# validate HP
>>>         if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
>>>             return NULL;
>>>
>>>     3# get desc
>>>         desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
>>>
>>>     4# accessing desc
>>>         ath11k_hal_desc_reo_parse_err(... desc, ...)
>>>
>>> Clearly each step depends on the results of previous steps. In this 
>>> case the compiler/CPU
>>> is expected to be smart enough to not do any reordering, isn't it?
>>
>> Steps 3 and 4 can be done speculatively before the load in step 1 is
>> complete as long as the result is discarded if it turns out not to be
>> needed.
>>
> 
> If the condition in step 2 is true and step 3 speculatively loads 
> descriptor from TP before step 1, could this cause issues?

Sorry for typo, if the condition in step 2 is false and step 3 
speculatively loads descriptor from TP before step 1, could this cause 
issues?

> 
> We previously had extensive discussions on this topic in the https:// 
> lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888- 
> c34178e690fc@quicinc.com/ thread. On my platform, dma_rmb() did not work 
> as expected. The issue only disappeared after disabling PCIe endpoint 
> relaxed ordering in firmware side. So it seems that HP was updated 
> (Memory write) before descriptor (Memory write), which led to the problem.
> 
> 
> 
> 
> 


