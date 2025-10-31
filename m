Return-Path: <linux-wireless+bounces-28433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2FBC23475
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 06:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E381A60998
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591C2472BD;
	Fri, 31 Oct 2025 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9gxUhAs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9Y1aSmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3782D248B
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761887003; cv=none; b=kcVK8izGG5zu6ny5Kp2usyOeCPFoY52PlaBNNf7M0XjuHyXu34Klz+U19pG5W15Yd7/O3e7CsxVPQFnK0Xec3Rc1Thl/gEs5Ufzy5kHwKD0lUAEpUwieWK22QVrqtl8T7XA1MaTzjcGyn0OchhK+1kMfXv/nweRzHkfCq2HyW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761887003; c=relaxed/simple;
	bh=lYj9VcHXn7/YnK/Yz2zHJ3l82JYmmkrccb6XVJxA3EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAtGGP2AASavUaXWNThUQvYmWDXpcAFKXHgfwXmK9ldmzEDFCFNBqTVhnBzHW17dWZzel+P3myU/caZvPE5HaDQeW7cGIhAg42rf5DNIC+07zbXmwZMb05b+8vLu4zLNPlOtRhrEp6NItfNOFc14epHp/EaJ+qWmzj/8rhmPX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9gxUhAs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d9Y1aSmD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULrORR898100
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 05:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnmIIGRyWDgzpEL4nE9m6+euHmxvL+6pBVybBni9b6M=; b=a9gxUhAs3++JcMO1
	QBnesSUIbVk25YyNBZ5TApfoJEk8/AU1Xz4ry1wmuyKGbw0I2V4tc0TrWH+c0NA8
	RdOd/ssOOwbKr0cTe9vhZ6l7KY96fmM8LJAoTeJcocghTrbkj3GEE0huuHMJxut1
	A/ZN6euGCMZvj2ZbndPjpB7tDqIw8gyqRqozSpSEq1B+u4v0dGJbIJxvQN14w6um
	ENqQS+/LwGhnb0OLTjNO+PtuqPR+Vl5Vgy0E6o5OSGR8EPRKMOHy4+FBW4M6Pi/B
	oRh4SPEfACquvG9Z0X0Li8719x5b5Qc7LRcAhAuFf2zhLMkGPXkE72a9h7UWSmmj
	vVlK0Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb20uua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 05:03:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so1599001a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761886995; x=1762491795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnmIIGRyWDgzpEL4nE9m6+euHmxvL+6pBVybBni9b6M=;
        b=d9Y1aSmDSDCnOi3ZHa2ek2o4GXefnFYiI00E/jm9VVezItLsPxFnHeNaI1tiPsOIHe
         A4N5T6ZqnLSO3KWiBn/A2g608oJcfJpejsSAplg5nb9Dbwayr0k9Z4P61aH6EL4Q1cmz
         ZBTErRhf7mWTp2uF6rIusfu1GoRHuHMhLvoofCXykcQKuoMTT1AzzpBua6BbExo5TCtL
         JsD98PC+Q1RLVNpRVB3udpXYIW4OWgp9mMyX49lO0bxlYUeuJauOXu8yg9zZk0sIJfcE
         3Jyv0o5FnCwCljH4P8wNews/bPS7W+75Iw8DhTGMzMsu6n8wS+l/dI8wPCrKucfWQbtr
         4pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761886995; x=1762491795;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnmIIGRyWDgzpEL4nE9m6+euHmxvL+6pBVybBni9b6M=;
        b=kKtOiVPpKZb9ho4VbqH/nG/YQI5BrmiT+LBFiMtYaY4qDTy4JiyrE245Zk8Qg6rvfn
         QCoz3D8BdPrUHUDHo0T+hUk7vgpOiGexMqLWfKhQ04BfbNFzIEI4BcIfwC3To5CHLCXM
         FVjUDqMMkuogdM4dvuIC7OY27XWJk7NAib8Dwo7gbSsAO6NvBk4Hwflfx9F8hXteslAr
         YSGL+Ex50z1egRIXIqr0AY6wf3QllsBz053p+Run1d81hfToEj3atNaEuMu35LwO1Ii9
         bPGMq9A296tDJWGSRUJkqiB0/6rUu2+n/Ifq7q4FFsG/4BmK/YxXlUBHHZFMiT2luFXR
         f2Fw==
X-Gm-Message-State: AOJu0YxFMaUIDr8+jBfAaXQTpXBaNHTUE0bhbmfoRRXsWWWKjm1MJ9ZV
	LY9HGE7w1W61qB1U41T3T/O+tNbKQYkwc42qe3M0mDWaSO9BCAtaXb1bBXW3CwevfzojwYnkEOg
	YT4SBBPU9p7qtR/9ZBxWr/bosL1iaijQAKGMkWq8IzUMkThoD9eKoXprGCaDJNbQJqPXFu0Sp1e
	GdrV9w
X-Gm-Gg: ASbGnct6sGoxpldOSAGUKaRLEt1qggj8EpPBpc2n2V3NFKeIgV7RgdtBAV5ujFoLKto
	sJuXSHqoODuhqOmKF/aSbDl5KH81C3cg+l7e/HnJBIXLiD0psaEIQrf8f4B6Uqc00s9tIbPrWwt
	TtanQGuJo0gR4rZdHc3YVhvJ3nGEUvRsHCqiRKWEAfU5GG+UPawWsyFGU3pxhQieRdjHvwF99AJ
	EAofOzNvbh20iEFed0qBTOSDL4oggyr0W/QHRrhV9t2CTniVPPIu46zk3t6k0KeqE18ZsmIugk7
	ZWz6jfLFIrZtcNsoLXEUiuWVANmZDiq3ACuVnqfmZyYzr24kefJWsSFv8b4tzovj+ev8W6G9lA1
	pxMDzPiUR4RJWJHD8eyZkquyP2OxZ9PEKuNPoiEBfgj1V2+RGJBlbGat4xT4hyHZOPNx9MvE=
X-Received: by 2002:a05:6a20:734c:b0:340:6b3e:5611 with SMTP id adf61e73a8af0-3477a5c12admr9772189637.6.1761886995203;
        Thu, 30 Oct 2025 22:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEevVdIiUdoYC7SFpyz3u2jiAoKNuX9JBljSICU+CMAR68uvct3zUzNMA/8ltjmJYkYlUI4Pg==
X-Received: by 2002:a05:6a20:734c:b0:340:6b3e:5611 with SMTP id adf61e73a8af0-3477a5c12admr9772146637.6.1761886994730;
        Thu, 30 Oct 2025 22:03:14 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bd9616c9sm672853a12.23.2025.10.30.22.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 22:03:14 -0700 (PDT)
Message-ID: <c1304269-7826-4381-ad18-28ad40f79625@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 13:03:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Address issues during beacon
 stats retrieval
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=69044314 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RNRu0hrWFMVXu-6-hGoA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA0NCBTYWx0ZWRfX3fsm8szVMGHi
 MxNjhcJVYRHxrld1iHIaq9ZEs5OfAuMtzK8P1ZSwEzpksVbzTZ003Sn2aRDhFIjm0Qsuey3eDmW
 36fEREU/NMVGNfW3KpRuOTwe0/zwxh+kvhnYA76RIBBQ9Qu2OvOB2IWDAGlUDfo2GlrRoemcEWq
 neqB9deO0X8mGT9BE9Txry8AmVNrCY9S9mVu8ghOYCR1iI5JElE/IRlDmLE6ariXXJH/BkVDlPE
 C9eRNxdWLGGIS2U/xiU1Mje6JfFf4PPRSqn3bSZvNsAi317jrSn0x3mG6Uhf6DPQ7mXJ6nQD3KN
 8f/6s4va9RcC13iC4heJQduoBsrdgs2BLm8zYr8bNzR8RtHcPqNcmeiFucaOQuN6Z9JzdpdWqYf
 3xILn6sAaHL/0WNcG9w2kaWd5Txbxw==
X-Proofpoint-GUID: pd0JMOAskb5DQHwFMmYPvV9RVRyORKoU
X-Proofpoint-ORIG-GUID: pd0JMOAskb5DQHwFMmYPvV9RVRyORKoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310044



On 10/31/2025 11:07 AM, Manish Dharanenthiran wrote:
> Currently, retrieving beacon stats is getting failed with timed out error
> when multiple BSSes are enabled. This patch series tries to address the
> mentioned issue by the following,
> 
> #1: Reset the firmware stats only after retrieving the complete stats
>  #2: Remove the wait timeout to get stats for all enabled BSSes during
>  beacon stats retrieval.
> 
> ---
> Manish Dharanenthiran (2):
>       wifi: ath12k: Make firmware stats reset caller-driven
>       wifi: ath12k: Fix timeout error during beacon stats retrieval
> 
>  drivers/net/wireless/ath/ath12k/core.c    |  2 --
>  drivers/net/wireless/ath/ath12k/core.h    |  1 -
>  drivers/net/wireless/ath/ath12k/debugfs.c |  9 +++------
>  drivers/net/wireless/ath/ath12k/mac.c     | 15 ++++++++++-----
>  drivers/net/wireless/ath/ath12k/wmi.c     | 12 +-----------
>  5 files changed, 14 insertions(+), 25 deletions(-)
> ---
> base-commit: 197498315de711140bcc4722fdeb7c1761777100
> change-id: 20251027-beacon_stats-5a84c15437ed
> 
> 
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


