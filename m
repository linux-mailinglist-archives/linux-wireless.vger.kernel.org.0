Return-Path: <linux-wireless+bounces-27753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C7BAD429
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650874829F7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8453043DC;
	Tue, 30 Sep 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLW+vJ3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7D25D1F7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243727; cv=none; b=kvTko6MzzDt+MPcYH9XwvGCvzgbW/aRxFUF5qz+6jLhg7OZax3dax3J2tugD4WIZh0E7/BHKI20ETBrMdvT7Fgr99DtZEw2Cd0rMBVLSJr04SG9jJ5qpCbeUx6IVpP8iFMxkCbbajPv9Ih7ug2EQJyRgI9+WFevCcY95e/xCdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243727; c=relaxed/simple;
	bh=xlIfLA1oaA6T5jp4n/5OOoy3fmAnxSFOgoE7Hix8V4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRAScRysAi5e+07oN0W8vNf/+I989klDONc5wp/VylRek1MgOHdWJmOzBfk+raWgkwYv0TcRGyNayhYXVDtF8YqKgVlX75EBSFNwwPKoiaSUMZMfcLcWyPaBraB63Un/7IjBDtcLXQtViXqBV8vL6+6/X0YBdaikY09190glz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLW+vJ3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBqFtx019070
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTrFqo2G5X3RRcNV8uDspTf6uHtkQQZrnEeBFh6o8ZE=; b=OLW+vJ3PkP4DFo2X
	v3s4vRj46NR77kV5BkVY5NYB/yumFOYsGDoIurHo95tDEWs4y/10eGrVc5av8ti7
	XgA+ZOf3cvccnPAAT5g5UA5TCakjihfzbnVzDZB3sj4+GPZ/iCZJEGFSj2tOOQYv
	2FEAoh2QtXuwmFCrxfybGuYx9OkBkXZFNUrbeLWDLuHIDrIIUdh46UP/GlHcDHJQ
	TbK3nFUGnaoVNN89N6vkqIs1FsWXClu4lVCgP5EjgKJw86YPn6ujQYUBvGur3luP
	jCqnxxZrctR1giUMs9D4+E+NxZ6ESVwj+jxbyRqhCEM9ndPH88d3sj86YW58fPPc
	XlEEHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tsdy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:48:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso63178185ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243722; x=1759848522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTrFqo2G5X3RRcNV8uDspTf6uHtkQQZrnEeBFh6o8ZE=;
        b=kXp1GdpLsJC1pslVIJv/KftqNWo+obru34tr7XbeTe4JJBHlJtgqMv9BjiFPCUlpoC
         X0C0X+QFXDVl/+22BFMvpEMaDItc/gfbOf1t67FUHYbeypcopSTPx6HlFOaKe19wVw9l
         FTQovfRUEA12PYYxvdmtFWSsZIeKbs6FWdPGqFQkVn4qj6cjqQbTNeTMkRJSnwiKYLSU
         zLam2cVq0p9ZoIY8/5eoLUXzZ64TwjRz63nbqICca76Y3Wi+6Kh3JKckSraBtJyk+jdw
         QwUIrEl9BQU4VcM9c1aa2ZEFaOYPKiuUJ3IsclyfgwpQrGVMlF6oy6fgDddOdO6zFu9j
         SupQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSTjn2hs4BThrSD0/FQMYGhOZtoKAAaWKs8wvnmxZj4sbkwzxxuBWx4ooyb+UFoNYOWXG2ckohKn6OdPPgbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3W/BkP7/JWeJk+2ttdzvOMn/wyW8TU8k7W2QYtjrWUtNcxBz7
	AgQI+YxYo37kEcCU5IEaJi0fUJncZwX3yIc4L3yg8x6fwk6D8ggk8vuJ/eW3Gbfxrbg9x+9muju
	KFqXgKWv7eFQIvVNCyGx/Epw+1dh4KRYu6QaLIAicXTX2MvTc6WRj8Rs41wq8TipQ7pfSQA==
X-Gm-Gg: ASbGncti/oMxrMCKNxEfJJ9j1RjYcAGMncldZ2np5omw2K17OvysoY5m0whsn7o6ia8
	Swy5OL+sbwLlaFbWzLff0k9OFw8yptZ50uBXv7yEOGprjfMy11n9xFnP9tfk8ZLPFuuZKGMsPL/
	DwCuhcu5FEQyfbh1iDVcL/P2nMJPg+CI5LcHf8EjjBzdAH3pR6omJ5jm1is/sbM2yOuaJZ69NMc
	ElDDmyKoMSiL7nLoU/ifjTKqNfCkh90p0ufjaV6vO9o9PFGlGW5b4McUlZ76RioTVocBrulR9W9
	spVqf0YW/7X79m5kF4bGeE+9j8eHRNZVYIL3WfJ31z0ZMxyAXb/Mv9rzlttUD8LfkXj/CVGJPp6
	ECud/hjgMSKrB6gesTbZt3+JMYtPyy82XQw1+9SQlDQ==
X-Received: by 2002:a17:903:32c5:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-27ed4a31641mr244257505ad.39.1759243722186;
        Tue, 30 Sep 2025 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4IzyIN9n4Q/kQArD8ugLcGVgKxYLLIRgU/ERTMY0enbO+NarkvMw4yNz1KuniTn2rlcIqqQ==
X-Received: by 2002:a17:903:32c5:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-27ed4a31641mr244256915ad.39.1759243721637;
        Tue, 30 Sep 2025 07:48:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed670b315sm163012895ad.40.2025.09.30.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:48:41 -0700 (PDT)
Message-ID: <13eeceff-9f2f-4673-8d23-eb439a687531@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 07:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
 <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
 <eddb5c03-e919-485b-a6d4-06485cd87db9@app.fastmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <eddb5c03-e919-485b-a6d4-06485cd87db9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX7O83Z2dRrhh0
 02f41Kw2+4nH949up5H5WqUQMtSInUJEesAySDstRnYD1YfGLMFWhzb0VRa7gZzKick47EtoTS1
 Y2c4X+wECOBMys/FZ0ZRW1HqdTbG0BOIC9EhAjOHffYouwiGj3kq6krHX3ABneZREr224rlMo1U
 kWMk9AhsILcX+vIvVkvHnEMiom8C8Q/ho7AaYnJ4drThyiC5G4RafL9s5bMeDgNM5S4UlU/TcKm
 Ed4PsZmeVHD0Osr9pounbF7Lopg1lWSQfpoA9f9SgbBcmk04jWR2UYNXmwO5rgQx1oeyejmghsd
 8lxW2WV4ytgvveVVSH+qOd7E2bSlSjJBScgbR4vg/g/H5uHjNMZcvCFLX9YsFDIZxMNtAmGTQnU
 mdvkwDqRhnLtfE7S43DtgP4UO7W8Zw==
X-Proofpoint-GUID: 7gLnJgAp84GaodGyW_aLfxXYZAB8nh4U
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dbedcb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wRxfcatdMthqClwbIL4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 7gLnJgAp84GaodGyW_aLfxXYZAB8nh4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On 9/30/2025 5:05 AM, Mark Pearson wrote:
> On Mon, Sep 29, 2025, at 10:17 PM, Baochen Qiang wrote:
>> On 9/30/2025 3:21 AM, Mark Pearson wrote:
...>> assuming Jeff can resolve above nits ...
>>
>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> Thanks for the review.
> Jeff, let me know if you need a v3 with the small changes.

I can address those in 'pending'

/jeff

