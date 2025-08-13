Return-Path: <linux-wireless+bounces-26368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785CB24E31
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373332A25D1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185627C17E;
	Wed, 13 Aug 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zh+d/Ko+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004A1DEFDD
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099794; cv=none; b=W2KHdZFGuGXUUVl5/CKPMf//NFuhEdZUlMqf/SuyUaixO469dzDaMvIzAMJVvYQgeM1oXKDmb4egcy1VnZ7GQWNhWhtIYmcUm1sKaFvs5h+dKL8HBC1zvCUuAbOYXZeo/rZTgqOXTo+osOWXAiGcRYAuQdmf342CzQCC13Vl8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099794; c=relaxed/simple;
	bh=8j6zwHSkNrxO88VhSHObHYoDToVzby33dWNtlia9CKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyiCbuquhIKGwzRVqqkk0hTdT0ldnYekkJCXTbZAob0sLybS7bAse9alYvO7ZAErfUq0Ot7g5vWsMyJvThdzTgly37qZ+zmsV1Ara9rxpyZdAqa/AhyMoh0G6ww9uik6O1BWQOz/03Lx32YwWNrGdXbzlM+V7EbxHgpGRSzTj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zh+d/Ko+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLgqr013008
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 15:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+vJiRxHnn3/K6boPwrrePMMQpvSubNZD/8bC45MJ5w=; b=Zh+d/Ko+ZbGVNY2z
	KZT/r8rY1DZUnWvaj/ikrs1R7+LdK0Gc2ew99PcLwNQ3qHsSWbtfZiB1WIYr0gUy
	nslaL+yoOodD3nQJI3Hxv/TGjqZGAWkD+YOSzMUQMIcQksxdVDp9s6T8dcgjzwzo
	HpyFczFcX5OaPzY/42gn2sFx6QdPSKUKe9uwjKvg5e/fPmaz/VPg+XN8EyMpPTkf
	0VKOx0806rjKaFdsSD+8uXWrqflq4rEIbTN2IiuZdtaZxyk5tLzFadq1j10gbxVB
	fBsLdNfqFwv0i4/WtPMCQ5lGLh3m1ROxWMchwc10KhK7uLyHTjGx1oGhSppaajzv
	FmFibQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6r6np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 15:43:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb2b837so30130b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099791; x=1755704591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+vJiRxHnn3/K6boPwrrePMMQpvSubNZD/8bC45MJ5w=;
        b=LD0KSVhnWvaZAB2FtwLAhowVGvP4+6XW0wC1q9NiW4jcDPWul6ClvyG+f6uoP0z2Y1
         bD7B3nPrcazMPWRB5pB3oLQxqg9o7R0OHNN2SFB5FQiOnKEPZ1HaSXhkM1ix2HBB+RVn
         9Ub76SbzqZfL1e4QsUqvudq5BOABd0YB8OrOj1+BV8hphdGwP0jq5jReuyg7SQCHOEfi
         ujJ70ckcJAFfjF5gY5NePpNfXvRTdFX8nAwbVcSWv9MNDNcPwYrbx64IyDHtyWc2W5FL
         SNzSyq+Xvqi/yb0n5lepkzNZrjBSagz+jJsTInpIx0upfTMu2H+3TNiQjkLzmTVl539O
         YZSQ==
X-Gm-Message-State: AOJu0YzcTmhFA2Vo/yEpes1cM3PtA73RJ/2wVGK+twwQVBUUtUx/hcB1
	/NIAkH7SmSynbK8IPDYlRLmCuK5kqysG/Ht2UjJYtP4oemISjWvM6a84mnZtPJXSe5SKLQc4Yxk
	nNinyx01fzKAE1aBTI/xNvIjzKkXdlzCNRSDIi8xVAsVZILfyCdhsA2Cu83ym0FKaBC6K2Q==
X-Gm-Gg: ASbGncuFe5hMmHdCUNW/dbLpeLtQNGg16CnWC6IwYBp4K5aLpl3rh/z76GyS6BgH5gy
	WPRYNzzS6Vv2fq6M9d67S486G+2a8MOW0x/OJmRnPJzHwl6+bXg6eAcBb2+kjAj3a8lTFZxowIQ
	5nJZLeQCOmAii8FxQQ/kxUDB6j9u2oxxsj/fax7rSJ0IU2HfR2s1dBBD1T4BSZ/pCkApAaSCTsC
	vXp0I2ltwcvsQ/d7JR19GBqbGlNCuSTb5Q0vdiRiW2+sokFz0fpfnvnyycZvhd9lMED6KSCFiAy
	r9+3URMF5kRjNsHgLLhe46LzGGO8JjUVUg5gsoegPoT+9yFneaATGLeDoGUGZ1y+LjvUJEnZIjG
	XKqc3sRP0RfFdmzFpSTQ=
X-Received: by 2002:a05:6a00:2d23:b0:76b:d7e7:f1de with SMTP id d2e1a72fcca58-76e20fbc777mr4617243b3a.17.1755099791032;
        Wed, 13 Aug 2025 08:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt+tw5CQOw9hHP6fC25gOa6wKJiAE3Tp9b+fde67vtYyymzbtqU3y6+2C+GYLi70eEmwf0mg==
X-Received: by 2002:a05:6a00:2d23:b0:76b:d7e7:f1de with SMTP id d2e1a72fcca58-76e20fbc777mr4617201b3a.17.1755099790581;
        Wed, 13 Aug 2025 08:43:10 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c1a9d6940sm21074480b3a.94.2025.08.13.08.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:43:10 -0700 (PDT)
Message-ID: <b62af6d9-eea1-41d0-997d-b9585f2a9533@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 08:43:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 03/13] wifi: ath12k: Move Wi-Fi 7 WMI
 configuration to dedicated file
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <20250812-ath12k-mod-v1-3-8c9b0eb9335d@quicinc.com>
 <00a72188-8ac7-4527-8128-352d0882754f@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <00a72188-8ac7-4527-8128-352d0882754f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX93EMlxQuNtwi
 h0hoj35RD/JryAhJ8q/mTOPw8gASaS1eSVlRJrU8lqK7RlUESyxOF4rsjogKOZ1pyMmWFEXRDID
 KB8HK0+75NjCR8aevdetCRGQjldPffiNuBU8Dq9+JeqfsYdCHiN1UzkObUu68LYYBTAf3KGrnnn
 kL0ZdTSmgAvKrD1amtRYqiZoqDPuwgrF/iP1GZppKpvm1XWlXCzJPxeG+T3iHXL6cDCYe48CVo7
 t0MpxyYUNb6KGcf1CPqNN/TXlFivA+kdLeihKBG6a2PMZSFXLcS0FO/HQpO7984BWX30qJ8xRP6
 x85asMKw5WNxrfScCoD2ut/N3kZwIhvFB3Satx34BIyj3XLdzy2l2BG8jzGKGwuf+SpYqGgCHdW
 H9lkudEc
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689cb290 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=hgPZAWqQMrviz7OzBV8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 45O-v_0J8iNwUjEbYkr2Z33_Pgp2hv-s
X-Proofpoint-ORIG-GUID: 45O-v_0J8iNwUjEbYkr2Z33_Pgp2hv-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/12/2025 10:52 PM, Krzysztof Kozlowski wrote:
> On 12/08/2025 19:09, Kiran Venkatappa wrote:
>> +}
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
>> +/*
>> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> 
> Don't rewrite the copyrights. Original file had different one. GPL FAQ
> also EXPLICITLY asks for date in copyrights and does not allow one
> without the date.
> 
> (and before you bring internal qcom regulations, let me remind that they
> do not matter. we discussed this in other thread)

Wi-Fi team wasn't party to the other thread, and this series was following the
legal guidance we were given. I'm circling with the core kernel team and the
legal team to make sure your concerns are resolved.

/jeff

