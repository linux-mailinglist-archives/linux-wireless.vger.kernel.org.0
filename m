Return-Path: <linux-wireless+bounces-7819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694808C8FC1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2722328306A
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E402D518;
	Sat, 18 May 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jIDOw2+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630BD50F
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716012073; cv=none; b=OKgFQR9GTJT9zc5O76ewBwDTI017KnHONp/WnSh1JtH7julVzcn2NhrZngV6JvoBVfhbo1pGMCcRX49qZ1dyibV16Qb9pQC+KoHJf6d0LUSnxP8Y3qrHsodyACl7b3VmPdHiG50j3iOtVOkjWXlZb9DICMVJBnHvK4ArEyNSKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716012073; c=relaxed/simple;
	bh=ReLAp5DKKF5bHAK+Z5Um4WKsUk+rSeA81giUFu+BniQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GOYA3txHCDw5ZCa0baKxFh59CzvYpnrSfzZKJ4Y8fAeHSsszjxS7c3Ro0uv/OD3uyoAyr0+/xYtYvlV2dNm2g/IjvEui4lyB+Lwk6jin8KvWIlJ5oq6w6qTf6o6uwedMiMR2tOc8lqlYrby7WlNRG4dhauR00sjq29HU46r5IwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jIDOw2+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44I54JTm015894;
	Sat, 18 May 2024 06:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ADxd3IsSbj1Rd0l58LK+hASLWbz+iaZ0QMYPnBX/hcI=; b=jI
	DOw2+caTjvAxBrCRDc7IjVlkIW9OJrctEWpUFGWdu0akhpiu0o9crlLXtErvefP0
	vOuEUHmyQDTkzCjERnEgjOd2XTkznV+vsLAaV5xKlGzIbXhWjevDu1ag2gjw+XPa
	Ta7f9qkx/bmXdDUywiT7G+xHiEZLZpHYCRgi+xNVYmqhQnG6nx/uDr+hwtI1Qfjr
	pCIrF5M8hC5iVv7Hkc4HjuJ73cBJzjHIVidxii078jl81AGWnCgdUVWTgj3X9OUx
	XIkXC9fTaerUzTQx+1tUuUzhupejULSHQljzS8U0r33e8Jml4uaOiauOioaT3P2x
	nMV35WHsF2r69cUb+vzQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n1p037x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 06:01:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44I613Zu007784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 06:01:03 GMT
Received: from [10.50.55.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 23:01:01 -0700
Message-ID: <6ee09e84-bc20-c053-34f8-dc4bf71587ea@quicinc.com>
Date: Sat, 18 May 2024 11:30:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 RFC] wifi: cfg80211: Refactor interface combination
 input parameter
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240518055316.3102746-1-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240518055316.3102746-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yyjqui_fRDFqzcylnIrwiKTF2S1GmicJ
X-Proofpoint-GUID: Yyjqui_fRDFqzcylnIrwiKTF2S1GmicJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_13,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405180031



On 5/18/2024 11:23 AM, Karthikeyan Periyasamy wrote:
> Currently, the interface combination input parameter num_different_channels
> and iftype_num are directly filled in by the caller under the assumption
> that all channels and interfaces belong to a single hardware device. This
> assumption is incorrect for multi-device interface combinations because
> each device supports a different set of channels and interfaces. As
> discussed in [1], need to refactor the input parameters to encode enough
> data to handle both single and multiple device interface combinations.
> This can be achieved by encoding the frequency parameter under the link
> entity and interface type parameter under the interface entity, which can
> hold an array of link entities. This is because, in the MLO scenario, a
> single interface can support multiple links. With this new input parameter
> structure, the cfg80211 can classify and construct the device parameters,
> then verify them against the device specific interface combinations.
> 
> [1]: https://lore.kernel.org/linux-wireless/ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net/
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   v2:
>    - changed the argument of ieee80211_check_combinations()
>    - changed the iface_combination_interface::num_link into
>      iface_combination_interface::valid_links
>    - Moved the new_beacon_int, radar_detect under the iface link param
>    - Moved the ieee80211_link_or_deflink() helper under the util
>    - Moved the ieee80211_link_get_chanctx() helper under the ieee80211_i.h
>    - Removed ieee80211_chanctx_radar_detect()
> 
>   drivers/net/wireless/ath/wil6210/cfg80211.c   |  44 ++-
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  60 +++-
>   .../net/wireless/quantenna/qtnfmac/cfg80211.c |  32 +-
>   include/net/cfg80211.h                        |  51 +++-
>   net/mac80211/cfg.c                            |  40 +--
>   net/mac80211/chan.c                           |  16 +-
>   net/mac80211/ibss.c                           |   7 +-
>   net/mac80211/ieee80211_i.h                    |  20 +-
>   net/mac80211/iface.c                          |   7 +-
>   net/mac80211/util.c                           | 280 +++++++++++++-----
>   net/wireless/util.c                           |  90 ++++--
>   11 files changed, 464 insertions(+), 183 deletions(-)
> 

...

> +/**
> + * struct iface_combination_interface - Interface parameter for iface combination
> + *
> + * Used to pass interface specific parameter for iface combination
> + *
> + * @iftype: interface type as specified in &enum nl80211_iftype.
> + * @links: array with the number of link parameter used for verification
> + * @valid_links: bitmap of valid links, or 0 for non-MLO.

Will correct the comments for valid_links in the next version. It should 
be like below

@valid_links: bitmap of valid links.


> + */
> +struct iface_combination_interface {
> +	enum nl80211_iftype iftype;
> +	struct iface_combination_iface_link links[IEEE80211_MLD_MAX_NUM_LINKS];
> +	u16 valid_links;
> +};

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

