Return-Path: <linux-wireless+bounces-17569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA752A12BCC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A4F7A3B0C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397C1D86D6;
	Wed, 15 Jan 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BrDKQCZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD41D79A6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969783; cv=none; b=K/6B73ApPkszJKfym2nSr0e4OvarX0fIGqTlcHs3ciPLIXgSUGzMkO91GGsYDzmmYUS4a/TzYNQ6fU8OqGjGW2lXtBMZ1uUYmP22n8spMx6Jcj75DqMs0aiwlnHwrPuOthE3WJ1MdjyiiKXzN3bi6wIVsSvmzn7InALraU431wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969783; c=relaxed/simple;
	bh=w2yutSuwS3/c1mp0S3D9IW+boiJqhqjXx82noBaKwiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=rJr3zS2Xd1TvJfs7NWOYq1BHxQGoZ0/j413q03zWraXH+vqHATZhp4Vb49pwKev654aF7TRpHJ0UYAxs9D+4mDNkxbEllR0j2zBJT5s3JhVu1HA/Bf1/WYIoE2At6xkToN4k5ibksBDbniCibmdgWUtjYuMnl0dfsyxAs703peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BrDKQCZ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FIobCC007832;
	Wed, 15 Jan 2025 19:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t56w0zxptNyUSFP9eC1B7m625vNjqZz4J1Nv5uogHDg=; b=BrDKQCZ7lkFoq7g7
	3EBQSOGI9eOt+K4nXEf6uFZRbSPXtqixbWisdjO8+HMjaVAJ7yBLOivQSiioXG93
	ABvDyVyYd1Zl7Ld1hTgEE7s4sH8QhClet/0l4JMzSAO0LHHXUtKZwCDLNCxDq1HK
	AqQF3Kmwa1ksi9QO8smBm1i+9dqrRTQjKnVc4b2a7EyT0p9l/aBrCB0thKaXEbBC
	7IUnl85TGSM8BLUulm+j5SOQBBisgiYmQCJlw/IXURwLKuZJu4SqWSsOSpIwxy84
	iH5onw8SpqMpW4vBGuM5WX3QG8DhkEGTDuu5NpoRovpn86WD3R5gYUtJo4tvWo4E
	5mhAdQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446jndr3du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:36:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FJa9dC011389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:36:09 GMT
Received: from [10.110.39.228] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 11:36:09 -0800
Message-ID: <1df1e6b4-cb25-4abb-a6eb-1abaeeb5f588@quicinc.com>
Date: Wed, 15 Jan 2025 11:36:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: Aloka Dixit <quic_alokad@quicinc.com>
References: <20250114223612.2979310-1-quic_alokad@quicinc.com>
 <20250114223612.2979310-2-quic_alokad@quicinc.com>
Content-Language: en-US
CC: <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
In-Reply-To: <20250114223612.2979310-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UejdSBEqeiKkfX_yuSSPKygzyFDM0cZn
X-Proofpoint-ORIG-GUID: UejdSBEqeiKkfX_yuSSPKygzyFDM0cZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=529 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150142


>   
> +static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
> +{
> +	if (arvif->vif->mbssid_tx_vif)
> +		return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
> +
> +	return NULL;
> +}
> +
>   static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>   {
>   	struct ath11k_vif *tx_arvif;
> @@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>   	u32 params = 0;
>   	u8 i = 0;
>   
> -	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);

ath11k_mac_get_tx_arvif can return NULL, below, we are accessing 
tx_arvif without a NULL check. Shouldn't we add a null check wherever 
applicable to prevent potential issues?

>   
>   	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>   							 tx_arvif->vif, 0);
> @@ -1597,7 +1605,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
>   	int ret;
>   
>   	if (vif->mbssid_tx_vif) {
> -		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
> +		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>   		if (tx_arvif != arvif) {
>   			ar = tx_arvif->ar;
>   			ab = ar->ab;
> @@ -1674,7 +1682,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
>   				     struct ieee80211_bss_conf *info)
>   {
>   	struct ath11k *ar = arvif->ar;
> -	struct ath11k_vif *tx_arvif = NULL;
> +	struct ath11k_vif *tx_arvif;
>   	int ret = 0;
>   
>   	lockdep_assert_held(&arvif->ar->conf_mutex);
> @@ -1701,9 +1709,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
>   
>   	ether_addr_copy(arvif->bssid, info->bssid);
>   
> -	if (arvif->vif->mbssid_tx_vif)
> -		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
> -
> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>   	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
>   				 arvif->bssid,
>   				 tx_arvif ? tx_arvif->bssid : NULL,
> @@ -6333,14 +6339,12 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
>   	struct ieee80211_vif *tx_vif;
>   
>   	*tx_vdev_id = 0;
> -	tx_vif = arvif->vif->mbssid_tx_vif;
> -	if (!tx_vif) {
> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
> +	if (!tx_arvif) {
>   		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
>   		return 0;
>   	}
>   
> -	tx_arvif = ath11k_vif_to_arvif(tx_vif);
> -
>   	if (arvif->vif->bss_conf.nontransmitted) {
>   		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
>   			return -EINVAL;
> @@ -7306,8 +7310,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>   			   int n_vifs)
>   {
>   	struct ath11k_base *ab = ar->ab;
> -	struct ath11k_vif *arvif, *tx_arvif = NULL;
> -	struct ieee80211_vif *mbssid_tx_vif;
> +	struct ath11k_vif *arvif, *tx_arvif;
>   	int ret;
>   	int i;
>   	bool monitor_vif = false;
> @@ -7361,10 +7364,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>   			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>   				    ret);
>   
> -		mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
> -		if (mbssid_tx_vif)
> -			tx_arvif = ath11k_vif_to_arvif(mbssid_tx_vif);
> -
> +		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>   		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
>   					 arvif->bssid,
>   					 tx_arvif ? tx_arvif->bssid : NULL,

