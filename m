Return-Path: <linux-wireless+bounces-19690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C7A4B9E7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FEA1891812
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E51F09A7;
	Mon,  3 Mar 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pAYf73WE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762441EFF83
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991781; cv=none; b=YRr4Zvb+Mp1HIw0MEuy9Aj/avi8PDPl4cswdqyj18G1gPjKdSO3i880EATDyLuv1KvRyZALd+BBprEKt3CbGlqydp2H+8GTGa5Fc3yuffp8urlnvTKehSxDmPBkRSEa0UU7IdMPI8deEV4586eNIMPNx0/6AUvMrD1JdWJwGKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991781; c=relaxed/simple;
	bh=cCIJEjP4WFyBgYxvmaA1Wc9AjDvbOgSOMga7HfIzWZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TEbukGufIZpXOElehXzTAJbYULsSb096uS/n9j0W2IqPsIbcjwedtF5h5dL5ilsl4rjKLBfZ1vLGPmagqSneF81t1YEkYr0cEc1P2Hi9QEyfmc1P1GrUCpzJnQwXb36IR0AaSg+S7RwxXjmde4q/29K2gwbVfti9jH0vQZ1d5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pAYf73WE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522Mqwkq026501;
	Mon, 3 Mar 2025 08:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SB7R5wb1CUoU9LklSw6XvjwTpPpnwfcuvpgCFMuuXtw=; b=pAYf73WEsLKatHlg
	Fe3vrN106dgbcKYk3Bjs7Bz8TTARXZkmhMgMTZN6CkoEDI2A9sA+qclPJDXS94G3
	UGErWoxcKnv6kEtXZDd2wmrCggQSeVdt0GjIbA0xGk8AGjngq33jgzdAuXo5Dbpx
	lv5lihjZDkt2dORTJ+Gabj/NuO1eCSU9qwLIwr4j49k52wTDarcS1PfJgWYb+plP
	rObdyEEFvyuOqYoDxXDcQXIG9ftj/HtMAXNKlesWfUTCg09TPuz9m2we7JYukF1Q
	12I8Mirjpdu1QOt6VTVTQtETYGRtZHeD3ruguOE1pjDDScp8JjrM8+tW/ZU+/h+S
	RjkeJQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d40uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:49:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5238nZcR014564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 08:49:35 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 00:49:34 -0800
Message-ID: <f1b35807-fd8e-4883-86a9-3a8beb423c7f@quicinc.com>
Date: Mon, 3 Mar 2025 14:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] wifi: cfg80211: add additional MLO statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-12-quic_sarishar@quicinc.com>
 <193193c23778b6b3c8c786d56b9a28046a35db60.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <193193c23778b6b3c8c786d56b9a28046a35db60.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wLqkRuG0NRp5d8kfbJo1Mi48gDQpDCr9
X-Proofpoint-GUID: wLqkRuG0NRp5d8kfbJo1Mi48gDQpDCr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=831
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030067

On 2/28/2025 6:57 PM, Johannes Berg wrote:
> On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>>
>> +	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
>> +		if (!nl80211_put_sta_rate(msg, &sinfo->txrate,
>> +					  NL80211_STA_INFO_TX_BITRATE))
>> +			goto nla_put_failure;
> 
> You don't need nested ifs where && will do just fine.

Oops, sure will add && instead of nested if here.

> 
>> +static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
>> +					   struct rate_info *link_sinfo_rate)
>> +{
>> +	if (link_sinfo_rate->flags)
>> +		sinfo_rate->flags = link_sinfo_rate->flags;
>> +	if (link_sinfo_rate->legacy)
>> +		sinfo_rate->legacy = link_sinfo_rate->legacy;
>> +	if (link_sinfo_rate->mcs)
>> +		sinfo_rate->mcs = link_sinfo_rate->mcs;
>> +	if (link_sinfo_rate->nss)
>> +		sinfo_rate->nss = link_sinfo_rate->nss;
>> +	if (link_sinfo_rate->bw)
>> +		sinfo_rate->bw = link_sinfo_rate->bw;
>> +	if (link_sinfo_rate->he_gi)
>> +		sinfo_rate->he_gi = link_sinfo_rate->he_gi;
>> +	if (link_sinfo_rate->he_dcm)
>> +		sinfo_rate->he_dcm = link_sinfo_rate->he_dcm;
>> +	if (link_sinfo_rate->he_ru_alloc)
>> +		sinfo_rate->he_ru_alloc = link_sinfo_rate->he_ru_alloc;
>> +	if (link_sinfo_rate->n_bonded_ch)
>> +		sinfo_rate->n_bonded_ch = link_sinfo_rate->n_bonded_ch;
>> +	if (link_sinfo_rate->eht_gi)
>> +		sinfo_rate->eht_gi = link_sinfo_rate->eht_gi;
>> +	if (link_sinfo_rate->eht_ru_alloc)
>> +		sinfo_rate->eht_ru_alloc = link_sinfo_rate->eht_ru_alloc;
>> +}
> 
> I don't understand the if statements here. Many of these do not have a
> value of zero meaning "unknown"?

Sure, let me check if it is zero or unknown and correct it.

> 
> johannes


