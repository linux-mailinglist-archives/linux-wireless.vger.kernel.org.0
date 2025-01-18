Return-Path: <linux-wireless+bounces-17671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFDA15A93
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 01:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F77164000
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 00:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09A747F;
	Sat, 18 Jan 2025 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jyAe+l27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BF3FC7
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161069; cv=none; b=X1L4yh14ahZWMAtdJmXzRfnbirnXrEVhTIGRKTZkUscZi2bCkoK0rCaqZoH1T9WYEn4WSHzeSvdviIX+5c5qtIJkkZUKSNMznjtVS4/UiTT8tXR4N+9RLm2MKZ4EE03tvrGGv8XqDdFDSCRaECbKOFgggLdv5lLSku7UD52zPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161069; c=relaxed/simple;
	bh=WuwVpXIxbCpaPE8iiqX0inKFwSgEJg9oVK1JULyM16I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YGceK0fEhAQ3yOOO65DHfi8qBihcAZCFxgG4d8V0d7pcLReDAzuZ8y7rLt5EI/W5i7mFl/4BnQdJO/WdCuv0bm0Vkljzp3OyqWg7a5RPlpcH5wwJP9uYFdvVFrE3oc6KrtkGMyzI1gDkB7PlxqIixGNagzNg1Wh/Fq9Ik1NTdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jyAe+l27; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HH3uAD021752;
	Sat, 18 Jan 2025 00:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QF2bHQkiOJedjeVzAo/ItEPrbadxV22ywrLQQWgxw3Y=; b=jyAe+l27A3X92pvz
	iToghRmUBMu5UnR3OzG9ul5tTFBSKgLrm3V69qBNh5/LMry22yWU+nT8B1De6Tfp
	DpI5igha+AjVtOWnF1+bPzyXov2KIzD1VODUIj3kEFyk+UPeOFiJx6InH0DF27Ae
	CN5QBilSeNzNSDDWdlBheaebIccTxBTjKnb7zSv+dZHEpeKxbBha7egbd+xHgirl
	KNrh9GjWjK1wh6l9G2AtBA9nwMRGiOln/2HujAsMzckvktnvWjHTZ4sh6hbFDWz7
	Wcrx7TUcugPlOaiTS3hATK7SVue1Kj+lPmiTG+5AjCeFoVXqBwZMKlk7MBfNkBnu
	ejM+Fw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447u9b0t5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 00:44:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50I0iO9R016152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 00:44:24 GMT
Received: from [10.110.0.90] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 Jan
 2025 16:44:24 -0800
Message-ID: <6cf46e51-ed6d-4081-ae05-2ccc15704dc6@quicinc.com>
Date: Fri, 17 Jan 2025 16:44:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: Aloka Dixit <quic_alokad@quicinc.com>
CC: <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20250114223612.2979310-1-quic_alokad@quicinc.com>
 <20250114223612.2979310-2-quic_alokad@quicinc.com>
 <1df1e6b4-cb25-4abb-a6eb-1abaeeb5f588@quicinc.com>
 <8a265410-4aaf-411d-a9c1-c215ef9ff412@quicinc.com>
Content-Language: en-US
From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
In-Reply-To: <8a265410-4aaf-411d-a9c1-c215ef9ff412@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2939ams5uX9T02bLI-RUuFmfLvHAr772
X-Proofpoint-ORIG-GUID: 2939ams5uX9T02bLI-RUuFmfLvHAr772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=748
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501180003



On 1/17/2025 4:36 PM, Aloka Dixit wrote:
> 
> On 1/15/2025 11:36 AM, Sidhanta Sahu wrote:
>>
>>>   +static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct 
>>> ath11k_vif *arvif)
>>> +{
>>> +    if (arvif->vif->mbssid_tx_vif)
>>> +        return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>   static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>>>   {
>>>       struct ath11k_vif *tx_arvif;
>>> @@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct 
>>> ath11k_vif *arvif)
>>>       u32 params = 0;
>>>       u8 i = 0;
>>>   -    tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
>>> +    tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>>
>> ath11k_mac_get_tx_arvif can return NULL, below, we are accessing 
>> tx_arvif without a NULL check. Shouldn't we add a null check wherever 
>> applicable to prevent potential issues?
>>
>>>         beacons = 
>>> ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>>>                                tx_arvif->vif, 0);
> 
> ath11k_mac_setup_bcn_tmpl_ema() gets called only when tx_arvif is non-NULL.

If tx_arvif is not NULL (and known already), Is it still required to 
call `ath11k_mac_get_tx_arvif` under `ath11k_mac_setup_bcn_tmpl_ema`?

> 
> 

