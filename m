Return-Path: <linux-wireless+bounces-8985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63196907766
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712831C249E4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3F12E1FF;
	Thu, 13 Jun 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T3X5QlL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0B12EBF5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293384; cv=none; b=txfwqKL61MPctRjAVaoFy55K3y702Dasa2PyRy0nxMjS9eQr+M8gEu6zqqpaKDxbMbXU/3ATYnX5Lx6JWl43aq5xo1S7gBYMzr4IliMKnNdMZOfD8HIP/46f6FIByEC2r2qnXOwiCMQx2pUvtjBIYAvrg94p70sgWRaTSCpS9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293384; c=relaxed/simple;
	bh=BoJ6dFAdg8m8D6Q4kAtHZGVfX8/fBUjvHO42uVoPtFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZxqkGnOU33AwawlxcvN7pwzjKlU9CZsmrjh0xwaBgyjx4n9GY0Oial0TN/lhnIRMGWcZ/b6RvcaR+MZeLjPE/ubkOcyJKvNpM3e37z/SYTWgY1dwzrfqoB0KhdH3/zltzfZx7Yq/pfAYNYFI2uktH7oVpIOEPoYSUGa7mshROP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T3X5QlL+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9A03x017338;
	Thu, 13 Jun 2024 15:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0oRxHl3WZmI/DfHhPcunVmnl6wDvlXlsFSQdDpIrb4=; b=T3X5QlL+oc/dwE4g
	a7GFISNvXez1uuy9xWzIgQai+GWuTj8TCqldi3+XHgHglK9s6HWrrEqE1wS+vhYL
	iav43gYbMEVfbzT8LPNC9EXcQMuahbBoT0lMkcqWHsXILwQDExwJrqMbzTTM3Uw6
	kqO64oMKmvHHyNmlOJSfcTTmUKpbLkoezhJxL/3dIqA0P+bhVRxCoxhMAQ7yy/oO
	0cnc4saSQqrogDHJagun70w3OK5VxqcSjv/k2fsmN8PBcX1P88pSDMHGclMq3Mi8
	tUPjdczeinm2GWjLKBnZTZMFYgFYrlz/2FiSsINevg/aD7d7EtxB2GFO2c+dkvFA
	1Dt5bg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yptuy653h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:42:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DFgvwZ005066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:42:57 GMT
Received: from [10.48.243.167] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 08:42:57 -0700
Message-ID: <760d99d1-c709-43b5-9d15-c2a0fef98b66@quicinc.com>
Date: Thu, 13 Jun 2024 08:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix legacy peer association due to missing
 HT or 6 GHz capabilities
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>,
        Zachary Smith <dr.z.smith@gmail.com>
References: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WzgyNjRc-sZtOWqiJkbdJABZXe4B4jgp
X-Proofpoint-ORIG-GUID: WzgyNjRc-sZtOWqiJkbdJABZXe4B4jgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130113

On 6/12/2024 3:53 PM, Pradeep Kumar Chitrapu wrote:
> Currently SMPS configuration failed when the Information
> Elements (IEs) did not contain HT or 6 GHz capabilities. This
> caused legacy peer association to fail as legacy peers do not
> have HT or 6 GHz capabilities. Fix this by not returning an
> error when SMPS configuration fails due to the absence of HT
> or 6 GHz capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f0e61dc7ecf9 ("wifi: ath12k: refactor SMPS configuration")
> Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Per checkpatch:
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#17: 
Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Is there a separate public bug report from Aditya?

> Reported-by: Zachary Smith <dr.z.smith@gmail.com>
> Closes: https://lore.kernel.org/all/CAM=znoFPcXrn5GhDmDmo50Syic3-hXpWvD+vkv8KX5o_ZTo8kQ@mail.gmail.com/
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2259ce22cc8b..fa9f6656a06f 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2255,9 +2255,6 @@ static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
>  				     const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
>  				     int *smps)
>  {
> -	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
> -		return -EOPNOTSUPP;
> -
>  	if (ht_cap->ht_supported)
>  		*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
>  	else
> @@ -2277,6 +2274,9 @@ static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
>  	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
>  	int smps;
>  
> +	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
> +		return;
> +
>  	if (ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps))
>  		return;
>  
> @@ -2756,6 +2756,9 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
>  {
>  	int smps, ret = 0;
>  
> +	if (!ht_cap->ht_supported && !he_6ghz_capa)
> +		return 0;
> +
>  	ret = ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps);
>  	if (ret < 0)
>  		return ret;
> 
> base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39


