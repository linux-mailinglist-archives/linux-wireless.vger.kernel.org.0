Return-Path: <linux-wireless+bounces-23170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1BCABCE97
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 07:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070FA17F76C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65725A645;
	Tue, 20 May 2025 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMDu8y50"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295721B8E0
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718751; cv=none; b=FxSS3UuyETiTh/DkgMvRxAXMSkO8/KqcK8GwxVylgZC7bkZd6xrUEHEzn89z+3lkxD09N97NjJfDWI/dIU2lmphk7YUM05cfye9NTky+xkoXbRTc3OqC51TGXDA+7hIBWsTl7cU/PMAcdBPhcZLmg4/Z7QHPdLhqaKDiRnbln90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718751; c=relaxed/simple;
	bh=3Mez9l46A+ruFPVOU2nc/m9awuTx41UMsMf22WN1Fng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH/x5D7BAwkOxbB01lxMCqVUNAqt1LpQXNDtydfciiJLOA+nayDFbbXPZv1XC+8B0XeDYvWoYjkjORy5fhWNR1osbep37n8wh8u1iPhOVMVSDaVU9qQXGvr12IGCrkssek+zMIKfuYyo0TUhi4PVTKYgpKirsYiMeuMSsZoR7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMDu8y50; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JL2Ubo003157
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 05:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wlt3Fp0JW7EstEEKwfVT1fU4hBSzC86YFZZPKTQMnI0=; b=gMDu8y50Jc9yM1b+
	t+E/HWb+MBu7ivwEDtpR7sB7qfhbSVdpLp02rJXqJCpE2acqWeNGbGXuYQ/+Zeh6
	CMVaIMfKGOBtfgIWNJHtgV72+jC5mLDB5nsewhjqqr69WYQ8lIUy27E4LbOT0y9B
	Wp9QsyGYakB2mrJ32d+QvbjkCBQ0lurpg6deN+rjOZCs5Kp0vbmZfN7PLS4eo+Xa
	jyOdfSfZ/Czo/9rgavW7uyo3IYkJJdbAHpGhWoaC73uHXbEfkrb0bKME7mE5cWkU
	AU3w2CZhUehjABQ8L3akpryiobfjeGBKOrlc2SwVmF4fKsJcDXyFiSY9rtYoZ3gp
	KF2uxg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4pfku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 05:25:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so5372640a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 22:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747718746; x=1748323546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlt3Fp0JW7EstEEKwfVT1fU4hBSzC86YFZZPKTQMnI0=;
        b=qseS0bj3xs2OAZrj2Cc+mRfFVgBHrRUsaS/2EiNZd78tPXixXdXwI3QkX+ehk5C/0a
         kWIOAI+Q/UiJLdKNtCPr1MGNlQ7MxRsPgJvuEDFQv3kyoTngjnFB0Pf61hMVTcIvT30e
         cRQjXAtJe9Jgg8Gr8AD35D+5zfbVVJRw3CF7o1EoxvegO3Dvc4VDJk4EFHe47B5yQQ3/
         KZhyyLOJdJZO7LGZxghaU52N5P2Poqede7ZScZ+wuxPKedHmKr6J/4MCqWIpAwRu3nOW
         SCRmbgibG5sVd1nKIj8AdldlsS36w8MixLKQJ6hJSXVWQQoW/ZDbFMJ5wCz1ge/BnMpi
         yTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3NV0TeV/nbWTItO25pj+Xq2+tHqF7sfZu4ssTTTsg88SuQtybBCiso+b45ARtEMayi8fYvGK8PDOqHLp2Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7NhOGFcl+FUMC96jXg0gMJyXptBg2DuR3oDpXQzIrQT5FOTx
	NwScWNUZ8WzQzBgF7AK+WVwfTjtBiWpiNceUtIA5EnXb27arbd31u/GMQ9uOZnOQrnBA+RvoAq9
	YweCVJeXfjEVq5kfWLNrS3Z0SnmMP8EkQJoeDEe1+sQPxcaZIBxNjP/wabV+w0bjTpZ4G/A==
X-Gm-Gg: ASbGncvCcZIZJT60bj4u57AptZM+Ib7zhR/56v5zlyYgxiSE7oEqFcGlR6WtLCoJlzr
	fptJvmEOG0fxcKFrwjAYvTTqMeVCdvmTXN3QFn+HWRYxoNaZlrRTc2EvHofWumbkVDfUJM8GsMh
	l3dqwybZJR+APf8CxdUDnUlr0YApp9+yrqSWqVBtsi2xX4pEOCJsL4YIFxwX35osh7p0/F7ieBG
	4WGMSJEDVg8AU2CPeLH2aohKF0VSoG7X3OWyxOe5VgcLOFg9Lh4+FvU4lR/R3LlJGEzXRUKexkf
	muX6W9413pFKiOo3atRQ4sn1kD2amwwJmFqlEAGuj7nniBZpWkYydWjCdrRl
X-Received: by 2002:a17:902:f64f:b0:223:26da:4b6f with SMTP id d9443c01a7336-231d43a479amr243153635ad.14.1747718745999;
        Mon, 19 May 2025 22:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhicgIUkUlCk/ZP6SHXT4Yi37KIJ4JVpqAQQQeDzR9WBY4IywvHL5dB59fYn41o/WiUvpUNA==
X-Received: by 2002:a17:902:f64f:b0:223:26da:4b6f with SMTP id d9443c01a7336-231d43a479amr243153375ad.14.1747718745660;
        Mon, 19 May 2025 22:25:45 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.197.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac99f4sm68842115ad.23.2025.05.19.22.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 22:25:45 -0700 (PDT)
Message-ID: <deb386d7-2ace-aa83-4e44-742102e2e0fd@oss.qualcomm.com>
Date: Tue, 20 May 2025 10:55:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: fix mac pdev frequency range
 update
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ngbtNP3DcnAq7iqZro1ijHjm9T6dypsW
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682c125b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=4yAOwc62Quh7N6Ih8RcKWg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VeykXRrYc7WjYsKDlBgA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ngbtNP3DcnAq7iqZro1ijHjm9T6dypsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA0MiBTYWx0ZWRfXxHMDIBjkKS7o
 oO6R3B1yUBZMFNdHNZhDRxZ/UtaQf1yIhcULa+it1BaWWicIaemm+ydTVNVu/dl/m+aocIlizyC
 jDl5W1VPoy5fTMIRplGWJroFbkISx2IDMS5xk1vXJeycgYkM8yCss/LJ0b7H23/p4DWX6AtmRrd
 IJRvEolPZcwXnRaEnnC+vAzHDS8eVtzl31bQNWo/VKP3b2wtjgWz8RuzFHFOHJZhFkX/xs0Rk4x
 J1Nj1JRSBV/GVey8mHXrJyOj66aLnp6wjMGkMgMLMpbPBKx+sgFsZocmtWaKZL0awZNHVpR/WKX
 6HIpzw2v74NWxmECHXJeRnaPUFhvhMo1hrAiEz414UjP5+dfv5B3nyk05M5GSRVO8Eh2T0+PrfW
 u/tQ16i2OoVBpRCIbz40b7kZRunHJvBlduGIPzr5kUNXxhwrN/fhotlkojEHO0NeLGAp5/Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=750 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200042



On 5/20/2025 10:06 AM, Aditya Kumar Singh wrote:
> The current implementation of per-pdev frequency range updates assumes that
> each pdev supports only a single band. As a result in ath12k_regd_update(),
> bands are handled using an if-else structure, which limits updates to only
> one of the band per pdev. This assumption does not hold for all chipsets.
> For example, the WCN7850 supports multiple bands within a single pdev.
> 
> Hence to accommodate such cases, update the logic to account for all band
> cases by handling each band in a separate if conditions instead of the
> previous if-else structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 13324cecbb2c ("wifi: ath12k: Update frequency range if reg rules changes")
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

