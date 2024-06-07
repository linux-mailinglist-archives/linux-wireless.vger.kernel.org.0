Return-Path: <linux-wireless+bounces-8655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AE8FFA6B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 06:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C041F23ACB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490B2572;
	Fri,  7 Jun 2024 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TU8OxjNz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D6101CE
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734377; cv=none; b=ZD9aY4KMGZdiEpX5BEUa4wWYNLXbnu7XYitLKiJqLkF1/u9I6LrxToB/vgqwP2840Qv/983Kucom2Bbv85ajtPp31IDigd783x886FjUIhhiaMp6ic705Dqmq81/r/eViBsMqecnQ/tq8zbHr62kb4fsGL16m5g+HLTsHiWGN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734377; c=relaxed/simple;
	bh=Tpbo+0R8BLz6qWZXuItnjUVc2094M9uMb3QWE4Ewnxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NXkdHcJ4o9lg/gnUni0f7tkFwVuJFq2ymWAJnuaq9/yILgyF5KbY93VeokSC27Ns2wQ75vrCG0E1iyed2MQlkOV8VX4IlHm7lRHC2f3Zx+p7hezvOACX+MqeeiJMhE2wIgpM5F3zg1Pq6rz21jhnCNIn/PhrGK8+6deScGjgpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TU8OxjNz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45742CAV022877;
	Fri, 7 Jun 2024 04:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SF08Y+2lgwbn94fK7TijeOO+0PXww71J4DpKxZh4Puc=; b=TU8OxjNzoqY/GFo0
	ZMcdWwfSYrZv4a5IU6oHQnDYMRQk/syShtqgthDOlM7GMiG8LxXmiDQ0pgCal8lM
	xWZiEW2xZovZRDwJR5G6MhdbjiqcW1tvavGdpqrwarZvQ8O1yjRGnHOiyuQNvhPF
	bux69b5ULu2FlSLyVPN7Bhn075y3kw6hX3F9eH8QwafF1BiTJVE5Nutj92Y+/wDJ
	mG/tyG3+DivgtkXS68SfME3sJuotfTP8MCI5H5ZzukWU7ELlvH7nxByLi+V4X2xL
	RFGb4ACNDgT3JM2US7vp8OoptYTibYOFctiZ5Kw0/ffSxmdGWdBoH/MWN8xc/X+W
	2pMcwg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ykttx016v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:26:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4574Q105031609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 04:26:01 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 21:25:58 -0700
Message-ID: <2014e488-b930-43ff-86a6-c5a4801b82f5@quicinc.com>
Date: Fri, 7 Jun 2024 09:55:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v3 4/8] wifi: mac80211: add support for DFS with multiple
 radios
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <7cc3d89225f365c85b363874725cfbc77c9c1db5.1717696995.git-series.nbd@nbd.name>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <7cc3d89225f365c85b363874725cfbc77c9c1db5.1717696995.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NmZjU0jwX45oYHlGlOlqQW8VtnY8abGL
X-Proofpoint-ORIG-GUID: NmZjU0jwX45oYHlGlOlqQW8VtnY8abGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070030



On 6/6/2024 11:37 PM, Felix Fietkau wrote:
> DFS can be supported with multi-channel combinations, as long as each DFS
> capable radio only supports one channel.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 40fbf397ce74..e9c4cf611e94 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c

...

>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>   {
>   	struct ieee80211_local *local = hw_to_local(hw);
> @@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   			if (comb->num_different_channels > 1)
>   				return -EINVAL;
>   		}
> -	} else {
> -		/* DFS is not supported with multi-channel combinations yet */
> -		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
> -			const struct ieee80211_iface_combination *comb;
> -
> -			comb = &local->hw.wiphy->iface_combinations[i];
> +	} else if (hw->wiphy->n_radio) {
> +		for (i = 0; i < hw->wiphy->n_radio; i++) {
> +			const struct wiphy_radio *radio = &hw->wiphy->radio[i];
>   
> -			if (comb->radar_detect_widths &&
> -			    comb->num_different_channels > 1)
> +			if (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
> +							  radio->n_iface_combinations))
>   				return -EINVAL;
>   		}
> +	} else {
> +		if (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
> +						  hw->wiphy->n_iface_combinations))
> +			return -EINVAL;
>   	}
>   
>   	/* Only HW csum features are currently compatible with mac80211 */

Are we omitting the "wiphy->iface_combinations" if the radio specific 
iface combination advertised ?

If so, it looks like unused "wiphy->iface_combinations" for radio 
specific combination advertised.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

