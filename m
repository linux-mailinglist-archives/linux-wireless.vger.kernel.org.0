Return-Path: <linux-wireless+bounces-20175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A16A5C543
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95DD3B8D50
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DC25DB0D;
	Tue, 11 Mar 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZlqiEWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C471C3BEB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705818; cv=none; b=p5TgoswkdKtBd14JptHJdS9vEBAkrKirP2TED7IRAno9sobFg63UM7rwkfanreeTL4hSshvaGpWDf4BlaAYaK2PJ95wH9pApNimPxeXCwhtwEPzrWwVsHH7b8MStpUlTXv1sWbuL+R0ngEgHbjx/vYNT3j5PF+ypXDemAmBp/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705818; c=relaxed/simple;
	bh=Xo6+bUdfAXiykfhZytMabifJufCzeDeXMkgQGzsi0qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jNARY49PMKKpfcuk2DWFVjBLeGy/JtKSQm95gpoW5vYz7SZO0DWvMkoZmpQ8adARozt/2kA7TxOYy/kvcYhwHLe139eCDHl8sYSJRFl8Smvkcict04vNoPxos0ry1aIO2KhXxEGEtpnNkBnDIDDAUWg09E5EFBiiH0IFdMI1wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZlqiEWo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8Mv0O010520;
	Tue, 11 Mar 2025 15:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yx3FhIr3uVsQa/YEIwLUwgsyGumE4sPV5kkZnx7JXmg=; b=ZZlqiEWoYjGLupaY
	AKLasHMTPRULWQmP22FGvxQveIHbRu9/oPP5el2DsQwzuqEEqsYM9R34upBnajXx
	qgMxr6S9hAWmfevjPZh3doQ/DQrPwhsHetiTl1TeaZ9H4gaFbDwk9bCieiD88wv5
	jaoRW4A9a/32YKuaLIKAF02DAQ06ukheORD9tD0NxIhnPp9WYEyXK+QDS4rBaSR6
	fC50jhczcf77WRoiMt/bjdjgpogMzszNCe1pi3mvnCZ9RqAX0MWz7/3/BHSLpKnx
	jDzeIWmB115H45TJ0t1J4AcpRU2jIopr0AIBzohru8MwEnR6B6/NsaKumwm+9n2O
	zRp2+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0q0ysx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:10:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52BFA6Se011985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:10:06 GMT
Received: from [10.50.38.234] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Mar
 2025 08:10:05 -0700
Message-ID: <e2e5bed1-1b2f-4b52-be5c-fe8da4122e0d@quicinc.com>
Date: Tue, 11 Mar 2025 20:39:47 +0530
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
 <809bd94d-66d5-4621-9475-b9a8a9370b62@quicinc.com>
 <041375dcdb6fd3afacd297f85036d4f3ca73cc6f.camel@freebox.fr>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <041375dcdb6fd3afacd297f85036d4f3ca73cc6f.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0skqLk26iX4mTxP7yaUMRA5Pk2U8BM6e
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67d0524f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=eAOsekaecODngoBePhcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0skqLk26iX4mTxP7yaUMRA5Pk2U8BM6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=726
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110095



On 3/11/2025 1:24 PM, Maxime Bizon wrote:
> 
> On Tue, 2025-03-11 at 09:38 +0530, Roopni Devanathan wrote:
>>
> 
>> I hope this will resolve the said problems. Thanks for pointing it
>> out.
> 
> 
> No problem is at registration time, not un-registration:
> 
> 
> CPU0                                   CPU1
> wiphy_register()
>                                        wiphy_dump()
>                                        rcfg->rts_threshold deref
> wiphy->radio_cfg allocation
> 
Got it. I'll add NULL check before dereferencing rcfg. Also, I'll try
to allocate memory for rcfg before wiphy is registered.


