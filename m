Return-Path: <linux-wireless+bounces-18240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76274A2392F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 06:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC781689A4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0845E571;
	Fri, 31 Jan 2025 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUbvgAa+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31DBA4B
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738299878; cv=none; b=TAkYnoT3MXalygcXI36+eKVKUR9XsHMw4RKTfeF6+TcAuDZ8y2Tq61y8OKt0BWEkr6bVDymzJ39mbB3CTPZUwtHXUnkzHrGhlRz1qt5gUhfM9auoaWPPo8yJD02CIfmVCjVk1Za/2EHSQXcGsS0HuE52806nHfqTvzsS2C+eszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738299878; c=relaxed/simple;
	bh=eDR91AmMY4Qz64GW7ZhGfTFUsP5WtS/+A6snX0ZXSEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWIOapT3VzTs3LYepL5gas3hjLwNIjeBGu9ICeJbnoPp2pYXsKTOAZMLPNHbMVFyuNXeVZ9kL2SnG6qeg2lUittOC5ZEFmaJdrS+aN/veXmsprpcdPOqsmgcuSa9dOUAspAVu+WsuicFJ0zgUvgWVTDGd8zvOBQJ0/lRORoSdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUbvgAa+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1iqQ029660
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/HJkB5AGnuoeEnlXxBXugyhlxoAoYetvkAD3YxOU7vc=; b=KUbvgAa++R5uV7bH
	Zj/qLn+o3CzSMZFpwbVgEiMsh6UGPDI+3qmZGHUEGV9QqHpVabRo04ALH7hNbbDm
	NMrg0S7MRey3KYIDRgvUw7gPWm44W9KUOM0OtpI0pQgXPcG741N99n/KihvraiKW
	79IT0Ml6rq+4RvOpldDB11hCSc5nWbjKdy23plxVvhRHceX90aK/5WLoOW1/rN0x
	T7JWCD1clmoRhUfsQxOCNnAbTt7XQeAVu9NrhPzwaLFu+OFoTT5rMPkOnvXnXkUH
	22x/3fm7NZBluPUvJUZA77yVlIvEDjJxthcJxgAdA288SBulnKD5cR3iLyLlzeHX
	81Rvhw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7jrydk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:04:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso3133682a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 21:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738299874; x=1738904674;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HJkB5AGnuoeEnlXxBXugyhlxoAoYetvkAD3YxOU7vc=;
        b=vgD7dv4xq5CiFrg8Ekz4D1nKofG55ElbMrfTLwYQYGOKcmOLSEhU1bCvRBBhbWEeGe
         S2MjIQrwzN650SmNReX22Cgp4HU2pIwrOgTPL3NXFFRdHyMwAUKogAeSYxj/EFCEd+P8
         aQgnq5roAgEHqc1CGnj5yHJc+Z5rgeW+Ptinv4P+4TYEf7rjiZ6VG52HOmKePVxHmo+Z
         BrN+px9t8fV4QhoGnsKdWvc6HruRNjAVMxwLZYUVeyMS9MYYRH3FeXysd0rq+LjxUkPg
         Mu8JnTfSxYZRT/0ONEol8tBCLqU85mHO1XEKBdiKxQkVPmuHw17Z3Uz4aZBOmi6tVmaK
         nFlw==
X-Gm-Message-State: AOJu0YwwWAGOhlmbTfY/lnFC73PBHGc3CpHgam3nxJasqwm8arfbrh2D
	owYoB7/aLJ848w8GBhV+qMl4uo9PkfxVIsPNXAzcaWsALSInBcNI3RF0mQqhZGkxupfz+QxOuDS
	X+l4P2lR/3GD5REg2K2OnYyZF++PfCpmYCGgPafDfCFy2kIXhwvvFjTC+Baf+2q8InXd1QA/t5A
	==
X-Gm-Gg: ASbGnctj7eKtZc5NN4y7iBXwLkDP/5Ks35/99GJQ/zo+lJ2VIGk0/nC8iUg1+4UJpkO
	zyZNFBK2zrKu+1b6jqqyJVbVIeR3GYkur94R7HPfDJPsn19o138lCTZgtPF0Jso2Ts9fuNmX8Zm
	dTsbbXfkLT4j5K1t58lbI2+AQkFvnL8knkIiTlB2PI+O5IeFeGymuaVzhOf/DnSliFmM9eBgayo
	g1uXSiHI+65ZIv53JXetyFJDkUWmO/XoqJlGU3O75mJu+xtCTu1SCHoADkdGo5YDQ9qr+BzgOIQ
	PsnofN8FJgLJZnhWjjJpOzINE+uVQcWRW5zavZM=
X-Received: by 2002:a05:6a00:391f:b0:72a:ae66:3040 with SMTP id d2e1a72fcca58-72fd0bc27b8mr12468110b3a.4.1738299873870;
        Thu, 30 Jan 2025 21:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD41LTCK1sMaAtnuRuMOdvs44r0TZQmWtOpus1osQnLWHZDANi7Xdi41HfIdv5TS85nMsDqw==
X-Received: by 2002:a05:6a00:391f:b0:72a:ae66:3040 with SMTP id d2e1a72fcca58-72fd0bc27b8mr12468076b3a.4.1738299873356;
        Thu, 30 Jan 2025 21:04:33 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bea6sm2345645b3a.22.2025.01.30.21.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 21:04:33 -0800 (PST)
Message-ID: <8c47e4a6-973b-43ae-96c7-5f92ca06797f@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 10:34:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: Dump PDEV transmit rate HTT stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
 <20250113071758.19589-2-quic_lingbok@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250113071758.19589-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tUUTb-revijQ8KgZ7ufEcAhtA5l8eFcF
X-Proofpoint-GUID: tUUTb-revijQ8KgZ7ufEcAhtA5l8eFcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_01,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=901
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310033

On 1/13/25 12:47, Lingbo Kong wrote:
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index 4b59976fbc35..4a40b3b7bccb 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -129,6 +129,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>   	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR		= 5,
>   	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM		= 6,
>   	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO		= 8,
> +	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE	= 9,
>   	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO	= 12,
>   	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
>   	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
> @@ -173,6 +174,7 @@ enum ath12k_dbg_htt_tlv_tag {
>   	HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG		= 25,
>   	HTT_STATS_SFM_CMN_TAG				= 26,
>   	HTT_STATS_SRING_STATS_TAG			= 27,
> +	HTT_STATS_TX_PDEV_RATE_STATS_TAG	= 34,
>   	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
>   	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
>   	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,

Your version log says you have aligned to match '='. But in above two 
additions, I see it is still not aligned. Is it just me?

Anyways, those are simple tab alignment, and if Jeff is okay to fix in 
pending then I'm fine.


Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya


