Return-Path: <linux-wireless+bounces-12789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FA9752E2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2831C21EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978D18C91D;
	Wed, 11 Sep 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="coZX4pI5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3099186E24
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059077; cv=none; b=rOjVgQtY7HsB0o6nlOADO5f1Vcos7rVRnIr8jvnADXThCSpbEPnxxb0DDjHBhqV01ebsH16dR09eAz5CqzvGi+LBXPcBhUrNoXZVnX/8jhc+i/CXDWA2SXpB4oYf0m3xg6e3E7AFo+Mq6/cYb/H+O7TbHOq3fh7El5dXSXLdcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059077; c=relaxed/simple;
	bh=kYLQrV0wG3y0fRFATw3WZIKLbvqRXEf5jajmEFwJn+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VYEOThM46rZMp7NMGOr+qF//gE2IO/MuvVgQpFFH7CNQqIeDVXLz0Rstnj3Fg2Gs/HTrLdMrXRUnaCYBwR3/tPo+ga5JZyCzCacVmV1GxKPdrVAznmBCfqsGUz/xtDch6dVRWh+Iv3NrqELuYRkN84yft8B219LkwxSDXN2aKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=coZX4pI5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B3Gelb013216;
	Wed, 11 Sep 2024 12:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2GMx5jM80kywV4woRhvn6bg6T7yTajQuWd3IMRuKevY=; b=coZX4pI5hzu+gVJx
	NkGOCXnhKzsg8MQiHlrSEKatk57sCwJyO+I8Y6eildrI7KRyeStV9WDhp2J8+828
	qYW5Oj2k/t8Z51G5qkIcGTN9Kp4T7op3iBdv5DHQxc9ToheyWn2zL1f6PCp+ZXBQ
	B4p54iZMhwRF3ThAHAmnEw+FjBWuSA6Z47S9E5joRch9qZDp33jUOKjt0HmIkaaB
	Jt0UlZS4ph8mM3rvENadMPXbc5pDEz1bMLMIUyzqzXUyl9JCI4OvQ8UFWMXio+8+
	IYUs/8XRml1vnLoIE42tSJOaCqIUS6cEAil7oKcIa/24tZ1cR5R89s4H5wSoKDF/
	qLxUpg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6ssq7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:51:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48BCpATp026428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:51:10 GMT
Received: from [10.50.37.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 05:51:09 -0700
Message-ID: <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
Date: Wed, 11 Sep 2024 18:21:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2C1cH8lrEXhQ5X6TiukXGcr8z2Tx8FZF
X-Proofpoint-ORIG-GUID: 2C1cH8lrEXhQ5X6TiukXGcr8z2Tx8FZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=840 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110096



On 9/11/2024 3:12 PM, Johannes Berg wrote:
> On Wed, 2024-09-04 at 16:59 +0530, Karthikeyan Periyasamy wrote:
>> Currently, wiphy_verify_combinations() fails for the multi-radio per wiphy
>> due to the condition check on global interface combination that DFS only
>> works on one channel.
> 
> As it should, really.
> 
>> In a multi-radio scenario, global interface
>> combination encompasses the capabilities of all radio combinations, so it
>> supports more than one channel with DFS.
> 
> No, that's not correct, it doesn't.

But the attribute comment section clearly says the Global iface 
combination encompass all radio combination as below

* @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing * 
the
*      supported interface combinations for all radios combined. In each
*      nested item, it contains attributes defined in
*      &enum nl80211_if_combination_attrs.

Is my understanding incorrect ?

> 
>> For multi-radio per wiphy,
>> interface combination verification needs to be performed for radio specific
>> interface combinations.
> 
> Agree, but it shouldn't make an exception for DFS.
> 
> 
>> This is necessary as the global interface
>> combination combines the capabilities of all radio combinations.
> 
> No, it doesn't.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

