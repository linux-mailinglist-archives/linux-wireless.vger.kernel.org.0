Return-Path: <linux-wireless+bounces-9262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C162A90FBF0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 06:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605FA1F220DF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 04:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC722EED;
	Thu, 20 Jun 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y+CLMb35"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A084381B8
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718857408; cv=none; b=MuT5gyqwVu4TFtt/FaJ9c9/94Ld1kuedtgfNlxG7o2fkC+dQcQAtO9punOClM+j3Q3GEyF9XdWZHLMnolNCZ+0MHO9JPRjtArR/kXD7oKL6dDfeC924UVygSBfvAT+5sICuDPP7RxE9rbIB9LjTtwyxqTa6pTNtdZwNjE/7HvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718857408; c=relaxed/simple;
	bh=SX0jl+vWdPD8pQU/pCUWjXZ/6R9tAZ3Lcr5rYOjj8VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wmn+cYg8cGTVZrJJtJHdku5LCsOCBmfbeGCQUY6brcmxKLVuui0fCZWJ6nC9noxp8HxNuAQCEt6EYavTwfImHZnijjN125PxCpaK9heoQ5efwZ+rkCd9JBHJcv19PdwnNK93zd1lx51Ext/fagGN/zw14wAQJSvgjxxywg3nXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y+CLMb35; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JNUxxL025755;
	Thu, 20 Jun 2024 04:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Bj8FJaMCS8jKnX1VnafPVpgiQEJjcKXalQEuVh9L90=; b=Y+CLMb35A1utbT/Z
	rju8nONoEcR7OFH1Gui1g6/8Jggf65eVMywDb5FVIYH0Y1UkQ/3CRhumLDByPTbM
	Y+4tnmMxTJji3n+ncT3Vg3AUH5M9+t3bgg0A7dDWy7lo7m/jibvepnJFSMeIdXc1
	KOMuSqc7ckzxCOlSFo/LZiXHP8FRABRb0F0NSgv1DKx5J/q3hC7zXhPX6v/pCKyO
	ItHAumSMWDdbvnDEqYfQvH3LQHLtHFrwGVQzPi7IcooyRpCbuy2p1q6DWzExXo67
	qwbaxhL4a90po0yKwAELWQpi5PgVVWf87H+D9sRUNgD1v5M7So4P3dYfYlcQoOti
	HUJmcg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujc4kcd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 04:23:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K4NEB8001593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 04:23:14 GMT
Received: from [10.152.203.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 21:23:12 -0700
Message-ID: <d1e9897f-c093-48ec-b887-2f5398ea9aa8@quicinc.com>
Date: Thu, 20 Jun 2024 09:53:09 +0530
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
 <878qz1kokv.fsf@kernel.org>
 <eb7ab3a3-4365-44fe-a33b-fdcd47524778@quicinc.com>
 <874j9olu7u.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <874j9olu7u.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t1V4N_UjHbbbB7QnBX0_LHQTsPZ3meKp
X-Proofpoint-GUID: t1V4N_UjHbbbB7QnBX0_LHQTsPZ3meKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200029



On 6/19/2024 10:56 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> On 6/19/2024 7:43 PM, Kalle Valo wrote:
>>> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
>>>
>>>> From: Lingbo Kong <quic_lingbok@quicinc.com>
>>>>
>>>> Pdev id from mac phy capabilities will be sent as a part of
>>>> HTT/WMI command to firmware. This causes issue with single pdev
>>>> devices where firmware does not respond to the WMI/HTT request
>>>> sent from host.
>>>
>>> But WCN7850 already works so I'm not really understanding the bug
>>> description. Can you elaborate, please?
>>
>> pdev id from mac capabilities sent as a part of HTT stats request or WMI
>> control path stats request was not expected by WCN7850 and hence fails
>> to send the stats response.
> 
> Ok, now I understand. Please include that info to the commit message.

Sure I will add the information.
> 
>>>> @@ -81,5 +81,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
>>>>  int ath12k_mac_wait_tx_complete(struct ath12k *ar);
>>>>  void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
>>>>  void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
>>>> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
>>>> +u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif);
>>>> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar);
>>>
>>> AFAICS ath12k_mac_get_target_pdev_id_from_vif() and
>>> ath12k_mac_get_vif_up() can be static, no need to add them to mac.h.
>>
>> Ah! Sure Kalle. I will take care.
> 
> Thanks.
> 
>>> So we are left with ath12k_mac_get_target_pdev_id() but I don't see it
>>> called anywhere. Isn't that dead code we are adding?
>>
>> The wrapper is used by upcoming HTT stats and WMI control path stats
>> support. Initially this change was added in the HTT stats infrastructure
>> support series. Since WMI control path stats also depends on this patch,
>> to eliminate the another patch series dependency, I pulled out this
>> patch from HTT stats series.
>> This wrapper will be used by below changes:
>> HTT stats:
>> https://lore.kernel.org/linux-wireless/20240614063404.2659089-1-quic_rgnanase@quicinc.com/T/
>> WMI control path stats:
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240529180920.1472003-1-quic_rgnanase@quicinc.com/
>>
>> WMI control path stats has to be rebased on this current patch. Since it
>> is deferred, I refrained from sending v2.
> 
> Ok, you could for example mention this is in a comment after '---' line.
> Adding dead code is usually suspicious.

Yeah sure. I will brief the usage in commit message as you mentioned.
> 

