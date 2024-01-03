Return-Path: <linux-wireless+bounces-1453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6A82315B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E519C28540B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E131BDCE;
	Wed,  3 Jan 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cSvXoLae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194A1BDDE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403DNLIn026005;
	Wed, 3 Jan 2024 16:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g7qTu3VkiUpqlR77+uQfKE+Acb+SUIp2sYG69or21u0=; b=cS
	vXoLaefg1dd4dDWSUALXidV/Oc+UPix2QFyYsHwSA1wCt/C1yp5/btkn/iDC0G2+
	UjwQktoL/BchWG91LRk97vk4PnYPze2yMSI/Cij2L4+wXGHIgyszY2ZyvYEnfTKK
	wL036KaCw5ch1pQiqhL3hzGhNbPipiooB08zbIE4kOAzlyxj2TC+dLx7K2WHF6os
	KaNPB4JFg2pRL8zvxKIuqa/h9rpVrN1SffAa7oE69vzWzFRC8uqxpRN3plDaH9dK
	bt5GMdCHuHZPAb6WIs4kLakpLWkGXH6akFUGMESRI6lisFfqHTcpQRs4wmJ0F7Js
	lMYfDC2nceLJvR3PLFEw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd0cksswq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 16:36:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403Ga2Yl027540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 16:36:02 GMT
Received: from [10.110.76.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 08:36:02 -0800
Message-ID: <2269025d-d1ef-4940-a438-c67d3d94baf9@quicinc.com>
Date: Wed, 3 Jan 2024 08:36:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240103041220.3082014-1-quic_periyasa@quicinc.com>
 <20240103041220.3082014-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240103041220.3082014-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5lJnuiGkm_p3jmZsVpAc0qSAjA5ShI9p
X-Proofpoint-ORIG-GUID: 5lJnuiGkm_p3jmZsVpAc0qSAjA5ShI9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=550
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030135

On 1/2/2024 8:12 PM, Karthikeyan Periyasamy wrote:
> ENOTSUPP is not a standard error code, don't use it. Replace with
> EOPNOTSUPP instead.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---

> diff --git a/drivers/net/wireless/ath/ath10k/htt.c b/drivers/net/wireless/ath/ath10k/htt.c
> index 907e1e13871a..3835c5cc07f9 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.c
> +++ b/drivers/net/wireless/ath/ath10k/htt.c
> @@ -2,6 +2,8 @@
>  /*
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
> + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.

You are not working on behalf of The Linux Foundation so you should not
be adding or modifying Linux Foundation copyrights

> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.

And this should only have 2024 since there were not any Qualcomm changes
in 2021-2023

> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index 0ce08e9a0a3d..9a1889599729 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.

Again this should only have 2024



