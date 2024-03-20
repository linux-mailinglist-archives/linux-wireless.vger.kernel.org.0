Return-Path: <linux-wireless+bounces-5062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45F881933
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAEA1F217DC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAA94F8B2;
	Wed, 20 Mar 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KcuJ7xRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92333062
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970554; cv=none; b=qc+vJ/EffjvwtPVQXjK3rpdvhq4sPcuyAd+EA9jpU4SoUeEiPtiIKpIht7SsNo0PP8YuhFdIG15g4CVLZz11OFhEtjU794wYDTuvjlJIx52BN5AosOwfB2+gRhMP2O59AlsOty35FcwsJl7jG5MWCGdnZJSTkXKQteiZl5ykqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970554; c=relaxed/simple;
	bh=fhJ4ZGJXcM73L3PttRW3qjYbctooGeudkVc8rUdiXYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k9npzWvOMYkE939w3g0Kl4FNCuOpILpe6CZOh97+EN1UQk7IGHVwqo8BpEPV5ONhnhN6yrVq2JaQNFT2jP0YW8rKdDMIysmbbFo9TBRvX2HmHeq24WK0s5IWXiXk/ZpNj1KKoolyG0e1RVepscsSQWxnkAJQei8PJVMlCGToCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KcuJ7xRk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KJ82pN005326;
	Wed, 20 Mar 2024 21:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cLWCmrKQpmzI/Bar2tJN0ed8F5UfwO5QNB0jLMmkcD0=; b=Kc
	uJ7xRkNyGi3h2JShujJmkcV4JkFTuDJCsRe0eXa26ikdpkXLRCre3j8LZUwvVTo3
	WX32UiTln86Wkle4jIZXBiT72t6j4QeFITn/0itZSU0yPUNS2WB2pa+5QYAD9ldH
	Hc7780i2o5eQsmqtvgH0AiQXhlr/i4ExqdTRB+MPrjgnKeecE4vRC2IRM2huntWf
	yZS5phSe2KFSk+IJ3oeFCBr+je6EjijIa74Cbbbht5VrKxNMmBR3ZTg+a7slFe7I
	qHFyzdY1pqbQrNjmHeQWSYibIfEAnPNF6HXQpN3qMgsyXtolsn/WMjKBkimbihsU
	2xCY0MVDfOeP0z8Jvuwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyyvdh9e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:35:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KLZnYb029315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:35:49 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 14:35:49 -0700
Message-ID: <cb9af1aa-d213-43b4-8ff3-bf984050a8b4@quicinc.com>
Date: Wed, 20 Mar 2024 14:35:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-2-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QppOEfP7HRmX_gHSIimpOeiCFXddstmz
X-Proofpoint-ORIG-GUID: QppOEfP7HRmX_gHSIimpOeiCFXddstmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=653 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200172

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently MAC HW un/register helper function support the single radio.
> To enable single/multi link operation in the future, the following helper
> functions need to be refactored to accommodate multiple radios under a
> single MAC HW un/register:
> 
> 	* ath12k_ah_to_ar()
> 	* ath12k_mac_hw_allocate()
> 	* ath12k_mac_hw_register()
> 	* ath12k_mac_hw_unregister()
> 
> This refactoring will make it easier to scale these functionalities and
> support Multi link operation.
> 
>                          Current Multi wiphy Model
> 
>  +---------------+          +---------------+            +---------------+
>  |  Mac80211 hw  |          | Mac80211 hw   |            | Mac80211 hw   |
>  |  private data |          | private data  |            | private data  |
>  |               |          |               |            |               |
>  |ath12k_hw (ah) |          |ath12k_hw (ah) |            |ath12k_hw (ah) |
>  |               |          |               |            |               |
>  | +-----------+ |          | +-----------+ |            | +-----------+ |
>  | | ar (2GHz) | |          | | ar (5GHz) | |            | | ar (6GHz) | |
>  | +-----------+ |          | +-----------+ |            | +-----------+ |
>  |               |          |               |            |               |
>  +---------------+          +---------------+            +---------------+
> 
>                            Single wiphy Model
> 
>                             +--------------+
>                             | Mac80211 hw  |
>                             | private data |
>                             |              |
>                             |ath12k hw (ah)|
>                             | +----------+ |
>                             | |ar (2GHz) | |
>                             | +----------+ |
>                             | |ar (5GHz) | |
>                             | +----------+ |
>                             | |ar (6GHz) | |
>                             | +----------+ |
>                             +--------------+
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


