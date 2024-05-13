Return-Path: <linux-wireless+bounces-7620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6C8C4A1C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18731C20F37
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFE85272;
	Mon, 13 May 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qv1uSelx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA585622
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643103; cv=none; b=bjGqZHhN076vZK8jZ17uAp8aqYtN5XqHrd2/GC2+j3vdSm3z+TeaN/qGePo2hLn3P2JiHYdmEMlBndEV+OoWL8SrMapRGBnUo+tTFC5NJVYT4xBTQCSYc4KMrZQv+lxjMv8V9KKg2Y6ys29xagtpNrTiuEKPEly2tpl3L6dZPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643103; c=relaxed/simple;
	bh=31G8NNjb1NRsycP8QvSk8i285p9RWZFOZZ+eNVugMmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iHQLLHSRjI6EuHFvIiFFSfCrPzx5xcDJ9uL2sx+gZIW+F8hewwHp2cNYUcdFxBReXPjHapu8igiWa0ViZH10OGW8d2QGRUWSCR3Zn/Z+1ucZFj7OXDYrtcAGmewLu8ebY05IhoOGcLoFaSnWko65Ye+P7ig63RJoUlqY7N8AV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qv1uSelx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ9BLA001659;
	Mon, 13 May 2024 23:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=stdxCUCTG4Tu5RjdGtgCgwWooLwi/XToQAgw3DMRbjs=; b=Qv
	1uSelxI2JD7SQUqpA9zJLPBkUsy8VOJjxTrByO1pg4wLKphCQZHZjbGlw2sJ+4Eu
	Z0UHNe2W+BcKC5U7BOEFWojYFR0btcAizTzyugXZ0D//jmh6NR8WPuvrU1WMS7Ij
	uCHp6S+UxHlT3OdqttM7kpo9j9+eIt1z+cHHcClh9rXx7eEuco3ZZkj6jByIIQFN
	Wp9xLXHW26ZGGLMPMsr6SVcd0YUA6CAQbFkwYfxTAjzLKmpaLlyjvW1VuMDCTK6I
	kS1t57Lsg3VglpZPztkiEVTIuQIl6M11zHJn2f3Z5b+X67LYzYriqHzWLqytv6O3
	SEOG56rKW/oY3IruHh3A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9kvuah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:31:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DNVT0M013978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:31:29 GMT
Received: from [10.110.0.4] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 16:31:29 -0700
Message-ID: <7916534b-ee14-4b95-b339-d614ce9393f1@quicinc.com>
Date: Mon, 13 May 2024 16:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: use correct MAX_RADIOS
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
 <20240511013644.3103905-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240511013644.3103905-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F_edr42BTH3FD5XAYO5o2zTFVDJrvEDm
X-Proofpoint-GUID: F_edr42BTH3FD5XAYO5o2zTFVDJrvEDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130161

On 5/10/2024 6:36 PM, Karthikeyan Periyasamy wrote:
> The current value of the MAX_RADIOS define is 3. However, this value is
> incorrect as the maximum number of radios supported by all devices does
> not exceed 2. Therefore, the MAX_RADIOS define should be modified to 2.

Use imperative tense: Therefore, modify ...

What is the observed problem, if any, with the current code?

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 496866673aea..27bec3800bff 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4770,7 +4770,7 @@ struct wmi_probe_tmpl_cmd {
>  	__le32 buf_len;
>  } __packed;
>  
> -#define MAX_RADIOS 3
> +#define MAX_RADIOS 2
>  
>  #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
>  #define WMI_SEND_TIMEOUT_HZ (3 * HZ)


