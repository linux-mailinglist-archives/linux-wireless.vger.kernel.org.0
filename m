Return-Path: <linux-wireless+bounces-7690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DF8C6A47
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E31F235B1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B2156230;
	Wed, 15 May 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aPuCAAk1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B05156979
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789421; cv=none; b=XHyi91+9rwCpSt7InwAAh+wg1ILg0LKLUo4LS4NwwlU7q/ZbyiipP3yQhJYrFegS7zwWDS/1dXEy8I7F22EhsJ+QV2EvGnGI7WFpfAcr1iKv970ppRhPN1aaw+lqNvwiw9uv+Dl2hrfv/Fr7n369vjpLu6DBL673PZ4XAalUhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789421; c=relaxed/simple;
	bh=kbT2OzXUHxKDFGOONZXT0deKhZzHxfXrrYh19+kcNJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OyrkkwLMb6j5U/AwIrgZRbZ6FZOB2Y939kRiXELVEQUGez9mgsE+Levbq4vI3LagQZKDUPhv+KR6ddocEfEy7UfGZschyWThPioJ6JZ+mpdJ2RQwYGhEfzfprGdT85oCq2+R8QLeJY3yo9P74Ia2V1FP1p3am9tLHiHmG7wLmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aPuCAAk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F90djK027077;
	Wed, 15 May 2024 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1BoKMffnN13x1fegF+z2l1P9ra2w1+Z9uXxcaGttFy8=; b=aP
	uCAAk1Y+4Yrp83IUwbmZ77CewH3L3KKXjp4c4eJId5QEWBQKAx1nFC7QJ+M+b8Ig
	eF4FNZWUzjmO8q0QIqFtongu1BIJiMKci+XCgfZcZLM5gxAJwPHFhtiXOkuSW6Xs
	hRlyocXTBowNX5LyTR5DZYUso/sVPOdZwU+Hrq5F9USE8bjCDeGn6EXN8HPe1rOC
	lkN0l/WULRefQKsdytUPwbUQEAfs7bIXKJFIaM302fekWkhIhBn8vE9ZN11ew+s7
	5sgK+R1X2dfIF2l/EciE0Bo+7EVC0b8SpdV1Z1EKnJZz6LXHaeikUOiMGo2vs4KV
	b1LY0ofIFXTiClXuz14w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47egb8na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:10:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FGA9Rf002669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:10:09 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 09:10:09 -0700
Message-ID: <98a7ac4e-7ba5-453c-8b27-270ac7236677@quicinc.com>
Date: Wed, 15 May 2024 09:10:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-2-quic_pradeepc@quicinc.com>
 <3b7be076-9aa6-4f21-b9dc-7ee04cf26ce7@quicinc.com>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <3b7be076-9aa6-4f21-b9dc-7ee04cf26ce7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _DIZYtmYOwQS4lMojoaxvMHZZB77w93R
X-Proofpoint-ORIG-GUID: _DIZYtmYOwQS4lMojoaxvMHZZB77w93R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=964 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150113



On 5/13/2024 1:49 PM, Jeff Johnson wrote:
> On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
>> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
>> to pass EHT MU-MIMO configurations from user space to driver.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>>   include/net/mac80211.h | 4 ++++
>>   net/mac80211/cfg.c     | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>> index cafc664ee531..d7b6f75bc920 100644
>> --- a/include/net/mac80211.h
>> +++ b/include/net/mac80211.h
>> @@ -701,6 +701,9 @@ struct ieee80211_fils_discovery {
>>    *	beamformee
>>    * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
>>    *	beamformer
>> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or transmission
> 
> suggest you reformat to fit in 80 columns
> (we allow code to exceed 80 columns when it improves readability, but comments
> should almost never exceed 80 columns)

Sure..Thanks Jeff, will address in next revision

