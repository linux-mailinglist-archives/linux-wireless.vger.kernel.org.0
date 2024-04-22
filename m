Return-Path: <linux-wireless+bounces-6618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894288AC2FF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3E01C208DC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2932579;
	Mon, 22 Apr 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F/9bb0UA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9082EADA
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756593; cv=none; b=Tvgk6jeVS99NgdRd0YOltFCb9uY2SHfNPeziM7dckDHD8/t1IOVQ1CzYZfebGKE1y3+l4WDeBCJohlpoT+NOt5fwFhWIb20J+pCvRH5cj8P2gMpJn95t7H0veqTmLyfFZ6z1jsCsvwtyroyqokOI92R/D521cg1pF84c4ccsWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756593; c=relaxed/simple;
	bh=WEjUEmyxec0fmwwLKE0jkmBIgsv4swVDXC61fYlIc/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FkIdC6USdNIuASwYqsobZKYKNiQIX6gRQUP01JJF4E1xNMiaXFE1U8x+NCy3FvxwXUD6fD4G90GqUsZMtZOq7kT9gfZWlN+X8xSKVhW6/ZuDORkSp9jFWZaNQZO/LfdrJz35WEKFgSeUZyjir20O46NgB/k5x7TDw8DKJ08vIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F/9bb0UA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3FPLS010241;
	Mon, 22 Apr 2024 03:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qEy1aj9e7j1XBrCy4RSYID7t92LIQPNNk/yjIcPRvzI=; b=F/
	9bb0UAKdsaGPYwB6aE4w4Bk/0+VusfRvcBOae4I1AjQE97fasS9Mxgy1OjYsriIZ
	m4vfikVRm75OTwu6CHUGekgA3p76Ol+aRGhKS+NIzh0B6evFRVU/Q6z1hz95RFb4
	oigZcyeMrfJRb7ejTBFKy5ozTnqbwhGqfQJL7F4w6Ng7cK4LSHU5oRoCPhwu9qeP
	s0jG3r9RmFa6q+H5WAzCRVJzO+LifTCFG1DZxtCdPgnPMxUxjXwum9J4IuGzon1b
	H+xpnb3j0y8IOf+wWFf2CUayLylsKL0TprEpK9HUQmZSUossWnSEVoE4VrwoVj9v
	SSWkOrf+9rN6dbG0cTkQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet783p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:29:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M3TQEw016606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:29:26 GMT
Received: from [10.253.79.89] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 20:29:25 -0700
Message-ID: <3040df8d-bb39-4540-b84b-9d049487f494@quicinc.com>
Date: Mon, 22 Apr 2024 11:29:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] wifi: ath12k: ACPI support
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240422030545.954-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20240422030545.954-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jmyYoVFr6OZrYgJiizswlqm1W4GguPJg
X-Proofpoint-ORIG-GUID: jmyYoVFr6OZrYgJiizswlqm1W4GguPJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_22,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=642 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220016

On 2024/4/22 11:05, Lingbo Kong wrote:
> v9:
> 
> * update the Copyright of acpi.h and acpi.c
> 
> v8:
> 
> * rebase to ath-202404181528
> * rewrite commit messages
> * cleanup and improvements all over to match the ath12k style, including
>    error handling, naming and so on
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
>    wifi: ath12k: ACPI TAS support
>    wifi: ath12k: ACPI SAR support
>    wifi: ath12k: ACPI CCA threshold support
>    wifi: ath12k: ACPI band edge channel power support
> 
>   drivers/net/wireless/ath/ath12k/Makefile |   1 +
>   drivers/net/wireless/ath/ath12k/acpi.c   | 394 +++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/acpi.h   |  76 +++++
>   drivers/net/wireless/ath/ath12k/core.c   |   7 +
>   drivers/net/wireless/ath/ath12k/core.h   |  18 ++
>   drivers/net/wireless/ath/ath12k/hw.c     |  10 +
>   drivers/net/wireless/ath/ath12k/hw.h     |   3 +
>   drivers/net/wireless/ath/ath12k/wmi.c    | 143 ++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h    |  41 +++
>   9 files changed, 693 insertions(+)
>   create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h
> 
> 
> base-commit: c416602943dd36fbd13af7496430723935c867a3

please omit this patchset, forget to add commit message of cover-letter,
i'll add it in next version.

