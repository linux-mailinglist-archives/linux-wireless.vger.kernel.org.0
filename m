Return-Path: <linux-wireless+bounces-10016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14319288A5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598FE286836
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301A143875;
	Fri,  5 Jul 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SrRHg7j6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2A1442FD
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182396; cv=none; b=Lw2op29V5YL49zSRzszJSu+UmQ+xtfzEFmYSfhJBkN4VLT7UMqW6v2NQ2u8d/9I3nBPPpDhhEaSo89VxZS3p/S9D7GVmW9eLSLtkehBABNh63/LQSvcuoG4zibK2Br52+L1soc88usGRb9LF891rKLhd9G9OSwJznqg+/raja9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182396; c=relaxed/simple;
	bh=JwWoSgBkf2cWoQjmGt7Qo5dE7oJQ1Ynsv2JvcxTvlLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ksc0vfb8EFZUu7aSwg01fbjEmEW9R1s1VtYlbQ0gTa0Y+VWMweBM4TUPzH9WAGaDdcAfYCHyC0aDJ63+1CGF1LQsmqL+UOLZ/ldXODjmU5XFAgeI9lqwlvleJX7fs/6WTMwxhhi6OuuTqwZVhxE8MfB+v1ZgEz+8wEr79nMziVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SrRHg7j6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4659Lwfh026217;
	Fri, 5 Jul 2024 12:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jKNTpUKMPYJjI6Pfh4g91X5/p74oY7ranZ+QwtHPYKI=; b=SrRHg7j65K7g6k2G
	nkFvXgSz9jpBLrMlRLwUZew9JPujQDx5Sxjil+9Z8UeYKnh3SFjQTHUCtGGWHPPa
	NT2JI6ibotfxNM8pxy3NdqcDamGTE3RUT2XXpngjH6bhY3NDHwo/JUEkLaJDWZpQ
	LJg9EwpK08gNcfRosWutiiHqD7EPt/Vtvaxq4TNDhGuU1ZvP+djVOHS9SJY/cgLz
	VoW8Z7v1mhIZYwCxpAtOuoyBYqYwp98Tx6JHPdzbRaHrckZHDm82Cct6W9XNdpik
	mLj3HkiJeKgxUE7/D/YS0hih57YvlvaYES89C1kJ5aduNGFPV884PjWh5qEwqNLd
	7nLvTg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4054ndwt3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 12:26:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 465CQUmv001585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 12:26:30 GMT
Received: from [10.50.10.246] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 05:26:28 -0700
Message-ID: <190a23f9-6898-a389-66c3-a99659376efb@quicinc.com>
Date: Fri, 5 Jul 2024 17:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] wifi: nl80211: allow MBSSID Tx VAP bringup without MBSSID
 IEs
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
 <dc5f37a389d05881f2b2120e0ccbb60aa64c6490.camel@sipsolutions.net>
 <ad821e08-b6d7-1355-6665-e96af668bd2e@quicinc.com>
 <2f955c9cb8828c78845dbfb6ffb7838f8a75c7ea.camel@sipsolutions.net>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <2f955c9cb8828c78845dbfb6ffb7838f8a75c7ea.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4gXpjoRFnVuQ4tTI8iFM8feDE1OCYHzS
X-Proofpoint-ORIG-GUID: 4gXpjoRFnVuQ4tTI8iFM8feDE1OCYHzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=831
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407050091

On 7/4/2024 2:28 PM, Johannes Berg wrote:
> On Thu, 2024-07-04 at 13:01 +0530, Sowmiya Sree Elavalagan wrote:
>>
>> I agree, but based on the current hostapd implementation, this flag NL80211_MBSSID_CONFIG_ATTR_EMA is set only when num_bss > 1. This flag will not be set when we do not have any non Tx BSS.
>>
> 
> Sure, but "based on the current hostapd implementation" isn't really
> enough for the kernel to protect itself from userspace doing weird
> things that it isn't prepared to handle :-)
> 
> It is, however, an argument for simply prohibiting it, I guess? If no
> userspace is going to do it anyway?
> 
>> Even if this NL80211_MBSSID_CONFIG_ATTR_EMA is set when no TX BSS is present, can just fill beacon template in 0th index of ieee80211_ema_beacons structure, if mbssid_ies are not present.  
>> Shall we handle this in mac80211 layer in ieee80211_beacon_get_ap_ema_list function like below
>>  
>> ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
>>                                  struct ieee80211_chanctx_conf *chanctx_conf)
>> {
>>          ...
>>
>> -       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
>> -               return NULL;
>> -
>> -       ema = kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
>> +       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt) {
>> +               ema = kzalloc(struct_size(ema, bcn, 1), GFP_ATOMIC);
>> +               total_beacons = 1;
>> +
>> +       } else {
>> +               ema = kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
>>                       GFP_ATOMIC);
>> +               total_beacons = beacon->mbssid_ies->cnt;
>> +       }
>> +
>>         if (!ema)
>>                 return NULL;
>>  
>> -       for (ema->cnt = 0; ema->cnt < beacon->mbssid_ies->cnt; ema->cnt++) {
>> +       for (ema->cnt = 0; ema->cnt < total_beacons; ema->cnt++) {
>>            .....
>>
> 
> I don't know, is that really the only place? I didn't audit _all_ of it,
> just looked at the first plausible code path that might be broken ...
> 
> Why can't we just prohibit it?
> 
> johannes

Hi Johannes,

You are right, better to handle this in kernel. Shall we mandate num_elems and mbssid index check if EMA is enabled in nl80211_parse_mbssid_config function.
But we will have to revisit this when dynamic link addition is supported along with EMA. 

Thanks,
Sowmiya Sree


