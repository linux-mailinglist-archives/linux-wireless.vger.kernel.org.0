Return-Path: <linux-wireless+bounces-4266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81B86D40B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 21:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B831F24B2A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432A13F420;
	Thu, 29 Feb 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZ0LAxHS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70E2E410
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237930; cv=none; b=aYVnmpiZdWE9BPfYtFls5VTvMZZbk701k42ZMnXlB0I6Y+tqQFeH4doBSS3qMGWpv5DyqF1mf88UxXXb11nwYcHN3sancECS/eEek9G/UJ3Om6ecn6olyIuYIaHoKHcbG3Ntwn0ex1jkmNi/WHohWhPU8tv6e5v/Dk+IdtAvjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237930; c=relaxed/simple;
	bh=8S9p3G+v0BhY6JkTsUthD8xLm8nCZYknJsSmwEA/8cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kmuxYTuB/gto4lNBDRDNqMa1186NZGdveF0ZIcmDsG0BTPVVzH76wnQ3na4dIdmMSJ/bccw7u+J77lx6Jh1njmxA+yM4D2bCqPM+rZOt3mQWmshYW+zeN7wJRsE+pJA3LWOEiyDFo13aqtdfzS905vFhNPfQjAQ+LEkgrMlKO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZ0LAxHS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TJxf1H028006;
	Thu, 29 Feb 2024 20:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M8xQrjhCPzY4N6J9dVH9EQlHleN2HwmHrb8uYgN5pl0=; b=JZ
	0LAxHS9cYiF2+auM3t5VvS2i/jG5nSWppSbf8pTd0AygNb1Xk2m2CFe347gdW2u4
	T0hfZo9U8zv874n8DrjFBLgwfrhbLSxwgzLq4oDzWzaJCMMT8iJSoyetobhbpl5Z
	5kmP76jqZpFeXSMDtfLfJc1c9FgsF4KguTCCilnq3gw58lM51ik3AuWXCJnBt4r7
	rN4meBZAV5Zbf3A6Ftmqp8RZgks527YbDiF1Y/IG/LQh6EfV5Q6iIXui4PjfoxEC
	zGvVtExWBTuySlX4ji1ZNfyMrgynZcWVIYW1vW4R5d4UauspVgGHLjr/kjENwyoL
	Rm0h53Bkk+VgnciF0Wqw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjx6c0fmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:18:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TKIboF011911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:18:37 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 12:18:36 -0800
Message-ID: <51e78bd1-a692-4600-955e-7b793c9bbff1@quicinc.com>
Date: Thu, 29 Feb 2024 12:18:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] [v2] wifi: ath11k: handle unknown scan state in
 ath11k_mac_op_remain_on_channel()
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
 <20240229084031.51957-1-dmantipov@yandex.ru>
 <20240229084031.51957-2-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240229084031.51957-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jXyvxi4g65iZstsSJdIYg4T6rsjpaule
X-Proofpoint-ORIG-GUID: jXyvxi4g65iZstsSJdIYg4T6rsjpaule
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=866 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290158

On 2/29/2024 12:40 AM, Dmitry Antipov wrote:
> In 'ath11k_mac_op_remain_on_channel()', add fallback default to
> handle an unknown scan state with -EINVAL. Compile tested only.
> 
> Initially found by Linux Verification Center (linuxtesting.org)
> with SVACE (and reported as an attempt to use uninitialized
> variable).
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: prefer fallback branch over dummy initializer (Jeff Johnson)
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index a6a37d67a50a..47d3d5fd0423 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9224,6 +9224,11 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  	case ATH11K_SCAN_ABORTING:
>  		ret = -EBUSY;
>  		break;
> +	default:
> +		ath11k_warn(ar->ab, "%s: unexpected scan state: %d\n",
> +			    __func__, ar->scan.state);

again let's wait for Kalle to comment on use of __func__

> +		ret = -EINVAL;
> +		break;
>  	}
>  	spin_unlock_bh(&ar->data_lock);
>  


