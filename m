Return-Path: <linux-wireless+bounces-28354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EEAC1962B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1813A4E63BC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB14253F39;
	Wed, 29 Oct 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Izo+03bp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7cWXDrH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD31A8F84
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730379; cv=none; b=mCxF99Uol/BkWRt6i0Q1BaqvnDu2SnbpFEhphv9kNOshG9IIH+q7sJ7s5cT/XurkO3tLeBl8fzsf2MkmoSZutWc8ZWNmW5h4tMOm2QQQZGXrM+o1C67W9FMShv5wkxY+2MXhQGcykMOr18ZVCkP6k9zqDMOY5B4qBeebdiCoUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730379; c=relaxed/simple;
	bh=0z+JeJm/YXQxHX5ZwVZj+Hn+3fMYyTkV/zRa3fd7k0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8wKPHx1F39hNwV0/nvJpAJ/SyMDe8BcDMoACPUqofh5jBYzCpkqGK0lykRcboolEp1EiHU99XEBhTl8CST4tExln2ll/NHB0Dn2GUKqIG7O71W5XttbNf2N9cj5hjmq896G0i8Cqoo+Y4wB8AA1cL5/WNo1DYk4fG/wF7+0gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Izo+03bp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O7cWXDrH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vC0E3664310
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 09:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zWi24kAJejrPENad76Qq2UdryfCSFDydt8kyu/N4BqY=; b=Izo+03bpwNgirYPT
	koLcdRD7HsnGn2kk6xass8gkF6HfaCNJIQ9WKY+8JjMFdO4Z8xREAajxtQo2XCwB
	Nr1H6ZZVUymIJBLeJpuBOYctmKN6CcxrzXkoj8EL7Jb0SheBcWSTSxjuQ2whoGck
	XXc67IYKwPEG45/SpXohrGUk4puvvIhpuBON10KgHl1WUb7W6QnJ/w86aswRnwp6
	nIEn/sTLCZz1NaIeNXZUR4CABI4cctD/bg3dOhBREmhtAPytOWLhjOVfWRaA5MR+
	uA2le8poOfDOJOeKW7EDQxRy+Cz2cRTfoKGY1VnNx1H5sxivy7xHDkAiLuRnXUoI
	w8c/dQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1syhm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 09:32:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so11293630a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730377; x=1762335177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWi24kAJejrPENad76Qq2UdryfCSFDydt8kyu/N4BqY=;
        b=O7cWXDrHMosNKwYwQEl1/WLuv0Ap19srR7CvJs7I2Li4OlE+Imh+FvEEYPbf9aWDyx
         HoG2VJ+YboD/IpyV9tFT8qFAUgYNrSxlR58jzzBhPXAdEgV76Ebe+XDxcqre63TV9Zh3
         UPmbVOZLy2DKMx1OFwdgEnxrYJpP2aSIeU4w/QXlcM/DpFqHif/sM53U9DiyrkWqYZi4
         hmXon1YegbbYjQfzvn6G3F0wnGAJxHgiIFeIIPbGeN2SCYzVEE8LfetGibJrVUQ385kK
         dIN5XEQP+faNoGWmz2Nm+PM1Pbz1Vcmr8ii2ppokt69vnvudgLzs+meFgSQDFTPDf8FQ
         dSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730377; x=1762335177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWi24kAJejrPENad76Qq2UdryfCSFDydt8kyu/N4BqY=;
        b=RATQzqATXpfVPDqtXAIYHQ7NAD97hhapTouSKwUKk/ZRag3P7BE9lZXrvAnC9FJqi+
         kIgCn5/wNlDVyY8aWpCh+aFX9BHH5ceSVeAftHzPeoRklceHV4YERAjuWTvHhcBEpW/L
         IcvjfFOiJmJuYLnXgkwUqcrkHL4z67cKKECoqCfCiV9bJp07Jp5rc60XlMpXEkEynAS2
         239bvauvh4umtquBcvkY5XUCU9whgnNQFhu4WvI4wwnR/6Cyu28NkyWCbgDw2D+hu6qo
         /bD2F/a33b4RyuFqafs59hMl0GGGVle8b8ip6edsxIbgRsk8Pg8N9dxvghwEW1PHPF8s
         p0kg==
X-Gm-Message-State: AOJu0Ywh2gaGP/NzVK3FB62mIdYPu0am8KfNf9wyoId/P30QXG2PnMtx
	rKzORKWsnOR7xuFB6E+RfJfU5XVznYGyzWKF2VM22cIjyRaFQDjNNbEPDJ0cVkfpwYhBCsR7B2A
	fFIWTkwh2VM0lAnW/f/3iOg+mAWBlAVybThZS/akx9hXPklAIoxsLqDSurB5PvLcSLoSOrg==
X-Gm-Gg: ASbGncu3xmPZcmx2HThgjUFZ9UtT0cV+gPixdu16mLx27k+Nfun59U88mzhg24CxUQ8
	X9Gy0CDve+g1khPL3x1Fli3JzSahxa4lxl17On8IFx8cPT9dCuD8/p/Ojvr9eLvAtS16a95G88R
	URdaWdXIiubvqBIdrAvaiOcskBjJcbsTzQIXwRn5UmvFbzkWJUlHGHtNC1T7A3CsnTwwa5MmcLm
	xfx6BpKV+SkZcuZa/CMaDEbXR1p9tvKNXQl2HEYXAChreuCuqYRLtcgYPDYx3/fG8ANQ+kW6l4p
	g8gZhHuXDHydC7Fv2DD3lhTDZU1g0s8hpXg4cHWkkc10mFH+Rn7pBgC1mpOLxMhjAIF8/dA5VV4
	TyR2uZg3iNkVV6N/7LyzU1NHtZBMADhUZjBxOvLTB7HPP
X-Received: by 2002:a17:90b:1d46:b0:340:29be:8afe with SMTP id 98e67ed59e1d1-3403a2a211cmr2590094a91.33.1761730376856;
        Wed, 29 Oct 2025 02:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT9rcn3NNg/VsimPAfxmXnqtN4k004t5UmNePulLNNW92ejPqrq14iwU13N8IYS0m1DaSM1w==
X-Received: by 2002:a17:90b:1d46:b0:340:29be:8afe with SMTP id 98e67ed59e1d1-3403a2a211cmr2590067a91.33.1761730376362;
        Wed, 29 Oct 2025 02:32:56 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d27b2sm15042316a91.4.2025.10.29.02.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:32:56 -0700 (PDT)
Message-ID: <1b7ea1a1-b1ce-b50d-c141-d9865b0d0175@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 15:02:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath12k: fix reusing m3 memory
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bCplIwAzZttm3CMIqCIuuBvJ3SwZRK1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MSBTYWx0ZWRfX4exd9aYMVc8L
 Cih1JiXMEsZqr3cMwOLGzQ0l3B9QvXaNqiCVY/MDRTkiqgluaH2Zc0/v72Y6iV5TDEyzFq3/+iS
 Ekr2bRBJURO///sYISIfxbRbNCKPLQ3ztG25N1K0ZQ8Nt5TSYep24eFQ/lBwriiPEBZFxCAWj6o
 pi3wrkyaTr97w6kx6MdtBcPONErfVu5z6H//+K3Kdo/unHIHDok8jDYMmPgMUZm0pihVBMP8szp
 JQEK1O980RjiGMEUsAI4J+rctUqP6Et6ONpc03KNB7t6IZc/PMoVEYQ9JaNhm5vh2Wl/S1d7YXp
 vmAXU/xhXVplFSyU9Nm1FiTlQPT7NWQbyx9Dx065jAjB0B4bjd6XdD6gNjMZcKSxYaa2Qx1Cp9v
 8Qesn41SkpQ2i/EkJPkIHWKZKxXhTg==
X-Proofpoint-ORIG-GUID: bCplIwAzZttm3CMIqCIuuBvJ3SwZRK1D
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901df49 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Y1qFtuX8SmuMirZhVQkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290071



On 10/29/2025 7:37 AM, Baochen Qiang wrote:
> During firmware recovery or suspend/resume, m3 memory could be reused if
> the size of the new m3 binary is equal to or less than that of the
> existing memory. There will be issues for the latter case, since
> m3_mem->size will be updated with a smaller value and this value is
> eventually used in the free path, where the original total size should be
> used instead.
> 
> To fix it, add a new member in m3_mem_region structure to track the original
> memory size and use it in free path.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 05090ae82f44 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

