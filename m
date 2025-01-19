Return-Path: <linux-wireless+bounces-17680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE5A1603D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B0C3A5FDE
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418D15350B;
	Sun, 19 Jan 2025 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AenSeMhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928929415
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737262671; cv=none; b=P5ZQP+tku3wqoCnw90Hzns4WTPJ/gTDUD8PKE4eXpYS7VUC8sfNYMKDaaIbtpn4ux+k3JL8RNG1CX5GqNKtE/o70qxVOTbOvR6MBtZQAClzbaMStO0/EBlqXJ+O5bjaNvrw+2vRQ7z6BgANK1dSb7MjU8wodjiqaKG5NmLdjDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737262671; c=relaxed/simple;
	bh=C7BJuacm4BLIMZCVHuJhCccR9FPeu9IGEuMGDf632JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ITBSHw+ZT7MbE7t72E9f/BiH8JxTW0WzHRRG8vyfUuGygtV+/qdb4PEcnWYwpTwoTX86Ti79TFcV/Rxc4sv/uVlIK1aTZw1H9YxOMu623H6Ct48QsstYijahsOr4FohIQkJ88+wT9b7fSYRiqOM57ym8ba4NT4bNTdDhusbNpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AenSeMhO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J4SwsM019859;
	Sun, 19 Jan 2025 04:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fBJC0BWbM8m/Zp8eyfeMxLzRPIwwchPnF7al3UVrDfY=; b=AenSeMhOLzoGKrq6
	aBfrUKEVkgNn1/8fxPEE/V/m9qR6WW1TFcQkqHQPAbQR8Vca9pFe5XTYCnX9leV7
	9yEbf59GFEMuxlG3cfjUTB8Rx44d3WmSwgvvkHI/mU+ehwyFpzEr1TBCQhoOegGf
	ex/e8hXiwQkBhUVCOSezxcuqYvsv9ma3wQHGUj2Uhi0xdTOjtiVQcyzfWDOplDJe
	WvnBJnCNBw4mnyxg+w2ohA0a99iBSdgOPKY0rVGeCbgXYBH7sKJhGpdeBX7YZeAc
	EelIvghj5u6Pj9A/PDVBBQVDlEiMjlZ8RWQCFcTSp+TYCf1qVo0naKghkiU7UQhC
	exJj9A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4485fhsf8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 04:57:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50J4vcN5021331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 04:57:38 GMT
Received: from [10.38.243.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 Jan
 2025 20:57:36 -0800
Message-ID: <a8f5946b-604d-4c1a-8ece-7705d52e2d4a@quicinc.com>
Date: Sat, 18 Jan 2025 20:57:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: Sidhanta Sahu <quic_sidhanta@quicinc.com>
CC: <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20250114223612.2979310-1-quic_alokad@quicinc.com>
 <20250114223612.2979310-2-quic_alokad@quicinc.com>
 <1df1e6b4-cb25-4abb-a6eb-1abaeeb5f588@quicinc.com>
 <8a265410-4aaf-411d-a9c1-c215ef9ff412@quicinc.com>
 <6cf46e51-ed6d-4081-ae05-2ccc15704dc6@quicinc.com>
Content-Language: en-US
From: Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <6cf46e51-ed6d-4081-ae05-2ccc15704dc6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 90iNH0c5gAR6ZvF0tb2Aa7B40vwsW-nU
X-Proofpoint-ORIG-GUID: 90iNH0c5gAR6ZvF0tb2Aa7B40vwsW-nU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=566 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190039


On 1/17/2025 4:44 PM, Sidhanta Sahu wrote:
>
>
> On 1/17/2025 4:36 PM, Aloka Dixit wrote:
>>
>> On 1/15/2025 11:36 AM, Sidhanta Sahu wrote:
>>>
>>>>   +static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct 
>>>> ath11k_vif *arvif)
>>>> +{
>>>> +    if (arvif->vif->mbssid_tx_vif)
>>>> +        return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>>   static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>>>>   {
>>>>       struct ath11k_vif *tx_arvif;
>>>> @@ -1538,7 +1546,7 @@ static int 
>>>> ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>>>>       u32 params = 0;
>>>>       u8 i = 0;
>>>>   -    tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
>>>> +    tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>>>
>>> ath11k_mac_get_tx_arvif can return NULL, below, we are accessing 
>>> tx_arvif without a NULL check. Shouldn't we add a null check 
>>> wherever applicable to prevent potential issues?
>>>
>>>>         beacons = 
>>>> ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>>>>                                tx_arvif->vif, 0);
>>
>> ath11k_mac_setup_bcn_tmpl_ema() gets called only when tx_arvif is 
>> non-NULL.
>
> If tx_arvif is not NULL (and known already), Is it still required to 
> call `ath11k_mac_get_tx_arvif` under `ath11k_mac_setup_bcn_tmpl_ema`?


Yes, as per the current code it still needs to retrieve tx_arvif to be used.

This patch 1/5 only creates a new function to refactor existing repeated 
code.

The next patch,

https://patchwork.kernel.org/project/linux-wireless/patch/20250114223612.2979310-3-quic_alokad@quicinc.com/,

adds few more changes on the same code.


