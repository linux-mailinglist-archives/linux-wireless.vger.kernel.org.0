Return-Path: <linux-wireless+bounces-11778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0A95AD09
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 07:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD791C22777
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2536AE0;
	Thu, 22 Aug 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZSoj4i2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AD23CB
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305610; cv=none; b=GzRwp1M3Iqh3SAXQJjUwmh9ggi004FQTPQ7h7D6H+CnLBPiWMTq3LpV3KT5HlxE5WK1U3np/oP2lCbywBo0kbIbjFLj9tQdY5dAKdwR0lr+QnYvxBzOyFm676joCZi41qafIgia2e8EjLVY0g5uC9/3jiskojZydOq+UHDhXcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305610; c=relaxed/simple;
	bh=RsB1tOhfEEBhMR8prOP5Afiug5LmDR3Dh97pGpyq20Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hsz7xnRvbr0ASkbRQXNbSTsZnU54axK69p1fROeSUT1zcrVH1UTIfYM+scs8y+Xnpwss7FH+MSoSwp4e2/ewJFNdnLQzPdR9ZfUzD3XsDudorGO1lBgWlxzfVImCAZouHEznzVKVW+EnqYNNGlOoCV0D+RqsOF+BOJmCpoxuYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZSoj4i2e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M12Mk1029158;
	Thu, 22 Aug 2024 05:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkrEjhhdrh2LxSFxa6D9QDj1lo1uBKP+h1FFIXtlK14=; b=ZSoj4i2e2zI7bl2c
	AWCCQi3bWG5Yq6BbgYZjG5agyQYLVFjL9czHkMoQEeyYauIxm+xF5/vG3QDtw51i
	iRS3QSLxcNOc2yByuIBEUEvg6NUyYGVEHV7i/Y8jNSHEA5w7mczPTFmqWJ/aRQbu
	J+KVCEiey0hNr47UMikRiepfJ1bUQVbx0x15y//3ev7a2CnvlqWO9z7HG6QtAYfk
	/M2LgL7BDBLUodLJSm5cd0vYUyCxDr1i0ZmQvXv5vyLY1/9htOBzfFd4+gTZv5kS
	yL5VPX2WeGmCSxUgWOLEgBZnWKc5FksGsaALVPtPAV98UUUKkjmoKXa1TSzpSxCb
	74pEEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4159adbvnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 05:46:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47M5kecX006949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 05:46:40 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 22:46:39 -0700
Message-ID: <a1a4202f-5c10-401a-9b02-47dacb9be048@quicinc.com>
Date: Thu, 22 Aug 2024 13:46:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] wifi: ath12k: switch to using wiphy_lock() and
 remove ar->conf_mutex
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240821153728.2121600-1-kvalo@kernel.org>
 <20240821153728.2121600-2-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240821153728.2121600-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1_JQS5AgmDkOGBI0aoKSzjr2FRWKY95L
X-Proofpoint-ORIG-GUID: 1_JQS5AgmDkOGBI0aoKSzjr2FRWKY95L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_02,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=805
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220040



On 8/21/2024 11:37 PM, Kalle Valo wrote:
> @@ -845,7 +845,9 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>  	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
>  	int ret;
>  
> -	mutex_lock(&ar->conf_mutex);
> +	lockdep_assert_wiphy(hw->wiphy);
> +
> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
we don't need this lock because it is already held by mac80211.

>  
>  	ret =  ath12k_wow_cleanup(ar);
>  	if (ret) {
> @@ -913,7 +915,7 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>  	ath12k_wow_cleanup(ar);
>  
>  exit:
> -	mutex_unlock(&ar->conf_mutex);
> +	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
same here.

>  	return ret ? 1 : 0;
>  }

