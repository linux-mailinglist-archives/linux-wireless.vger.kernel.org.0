Return-Path: <linux-wireless+bounces-13090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7297F094
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 20:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D90282B59
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C31A073F;
	Mon, 23 Sep 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L9cnYoQG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084519F41C;
	Mon, 23 Sep 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115734; cv=none; b=pZFkrkKKs6yVQJ/7PdYCPKgovcnvOaisVXrBNhPXmJz3CZe+bp1qtY0OkcS/zaOutPJzoDoWP/yYXKcGj8bZ1NIemhdQIiXIojFhJInm4Wq0Ycmm7+X7PSwlE9G8YMKtbkgCkHJ6765TrH6JDCtdNLRWblfg/oJYUJQdmT74oxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115734; c=relaxed/simple;
	bh=9iY+4FM4+oIBVw73ti8BAWVWFWPB+mK/XcAHFHXLCmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qa0SwZZxR6jG0cjj4TwgwN5Q5ghYZV9fdHO3tBBD7n4x42u09amIQiAWynJiqB3rSQEzaL3DFZtUXtlCoB5jn3NwPElu5u8IuxBGdjZDKgjvpaAIS9yIz1y6GL1H/UMiY9d3KsfmGx/YI+NFmRx3582T5qloIerYz8FIhvAWvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L9cnYoQG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NAEPjI032714;
	Mon, 23 Sep 2024 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FfMvljWqolIkMjOU9A/mkoVjgPykveoXeX/hADfX+Pc=; b=L9cnYoQGDL9UqaUU
	AxQo4O86R6kqhElq6foVWBvqnYv+r6RnruH5jwBmIx4F4F0gOVjJ66K3h5vnc/fZ
	C0qw0XXqg2jmhfNv8WgpP72joZRmkcPxOHIwRayin3+lX9ab83V2n/h9z4ZR7qBK
	X4rj+SFTxPuvMqtRE336IXaZvX1DQxw80BIJTYlmy6yEQzfIRTIVLSemydahltDq
	BhwEpC+HbhfnsbNo8gF+sioy3v/oUX6khJuvRDW3V/EcxT4ryxNXK4TjZI3l59z4
	ZoDVCu449saJsTNGaSsBv1FGBtDSSEI2+YuFC1QXbM8/vRc5eu4F7iNh1tJRK8kC
	pWFZGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe95mde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 18:21:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NILpn1031081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 18:21:51 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 11:21:50 -0700
Message-ID: <ca52f5a6-2f38-447c-a2b8-8404fffecaf2@quicinc.com>
Date: Mon, 23 Sep 2024 11:21:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ath6kl: Reduce scopes for two variables in
 ath6kl_sdio_power_on()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>
References: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
 <33b08664-fa25-4cef-86b2-49f65b4369c9@web.de>
 <80b820cd-9255-473e-8e4a-3e7d8612d876@quicinc.com>
 <45f6c8a7-4021-483a-aa81-a836cd3fbcd8@web.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <45f6c8a7-4021-483a-aa81-a836cd3fbcd8@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6DdNGXIIae8vwd42zLyoCwKECqZvpZuq
X-Proofpoint-GUID: 6DdNGXIIae8vwd42zLyoCwKECqZvpZuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=829 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230135

On 9/23/2024 10:00 AM, Markus Elfring wrote:
>>> Adjust the definitions for the local variables "func" and "ret"
>>> so that the corresponding setting will be performed a bit later.
> …
>>> +++ b/drivers/net/wireless/ath/ath6kl/sdio.c
>>> @@ -503,17 +503,15 @@ static void ath6kl_sdio_irq_handler(struct sdio_func *func)
>>>  static int ath6kl_sdio_power_on(struct ath6kl *ar)
>>>  {
>>>  	struct ath6kl_sdio *ar_sdio = ath6kl_sdio_priv(ar);
>>> -	struct sdio_func *func = ar_sdio->func;
>>> -	int ret = 0;
>>>
>>>  	if (!ar_sdio->is_disabled)
>>>  		return 0;
>>>
>>>  	ath6kl_dbg(ATH6KL_DBG_BOOT, "sdio power on\n");
>>> -
>>> +	struct sdio_func *func = ar_sdio->func;
>>>  	sdio_claim_host(func);
>>>
>>> -	ret = sdio_enable_func(func);
>>> +	int ret = sdio_enable_func(func);
>>>  	sdio_release_host(func);
>>>  	if (ret) {
>>>  		ath6kl_err("Unable to enable sdio func: %d)\n", ret);
>>> --
>>> 2.46.0
>>
>> NAK
>>
>> no maintainer wants to spend time on patches like this which bring no real
>> value to code that is not actively being maintained, and which violates the
>> established understanding that, except under certain recently established
>> criteria, declarations and code should not be interleaved.
> …
> 
> Would you find other software design options more acceptable for further
> collateral evolution?
> 
> 1. Additional compound statements (by using extra curly brackets)
> 
> 2. Moving a bit of source code into an additional function implementation

I cannot speak for other maintainers, only myself. For myself I am far more
interested in changes which fix actual errors or warnings, and far more
interested in changes to code that is actually being widely used and where
active development is occurring, as opposed to drivers that have no ongoing
development and little deployment. At this time the ath.git maintainers are
100% focused on the ath12k MLO feature, and anything other than bug fixes to
ath12k or other ath drivers will be ignored.

/jeff

