Return-Path: <linux-wireless+bounces-21954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC9A9A438
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F83169E9D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7152367C9;
	Thu, 24 Apr 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dfW6tsdP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C22367BD
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479323; cv=none; b=Hs6R3eG59djJbH8Cu2+MvrA9WJuC55D1djxpv4PpyYyPOYtRZmkyAEXuAKmNmILa4r8PSFJlVmxIegDe8lfZarQVs7eIaLe4Ec4DVir1luBRYS2QwFTyP4ccL+kcvrAvTpWYz0PMFXumXspCjSDjB1VSWZ2l85kfWwmUizA0UL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479323; c=relaxed/simple;
	bh=taBYE20aoL3hqyYXJpr0/KF6eixhqiyRpkP75PnmqLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VLR3A8bKqsD5Xc1O4MuSsBLRMsH3Cj+eSIMQ3ej0KJJUeYuNwBvOy8ooM/xf1iVvvlJeeFGAZt5go+1ewSlPaolIFe1mXvLlJ+a3sutwoYxptX1Laf2t3rbBMHn6cWUdFyBwWIzRt0Zcj+weoH40YoIDrDPxC8L0EQbSQvwWpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dfW6tsdP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FHIG000855;
	Thu, 24 Apr 2025 07:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OBlvphndicmOz5rOHCGOG3kl8emYmeybm4FDfDgmcYQ=; b=dfW6tsdPFZIstCYe
	qUJSCuOUCSZoUojygJS7LMwficLhpBUj42HEobKwOFwPqrLa7D82fZwqCDb+ayLb
	W/KMb4px5Ta3No2E4qdu7E/nM2pLL7A46TwRH7qbhDKh6G/1za+aX6MCFKyxPX8k
	TSCp8LTPa1YiXKNT32mmZTb/cVw32QlDVNNBTOrvYBd1WRk/7hhmtAnKyUmYOlFD
	/qdENAbjPz9ddCCKaUL4WNM3yEjKzaObeprwx/fXtr/Gz1k5cq6Myi7Ptso4UeVV
	yiGfc3L3r59tzCqiKEcTS3f8Wb5XO/ObjpG1XOGyxyzjA7k/O9iaVdnAYccaxLED
	EtB5Rg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3cjun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:21:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O7LcX4028629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:21:38 GMT
Received: from [10.216.33.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 00:21:36 -0700
Message-ID: <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
Date: Thu, 24 Apr 2025 12:51:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <balsam.chihi@moment.tech>,
        <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0NyBTYWx0ZWRfXxAKA5NrVIvp2 jH2uFArkwgXQD2EIMAVXtyftSfBEwlQGa5ZKEkhTnu01ZwggHaHPQwPzGQSI42hI5qvvmyhAto6 gjzEcQwA459ZRW7imx087R7rzPnom1qGkH41umtTXEOPOtJfbkrK/f3/HTE6ywcuLswijgbOLX3
 BwppRDZMfRtc6pQ/9VEFlQFTfd0FmENHDVXhflLsl93QZkmNgleGW1PmbyWFqSwV7USELfo2DAD 3fzxdLdOK9AUPSgahYOpJLW//1CgPvse4DvrF1EWYum1fRRUZSrMEuwx232+4MAKJZ/67oNO0GD iKhC0kBci3l2Llcbqe31cO7u/AZREKhmxiRq7CtnXvYR9rufw4cYprlPrRGuOeobIVGcJLuqI5C
 tT+PBLB4JeHjIkNOBpU0PWPhTDzq4LKanlvAgiuzR8tkJFp/xqTKSE6UJEd75i8fsEJdiKEu
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=6809e683 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=33T7mwWb2eJha9v3rUkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3cQFmdBGd5XJCyGGfahPsdOSCDUXBBW9
X-Proofpoint-GUID: 3cQFmdBGd5XJCyGGfahPsdOSCDUXBBW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_03,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240047



On 4/24/2025 11:21 AM, Baochen Qiang wrote:
> 
> 
> On 4/16/2025 6:09 PM, balsam.chihi@moment.tech wrote:
>> From: Balsam CHIHI <balsam.chihi@moment.tech>
>>
>> This patch addresses a crash issue that occurs when unloading the
>> ath11k_pci driver with QCN9074 PCIe WiFi 6 modules.
>> The crash is caused by the driver attempting to perform reset
>> operations during unload, leading to a synchronous external abort
> 
> Do we know the root cause of the synchronous external abort?
> 
>> and kernel panic, as indicated by the error log:
>>
>> [ 5615.902985] Internal error: synchronous external abort: 0000000096000210 [#1] SMP
>> ...
>> [ 5616.056382] CPU: 7 PID: 12605 Comm: procd Tainted: G O 6.6.73 #0
>> ...
>> [ 5616.069876] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ 5616.076841] pc : ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
>> [ 5616.083035] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
>> [ 5616.163712] Call trace:
>> [ 5616.166153] ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
>> [ 5616.171993] ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
>> [ 5616.177583] ath11k_pcic_read32+0x30/0xb4 [ath11k]
>> [ 5616.182391] ath11k_pci_get_msi_irq+0x528/0x1914 [ath11k_pci]
>> [ 5616.188143] ath11k_pci_get_msi_irq+0x147c/0x1914 [ath11k_pci]
>> [ 5616.193983] ath11k_pci_get_msi_irq+0x1764/0x1914 [ath11k_pci]
>> [ 5616.199822] pci_device_shutdown+0x34/0x44
>> [ 5616.203923] device_shutdown+0x160/0x268
>> [ 5616.207847] kernel_restart+0x40/0xc0
>> [ 5616.211512] __do_sys_reboot+0x104/0x23c
>> [ 5616.215436] __arm64_sys_reboot+0x24/0x30
>> [ 5616.219447] do_el0_svc+0x6c/0xfc
>> [ 5616.222761] el0_svc+0x28/0x9c
>> [ 5616.225817] el0t_64_sync_handler+0x120/0x12c
>> [ 5616.230174] el0t_64_sy
>> [ 5616.233839] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
>> [ 5616.239932] ---[ end trace 0000000000000000 ]---
>> [ 5616.244547] Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
>> [ 5616.253343] Kernel Offset: disabled
>> [ 5616.256827] CPU features: 0x0,00000000,00020000,1000400b
>> [ 5616.262138] Memory Limit: none
>> [ 5616.265188] Rebooting in 3 seconds..
>> [ 5620.268926] Unable to restart system
>> [ 5620.272503] Reboot failed -- System halted
>>
>> The fix involves adding a conditional check for the power state before
>> performing the reset operations in the ath11k_pci_sw_reset function.
>> This ensures that the reset functions are only called when loading the driver,
> 
> The ath11k_pci_soc_global_reset() is called to make sure the device is in the expected
> state, such that after machine restart, the device can be successfully enumerated. If
> skipped, the chip may be not detected. At least this is the case for WCN6855, for others I
> am not sure.

It is not safe to skip soc_global_reset for QCN9074 also as this may leave target
in an unknown state. Better to get the actual register access that is causing
the error, also we check check ath11k debug log with debug_mask=0x1020 enabling
boot and ath_pci debugs.

Vasanth


