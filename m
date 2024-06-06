Return-Path: <linux-wireless+bounces-8596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7536A8FDF79
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E91282360
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F413BC20;
	Thu,  6 Jun 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fEkQFZOG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AB13791C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658456; cv=none; b=AXotmFmfS0Kf1Bigo3tb2Xt1J3w7kLBxWj75S0OoYpMfz7AdATO0g2T65ZnB4rsUSNB0+TL8VWT7AgFIOvlLgzwb2LSOhi+OpUjCziYwax/I1aqf/ew+nzu10bbHTICZHzj0yFHZ9EJHaGuzwJLhwAP7nGmMeZJEG1t+IulC+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658456; c=relaxed/simple;
	bh=aF1cdUAfygdFhOMLNBchQhDCdq6IcTc0RYJwU2MiC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YBGZzsrbOS8HKtkqqyDsIdUO4Fr/NM79O73JN9ra93RFCFMNtMgJRIocmTIcLHp3RsGfrQAfOYs+nm8U4dt5alVvqJs+w9jBfbiTDu2Z6rC7E4rojadd+PsmE3M4SNIESYUTWpbpx7H6oRhlPazLTa1x5bC8o1yfk2YiyroAiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fEkQFZOG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455LVaH4031023;
	Thu, 6 Jun 2024 07:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blH4rmlIZKgD+flmTPdfc8iYLufCZXA/oIlAY0wjpSg=; b=fEkQFZOGtFz+sE5b
	f4kmFzqkBLgCQzZIlOqKiZU9epewGB5nc0nb0JI1eH/7h3rmnuZDSfyFaJ1xdsuZ
	EZr3AeEANJKFbkIRaIuQpS7M9V7v31rWzd+QGWFyttr4AFXqPU2QPdleMXE6bNzu
	MFdYXl/09QlmZeQhOYwFFWx6zX24gDDkuqs/kYxJYSxatLdo44370ua1Hp5WLqKQ
	Kbo3SM7RoL8ysZxu2R9ITUwCLs7aAzoNB3sua3FdgxRchunUxm83G0pkzpeMzN0R
	iM0DLxQag8K2fAOSRHRVeYMPqOR9tU/GRXDRc4w3QdvXWKc0WEORt1IUFaDSZFy4
	8mTn+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rm4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 07:20:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4567KNuR009169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 07:20:23 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 00:20:21 -0700
Message-ID: <8add7134-9929-0288-0770-7778013cc37c@quicinc.com>
Date: Thu, 6 Jun 2024 12:50:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 3/7] wifi: cfg80211: extend interface combination check
 for multi-radio
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
 <8fc2f117346fcb4ed11bb20cdf9cb1f88bcf64b4.1717611760.git-series.nbd@nbd.name>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <8fc2f117346fcb4ed11bb20cdf9cb1f88bcf64b4.1717611760.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZWK0g9ZB2USXpoWtu9HG34Pz4cnSvFCj
X-Proofpoint-ORIG-GUID: ZWK0g9ZB2USXpoWtu9HG34Pz4cnSvFCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 mlxlogscore=959 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060053



On 6/6/2024 12:01 AM, Felix Fietkau wrote:
>   
>   	/*
>   	 * This is a bit strange, since the iteration used to rely only on
> @@ -2384,8 +2383,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
>   	 * cfg80211 already - the only thing not would appear to be any new
>   	 * interfaces (while being brought up) and channel/radar data.
>   	 */
> -	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
> -				   &beacon_int_gcd, &beacon_int_different);
> +	if (!radio)
> +			cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
> +						   &beacon_int_gcd,
> +						   &beacon_int_different);
>   

Why its avoid for radio specific iface combination ?


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

