Return-Path: <linux-wireless+bounces-3405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FC84FB3F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988E22877EB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742C7E59F;
	Fri,  9 Feb 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OGYqB2vq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE67BB16
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500848; cv=none; b=DoNSr91RM0ZrYtCeEb4wCN21QGDYgqULQ2wC0P0TEXoHKUyNVyvquo4pnoFPvCFYcegxJzCgFbuOxZcIZdNJ8MgY/S53QEAHuNhSUE6GnWy83ty5OjEw+AUltVtMyoNhyNeoyKTb7KKlIMcK57vedxoRHzBFqkYonjyRH/J+mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500848; c=relaxed/simple;
	bh=85EGQ/JFFdL5oLBjhnI/M/6LT8YTXmbsuDa3DzDmzdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fA54J9YXN2pkQqx/jRzYtjVk2VjDblXPFua+6PpvknWhk9MPgVTUByQJqk86ET0dSR8FAKWoLqnCeBgMYmhukagGe3h3QY89qo9R52NP/RvbQis9Dpj7Yr4POddU3+6fS/QIDOu9AobK/b562GuAnWMXAYk4YR/gUORZEEkKyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OGYqB2vq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419GsxWB031572;
	Fri, 9 Feb 2024 17:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7IjLCr72LHOycKWriKwle+9X3Z+1aqSjnHoRBVLlHDE=; b=OG
	YqB2vqkGH/zxZkCaaWPqpfqes10vVO3WEfoAWFa2/7FRtQQf07IPrl1k08gOfNIC
	9evWDB4I9hQmP7rGWbFQA+zPL8Kb7sVYC9YnKIyduZKi7VLk1crtK6qGHpuynjYg
	bV3DavhN4ynjUfU4dQFmt1cwAIVEmoy8u7RQIod67FrZHskCJA63nu2Tb4trMl3X
	FC5GZcnAasarUqLnhGd+XWf7vBnzYky01JhigSfI+q+evgiRV7PjA0L34TWxUjjf
	Zi2YNZXxoG4IAD2cMa6uM6npKPsCYK6CRGmXd5VQOrhR2z54vptwbmChBfP7B7oN
	5eLkuuzyK3Ey1tUNP1gA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5m158nt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 17:47:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419HlLKo001552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 17:47:21 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 09:47:21 -0800
Message-ID: <4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com>
Date: Fri, 9 Feb 2024 09:47:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240209113536.266822-1-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240209113536.266822-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xntW270-BVxw_8kxiqo4FNkSFDQmNYif
X-Proofpoint-ORIG-GUID: xntW270-BVxw_8kxiqo4FNkSFDQmNYif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_15,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=746 lowpriorityscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090128

On 2/9/2024 3:35 AM, Nicolas Escande wrote:
> As previously discussed in [1] we have a mismatch in struct scan_req_params
> between the bitfield scan_f_xxx & the scan_flags when used with WMI_SCAN_XXX
> values.
> 
> To fix the issue & prevent it from happenning again lets stop using & remove
> scan_flags altogether in the driver and only use the bitfield instead. That way
> even if the bitfield doesn't match the WMI_SCAN_XXX flags, the right value will
> still be sent through the wmi command to the firmware (see
> ath11k_wmi_copy_scan_event_cntrl_flags).
> 
> Questions:
>   - In the same rationale shouldn't we remove scan_events from the same struct ?

yes, scan_events is unused so it and the union+struct can be removed,
leaving just the u32 bitfield. feel free to submit that as a separate patch

>   - The same goes for ath12k, should I send a seperate patch or respin a v3 with
>     similar patches for ath12k ?

please send a separate series for ath12k since it has a separate mailing
list

> 
> [1] https://lore.kernel.org/all/20231127180559.1696041-1-nico.escande@gmail.com/
> 
> v2:
>   - remove explicit uses of scan_flags with WMI_SCAN_XXX flags
>   - remove the underlying union of scan_flags to only leave the bitfield
> 
> Nicolas Escande (2):
>   wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
>   wifi: ath11k: remove scan_flags union from struct scan_req_params
> 
>  drivers/net/wireless/ath/ath11k/mac.c |  6 +--
>  drivers/net/wireless/ath/ath11k/wmi.c |  2 +-
>  drivers/net/wireless/ath/ath11k/wmi.h | 55 ++++++++++++---------------
>  3 files changed, 29 insertions(+), 34 deletions(-)
> 

Thank you for this cleanup!

/jeff

