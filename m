Return-Path: <linux-wireless+bounces-4653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2316879FA9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753581F216EC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49D46551;
	Tue, 12 Mar 2024 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pe8O0Rmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8B14293
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285948; cv=none; b=Rnb0iq3cGRAwI/F5ST5Oeyq+k9MkIXnRtiFSMrJXzPUDpJ9ZM43sQ0Jt/ew5MykyN4g1ii4cnVAGhpM62Ooa7kpLsM5cMCAEDQi2sakG77alQyjFwEStDPpYrv9EoGk+CAU3teFXqTv/1OGq94ohSMWtuK9YiDb2LHvniVBD64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285948; c=relaxed/simple;
	bh=AHMt+NJdc/+KC3nW12xukDLxSjp4w/TGI8Kzufo364A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ldEQ7g657ogQ+aIBAcb9wml/Gv/ecP1yDQRTujhJhvfLz3JqSv9oxmiIuAR5C5uqeIXOqDWUbXi2G50EemyOuqyUHB+VZVUoZTZNoSlzZOivTNq5XMcONu1pSTi7mfUX+mkMKCjWoHS4wkF7YAJo7nZ7BbSfri3rWIxASvElFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pe8O0Rmy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CMq9Ts009926;
	Tue, 12 Mar 2024 23:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U57j0rFTSpCPaCIeJjRmCGJl4DJbjApEu9z5qpiQusU=; b=Pe
	8O0RmyNq/0sj2RzU+UMf+joqjTWHW4o7JqSdEd7gqUlnz5iJrVq8kKYleNR8sLKT
	NkkX7Av0XpQcg3YTmk87diV9rEbfm8r/8xcF1nCct47kg42hxrBNVj2x+asxdX0J
	gawWvfPy4YgdpDWHdvB60oG8YjalPEljAzXSQ/CPYACPPnzOYXQjucyuxJaVLvgS
	D5VNrdTzuOy/GFW1LO9D8DP3XoWfXv+zR7aBZZcgFHnvzOvfsGqIZziJi7YUjCch
	w0bOYnk7k7WQ0xw8TB8cgUZnUfdwr3ylw2bePBFFinOeGZUNw52amDlgkc/yDy4a
	ihSEWQl07LW8fOvcu0oA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu07c81gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:25:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CNPfYf018096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:25:41 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 16:25:41 -0700
Message-ID: <036abbcc-eb90-48db-a82e-5565bcc336ef@quicinc.com>
Date: Tue, 12 Mar 2024 16:25:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] wifi: ath12k: support get_survey mac op for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-13-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-13-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7g4lFtsFCLic5mtMQy3FTkNcMpea2rWc
X-Proofpoint-GUID: 7g4lFtsFCLic5mtMQy3FTkNcMpea2rWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=833
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403120180

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> The radio for which the survey info needs to be collected
> depends on the channel idx which could be based on the band.
> Use the idx to identify the appropriate sband since multiple
> bands could be combined for single wiphy case.
> 
> Also use the channel idx and sband to identify the corresponding
> radio on which the survey results needs to be populated.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 6123d7db2edc..a31003f8325d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7821,7 +7821,6 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
>  static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  				    struct survey_info *survey)
>  {
> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>  	struct ath12k *ar;
>  	struct ieee80211_supported_band *sband;
>  	struct survey_info *ar_survey;
> @@ -7830,12 +7829,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	if (idx >= ATH12K_NUM_CHANS)
>  		return -ENOENT;
>  
> -	ar = ath12k_ah_to_ar(ah, 0);
> -
> -	ar_survey = &ar->survey[idx];
> -
> -	mutex_lock(&ar->conf_mutex);
> -
>  	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
>  	if (sband && idx >= sband->n_channels) {
>  		idx -= sband->n_channels;
> @@ -7850,6 +7843,21 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  		goto exit;
>  	}
>  
> +	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
> +	if (!ar) {
> +		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
> +			ret = 0;
> +			memset(survey, 0, sizeof(*survey));
> +			goto exit;
> +		}
> +		ret = -ENOENT;
> +		goto exit;
> +	}
> +
> +	ar_survey = &ar->survey[idx];
> +
> +	mutex_lock(&ar->conf_mutex);
> +
>  	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
>  
>  	spin_lock_bh(&ar->data_lock);
> @@ -7861,9 +7869,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	if (ar->rx_channel == survey->channel)
>  		survey->filled |= SURVEY_INFO_IN_USE;
>  
> -exit:
>  	mutex_unlock(&ar->conf_mutex);
> -
> +exit:

goto should normally only be used when there is centralized cleanup.
since now there is no cleanup required, all of the goto exit calls should just
directly return the appropriate error

>  	return ret;
>  }
>  


