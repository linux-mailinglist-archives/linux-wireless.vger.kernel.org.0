Return-Path: <linux-wireless+bounces-17266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3EA081D4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36817169466
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38C1FF602;
	Thu,  9 Jan 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMI5U5RH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCD2054E4
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456037; cv=none; b=uy/ww6XAshIrMDnV4Bk+7mJ5Pt6nnD+p6dpZiK0EH2Ms+2bc0ZWnxuTe+oxAS+FFLvEuikCDLz49fX96pHnRRn7JLex6+tesRetSgfhLayU6cK3BZxX5INL/L/5VI5rcqkOv6tOpUjnQljz2HnEdJb20KaMNJisJrLSPc92VQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456037; c=relaxed/simple;
	bh=5YVXiZ4LXZzG+PC+/sBXxyObGY7rK1AGelaN3WXQW1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLon2ZwtOwfC0/ebC3JXNnrlMZxX50Ii02twUgPZYhtNcEIp42vAnVqNcNaenG8Wj9farJOQVrRtfWFkLm13kSV8Kwmz2HSFQEwV29BQsQYdaZos4Uf1jJdGYA97fp1HtYcNmt/Bz8f8fOiIGjhhKIVizRauTCNl/4s19NtEbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMI5U5RH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509FrePQ007347
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 20:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjWG1bYTdqbLh8NAqdIp3J5nh3T7QSmrTPraAQAjW7k=; b=YMI5U5RHyrdrOrC0
	Z6MXxHVE1SPwuaLGblobZ9ckIDwvmV8/M0C+4IrEWCHJkGKyeRpcr5hhRIZcOJpx
	mgk7moMUZLCvmTc974kfIsNvfIJF/DOcrHfTfCxMLz6xV6oTXq23nNNTJP7dJvIH
	C+UovTeRh9PI8sRqFl/3tuUDell+3NdyrkjGZdZ6+yGxWmxTmDeadVlV3IH1vbN5
	q0AXyoq+pxr41wF2ys+1v5a4f+3ZPx1RLuhiN2SrX4q7IljLwSCw6gKGXSDOss2H
	27M5wKJktPBsLknPOHBX1C8NsbuU00qrMgxHVBGzB9qT33K51J6jB8vKOX/6f1vC
	JF6ANQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442hgg0p44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 20:53:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166464e236so38296235ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 12:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456033; x=1737060833;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWG1bYTdqbLh8NAqdIp3J5nh3T7QSmrTPraAQAjW7k=;
        b=na5cN5DlO6d0iC/RyCG8ErAGtIOxw7PItD+UMJiYkL6yCSraV5DQNnNw6YwMyDeiV2
         n18SfN5h2Z/Zaq2Hguzsw4E2qe+gvxbXgg/GYfizRxnkJ8lPecbOYs69W1fkK6FDR6FV
         ao9tR7aI0rXCK1JaQX/4tefRG2C0Z3YIyjoFIneoeVEOPAti0I0mH8Z5LUPnZUE/PSHj
         O5xlT52HeuBVhbxD9MdzJ3FK7LVXSHFbFE3T1JgS1LPVUo7if4fxMcGcGN6IDXsTp/Kf
         H7NlqCIBZpfHMiTzFpFgoKw8I+cHHRgu3t05sSIIfGebAOOoG+jgRAsUI/m0mP2nIvbe
         UFwQ==
X-Gm-Message-State: AOJu0Yx6s5z2VHtWMj2J7GF6DGp54xIf4u69+cVYq+wh1TYjfu1f3dBN
	CbmABDRcxipr2Gy9b47J8hwE251fz57HMS60BteiiggCGkT2GHDvM/r1WIqf1y+/62SYlTdkXyf
	oKpkIFrTh0BkSgODWk9jHvuOvBilYX1e0YLmOuOt8BHWGHEdC9YCW92yDfmfIrebtbA==
X-Gm-Gg: ASbGncvY/kq/ciadWysHVtXmVwZyclXnM437WVIR6rSPaxP/AQLRZZLZOTvybjJl/YD
	rqWYzEqAkjyv8SLaYWKkJAwpW6i970XUFqSsK4NtmwimpeuMbAEhTw8h0K8BZsNK+MxTiNH7iXy
	shjwlOLdm3dWuxai8JpYWfY5PweQdace5KGTEL58/1xI2CIrHkRdKl6M1aiLCT75EAV1U0SSPqz
	x+Hw9YrTwITZ+LbumgmD0tunlKNGF4VgPOnz7k8UsDfCc5Tsp4KljzB8HWfUgA93UEYG2EO/dYE
	3U9eXiuV6jShC2RwvRxnQpRT+YhioAy/bwot
X-Received: by 2002:a17:903:32cf:b0:216:644f:bc0e with SMTP id d9443c01a7336-21a83f502aemr138891715ad.24.1736456032843;
        Thu, 09 Jan 2025 12:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBpiMVb3WnlkvxE8joPaaT4BA5vVWlpYlIe3cgFo9Nthp9ndwMQB5a2/Zj+9UeaWS3quU+bA==
X-Received: by 2002:a17:903:32cf:b0:216:644f:bc0e with SMTP id d9443c01a7336-21a83f502aemr138891465ad.24.1736456032484;
        Thu, 09 Jan 2025 12:53:52 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3193921675sm1667243a12.40.2025.01.09.12.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 12:53:52 -0800 (PST)
Message-ID: <70242ecc-c353-4973-bc04-e85b89a1aabb@oss.qualcomm.com>
Date: Thu, 9 Jan 2025 12:53:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] wifi: ath: create common testmode_i.h file for ath
 drivers
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
 <20250109183551.1028791-2-quic_aarasahu@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109183551.1028791-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FfPCSvSEb2lgqw_j0wNaBxvOcWlv_Kd6
X-Proofpoint-ORIG-GUID: FfPCSvSEb2lgqw_j0wNaBxvOcWlv_Kd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=768 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090165

On 1/9/2025 10:35 AM, Aaradhana Sahu wrote:
> User space application requires that the testmode interface
> is exactly same between ath drivers. Move testmode_i.h file
> in ath directory to ensure that all ath driver uses same testmode
> interface instead of duplicating testmode_i.h for each ath drivers.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/testmode.c    | 80 +++++++++----------
>  .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
>  2 files changed, 67 insertions(+), 67 deletions(-)
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
> index 302d66092b97..9d1613723601 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode.c
> +++ b/drivers/net/wireless/ath/ath11k/testmode.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.

should be 2023-2025 to account for the patches posted but not merged in 2024

> diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
> similarity index 50%
> rename from drivers/net/wireless/ath/ath11k/testmode_i.h
> rename to drivers/net/wireless/ath/testmode_i.h
> index 91b83873d660..b8fa5092e6ca 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode_i.h
> +++ b/drivers/net/wireless/ath/testmode_i.h
> @@ -1,59 +1,59 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.

should be 2023-2025 for the same reason



