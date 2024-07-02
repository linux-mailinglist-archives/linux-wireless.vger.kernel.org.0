Return-Path: <linux-wireless+bounces-9817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE233923B74
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C8EB223FE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213814F106;
	Tue,  2 Jul 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LJNuB0mP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91352AD17
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916343; cv=none; b=pCYbqJ1nK+pkcyQTamGZdbFmueSj5mCvmsydqeJtS/PmEkDywO2jKXFOiUVw/M3mq8b51GQPYIEwLJkZ78adgaiSad3gXWMzkGHDP9LO3UNKbhXkhbDlQkKue2q+KmhjJhQb1yAT9FvrsoHInSvMLyU69T+MNfZnDi2oE0Sjg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916343; c=relaxed/simple;
	bh=H2gzOVpRb2R2tdX7McYOdEn6gbOQ471zh4VeRGL2yxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O+s3M6So1ZV889T7OcmgRZtq61rLfxz+uiZvkxWV3DhQHhuGW4S3D7nTXvxf0mFb32BArGoA9BBxaV2ycyQoBdwRbRhTjxhLwju4haxPcWcU8FX6qh1lGwAIsQSwUR7MY3rwsP3pYtUUqrPq272xnCEFN5L++eKp82BhnBg+L58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LJNuB0mP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4627nMmv006937;
	Tue, 2 Jul 2024 10:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EEHIeQ68RH/N7etDBWjTgdfHV12LimfW6JMNoEKGk34=; b=LJNuB0mPvCSksobY
	jAMLT/x4GTb1g1+Af33ZfaWVteMOwZpKEneGGbnt1KlL21oP+S8yuIgZ9HLsTqbd
	B2UhlEN7HbRv0PkfwFWK8hRVnmPZYCg7+bJ4xFhOLUup1tcLWGwwO6ry5vRTu8Pk
	yFmR/ioAysCNT5swQPoEahkdmaG6F6a84zB2t7m+45u9KkpXXfMFd3SiabGBx6oJ
	ErKq/bkD2BLHCPEyvKbCCPET21A+e05VRX2AgF1rDb7XxZmLmiGlmT5GPx6ZBe7y
	ywvmDK1b3jQ3x5dwknxeQskN5C1tmMxlrXvCmxOzjpCsW19dWKjx6D6e/huK7TQs
	0pPWsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bejpysx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 10:32:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462AWB6d022042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 10:32:11 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 03:32:09 -0700
Message-ID: <9c3da9ac-490a-d4aa-a830-7272c1a67b9c@quicinc.com>
Date: Tue, 2 Jul 2024 16:02:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 07/10] wifi: mac80211: extend ifcomb check functions
 for multi-radio
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
 <15d63cd77aad2d2eef503676a3f3fbabe78d5828.1719843147.git-series.nbd@nbd.name>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <15d63cd77aad2d2eef503676a3f3fbabe78d5828.1719843147.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dAjvYOXOrjnLmMo8dz54lEwYFeeLp9Ks
X-Proofpoint-ORIG-GUID: dAjvYOXOrjnLmMo8dz54lEwYFeeLp9Ks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=644
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020078



On 7/1/2024 7:43 PM, Felix Fietkau wrote:
> Add support for counting global and per-radio max/current number of
> channels, as well as checking radio-specific interface combinations.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/cfg.c         |   7 +-
>   net/mac80211/chan.c        |  17 +++--
>   net/mac80211/ibss.c        |   2 +-
>   net/mac80211/ieee80211_i.h |   5 +-
>   net/mac80211/iface.c       |   2 +-
>   net/mac80211/util.c        | 126 ++++++++++++++++++++++++++------------
>   6 files changed, 108 insertions(+), 51 deletions(-)
> 

...

> @@ -3982,6 +4062,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>   	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
>   		params.iftype_num[iftype] = 1;
>   
> +	ieee80211_fill_ifcomb_params(local, &params, shared ? chandef : NULL,
> +				     sdata);
>   	list_for_each_entry(ctx, &local->chanctx_list, list) {
>   		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
>   			continue;
> @@ -3991,28 +4073,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>   			params.num_different_channels++;
>   			continue;
>   		}
> -		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
> -		    cfg80211_chandef_compatible(chandef,
> -						&ctx->conf.def))
> -			continue;
>   		params.num_different_channels++;
>   	}
>   
> -	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> -		struct wireless_dev *wdev_iter;
> -
> -		wdev_iter = &sdata_iter->wdev;
> -
> -		if (sdata_iter == sdata ||
> -		    !ieee80211_sdata_running(sdata_iter) ||
> -		    cfg80211_iftype_allowed(local->hw.wiphy,
> -					    wdev_iter->iftype, 0, 1))
> -			continue;
> -
> -		params.iftype_num[wdev_iter->iftype]++;
> -		total++;
> -	}
> -
>   	if (total == 1 && !params.radar_detect)

Here, total is always 1. no ?

>   		return 0;
>   


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

