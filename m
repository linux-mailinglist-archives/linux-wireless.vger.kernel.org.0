Return-Path: <linux-wireless+bounces-24568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C90AEA461
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53DD1889D35
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B025A2CF;
	Thu, 26 Jun 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lCSGG+F/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48004215175
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958663; cv=none; b=GrQM+gAibNAi1XGXf4zw1Eqgy635ebV5CnByAs4bKHrCZM4qRTCN9+JT5smrb3mexOt3pXqZyo87B/+kLcIgZ7kGePaVxn53ORHefkm27ZYCc7uSK1DLy1zzka1rgjaa6sHtnRo/44LXDNCWQkDLD+du9Gw+jrUHVwMWfRqYEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958663; c=relaxed/simple;
	bh=aQ6J0TyqPbSq/BrViwwyCrztVepM0hXHydL4alY5+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=moXLdkaRzh1CWfxTPjgf/K71ULurRHBLxjSH7U4Av8epn4SKtxMq1bdSPUMIshcrPdc8cejKmHx66TXpFtDvrrxeXAL1zbBnLB2rfhgWvWT0Ede52MP/JQDFN+Hn5Zki4aHXkhJo4zSN40wSeo8OqBTc/KMsthymiPtXYG3tnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lCSGG+F/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9UFDK026643;
	Thu, 26 Jun 2025 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5dr6TvuI3dg5mwfS1TqhKy7UB0zjUv4LQeJ0SMajz7E=; b=lCSGG+F/MRHiZJk/
	RXO1voX3A+bF+B1saA9RHuthFU+QoIo125HuwpMHTxKntrHJkFGik/jmqnuaqUJB
	O3VmAgtlw0X184Sz6db85wjKtdFlTgS2iIS3QSDjLq5UKCM6OgJ8O8MDN2l2mEmW
	r8IMZHoBwIPmjD9afZYFoYaZeCIn5UzcLBb6FRnNtMs0wj5tBIuBk4OFgNb5Sgph
	LvJWRw1teoeBFQT3/xndc3z8md4Rx+4Ee3JdgXYHX16RLnvZO39DYrbzyj6hfTqO
	wK+SbUyu0R0XBA/JjNj5ydjt34FDf55oOOv+R0tC3nEWaFE9BVZQBu7GFQfaW33+
	VFlumA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5wa62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 17:24:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55QHODjK019146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 17:24:13 GMT
Received: from [10.216.56.23] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Jun
 2025 10:24:11 -0700
Message-ID: <e71c733b-0f0b-58f7-d881-301e7aa60df4@quicinc.com>
Date: Thu, 26 Jun 2025 22:54:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Support TDMA, MLO, RTT stats
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5G3mk_zUOE2kYOtkP9Ujb3qe4KPqOIpq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0OCBTYWx0ZWRfX8e5DH2XknED2
 JRUJbFve5MX3+yMfJmuAdsUszjlPuq9osafz3qtFqJ4e/TyebXdDn0uCywYY57CVYgsj0Gmqg3x
 XnlcByQck8aHTX+neRct/D/lEwBdWO1kvzxuxmVZ+PQfw/9kfMU9wpSztN8b9wttpYsstDNeJDn
 r9azW1aJriXPWO1L1uDyfJo6X2xLGutZ0tKOCULdCA2QCVza1dHRmyQ0oR7wnSR9+xsa3pbdJQM
 vt4fWPLSY4vgQdMh4ketdRamTj/Q40Ra76I2k/j7ZN/b/o3Wu+OHVrOpo5fILl3aOc94rUJ/9QF
 /wJ2UztVXDxY2g36QihcW+OfnXjnPBGsKAyQvzqTTREz13I2dJl+GleNHpVNTdKuio1AqAS/LlD
 GZGbeXtS370jghMiKB5krQSDZL08JW9QS1vteUSth8namQ1ZgcN3dF6yiqesFPLF88cPc6o7
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685d823d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=PERqVRO3yxHNNTxRS38A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5G3mk_zUOE2kYOtkP9Ujb3qe4KPqOIpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=852 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260148



On 6/17/2025 10:41 AM, Roopni Devanathan wrote:
> Add support to request HTT stats type 57, 63, 64, 65 and 66 from
> firmware. These stats give TDMA stats, MLO scheduled stats, MLO IPC
> stats, RTT response stats and RTT initiator stats, respectively.
> 
> Maharaja Kennadyrajan (2):
>    wifi: ath12k: Add support to TDMA and MLO stats
>    wifi: ath12k: Add support to RTT stats
> 
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 516 ++++++++++++++++++
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 185 +++++++
>   2 files changed, 701 insertions(+)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

