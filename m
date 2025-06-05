Return-Path: <linux-wireless+bounces-23727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB87ACE8D1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E08175ADF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28ED136E;
	Thu,  5 Jun 2025 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PE/HJkK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329A36D;
	Thu,  5 Jun 2025 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749096103; cv=none; b=MhBTHtfAy1TkwV3fUT/zKYPaLaTwyT+S0GTJaiWUil1ZNq9HDNd2U7hJHY/Le7X0t0+Fbc2PXdvW8sYEZDZlbuWWJeXMFCPanze1VJocbZ82iGrjY5gocMXtHd8pZoNV19boJDHE/tcapMphMxsw4/z+H0eiE6CxroCfKm91LpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749096103; c=relaxed/simple;
	bh=32c7+/f8dJEBLn5iseICjaVxF8Xs0WCRAXtVpNyVYvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EylaAzqPigCFScfatMd/3zAwKbewLEnls/+YOapRjfQXAneRYRMUFJxJ4p06k0xg4T+g/rc0DodV6m17thEWSWVmlrfg4EhPqfW5gW+5TghitfFwJzwb6oZnbV2hlXVHoZZLMBkNyCgSjhwWvxJfmlkdzVBAlSrCAnA5JNnQNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PE/HJkK2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554HXXig032470;
	Thu, 5 Jun 2025 04:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YylkOQCh+vCY3pVbR+5T6o1JTLHD9ZCMZHUsqJ1mDIg=; b=PE/HJkK2ZTSZggqn
	rU/xxdpJJRUrR77TLp1G94gogCvBRbhr5m/aHae0ffddwYyTauXAvmsyRdqFzyFK
	8U5ByBrZ3S/bFzdgeuhy3cXM8xECkKOgV0tSlBz+gKEgymxDryEPZX5umLv3uSrk
	iW/5AUXH9IOKowd4payvnn6T0yA7yHsl9vOr8LyOl/Y5uJIl1bgYoVczLoFsZfWT
	BMYhhia1Q3kDMF8ClVshO//2RUmu5ZTIF41uuqggoujjS/EtiuWKZWBLU/13WAAt
	Sj1oOUrNjyAUA7AbInHpV7+QBVMc+g6bU5o8MWx42FzaJliJCgkDp3W+tVcZ/Wje
	i8Xqfw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfuxv8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 04:01:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55541YU8020129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 04:01:34 GMT
Received: from [10.133.33.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 21:01:31 -0700
Message-ID: <03354d56-ed21-47e0-a52e-14f559ff3bfb@quicinc.com>
Date: Thu, 5 Jun 2025 12:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johan Hovold
	<johan@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=6841169f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=HNy3F74MYHTJsWsaVJsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: eez8o6FWFR7_XDEWNogdVUfn6H8qt2j6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDAzMSBTYWx0ZWRfX1sFSTU4HTb4g
 +fVLEIJj6xUsLDiOzqWPABGcih4+gZuRi+GWUexjAfMKAKkYao0Ht5Y1nQa4FzB1n9a6Uzb389q
 cJZ/IcnuIr7VDP2ikUfQ0FcQI0FxrLK3JBkKcgFNUaPSiiiqqEgt+NWeDvmM304XB7To9/IW6+L
 aMRp74N2rgQsQ1iknlhbv4HF9mVHxSdm7DkcT6n33O6GunJTRh3Subhc+bm3xd1WN7fuIM4RnHi
 R4jfU9k3mZyJqd17Nh+j14BgiwAhuXIhx4IaQtbDlO5GADYl4ND4cZ6kazWBfiBAnFoFyQ40N9C
 ej+1L26jVzpTTVxdKg4Va8g73WaEKWnRr/E3uv+s+VuM8c76f6GXAiYpg6tXrWPsA+dj1d0S+hS
 akR1h0OrMC9VvuZOPhfL8MWDTDFGazFVlIts3bYNnS/rhWPhMctME3hidCHNxgZhCM68pJRD
X-Proofpoint-GUID: eez8o6FWFR7_XDEWNogdVUfn6H8qt2j6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050031



On 6/5/2025 12:24 AM, Jeff Johnson wrote:
> On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
>> We previously had extensive discussions on this topic in the
>> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com/
>> thread. On my platform, dma_rmb() did not work as expected. The issue
>> only disappeared after disabling PCIe endpoint relaxed ordering in
>> firmware side. So it seems that HP was updated (Memory write) before
>> descriptor (Memory write), which led to the problem.
> 
> Have all ath11k and ath12k firmware been updated to prevent this problem from
> the firmware side?
> 
No, as this is not a widespread issue, and addressing it would require 
modifying the core underlying modules of the firmware. Therefore, we 
chose not to proceed with that approach but instead used the workaround 
patch I previously submitted.

> Or do we need both the barriers and the logic to retry reading the descriptor?
> 

I think so, that would be best.

