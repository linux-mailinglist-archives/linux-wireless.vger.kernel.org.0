Return-Path: <linux-wireless+bounces-9819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20974923BEC
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4178B1C209CB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B70157E8B;
	Tue,  2 Jul 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PuwJrdww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250442C6B7
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917920; cv=none; b=LogdWiJazsbb7PDpyJbCIK/3v9Um3izjzVfv4aqHJBupsl+32/qesY3G6M+sxveA8kKPEqvJZc8MXyovSecRR6KCKArfFBSg69yWe8WZ9TiZjPN6D7Da7T2q6wBbKSCtDsoaQVjAolbG0fxorCng+p3fSR5MpE1EKD6vSY+cPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917920; c=relaxed/simple;
	bh=+7LxwZiw3dckSeNKfMa8+/nfhRASDedOWQ4ewuB+N3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=haPyk5YbPbSGb+AMmeP8OeaSBYQrp/5E/3ArTa04htzg7qbXCobglLm7X4w5mV/Usis4qMWs0ZyxSkdVlugswfluqmjZJrcZlgdJ8I8PLIy0wrNaoWSNUjQ7NifTeu99x5MWusAxoLo/S1kEmtqNXemCEEN+Gv9tQRGRuHe42gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PuwJrdww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46299N4Z011835;
	Tue, 2 Jul 2024 10:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMjXomIVnAvSN2neZTg7xL2nl1uZrOYRuy84mhg93Xk=; b=PuwJrdwwp53GPS5N
	uo5Gr7sxKvVOGsWHiM2LuppSyhIxuPcomhTc5CH1tfXNlggoBHilWe2EpwNopEYm
	/M9aAekGGxXJSXBpcdgak23YmDq9+tHeXAddcvQs/z6OeOWqDeNgNnzuS5FV1Flp
	3qcxDq9PmZAlffEOh7GL49pA5ZpU6CWRxI7qblZE6Qzo4W+kMV5bzux1RLEy+nMd
	OBqd+4qsgA7TTTSbRBeUoSLD2jfk0J5Q9XpcxjlS+ZjxqD8I1pmr1fE32vXUYTem
	42Y9jtYyNZlGsIPKVOpeH3uWhRS3y3gpA8AOwKyYAKvcJ//fHQeFhGTaV3YVin/r
	689+dg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 403kj8vhyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 10:58:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462AwTxH022281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 10:58:29 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 03:58:27 -0700
Message-ID: <bbb93003-807b-b6af-2096-20837de902f0@quicinc.com>
Date: Tue, 2 Jul 2024 16:28:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 05/10] wifi: mac80211: add support for DFS with
 multiple radios
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
 <61899e29de4e0f5437643d578999d2a3d4d7d7b2.1719843147.git-series.nbd@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <61899e29de4e0f5437643d578999d2a3d4d7d7b2.1719843147.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sbCVW6j_liIwezKDUa7HYWzXiMP-gZVc
X-Proofpoint-ORIG-GUID: sbCVW6j_liIwezKDUa7HYWzXiMP-gZVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020081



On 7/1/2024 7:43 PM, Felix Fietkau wrote:
> DFS can be supported with multi-channel combinations, as long as each DFS
> capable radio only supports one channel.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 7578ea56c12f..58bebfdaa062 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1091,6 +1091,21 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
>   	return 0;
>   }
>   
> +static bool
> +ieee80211_ifcomb_check_radar(const struct ieee80211_iface_combination *comb,
> +			     int n_comb)
> +{
> +	int i;
> +
> +	/* DFS is not supported with multi-channel combinations yet */
> +	for (i = 0; i < n_comb; i++, comb++)
> +		if (comb->radar_detect_widths &&
> +		    comb->num_different_channels > 1)
> +			return false;
> +
> +	return true;
> +}
> +
>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>   {
>   	struct ieee80211_local *local = hw_to_local(hw);
> @@ -1177,17 +1192,18 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
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

In ieee80211_register_hw(), mac80211 check the global iface combination 
against the IBSS interface max.

This check may fail for the radio specific iface combination 
advertisement since global iface combination is sum of all radio 
capabilities, no ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

