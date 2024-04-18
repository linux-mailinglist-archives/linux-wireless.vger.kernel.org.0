Return-Path: <linux-wireless+bounces-6544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACCC8AA56F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 00:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EA41F21B37
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0088199E8B;
	Thu, 18 Apr 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="crcrUigf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333D168B06
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479041; cv=none; b=YrsI9vw3ZRIYxTwc4vPTqYwi0CUiuVOLekxOg0nmAkTN391F6/uGt4ipz8nXEXK5utC//caAT2LgJ5v/OeJ7+ZAoeO26dZMl2iRZVG5IWOtG/DY3lLWxxybvp6grmRHYrH42mTxQNOIbaMymicwIPk3vXd7qvjinOzOG4kAu/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479041; c=relaxed/simple;
	bh=sR804aN3uZRYEUdLMq63Lz/giL6ZLpfSWIr5KcyxgMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AWFCQDYPJW0FaYRofqQQGdSnlwIeyoC1vn5O+x884gGyx8gFoc7V0Mp5r3jBe79+EH8qSrzSq9BWtzmxRTGGN5sKyTgezIDS+RTP/NSUQveGNPbNE2l0nkgKPQS6wRvJPLpAjwsnDdkHd7Q1gZjKNeBGEGHs6aY6M91f+JAFoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=crcrUigf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ILqR2Z009600;
	Thu, 18 Apr 2024 22:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1mjKvSNAWlIpVzI3IIrZrBQFaI/9Zpxh+Nph30N497s=; b=cr
	crUigfviM5sSToxzQIXRxJ0dVXqLxrBxc1I7TG5XtVfwIsweZB5cV1xoxqF2Fob5
	TjnzIE+MerPhZiQtV/lhUCrjwyFxMiTrtHUyVuH3dMkFQodDiEWM+yeKGnOJEcaM
	XG4dIFOWzyLQnpvvKEzWzEhMcIKm9ScIV45PMKpTSOOvq5CWbATll8G/so7Na/VT
	QBOoF+FfX6GMBFDqdmONMomBhi1J5GCoivpzuFPRbyTtbH51Xw1KR7aSAZ+NRSUp
	Vpq7V5gHpY5y9pEehtLrCnsnyBdIwBh9RZ7HDNSnXXlL+WMDJUc6QST0M9XI9zEu
	trcMo42PxCL7RCdYHTmQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xka6rr86n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:23:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IMNn7f007012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:23:49 GMT
Received: from [10.110.20.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 15:23:49 -0700
Message-ID: <71414c51-26b2-4ce7-898c-5df0e8e31825@quicinc.com>
Date: Thu, 18 Apr 2024 15:23:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418162019.1246749-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 46IoToySGNOt0hx896yCx3bhmXBGzTJc
X-Proofpoint-GUID: 46IoToySGNOt0hx896yCx3bhmXBGzTJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=514 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180162

On 4/18/2024 9:20 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS SAR,
> configuration of CCA threshold and band edge channel power functionalities.
> This is enabled only on WCN7850.
> 
> TODO:
> 
> * test with ACPI support in hardware (I don't have such hardware), especially
>   suspend and hibernation
> 
> v8:
> 
> * rebase to ath-202404181528
> * rewrite commit messages
> * cleanup and improvements all over to match the ath12k style, including
>   error handling, naming and so on
> * locate new place to call ath12k_acpi_[start|stop]()
> * move wmi functions up in wmi.c file
> * consolidate WMI functions using WMI_PDEV_SET_BIOS_INTERFACE_CMDID into ath12k_wmi_set_bios_cmd()
> * ath12k_acpi_stop(): don't call acpi_remove_notify_handler() if we never installed the handler
> 
> v7: https://patchwork.kernel.org/project/linux-wireless/cover/20231013114434.81648-1-quic_lingbok@quicinc.com/
> 
> * adjust the length of line
> * add cpu_to_le32()
> 
> v6:
> 
> * remove code that is not called
> 
> v5:
> 
> * rebase to the latest tag
> 
> v4:
> 
> * revise commit log using imperative voice
> * delete guid_is_null()
> 
> v3:
> 
> * remove unnecessary cpu_to_le32()
> * adjust the order of the macros
> * apply jeff's advice
> 
> v2:
> 
> * put <linux/acpi.h> in the include guard
> 
> Lingbo Kong (4):
>   wifi: ath12k: ACPI TAS support
>   wifi: ath12k: ACPI SAR support
>   wifi: ath12k: ACPI CCA threshold support
>   wifi: ath12k: ACPI band edge channel power support
> 
>  drivers/net/wireless/ath/ath12k/Makefile |   1 +
>  drivers/net/wireless/ath/ath12k/acpi.c   | 394 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/acpi.h   |  76 +++++
>  drivers/net/wireless/ath/ath12k/core.c   |   7 +
>  drivers/net/wireless/ath/ath12k/core.h   |  18 ++
>  drivers/net/wireless/ath/ath12k/hw.c     |  10 +
>  drivers/net/wireless/ath/ath12k/hw.h     |   3 +
>  drivers/net/wireless/ath/ath12k/wmi.c    | 143 ++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h    |  41 +++
>  9 files changed, 693 insertions(+)
>  create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h
> 
> 
> base-commit: c416602943dd36fbd13af7496430723935c867a3

I can verify this doesn't crash my system, but apparently my ACPI doesn't have
the underlying settings, so cannot verify actual functionality

Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi_evaluate_dsm() failed
Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2
Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi failed: -2

/jeff

