Return-Path: <linux-wireless+bounces-14655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31339B4EF3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DB280D0F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70032195F22;
	Tue, 29 Oct 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mesYqOdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B83234
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218262; cv=none; b=ST0zzGo837pxLeyMfqX3v5Tq6K3T01CDWa/vEk9doPmd45mMdJjwpdg2PiT/c0iam8n6OG+jhb4/Ew/iwhJplugZMPgbRdHULStPpRD1jk5Rehkq9hH6C5oDPWi16kobGsbcLj//0irO8P9xKmYqTwL6tIcDRI+eLD8QOVEZkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218262; c=relaxed/simple;
	bh=3auKhJL6icMkhfC7lU9EYnV3Mv8LjnFYia10S4FmcVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5oyGG7S0vnrKL/Sor7eok4TtQIjge0bmETFNs5s7wXUz9SvD6tZ+RbjSjVx6FMem6Qes7hQ0P//hgWzu699FMRPYU1T5pY7vjTbReRqlvyLfRukmuIKIBGaeuGv7akOLO19BVAgVOyTXlffBtCO6YQbRSnyqYX8FhELAxGq1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mesYqOdW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9YS9B000668;
	Tue, 29 Oct 2024 16:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3mt9pH/78oE5zuJU2bKByu8PR41r20/+DXKfBeBXsAw=; b=mesYqOdWCXzfq1R6
	A5HHOa6Qjh/0p4vxuwBzMeQeUMJMEgaHCBUjoB6/BRTJOu3TeFCIkjJ6An80LEDV
	MwkTDPFMKwzdibUvWhrZhho46C37UEiTplEdUbsTtbQH3RhAzXnYDFieS76OTD/k
	xGkbT8o/YPcFsYgdxgWWD8og17vea+q/+GyJ6tNYbAanuzgWNagG3dS21ms9GDUH
	HkeI6OtaCq/r2uRmN1Lb4caRV7DDjrehYaNnEQ+WUE4Fs/1KogwZ9YiswjIK5G7Y
	CldQPRZt8zB3dY2zwQbdDkKdDPboFc3ttMdhPn4bqn9ddqA13rsVFv4dxeAFibBj
	TQi+Jg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt70xb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:10:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TGAreo008774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:10:53 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 09:10:53 -0700
Message-ID: <bcdd7464-8969-4ace-9a68-d40919bc1d59@quicinc.com>
Date: Tue, 29 Oct 2024 09:10:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] wifi: ath12k: Add MLO peer assoc command support
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-9-kvalo@kernel.org>
 <cb386a9b-2290-4640-8f08-7834cf4e79df@quicinc.com>
 <87o732gahz.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87o732gahz.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WIer5tUpHHwb1pUwClQWe0NshPsCHUgL
X-Proofpoint-GUID: WIer5tUpHHwb1pUwClQWe0NshPsCHUgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=864
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290124

On 10/29/2024 9:05 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 10/23/2024 6:30 AM, Kalle Valo wrote:
>>
>>> +	rcu_read_lock();
>>> +
>>> +	i = 0;
>>
>> nit: setting i=0 doesn't need to be RCU protected
> 
> Yeah, but that doesn't cause any issues and this way it's closer to the
> for loop where it's used:
> 
>>> +	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
>>> +		if (i >= ATH12K_WMI_MLO_MAX_LINKS)
>>> +			break;
> 
> [...]
> 
>>> @@ -2243,12 +2251,38 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>>>  		ptr += sizeof(*he_mcs);
>>>  	}
>>>  
>>> -	/* MLO header tag with 0 length */
>>> -	len = 0;
>>>  	tlv = ptr;
>>> +	len = arg->ml.enabled ? sizeof(*ml_params) : 0;
>>>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
>>>  	ptr += TLV_HDR_SIZE;
>>> +	if (!len)
>>> +		goto skip_ml_params;
>>>  
>>> +	ml_params = ptr;
>>> +	ml_params->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_ASSOC_PARAMS,
>>> +						       len);
>>
>> this is another instance where we are using the same length for two
>> consecutive TLVs -- that doesn't seem right
> 
> This is also a similar case of _hdr() vs _cmd_hdr(), does that look ok?
> 
here again this is evil. please change to _hdr() and explicitly subtract out
the tlv header size


