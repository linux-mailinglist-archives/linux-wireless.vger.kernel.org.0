Return-Path: <linux-wireless+bounces-20877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FEA72896
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5A3BC13D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DD71805B;
	Thu, 27 Mar 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpHUelQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC4DDD3
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041079; cv=none; b=FNm+YqEDhuezIvGyepI9tHBI755EVIi/ltvZyxEXZMGy0d6wzv5tl79rDqrZSrT1IPpRTCWGfxSdDmNvJwNrRUyncJmXpStsA+AapvZc64b26q5wNab17Gng3/y2rATks/g9SSrNw5XJ+mZWh8er7DLAJPzwZdJZQl5rizAZB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041079; c=relaxed/simple;
	bh=PE5rGx1LhdfTbEiS7kKEEIxAJZR7vgxa8ErH95NU28g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SScktbema/jlKuStRa8sxGkkWKa3w8iJuC45EJyuho9tmmiEBm4GMAknkfEm41YWZ6VHqXbYNPP2JoxNis8fOey7EsDZ21gV1dffVrefyQo3efWwrzhHscDPEBhq1ICUxYbn0BASsoOWBySCjPa1eekeUDzD4yyEbVr19GHBOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpHUelQL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFJ7qC026884;
	Thu, 27 Mar 2025 02:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N/G/w3CJLwc0q/Ca5b4z7XkmPdahR0r8Ke2p51GD9jY=; b=jpHUelQLS2gfp/ap
	yc0gFSnO2dO3wSY1Mh6CHS79+iQQmwal0XmjdI0YuTfh5qRezC3O5p3liRRalXgE
	8V4gaoiRBphgR3wrO30ROj9mFWFn1qtJV2Z+/v2BzCsS5s7WrO8erZKgOKfepuE4
	qpX/cD1T9zDqGMq1Lq6RCEtCslfxZwrPFma8ZWqzrKovC+BDxjlb0twkqHE0p9M9
	MiTmQEQFiyGCu2MM+/SqIMLZBzmP1Uupp5UnYmK4wwRb9lwcUuEODbYgnfWzfZ5C
	UwNCV0IJuTvZmTJcjtye46rfyHj9TIM7XcoZ88Gi3WB8G1BlfLXK2dzoAcNbJ9eA
	NU4kAA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m0xdvjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:04:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R24Wh2015682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:04:32 GMT
Received: from [10.133.33.100] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 19:04:31 -0700
Message-ID: <719a9ae3-fc24-47e8-b3ef-1037900d148a@quicinc.com>
Date: Thu, 27 Mar 2025 10:04:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/4] wifi: ath12k: add 11d scan offload support and
 handle country code for WCN7850
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250327015546.1501-1-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20250327015546.1501-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lsnnVf0H11plmc9oUH_yGMnjAMd23GiQ
X-Proofpoint-GUID: lsnnVf0H11plmc9oUH_yGMnjAMd23GiQ
X-Authority-Analysis: v=2.4 cv=Q43S452a c=1 sm=1 tr=0 ts=67e4b231 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=uhMqMWLRpLrNCD56NxgA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270012



On 3/27/2025 9:55 AM, Kang Yang wrote:
> This patch-set mainly does four things:
> 1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
> 2. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
> 3. Implement 11d scan offload, and update new channel list to firmware
> when 11d scan finished.
> 4. Store country code, and update it to firmware after device recovery.
> 
> With this patch-set, WCN7850 can do 11d offload scan and update country
> code to firmware successfully.
> 
> Note: This patch-set is an old patch-set in public review written by
> Wen Gong. Just resend it for him.
> Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/
> 
> v13: rebase on tag: ath/main(ath-202503251458).

Forget the branch tag, please ignore this version.


> v12:
>      1. add reviewed-by tag.
>      2. add branch tag.
>      3. rebase on tag: ath-202503172347.
> v11:
>      1. swap the order of patch #2 and #3.
>      2. rebase on tag:ath/main(ath-202502181756).
> v10: rebase on tag: ath/main(ath-202502111625).
> v9: update copy right in patch #1, #2, #3.
> v8: rebase on tag: ath/main(ath-202501172342).
> v7:
>      1. rebase on tag: ath/main(ath-202412191756).
>      2. rewrite commit message for patch#2.
> v6: rebase on tag: ath/main(ath-202410161539).
> v5: rebase on tag: ath/main(ath-202410111606).
> v4: rebase on tag: ath-202410072115.
> v3:
>      1. use wiphy::mtx lock instead of adding a new lock(patch#2).
>      2. rename struct according to wmi naming convention(patch#1, #2).
>      3. update copyright in reg.h
>      4. modifiy patch#3, #4 due to struct name change.
> v2: change per Jeff.
>      1. change alpha2 length from 3 to 2.
>      2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
> 
> Wen Gong (4):
>    wifi: ath12k: add configure country code for WCN7850
>    wifi: ath12k: use correct WMI command to set country code for WCN7850
>    wifi: ath12k: add 11d scan offload support
>    wifi: ath12k: store and send country code to firmware after recovery
> 
>   drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
>   drivers/net/wireless/ath/ath12k/core.h |  17 +++
>   drivers/net/wireless/ath/ath12k/hw.c   |   6 +
>   drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
>   drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
>   drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
>   drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
>   10 files changed, 480 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 11cea2b6a2e3a5ddf3562314d1a378e7ea1c26eb


