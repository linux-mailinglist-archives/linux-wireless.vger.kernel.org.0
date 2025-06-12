Return-Path: <linux-wireless+bounces-24049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F182AD6D8C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBFE16517B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7D22E3E3;
	Thu, 12 Jun 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HQWIhtHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F251FBCB0;
	Thu, 12 Jun 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723840; cv=none; b=SuybAnMSCSe53cAzSv/6f+wPR1CIbU4lSOoQZYFytrYFDJLpH5ejeIQB4zaxJb3dfSCZIWprE4wqqqttthnd8rIqQkQc+noEM8bZCyAmavnaFu4g2X0G9vK3Kw6yd1iBljKUA3vYoc+8HLW3HfE8vc66KEyyJZGdkepbFYRI2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723840; c=relaxed/simple;
	bh=p0dTYPdrugmbNsHZAy9XJZqGQfleK/Hn86rsvcPdfv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EnjPamq8pPlDeCzvp3BgpyLEaJ6oVlvT3ltQ146XpPTzEV8hOAnUCNfsJkz2hSKwn+nirLmsjbTjRIjSzV2V5Gt+aMamr8qdeq0PpBvx9Qusk7Bs7phv326QPujk9Le95N8Y0L67CTgCEYXi1IUMQ92Fj0dOy3chhZWhRnGix6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HQWIhtHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7qeKh027189;
	Thu, 12 Jun 2025 10:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dtDKf/1KTGy32BkhQJYDFCqnaGlZQ83I2ImgYeBlH1E=; b=HQWIhtHmzZPcB1L1
	/grthliKzgZQBQ2dfoL2TKm8FJcnzGtw4wVieJGM6qfcDxantSOGOPVqkELHei1n
	oL+RlbWQkVs+A3AQibt7qBZlTkNdt2wxortYmc6uJKbzfGzhYySIxegrBshMwYEr
	S+sU4sZ9WDBTN3Y1ds0y6GnbuCwKpmKWF2bQfyi8v3e4aH2CF44g8DfIdmes29uA
	fdkS+voTqmZ/AMTjAXQGDvKCquYgzxAe2CxzlybotCsfeh6JAzbzTB0b+3nd4URR
	DixuvC5muVKe8GyzTtZI0VYuwnMNPI0Gor/fxpGTcWPLahlZTLp2/ZJ8Y3ulRbwJ
	ffb0Xg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvg23h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:23:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CANYLR006468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:23:34 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 03:23:32 -0700
Message-ID: <4fc60f88-827f-4dd2-a995-d605082b1ab3@quicinc.com>
Date: Thu, 12 Jun 2025 18:23:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Pedro Falcato <pfalcato@suse.de>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>, <akpm@linux-foundation.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <d02bca79-66f1-48b0-8c3b-aeaaa17135a9@quicinc.com>
 <zlzpmburt4o75yizy6uknx4ews4eox6wbr5jleuixp6o6v2tuk@sz6k4x4gcolo>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <zlzpmburt4o75yizy6uknx4ews4eox6wbr5jleuixp6o6v2tuk@sz6k4x4gcolo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zyqawkJieCQlv1_S0xrPsRAXLLfOTeIq
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=684aaab2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=wXqGBGp1KCZRk8HKG9kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zyqawkJieCQlv1_S0xrPsRAXLLfOTeIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MCBTYWx0ZWRfXz/VgEtL9ttX0
 2Xq+Y4z4Kc7QOPPWyj9n509KFtPZFnCCuDJH6Wkkv2LGrFh9baU+paZgTxHHkCR95uDW5RwpKJV
 nCYtLx1me5CZ40j2Wi0CbeWZb+OUu4sSz2wED1qYmhgpmTwTET59Q7K+uJJ9SpldHf0w+X15hjX
 GaMDrvd2Y6XbdGYiVCegiZvfV9ejKqmS6tkpFb2vwf5/Wxw+sQ9K0c92TDVx/0rAYQCRWByHBAb
 MavDj/i/1bOpyIw1hUwcooKcSwX09rMax9bxAbnUaWGIWZ2BIN7XgyBNJH6qiRt5jK4qnVAEIOk
 wuzH4hGw/WbQaH8kE2IcOY6BvGckHapI9sTIumuv8hgugAgSbO+H6K0zm53pddcKaylDufsxdyZ
 zlxS57x5RJwSi/a+E74oMbL2hIFqnNmgAg0kSD2MvddRfRjdNRRlpYINwMPBwNmbOrdnp8vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120080



On 6/12/2025 6:01 PM, Pedro Falcato wrote:
> On Thu, Jun 12, 2025 at 04:01:49PM +0800, Baochen Qiang wrote:
>> [+ kernel mm list]
>>
>> On 6/12/2025 1:04 PM, Sergey Senozhatsky wrote:
>>> On (25/06/12 11:30), Baochen Qiang wrote:
>>>> On 5/29/2025 11:56 AM, Sergey Senozhatsky wrote:
>>>>> ath11k_hal_srng_deinit() frees rdp and wrp which are used
>>>>> by srng lists.  Mark srng lists as not-initialized.  This
>>>>> makes sense, for instance, when device fails to resume
>>>>> and the driver calls ath11k_hal_srng_deinit() from
>>>>> ath11k_core_reconfigure_on_crash().
>>>>
>>>> Did you see any issue without your change?
>>>
>>> We do see some issues, yes, on LTS kernels.
>>>
>>> [..]
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>>>>> index 8cb1505a5a0c..cab11a35f911 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>>>>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>>>>> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
>>>>>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>>>>  {
>>>>>  	struct ath11k_hal *hal = &ab->hal;
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
>>>>> +		ab->hal.srng_list[i].initialized = 0;
>>>>
>>>> With this flag reset, srng stats would not be dumped in ath11k_hal_dump_srng_stats().
>>>
>>> I think un-initialized lists should not be dumped.
>>>
>>> ath11k_hal_srng_deinit() releases wrp.vaddr and rdp.vaddr, which are
>>> accessed, as far as I understand it, in ath11k_hal_dump_srng_stats()
>>> as *srng->u.src_ring.tp_addr and *srng->u.dst_ring.hp_addr, presumably,
>>> causing things like:
>>>
>>> <1>[173154.396775] BUG: unable to handle page fault for address: ffffb4e4c046f010
>>> <1>[173154.396778] #PF: supervisor read access in kernel mode
>>> <1>[173154.396781] #PF: error_code(0x0000) - not-present page
>>
>> I am confused here: if the root cause is driver trying to read a freed memory, it should
>> not result in a PF issue. Because even if freed, the page is there and still mapped in
>> kernel page table.
>>
> 
> Any memory that is virtually-mapped (read: vmalloc, vmap, vm_map_ram, and others)
> will be unmapped on its subsequent free. I'm not familiar with the DMA subsystem,
> but the address ffffb4e4c046f010 is vmalloc-like.

OK, I forget the vmalloc case. And indeed in case IOMMU present, the DMA subsystem is
preferring vmalloc'ed memory.

Thank you, Pedro!

> 
>>
>>> <4>[173154.396824] RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
>>> <4>[173154.396839] Code: 88 c0 44 89 f2 89 c1 e8 3a 14 06 00 41 be e8 25 00 00 eb 6e 42 0f b6 84 33 78 ff ff ff 89 45 d0 46 8b 7c 33 d8 4a 8b 44 33 e0 <44> 8b 20 46 8b 6c 33 e8 42 8b 04 33 48 89 45 c8 48 8b 3d 45 a3 a0
>>> <4>[173154.396842] RSP: 0018:ffffb4e4dceefc50 EFLAGS: 00010246
>>> <4>[173154.396846] RAX: ffffb4e4c046f010 RBX: ffff90d1c3040000 RCX: a0009634a5d28c00
>>> <4>[173154.396849] RDX: ffffffffb0279d80 RSI: ffffffffb0279d80 RDI: ffff90d2e5d17488
>>> <4>[173154.396851] RBP: ffffb4e4dceefc90 R08: ffffffffb0249d80 R09: 0000000000003b82
>>> <4>[173154.396854] R10: 0000000000000004 R11: 00000000ffffffea R12: ffff90d1c3041c90
>>> <4>[173154.396856] R13: ffff90d1c3040000 R14: 0000000000002828 R15: 0000000000000000
>>> <4>[173154.396859] FS: 0000000000000000(0000) GS:ffff90d2e5d00000(0000) knlGS:0000000000000000
>>> <4>[173154.396862] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> <4>[173154.396865] CR2: ffffb4e4c046f010 CR3: 000000005ca24000 CR4: 0000000000750ee0
>>> <4>[173154.396868] PKRU: 55555554
>>> <4>[173154.396870] Call Trace:
>>> <4>[173154.396874] <TASK>
>>> <4>[173154.396883] ? __die_body+0xae/0xb0
>>> <4>[173154.396890] ? page_fault_oops+0x381/0x3e0
>>> <4>[173154.396896] ? exc_page_fault+0x69/0xa0
>>> <4>[173154.396901] ? asm_exc_page_fault+0x22/0x30
>>> <4>[173154.396908] ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:3de7 4)]
>>> <4>[173154.396923] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:3de7 4)]
>>> <4>[173154.396942] worker_thread+0x390/0x960
>>> <4>[173154.396949] kthread+0x149/0x170
>>
> 


