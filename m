Return-Path: <linux-wireless+bounces-19625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3DA4A8A7
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A891E189BB60
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5311B043A;
	Sat,  1 Mar 2025 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCIX9lfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50530199FBA
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805669; cv=none; b=DA53S68bJ/HyypT15Njg16SCMXi9IaXMfMABsQxr69o6+JJPOs/Ewm6DWpkyrywDk90YpA1U5KWnDl9bhp4QbvzUwMXHKRt6RcMqAQOvT2wH0Snq13ZlpfTHJ/ujpYGmtReyyFsm9p4ORGHvpq9sQrdEKNJOkB/LWKr1ReGVBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805669; c=relaxed/simple;
	bh=CxFXvby1AOyh8FCsGpSaDA2xskfixYsrEFb9d4PkoEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz6aRykcGm1PUBEiMdRIbfzHEUofxUsvM8Emvam2vKi0WODpMUcPztT7dcA8NhaGWGoyBdLxhE3d6hj0uelXvohafCGQy0TA4UZU7LPjYCeyN/mFEbwZeMSuOT1EVioY3fSi34QmAB45Sw4/fL+fBhQvMt8AOS/plYxMUO7mKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCIX9lfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213IjMn015119
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XFT5nBEi6P5rbXSNr2RavioxPFqsPJh7CqDvB8mlzxU=; b=YCIX9lfbSv04SAfb
	W4OCrdCDPGxlgaopmblrjkkcW3Rim59LQIWaRLKQXrDAqX/HxA7MzO7ha7g6mKNz
	+/1JB6T8KAhy9Tz87zt5uXw5MLyO7Ylof3fD1kcF/karBLhejrYPhmSboseAQ9Z3
	WVAGSFJBLhtLSegGyyErwFuv9G2K9gYs9SC3G0rObPfbCiI4Gt7dViHqF+O/Gqk5
	vupN1L4hB+whCKqSFfGs513qvVi0thCt84FiIH7BgdLbSq5rkQ9x5VPPUBr/b7n0
	l+kJZ/C89kjEa3N0TO+yjxf2n/BqI2gAxs4CO0Idc3lIP1SLXGQ3frdEEz2/HD31
	C+ln0A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr54b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:07:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso3532190a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805658; x=1741410458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFT5nBEi6P5rbXSNr2RavioxPFqsPJh7CqDvB8mlzxU=;
        b=JSlKfqgaXf9bJP8blJmNAqGR790l9r2+qGmc0H82e6Cwmyoh8lxRs8UQBp4BS1dajC
         dEOEDVpuZvCuFTNIksMTYckb0F86eunD+swUxzxuRDDm4wlsuLOd9lIzvShMN7vln9lo
         duupZIHtXZEenEoTi+I82/Pn8UF+Mgugn27JbUZtHQS3vg4rdQIN8ZbeAwrwgd9plOAX
         TThGb45bkhEa8+sU/P0bocPdi24T4kzdAaakNFPwaQ0PMzXu6Rc29C8WR/JB7HJSf2H2
         L+reUHVd6fQu+fW9Q3DOtASySaitr3gRybYb5ZGnBH4rtoYuHeeo5V4Q/tRL9/0PxgKo
         72fg==
X-Forwarded-Encrypted: i=1; AJvYcCUbP7fcLFRAobV2MtAgEI22jLk4nqQu3atKTsFhKtXKcpeHUvp8nXOPRIbIs1NFCPQLVqkZXdbnSfa89Wr4Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJ1VXI/jpq9VGrb/aOAf6es1O4sV9Rs1wfx1sC5d+Yd1cSHDS
	GRF6Y6sds/BUEL+hAO34JO6/DknZ2buzCFvvqzl8GojIOi+NWxE4I2118HIo3/Osknvjeu9O083
	78UwncSVngt6PLNhWXQJTH8p4fJAe5QMYRGq2Jlx8vRwRHu4tsWfqrbZ9RA/QkWvMjw==
X-Gm-Gg: ASbGnctDAMpTu9x+jmonn3JOuhGntx4T34Rp4VPNtISXhRaH8eKyTHKWtXWe54txeE9
	BQbnO9wqFqTaqfDefB1RdtiK/U+48yfiVWbmkrBnQt3ioH6jbNq1JtBAhymWfHcXMfMZNFgaTNX
	tDDNZTVloytjefhbz9ugj3A5pYZrsm06oxJ4pfxuDAlwXqdcjjXRdBeuzQnfPH5MXW/icaveXyo
	uFCzz/bD978qNege4rtx9tM1ljFCUIKjvb5rjKaRs12N1tjm0Jj/ViKwmullVexA5A9CAJJJTc3
	cw8gY698U1hYwc92umqbWqzrV86S25ziVpcKr9Y8TQPnEUcwOutnH/MU7lVVDjo=
X-Received: by 2002:a17:90b:1e03:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2febab75c47mr10665681a91.15.1740805658230;
        Fri, 28 Feb 2025 21:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9UVdU0oV+qEOL0CvwM8/vOiZK617gSZTNyxyzB4mbr004phFYfIO5DKdKHeY4FWpLxnLXZg==
X-Received: by 2002:a17:90b:1e03:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2febab75c47mr10665651a91.15.1740805657873;
        Fri, 28 Feb 2025 21:07:37 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b85sm6819271a91.26.2025.02.28.21.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:07:37 -0800 (PST)
Message-ID: <366c02d9-2b31-17e9-609f-e397f675672e@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:37:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 02/13] wifi: ath12k: fix incorrect CE addresses
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-3-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Z2Z4fo0xuoJJt43rJFrxuJ3kXLLG6lBY
X-Proofpoint-ORIG-GUID: Z2Z4fo0xuoJJt43rJFrxuJ3kXLLG6lBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=814 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> In the current ath12k implementation, the CE addresses
> CE_HOST_IE_ADDRESS and CE_HOST_IE_2_ADDRESS are incorrect. These
> values were inherited from ath11k, but ath12k does not currently use
> them.
> 
> However, the Ath12k AHB support relies on these addresses. Therefore,
> correct the CE addresses for ath12k.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

