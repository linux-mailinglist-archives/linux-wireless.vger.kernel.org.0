Return-Path: <linux-wireless+bounces-4072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE8868E0F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 11:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773461C23FCC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84B1386BB;
	Tue, 27 Feb 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hd24gszB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9901386B4;
	Tue, 27 Feb 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031178; cv=none; b=nRq7roqbIxcefLQcmNX1FCQ65E2+ZAIs6jjrwic5Rd9Bql8q4ll+pRNRbq2OzRRY28nW8+VQKogo7mS0IzjipCxTvjLy6F+ZY/deJB/zssWfKRH7KFiNR+f7c6b4z2IM+ZtnD351u2VHvv0GHoabWz7K7EOQRQR3zejroL5Nus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031178; c=relaxed/simple;
	bh=QSZjUZ50vwu6ctMABlEVPk9Zai34/PnEUL4lGN7lmPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bH8+utmpLvYOyvSNdDYSrRfmM/HZBxn3d1C+RVQlxEbOYkegolM2ghtcvyGUZVODKEOx7MwSOfroRVA7iqpxtmCzS2u/4WrL1rZsnnPezX8u15C/qssCuTD1RGtbAVyFsg5/TbOHzDYX1a12Ycx3HIrZL2ZiAPXmSEsF6elnW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hd24gszB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9ZEO6022683;
	Tue, 27 Feb 2024 10:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oDTJ2+9IOdVFHed5HSEjPpe5xJe6fV9RI3NfptpcPqs=; b=Hd
	24gszBc7RVtN/CcDKsaPg+8q8BxR+sVHWy8r1Iq0UuiJ4lv6zw4tG1r7yd3h/O3N
	NB87wTnctuFZ4p3Zrm1MJkJ+nz89M7plIfl/ep/KHkWsnjSr9btO8FxWi2pRHGQU
	YfZrzcS9CYy/UH4erOM69IPHpz78j63DffgqMMLVj5A76oGrDo5M6eOubM1T1+M8
	I9ZKMBvezkpXDiagHwXAU5P6ExEftDDMwWeuufZfiQRGEkEaRMFV3z+J4v4KoEQC
	VNuyQ7BpQbbgf65Bu4nL5HblMSwgZGBjNGlI2t5ARlzkVga3Prkn1tAn3idcgOsl
	BsNb24ktk6hCmk7pQj+A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh50795km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 10:52:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RAqbO6007654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 10:52:37 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 02:52:36 -0800
Message-ID: <033a82d5-b8c1-437c-be85-ea37fb1e9420@quicinc.com>
Date: Tue, 27 Feb 2024 18:52:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] wifi: ath11k: hibernation support
Content-Language: en-US
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <20240227104427.7505-1-quic_bqiang@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240227104427.7505-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CrHNkUuqffRZyeNywZ20-pPS7P4TUBea
X-Proofpoint-GUID: CrHNkUuqffRZyeNywZ20-pPS7P4TUBea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270084



On 2/27/2024 6:44 PM, Baochen Qiang wrote:
> Currently in ath11k we keep the firmware running on the WLAN device when the
> network interface (wlan0) is down. The problem is that this will break
> hibernation, obviously the firmware can't be running after the whole system is
> powered off. To power down the ath11k firmware for suspend/hibernation some
> changes both in MHI subsystem and ath11k are needed.
> 
> This patchset fixes a longstanding bug report about broken hibernation support:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214649
> 
> There already is an RFC version which has been tested by multiple users with
> positive results:
> 
> https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
> 
> Basically the RFC version adds two APIs to MHI stack: with the first one ath11k
> is able to keep MHI devices when going to suspend/hibernation, getting us rid of
> the probe deferral issue when resume back. while with the second one ath11k could
> manually prepare/unprepare MHI channels by itself, which is needed because QRTR
> doesn't probe those channels automatically in this case.
> 
> Mani, the MHI maintainer, firstly doesn't like that version and insists that an
> MHI device should be destroyed when suspend/hibernation, according to his
> understanding on device driver model. See
> 
> https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/
> 
> After a long discussion Mani thought we might need a new PM callback with which
> ath11k is able to wait until kernel unblocks device probe and thus MHI channels
> get probed. So we came to the kernel PM list and there Mani realized that his
> understanding is not correct so he finally agrees to keep MHI device during
> suspend/hibernation. See
> 
> https://lore.kernel.org/all/21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com/
> 
> Mani also pointed out that an MHI controller driver (ath11k here) should not touch
> MHI channels directly because those channels are managed by the corresponding MHI
> client driver (QRTR here). To address this, we come up with this version.
> 
> Compared with that RFC version, this version adds PM callbacks in QRTR module:
> suspend callback unprepares MHI channels during suspend and resume callback
> prepares those channels during resume. In this way ath11k doesn't need to do
> unprepare/prepare work by itself so those two APIs added in RFC version are
> removed now.
> 
> The power down/up procedure requires a specific sequence in which PM callbacks
> of wiphy, ath11k and QRTR are called, this is achieved by exploiting the
> child-father relationship between their device struct, and also the PM framework
> which separates whole suspend/resume process into several stages. Details in
> patch [3/3].
> 
> v3:
>   - skip QRTR suspend/resume if MHI device is found to be in suspend state.
Forget to mention that comments on 'destroy_device' are also updated per 
Mani in patch 1/3.

> 
> v2:
>   - add comment on why destroying the device is optional in
>     mhi_pm_disable_transition().
>   - rename mhi_power_down_no_destroy() as mhi_power_down_keep_dev().
>   - refine API description of mhi_power_down() and
>     mhi_power_down_keep_dev().
>   - add/remove __maybe_unused to QRTR PM callbacks.
>   - remove '#ifdef CONFIG_PM'.
>   - refine commit log of patch 1/3 and 2/3.
> 
> Baochen Qiang (3):
>    bus: mhi: host: add mhi_power_down_keep_dev()
>    net: qrtr: support suspend/hibernation
>    wifi: ath11k: support hibernation
> 
>   drivers/bus/mhi/host/internal.h        |   4 +-
>   drivers/bus/mhi/host/pm.c              |  42 ++++++++--
>   drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
>   drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
>   drivers/net/wireless/ath/ath11k/core.h |   6 +-
>   drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
>   drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
>   drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>   drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
>   drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
>   include/linux/mhi.h                    |  18 ++++-
>   net/qrtr/mhi.c                         |  46 +++++++++++
>   12 files changed, 244 insertions(+), 60 deletions(-)
> 
> 
> base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11

