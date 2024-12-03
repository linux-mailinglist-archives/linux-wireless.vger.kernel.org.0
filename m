Return-Path: <linux-wireless+bounces-15841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221F9E10FD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 02:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8261641E5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A41CFA9;
	Tue,  3 Dec 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mPTdOc9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD022E400;
	Tue,  3 Dec 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190898; cv=none; b=SLKZJkUXsZzd1q2K1Vr4LepwcJxELdDr6T098akhj0DmWbesR8hymLFfOMUY7kzt5Lal+KLaNZ3EDn5fwHBeXZXIKJ69rNvwnqASwG6mrq99H0nDzq1nAmwln9ftjewvO5nJTeoeQAb6dMXcoWigHspj4IWao7yPW7mkgPO3fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190898; c=relaxed/simple;
	bh=os709eFpyZXXzpDsSVxNEFgb3S8OYUhRP/cfq7MdNRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i0C/5DvMFbRQVClZOczs1HjUyP24hkbR5kBqExYNtXqPG/adBGUuTwF61UHz1m0BNiGcLMXSYwQ4NHdgcJePhZToiB3LLvuwaav4iHS0X6NV40eSCcWoTK/kyJf4gIAXWSzYpypF9DtZDxkAuWrMGVaHkuTDlasPcSic1vfljwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mPTdOc9s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Jr8Bv029045;
	Tue, 3 Dec 2024 01:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tH7Bv/E4tITeddHSJN0qhSxcIiET/yWGf0xXk7LImBg=; b=mPTdOc9szQdOUnXv
	NXE8rPX1OVMB4Uo9Yzc0kuekvq8G15UYKrPX/OippXLJfvvU86E7KU6kqVFjPvQm
	bL9ORpvQ5yyNdD2PXPdMunXFW6lBYP55w4kCnrvN4PXkCd+6W2A2QmUmDEgf1hgA
	WcxQx7cFvpnutb1/wtxJSq+ff0yQzlfV9VDXvG2t0vbIWBKJzF6hrqKV/Q81k5fm
	gvgy1BSnt/U2VoyUnUfx99e+yYvbolbLNVoMYYsgaKKt0y++BqsZrOUh0GgvjbnR
	lcUsmacr9iGaNDd3koFThlhHHJDg5fu34XFEKwighYl5y35mi7FUNh5IKllNbBq7
	K523pw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ufe6ced-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 01:54:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B31smtJ025605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 01:54:48 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Dec 2024
 17:54:46 -0800
Message-ID: <7ccd4b98-9557-4a8b-b493-e01b157c71e2@quicinc.com>
Date: Tue, 3 Dec 2024 09:54:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <quic_cjhuang@quicinc.com>, Vladimir Benes <vbenes@redhat.com>
References: <20241202091858.200773-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241202091858.200773-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oIxCo3DKzLTdlAKzqpLlK3NKl0JQ2JIt
X-Proofpoint-GUID: oIxCo3DKzLTdlAKzqpLlK3NKl0JQ2JIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030014



On 12/2/2024 5:18 PM, Jose Ignacio Tornos Martinez wrote:
> Since commit f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces"),
> if dual stations are supported for a device, we can not configure more that
> one AP and/or DFS cannot be enabled.
> 
Try 
https://lore.kernel.org/all/20241127022742.4016870-1-quic_yuzha@quicinc.com/
> Enable this by creating a new parameter (ignore_support_dual_stations) to
> ignore this feature if it is convenient. Default behavior is to support
> dual stations if possible.
> 
> Reported-by: Vladimir Benes <vbenes@redhat.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>   drivers/net/wireless/ath/ath11k/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index be67382c00f6..55c7a55d85ff 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -37,6 +37,12 @@ bool ath11k_ftm_mode;
>   module_param_named(ftm_mode, ath11k_ftm_mode, bool, 0444);
>   MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
>   
> +static bool ath11k_ignore_support_dual_stations;
> +module_param_named(ignore_support_dual_stations,
> +		   ath11k_ignore_support_dual_stations, bool, 0644);
> +MODULE_PARM_DESC(ignore_support_dual_stations,
> +		 "Ignore the support for dual stations to support other combinations");
> +
>   static const struct ath11k_hw_params ath11k_hw_params[] = {
>   	{
>   		.hw_rev = ATH11K_HW_IPQ8074,
> @@ -2162,6 +2168,9 @@ static int ath11k_init_hw_params(struct ath11k_base *ab)
>   	}
>   
>   	ab->hw_params = *hw_params;
> +	if (ab->hw_params.support_dual_stations &&
> +	    ath11k_ignore_support_dual_stations)
> +		ab->hw_params.support_dual_stations  = false;
>   
>   	ath11k_info(ab, "%s\n", ab->hw_params.name);
>   


