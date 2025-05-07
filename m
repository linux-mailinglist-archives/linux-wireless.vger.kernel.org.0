Return-Path: <linux-wireless+bounces-22700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70989AAD31E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 04:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D499F501490
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18913183CCA;
	Wed,  7 May 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCMS3w8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60413C914;
	Wed,  7 May 2025 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583973; cv=none; b=fJCbxv5xFSfbhd1vn1o95mw96GzSJtXUe/RKrptx11Nh1Iw3r2Mb0nbU9jUbm8+9o4BC02gwvFyz9Ph+lAdfAv9zF027l58pviNCksYmJWdEk2vMWnoW33Yco/rGY3+2z5B2HfzHJSxbxbLGhm1mavE+AbgUnONxGUXKYBsBUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583973; c=relaxed/simple;
	bh=dzrbkY4X23RipD3l3Ge3/ZqWj4593/alobH6BpDh7hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6Q0DGitZEfE2Qnr9LW3Hsqqr+QT4Z/moJ7cuZfqK+ORoSSVPrY9T6MP+bxQN6tIrOEKKSrNBMQmAwijrUgx39ks9f0Vq3jtjNXWJfy9AwfSpJeJF+ltJh57bWsGkH8g6v+gTiRRKLgucJ3AT/pW84VnEUY93663A26PyKVDp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nCMS3w8I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471HAL8028440;
	Wed, 7 May 2025 02:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LfB5xXq277MAtXzOU/9GyduFI0JF/YzAt4MvMU6xV7w=; b=nCMS3w8IqfJ5TA8o
	irqWTzhKWUbLuRds7P1UVuOGcxrw0Gl5x+nSARKjbECtfctBO5E4bfVeOHQiyOY1
	KgTWteypuPAAQMqIi4uEJ7tNqW+GikRe46KiIrE6Z/IZSsBe4dVI3W0MZT94khAD
	4cEXHvEWZ4bSJG096VQC9lPXrIxf4NA3g4HAGpTZRpinPMI4NsVwJrhaZPNbKfUE
	aFiMD7p4BVP0yap1bMHQA05rVuu2bfO0O8nt6TrQIpSnZc1K9vHSD069MlPdtVyz
	CL2f61XNGu9823B7yF4T7g8MtF4cYJOL3pDX9ik/8nK0ogMz0KFsUbxW/ZkcMhmn
	NKaoqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fguuj94k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 02:12:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5472CZH4018497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 02:12:35 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 19:12:33 -0700
Message-ID: <3448c268-06e6-4d82-8f6c-ec635e624fe7@quicinc.com>
Date: Wed, 7 May 2025 10:12:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Muhammad Usama Anjum
	<usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
 <ec0bb100-4a70-4827-86b1-e4a7e8867a2d@collabora.com>
 <b21ced75-b239-43ad-b4a1-293300b00eb4@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <b21ced75-b239-43ad-b4a1-293300b00eb4@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=UJPdHDfy c=1 sm=1 tr=0 ts=681ac19b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=Ai7BlpgEY3ezrPMUgKsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: NWgPhPa3jJygoQ0xgcXFwyBiyB6pupGU
X-Proofpoint-GUID: NWgPhPa3jJygoQ0xgcXFwyBiyB6pupGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAxOSBTYWx0ZWRfXws3uU9xpFPWE
 j0V7gwbmvdtgj+ndAGlyHeyKjS9ju/E1xRUx+RSmzlqM8WHOD6Wo6WyZgbWhCGs7STGYlBr6fX0
 vEKlQVs0eV9hTrRH6JHT6+vfxQXaTVd/SReQ0CxdGrvNIj2N+k4mb3o0z0peWm/4SUAavCk2jNZ
 S1cloQoJkHu3LzclsI+My2YYtUNKShRV1NNZqBMaIpTE83nVPOft8gCSmwkRZ6E2eUHsXLJatL2
 WWESoD7psknoPj6Z/1EOmEq7C1ZPIrkeRdd1hUJVyWeNWuGuS7k590xmlsawuo2CPBpWb66lK6J
 uCvH8GuJ5i9Ptn3zSix5R5pJxD09cCMUatq1yMbIMjEOIL59f1JwzjGxoDE3ztc/6O2VtWXn1n4
 os0etMPl2aTdUSmfqXBwosl3jvILk5e90LRlEzt2Z23C2Lyxhn2UdRG/bqVg7ZsuRiivROW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070019



On 5/6/2025 10:37 PM, Jeff Johnson wrote:
> On 5/6/2025 6:10 AM, Muhammad Usama Anjum wrote:
>> On 5/6/25 12:17 AM, Jeff Johnson wrote:
>>> v2 feedback was not incorporated:
>>> For starters, can we make the subject a bit more specific, i.e.
>>> Fix MHI target memory reuse logic
>>>
>>> But don't repost for this -- I'll make that change in ath/pending
>> I'd changed again on the request of another reviewer. Please feel free
>> to change as you like. I don't have any opinion on it.
>>
>>>
>>> However, does ath12k need the same fix?
>> Looking at ath12k, there is similar code structure in
>> ath12k_qmi_alloc_chunk(). By adding some logging, we can confirm if
>> ath12k requires the fix or not. As a lot of code is similar in both
>> drivers, ath12k may require the same fix.
>>
>> I don't have access to ath12k. So I cannot test on it.
> 
> Baochen, do you want to propagate the change to ath12k?

Yeah, I can test and fix if same issue is there.


