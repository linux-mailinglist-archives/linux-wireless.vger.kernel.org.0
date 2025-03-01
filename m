Return-Path: <linux-wireless+bounces-19630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C5A4A8B7
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09D87A9762
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289B1B87F3;
	Sat,  1 Mar 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEGrlm/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CE1B4F09
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806009; cv=none; b=P6+d0QDfnz2Up2nOtjc31BqOoxv+VFN/cIiNac+5u7EO5sr63APcJBh5dGW5QJhSypg0Slp6tSV5woYWcZRnMfIJjdtl/aD2wYj2l2+sdMnXYDZMmPCn4zN9otdbUxcmr+/gSox0VhZl3JhM80YPX/v8lUAafXxpHYXBo7jRL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806009; c=relaxed/simple;
	bh=s6Q98o2nzYuzIZrpQ0DKjzRZunUGX7/VgDi8qku5YdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMKl4YEKzC8cn5SEgqBcqzobNW8npS2p/VeoNfNW69um3J3QH+9Gtw6/IXmnqlQKRjeR9PnJb+McP+cDVwmBGTzLJKxYo9azJWmwkzwc6acC7oGWzAilA9oVkPYoFYUN15zVZTwQPfUi+2unAC7hMZN1e+DbNWWslB+bUIjrtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEGrlm/c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213wWPP011120
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00pvRciJywe4pbk8Zn2txD6iFUc0etybYgSJXQKx6n4=; b=bEGrlm/cmJMInX0A
	LhfmqC+jXOELDQ2QT973iHmsGzS5s7AWtGDz6l18BMOKI+JtijrnkboxTI7nxJOD
	pQeqyPpe9ScbbM5DGC9rbk+UYV5jmUdo9zmuNr5x1p1bWLibGKQUlxUwY1HuVkiq
	1Rg8Fgjib4vvDX9uU3NMuQCaQVB9blqoD6XvKjt4GF7n6rkAjJJBgUn5wyemhKqL
	xRVRwF+UGHbfpE7k+K1bWaRHLF/gYnZTHNXCVz4VG2fLP7fm13241xnN9CN27i3/
	NCBG6Sy/YVxBIFEWJaTg4DUTjyHwRNGhgDqP54HU1BzGu2yj+rg34K4/WdX+/Uax
	+w93Rg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k05n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:13:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so8080398a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806006; x=1741410806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00pvRciJywe4pbk8Zn2txD6iFUc0etybYgSJXQKx6n4=;
        b=Fo/QqEgPiAsB7KMNTR8cPkDQn4yfBOCkLxznK8bzMWeo1BTb0x2Nf1gvpnjsZduzNQ
         08Zm03j/d6I7lfJ210m57KsHEqCVyl5qY5dilSTXfBcPqdHX+39y3S1wxaajI8X9v5VZ
         zGESbbxRMZPlKCsnKF4NjL5x4b6OucXOX0QplKvgfoPEhVHdKqCLjkaEhdNvqdiSzBki
         6Tb5zHQ8OnEPp4Smg+Zd1rnkbAEl6tuABkZ467x91NftmyCzhlKziOiK2i1ddMUu8K4r
         qzBQFoUm38qD+QNZ3R4J/ibwbCJZhNdzM3yjXYDfdaw79M063vVdq0sWKAUW2etoNEEp
         IPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVymQRLhoQAM9M4DJ3YWC/UTIA93n1j+qvvgJNs2KfxoS8a1i1VC91yECHBgNKe8aMOqK6n+dlcXu8zovcUtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OSusqopek8Oom4X2sFhY5ofS6Dt0J+oebmBHxvCU1SV2EeQL
	HuWimpX3reEKY1lg7AKGG27i/oaR/BzI1fkw+SobfjxPceFfM95LnNIu3F/klcyb68DkGgGGpUG
	zwUZ2YmSzJKnbTIZOxQ0Bl6YdH0TZBnwG82NXkr3ITD0oWmjfApV/I+txwFWc46MJRw==
X-Gm-Gg: ASbGncvOcvymHB3UNZXZ3CHjhvCsUzhCIb5yBhtxvFlsd+lWSUwkN5M2MqI1G4/8EYS
	CTCl9ZIaNtrcQmahYVj/A4WS11CtyCrbEq4Ni+g1dsgAAdcq/44hmpVS/PjV/IifMcd2w4pMkOh
	sIi7jcpExdnWmxJ8B6Tad5n6p9ONps5aHVg8RwqIL1xvzszaYWIEUzO/FcJGQPl9LnfJgXNOruf
	g0cl0B3TOEg3g+tCs3I8RwltL2TRvbuPu+BzbXUXhCH/uJSlQ67xXUvtExa2IAAP6zqi8+6ct6O
	JSwGJKMSPB2W71I/nhfOLRrIZPu4lc8+7yMtBJtuvNYn+OfCKY++LHEXeAGJTh4=
X-Received: by 2002:a05:6a20:1592:b0:1ee:7e68:6987 with SMTP id adf61e73a8af0-1f2f4ccc71amr10352734637.14.1740806006478;
        Fri, 28 Feb 2025 21:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzPjIspJjUNkUjz4HWnpKLOC7JMERGF/LKOMRzg9d6v2hSHkgG9atjNmQh7kvlQnH86ulpFw==
X-Received: by 2002:a05:6a20:1592:b0:1ee:7e68:6987 with SMTP id adf61e73a8af0-1f2f4ccc71amr10352716637.14.1740806006175;
        Fri, 28 Feb 2025 21:13:26 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec6727sm4361507a12.51.2025.02.28.21.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:13:25 -0800 (PST)
Message-ID: <3a665200-04d6-b9a4-7f47-fd7e68ea438c@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:43:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-8-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-8-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dw9khN7kyMHzjMP2OVT-w0vn1gyMGGGT
X-Proofpoint-ORIG-GUID: dw9khN7kyMHzjMP2OVT-w0vn1gyMGGGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> IPQ5332 firmware supports only fixed QMI firmware memory.
> 
> Hence, add support to read reserved fixed memory region from
> device-tree and provide the reserved memory segments for
> firmware to use during QMI firmware memory request.
> 
> Note that the ability to set the fixed memory will be introduced in
> a subsequent patch. Currently, the flag remains unset by default,
> ensuring that existing chipsets are unaffected.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

