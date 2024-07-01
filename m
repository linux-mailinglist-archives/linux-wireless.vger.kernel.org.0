Return-Path: <linux-wireless+bounces-9784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FB91E3F9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875111F21162
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1084158D7F;
	Mon,  1 Jul 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PH5iVmce"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04111522F
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847452; cv=none; b=TUWBuo/9Q9orcMvkD/eff7+rXAijBhDt5aMz61Yd0k2POrKRa8NTqt91/mUXRKuVQwzuNL7rMpx0pt38/jrDZG/y8DuMFJxAFAMyCHtmoMwurOFAi9WfW2g5AHt1dyTnEGMDj7vrxed1SfVyvYOdlk8pIndx4IQv+tLj/jdn3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847452; c=relaxed/simple;
	bh=tDm74ae4oD+SeRwX9uqvUJM+h2zrhEa7witmn6JaII4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CeBSBtUEugXDd6agksexuOkC41UaW5ajql8i7jbRxx6hzWKGZRGSaFSGY1tcsXwIqGVVTK7rAVBn++lh4yKwdFT+mV/D3tlRlnDxG0dEdeqG09Rmpouq74+jxmCQWZ7690erWCtVJiRXMoDoSyMUoqrvJtmP3Jb3V01a/FAu/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PH5iVmce; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4619iL56030283;
	Mon, 1 Jul 2024 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbVhLc6/koF2x/qir6yEyR52lJ0YasrLyzsL92gUMkk=; b=PH5iVmceB6MRxMe1
	W/IZM3uCTQuoxkJclxcLpEhJe+ihxLkynfWk+dWP2SqzzjE2JOevhv3448QxypWb
	LiffSVqOHzftg60VkMz/2RUQbt8Qz3ztnQT04qxnj+AHHwUeqEszCSrbn96srX59
	QncEXMw7YX2aqMSbkQebJBTNbuSyGr/0iN75Q3pUsnPp0IWWp+yw5TH3WMKviCrl
	Qz/SzdcJphbeeC5qEIN0hj/gvWG+UMCXZ9L/cCl+OlU2oXLwCYlEIMTz5pZW5mQu
	7FGi3lxNodPxJ9ceTXX+PQ3dv2vV6lXhg4yajC7zZDd0LDS3cVwPa7pUWYCzQcJ0
	MVpxew==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnmxxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:24:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461FO08s031850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 15:24:00 GMT
Received: from [10.50.63.139] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 08:23:58 -0700
Message-ID: <ff362ca2-361d-5da7-9d8d-299ba1200bf0@quicinc.com>
Date: Mon, 1 Jul 2024 20:53:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 03/10] wifi: cfg80211: extend interface combination
 check for multi-radio
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
 <18a4aae4b14f1005fb5b1ed98173e31b18914155.1719843147.git-series.nbd@nbd.name>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <18a4aae4b14f1005fb5b1ed98173e31b18914155.1719843147.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aB7sLNel07RTawiptQ6CnE4qN6ySzFhJ
X-Proofpoint-GUID: aB7sLNel07RTawiptQ6CnE4qN6ySzFhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_15,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=855 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010118



On 7/1/2024 7:43 PM, Felix Fietkau wrote:
> Add a field in struct iface_combination_params to check per-radio
> interface combinations instead of per-wiphy ones.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   include/net/cfg80211.h  |  5 +++++
>   net/mac80211/util.c     |  5 ++++-
>   net/wireless/rdev-ops.h | 12 ++++++++++++
>   net/wireless/util.c     | 33 ++++++++++++++++++++++++++-------
>   4 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index a3cdad3a9305..bb3b803e5468 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1598,6 +1598,7 @@ struct cfg80211_color_change_settings {
>    *
>    * Used to pass interface combination parameters
>    *
> + * @radio_idx: wiphy radio index or -1 for global
>    * @num_different_channels: the number of different channels we want
>    *	to use for verification
>    * @radar_detect: a bitmap where each bit corresponds to a channel
> @@ -1611,6 +1612,7 @@ struct cfg80211_color_change_settings {
>    *	the verification
>    */
>   struct iface_combination_params {
> +	int radio_idx;
>   	int num_different_channels;
>   	u8 radar_detect;
>   	int iftype_num[NUM_NL80211_IFTYPES];
> @@ -4580,6 +4582,8 @@ struct mgmt_frame_regs {
>    *
>    * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
>    * @set_ttlm: set the TID to link mapping.
> + * @get_radio_mask: get bitmask of radios in use.
> + *	(invoked with the wiphy mutex held)
>    */
>   struct cfg80211_ops {
>   	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
> @@ -4941,6 +4945,7 @@ struct cfg80211_ops {
>   				    struct cfg80211_set_hw_timestamp *hwts);
>   	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
>   			    struct cfg80211_ttlm_params *params);
> +	u32	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev);
>   };
>   

No documentation for the global iface combination when multi-radio 
combination present ?

/* 4.  Radio specific iface combination...
  */
struct ieee80211_iface_combination {
...
};


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

