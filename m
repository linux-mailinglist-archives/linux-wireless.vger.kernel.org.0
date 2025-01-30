Return-Path: <linux-wireless+bounces-18229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2DA23481
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 20:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAF83A3716
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314321898F2;
	Thu, 30 Jan 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvBdDwUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8251F03FD
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264041; cv=none; b=FFhvXSddPj6RQJCxysS9K08RuyZCsoQ/1OkmTNF5TKBYARl9p/On8kXUbOUW5wh2yZmc0GmIZxXN+kVR2BQXk4L+/5fld53+Wohq/pQNvSacDOEZgTtDe3DT2ef2vzbUD4ace3LFJg9SMNRm4X5bQNxfI3fTbLUovkHwzdYgY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264041; c=relaxed/simple;
	bh=pBj/Ril1YnghqrkWxFD8p/K4bAcqVGUkw+8Wg5nUKUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV78xLisbnWZdBJWJqV+aLav1Dcp4kOuKPeu4S78cVcffx2Gw2pmuL0wWS/oYGg8PqEZvQaCc+sfwgqB5rOHUqbxu9pSmXRARBBohypiVufxFxp534B+zbQdeKiBMBwhfe+3k+H+kcOZSMrKdPNzQSJzEs6uRv32FDb2fZrgwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvBdDwUy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ2Bxi005393
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 19:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3BhaqXgrMLyKfVblpg6Bsrl71b0YFcABEbF9BiIscYg=; b=VvBdDwUyDlBcBHYi
	rjjkal7KVs9FjsoZefLoyuXHaGPybd+B296tdMJDFNcjkuJc8vowZKYkXZImESKu
	uY1HJ1PA2MBSFOoHWZ4U30Fqef9nTv/8MR2jEJKL1YyfW6o9Noni32IqnamdJh2n
	FoaUVXCvkQpnA7Wj6kYDNBkSwirXsnFhLU+B4LGEiD/k2LSaIdCm4kR7KBcXvE9j
	1L6DVFD1+O/y5rLPvw9EFs6KrTsKaEocS+zGaK9/432a08HPOgZfbALDkSKAvXwW
	jOKCgCloDrdc0CunM7ykFDmP718PyFrzHdygc9jQVjrFXxmfkVKK5j+mAYA9B16h
	zqg9Jw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7j80m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 19:07:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so2149573a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 11:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738264037; x=1738868837;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BhaqXgrMLyKfVblpg6Bsrl71b0YFcABEbF9BiIscYg=;
        b=YfeEmIbia8tXKFWCG1Cd+h1hGXmTPiY30+978xXJqZiBABQ8Fb7RNY1qsItQ+QgEh8
         +CGafbVOPSt5WDqF9a9vzJdn3pL9vD1IBAZOALREMc27hoHKwcZIjpnIBtwFBf9MHHWA
         h5nO0zDJQ5h0KUQrmvp4z8GvFQw4uK8QIv7I8C4nSi3JgsUtHlqoCj+mn5r7YCqOtkCn
         JFGFqvdJVeDrYmI2FVfBSTyrLE8g9SUnxAJFJ6vblja/jfzhUXQc2cbb8dsE1Hs61bp6
         5e85P2qpGrY45atN7IIz6JN2lItcl+OlgQ+51pI0pukN8+wjG6JYJAUK+eVUP0HEAPi+
         1jCw==
X-Gm-Message-State: AOJu0YyvIdoGVwvaGkAS/7SeNvuzHTikpdYOnkn0gGESe5Z32sZcgaCc
	O4o7Oen6TEDI848/MRTRw3Jkj1TXjl4lVDuG0PpmoXnH9ffrAanHfg58tVYAVyEPF3vISefbKOk
	Al/TKDJS6sNlwhomzbqRlOXtwPkLeLu6P0N/ZI1QgCDIZxacbB2IWK4FNw1T92mEoz57EOC4c6A
	==
X-Gm-Gg: ASbGncvsgNspkQK4IUaFRWP7vn51kh65zb6ohDu7TeY88o/3VPzK7H0eAsHrCFn/8xI
	4IJhv3DdU/aFjrvXOLlMX/CEgLbQUy2pQM6RWXS4Rk4Apr0tB8NeofGlCx3rmsVco9fbg9reSyx
	aeHxcVMV2OodaQApyTp6LblSzAEplCnw04wPXh1Ob1M1yr9h430q4ubtW8UQoXEAZszPx7ACIvR
	TwSiPXNVJHftMJD3d+cY5K//kVpSlkNPpySBxHAMdHM9jMtCLwUW/uUgfseBlR89GOPLLVf1RTw
	h1gi7l7f14UnJrEHvT4siXQtHT5gWYnVfgJDjeu8pqCffdvcwj6wme4b7F0ZJ4PDpOnUSbEvSg=
	=
X-Received: by 2002:a05:6300:6713:b0:1e0:d766:8da1 with SMTP id adf61e73a8af0-1ed7a6e12f1mr13417006637.39.1738264036756;
        Thu, 30 Jan 2025 11:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg96qvbgqQ2gmDdQfd6xQyLD7vfiaEvtI6JhWhTIDtpEzP/0JSK3SeWZjihVBwGXNWf3YRmA==
X-Received: by 2002:a05:6300:6713:b0:1e0:d766:8da1 with SMTP id adf61e73a8af0-1ed7a6e12f1mr13416970637.39.1738264036374;
        Thu, 30 Jan 2025 11:07:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebddbb165sm1701686a12.6.2025.01.30.11.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 11:07:16 -0800 (PST)
Message-ID: <b3637222-d79a-4019-8155-d14abbadd6f7@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 11:07:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eUocl3XlguAVGBDefe7XBxo5TzxZCncC
X-Proofpoint-ORIG-GUID: eUocl3XlguAVGBDefe7XBxo5TzxZCncC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501300146

On 1/29/2025 8:34 PM, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 319 ++++++++++++++++++
>  1 file changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> new file mode 100644
> index 000000000000..bd953a028dc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> @@ -0,0 +1,319 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-ahb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (AHB)
> +
> +maintainers:
> +  - Kalle Valo <kvalo@kernel.org>

sadly, you should remove Kalle since he resigned as a maintainer this week

> +  - Jeff Johnson <jjohnson@kernel.org>
> +


