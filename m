Return-Path: <linux-wireless+bounces-10205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239B92F815
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30BB1F2347D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203713D51E;
	Fri, 12 Jul 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AAOMWvyu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2288374D3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777110; cv=none; b=EYjk9HbYgHszQbgXR1kvxTJZrxRb23aUEQSq2dRv3IE+KkDbdluHUDPTqj8+qAgRMn3NWfe6VB8suBiA68EqT+kOgrlJSxIoHS2Sr0++EBATUYwa9g58Gz6GLFSNL3YaEz+XjTPjTM3P8yp4uISZeyUMKSd9xIO0EoHd+iwqnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777110; c=relaxed/simple;
	bh=9/s7+Cx2ZAiGYpjEqi9HwYhRM9tqKGrkUoTCfQlGIY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AZ+pKbL3arQOUsQLKQ8ycWfvljQ50UFC7a6kh0LUQ6IJ4kQSLD8ebKxdc/RH1dTnhguKq3qdDsEpy3sNOmFn6m5wpZt9cWgXZtGf4p9QE394qeXJaNWoZlbauRddM6z3VQkcYtC+tTC02aoQnLyJtemwdhYDLMaRrTJKmKW85nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AAOMWvyu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BNfSvS030678;
	Fri, 12 Jul 2024 09:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8aiwAufKkDT7hqiwbMDpcpLwROKC5cwqcXjAcs0sB0Q=; b=AAOMWvyu5YP5VCc/
	eFd3E3/oSW/0GW9HU8kAP0dGblc40Z/kLC6G4ud6vGU+eGsKX4jGY0RQ7NcXrv2A
	FFPOcW+uzxWj71vxrAzwxYuaJcA8Xyg5XsZAVWGFypgMMeME/JcLO4jx4GBzJbSP
	oVrH6o2kcttP9QP+dCpv9s0TLNS/mq+Ett/Yc1FLV8W2ucm53LdcI9t+B36CJ+Lu
	5L5TFF/f2t54ZNBGpcc+1NEvOo1KMmKCSLNinhMNay50DTvo7BMTFEmQ9IxvpFTT
	QzoKEuFkd0Bf3wXVMKvymS8U+RgD8OfzaW+OCuFbxIG9QDv9Hd1cx9exob6znXRJ
	pw7szA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ar3gs48y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 09:38:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46C9cFWZ020198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 09:38:15 GMT
Received: from [10.231.216.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Jul
 2024 02:38:13 -0700
Message-ID: <870d1749-6f6c-4ca9-b852-7a511e70103e@quicinc.com>
Date: Fri, 12 Jul 2024 17:38:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add firmware coredump collection support
To: Kalle Valo <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240605034639.3942219-1-quic_miaoqing@quicinc.com>
 <874j8xb4m5.fsf@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <874j8xb4m5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b16mcp8MXhooyEcGUwUE7M4aXbckeJT6
X-Proofpoint-ORIG-GUID: b16mcp8MXhooyEcGUwUE7M4aXbckeJT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120068



On 7/11/2024 12:20 AM, Kalle Valo wrote:
> Miaoqing Pan <quic_miaoqing@quicinc.com> writes:
> 
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>>
>> The changeset is mostly copied from:
>> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
>>
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> This has a similar KASAN warning as did the ath12k patch:
> 
> [   48.364483] modprobe (1116) used greatest stack depth: 21760 bytes left
> [   48.450859] ath11k_pci 0000:06:00.0: chip_id 0x2 chip_family 0xb board_id 0x106 soc_id 0x400c0200
> [   48.451252] ath11k_pci 0000:06:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> [   63.694922] ath11k_pci 0000:06:00.0: simulating firmware assert crash
> [   64.118179] ath11k_pci 0000:06:00.0: firmware crashed: MHI_CB_EE_RDDM
> [   64.132388] ==================================================================
> [   64.132470] BUG: KASAN: vmalloc-out-of-bounds in ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
> [   64.132530] Write of size 4 at addr ffffc9000497520c by task kworker/u32:2/88
> [   64.132578]
> [   64.132610] CPU: 5 PID: 88 Comm: kworker/u32:2 Not tainted 6.10.0-rc6-wt-ath+ #1678
> [   64.132659] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [   64.132719] Workqueue: ath11k_aux_wq ath11k_core_reset [ath11k]
> [   64.132791] Call Trace:
> [   64.132827]  <TASK>
> [   64.132867]  dump_stack_lvl+0x7d/0xe0
> [   64.132910]  print_address_description.constprop.0+0x33/0x3a0
> [   64.132958]  print_report+0xb5/0x260
> [   64.133038]  ? kasan_addr_to_slab+0xd/0x80
> [   64.133096]  kasan_report+0xd8/0x110
> [   64.133132]  ? ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
> [   64.133179]  ? ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
> [   64.133225]  __asan_report_store_n_noabort+0x12/0x20
> [   64.133266]  ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
> [   64.133311]  ? ath11k_pci_coredump_calculate_size+0x710/0x710 [ath11k_pci]
> [   64.133358]  ? lock_sync+0x1a0/0x1a0
> [   64.133398]  ath11k_coredump_collect+0x60/0x73 [ath11k]
> [   64.133466]  ath11k_core_reset+0x225/0x640 [ath11k]
> [   64.133524]  ? debug_smp_processor_id+0x17/0x20
> [   64.133564]  process_one_work+0x8cc/0x19c0
> [   64.133893]  ? pwq_dec_nr_in_flight+0x580/0x580
> [   64.133934]  ? move_linked_works+0x128/0x2c0
> [   64.134007]  ? assign_work+0x15e/0x270
> [   64.134074]  worker_thread+0x715/0x1230
> [   64.134114]  ? __this_cpu_preempt_check+0x13/0x20
> [   64.134153]  ? lockdep_hardirqs_on+0x7d/0x100
> [   64.134192]  ? rescuer_thread+0xdb0/0xdb0
> [   64.134229]  kthread+0x2fa/0x3f0
> [   64.134266]  ? kthread_insert_work_sanity_check+0xd0/0xd0
> [   64.134308]  ret_from_fork+0x31/0x70
> [   64.134345]  ? kthread_insert_work_sanity_check+0xd0/0xd0
> [   64.134386]  ret_from_fork_asm+0x11/0x20
> [   64.134426]  </TASK>
> [   64.134459]
> [   64.134498] The buggy address belongs to the virtual mapping at#012[   64.134498]  [ffffc90003965000, ffffc90004977000) created by:#012[   64.134498]  ath11k_pci_coredump_download+0x144/0x12c0 [ath11k_pci]
> [   64.134576]
> [   64.134606] The buggy address belongs to the physical page:
> [   64.134648] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13faee
> [   64.134699] flags: 0x200000000000000(node=0|zone=2)
> [   64.134746] raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
> [   64.134796] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   64.135523] page dumped because: kasan: bad access detected
> [   64.136273]
> [   64.136928] Memory state around the buggy address:
> [   64.137641]  ffffc90004975100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   64.138361]  ffffc90004975180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   64.139074] >ffffc90004975200: 00 04 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [   64.139742]                       ^
> [   64.140495]  ffffc90004975280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [   64.141222]  ffffc90004975300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [   64.141892] ==================================================================
> [   64.142674] Disabling lock debugging due to kernel taint
> [   64.143630] ath11k_pci 0000:06:00.0: Uploading coredump

Thanks for catching this issue, it's triggered by the statement of 
'dump_tlv->type = cpu_to_le32(mem_idx);' The 'buf' which assigned to 
'dump_tlv' is out-of-bounds. Will be fixed in the next version.

> 
>> ---
>> v2: fix implicit declaration of function 'vzalloc'.
>>
>>   drivers/net/wireless/ath/ath11k/Kconfig    |  11 ++
>>   drivers/net/wireless/ath/ath11k/Makefile   |   1 +
>>   drivers/net/wireless/ath/ath11k/core.c     |   2 +
>>   drivers/net/wireless/ath/ath11k/core.h     |   5 +
>>   drivers/net/wireless/ath/ath11k/coredump.c |  52 ++++++
>>   drivers/net/wireless/ath/ath11k/coredump.h |  79 +++++++++
>>   drivers/net/wireless/ath/ath11k/hif.h      |   7 +
>>   drivers/net/wireless/ath/ath11k/mhi.c      |   5 +
>>   drivers/net/wireless/ath/ath11k/mhi.h      |   1 +
>>   drivers/net/wireless/ath/ath11k/pci.c      | 191 +++++++++++++++++++++
>>   drivers/net/wireless/ath/ath11k/qmi.c      |  45 ++---
>>   drivers/net/wireless/ath/ath11k/qmi.h      |   9 +-
>>   12 files changed, 384 insertions(+), 24 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
>>   create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h
> 
> I feel that the QMI changes should be in a separat patch and explaining
> in detail what they are about. Didn't review those now as there's no
> explanation.

Minor changes for updating 'iaddr' definition. IMO, don't need a 
separate patch.
struct target_mem_chunk {
         u32 prev_size;
         u32 prev_type;
         dma_addr_t paddr;
-       u32 *vaddr;
-       void __iomem *iaddr;
+       union {
+               u32 *vaddr;
+               void __iomem *iaddr;
+       } v;
  };


> 
>> diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
>> index 27f0523bf967..bb91da0098b4 100644
>> --- a/drivers/net/wireless/ath/ath11k/Kconfig
>> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
>> @@ -57,3 +57,14 @@ config ATH11K_SPECTRAL
>>   	  Enable ath11k spectral scan support
>>   
>>   	  Say Y to enable access to the FFT/spectral data via debugfs.
>> +
>> +config ATH11K_COREDUMP
>> +	bool "ath11k coredump"
>> +	depends on ATH11K
>> +	select WANT_DEV_COREDUMP
>> +	help
>> +	  Enable ath11k coredump collection
>> +
>> +	  If unsure, say Y to make it easier to debug problems. But if
>> +	  dump collection not required choose N.
> 
> I'm not sure if a new Kconfig option is justified? Maybe instead just
> use CONFIG_DEV_COREDUMP directly.

ok, will be removed.


