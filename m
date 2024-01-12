Return-Path: <linux-wireless+bounces-1825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACAA82C429
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD34EB222F0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE31B58E;
	Fri, 12 Jan 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nEanatMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9111B585
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CCWIE7032347;
	Fri, 12 Jan 2024 17:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i76A4sLOKOSNPIcFjNajS2rtvzLP+pE0ISwWXQdn0No=; b=nE
	anatMeYY+cHbYUmikDtSJ1lkMCLy6vJAsgIm6fKs12R8zS1NteAzIbKyGhuvSGr7
	jX5dG8mw2UD+QnAvKljAVsjhVw1PmqxPn5FPfNaMdQmEOYzpzfk1zF0gkCCQVDBP
	NG7PApA2bh6WnIjHBd0gx19mRO+da40jpvXPlr006ZweXeb/imZvjR5GOwoia029
	qZRvCfShkk0mtSIBnpE6RgdKsFRf4vSNRFKHlQogLlZ8bWcKsjxcV6q/6UXDfJzJ
	gF4s0ivwUBea2WzZZzIDPQ2G1Cs+TEel9DsyPutXan0VdwWBIGHEZE82qmY3pizC
	0C73KVBM4XjlI0nbFq7Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjpuj2m8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:03:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CH33m5011320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:03:03 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 09:03:02 -0800
Message-ID: <aee0419e-c443-4b5d-957c-6c88dd3d4a71@quicinc.com>
Date: Fri, 12 Jan 2024 09:03:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-2-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-2-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p767pKjM_0X6gvvmBJwoMfpv3dKnGqUG
X-Proofpoint-ORIG-GUID: p767pKjM_0X6gvvmBJwoMfpv3dKnGqUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=807 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120134

On 1/10/2024 8:50 PM, Sriram R wrote:
...

> @@ -7553,10 +7553,12 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>  
>  static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
>  {
> -	struct ath12k *ar = ath12k_ah_to_ar(ah);
> +	struct ath12k *ar;
> +	int i;
>  	u16 interface_modes = U16_MAX;
>  
> -	interface_modes &= ar->ab->hw_params->interface_modes;
> +	for_each_ar(i, ah, ar)
> +		interface_modes &= ar->ab->hw_params->interface_modes;

This logic sets interface_modes to be the modes that are supported on
every radio (starts with all modes supported and then masks off the ones
that are not supported on a given radio). That means that if radio 0
supports a mode that radio 1 does not support, then we don't advertise
support for that mode. Just want to verify that is the correct logic,
and that instead we don't want to start with no modes supported and then
OR in the ones that are supported so that we get the list of modes that
are supported on ANY radio instead of ALL radios.

>  
>  	return interface_modes == U16_MAX ? 0 : interface_modes;
>  }
> @@ -7564,15 +7566,19 @@ static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
>  static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
>  					    enum nl80211_iftype type)
>  {
> -	struct ath12k *ar = ath12k_ah_to_ar(ah);
> +	struct ath12k *ar;
> +	int i;
>  	u16 interface_modes, mode;
>  	bool is_enable = true;
>  
>  	mode = BIT(type);
> -
> -	interface_modes = ar->ab->hw_params->interface_modes;
> -	if (!(interface_modes & mode))
> -		is_enable = false;
> +	for_each_ar(i, ah, ar) {
> +		interface_modes = ar->ab->hw_params->interface_modes;
> +		if (!(interface_modes & mode)) {
> +			is_enable = false;

note that in the example I mentioned above, this logic could say a given
mode is enabled even though the bit isn't set in the interface_modes
listed above

> +			break;
> +		}
> +	}
>  
>  	return is_enable;


