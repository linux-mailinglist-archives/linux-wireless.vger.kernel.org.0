Return-Path: <linux-wireless+bounces-13340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30098AEED
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 23:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F1C1F22D79
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9B17C7B6;
	Mon, 30 Sep 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mGTda37t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3931A0BDC
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731090; cv=none; b=T6xkbu2ZajU8x/78qezhN/ImqBg1/m7XUOM20UTGRtfF5NC+ZcUuFR6ZeGe18zGfupWogeMWsr+bpOZmYwGK+mUXuZ4mDiEm49QM2ZcpstY3gFWHPKj5TJuPrmUPSVuaxeZRCZXUrOLm4BmpnOgO5hq82aj0pw92BGnxuS914CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731090; c=relaxed/simple;
	bh=3MNYiRQzk9D+U+4rY1ePIglSuTiA8ycYI7GynYD1+as=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n2TfGzC6NmLtpvuJmqWp2vMuGY/XQSeNEr5N2mSOxwQGkquGpdY/5CxLIy28VmP93mKsQiQ3xrqzWK7HuBj8kNn3KVbIF500u/RT0vc/Ov8XNwDumW+Z/CNTHv77nLTZxMuq6X7Suh4EynCYDRnaS0hsUuu5UN4dPwvJaxromz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mGTda37t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBRMAj001546;
	Mon, 30 Sep 2024 21:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUbnokjMdhbaHID+kmCt2enVRYrky86MLMRNTCxQODg=; b=mGTda37tTb3lLkRh
	KhrfBIgzBXkeL3RMBDuZ/f06UG79+VN99sYwsT538qvogvAJx1MgFNZKoWIXWRin
	tKg7f/eo03n48iXYMJoAfdJr9Y0/RgAMJiUEcd8RTsF2ZpTMtMzAcJ+KXnkMpuEj
	3DBhA2sj2m3Xq+8ImqcoIN0IXXMz0mLVUi89cfMy5T4QOGk8G9F93dhaMMMvYSg3
	iTyMdDGukox9Os8aiKvxTK4DG9tSq6bK39VdjiOipGzFjn4OwDQAJ/qp5KyedqCh
	gMHWdMyMVkFClBfymi+mmripDQPUQukPtCOsfIIRQm5iEEyoI6mbIkr7iNp8plVH
	Av6iMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajfe0hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 21:18:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ULI50G015419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 21:18:05 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 14:18:05 -0700
Message-ID: <793ec8c0-7227-4ba5-891b-8f7ea7382463@quicinc.com>
Date: Mon, 30 Sep 2024 14:18:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240918212056.4137076-1-quic_pradeepc@quicinc.com>
 <20240918212056.4137076-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240918212056.4137076-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kMbBfm2zBSarpJVZnLwzsbaKQMb8hrpP
X-Proofpoint-ORIG-GUID: kMbBfm2zBSarpJVZnLwzsbaKQMb8hrpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=947
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300152

On 9/18/2024 2:20 PM, Pradeep Kumar Chitrapu wrote:
...
> @@ -8323,15 +8808,27 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
>  		ieee80211_iterate_stations_atomic(hw,
>  						  ath12k_mac_disable_peer_fixed_rate,
>  						  arvif);
> -	} else if (ath12k_mac_bitrate_mask_get_single_nss(ar, band, mask,
> +	} else if (ath12k_mac_bitrate_mask_get_single_nss(ar, vif, band, mask,
>  							  &single_nss)) {
>  		rate = WMI_FIXED_RATE_NONE;
>  		nss = single_nss;
> +		mutex_lock(&ar->conf_mutex);
> +		arvif->bitrate_mask = *mask;
> +		ieee80211_iterate_stations_atomic(hw,
> +						  ath12k_mac_set_bitrate_mask_iter,
> +						  arvif);
> +		mutex_unlock(&ar->conf_mutex);
>  	} else {
>  		rate = WMI_FIXED_RATE_NONE;
> -		nss = min_t(u32, ar->num_tx_chains,
> -			    max(ath12k_mac_max_ht_nss(ht_mcs_mask),
> -				ath12k_mac_max_vht_nss(vht_mcs_mask)));
> +
> +		if (!ath12k_mac_validate_vht_he_fixed_rate_settings(ar, band, mask))
> +			ath12k_warn(ar->ab,
> +				    "could not update fixed rate settings to all peers due to mcs/nss incompatiblity\n");

checkpatch says:
WARNING:TYPO_SPELLING: 'incompatiblity' may be misspelled - perhaps 'incompatibility'?


> +
> +		mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
> +			       ath12k_mac_max_vht_nss(vht_mcs_mask),
> +			       ath12k_mac_max_he_nss(he_mcs_mask));
> +		nss = min_t(u32, ar->num_tx_chains, mac_nss);
>  
>  		/* If multiple rates across different preambles are given
>  		 * we can reconfigure this info with all peers using PEER_ASSOC


