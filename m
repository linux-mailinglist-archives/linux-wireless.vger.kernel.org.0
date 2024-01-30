Return-Path: <linux-wireless+bounces-2742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA5841831
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF19B22494
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF812D05B;
	Tue, 30 Jan 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6oRiiLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CB2C868
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577273; cv=none; b=EieAG6fhMNfyJ1Y/2c4L0CtRb6bVUPEj8NPPlynW+1K361JbQxCj7ytlyEhumvz0WtwKX9w5N9plsuej3dIFO7HLwbI9VDULH9Q8lLjnG5N74M0BUboEVlwXI9Ty8/ug/gqNdqCkN0iN4Vfb2CSM3Fdpt4H/qhtKED65MeYU6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577273; c=relaxed/simple;
	bh=ql1fkAcHiBEMI38cPPVB0rzwYqC2xWluuv2M8HNKD5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bgz188TwDkQxcBEMVcQuvVMkyiQVjbQczuSQ6oF2yh4HAoYdF+O2Zt0Z/F9GQdAqHjB3TRvrugBfyxUp58RjhwLVOi63vhxnXReGRymx0+1SDiVDQFYc58b9ZqDOlNKNEcmZTwKSEqlggxghrbfSIiaODHOd0kEEC0VGGca8iV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6oRiiLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0Wl2Q004642;
	Tue, 30 Jan 2024 01:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8K1+dfHj1nJUjH1pEWFiTJt/Z0VqsrMp8aF/CE2hzQo=; b=X6
	oRiiLZQGQzHxHSmH3jvWZ65Ksc4dBwPLzafz3PEUEOnBVU6IoXE+1+QXRo07q49I
	FExFTpbM2HD9UY8iMPE2TpBAtooIGtOvHTBfMhQ1Xt+zWs/+gE0EMOcUNNp8LRiY
	74u8oexDmGyL59Ik+3RQFwFNMYJm5Y6gHlx296JK3TWvBuqIPh8ZpJNBxWSLNw8Y
	F4xjLN8TeCiy9JwDujV47ZMlc9EBz0sxG9IAUzZcJW27sSLqgD56l64u5k0bjswP
	Xca6jdCt9aVX8AS5alCEicT67JCvEhzg+2QZjlqKlEKVaMZO8NaAzXfjihpIB3Ja
	Y2IfHSILLO2qkMkv5h8Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htan9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:14:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1EQSY012628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:14:26 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:14:26 -0800
Message-ID: <153c2f4f-8caa-4d76-9d05-a0ee443fb274@quicinc.com>
Date: Mon, 29 Jan 2024 17:14:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] wifi: cfg80211: send link id in channel_switch ops
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-2-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129052832.905113-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 02f7rAJf8mzJ1LJiIcN3hYhShquTPJha
X-Proofpoint-GUID: 02f7rAJf8mzJ1LJiIcN3hYhShquTPJha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=817
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300007

On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
> --- a/net/wireless/trace.h
> +++ b/net/wireless/trace.h
> @@ -2341,11 +2342,13 @@ TRACE_EVENT(rdev_channel_switch,
>  			memcpy(__get_dynamic_array(pres_ofs),
>  			       params->counter_offsets_presp,
>  			       params->n_counter_offsets_presp * sizeof(u16));
> +		__entry->link_id = params->link_id;
>  	),
>  	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
> -		  ", block_tx: %d, count: %u, radar_required: %d",
> +		  ", block_tx: %d, count: %u, radar_required: %d link_id: %d",

nit s/%d link_id/%d, link_id/

>  		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
> -		  __entry->block_tx, __entry->count, __entry->radar_required)
> +		  __entry->block_tx, __entry->count, __entry->radar_required,
> +		  __entry->link_id)
>  );
>  
>  TRACE_EVENT(rdev_set_qos_map,


