Return-Path: <linux-wireless+bounces-29897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E3CCB804
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 11:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C4AB303A90F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670E326948;
	Thu, 18 Dec 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaMvMObl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYShmxd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B41314A8D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055260; cv=none; b=YZhHJHOd66qaW12i8yzgwpaKuZIJN3TGsvTBs2gBDyf/M1LlNN6Uld/89H/7biMx2hmfjlrqtam6OAuk331E7V93mc6Tu8BzTPkMruaZjkGbnDPiS1bs+x8dCNw8ibfnvj7XSxMbhrBViek+Q2FTmmqsbtFcTZ+sBghIcGPAVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055260; c=relaxed/simple;
	bh=wolOtR5gbMuHGYPn7isX6pVe+I4UdjJqr+mzUnQuzN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoOrQrcsMfwaltISXGz+xztBYuDYw/+E7cauesgU4lxC6UzWSR6SpH7Mk6cMBcHzXvtsZEDZks+DJd5QUBafWvIWOa7uGLfTN6lzFHUd23FgoK5ZNusdR3tfOVOFs4mnfZOkWrYiHZ4OisZcHBsqqGVycEfb0nHqCmlUK7CYshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaMvMObl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SYShmxd0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI8uSbT529411
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 10:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ULiMr+jjQf2IPNeanbk3DLBorGWRLoXxf7JiGDZ0X0I=; b=BaMvMObltxpjlJX2
	hDi1lnh+3LRntbDrAOg4JzxnEtNIasX/GHrqSFO+6PEWprty46vErmrdjMQ+0R+d
	PB6dMSyhsXsOkkIbRyZN5NF2qNh1XM0D9CleCOljN15BesCsdrMWuoPmygi2uKmr
	Ft7+V5RzUDdGWtmok/tlpi00lFdyIc58mdQug/iwF4CS9X0UaOjuIB4sQQ3xWjCb
	Gy+qX89KVMfYKr4/GHEFEhTBP9LlIxbD5MafnUxG5e1BWN4PNk2oKuSPL7hydyiy
	u2DEGsYL8IcAXZC+RoFjU+IH52kpMAsyPMwvvOcppYFYD1UasINp/jkJoSIw90ZB
	1oZrXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43mb2aqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 10:54:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bbb6031cfdso15193385a.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766055257; x=1766660057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULiMr+jjQf2IPNeanbk3DLBorGWRLoXxf7JiGDZ0X0I=;
        b=SYShmxd0AQryYG17CrlT+w4uBYw0j1sqT0T4l2hgwrnCT+IAWqwgbu/wkrJDHpR/Ya
         yafOkWwEVPD84uyflDEEqflSE8AYlvL2zo6SY5g0RaRY1SHlsX2kXP1jKUrV9JFc3JyR
         0PpRiV/OIZiOzaNbip7y/TzNcs+hWYkDYnwZms1z5vn/W8jE6djhIQZoJzjnmiIsQo++
         TdWNi0MHaJoeJS8WbjbFNDdo8QfEfB75myExKLqhp8ZnevHg7yuCyq+2F/JosFFMCuWi
         atTdyBAUKAMj3P6qd1H3TqPMEjfZ2lepfo/XoA7EPxKKZabOMWIqoIJQiE5R1DZZAutF
         I+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055257; x=1766660057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULiMr+jjQf2IPNeanbk3DLBorGWRLoXxf7JiGDZ0X0I=;
        b=LJOeQNhh66HCOqvO/2+o3qDEZo7m6SAwqy82g0EtdICnwiLvLy+kpUQgj9mtnvQybl
         ZN4yQmvUf4yt+unLqSdtC739D+FKlJNdTnsZ5MkvVpNcKd1CCqwvRMCCQT7t7z1hECFR
         K21X4maFA3MrJLRAHkpGJ3FsXCUy6mTVCb4lu0P9wlQmjuS2jKb6Rgh1Zfn+2a2Mh0Nr
         8tI2k/5Cu3Rux227KgbrE2w+0NPBtXd8rJsyFCKWOtha9Srd8cOxKpT1HzWhu6lhcH1d
         NJsGr2SWhsucEEpMvCw95iAufjuK6YNZU9Txz9yefzMG9bKyDkArzksK+rMYPIN2vBfR
         oWxg==
X-Forwarded-Encrypted: i=1; AJvYcCXc/zGxFGP+Jet6HSOHhpBRwZRNXrMCGmrkBk59J895wzDTOpQeYrNhUqO4kz05E/XRUO8jlzktLEdtSBZEdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoabuUMCrykVPoWT6uh9+1M3wB+/5kQELHjOGpPgErXWtQ13GT
	8A5tVRN38d8qp1ZyNmfAex3KbUStMqOzkc6LkjdInoxn6h+/x6yQg74soGp+y0zlDl25xqY5UXh
	5zsPnJlu32sQFiqnuDt3ZSYRFxF8bFSChOoyEioSSkjhPWkICuDOWLox8mFPH3Pkg3bMFMw==
X-Gm-Gg: AY/fxX4Zd4+mC5xwc+nwnQPY6a2KKUvap2khB9R1urMUXg7ZjBiOfaCIiBnVoVk5Ml7
	Vl2MC/XxuFfld2LCuENwccEcGGPLB245bBPB+knQFrSIriALCNbeOTBksft6zspWeO8tGllC+aa
	5y3FYVp+RShE1cltbuSYXXmjMs94718FrTUwQ6wOBrr3W1IQv4Ow3x6vSNJP0TY9bUEeDOLyq0k
	4fwGMpFW10ebOdPy5I6oa0ATDRXz9qQKB3F3DIESp7u8Wqb0Jz3gIJWYw8aaj9d9FFU4d7eaGA8
	G1LlrsyiFL8/l/qBiNwd0k12z+HBq2v5UfzxGB5LYinXFMWO9BoPFJq6YXgrCanVSXCQV8yCd/R
	CXClPE6lEl5lJp03s2Typo8Zvc+3VgYK62QrTa3zd/tjb8sKiUp2uI/1gpqLRk5GL9w==
X-Received: by 2002:a05:620a:4441:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8bef2b6ad2fmr173837585a.9.1766055257292;
        Thu, 18 Dec 2025 02:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg6rD4FG+ZdEpLvSxXB7VPKfet2cJMu4WCkxjwUL9ypB7KXsrgvhhdJxlHfMC+UTosSE+weA==
X-Received: by 2002:a05:620a:4441:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8bef2b6ad2fmr173836085a.9.1766055256861;
        Thu, 18 Dec 2025 02:54:16 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b585b52bbsm2367565a12.6.2025.12.18.02.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 02:54:16 -0800 (PST)
Message-ID: <4491e009-0071-4130-9e1a-29145314e349@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 11:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: Add support for Surface Pro 11
To: jerome.debretagne@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org,
        Dale Whinham <daleyo@gmail.com>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
 <20251218-surface-sp11-for-next-v3-5-875afc7bd3b7@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251218-surface-sp11-for-next-v3-5-875afc7bd3b7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U9wem_Lp9Ttfj3DXzMsW8uoJZ0MBP0Hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA4OSBTYWx0ZWRfXyK+ocJguWhD2
 oBr+X7tyijZX0w60GesbeZPvK15l+GXmamPSUftz19nw19Z51mC06q9djEX8p9O17j1mjr56SgM
 4wrauu10oXbHNgNPH0mHn7IyaVKK90lBc5RAwWPjnDSxFJ2WbLJmaIqj6UHy8XyrqYtoXxMHta7
 0w9VuFMCeCLPV7o8+nKRszPeBXJh+pv1Gqs5ztxPtrCu02vNNud6zyyhjenc+d+ZkRxGWK8iR92
 2fFwPAFE286KB31cma8PHZRjcRjPADrOMQSVNvsm35Y9Fc6aO5sNE3HJ/PP1yGCXoCHeSvisBVq
 pzMFhsioFmvAem+QncoeWt6IwBQejX//MyN13qjkTT2Dj2yS1DYSY+A2qFy+77Ysl8b452PMy5U
 RYYbK0HWdDl2CY6F1wf3TMFQZ71hnA==
X-Authority-Analysis: v=2.4 cv=NPHYOk6g c=1 sm=1 tr=0 ts=6943dd5a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=T6QFUigfjUT3ERtuJAUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: U9wem_Lp9Ttfj3DXzMsW8uoJZ0MBP0Hw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180089

On 12/18/25 12:56 AM, Jérôme de Bretagne via B4 Relay wrote:
> From: Dale Whinham <daleyo@gmail.com>
> 
> Add device trees for the Qualcomm X1E and X1P-based Microsoft Surface
> Pro 11 machines (codenamed 'Denali').
> 
> This device is very similar to the Surface Laptop 7 ('Romulus').
> 
> Use a similar strategy to x1-asus-zenbook-a14.dtsi so that we can create
> x1e and x1p-specific flavors of the device tree without too much code
> duplication.
> 
> Hardware support is similar to other X1 machines. The most notable
> missing features are:
> 
> - Touchscreen and pen
> - Cameras (and status LEDs)
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Tested-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

[...]

> +&i2c4 {
> +	clock-frequency = <400000>;
> +
> +	status = "disabled";
> +};
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +
> +	status = "disabled";
> +};

A little bit odd to leave them explicitly disabled. If they're useful,
enabling them makes sense. If not, removing the reference seems to be the
way to go.

With that taken care of, one way or the other:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

