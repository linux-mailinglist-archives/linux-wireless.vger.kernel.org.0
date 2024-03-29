Return-Path: <linux-wireless+bounces-5595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC7D89228D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F831288F82
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7D4A0A;
	Fri, 29 Mar 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i6Y74N6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560F136E01
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732619; cv=none; b=gthDLqBwei4M0iLaCZTI24rj91LUGweamHuIpx5/yaZ9/M8BKBO9D5nFTJCMXxm2g9o+g2MkhK1VbZshBfst4+F3cDaHT5vFg7GRdNtn+ePvOQdaE6y7T5ZSnqjC3zI/yRdVbGJOgkZ5BEFlVEfUMk0sRf5TZZFXNh2D7UlTXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732619; c=relaxed/simple;
	bh=DQSzgd94oE53GhaFbwRZlzQIYRholcveRXNvDe5F+lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZxHiKMQl8uLMlAxLkH9Vw1+OlOMfHoD+K7eZN4qPf9FcrgwXO4/l1VLuKik80NQZC+5RhjN6qCPy+88vwboFVpEt03NiznE1OjBtLV/nKGb5rsmIBT/kAiLvdSkuUN5GwSEwzLEquADyo5j7nn/1ZwbCCM7NgVJO9nT+p4kpftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i6Y74N6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TDJPjo024490;
	Fri, 29 Mar 2024 17:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qUGe/je11apyofF7iCHMt2ObxxYCF3zOIbf+iCrEnJk=; b=i6
	Y74N6qcRaO4UZ3bT6BL8Z4omARrBHVbSB5TEvJUi5lcNHt83lNL4gGT5hdEcVker
	MLnLHtwMpLr9YIphrfyueVkVaGc9gJ7DPM4lHIRpGOrYUR9iu6rQmC+BdXjb2ohA
	HUhz7QbvB5/k3pJcJqxr5tgkHFom4rFGLka/DZ7bCvbp1JH4uCW6s8QIOjkW1uk7
	/1ZnVb4LcguIm8dvB5Pe/w7AkMbF13YO/HYZDHTuL8Eh2GtQZc+uWIymQLYtDiOI
	Xtv5L1nbZwiKZ9iAl6gZegOQ7TtKNW/O30RzLlkbhLS+Ix3SX4kHTv/lal8NGV2Z
	Hawq3VeCHfRFu0qmNM6w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5xcy0g2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:16:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THGsdo012165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:16:54 GMT
Received: from [10.50.15.209] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:16:52 -0700
Message-ID: <1ff49b19-e2e3-4415-b9e1-f9c1f793f89c@quicinc.com>
Date: Fri, 29 Mar 2024 22:46:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands to
 support MLD link removal offload
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <20240328055235.3034174-2-quic_mdharane@quicinc.com>
 <ab738886-f7e3-43ab-8615-2164e8414786@quicinc.com>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <ab738886-f7e3-43ab-8615-2164e8414786@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2QfiwQ9dnDRbrzCDIy6FWBzlmRh6jEk_
X-Proofpoint-ORIG-GUID: 2QfiwQ9dnDRbrzCDIy6FWBzlmRh6jEk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=955 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290152



On 3/29/2024 2:32 AM, Jeff Johnson wrote:
> On 3/27/2024 10:52 PM, Manish Dharanenthiran wrote:
> [...]
>> +/**
>> + * cfg80211_update_link_reconfig_remove_status - Inform userspace about
>> + *	the removal status of link which is scheduled for removal
>> + * @dev: the device on which the operation is requested
>> + * @link_id: Link which is undergoing removal
>> + * @tbtt_count: Current tbtt_count to be updated.
>> + * @tsf: Beacon's timestamp value
>> + * @status: Inform started or completed action to userspace based on the value
> 
> kernel-doc warns:
> 
> include/net/cfg80211.h:9573: warning: Function parameter or struct member 'action' not described in 'cfg80211_update_link_reconfig_remove_status'
> include/net/cfg80211.h:9573: warning: Excess function parameter 'status' description in 'cfg80211_update_link_reconfig_remove_status'
> 
> /jeff

Will address that in the upcoming version.
Is there any way to run this locally similar to checkpatch? so that we 
will make sure check this as well before sending to community in 
upcoming patches.

Regards
Manish Dharanenthiran

