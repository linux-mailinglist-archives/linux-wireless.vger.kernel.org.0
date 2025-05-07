Return-Path: <linux-wireless+bounces-22716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DDAAE298
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15B41C41312
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2028BA8D;
	Wed,  7 May 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxLuGw4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2E289346
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627255; cv=none; b=ZQfAy/ryBdalspVB7HFAumsRhWBoQgRxFvLbuc88nVljY10cxN+/AMHQdmq87vi2e6NkpVvxlBrNyR0EDsRFkVVuTk+3xtOqBI/f6R4ZYuc9sMw7h7REIKk7IneH+tBtTSXdVF+nI0x873KLWBooM9wZNKGrLA1zUTO829YENmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627255; c=relaxed/simple;
	bh=zjA31ECKWrYkvp6T7RqaV1DJ7jIFc604unho5HpCUh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHweuasuQsCtVTeGUrgaUpQcDegHPNgVPCYaRBtKPu5z39MUNA7zMfZy+eSCltMFYPPqrca3rW4eBPlpZ6WwgmIa7mkfuTVVkmrTHGBoPLmVsaXaE5ds84egmOhYySYYl/rSWJ875JWdxmu3iblOFyFilfDjAnAxCFIw9Gzdsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxLuGw4i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547BYBmk018749
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 14:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGluIw6NWJNNfPUxDeMzbPFoQEkugMbs6IrEIEEdFwI=; b=PxLuGw4id89E1aml
	6gV5ozGPCswlL9yuIGLr2dBSTp8mzQLJuaK670bAK7VHXfylNPmHlz/kmJkNEW8d
	VoXugREKv37J+sWjuir7/XdG7+eICBODoQfkBXVjC6Q3Rq2OFr8htq9nSaFJRq/L
	DL4WHqEb4ZqE5DqRG6PbXAue7XNJuHwOngGQ8jTd6PiXqvBgfebIWRXYJR7G9uFJ
	Oy+XvCGeY5DO2zLFBQqbwpAWh/TJh6A1Dow5MtaM2RcuBRznoUqwrYNiO/dq1KTg
	LeMoLAATRbcp5S7ynDqzPQ56aL9fZ/OBAY3iif2IAsfj+MUlUNouBhxODjnJ1RZD
	L5pEig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tbdycf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 14:14:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so6319293a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627250; x=1747232050;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGluIw6NWJNNfPUxDeMzbPFoQEkugMbs6IrEIEEdFwI=;
        b=rg2EHCxk5CjjP6r9jxx6AQX/tA6U09KauHEXMokeOVmyXHQTTFQCA0CCytA6WRurJM
         jFvtZfu+yuyXodCIZy/gZlbmgYHZLKJ17hfS7AllvceZ1nbM6ZBz6tLakstoqGCSIIWO
         w0Jqhsb9oh+CpTOdkjJ/VT0TvIPHCrKWrCl9IZceGW+wQdaNy2FlRmghW7Cf+1Hlne6E
         FnSp9eRhEj8Lpz96AUa4sh8byFBRDmP7gisPU3yzGzNPAamPLOAVSF6Fzj8RBOT1M2u8
         f45Nzj6WSsAvCr2PbxTQ8/j20+XTFNYbwxNVpDn7zAwMyL1cQKAZKqemrb+gb3cvAm50
         BWkw==
X-Forwarded-Encrypted: i=1; AJvYcCUJIJFufmOTZiV3ChxEuJLjyLoPEmdI9i0lNtiKqr+IlMfpkUGsNgb77ddmN6bTvjOW+5pk7Kf/gZNBQf0CFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWxGVnbsDS44B+eOb+fLLEEgSc4d4q1ZSZJBzLSu0PADzq9jA
	SX/fyxmEKiiWuYoRfywha8W+OibY5IMF0HATWqO3UDJyckGCa9LZiX5cUdKNoRAL9K1WjPVeo+e
	n3yFDc8fdmRH230uOq+0xs7VdS2WNJ5hQVeuLTdj4FtjXhuIiCJNIGfKxGVP+0uqcyA==
X-Gm-Gg: ASbGnctIVInkHuDsHJSwvWmQSsHxlM/CTQ0QQfhYpEBr4DR4LchQEbc1oTL25CuMThi
	JNP4qJ9Prw0E3G2AspHnxTHCHmXS07ZaWPrT7rAIjxP4+DsOD9StcqUTW3Jf95OXDYAFAy7szEr
	nL0FJaTid8NvVmNj/QHgv9NtA/dlmXY7Lrja6fF1DNIUs9B3a6L0gTnl97e4ZY+oQkcAVEmyQSK
	rg0hSTDa3CSqimzqq8jlYj8bVW9TlEk/fAk0hRog+XX5yf1HDqmk8crVxgwBHzOwvH4elA4p/x3
	M20iZx7DFwIb8tL4HnnvI9AuiW5wPfg4cxCdBf0U8IChd4o+/rEvbHW1rUaPN0z9dZA=
X-Received: by 2002:a17:90b:3848:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-30aac1857c5mr5519669a91.4.1746627249720;
        Wed, 07 May 2025 07:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1V1DpH2j5TQAnKSXjEhB0Z9ZTZtIJQ3RIw8lPQXZTbkyLn3CbGTR63lRfuDo8fl3HrCpE0A==
X-Received: by 2002:a17:90b:3848:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-30aac1857c5mr5519620a91.4.1746627249268;
        Wed, 07 May 2025 07:14:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe2248sm156879a91.35.2025.05.07.07.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:14:08 -0700 (PDT)
Message-ID: <608a5b08-a5c7-46a4-adf0-7106e4d82250@oss.qualcomm.com>
Date: Wed, 7 May 2025 07:14:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Kunwu Chan <chentao@kylinos.cn>,
        Troy Hanson <quic_thanson@quicinc.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com,
        Carl Vanderlip <quic_carlv@quicinc.com>, Alex Elder <elder@kernel.org>,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
References: <20250506144941.2715345-1-usama.anjum@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250506144941.2715345-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Qa_WOwsQijPOmJmmnC2CgAoh1JdEOlsx
X-Proofpoint-GUID: Qa_WOwsQijPOmJmmnC2CgAoh1JdEOlsx
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=681b6ab3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=4n9vdfglUG3wgorB42cA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEzNCBTYWx0ZWRfX0ZniL0PZeNq4
 xyCFxNbBlmIfDd2wLbeBbjpBm7YMdIGnTmVAECKFmHuJdDkAeHUiw47fdiyCsrJWrQmQTdVOB1k
 2bKX/ne89/COKDhYNWZaQYhANV6KWeCZ+n8o72jO19VDh/cAsCWpUiCEJaKv7lBGoO6UyJAZczU
 sJ+K4mv9j7jtogP+YxJWuFXkhtvo/HucxAdFHdNkYTB1IZNkm88mYkqQDGute9TCQWJPBW3/agQ
 aYDdxrKfVdh9hDJW3SHsNOHZmnAH3TX38RRVFHt0Ww7nXkcyUt6+xyvTQcLC1h8bMsELIjP8bxz
 7iobtJD1BN2sggbOzvCrTRjYA7sSK91EpnTV1AmoLcKYhMfs13ZmLQFDE1hyQov2yyeBLusix6J
 FbIb3YbINBpV+9aaycmNzwsvoMSGfMSLegmykmgyFRwJ1wSXy3Xb1rn1DCs91+2wHjX8TsWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070134

On 5/6/2025 7:49 AM, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation because of memory pressure. There is a report where at
> resume time, the memory from the dma doesn't get allocated and MHI
> fails to re-initialize.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Mani, if this looks ok to you I assume you'll take this through your MHI tree.

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


