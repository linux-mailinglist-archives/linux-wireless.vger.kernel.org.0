Return-Path: <linux-wireless+bounces-23022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC09AB8D0F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69274E6020
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA725486B;
	Thu, 15 May 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y1HOzAuf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF571255F4C
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328380; cv=none; b=RHinhZ94aEShz9AzsLGkXp8F1Zx7p/pWy0wV9dlflZdMHacwsr88Jr4YzRl0sR2Zyeq321FHQxHEQhA1n84Ga5TpiKwilkU6H9ynk/CTkAGJjJOt8yLTMBIecTTxAVTF8bXwY465F1CPRsChvC2fV7TxANU0+IMa845uagjuK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328380; c=relaxed/simple;
	bh=80ObrB87BFXJFL5U5r1Kc2ET55KOvLvtkIlxVldTQMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JtKUYrbL/D/Iv4wThMdM5CqlZdm1kjRNVa24YIXawX5p+gND8kBaZYxorsoFEQ8LElUNnQt70cUWJHMqPoc3vBg9Tn8099HCVCY9yVk/3u7tiBgbCRPUizI29mHiLL+Mxdiwz9Eup6C5beKVM4/cjYtI26H7q2oucdBErtWJNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y1HOzAuf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFWU7021293;
	Thu, 15 May 2025 16:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R3wJt2PymzRCtkn+u9kPOUDTyVxnts5dlj5274R8yTQ=; b=Y1HOzAufCinALCy4
	3LMFxmkQF2s8lX6N/usZZdRGL40EzO36O2EgBpgweJ5cNow5mJHTJUuf7To+aix5
	rYqOaOREHLhY2Wvujd1cCFBPKLDm2E3Nop4amZnsLpOhmszv4KKWoQwoPIoBpX9w
	o9FTbur2DGvwXhx21rkmzscLIT7/9V61Hr+wVxiK8+HA4vpJ4nsGHOMLc76vZKOZ
	3yQrvJmgYG6TmQeNgxvfbZ66yrMDuf/02LutVwY8Wwibwykj26QpMIPr4VS+OeN9
	nkUR88O/rKKKXbmSdQaN9r1w/VAYk3+RClPiXHKUf4KieyV/62bY/XWtKffboVIT
	NwwYvA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew6v9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:59:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGxWw1005158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:59:32 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:59:31 -0700
Message-ID: <d0a54110-b877-49db-b199-a4df55eec97c@quicinc.com>
Date: Thu, 15 May 2025 22:29:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 04/10] wifi: cfg80211: add statistics for
 providing overview for MLO station
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-5-quic_sarishar@quicinc.com>
 <e5547e0b3e476bccbce629fa0c7d7e4db9556822.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <e5547e0b3e476bccbce629fa0c7d7e4db9556822.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LmdBnbeKt6BA1qSdECsmO4GUX3AqBwTx
X-Proofpoint-ORIG-GUID: LmdBnbeKt6BA1qSdECsmO4GUX3AqBwTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2OSBTYWx0ZWRfX2FUOA/jkuIg4
 ne9D4P08s0Gx1G0unSLUtleYMQfrhAlFmXw8S/rs/X9QSfHk8hjWkfN72xnOY/Iyu7jFLXoAoAP
 sJUfoyr9gNITl3soFwKLX2dN4e/dsSTGL5R0fNaBUELa/jZE3FE/XokHwosVYB2TcDko8FdVF6c
 9DJjVhFIPyNA9jOiQ3ik9Hqlzcbk0OgVI/xPN/ua/8Fe3zL1KWLdqljvFmkJKRI81rURRwGDdrg
 fVoasGX6N9h7Wskm2xTdwE8sGxfld7yPZ4klIoM5Th2xMgsSa74i3pHf3gTniDJwAm9za217f5L
 sg6INDGoy+EWMeG88H+Wx4OG8hYwvfOj3/KV/0cgz+KM45U+ff51F53vFuxw8rPYLOtclDcjUfW
 5o02zzqSzihAZnQ5J8FQR/IvKbElpCF3LMpxOuKGuZaZTeudZ0fJN3zUjVJaNPaZkQSlH4Kb
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68261d75 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=W1dijrUWnrQc4QvUtGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=957 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150169

On 5/15/2025 5:05 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> +static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
>> +					   struct rate_info *link_sinfo_rate)
>> +{
>> +	sinfo_rate->flags = link_sinfo_rate->flags;
>> +	sinfo_rate->legacy = link_sinfo_rate->legacy;
>> +	sinfo_rate->mcs = link_sinfo_rate->mcs;
>> +	sinfo_rate->nss = link_sinfo_rate->nss;
>> +	sinfo_rate->bw = link_sinfo_rate->bw;
>> +	sinfo_rate->he_gi = link_sinfo_rate->he_gi;
>> +	sinfo_rate->he_dcm = link_sinfo_rate->he_dcm;
>> +	sinfo_rate->he_ru_alloc = link_sinfo_rate->he_ru_alloc;
>> +	sinfo_rate->n_bonded_ch = link_sinfo_rate->n_bonded_ch;
>> +	sinfo_rate->eht_gi = link_sinfo_rate->eht_gi;
>> +	sinfo_rate->eht_ru_alloc = link_sinfo_rate->eht_ru_alloc;
>> +}
> 
> What, no. Remove this and just do
> 
>   *sinfo_rate = *link_sinfo_rate;
> 
> johannes
> 
Oops! yes true, can directly do this.
Thanks, will correct it.

