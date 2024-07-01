Return-Path: <linux-wireless+bounces-9769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69F91E039
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631AB283F2A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E4158D9F;
	Mon,  1 Jul 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aSpJvQQe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7715A87C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839204; cv=none; b=cmTNqodmwen/MNWCCCHZwwgMkKWcEQW4X8tnisFsT/c5rjx0i8Bxb+PEnf9belSvgrDwxRFwp1WFv6HzN/OHQJgBPFBLT8vVFBVC+KR+SnCeaA7VFawJSgzHZWpvEZVH+2Xc5yHYqHYo/idmwQm4wuSsBp1/3Ehehz2DLlXrrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839204; c=relaxed/simple;
	bh=tSeT0xtrble+LcmECtbW/PErbJvDAUI0eqiXfqDGehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kz5h17hQoL6YSczi8kHna63ty3unIWLGEUve42pbff6tlOCHGGd1IQglyyr/+vwx18v7kFwPjetL0WUfUsCEdGLnYkDTdgcM6jTciaBQdvbS75lizriM3E8UAxWeqRutw2qkjLUyrBcVLFBjPKbKJlp4Y7W53Sb101Ik+EH9mE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aSpJvQQe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461AAFQd009698;
	Mon, 1 Jul 2024 13:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EW1omU7zTgLyUMYwfYqm39P4OHVuXALFmFuEnkH91l0=; b=aSpJvQQeQU0vpn18
	0uDUB4pfb0ff6u4YTlJxk11agW+3u/EUftwbo9uktPD8zw36qYjCApPDWJlCCLXt
	bmt6H35fLOWbV72A6I7e+SwhUVOCez8EJ28O1Xa0tMfdJ8KxILQQJYKXFpbVjRiS
	vzri2y7oDFOO4GFOpCyzT/NHuy/I+4/phaNzwoZS7mr2eK3KBOi1EdcJzsu/+qin
	wUqBDTbl+Z6SKso9kL6/25UIA+1KZB8X24sZx3Fr7N7eOODHoQ7o69ZoWEwyhqEj
	kPRUakaTP5C3DvRVM7YlVD7qWv4+MpSUJ1EWMPT6O0YRGiz2TM8M8TW9PCV1OC04
	r7NITQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rmecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:06:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461D6YAm015473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 13:06:35 GMT
Received: from [10.152.203.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 06:06:33 -0700
Message-ID: <8ebc29cb-2e26-bd3c-6659-050fc25cedd2@quicinc.com>
Date: Mon, 1 Jul 2024 18:36:30 +0530
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
To: Sidhanta Sahu <quic_sidhanta@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
 <1624b548-334e-4391-a8e9-ff2aa5d81f80@quicinc.com>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <1624b548-334e-4391-a8e9-ff2aa5d81f80@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ih0nvduLkpdO3wzYmfGgL-4kg3HqCdWA
X-Proofpoint-GUID: ih0nvduLkpdO3wzYmfGgL-4kg3HqCdWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010101

On 6/27/2024 9:16 PM, Sidhanta Sahu wrote:
> 
> 
> On 3/25/2024 11:34 AM, Sowmiya Sree Elavalagan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> ---
>> v2:
>>    - Fixed errors shown by ath12k-check
>> v3:
>>    - Fixed SPDX comment style for coredump.c file
>>      Changed Kconfig description.
>> ---
>>   drivers/net/wireless/ath/ath12k/Kconfig    |  10 ++
>>   drivers/net/wireless/ath/ath12k/Makefile   |   1 +
>>   drivers/net/wireless/ath/ath12k/core.c     |   2 +
>>   drivers/net/wireless/ath/ath12k/core.h     |   5 +
>>   drivers/net/wireless/ath/ath12k/coredump.c |  51 ++++++
>>   drivers/net/wireless/ath/ath12k/coredump.h |  80 +++++++++
>>   drivers/net/wireless/ath/ath12k/hif.h      |   9 +-
>>   drivers/net/wireless/ath/ath12k/hw.c       |   4 +-
>>   drivers/net/wireless/ath/ath12k/mhi.c      |   5 +
>>   drivers/net/wireless/ath/ath12k/mhi.h      |   4 +-
>>   drivers/net/wireless/ath/ath12k/pci.c      | 185 +++++++++++++++++++++
>>   11 files changed, 351 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath12k/coredump.c
>>   create mode 100644 drivers/net/wireless/ath/ath12k/coredump.h
>>
> 
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 391b6fb2bd42..f0cc4959faf5 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -1121,6 +1121,7 @@ static void ath12k_core_reset(struct work_struct *work)
>>       reinit_completion(&ab->recovery_start);
>>       atomic_set(&ab->recovery_count, 0);
>>   +    ath12k_coredump_collect(ab);
> 
> 1. Can we confirm if the operation guarantees that the coredump has been successfully uploaded upon its completion? It would be helpful to understand the expected behavior of the system in the event of a successful or unsuccessful upload.
> 
  You would see the print "Uploading coredump" on the console upon successful upload of the coredump. In case if the dump collection fails on the driver side itself you would not see the debug message.

> 2. Is it safe to proceed with memory cleanup operations immediately after this call? Understanding the dependencies and potential risks associated with memory cleanup post-upload would be beneficial for maintaining system stability and avoiding potential issues.
> 
  If you see the implementation completely, we take a copy of the memory to be dumped in the above call and queue the work of uploading to user space. All this happens before we proceed with clean up.  We cannot wait for clean up until coredump gets uploaded as it may delay the recovery process which is not accepted.

>>       ath12k_core_pre_reconfigure_recovery(ab);
>>         reinit_completion(&ab->reconfigure_complete);
>> @@ -1220,6 +1221,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>>       INIT_WORK(&ab->restart_work, ath12k_core_restart);
>>       INIT_WORK(&ab->reset_work, ath12k_core_reset);
>>       INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
>> +    INIT_WORK(&ab->dump_work, ath12k_coredump_upload);
>>         timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
>>       init_completion(&ab->htc_suspend);

Hi Sidhanta,

Please find my response inline.

Thanks,
Sowmiya Sree

