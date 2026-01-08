Return-Path: <linux-wireless+bounces-30517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52037D01262
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 06:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9B5300DA6F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 05:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC833176E3;
	Thu,  8 Jan 2026 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPZ5lWCG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1Wl1mds"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81943315D47
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850468; cv=none; b=kuoTMQ52qbmuOq3W/IbUy+71Q1lSnq8KPyztoGa/+3pi1Cop/kCtfbCiPKChjdizZp1YixwSMyzn0pHzZQT8sISkABIhHv6/2FB0uy6AN8Iw5gsRd7GZkTSWJUVSrFAos7lfQ8okaSesncqy8fT/7ampVDVGAJhA1GQ+p8BA1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850468; c=relaxed/simple;
	bh=uaqlTPp/8KTPG3ef4O80xQjj2YN1sWpWHxKpKJ85omI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq4yZS877NJ4AfS20i6FHVQzLjuwI6L708PYGcub69Zpqb3wUKWVZT+QjiWFU9VvIx5kW/YFE/F9qmnGTi1M1ky5C1VB1p8WJSPDp2XS3IFanjIyCl6Tk1/Ee8/OwvEWzNN00VkC7iS5gYUXcxaVH2OBrQKo9ShzmCI4dEx58Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPZ5lWCG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1Wl1mds; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6083xbLl3752247
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 05:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slLn6K+KnTPN5Uck4oM5JY9fSY7YWNgrkn0AkTxdWS4=; b=MPZ5lWCGXRjgU9op
	qBGFTCYw2j7wDtZP5dcyi4NQmZwuWbeK6SQjCgUzcqodUqmH7pE57vSmlTwWB0LH
	rrgAlGuJICBO7euoCaCS+aLnQuQxF2oIMmQmqnK2suzPrRd8Uopv8IVxVK7Rn4de
	euuvv9cGHTMWAVzqaJ6hv3qrC4UgGvXdpNMyw5jZffUiKgxR0DZVZMiEFV+97FuE
	5mKynC+FHyl09cU8zbPfRBP30RyH4NkQb3iEsKdAqwY5KErOJnrRJkj8X+m9yGvV
	+Fhuu+DrqEdi/qf3Q0itL/VxBc1UnlupodFFW3hj55AquuwYHA0ZPQHwvJt0kb/S
	wq5ecA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuxcsypv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 05:34:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so1279389b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 21:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767850464; x=1768455264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slLn6K+KnTPN5Uck4oM5JY9fSY7YWNgrkn0AkTxdWS4=;
        b=O1Wl1mdsypMmd2eCa7UPI1VZLesez3XRhGGbmwXZ55JXAJV6zigs58szeo92CnhABB
         vv/efQNsxcbNcrE8rDBOIu6ZzjUo0bCKN17j6o+nAb6g6Doz2B6Jss3x2MpfIVX+2pQP
         0aP04O/oecMOLuTxxuffIWj/+QdTD7XMzBKtkobvbJHhnaCA9Qd0V/ynC15c3IMr4YZ3
         0bf/1ZWFBzsSO7iqxTgBl9hW3bu2R6IqSA1WgLvRcMcnw3VsXxGs1Y60u5hCaVmxU/h8
         TfTZzkFFFgr0a9Ht8U8712JoVNFtu8ZzIpIQgYygzJNzw0L8EIL2WCsHAv309oE71T5s
         mcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767850464; x=1768455264;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slLn6K+KnTPN5Uck4oM5JY9fSY7YWNgrkn0AkTxdWS4=;
        b=OOPpncgT0gDE9d785+UeySuNbbpmG9abZmN85HBF+pdZIJihuUoW8fXo9Cbcyfu4v+
         XnMdreydav30LlcTMxA0RmZOFmT0GjBJjgoGapregonoSfoXm6GoAfDp877oS7CX6o3I
         y7/HHCSoMBt7ze3D+JeQ2RArA5A6tC7tlkfsjG2OGqXA20vH5cIU2Xl/DqDFTNb8POM/
         p2nWnB0vZwKkoNI3QinXZMRtvyNUrPcL9oAqJIqBNAjfVVVfQQwF7IFyhGN6PZALJVUm
         ICWeOsS+sJrlKdIlGDtsILBCZcFgcgQE32XEwKK8FyHDdT92r4WqM+Cfyt7kH2l9WQ/h
         oybA==
X-Gm-Message-State: AOJu0YwVMByJO122/3kyx7gKYQOp6tWElELsICgdr2AfozQhMKEFrRb3
	Msc+X4K/r5/DsbQYjgW6e33PW+XcdF1GWeyDxFBpuiFDnaqr6na8qh+dMA24TD5GVlsFmezdb8n
	jTMiYbd7UbFu8XlKJRZa/2glTZMTGNXQw2blal5mqqlqPVfD9IpfA2gzxehDM3D6qA0qKXQ==
X-Gm-Gg: AY/fxX40n/h+WWyddW25xweri4NGSBaknomyqpyR2AexyET0veodkrgh79jSTxcLWId
	4/7z9zB6D7ocy3G5NPSL6ABNnx3hIoJZkUjCvVNEXv9oTixEaFEcDIZqjOAcUBZmOBhGNTnZATP
	WLnudjFaR1TzdaNYnhQdQFBeJcjGAXukfkzC+sGQLtVI6yPXsODNCPm+dzsvDHje3ih/m70/C1h
	UZb98e86OxOfRgGDFt7NFxyTiJeR0T/WEUWh0fJOaO7XQ7xBLxq7rIfwlzSgazIFfSRh+sJ1bzC
	bl4rC4ooqJ5XB7ybMK0sDC6YIvUOMGRYIC2BaE8VGpovrG0i/uZ9s4PN8R4U8Etc55aTNubeLSG
	meb/EexqqWZ6kIlZfTZXa78AkaiBC9QJSge/DVXm5b0zkbpl4jXJb9WKu0vubR+deMBmIZbeG33
	WmmkzmbwE=
X-Received: by 2002:a05:6a00:428e:b0:7f0:ead9:578 with SMTP id d2e1a72fcca58-81b7d260595mr4207061b3a.2.1767850464294;
        Wed, 07 Jan 2026 21:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvjKoMC4OVaPaZGA0PL5yN0sag4muDj4ni/96sAYrVTUGqph6n4D71VQxoz3vXbranFXLKMg==
X-Received: by 2002:a05:6a00:428e:b0:7f0:ead9:578 with SMTP id d2e1a72fcca58-81b7d260595mr4207030b3a.2.1767850463794;
        Wed, 07 Jan 2026 21:34:23 -0800 (PST)
Received: from [10.133.33.194] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8e10sm6428184b3a.44.2026.01.07.21.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 21:34:23 -0800 (PST)
Message-ID: <5b264207-de1e-4f76-a0f9-6b4d0d6f68f2@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 13:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath11k: Fix failure to connect to a 6
 GHz AP
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260108034607.812885-1-qian.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260108034607.812885-1-qian.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAzMyBTYWx0ZWRfX9E7BLm3JMZ17
 eqft+qLte2tJeKRcicrshYALM8THJjkuebQRY6d/RheDvqtmnOabQRqbx5zETRAeipb3SMqJzP+
 yCP8uMYjOflLf4gS6C4bjjNajyntY+pt5YKBIwJh9Trc/e+oDw7lGmMcZfGRTjoHbedrOx25bid
 z/dfUk+Bok7QC3HdOt+Urp9QDqb7AbABcUVsFVfq51xhtG3Fbt7A6vgt61ytqO3Mcb3YTxL+UbD
 jDMtdCw1pQe5ER3/ioa+Ytg48Ydao/TJK3ZgJLgNhn5qC01Y1wgoWs38abeGOoV2sXWHtr44ALH
 v7OWfFDNPi0uz2yPRYJ3Dp+433QgK1yeCgvyUMpaN02nvr30dAj9BjuHqsuoACHXH8k75t/h6EZ
 gprqGUUu0RTTQAejdWmSpPlxKugRDXSZq4gwCHlMWHC83DIAuyaOzKYS1kw1fcj6vH9Y1+MCf7C
 8dWNztv6SjrvZIpMKqA==
X-Proofpoint-ORIG-GUID: 28QI7RZM7O2FTU3h3ZJG6VOODbhM8AEy
X-Authority-Analysis: v=2.4 cv=SPdPlevH c=1 sm=1 tr=0 ts=695f41e1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PKyBAWt5R5Rl1cvDm-IA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 28QI7RZM7O2FTU3h3ZJG6VOODbhM8AEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080033



On 1/8/2026 11:46 AM, Qian Zhang wrote:
> STA fails to connect to a 6 GHz AP with the following errors:
>  ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
>  wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reason: 3=DEAUTH_LEAVING)
> 
> ath11k_reg_handle_chan_list() treats the update as redundant and
> returns -EINVAL. That causes the connection attempt to fail.
> 
> Avoid unnecessary validation during association. Apply the regulatory
> redundant check only when the power type is IEEE80211_REG_UNSET_AP,
> which only occurs during core initialization.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> ---
> Changes in v2:
> - only return in IEEE80211_REG_UNSET_AP cases
> ---
>  drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
> index d62a2014315a..49b79648752c 100644
> --- a/drivers/net/wireless/ath/ath11k/reg.c
> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  #include <linux/rtnetlink.h>
>  
> @@ -926,8 +926,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
>  	 */
>  	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
>  	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
> -		    (char *)reg_info->alpha2, 2))
> -		goto retfail;
> +		    (char *)reg_info->alpha2, 2) &&
> +	    power_type == IEEE80211_REG_UNSET_AP) {
> +		ath11k_reg_reset_info(reg_info);
> +		return 0;
> +	}
>  
>  	/* Intersect new rules with default regd if a new country setting was
>  	 * requested, i.e a default regd was already set during initialization
> 
> base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


