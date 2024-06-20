Return-Path: <linux-wireless+bounces-9263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0790FC16
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D845CB2365B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0281CD2F;
	Thu, 20 Jun 2024 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PtlfJjCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F231B5A4
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859640; cv=none; b=Vr1WMN+1qAliKZUp6odovCdARi4hn6uuWF8QknyKTj3WI9QaeVNs+UUJbt27/gyWVLqnhpZd/2wf+cEPwh1puuSoQFcV02bObF0KfoPLiYBvA9Jn4y6e0yslJM5yXY8qOAIPSu1TB3qKzApWNytTo8JXLAE+ZLrxbPX6vpjpOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859640; c=relaxed/simple;
	bh=mLTBH5ieVx+Wdo9M3N0EZv1JQTVK6C0Efl3hviV5zIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U0SNkc0pDeT/ChB5K5aNdiWgUnI1fZHx5yafXrSJlMdhF/IjUQfEfIlmGf7v2m91zXEog1rMykOig4tvjFJ9TIg3UtQ7rkCjEirCCeIAwxjU3U3Mmgm4YeYevtd0bOqwX3J2MwYrrs+BDMayL82J2u9rombZol/8XrqxXEuPsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PtlfJjCF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JKcX6U023321;
	Thu, 20 Jun 2024 05:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ss9dsFbAq2sILeOap9WZdRDglRvfql8k6A/40bSJUjI=; b=PtlfJjCFnW46c9No
	8mchGUR3CmI224eINYtelbuJ01BlV530fzeGkffDa9Ey1/nIQUXmtUPxAhzscU3w
	CcQFTAhlduAXQ9sApW0r89Cm+xRLseUHFT2wOSBqaWjNbJO2B9JOi3ily55E6ts0
	P20jT1ZLIYoBHvFRIueZASscFnDb5ZQLMIO2LOoAfTBTEtmfE6+m9ccotW9avnbS
	5AKt/m3BqqNZfInbclCOinqAp1bgQg9sI5HOy36nRT5U1OuD/A6PoOjo7FPxypeu
	ALe5ToDi4f3dtt3W6WO5nnNq2uNR1NODAMIoqR4xM74KpxV5t0RtOojk4SntoO13
	BRdJAA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv6hn0ter-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 05:00:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K50WDZ027336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 05:00:32 GMT
Received: from [10.152.203.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 22:00:30 -0700
Message-ID: <b84e9793-d159-4e82-8c2d-90a811e2a3e1@quicinc.com>
Date: Thu, 20 Jun 2024 10:30:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix pdev id sent to firmware for single phy
 devices
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Lingbo
 Kong" <quic_lingbok@quicinc.com>
References: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
 <87zfrgkf8i.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <87zfrgkf8i.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yANB_eUnVp61Vk9ykA1k5bbBqIZAg0ph
X-Proofpoint-GUID: yANB_eUnVp61Vk9ykA1k5bbBqIZAg0ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200035



On 6/19/2024 11:05 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> From: Lingbo Kong <quic_lingbok@quicinc.com>
>>
>> Pdev id from mac phy capabilities will be sent as a part of
>> HTT/WMI command to firmware. This causes issue with single pdev
>> devices where firmware does not respond to the WMI/HTT request
>> sent from host.
>>
>> For single pdev devices firmware expects pdev id as 1 for 5 GHz/6 GHz
>> phy and 2 for 2 GHz band. Add wrapper ath12k_mac_get_target_pdev_id()
>> to help fetch right pdev for single pdev devices.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> 
> [...]
> 
>> +static bool ath12k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BAND band2)
>> +{
>> +	return (((band1 == NL80211_BAND_2GHZ) && (band2 & WMI_HOST_WLAN_2G_CAP)) ||
>> +		(((band1 == NL80211_BAND_5GHZ) || (band1 == NL80211_BAND_6GHZ)) &&
>> +		   (band2 & WMI_HOST_WLAN_5G_CAP)));
>> +}
> 
> This is not really pleasent to read. What about something like this:
> 
> switch (band1) {
> case NL80211_BAND_2GHZ:
>         if (band2 & WMI_HOST_WLAN_2G_CAP)
>                 return true;
> 
>         break;
> case NL80211_BAND_5GHZ:
> case NL80211_BAND_6GHZ:
>         if (band2 & WMI_HOST_WLAN_5G_CAP)
>                 return true;
> 
>         break;
> }
> 
> return false;
> 
> Or any other ideas?

Thanks for the suggestion Kalle. Switch looks aesthetic compared to
conditional checks. I will refactor the code as above for better
readability.
> 
>> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
>> +{
>> +	struct ath12k_vif *arvif;
>> +	struct ath12k_base *ab = ar->ab;
>> +
>> +	if (!ab->hw_params->single_pdev_only)
>> +		return ar->pdev->pdev_id;
>> +
>> +	arvif = ath12k_mac_get_vif_up(ar);
>> +
>> +	if (arvif)
>> +		return ath12k_mac_get_target_pdev_id_from_vif(arvif);
>> +	else
>> +		return ar->ab->fw_pdev[0].pdev_id;
>> +}
> 
> I find this easier to read:
> 
> arvif = ath12k_mac_get_vif_up(ar);
> if (!arvif)
> 	return ar->ab->fw_pdev[0].pdev_id;
> 
> return ath12k_mac_get_target_pdev_id_from_vif(arvif);
> 
> But I still would prefer to have some a code comment explaining the idea
> behind here, especially why it's safe to use fw_pdev[0].pdev_id directly
> and what scenario that is.
> 

Sure. I will get the necessary info added as comments.
Thanks for the review Kalle.

