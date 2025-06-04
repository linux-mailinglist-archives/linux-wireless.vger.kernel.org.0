Return-Path: <linux-wireless+bounces-23676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C8ACD925
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D251892F2F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BC2609C4;
	Wed,  4 Jun 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fXLuZ/aO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE672512C8;
	Wed,  4 Jun 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023889; cv=none; b=A6DgSFoZKgSCiYVq5nhl9YbVnc4weZ24hIJLZpJl8N9AR0j+m9X5lu2XNBV9Hud4A9C6AFTBabMuvYrMbnEfBr6YlS/wZ+tSEUpZgFBR9oHyPqDKBWe9kOk08M6H9jlF4PsP+vba35a2jjLNL9ILYsxI4rW7Czn7JVwgvv5vzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023889; c=relaxed/simple;
	bh=UYbkKmFr5UeqFtFI+nJW2S2A5YoPkpfAfOm6qQvwN/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pOicfUmyXk+t7WW09/3QkSFuwRNgmYYQooOpSboXroQqeXyNhUORgSQ9lyeyObHxljo/pf8aOlfBPl6fJVj+3fhssY4kLeDXUzviLqEVFvv7FzyDoiBDuAMNPV/WjLYY1zQ8+OCuCoIxoD0PVJkMma6QYZkV1/muLycSQgpPuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fXLuZ/aO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5547gt5q013476;
	Wed, 4 Jun 2025 07:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	anivJ2eg09Hruutk0YLTt4SfGPp8ix1kxgXyCn4T76w=; b=fXLuZ/aOrTB57i9a
	+3VpTTRfVuBUGtRYzZpzJuIzfWsljZ1ZYCQmA4+A34l47BPPBaEvYgJNrO7+U4P8
	+yHFWHz0DbUVN3fBE6UDI6pDeW/eFsqosoq0kwmITqsCjbCjU64JFwGT00Di4FJL
	psSd7wakUutcz332LHskC74HFCvWXJHYFIeVUt20W6jh4tOBPszztuV+87Ad5Y3O
	P2m4g9wOWBEW67VfUG4CdHePXT88FhBngj8dolW/BLFQvVKg4pntUQH+BESb0LZb
	51eHW0lldXmI/M//0WyDlhA6UC1F0wZjwDlyk50UjmljifHrc+JxVi6ANmuuFQjo
	a4M5Ww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8nn93k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 07:58:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5547w2se011415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 07:58:02 GMT
Received: from [10.133.33.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 00:58:00 -0700
Message-ID: <79b4bac1-6e55-408c-a334-006eded4229f@quicinc.com>
Date: Wed, 4 Jun 2025 15:57:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>
CC: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>
 <aD_wgACEfm1_1GNz@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <aD_wgACEfm1_1GNz@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w_XPjTFSZNiX8ks9rHAHNceZHHXIJp0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2MiBTYWx0ZWRfX5vrSLcCIdqi5
 bhMR3JPe4iY/k3ige1RY1H7RQSJ/omLn1XbPiOAOiIroEPNKxxKgVOondJDinyKtswOXO9cgC8x
 KFZ4+ONI+tHtxnt0/meVDm8dl3MyYKGKVvngoDNHGUSQCWgYGqg008rsssN3t23bLhr2VZzbArv
 Lufq0ggEgsxbanj1xy2lmqkA3nQv8FBcQyYbEemghTrkndo8A0ABR7bRe02GJuGOcGa5w0Ub+Yx
 /bX9Phn2rPfLAgfYTWm2MKv8RuqJxNo1L/m9EOskR1x1OM/h/HZszMZGSik+rrGTD7T5F+gp0Fj
 62a3nG9wzeDELtxjRCJ02Evg6JrnP6++haOuU/XLJ3HefQPAdsYJci5f8dk0GS2dqUm3V9oogb6
 nvc724v9eGOIroMOOqcKrGvs8BBP+Q8OCKpRwhwN/tcsSU/2LQzjCCT0Zpp6a+X+uSilRslt
X-Proofpoint-ORIG-GUID: w_XPjTFSZNiX8ks9rHAHNceZHHXIJp0p
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=683ffc8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=vX_C0UsDqE-s7w2R9qsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=478 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040062



On 6/4/2025 3:06 PM, Johan Hovold wrote:
> On Wed, Jun 04, 2025 at 01:32:08PM +0800, Miaoqing Pan wrote:
>> On 6/4/2025 10:34 AM, Miaoqing Pan wrote:
>>> On 6/3/2025 7:51 PM, Johan Hovold wrote:
>>>> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
>>>>> On 6/2/2025 4:03 PM, Johan Hovold wrote:
>>>>
>>>>>> No, the barrier is needed between reading the head pointer and
>>>>>> accessing
>>>>>> descriptor fields, that's what matters.
>>>>>>
>>>>>> You can still end up with reading stale descriptor data even when
>>>>>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to
>>>>>> speculation
>>>>>> (that's what happens on the X13s).
>>>>>
>>>>> The fact is that a dma_rmb() does not even prevent speculation, no
>>>>> matter where it is
>>>>> placed, right?
>>>>
>>>> It prevents the speculated load from being used.
>>>>
>>>>> If so the whole point of dma_rmb() is to prevent from compiler
>>>>> reordering
>>>>> or CPU reordering, but is it really possible?
>>>>>
>>>>> The sequence is
>>>>>
>>>>>      1# reading HP
>>>>>          srng->u.dst_ring.cached_hp = READ_ONCE(*srng-
>>>>>> u.dst_ring.hp_addr);
>>>>>
>>>>>      2# validate HP
>>>>>          if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
>>>>>              return NULL;
>>>>>
>>>>>      3# get desc
>>>>>          desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
>>>>>
>>>>>      4# accessing desc
>>>>>          ath11k_hal_desc_reo_parse_err(... desc, ...)
>>>>>
>>>>> Clearly each step depends on the results of previous steps. In this
>>>>> case the compiler/CPU
>>>>> is expected to be smart enough to not do any reordering, isn't it?
>>>>
>>>> Steps 3 and 4 can be done speculatively before the load in step 1 is
>>>> complete as long as the result is discarded if it turns out not to be
>>>> needed.
> 
>>> If the condition in step 2 is true and step 3 speculatively loads
>>> descriptor from TP before step 1, could this cause issues?
>>
>> Sorry for typo, if the condition in step 2 is false and step 3
>> speculatively loads descriptor from TP before step 1, could this cause
>> issues?
> 
> Almost correct; the descriptor can be loaded (from TP) before the head
> pointer is loaded and thus before the condition in step 2 has been
> evaluated. And if the condition in step 2 later turns out to be false,
> step 4 may use stale data from before the head pointer was updated.
> 

Actually, there's a missing step between step 3 and step 4: TP+1.

TP+1:
	srng->u.dst_ring.tp += srng->entry_size

TP is managed by the CPU and points to the current first unprocessed 
descriptor, while HP and the descriptor are asynchronously updated by 
DMA. So are you saying that the descriptor obtained through speculative 
loading has not yet been updated, or is in the process of being updated?




