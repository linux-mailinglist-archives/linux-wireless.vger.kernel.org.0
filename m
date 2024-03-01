Return-Path: <linux-wireless+bounces-4296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB0586E516
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2176FB23E13
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86B6E2A3;
	Fri,  1 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bG5ygqzj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BF71B2B
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309790; cv=none; b=Mmp5sYS1h/PzFHK85rlW/j8D14GrAXzyU8l00v8g68DG5mhOTtzKFObf/bTYqQGt5mXQqSDfl1YakWHzAhjvR2WNNJw4NJammhDFiE1Ttr50BRlTKctId6EfQonFjAxrrKC7AFGexaT8L2Ynkj9j7/ZBQrOFd4E42xdKPUkjozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309790; c=relaxed/simple;
	bh=DcKb6DOVih7XxWhZcOlWGPemOOwfrQQ0BnIqEvl6sKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h1X+4BChtC7hkNaNbqA3nKWnGprExPmS8dBzXzgYsbAw47tGhBwakKb/ShxcjOvM8SxkV5qD/xu7dFHLSExzuXAdtL0aYm4NjdP92/zUZEamhQli+TmzRNguZflw6TLkNSV/+IbZLEwncOrFWCzeCkfag97AR0khDHnEKixUKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bG5ygqzj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421B1LP3023563;
	Fri, 1 Mar 2024 16:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P9oSbjYVwwJViyUns6YHVbiAEOcSyvonOUoUVWmngIM=; b=bG
	5ygqzjSrP3tQctJO7k8jkDe/SqI7BGpb7WxC3jv5dLahF1+RR6UPuK6u/nS3E0t5
	3n71gKIOjfvMvSAJupo3VXM0b4oXBeGA0s9vBJu0I7mLzTPL3SmqFM/5oge1CxBF
	aKpKBPRYbomP95MIbUG+6YNDQS0jPTu4i9ux//rNmOD6xUgqqMksumWGqSklYXEE
	xHb4CH1ogq1jTJs+Og4JkeYfqcTLiIKJTrwQAw4D0BwsI16xSO7rdzN1/LxjpRWR
	L06nDaXuxgG7KA0n53DJMaIrEcES+tcw7KGML5GkihwbvpNoovUYIXnkhBJvKvvy
	mP0URZ2X5raYPFyrmVdw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk9mf1cvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 16:16:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421GGHa7015847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 16:16:17 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 08:16:17 -0800
Message-ID: <6bdcffce-e657-4990-bd60-5dd67abbb9c9@quicinc.com>
Date: Fri, 1 Mar 2024 08:16:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: adjust a comment to reflect reality
Content-Language: en-US
To: Kevin Lo <kevlo@kevlo.org>, <ath11k@lists.infradead.org>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <Zd1Muyd8mtA1Hih7@ns.kevlo.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <Zd1Muyd8mtA1Hih7@ns.kevlo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H6N7GW0bgFRtuYB6wISkgmCb7NRoJ7Et
X-Proofpoint-GUID: H6N7GW0bgFRtuYB6wISkgmCb7NRoJ7Et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=896 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010135

On 2/26/2024 6:45 PM, Kevin Lo wrote:
> In ath11k_mhi_set_mhictrl_reset(), I observed on QCA6390/QCN9074/WCN6855,
> MHISTATUS has SYSERR bit always been set after SOC_GLOBAL_RESET.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> ---
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index 3de7fa6f88d0..1198e80d9dff 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -158,8 +158,8 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
>  
>  	ath11k_dbg(ab, ATH11K_DBG_PCI, "mhistatus 0x%x\n", val);
>  
> -	/* Observed on QCA6390 that after SOC_GLOBAL_RESET, MHISTATUS
> -	 * has SYSERR bit set and thus need to set MHICTRL_RESET
> +	/* After SOC_GLOBAL_RESET, MHISTATUS has SYSERR bit
> +	 * always been set and thus need to set MHICTRL_RESET
>  	 * to clear SYSERR.
>  	 */
>  	ath11k_pcic_write32(ab, MHICTRL, MHICTRL_RESET_MASK);

Unless you've verified this is always true for every supported chipset
I'd rather more accurately say something like:
After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set and thus...

