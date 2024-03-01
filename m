Return-Path: <linux-wireless+bounces-4285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4B86D96D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E74A1F221D3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D913A1DC;
	Fri,  1 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FF3GkalG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2263A1D3
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259188; cv=none; b=GOmpGEppRqp7sowziDSVow8rFxibT5gsZw83teq0MRQLmoHp+lNraydL3EemYF3j//TuEni4fbPpwfIoSqJDKaF6TFDFXSQ1ej59/E4UwYGMLriI3YPywOVOzzgdq1lPyRu+Tn2DkIsNneYS1dM2+UK3vymFn3wt6BHWgYcafQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259188; c=relaxed/simple;
	bh=pzYHl6HB6pbfpEZsuyWfmd/4ElgmU70a6Zcn7gAQcis=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOgLMr+3YrrrNeVV5ZZAmolb5aLVXYzWSmKgCxPRklE2D2SgjRPHRdfjK/ygD2bJarMO+g57paCPkBZeH4kGLwTav1hrB+OmJ5ZYKZ2BnoepxM/aT6m+finFF7LdVgNBdfEaDHmFE13ag2HeTZNCdklRw2P2nI3MKWJAwElR8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FF3GkalG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4210kc0S020781;
	Fri, 1 Mar 2024 02:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DTdjKzfF+wLCw2HEeowzvC/2ioh+ybgSCMwH90VAiMQ=; b=FF
	3GkalGOKJ3+tjg4sbnttvuQCz8gb9tPqXD/4AlX01eObxCGvQ8j2utW91GxbRd1q
	hAo9XwzrKEBuRqZdVSiDFqDsJha+/dM6PY+F+1egSIkjuOhxPOlMukoIHpqIO7TD
	LUz8SB6htbn5qMoD9IOexO7YdgeiprqcV+8OmxBu8LKrqX/Wo+HkzPlj+0VfVyDW
	ybdi39au0PQ/UevG+qsDMEQClAsbgiHBkVu8XXE22SQA8uTSJD1EHB7TO5cQKIWo
	z3rTXdb4D4107sfyzTgBiPw7ElqbJDcjOOKrdZPaX8LFD7twAszex3XO4Byvjmci
	ozWbDAc47XKvpM09q04A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk4rvr66r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:13:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4212D1cl011827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 02:13:01 GMT
Received: from [10.253.10.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 18:12:59 -0800
Message-ID: <8014cab6-8d8e-4c9c-98ea-fe0567e0e578@quicinc.com>
Date: Fri, 1 Mar 2024 10:12:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] wifi: ath11k: P2P support for
 QCA6390/WCN6855/QCA2066
To: <ath11k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20240228093537.25052-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3BvrH0bvawuGzRhoL-oRxcBmbOdoyzyx
X-Proofpoint-GUID: 3BvrH0bvawuGzRhoL-oRxcBmbOdoyzyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403010017

Hi，jeff, this is 2nd version of P2P for ath11k, could you please review 
them?

On 2/28/2024 5:35 PM, Kang Yang wrote:
> Add P2P support for QCA6390/WCN6855/QCA2066.
> 
> v2:
>      1. patch #1, #4 and #6 have already been acked by Jeff.
>      2. patch #2: remove unnecessary initializer in
> ath11k_mac_setup_bcn_p2p_ie() and change judgement for P2P GO.
>      3. patch #3: verify the validity of descriptors number and remove
> blank line.
>      4. patch #5: change scan flag filter before
> ath11k_wmi_send_scan_start_cmd().
> 
> Kang Yang (6):
>    wifi: ath11k: change interface combination for P2P mode
>    wifi: ath11k: add P2P IE in beacon template
>    wifi: ath11k: implement handling of P2P NoA event
>    wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>    wifi: ath11k: change scan flag scan_f_filter_prb_req for
>      QCA6390/WCN6855/QCA2066
>    wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
> 
>   drivers/net/wireless/ath/ath11k/Makefile |   3 +-
>   drivers/net/wireless/ath/ath11k/core.c   |  20 ++-
>   drivers/net/wireless/ath/ath11k/mac.c    | 166 ++++++++++++++++++-----
>   drivers/net/wireless/ath/ath11k/p2p.c    | 149 ++++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/p2p.h    |  22 +++
>   drivers/net/wireless/ath/ath11k/wmi.c    | 107 ++++++++++++++-
>   drivers/net/wireless/ath/ath11k/wmi.h    |  42 +++++-
>   7 files changed, 471 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
>   create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h
> 
> 
> base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11

