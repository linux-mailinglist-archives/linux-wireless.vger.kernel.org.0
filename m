Return-Path: <linux-wireless+bounces-4265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4986D3F4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 21:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031011F2363E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279213D316;
	Thu, 29 Feb 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VCBzc9zf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AA13C9EE
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237425; cv=none; b=XLHnmiujMclC+5qv9JdZwXMG8gQlBw8JdqeFr0oS6H6sprWMIM3LmapOF4P8Bv/FlOvA+H8KpcsQ14eho2bXC8BD8oOgTWWQoMQ9yCpcJ2b1efSKLXmQyfoRq5/R5yghBvqsZrfsL2ri1ebP51e73fiwDbkpOc1OlovRsY+Vzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237425; c=relaxed/simple;
	bh=yA6n56QKwdJHgdXFbJxc5ZpKsxagZ6W196E9A9a0WMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VJBXPtcKWdvvzHrDL1Du2W5kT6zdkjO5Q+BygjOT5vBHi6pjizgxlCMRUTZZn+rUBeoDehK0G186kgRmAZHrhkGiwK4vYh9m73jM8GKXdj3cxX50UrJt0qcWeEA1aRZkmTHW3qDzdOzSg97iUdjKfHnCXiEYx2kKeUc4Kg3BPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VCBzc9zf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TIe7WI014560;
	Thu, 29 Feb 2024 20:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1CcyJbEfna7NtQC9oeqraeumFk2pyv8puZ1bXPL2s3I=; b=VC
	Bzc9zf9qkd3ggbuDrgcEZCzglOtVlknjelQJFxOctnV70G2tC0LOgiMQdpBaBu7Y
	hGzLWzJT8RGzc/pY+yonRgw31O5NjEO97o74WuEe9ZACeogzUNV1HDt5f+UjUAN5
	UvjR4pX0Dd7c6RPUAJUUVsJApC8Dh1CEYUKZwDepYU8fHVD4fqQt/Ij/SWBMrF04
	TAR9oLNAdlSYoVe8GJpYTlI/elwRoGbNDF7XAPP5pfA8Cqz8aNr2w6eHLDEVnb5P
	+/XLI9tK42twf8DzGoCCgF4/Sq/twAvLWskFaZmchPP69XacYK8eS9nmYbBFoaHh
	IxrZQ2Xlrt+ShCoZmRSw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjycdg6ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:10:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TKAFTL015090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:10:15 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 12:10:14 -0800
Message-ID: <a79de0d7-f630-4a11-8cde-3444a6b93ee1@quicinc.com>
Date: Thu, 29 Feb 2024 12:10:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [v2] wifi: ath11k: use ath11k_mac_get_ar_by_pdev_id()
 consistently
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
 <20240229084031.51957-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240229084031.51957-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C-RQTzIEMqjFWTfTJuKp1c45sdQnVpO4
X-Proofpoint-ORIG-GUID: C-RQTzIEMqjFWTfTJuKp1c45sdQnVpO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=874 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290156

On 2/29/2024 12:40 AM, Dmitry Antipov wrote:
> Since 'ath11k_mac_get_ar_by_pdev_id()' can return NULL, check
> the return value in 'ath11k_wmi_tlv_rssi_chain_parse()' as well
> as in 'ath11k_wmi_tlv_fw_stats_data_parse()', and return -EINVAL
> in case of error. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: aggregate to the series

In the future please don't use In-Reply-To: when submitting a new
version of a patch/series. Each version should start its own thread.
Having In-Reference-To: is OK

> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 34ab9631ff36..2d93e4e78a37 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -6498,6 +6498,12 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
>  	rcu_read_lock();
>  
>  	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
> +	if (!ar) {
> +		ath11k_warn(ab, "%s: invalid pdev_id %d\n",
> +			    __func__, ev->pdev_id);

it is currently not the convention to use __func__ in ath11k logs.

there are currently 6 instances where the NULL check is present, and
each has a custom log message

I personally would be ok having this new format, but want to get Kalle's
approval for that. But if we do that I'd also want a follow-up patch to
modify those 6 existing logs.

FWIW in all of ath11k there are only 3 instances of __func__:
mac.c:                     "%s: rsn ie found\n", __func__);
mac.c:                     "%s: wpa ie found\n", __func__);
wmi.c:                     __func__);

> +		ret = -EINVAL;
> +		goto exit;
> +	}
>  	stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
>  
>  	ath11k_dbg(ab, ATH11K_DBG_WMI,
> @@ -6570,6 +6576,12 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
>  	rcu_read_lock();
>  
>  	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
> +	if (!ar) {
> +		ath11k_warn(ab, "%s: invalid pdev_id %d\n",
> +			    __func__, ev->pdev_id);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
>  
>  	for (i = 0; i < ev->num_pdev_stats; i++) {
>  		const struct wmi_pdev_stats *src;

The actual logic is correct.

/jeff

