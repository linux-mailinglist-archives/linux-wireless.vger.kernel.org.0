Return-Path: <linux-wireless+bounces-2794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A768421AC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AFA1F239C1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB671627F0;
	Tue, 30 Jan 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BHu39B9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AD57874
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611408; cv=none; b=oCeii5Cy3x/RlE9QOBMNI1dH9rCORQLBZoZusH5IytfAB2OwuBV/FNQ+lvfuOYoe4wHYov++rA2Jr68etL+BG41hsTrF8KdCPfvx+U6w3WdbUzmiDfMaUakpl4pxeLi66Ss+/r3ed3kG0WhxgjIaHSG6zog/bEtSWRLTy0xX39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611408; c=relaxed/simple;
	bh=DWyobt2SWb3rFgiWQXaxn5ff9jN+AV2YKknl7iEoNFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8sOhU30+uUuMsECfX18eW4Wia/yYQPPHslncpFcwfbut3Snmn0YeMNsowWcfv1U6eepp7RnjBFqcfPXZgMTVToGh8tLQqW3ewNL1YF3eDq84hF3I5bgaScJBPaoYHYHKbXo5qQ3Vm7VraOJQykyERQNXvdCPCvBVxn19d+0meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BHu39B9/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UAUDp2006137;
	Tue, 30 Jan 2024 10:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZcLHVWWt1jUm9GZyPCv2SZPVscI0UUeHdptB7axJaO4=; b=BH
	u39B9/9DRaWlxLw+k7xFtIpTZ0Jxy37NQUKoif9Me+qxxH7Mjk1pXHsRp+vdOsGW
	E67G1Go2yyAp9IOq42ivnidC8nQJI6TirltQl4V87AO5BKs2UM6xOhAA85oxMqe5
	n+23IiYD8Q4IC4cIGGd3o/73hue4rDM3zt34TbuA+wy11Vn2HD4RkUGUesai/6hB
	r5JUPSML6h/1NphfU9Yzy3AfXALq5VMwYb3lRW8dGJ6nd7pLv6vYHPzDxG3GFx+y
	QEO+MPXY/HO2q50U5/Lsv7O9JTIxWQW32gnDKPyQNGrqePFMabEPeW36KXJu4wrW
	Angfk+mlA6uEB2JOG2Rg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxydh00x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UAhLZ3030145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:43:21 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 02:43:19 -0800
Message-ID: <55d1aea6-8721-4774-9f09-549245461ba8@quicinc.com>
Date: Tue, 30 Jan 2024 16:13:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] wifi: mac80211: handle set csa/after_csa beacon on
 per link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
 <20240130043225.942202-4-quic_adisi@quicinc.com>
 <1e73c061653abf8e5f1671ae026e0905b2fb4ded.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <1e73c061653abf8e5f1671ae026e0905b2fb4ded.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B2Zd6OREZ-FEjMIfYkwN5auKd4uEzXU1
X-Proofpoint-GUID: B2Zd6OREZ-FEjMIfYkwN5auKd4uEzXU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300078

On 1/30/24 15:47, Johannes Berg wrote:
> On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
>> In order to support CSA with MLO, there is a need to handle the functions
>> ieee80211_set_csa_beacon() and ieee80211_set_after_csa_beacon() on per
>> link basis.
> 
> nit: "on a per link"

Will address in next version. Thanks.

> 
>> Add changes for the same.
> 
> Is that some cultural thing?
> 
> I always find this phrasing with "for the same" very odd, and would
> rather say something useful such as "Implement this by passing the
> correct link data"... but I see this a lot, hence the question.
> 

No idea :). Even I have seen these quite a few times and thought that 
may be it is fine to use it that way. But I do agree that instead we 
could put something useful instead. Thanks for pointing it out, I will 
address this in next version.


>> @@ -3658,7 +3659,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
>>   
>>   	sdata->vif.bss_conf.csa_active = false;
>>   
>> -	err = ieee80211_set_after_csa_beacon(sdata, &changed);
>> +	err = ieee80211_set_after_csa_beacon(&sdata->deflink, &changed);
> 
> weren't you just saying deflink shouldn't be used?
> 

Correct. This patch's aim is to form the base - basically modify the 
helper function to accept the link data argument. But at this point, CSA 
is not started on per link basis hence in order to keep CSA working 
still as it is before this patch, have used deflink here. Functionality 
wise, this patch is not bringing any change yet.


>> @@ -3928,7 +3930,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
>>   	if (sdata->vif.bss_conf.color_change_active)
>>   		ieee80211_color_change_abort(sdata);
>>   
>> -	err = ieee80211_set_csa_beacon(sdata, params, &changed);
>> +	err = ieee80211_set_csa_beacon(&sdata->deflink, params, &changed);
> 
> dito
> 

Addressed above.

