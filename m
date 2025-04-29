Return-Path: <linux-wireless+bounces-22181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48723AA01AF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 07:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8858246262A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D331A5BBB;
	Tue, 29 Apr 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nv1quYBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB21BC5C
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903887; cv=none; b=RnyC6qZ3ZPu/LL4r4kjGpwzyVE5l35+stnbH7TKe2WUJFtb834xje0SZ38N9CWvUdAPnzuiZbWPLByj9XxwN+MAlZQspR5LTIguUAxBMUE4B/8CQWo8qvQLGoOfU2zJKqkoYhRLWv7jS8wL+xk1D9H81CRINzAfZ+49imHVM5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903887; c=relaxed/simple;
	bh=yVefowTQu+ZZcyzp680EtmgVlqLf3JSI5XHAsystQF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhE6y5V2lEuM6/XPAmH1YzLTTR3fRMqI54YHH6K9OcfuiVzxbMQdPtvLOKTM3Xt2I3Wn9uq5h4Oyqz9ha3L2c47UltT/iFADHcLP1sPZwhZ+Oau0zt9OVQFDvYbzkWwVcNrxMVvN6AWTiFQxGXKEM73Ercu4NUdOtxjOfNPRYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nv1quYBL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq2qD019694
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cA8DttvezShyXEK6Bv9AR3jzIX6m84IOgjCa99x3Z3A=; b=Nv1quYBLu54ABOKh
	jDpLJpuwBK4fQuO+WMPKDj6tpx/bSmVBVzA4FUzKJQjVcilTnIXxCt6d950m3TCm
	KuYRS7rqo6CIu51RuVSucnolkcB7cF5UO3rbuPOqp3DayjJoRGDW3c/HAyQq6Jdl
	zJ9zUEEoqXiJ8XscUPARB5KNVem7go8vy5i+5sgxwwnvimF5Af4sUmhQ3+whEpr4
	gvudwVFv82FivlRxjMD7lY6k9mYcpBzrmpm4U/gxw4Wg2vowBU18zuONumQfjYJY
	JRfUQc5ePWZ75YQp1rQ1SLy64h9JXvoacZWnleKtXR9bqbbIYr6iCNhWXXSHuBW5
	ZEDGIQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468n6jjky7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:18:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736b22717f1so3980642b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 22:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745903883; x=1746508683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA8DttvezShyXEK6Bv9AR3jzIX6m84IOgjCa99x3Z3A=;
        b=ivWwOIgKgzvT0W/roNjPWS83Xex1uE8OxmwrrLx8B4plSdtZFp/c1KSI/TbxfOB8GD
         IKTsMoPBRoiUJdvM9rUDQYfz0c4Uf/D0D0LZbKT7IsHTrK68jrNgZ2a1Bl0r/0hS9eVU
         Lq/ULywwKqU6zVtdW04EaCdzcS5WZwNHtPJQSTdI+YBtDL+vxYptXH4o3EHISsROWrNq
         E01ogF/oiS0zGn8KEfORwBCem49tkaWfu9QDaiUdFHo9xDa3WSZ/85pEN3WP1qUUxh7Y
         0bcae9fAlV0qZQDUgNYh8vFP39gxGigOOAS4DIaCbP3nSm9F7h4SEV0bvOR+FC8VJVwP
         eh4Q==
X-Gm-Message-State: AOJu0YwS88h7PR8ii+l23ga4vcd5TqUXPeajA1Zxu02znAh2y5gUKuXC
	pe1ESd8y6eapsVToM8UfEPUsRgy/NVzOf1U7wWPoVS0AIOzIN+XBKOjFc9Y1+P93ynqBv3Oc+sX
	GwWKRknqq9xrGleAo6wVBRiu4KgntYbh8x2WWoSth48eDNyvvXYosq0bbbtqUPe9vfg==
X-Gm-Gg: ASbGncstbjBy/TtJvvWqByBwzmA0g+x6dAIpsOooUq0uR0z5gaZeMNDXfUKdJJNrmVO
	GbmVr39t2u3YwH0wqVQHaCMODZcj0dAGT435VPtZNFZApjcW5NPt9lfVlWCftSzjQxkT/NQWneV
	heJ4Q9OWFpIxpWUb7GYlh+vghq4hysTrmTuBID88GkrueHc0GqroKJB8Q0M7e3UDeyfZkPcD0pb
	L6tY0SjAVenr1DnRU3j3JR5w26nVwoaz6NxnAo75OHCMRjTBKLX9vdeRSiapKwiROZN5BQ2dY8x
	5vrhaGa0nKcT3vDjeySARF4gps2/nAkJ0NZemYxcQ77H2yc5QOW3TA==
X-Received: by 2002:a05:6a20:8487:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-2094f479a2bmr2277502637.3.1745903883437;
        Mon, 28 Apr 2025 22:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3upP0c6A0V0zlQysj0bt2oK9Lx16QvU55T1RVoMsFPKHhv3pQyQ3vjpXnpRuCGfqhh4nezg==
X-Received: by 2002:a05:6a20:8487:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-2094f479a2bmr2277481637.3.1745903883052;
        Mon, 28 Apr 2025 22:18:03 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25965b82sm8994435b3a.79.2025.04.28.22.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:18:02 -0700 (PDT)
Message-ID: <a5cab792-04c1-15f7-ce36-1b8104082f51@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 10:48:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Fix asymmetry between
 ath12k_core_init() and ath12k_core_deinit()
Content-Language: en-US
To: Yingying Tang <quic_yintang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250423055650.16230-1-quic_yintang@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250423055650.16230-1-quic_yintang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzOCBTYWx0ZWRfXxosV22QIt285 h+nAO6yl7XTooi9pi4ojeCdB4HNzfqKBBBjK3ZEgZOBPx3DyxqCwZFcInN5EBlcTD+Gm+kcg5qg MsryYM89yrIIx4RCsEDoPNQn1iO9+lFXa5z8mrlVtcXpjrWmwoYFu/zMDAjc10lW2NXpxPg9GRY
 jOghaWRC60Sdl4gxW62vwUXiC6kPvmOqh6SXbYrKnn5KwtFDdaFmabUEYx9ynliU4GHCeneK6bV SXfe2YgUv0c+hNpIjdb5jhPWs0767KQ2fi79ZErSmlpn7HnQsKqakhd0Rh2QMTfU+7Ta/WjDcRN bRgcJjS24GXZMItI/bKdilck3qJBre6c51AFqxZmGjvIxNmAeucptMEcNBBMNZVr2kwwvZeGP/Y
 WSrzj5ejn/rC3dUqi1mVzapVaRSJr/SSwXT9WQxGkCOZ2a1K3QKP4m+M2/PDJ3c87TTEeBHE
X-Proofpoint-GUID: r7EroieBfi3OgOSrfEk4aQcu9T45Gi2N
X-Proofpoint-ORIG-GUID: r7EroieBfi3OgOSrfEk4aQcu9T45Gi2N
X-Authority-Analysis: v=2.4 cv=C8fpyRP+ c=1 sm=1 tr=0 ts=6810610c cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HYYPFgkb9UnnZKMoj5YA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=381 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290038



On 4/23/2025 11:26 AM, Yingying Tang wrote:
> There is asymmetry between ath12k_core_init and() ath12k_core_deinit().
> It will cause page fault in some case. Reorder and relocate the release of
> resources in ath12k_core_deinit() to avoid this asymmetry issue.
> 
> Yingying Tang (2):
>    wifi: ath12k: Reorder and relocate the release of resources in
>      ath12k_core_deinit()
>    wifi: ath12k: Adjust the process of resource release for ahb bus
> 
>   drivers/net/wireless/ath/ath12k/ahb.c  | 5 ++---
>   drivers/net/wireless/ath/ath12k/core.c | 5 ++---
>   drivers/net/wireless/ath/ath12k/core.h | 1 +
>   drivers/net/wireless/ath/ath12k/pci.c  | 5 ++---
>   4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

