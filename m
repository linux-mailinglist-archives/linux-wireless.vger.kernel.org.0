Return-Path: <linux-wireless+bounces-12791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3397535F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1514F289972
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A121714AC;
	Wed, 11 Sep 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LC3/Uqv1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009415C13F
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060570; cv=none; b=aOd9S+WRDWX8bkUK/BGYw41jxp05rsXylJ1Kw0DF2G2j9U0IoGBxUjY/HUNFaDL+pE1XGfu+h5Y5sN545gnL22pvR/7rG6W9tafgHsfPFX4G5ygQyUupVMrz4kpVUlY7pVv65J/YafEhMxob7wsSHoPRkMLybsHTAX1T+gRKjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060570; c=relaxed/simple;
	bh=0+yGm3o8WcjWekwiEfDYxtfM4U2SI5Zo2bulJIu2Uvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2OMkVzOBgmfGAeansbSeEnvnHh4ffIjg+nwQmnQHbhXEc/AsbZwQAELUEPLZ71ZMeAfeX+EwkQt6Zz3wvAjGCZVr/AkvH+o7btuBhUDuBwSx2p0Icf1roL8B4PbmYhOOYfuDRWUO3mPdzZXPW9G6ege7WAYrBDfKWrJ9GlU8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LC3/Uqv1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B9cjVs011017;
	Wed, 11 Sep 2024 13:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nl8ntfpg1otamw/fGv2L2a9Ikxz6zxTMv24igvHkNEg=; b=LC3/Uqv1UAiuVMwD
	8ZPKcQtw+vI9S1Jc2GA5CfPEj6XOlwz+yze/1oiTfkNZXT2tqNHqE4Zrh4+qZBOu
	00hvuCnGdQH6yyWexqbSRXWmwP0VWgSxagdwmnWW9aqDZ0esdq5oZZYiXGVlZaVz
	KalqHb5cmjgxAIxglfwZm+O5rXFNZ4t/hfYBLl8AFOwKGXnxnmiJ6TMIrpMqA25y
	l7UWYCTalPyGlNxAMxTKxhJhA4XIJNxBI0HWdsVYxYDl3+smlpet05jTdJ3V3Gga
	gJUrANJUdpjW/E7aK4jgt6HeNElY+tIubTxkZwkIftXw0GwCdBwZ1Cq5DhUAOMZB
	SyuiFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpspkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 13:16:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48BDG2VH014471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 13:16:02 GMT
Received: from [10.50.37.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 06:16:00 -0700
Message-ID: <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
Date: Wed, 11 Sep 2024 18:45:56 +0530
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
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>
CC: <linux-wireless@vger.kernel.org>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SvmTPr7C_GnRaSymuvEimbkzbevuawyd
X-Proofpoint-GUID: SvmTPr7C_GnRaSymuvEimbkzbevuawyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=893 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110099



On 9/11/2024 6:22 PM, Johannes Berg wrote:
> On Wed, 2024-09-11 at 18:21 +0530, Karthikeyan Periyasamy wrote:
>>
>> On 9/11/2024 3:12 PM, Johannes Berg wrote:
>>> On Wed, 2024-09-04 at 16:59 +0530, Karthikeyan Periyasamy wrote:
>>>> Currently, wiphy_verify_combinations() fails for the multi-radio per wiphy
>>>> due to the condition check on global interface combination that DFS only
>>>> works on one channel.
>>>
>>> As it should, really.
>>>
>>>> In a multi-radio scenario, global interface
>>>> combination encompasses the capabilities of all radio combinations, so it
>>>> supports more than one channel with DFS.
>>>
>>> No, that's not correct, it doesn't.
>>
>> But the attribute comment section clearly says the Global iface
>> combination encompass all radio combination as below
>>
>> * @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing *
>> the
>> *      supported interface combinations for all radios combined. In each
>> *      nested item, it contains attributes defined in
>> *      &enum nl80211_if_combination_attrs.
>>
>> Is my understanding incorrect ?
> 
> I guess it depends on how you interpret "combined". It must be something
> that can actually be done *regardless* of radio assignment, to be
> compatible with older userspace.
> 
> So if you think "combined" == "superset of all radios" then your
> understanding is incorrect. You need to think "combined" == "what the
> device can do without caring about radio assignment".
> 
The current implementation of radio specific advertisement global iface 
combination (NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS) expects the 
superset of all radios, wherever the radio idx is -1 from caller of 
cfg80211_iter_combinations().

Is it incorrect ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

