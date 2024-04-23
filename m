Return-Path: <linux-wireless+bounces-6733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307EF8AF363
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F9E1C2215F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59E1350F2;
	Tue, 23 Apr 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CrmphLDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFA13CA97
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888089; cv=none; b=KTKBZzdjuDqWON4tvwcywef9q7mhxPCHNR1d+CYqBc7pxtBCsXUZKNRulLOyk81B7PeKOSkQfknox1YkG9X1Xy88+Yc1jfimhbC65DACy/OOJ9KVV6vpx+caeJB9x4oHacLTNR9J8DF5LGbzKspScnM3aOfQ5aQAArrqdwYEWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888089; c=relaxed/simple;
	bh=dj3jOKCrGIkNVnYDB28AtFbkH3umjF7XlfVkhD4h5fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L1A2lpZ8Pe7heRaIYEuDdahWnG5Q/r6+L3pEObb2LBGUV7kbI4K27zawyDQlLAQjP5xqFHB8xgBkupJveHc5xK4CiYSteOVhuxVv2pUhZhBLbLav7fnNgc4sLTe7i2CXZ8q5c1uEoZLM0nQYR2PPtEpJvtiVelhQCojISac1OOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CrmphLDQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7uKGC007932;
	Tue, 23 Apr 2024 16:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ra7+mEfUpCtR0s5cPk0OFG/Py5B9+cSpYZgM96IxNV4=; b=Cr
	mphLDQMDYT+rLotkOvJzl603cl46EEv0GUUNyOPwOgONzOf9AiPA96CB2ClJEV32
	4qO1x1O1B5V5DbZkOcxScqIsoPkkjGLEt5cfaAQOWrgR7I+KLxdzp6JbX/Lyne8A
	Cf0BCM+LhmHMgIhi++5nMtrM0DVdzdAJS0Y7sWsiIFldnv5sZUeT4hb6o0GFTFJ+
	y+hnMPmmIRpEyhAGv2fdaFaMr5DHLppuiOZizNduF5bb6JN3i3jHNuCo/BofGFOV
	9vdACIp70eYK6ts2w/L81CDD19IxbfySdaVGpLerPaIW0u3pFSSi66x1FEFszJpg
	Z1VvxFdznF+nHznw2KSQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91fhdaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:01:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NG1CqY007531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:01:12 GMT
Received: from [10.50.9.167] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 09:01:10 -0700
Message-ID: <d534ee27-0513-5c3b-b4a0-730a67fbf78a@quicinc.com>
Date: Tue, 23 Apr 2024 21:31:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/13] wifi: mac80211: Add multi-hardware support in the
 iface comb helper
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-12-quic_periyasa@quicinc.com>
 <ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fEMo4wzjnc4vQ5BlJvJTI7q5plZHfMqh
X-Proofpoint-ORIG-GUID: fEMo4wzjnc4vQ5BlJvJTI7q5plZHfMqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_13,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230037



On 3/28/2024 8:11 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>> From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
>>
>> Currently, iface combination param supports single physical hardware.
>> To support multi physical hardware, add hardware specific checks on the
>> channel context creation and populate hardware specific parameters from
>> the channel definition for which the interface combination need to check.
> 
> I haven't gone through this patch in detail, but again like on patch 9,
> I'm not so sure about the implementation of the XOR behaviour of
> checking global and per-HW limitations.
> 
> I probably wrote on the other patch that it seems it should check both,
> but I realize now that doesn't make sense: After all, the top-level
> combinations data must encode something that's supported _regardless_ of
> channels, so likely only a subset of the combinations supported across
> the different HW.
> 
> But that doesn't mean that I'm yet convinced that the design in patch 9
> is actually good, with how it checks that depending on the 'chandef'
> parameter. I'd like to explore other possibilities such as a different
> function for that, for example. It could use the same underlying helpers
> and mechanics, but it seems that might be better overall.
> 
> Or probably better yet: explore an approach where mac80211 doesn't even
> have to _know_ about the cfg80211_get_hw_idx_by_chan() and all that, but
> just prepares the information in a way that encodes enough data to
> handle that, which really means going from
> 
>   int num_different_channels;
>   int iftype_num[...];
> 
> to
> 
>   struct {
>     enum nl80211_iftype iftype;
>     u32 freq;
>   } interfaces[];
> 
> or something like that.
> 
> 
> I was almost going to write "links" instead of "interfaces" there, which
> reminds me that none of this really even works well for MLO yet. Not
> sure if that's better addressed as a separate first step?
> 

Sure, will post this change as a separate RFC patch.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

