Return-Path: <linux-wireless+bounces-1526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551E825A48
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7C1C23521
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D035EE7;
	Fri,  5 Jan 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a+U2NRFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153B35EE5
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405ILWgP029228;
	Fri, 5 Jan 2024 18:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WTNHKNor+rHszt/yEupeL3WI3usQCMjroD9+DhHfOJ0=; b=a+
	U2NRFK33YR5ZR7cjlUZMZoPjnci6I9F0/8/+0/utaHsAFvYulISmuHvm2oWMJhBz
	MO1/jFVfsPeb5g2iQc7pU5d+KACazrtecTEsKlYsmyPYFOhR3QN3WtjocyJLqVw+
	gjBCPaRb4Wk1aImPzz1mWfDGBhoBA31Lwvc7IWBRpWPuiGKitQaf//9PBWm7PzRe
	TPcEf7UJKQREzZ8IJrJHgFRcyKt1nwtpks/3smjGbVLF6W+9PItj9Yuu7Up0ZiK4
	6va/lZ57BPMmQyozId6/M6kmCT2tipUIX6Q2dZwLespuj1DE9l7wZ+7ZTsfFt0v4
	bPC/jN8c5rzAu6aKes0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve97r9xtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 18:37:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405IaxOl023226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 18:36:59 GMT
Received: from [10.110.76.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 10:36:58 -0800
Message-ID: <84a1fba8-b709-4bf5-8fc0-9d32d245f9ff@quicinc.com>
Date: Fri, 5 Jan 2024 10:36:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add firmware-2.bin support
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240105164207.2906093-1-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240105164207.2906093-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GKDPZJ1CErmP64k_OHrhmmQS_G2DmDdL
X-Proofpoint-GUID: GKDPZJ1CErmP64k_OHrhmmQS_G2DmDdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050152

On 1/5/2024 8:42 AM, Raj Kumar Bhagat wrote:
> Firmware IE containers can dynamically provide various information
> what firmware supports. Also it can embed more than one image so
> updating firmware is easy, user just needs to update one file in
> /lib/firmware/.
> 
> The firmware API 2 or higher will use the IE container format, the
> current API 1 will not use the new format but it still is supported
> for some time. Firmware API 2 files are named as firmware-2.bin
> (which contains both amss.bin and m3.bin images) and API 1 files are
> amss.bin and m3.bin.
> 
> Currently ath12k PCI driver provides firmware binary (amss.bin) path to
> MHI driver, MHI driver reads firmware from filesystem and boots it. Add
> provision to read firmware files from ath12k driver and provide the amss.bin
> firmware data and size to MHI using a pointer.
> 
> Currently enum ath12k_fw_features is empty, the patches adding features will
> add the flags.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/Makefile |   3 +-
>  drivers/net/wireless/ath/ath12k/core.c   |  10 +-
>  drivers/net/wireless/ath/ath12k/core.h   |  16 ++-
>  drivers/net/wireless/ath/ath12k/fw.c     | 165 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/fw.h     |  27 ++++
>  drivers/net/wireless/ath/ath12k/mhi.c    |  20 ++-
>  drivers/net/wireless/ath/ath12k/qmi.c    |  51 ++++---
>  7 files changed, 267 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/fw.h
> 
...
> +int ath12k_fw_map(struct ath12k_base *ab)
> +{
> +	int ret;
> +
> +	ret = ath12k_fw_request_firmware_api_n(ab, ATH12K_FW_API2_FILE);
> +	if (ret == 0)
> +		ab->fw.api_version = 2;
> +	else
> +		ab->fw.api_version = 1;
> +
> +	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using fw api %d\n",
> +		   ab->fw.api_version);
> +
> +	return 0;

since this always returns 0 perhaps make this a void function and remove
the error checking from the caller?

> +}
> +
> +void ath12k_fw_unmap(struct ath12k_base *ab)
> +{
> +	release_firmware(ab->fw.fw);

should we memset the entire ab->fw struct to 0 so that there aren't any
dangling pointers into the firmware buffer?

> +}


