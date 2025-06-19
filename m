Return-Path: <linux-wireless+bounces-24263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B106ADFD93
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEC13B16AD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 06:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24123C4EB;
	Thu, 19 Jun 2025 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XEBwZkqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A46374D1;
	Thu, 19 Jun 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750314031; cv=none; b=OSgCa/su8FmtVFpiVYz0BwJ3PrlM29c2QWDN8nzWuM1r359Jt8zsIL1d4xR2EDhRNL3Y8KSTV26p6tpzJdPZBYDebFFhQI9+b944vTDdDqPL3uuT8awXzMoNThyPyxCPapqwRa4tfGyDH9qsfn6k7aTp3rAq+HGH4XdAaSu1beM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750314031; c=relaxed/simple;
	bh=u8MK5YJ7/D4I8h7buOfj5YdC/OljKWR88ghrDeODOvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cwdGZCYZx+UCgmU+fUCUCE5w3wmFhk9oW5gzJGqVijamtrFX67PA6aS+6pFRsT57XPFURD9phzLGGsDaFvWjCJwpxve0ZkdjH86qNOWtDGGpqS1tsrFOYpWIv+sPvMpUTlkjiZ18pWmMVYqjlgOpG8nKBLq9P890Wt2Y+HtXr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XEBwZkqJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J2FB2f007549;
	Thu, 19 Jun 2025 06:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7S3dL2sRXp9WOLre7cKo5ScuM4av7S05O8Nmx+GhIM=; b=XEBwZkqJqpQFAWoJ
	6AF99ysOoUqfPIFVE6eWUKlKo6THjmUMAFnNjoKoIYb5uP/+9abfT9owEAYomEYY
	EgOcvCJkm2NafFjsUBB9KhWU8bia1a510g7kJPkPvRoHaDP4dUz4jAGPSFIamQYN
	sKk/zKTAGZxPDKcM2xcbf+vcRRcZUd8NPp8+tyY3bQVk4/lnBYblBpb3at4uOk4L
	YYPrLjSA1thhrWS5K/MdhsclTZ1bqmgdd6Wcy8uZfHlORYGMQ8uKy4oU62YYpFQA
	ogotRfKO3fRd0/amxZN2LuSLWLeHUKsl04OBS5uJf69wU+WlV8ZdHwB3l6tPws0P
	3kD5fQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47c9krrjkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 06:20:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55J6KDFm016947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 06:20:13 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 23:20:11 -0700
Message-ID: <3c6ff0e0-0b5f-4bdc-8d11-6a2fe899fbc3@quicinc.com>
Date: Thu, 19 Jun 2025 14:20:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed srng
 lists
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sergey Senozhatsky
	<senozhatsky@chromium.org>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250612084551.702803-1-senozhatsky@chromium.org>
 <73c6cd0a-9c15-421e-afa4-27fe173bb428@quicinc.com>
 <311686ba-d0d4-4e9b-a0e4-02a1652bbdbf@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <311686ba-d0d4-4e9b-a0e4-02a1652bbdbf@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R3Z-PYViQP9uTXU4YJtNkpICnFHCw6Jl
X-Authority-Analysis: v=2.4 cv=UPTdHDfy c=1 sm=1 tr=0 ts=6853ac1e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=cm27Pg_UAAAA:8
 a=COk6AnOGAAAA:8 a=D3nA0KNcIkGSaxSwe7kA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA1MiBTYWx0ZWRfXx2M4sSj/SAj+
 ewuB7XiPFaCMbeY5BneGLvJgP20R606EZLhZxVpMObkqpuUr/Ar77aKvENixojN012qT7wfhUTR
 aTvRummsL7rSvCHjKJk8f9xMhitCF4no+7RMCFMiu4fF06Uw1T5CmnhFO0Y+Azw8LrNA5+0+8q6
 PL0tj1QLP9LauDbvrDVr/yyHCQiqR0IMbyZDyMhpkr/XM3PmPpVGpEHHkdQyu1rWWo/W8lm0cNw
 hXhQ0nWcqYtCzircJMME52ksWcZhWVYqr2Iz2rd7KIilYKavkUSb+9GCL0qBurJJ67z+ksq6dfW
 LRJu6Kf2rtQ/wwd/YCmTBWVK5jhFgOSDgd9fo/bY5JvoFqj1Q5tLobWpFiQTtd5J2mb2lc257Mn
 gsX3ywGMapPpTa/gC3Njjvf1t7A8TMOcJwLSzN3inxLo0NOu4jX9ptVkoGAfMpLJBGxfOeaF
X-Proofpoint-ORIG-GUID: R3Z-PYViQP9uTXU4YJtNkpICnFHCw6Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190052



On 6/19/2025 1:27 PM, Jeff Johnson wrote:
> On 6/12/2025 3:49 AM, Baochen Qiang wrote:
>>
>>
>> On 6/12/2025 4:45 PM, Sergey Senozhatsky wrote:
>>> In a number of cases we see kernel panics on resume due
>>> to ath11k kernel page fault, which happens under the
>>> following circumstances:
>>>
>>> 1) First ath11k_hal_dump_srng_stats() call
>>>
>>>  Last interrupt received for each group:
>>>  ath11k_pci 0000:01:00.0: group_id 0 22511ms before
>>>  ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
>>>  [..]
>>>  ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
>>>  ath11k_pci 0000:01:00.0: Service connect timeout
>>>  ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
>>>  ath11k_pci 0000:01:00.0: failed to start core: -110
>>>  ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>>>  ath11k_pci 0000:01:00.0: already resetting count 2
>>>  ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>>>  ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>>>  ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>>>  [..]
>>>
>>> 2) At this point reconfiguration fails (we have 2 resets) and
>>>   ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit()
>>>   which destroys srng lists.  However, it does not reset per-list
>>>   ->initialized flag.
>>>
>>> 3) Second ath11k_hal_dump_srng_stats() call sees stale ->initialized
>>>   flag and attempts to dump srng stats:
>>>
>>>  Last interrupt received for each group:
>>>  ath11k_pci 0000:01:00.0: group_id 0 66785ms before
>>>  ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
>>>  ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
>>>  ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
>>>  ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
>>>  ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
>>>  ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
>>>  ath11k_pci 0000:01:00.0: group_id 7 66814ms before
>>>  ath11k_pci 0000:01:00.0: group_id 8 68997ms before
>>>  ath11k_pci 0000:01:00.0: group_id 9 67588ms before
>>>  ath11k_pci 0000:01:00.0: group_id 10 69511ms before
>>>  BUG: unable to handle page fault for address: ffffa007404eb010
>>>  #PF: supervisor read access in kernel mode
>>>  #PF: error_code(0x0000) - not-present page
>>>  PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
>>>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>  RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
>>>  Call Trace:
>>>  <TASK>
>>>  ? __die_body+0xae/0xb0
>>>  ? page_fault_oops+0x381/0x3e0
>>>  ? exc_page_fault+0x69/0xa0
>>>  ? asm_exc_page_fault+0x22/0x30
>>>  ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
>>>  ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
>>>  worker_thread+0x389/0x930
>>>  kthread+0x149/0x170
>>>
>>> Clear per-list ->initialized flag in ath11k_hal_srng_deinit().
>>>
>>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>> ---
>>>
>>> v3:
>>> - updated commit message and subject line (Baochen Qiang)
>>>
>>>  drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>>> index 8cb1505a5a0c..cab11a35f911 100644
>>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>>> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
>>>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>>  {
>>>  	struct ath11k_hal *hal = &ab->hal;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
>>> +		ab->hal.srng_list[i].initialized = 0;
>>>  
>>>  	ath11k_hal_unregister_srng_key(ab);
>>>  	ath11k_hal_free_cont_rdp(ab);
>>
>> Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Baochen, should there be a Fixes: tag? If so, can you provide it?

Yeah:

Fixes: 5118935b1bc2 ("ath11k: dump SRNG stats during FW assert")

> 
> /jeff


