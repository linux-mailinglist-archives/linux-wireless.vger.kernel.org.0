Return-Path: <linux-wireless+bounces-24031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE45AD677B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4414A165B9C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7919B3CB;
	Thu, 12 Jun 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KF/nxShG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325078C91;
	Thu, 12 Jun 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707287; cv=none; b=lAFPEB6ZxoDuP0euynXz+wawQrLEmW8EeT9oBGR7WpohfHGeVusN/RcE3FyPqqJYiEQuVZmIc8BxfqoCaNIKKNNq071wLlMVCjVPkTUKcLWrSUJU8Npfjsx6DjvkUI/Y9oxSmyCZNIvNM6Zq5T7XSAjM6dAqkqGKaHYC1w4p9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707287; c=relaxed/simple;
	bh=H6OCubU6KLnFwuOavAawoIoW0yW9RMi/MGOfb9noeAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uy5moa68EKFyutm2DbBQXQgW9ZXosDwxzs72WF8qO2Xhu+djCP1sqCBZh3mjx+dJ8to8vSsQxipuPfSjO5gm+YOXcgCPQQA33eiPPeJaPEWZB/+TwhaXrNVIFXUnP47tALtIc+t/0boBLQHjwC+ChDOdKviXPPSACsDbL7Itaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KF/nxShG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJKBSr013464;
	Thu, 12 Jun 2025 05:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vy2lggNBoJOaZMU29P6tAcOwzzmR5WDrI4CFRZPSgU0=; b=KF/nxShGSv6QM7Z4
	hQaNFFm4e0ZD/4swvAtBYFixyIhOpiqBauhoHQ4zsndJ5OW+N1wmlhqdWdfDirv7
	Jw3yYeUlBMjCDxFnSb0uC145q6eyfsiJ6wa4DsB8hnUq4gsP4Xg2vu7VEQxN553l
	BeKEPK+i71fvxVe700qPFpTvWrWH01qn/eWONNBkTGVSCa8sB9RQAeoS10AhdZDi
	q9MqMA8Kua82Isw5BLvHjwGOk0H2zAs4UIJ6OAULnWvGVVpWHHIp2FyT6bptxP7j
	TCE5C7YacKEhul6dOBaTZpCcn1+wXlaAiUKT8Wcul5JU8MecnIpUToq8uSNaPBNC
	CYghjA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmnf0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 05:47:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C5lwFo008601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 05:47:58 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 22:47:56 -0700
Message-ID: <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>
Date: Thu, 12 Jun 2025 13:47:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IKhNYES_ax4epiXRteVvtZpYsDTKKRZt
X-Proofpoint-GUID: IKhNYES_ax4epiXRteVvtZpYsDTKKRZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0MSBTYWx0ZWRfXzj3nsDsf5m9h
 GTELXCbEJfA2WOBbDukCAcWMPJJ5xYH5JYLTpfFIDNxV1T0raQ5uypG9WPJ8wJILH3AWu6Qhabb
 W9LrhS9BpksL1ffdzlz+LhP5QAGTcGWCGMbSiCTcDT974deerFVBN+8IJ89gjfPFBKN8l18V48D
 Kp45+69K6sgPKLggckKM+ierfD0O2CI1prG8bywctzIaNzhBNeNDFIOxE5fpNw5eCJ7aw57eHiu
 K0i5FLF8OiXP76IPug9a9fa5F3s4ZcUfzz/wY6RkFMwZlaMEs9tgcHyCNLA5BsCuKNTE1LprrFa
 SAM3oiy+H6s87hOMXEEGP4A2EgwZk9H2jmZZ7/FHPB1NsalnCmKSU6UJqXUrZqjknb0RWT3zfv2
 TXh8X1xURFr+yn44RcJ471ng/9QRWQwh7pide03zk8ASh+RPf/ImZpQuHXgShrNwaKzEr9SJ
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=684a6a0f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=gw6Avj90hZdGHWO8bBkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120041



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

But ath11k_hal_dump_srng_stats() is called before ath11k_hal_srng_deinit(), right?

The sequence is ath11k_hal_dump_srng_stats() is called in reset process, then restart_work
is queued and in ath11k_core_restart() we call ath11k_core_reconfigure_on_crash(), there
ath11k_hal_srng_deinit() is called, right?

> 
> <1>[173154.396775] BUG: unable to handle page fault for address: ffffb4e4c046f010
> <1>[173154.396778] #PF: supervisor read access in kernel mode
> <1>[173154.396781] #PF: error_code(0x0000) - not-present page
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


