Return-Path: <linux-wireless+bounces-2966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF919845C19
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174C829AC9D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF816215A;
	Thu,  1 Feb 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F5Bv4Gym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BF5F48F
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802613; cv=none; b=Dxw8R5rIVhZkCLoXrcFhU2YewqxTTM5wRbdI/CzJC+Ve58RnYWfPgVKh2uT4BLMKn2HzrJGOXa6mAeW1+mpVMxBECNLaLELFH1opdVpMpvZm3+gSmUqB1ugz02V2v2DY6z/W7xIOUb+CXAhZlorx2xOFZ3jg2Ct/x987bX2NiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802613; c=relaxed/simple;
	bh=jTSBj9jLKNKdi0y3iM/C7gIWXZXoGI4kcvR3ImuT2Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBkpbG+wNkrDNYVy8p884tW6SRs+XAwMoVBe0j3w/M7HSTobdwiqmrjqR6LiqMVolVFqJyRMxMb1m2XYKSetRNasCMJAW1jZ3AcBUgM44ZhSesOQC7PkN5aY7MOYCLSYnWlAn+4sUmNe4f9uYMqboBf/TZViFQAFzfVIagxiQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F5Bv4Gym; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411C8KTD011165;
	Thu, 1 Feb 2024 15:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YE5DgA3kYqy7egRBGYJ0PPp5ECW0xBYESXgrdcxB00w=; b=F5
	Bv4GymmqaatmbDfaPuSM5N+LZGtO/NnJYyHGDQ3ae3/yf77DHW4Np3khSnQdK14/
	fqqYkznHYVWhXQMl6wWIj18MgqAIiB7Myg2BwJA7ISOuzwtUuIEvTd71Ki3Qk2LF
	z87OAe0D7w7vI/Xkjwhqgz0knez92OVqvEaJOxIH3HoLwT1wWkfK8RD9wzLM3HEC
	cQ6SQvT96yMP4f29zZyMm386NhjM6bUYafwkD8nz7u5Wl+UiB2indZ+xqdh4SVLD
	kSNmix9Yn45xZF2dp/AW2arzo6amdAzNfeVv0NThp4S6b8ORcXZzIiJ81s8MAx3Y
	EUJUm43zWf7EkgqVal2w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b1qrgtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:50:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411Fo6h1010237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 15:50:07 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 07:50:06 -0800
Message-ID: <1818e068-4075-4510-8985-f05e124d1246@quicinc.com>
Date: Thu, 1 Feb 2024 07:50:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
 <119d60053afa6f5eb9af6597d895f1da1065d7c5.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <119d60053afa6f5eb9af6597d895f1da1065d7c5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PgVUv0zUEf9hxfhMnPvV0pEe5TU5uXJD
X-Proofpoint-GUID: PgVUv0zUEf9hxfhMnPvV0pEe5TU5uXJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=966 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010123

On 1/30/2024 6:22 AM, Johannes Berg wrote:
>>
>> Move puncturing into the chandef, and adjust all the code
>> accordingly.
> 
> So I clearly forgot ath12k in "all the code" ;-)
> 
> Looking at the code, this seems to be an appropriate update for ath12k:
> 
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2767,10 +2767,6 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>  	}
>  
>  	ath12k_mac_fils_discovery(arvif, info);
> -
> -	if (changed & BSS_CHANGED_EHT_PUNCTURING)
> -		arvif->punct_bitmap = info->eht_puncturing;
> -
>  	mutex_unlock(&ar->conf_mutex);
>  }
>  
> @@ -6215,6 +6211,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
>  		if (WARN_ON(!arvif->is_started))
>  			continue;
>  
> +		arvif->punct_bitmap = vifs[i].new_ctx->def.punctured;
> +
>  		/* Firmware expect vdev_restart only if vdev is up.
>  		 * If vdev is down then it expect vdev_stop->vdev_start.
>  		 */
> @@ -6311,7 +6309,8 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
>  		goto unlock;
>  
>  	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
> -	    changed & IEEE80211_CHANCTX_CHANGE_RADAR)
> +	    changed & IEEE80211_CHANCTX_CHANGE_RADAR ||
> +	    changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
>  		ath12k_mac_update_active_vif_chan(ar, ctx);
>  
>  	/* TODO: Recalc radar detection */
> @@ -6371,7 +6370,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>  		   "mac chanctx assign ptr %pK vdev_id %i\n",
>  		   ctx, arvif->vdev_id);
>  
> -	arvif->punct_bitmap = link_conf->eht_puncturing;
> +	arvif->punct_bitmap = ctx->def.punctured;
>  
>  	/* for some targets bss peer must be created before vdev_start */
>  	if (ab->hw_params->vdev_start_delay &&
> 
> 
> Any thoughts?
Looks good

