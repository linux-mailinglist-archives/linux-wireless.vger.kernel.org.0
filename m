Return-Path: <linux-wireless+bounces-10181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15C92DF6A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 07:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D461B218B6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7B101E4;
	Thu, 11 Jul 2024 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eygbobCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EB58AA5
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675578; cv=none; b=lBoBVrSfItIuJ3jvrUdUd1fWpWhuIp+PiwJ9MM+s/LgpPqMH3qr7dF9Rg9CxxfMcSqAuqSy6OKRuH1nO55GUOm8L0oWCFYmCpBrL4pk0BOqPLh4vjzZm5vTeSJ25KWoIPx2hOjZrkAe/bcdrl5O1G+mE5nO4F5ScX6Kdwf2K7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675578; c=relaxed/simple;
	bh=6dLek2tqvoLhBhMAmQ2LvTm8h1zKSugAaGeCwvXuWPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jB/J8FDgjHbwEO/NV/Dn2S6R7EAuUYDiua6uVBCW0SCP/exLv0xTtmj5K8TR88wOf3d7dZSJ5ditrVYg+v3GxGYG7EI2nj5yfKW4XTcvWT4sTe4ijd+YkXZb4WifyTRVzUo7u02dq5X5crcYhC6MWuAWJLOhry/sVJkpWUK7ZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eygbobCT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4xAF6017597;
	Thu, 11 Jul 2024 05:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G75HM4Q6C/7DItwF6dPXh5M4bArJMfbAySOzxAcs4T4=; b=eygbobCTOQB8CX/G
	dm+YaCa+HTvu+OQaTazaC/ZESlA3K/x8TOAndqzO+3CAp869UItTKies5E730B1T
	BktMxWliAXfRzI54EAP8U25nPRI6sFZ5Bzeph3ypl5Gg+sAR/ZUwEyO+9wDzTpbw
	iPriNRz/X8jwNJZu0mAwJBxzFzGGW7Ty20aMonogr6brqbqx17sPL7S++KeG1ZSz
	Q987YjkG2TAQNfct16Uvlf0tBllGVn/43SIJMqVDNyAFlcrCZm5uu90eLsCAY9zX
	MFmQoqmzXHRfYtfFapnv7SheCapLQZic1KEZ9DFRmBUDFs3U1HJqiyyMEDjwfLe9
	iElc2g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40a8uhr1as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 05:26:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B5Q8ms008229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 05:26:08 GMT
Received: from [10.48.246.254] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 22:26:08 -0700
Message-ID: <a04ecf46-39d9-4785-824c-c53c17362abf@quicinc.com>
Date: Wed, 10 Jul 2024 22:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240709120659.1564434-1-quic_ramess@quicinc.com>
 <20240709120659.1564434-2-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240709120659.1564434-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jkwb540qWvfOX1HHq3wFXU0zR5TriMCr
X-Proofpoint-ORIG-GUID: jkwb540qWvfOX1HHq3wFXU0zR5TriMCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_02,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110035

On 7/9/2024 5:06 AM, Rameshkumar Sundaram wrote:
...
> @@ -4569,12 +4685,17 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  				   enum ieee80211_sta_state old_state,
>  				   enum ieee80211_sta_state new_state)
>  {
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	struct ath12k *ar;
> -	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>  	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
> +	struct ath12k_link_vif *arvif;
>  	struct ath12k_peer *peer;
>  	int ret = 0;
>  
> +	mutex_lock(&ah->conf_mutex);
> +	arvif = &ahvif->deflink;
> +
>  	/* cancel must be done outside the mutex to avoid deadlock */

this is now inside the ah->conf_mutex -- is that ok?
seems this comment should be updated to explain *which* mutex(es) the cancel
must be done outside of?

>  	if ((old_state == IEEE80211_STA_NONE &&
>  	     new_state == IEEE80211_STA_NOTEXIST))
> @@ -4583,9 +4704,9 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  	ar = ath12k_get_ar_by_vif(hw, vif);
>  	if (!ar) {
>  		WARN_ON_ONCE(1);
> +		mutex_unlock(&ah->conf_mutex);

unlock before the WARN -- the WARN is not part of the critical section

>  		return -EINVAL;
>  	}
> -
>  	mutex_lock(&ar->conf_mutex);
>  
>  	if (old_state == IEEE80211_STA_NOTEXIST &&


