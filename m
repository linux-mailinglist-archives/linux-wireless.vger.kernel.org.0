Return-Path: <linux-wireless+bounces-20132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E54A5B7D2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB652173998
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B031EF368;
	Tue, 11 Mar 2025 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eOEfm2V9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4B1EE01F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741666147; cv=none; b=OtWY5UXoux5WKnYTQCw+YTUSQdgBswEuzubiUCGmTdLBLEnFEBv/90LTSE3xlJErBhedRY+wTOw75TkvJTuu/s0DNa792xSFJ8AzGj74PsnjC5bCHmPoJkDEN/EW6mLak0jClnab57T9NusvFF/KPkpjn0DRA2i4D0WgK0yzMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741666147; c=relaxed/simple;
	bh=rDFd9zZBdyopVFVnOkhGAYF5XQ4DyspPTpi4ZR0egK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eYQTNq4ukaXU1MAAf8+84Es42j33Wr0XdCiFECNcEZvM0pMt33wPgsB8kLohWIfCc3yZ1ykyK2ALUD2+VwFpmTOGgY4I/x1SkU6EW6CThDxo+iTB33tQ/+s6rAgX1MFxDjw4fb8Sgn/O3ut2AX6/t/+YYVeQARgM/uXEF215tXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eOEfm2V9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALbSjo019766;
	Tue, 11 Mar 2025 04:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sxpPMK9+705ex1pBULKe9yHp35DeQmFMv6OYkKbcnc4=; b=eOEfm2V9LoYE1R7y
	rFzkbwVE+0RdZv7CAnwcAbSym2ihU4CDnG42LCgWAQlWhc+QGFcC/OUo7zQ5ikhe
	D4Q2JpU8XCGvvrjSN4EuI9G0BsETUrzH/yJ0XCVSEtbpIRrEVonTsWz5/UnEg2cT
	0udl9vDyrMCU8f5Q1YbV2P1fyhQLfYEpyUfn1M5e9y5ahzwxSem52vKQcKl2cFeL
	K+TAexKXkC5Lq4w2jOmGUeLfrXZfCKiCniup9TCHLrS6wM/BpyvW89NO40MvtnEp
	DLPVMUOrS3d8psdJRuhbLeHlIonlfi3TOHjcMppbtnwpu9EPgSDZFoiCq5MZ3QSP
	afz9MQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0pxygb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:08:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B48pLq024705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:08:51 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Mar
 2025 21:08:50 -0700
Message-ID: <809bd94d-66d5-4621-9475-b9a8a9370b62@quicinc.com>
Date: Tue, 11 Mar 2025 09:38:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
To: <mbizon@freebox.fr>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
 <edcaf289872243a7a5a794ebccdc39094e130d3e.camel@freebox.fr>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <edcaf289872243a7a5a794ebccdc39094e130d3e.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vmwOjQDLr9p4JjHddyUg7WmUicm_5_3e
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cfb754 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=c4BRbBBTdcXW6Q_xAVMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vmwOjQDLr9p4JjHddyUg7WmUicm_5_3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110026



On 3/10/2025 10:03 PM, Maxime Bizon wrote:
> 
> On Wed, 2025-01-29 at 21:22 +0530, Roopni Devanathan wrote:
> 
> Hello,
> 
>> diff --git a/net/wireless/core.c b/net/wireless/core.c
>> index 70857018f020..3f4c9edc2bc8 100644
>> --- a/net/wireless/core.c
>> +++ b/net/wireless/core.c
>> @@ -1077,6 +1077,23 @@ int wiphy_register(struct wiphy *wiphy)
>>                 return res;
>>         }
>>  
>> +       /* Allocate radio configuration space for multi-radio wiphy.
>> +        */
>> +       if (wiphy->n_radio) {
>> +               int idx;
>> +
>> +               wiphy->radio_cfg = kcalloc(wiphy->n_radio, sizeof(*wiphy->radio_cfg),
>> +                                          GFP_KERNEL);
>>
> 
> wiphy is already registered at this point, so it can be dumped from userland.
> 
> And your patch 2/5 dereferences rcfg->rts_threshold in wiphy_dump(), so
> there is a race for a NULL deref (KASAN caught it).
> 
In my next version, I'll unregister wiphy when memory is not allocated for
wiphy->radio_cfg. I'll have something like:
	if (!wiphy->radio_cfg) {
		rfkill_destroy(rdev->wiphy.rfkill);
		rdev->wiphy.rfkill = NULL;
		wiphy_unregister(&rdev->wiphy);
		return res;
	}

I hope this will resolve the said problems. Thanks for pointing it out.

