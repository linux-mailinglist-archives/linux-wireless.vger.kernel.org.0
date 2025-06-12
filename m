Return-Path: <linux-wireless+bounces-24041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E240AD69D5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CE41721E2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A95215AF6;
	Thu, 12 Jun 2025 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OjmAtI2k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FBBA34;
	Thu, 12 Jun 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715327; cv=none; b=nosr9yHkjWJyL/FUV7vWpFZh947P06OnYuVB9rihwDqdZtIcFCjHpjOSwlvk/qJ74i52FMnvk6PT8t9xoF6GbYrqsmI3l6QiDlfJKSQUN6QGJmJeG/GN/6W46XFK3W3MjxkRbuMA0TT0QbAuoWhsoxC1JkrQ72ilLoVHq0qkV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715327; c=relaxed/simple;
	bh=7HgOqxchUCK4vKsy/UlLh+aYLzop6aXcxPO+nk0jUzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BSEldVm5ar7BHddVJSfDl27oTWfSh8u6PobrhBZBmK4Sv69G+zA2EeY3CnqcLIGVKDmlddQkIWLgYetkqDm49k+1VdLHxFtqEV9kTh+RhVkJA7velEnZzAMICmyqDCZtK0vvCUn9H+q8yK2Mp/TfdCACspyoY+NhXRuQS/lhANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OjmAtI2k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7lGAr027235;
	Thu, 12 Jun 2025 08:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oaomhS8dMfrepLdECiBKjEBqxHnNVF77uNFcGepwSTk=; b=OjmAtI2kg69l6oBp
	3F+aK87BasOzZV7pvTbNzU39NSpu0Go3Qz7sz3UNnCxHl413tBKyCt0qEYDAcIRi
	gPAtwBFI167IrJmJBfVwM4vDJrNqGr9CzaP+c1/FuHqFHuaIzj++yMnFwFHswZyX
	Th3cJ8HFkoXE2Sz6NMJWp548CVyn1OH02U7lTiKzbq6JAx5KViha8Ciiws2vfKn3
	dfQJBH70WtUq6NsDFQh/l0z7QBeiKl5O2C2RQBa4jt57gEIi/Os3XZtnKvgiyCHz
	IkXZJVR7+F1YtoKW6ZdQuJgzth994Dh8iYOtLETIGY/0iFZVjMMyQKF7tJGoJmPM
	SD6cGA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrheprd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:01:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C81sC6020488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:01:54 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 01:01:52 -0700
Message-ID: <d02bca79-66f1-48b0-8c3b-aeaaa17135a9@quicinc.com>
Date: Thu, 12 Jun 2025 16:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Sergey Senozhatsky <senozhatsky@chromium.org>, <akpm@linux-foundation.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=684a8973 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=gw6Avj90hZdGHWO8bBkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SurSnutfkbfhL8eagUqC8sWXXVKQyfUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2MSBTYWx0ZWRfXyGVF4C944/yV
 CWktncgLfW/3bkZlpSr2rXRBA6go89MAZu0sDepB9EQV0y2Ocx7cyYA5hPfT8qJHjUL2hm7gNG9
 NiwL15W6Ytw+Z1g+8qfpSW+eiCDFYy65RnLUdAXpN47F/4vVsfS2nhBPLpGHWSMtscZ0fOsBaWm
 badj40hNHNAmA5I1tbXWyEi03JjV/r1LcG8RHxW8372g9BmpMpN1JJhLpWrsOIRZjodKzAa+127
 fPdJCVvmQM18ARc3vHuniCthB94e9KAF7JYF+HrQrEOq30CuU3tIqhujY1wfm+mxZxe7xhhW++y
 bt0nGmynG+8sY4qol8MT/ideq5O3G/dn98JWo8Ki/N6mS4aRRg0883ZqajTAabM+cc/mlhyt0m7
 XP79fyYmBQkXLjx3KMrdkMsHR67pVoAyRKoHwnSs0BQ0+NHuy7t+3ngsIgn1rO+qWEONQKXh
X-Proofpoint-GUID: SurSnutfkbfhL8eagUqC8sWXXVKQyfUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120061

[+ kernel mm list]

On 6/12/2025 1:04 PM, Sergey Senozhatsky wrote:
> On (25/06/12 11:30), Baochen Qiang wrote:
>> On 5/29/2025 11:56 AM, Sergey Senozhatsky wrote:
>>> ath11k_hal_srng_deinit() frees rdp and wrp which are used
>>> by srng lists.  Mark srng lists as not-initialized.  This
>>> makes sense, for instance, when device fails to resume
>>> and the driver calls ath11k_hal_srng_deinit() from
>>> ath11k_core_reconfigure_on_crash().
>>
>> Did you see any issue without your change?
> 
> We do see some issues, yes, on LTS kernels.
> 
> [..]
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
>>
>> With this flag reset, srng stats would not be dumped in ath11k_hal_dump_srng_stats().
> 
> I think un-initialized lists should not be dumped.
> 
> ath11k_hal_srng_deinit() releases wrp.vaddr and rdp.vaddr, which are
> accessed, as far as I understand it, in ath11k_hal_dump_srng_stats()
> as *srng->u.src_ring.tp_addr and *srng->u.dst_ring.hp_addr, presumably,
> causing things like:
> 
> <1>[173154.396775] BUG: unable to handle page fault for address: ffffb4e4c046f010
> <1>[173154.396778] #PF: supervisor read access in kernel mode
> <1>[173154.396781] #PF: error_code(0x0000) - not-present page

I am confused here: if the root cause is driver trying to read a freed memory, it should
not result in a PF issue. Because even if freed, the page is there and still mapped in
kernel page table.

Andrew, any insights?

> <4>[173154.396824] RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
> <4>[173154.396839] Code: 88 c0 44 89 f2 89 c1 e8 3a 14 06 00 41 be e8 25 00 00 eb 6e 42 0f b6 84 33 78 ff ff ff 89 45 d0 46 8b 7c 33 d8 4a 8b 44 33 e0 <44> 8b 20 46 8b 6c 33 e8 42 8b 04 33 48 89 45 c8 48 8b 3d 45 a3 a0
> <4>[173154.396842] RSP: 0018:ffffb4e4dceefc50 EFLAGS: 00010246
> <4>[173154.396846] RAX: ffffb4e4c046f010 RBX: ffff90d1c3040000 RCX: a0009634a5d28c00
> <4>[173154.396849] RDX: ffffffffb0279d80 RSI: ffffffffb0279d80 RDI: ffff90d2e5d17488
> <4>[173154.396851] RBP: ffffb4e4dceefc90 R08: ffffffffb0249d80 R09: 0000000000003b82
> <4>[173154.396854] R10: 0000000000000004 R11: 00000000ffffffea R12: ffff90d1c3041c90
> <4>[173154.396856] R13: ffff90d1c3040000 R14: 0000000000002828 R15: 0000000000000000
> <4>[173154.396859] FS: 0000000000000000(0000) GS:ffff90d2e5d00000(0000) knlGS:0000000000000000
> <4>[173154.396862] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[173154.396865] CR2: ffffb4e4c046f010 CR3: 000000005ca24000 CR4: 0000000000750ee0
> <4>[173154.396868] PKRU: 55555554
> <4>[173154.396870] Call Trace:
> <4>[173154.396874] <TASK>
> <4>[173154.396883] ? __die_body+0xae/0xb0
> <4>[173154.396890] ? page_fault_oops+0x381/0x3e0
> <4>[173154.396896] ? exc_page_fault+0x69/0xa0
> <4>[173154.396901] ? asm_exc_page_fault+0x22/0x30
> <4>[173154.396908] ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:3de7 4)]
> <4>[173154.396923] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:3de7 4)]
> <4>[173154.396942] worker_thread+0x390/0x960
> <4>[173154.396949] kthread+0x149/0x170


