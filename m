Return-Path: <linux-wireless+bounces-9662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1F91AAF8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 17:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA04B2994A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F07198A2C;
	Thu, 27 Jun 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cuj5ldxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02251198846
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501498; cv=none; b=Y/obc9JrwjgNXwG76Q/PvE90NLccEzQs2K+lg9gZ/W+qE5eJlOsKqlwRyEFdeT6LbhDDvONMjcZ6rQFlUJ0fK5++0ScLfC0CVoddaeWYWgyQpNsf+nGunZY7HzmcFcg/mlxCSL5kxfPhzPmrGDtONBJtyKYw48kxi+p15/s1h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501498; c=relaxed/simple;
	bh=sVyqQ+GpB92SrlF33wGjP4bjFFvSxx6pZPyfG4HWbZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WkgqdSOt/RPn4Q7F0MTdSwmNDVZg76yYlZAxRRXOxJylZhmg2+kA3zoHLFeT5DBp6BMLj8UWtUV3GEMAn3SX8P1rl4B64dMicI/zOGXjrQ5ntLSScFs4Ga3PhhfhFwzu9mdz1ltIecn9DEJGTnZz1VOjSQ13htYLfWD3+Mt1XS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cuj5ldxL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RACvCU015308;
	Thu, 27 Jun 2024 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V6xVJhtsQ/fg8q2YL50POwxxRAnNt8F004Ncj/eEuTE=; b=Cuj5ldxLmS03HkxF
	O4BP8QOuitrwZQqPtyFmR50BiudRAGx/6BMi2ZRjaCVvhtzJAUMC2X7w5RK8qdJG
	4UrJYUH1r4HNlXIqBGZJV1sC4g7MKxZL0Fw2C2parztt/rGkx9zXqK0dengt5BHL
	NY5SZOhG8+cIeQkBTnej0euJS4jtYhG2qG6nnWHEoPG8uQ+yae2ff4TUOSQISOmy
	zrp4J9A7RqZrNwWH9cLxR+bqvNj94JwM8HO6vgDGA3SfiD/LGqFo22K+m9UfRasE
	lYNg5S0cZeDOY0y4ANMCvf3nWgt+Ud9TTWQhFf2ikKuu8HTwDzh0SH6rIGRDCYLC
	bC3kbw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcmbt62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:17:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RFHwhw030148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:17:58 GMT
Received: from [10.50.12.159] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 08:17:56 -0700
Message-ID: <1ebc38c9-ae1b-4487-d87b-8baa99638494@quicinc.com>
Date: Thu, 27 Jun 2024 20:47:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3]wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
 <171889253841.918573.15918536206746856053.kvalo@kernel.org>
 <87zfr7hha3.fsf@kernel.org>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <87zfr7hha3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G-QLAoK2eZ9v_NZilVbkIU6m3786IhcZ
X-Proofpoint-ORIG-GUID: G-QLAoK2eZ9v_NZilVbkIU6m3786IhcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270116

On 6/26/2024 8:39 PM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com> wrote:
>>
>>> In case of firmware assert snapshot of firmware memory is essential for
>>> debugging. Add firmware coredump collection support for PCI bus.
>>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>>> format and also pack various memory shared during QMI phase in separate
>>> TLVs.  Add necessary header and share the dumps to user space using dev
>>> coredump framework. Coredump collection is disabled by default and can
>>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>>> approximately.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> This didn't compile for me, I added this to pci.c:
>>
>> +#include <linux/vmalloc.h>
>>
>> Also in the pending branch I made some whitespace in struct ath12k_dump_file_data:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=44ae07628b68375f476895f4fc1e89a570790ac0
>>
>> Any tips how to test this until we have the debugfs interface to crash the firmware?
> 
> I was able to get patch 'wifi: ath12k: Add support to simulate firmware
> crash' (not yet public) and did a quick test with it. There seems to be
> a KASAN warning but I can't debug this further at this time.
> 
> [ 8091.304272] ath12k_pci 0000:06:00.0: simulating firmware assert crash
> [ 8091.722245] ==================================================================
> [ 8091.722329] BUG: KASAN: vmalloc-out-of-bounds in ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
> [ 8091.722433] Write of size 4 at addr ffffc9000644b28c by task kworker/u32:0/11
> [ 8091.722517] 
> [ 8091.722552] CPU: 0 PID: 11 Comm: kworker/u32:0 Not tainted 6.10.0-rc4-wt-ath+ #1663
> [ 8091.722604] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [ 8091.722670] Workqueue: ath12k_aux_wq ath12k_core_reset [ath12k]
> [ 8091.722742] Call Trace:
> [ 8091.722778]  <TASK>
> [ 8091.722832]  dump_stack_lvl+0x7d/0xe0
> [ 8091.722920]  print_address_description.constprop.0+0x33/0x3a0
> [ 8091.722999]  print_report+0xb5/0x260
> [ 8091.723069]  ? kasan_addr_to_slab+0xd/0x80
> [ 8091.723146]  kasan_report+0xd8/0x110
> [ 8091.723217]  ? ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
> [ 8091.723301]  ? ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
> [ 8091.723386]  __asan_report_store_n_noabort+0x12/0x20
> [ 8091.723461]  ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
> [ 8091.723563]  ? ath12k_pci_coredump_calculate_size+0x730/0x730 [ath12k]
> [ 8091.723632]  ? __this_cpu_preempt_check+0x13/0x20
> [ 8091.723677]  ath12k_coredump_collect+0x60/0x73 [ath12k]
> [ 8091.724276]  ath12k_core_reset+0x1b1/0x880 [ath12k]
> [ 8091.724921]  ? _raw_spin_unlock_irq+0x22/0x50
> [ 8091.725503]  ? __this_cpu_preempt_check+0x13/0x20
> [ 8091.726126]  process_one_work+0x8d7/0x19f0
> [ 8091.726718]  ? pwq_dec_nr_in_flight+0x580/0x580
> [ 8091.727346]  ? move_linked_works+0x128/0x2c0
> [ 8091.727998]  ? assign_work+0x15e/0x270
> [ 8091.728601]  worker_thread+0x715/0x1270
> [ 8091.729244]  ? rescuer_thread+0xdb0/0xdb0
> [ 8091.729905]  kthread+0x2fa/0x3f0
> [ 8091.730520]  ? kthread_insert_work_sanity_check+0xd0/0xd0
> [ 8091.731192]  ret_from_fork+0x31/0x70
> [ 8091.731856]  ? kthread_insert_work_sanity_check+0xd0/0xd0
> [ 8091.732525]  ret_from_fork_asm+0x11/0x20
> [ 8091.733212]  </TASK>
> [ 8091.733909] 
> [ 8091.734559] The buggy address belongs to the virtual mapping at#012[ 8091.734559]  [ffffc9000500b000, ffffc9000644d000) created by:#012[ 8091.734559]  ath12k_pci_coredump_download+0x147/0x1330 [ath12k]
> [ 8091.736558] 
> [ 8091.737272] The buggy address belongs to the physical page:
> [ 8091.738016] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15a485
> [ 8091.738730] flags: 0x200000000000000(node=0|zone=2)
> [ 8091.739481] raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
> [ 8091.740256] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [ 8091.741043] page dumped because: kasan: bad access detected
> [ 8091.741786] 
> [ 8091.742529] Memory state around the buggy address:
> [ 8091.743296]  ffffc9000644b180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 8091.744087]  ffffc9000644b200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 8091.744834] >ffffc9000644b280: 00 04 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [ 8091.745598]                       ^
> [ 8091.746359]  ffffc9000644b300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [ 8091.747152]  ffffc9000644b380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [ 8091.747932] ==================================================================
> [ 8091.748688] Disabling lock debugging due to kernel taint
> [ 8091.749699] ath12k_pci 0000:06:00.0: Uploading coredump
> 
Hi Kalle,

I will check and update you on this.

Thanks,
Sowmiya Sree

