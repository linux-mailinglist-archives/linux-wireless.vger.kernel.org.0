Return-Path: <linux-wireless+bounces-7450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B68C23AF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CEE288E29
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B3168AFC;
	Fri, 10 May 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mR3n1GV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848E165FB6
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340962; cv=none; b=uPAJWa9R6OKlta9J3SkPLWSSWUrj1s5JohLmVLmIkcese3ZG+aqSocSFHpVylDq4uvOUU71SXoAM0V3jvdSiSyWi76BoGUzupmoxuHHUU/LS10j/yEGoOyAEjR4LouFFdyQ5AKX3I80Z9yT1XkjdnXkExmM37kZ3p9PYfGiyQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340962; c=relaxed/simple;
	bh=3DyYPc5afHa/v8tyhWJ1XSkcDhHrEUjd0tUVvxK/40g=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yfe2uZSuRgMOWzHj3reOpd120malSu5JAjnV6YXhpZxsi0W/wZkSUvfQ7V27Kd00j3vrqBSKqtzWkfUd7J7LsW/vJtEC0H7cnbWoS1sTHm04mxULB0jC8bVWxdpnEdFNrn2CKCVcS2uYiQ0HhtQTGnHylL95YWcMzg7Y0doHN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mR3n1GV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tomQ001048;
	Fri, 10 May 2024 11:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:cc:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zQHMKBvbLL6c+PD00kIek7vz53QDxFtiRxYCPWCZnk4=; b=mR
	3n1GV6JS6+oKr+RVX+hVON/od27XyFYX5/gYcqKGPbgQGUP11iPXK/YwVb/ejyna
	rZPswbPVVV++tsd/jqGhLt5mmg66pn0eIarReJGivq+S3mVZvmvDDFlTG61vnFNd
	DKkaFwQVTUrkH+GlIVXmaCVGy4i/gBbk1f6EiZUKLXVOclQxTXi2sFQsg5lhcBQl
	JazAJmVci3TQYuNy/DW+po/opwhwM1j5zpYapUFJ173ftl58eVNaC+BoQZUT8TJS
	haLSothYTwWJrnzVmUrAMbpiREedp+AXDc1szqmGCSde7R0AyjDJbx5yej0DFmd/
	lWaDDsy+F5+eQCgcXOdQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16yt1ahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 11:35:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44ABZrAQ001029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 11:35:53 GMT
Received: from [10.231.194.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 04:35:52 -0700
Message-ID: <4b7719c7-22bf-4644-9705-2518031782d3@quicinc.com>
Date: Fri, 10 May 2024 19:35:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <quic_cjhuang@quicinc.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Luca Weiss <luca.weiss@fairphone.com>, <ath11k@lists.infradead.org>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com>
Content-Language: en-US
From: Carl Huang <quic_cjhuang@quicinc.com>
In-Reply-To: <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j3AXI2jA4xn9fb_LsFO0cpZiIIWeP0BZ
X-Proofpoint-GUID: j3AXI2jA4xn9fb_LsFO0cpZiIIWeP0BZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100083



On 2024/5/10 16:22, Luca Weiss wrote:
> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>> Add hardware parameter support_dual_stations to indicate
>> whether 2 station interfaces are supported. For chips which
>> support this feature, limit total number of AP interface and
>> mesh point to 1. The max interfaces are 3 for such chips.
>>
>> The chips affected are:
>>   QCA6390 hw2.0
>>   WCN6855 hw2.0
>>   WCN6855 hw2.1
>> Other chips are not affected.
>>
>> For affected chips, remove radar_detect_widths because now
>> num_different_channels is set to 2. radar_detect_widths can
>> be set only when num_different_channels is 1. See mac80211
>> function wiphy_verify_combinations for details.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Hi Carl,
> 
> Unfortunately this commit breaks wifi on a QCM6490 smartphone
> (qcm6490-fairphone-fp5) and makes the board crash.
> 
> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
> provide address list if chip supports 2 stations")) makes wifi work
> again.
> 
> Here's the crash log:
> 
> [   43.458118] ath11k 17a10040.wifi: Adding to iommu group 11
> [   43.459075] ath11k 17a10040.wifi: wcn6750 hw1.0
> [   43.461219] remoteproc remoteproc2: powering up 8a00000.remoteproc
> [   43.490363] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mbn, size 7435056
> [   43.614039] remoteproc remoteproc2: remote processor 8a00000.remoteproc is now up
> [   43.746227] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [   43.746262] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_timestamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> [   53.116443] qcom_q6v5_pas 8a00000.remoteproc: fatal error received: cmnos_thread.c:4645:Asserted in cmnos_allocram.c:cmnos_allocram_base_with_alignment_recurse:497 with Args:0x3,0x3,0x0
> [   53.116503] remoteproc remoteproc2: crash detected in 8a00000.remoteproc: type fatal error
> [   53.116734] remoteproc remoteproc2: handling crash #1 in 8a00000.remoteproc
> [   53.116749] remoteproc remoteproc2: recovering 8a00000.remoteproc
> [   53.125088] ath11k 17a10040.wifi: failed to send WMI_PDEV_SET_PARAM cmd
> [   53.125116] ath11k 17a10040.wifi: failed to enable PMF QOS: (-108
> [   53.125167] remoteproc remoteproc2: stopped remote processor 8a00000.remoteproc
> [   53.127827] ath11k 17a10040.wifi: failed to send WMI_PDEV_SET_PARAM cmd
> [   53.127848] ath11k 17a10040.wifi: failed to enable PMF QOS: (-108
> [   53.258990] remoteproc remoteproc2: remote processor 8a00000.remoteproc is now up
> [   53.390288] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [   53.390319] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_timestamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> [   53.404765] ath11k 17a10040.wifi: Last interrupt received for each CE:
> [   53.404789] ath11k 17a10040.wifi: CE_id 0 pipe_num 0 580ms before
> [   53.404804] ath11k 17a10040.wifi: CE_id 1 pipe_num 1 476ms before
> [   53.404818] ath11k 17a10040.wifi: CE_id 2 pipe_num 2 476ms before
> [   53.404831] ath11k 17a10040.wifi: CE_id 3 pipe_num 3 580ms before
> [   53.404844] ath11k 17a10040.wifi: CE_id 5 pipe_num 5 4294720700ms before
> [   53.404858] ath11k 17a10040.wifi: CE_id 7 pipe_num 7 4294720700ms before
> [   53.404871] ath11k 17a10040.wifi: CE_id 8 pipe_num 8 4294720700ms before
> [   53.404883] ath11k 17a10040.wifi:
>                 Last interrupt received for each group:
> [   53.404894] ath11k 17a10040.wifi: group_id 0 4294720700ms before
> [   53.404907] ath11k 17a10040.wifi: group_id 1 4294720700ms before
> [   53.404918] ath11k 17a10040.wifi: group_id 2 4294720700ms before
> [   53.404929] ath11k 17a10040.wifi: group_id 3 4294720700ms before
> [   53.404940] ath11k 17a10040.wifi: group_id 4 4294720700ms before
> [   53.404952] ath11k 17a10040.wifi: group_id 5 4294720700ms before
> [   53.404964] ath11k 17a10040.wifi: group_id 6 4294720700ms before
> [   53.404976] ath11k 17a10040.wifi: group_id 7 4294720700ms before
> [   53.404987] ath11k 17a10040.wifi: group_id 8 4294720700ms before
> [   53.404998] ath11k 17a10040.wifi: group_id 9 4294720700ms before
> [   53.405009] ath11k 17a10040.wifi: group_id 10 4294720700ms before
> [   53.405021] ath11k 17a10040.wifi: dst srng id 0 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405037] ath11k 17a10040.wifi: dst srng id 1 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405052] ath11k 17a10040.wifi: dst srng id 2 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405066] ath11k 17a10040.wifi: dst srng id 3 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405082] ath11k 17a10040.wifi: dst srng id 4 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405097] ath11k 17a10040.wifi: src srng id 5 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405114] ath11k 17a10040.wifi: src srng id 8 hp 0, reap_hp 2550, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405130] ath11k 17a10040.wifi: dst srng id 9 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405145] ath11k 17a10040.wifi: src srng id 16 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405162] ath11k 17a10040.wifi: src srng id 17 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405179] ath11k 17a10040.wifi: src srng id 18 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405196] ath11k 17a10040.wifi: src srng id 24 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405213] ath11k 17a10040.wifi: dst srng id 25 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405228] ath11k 17a10040.wifi: src srng id 32 hp 12, reap_hp 8, cur tp 12, cached tp 12 last tp 8 napi processed before 580ms
> [   53.405244] ath11k 17a10040.wifi: src srng id 35 hp 4, reap_hp 0, cur tp 4, cached tp 4 last tp 0 napi processed before 580ms
> [   53.405260] ath11k 17a10040.wifi: src srng id 36 hp 20, reap_hp 0, cur tp 20, cached tp 12 last tp 12 napi processed before 460ms
> [   53.405276] ath11k 17a10040.wifi: src srng id 39 hp 0, reap_hp 124, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405294] ath11k 17a10040.wifi: src srng id 57 hp 1022, reap_hp 1022, cur tp 2, cached tp 2 last tp 2 napi processed before 476ms
> [   53.405310] ath11k 17a10040.wifi: src srng id 58 hp 18, reap_hp 18, cur tp 22, cached tp 22 last tp 22 napi processed before 476ms
> [   53.405327] ath11k 17a10040.wifi: src srng id 61 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 584ms
> [   53.405345] ath11k 17a10040.wifi: dst srng id 81 tp 4, cur hp 4, cached hp 4 last hp 4 napi processed before 476ms
> [   53.405361] ath11k 17a10040.wifi: dst srng id 82 tp 44, cur hp 44, cached hp 44 last hp 44 napi processed before 476ms
> [   53.405378] ath11k 17a10040.wifi: dst srng id 85 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405394] ath11k 17a10040.wifi: src srng id 104 hp 65532, reap_hp 65532, cur tp 0, cached tp 0 last tp 0 napi processed before 588ms
> [   53.405411] ath11k 17a10040.wifi: src srng id 105 hp 0, reap_hp 504, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405427] ath11k 17a10040.wifi: dst srng id 106 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405443] ath11k 17a10040.wifi: dst srng id 108 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405458] ath11k 17a10040.wifi: dst srng id 109 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405474] ath11k 17a10040.wifi: dst srng id 110 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.405491] ath11k 17a10040.wifi: src srng id 128 hp 8190, reap_hp 8190, cur tp 0, cached tp 0 last tp 0 napi processed before 464ms
> [   53.405507] ath11k 17a10040.wifi: src srng id 129 hp 0, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> [   53.405525] ath11k 17a10040.wifi: src srng id 132 hp 2046, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 460ms
> [   53.405542] ath11k 17a10040.wifi: dst srng id 133 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294720700ms
> [   53.747641] qcom_q6v5_pas 8a00000.remoteproc: fatal error received: platform_msl.c:513:PCIE ACMT error debug0 0x6030, debug1 0x101
> [   53.747677] remoteproc remoteproc2: crash detected in 8a00000.remoteproc: type fatal error
> [   53.747864] remoteproc remoteproc2: handling crash #2 in 8a00000.remoteproc
> [   53.747875] remoteproc remoteproc2: recovering 8a00000.remoteproc
> [   53.758632] remoteproc remoteproc2: stopped remote processor 8a00000.remoteproc
> [   53.886889] remoteproc remoteproc2: remote processor 8a00000.remoteproc is now up
> [   54.017475] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [   54.017505] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_timestamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> [   54.027605] ath11k 17a10040.wifi: Last interrupt received for each CE:
> [   54.027627] ath11k 17a10040.wifi: CE_id 0 pipe_num 0 1204ms before
> [   54.027642] ath11k 17a10040.wifi: CE_id 1 pipe_num 1 1100ms before
> [   54.027655] ath11k 17a10040.wifi: CE_id 2 pipe_num 2 1100ms before
> [   54.027667] ath11k 17a10040.wifi: CE_id 3 pipe_num 3 1204ms before
> [   54.027680] ath11k 17a10040.wifi: CE_id 5 pipe_num 5 4294721324ms before
> [   54.027692] ath11k 17a10040.wifi: CE_id 7 pipe_num 7 4294721324ms before
> [   54.027704] ath11k 17a10040.wifi: CE_id 8 pipe_num 8 4294721324ms before
> [   54.027716] ath11k 17a10040.wifi:
>                 Last interrupt received for each group:
> [   54.027726] ath11k 17a10040.wifi: group_id 0 4294721324ms before
> [   54.027738] ath11k 17a10040.wifi: group_id 1 4294721324ms before
> [   54.027749] ath11k 17a10040.wifi: group_id 2 4294721324ms before
> [   54.027760] ath11k 17a10040.wifi: group_id 3 4294721324ms before
> [   54.027771] ath11k 17a10040.wifi: group_id 4 4294721324ms before
> [   54.027782] ath11k 17a10040.wifi: group_id 5 4294721324ms before
> [   54.027794] ath11k 17a10040.wifi: group_id 6 4294721324ms before
> [   54.027805] ath11k 17a10040.wifi: group_id 7 4294721324ms before
> [   54.027816] ath11k 17a10040.wifi: group_id 8 4294721324ms before
> [   54.027827] ath11k 17a10040.wifi: group_id 9 4294721324ms before
> [   54.027838] ath11k 17a10040.wifi: group_id 10 4294721324ms before
> [   54.027850] ath11k 17a10040.wifi: dst srng id 4 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.027866] ath11k 17a10040.wifi: src srng id 5 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027882] ath11k 17a10040.wifi: src srng id 8 hp 0, reap_hp 2550, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027898] ath11k 17a10040.wifi: dst srng id 9 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.027914] ath11k 17a10040.wifi: src srng id 16 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027930] ath11k 17a10040.wifi: src srng id 17 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027947] ath11k 17a10040.wifi: src srng id 18 hp 0, reap_hp 16376, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027964] ath11k 17a10040.wifi: src srng id 24 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.027980] ath11k 17a10040.wifi: dst srng id 25 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.027997] ath11k 17a10040.wifi: src srng id 32 hp 0, reap_hp 60, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.028014] ath11k 17a10040.wifi: src srng id 35 hp 0, reap_hp 124, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.028030] ath11k 17a10040.wifi: src srng id 36 hp 0, reap_hp 8188, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.028045] ath11k 17a10040.wifi: src srng id 39 hp 0, reap_hp 124, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.028063] ath11k 17a10040.wifi: src srng id 57 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 440ms
> [   54.028079] ath11k 17a10040.wifi: src srng id 58 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 436ms
> [   54.028095] ath11k 17a10040.wifi: src srng id 61 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 436ms
> [   54.028112] ath11k 17a10040.wifi: dst srng id 81 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028128] ath11k 17a10040.wifi: dst srng id 82 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028143] ath11k 17a10040.wifi: dst srng id 85 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028160] ath11k 17a10040.wifi: src srng id 104 hp 65532, reap_hp 65532, cur tp 0, cached tp 0 last tp 0 napi processed before 448ms
> [   54.028177] ath11k 17a10040.wifi: src srng id 105 hp 0, reap_hp 504, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> [   54.028194] ath11k 17a10040.wifi: dst srng id 106 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028210] ath11k 17a10040.wifi: dst srng id 108 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028226] ath11k 17a10040.wifi: dst srng id 109 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.028242] ath11k 17a10040.wifi: dst srng id 110 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 4294721324ms
> [   54.622819] ath11k 17a10040.wifi: failed to receive control response completion, polling..
> [   55.646232] ath11k 17a10040.wifi: ctl_resp never came in (-110)
> [   55.646259] ath11k 17a10040.wifi: failed to connect to HTC: -110
> [   55.653201] ath11k 17a10040.wifi: failed to start core: -110
> 
> 
> Let me know if you need any more information.
> 
> Regards
> Luca
> 
>>
>> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/core.c | 14 ++++--
>>   drivers/net/wireless/ath/ath11k/hw.c   |  2 +-
>>   drivers/net/wireless/ath/ath11k/hw.h   |  1 +
>>   drivers/net/wireless/ath/ath11k/mac.c  | 62 +++++++++++++++++---------
>>   4 files changed, 53 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index bebfd342e28b..739a8d13d57d 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -120,6 +120,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tcl_ring_retry = true,
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>> +		.support_dual_stations = false,
>>   	},
>>   	{
>>   		.hw_rev = ATH11K_HW_IPQ6018_HW10,
>> @@ -202,6 +203,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = false,
>> +		.support_dual_stations = false,
>>   	},
>>   	{
>>   		.name = "qca6390 hw2.0",
>> @@ -251,7 +253,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.cold_boot_calib = false,
>>   		.cbcal_restart_fw = false,
>>   		.fw_mem_mode = 0,
>> -		.num_vdevs = 16 + 1,
>> +		.num_vdevs = 2 + 1,
>>   		.num_peers = 512,
>>   		.supports_suspend = true,
>>   		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>> @@ -286,6 +288,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = true,
>> +		.support_dual_stations = true,
>>   	},
>>   	{
>>   		.name = "qcn9074 hw1.0",
>> @@ -367,6 +370,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = false,
>> +		.support_dual_stations = false,
>>   	},
>>   	{
>>   		.name = "wcn6855 hw2.0",
>> @@ -416,7 +420,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.cold_boot_calib = false,
>>   		.cbcal_restart_fw = false,
>>   		.fw_mem_mode = 0,
>> -		.num_vdevs = 16 + 1,
>> +		.num_vdevs = 2 + 1,
>>   		.num_peers = 512,
>>   		.supports_suspend = true,
>>   		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
>> @@ -451,6 +455,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = true,
>> +		.support_dual_stations = true,
>>   	},
>>   	{
>>   		.name = "wcn6855 hw2.1",
>> @@ -498,7 +503,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.cold_boot_calib = false,
>>   		.cbcal_restart_fw = false,
>>   		.fw_mem_mode = 0,
>> -		.num_vdevs = 16 + 1,
>> +		.num_vdevs = 2 + 1,
>>   		.num_peers = 512,
>>   		.supports_suspend = true,
>>   		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
>> @@ -533,6 +538,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = true,
>> +		.support_dual_stations = true,
>>   	},
>>   	{
>>   		.name = "wcn6750 hw1.0",
>> @@ -613,6 +619,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
>>   		.smp2p_wow_exit = true,
>>   		.support_fw_mac_sequence = true,
>> +		.support_dual_stations = false,
>>   	},
>>   	{
>>   		.hw_rev = ATH11K_HW_IPQ5018_HW10,
>> @@ -693,6 +700,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
>>   		.smp2p_wow_exit = false,
>>   		.support_fw_mac_sequence = false,
>> +		.support_dual_stations = false,
>>   	},
>>   };
>>   
>> diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
>> index d7b5ec6e6904..3b56ba1b8534 100644
>> --- a/drivers/net/wireless/ath/ath11k/hw.c
>> +++ b/drivers/net/wireless/ath/ath11k/hw.c
>> @@ -58,7 +58,7 @@ static void ath11k_hw_wcn6855_tx_mesh_enable(struct ath11k_base *ab,
>>   static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
>>   					   struct target_resource_config *config)
>>   {
>> -	config->num_vdevs = 4;
>> +	config->num_vdevs = ab->hw_params.num_vdevs;

Hi Luca, I guess above line caused WCN6750 crash.
For a quick try, you can change it back to "config->num_vdevs = 4".

A more reasonable fix coule be to define a dedicated function like 
ath11k_init_wmi_config_wcn6750() so wcn6750 doesn't use the same 
function as QCA6390 and WCN6855, and everything changed in this patch 
will not affect wcn6750.



