Return-Path: <linux-wireless+bounces-29587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC5CACD9A
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCF5F3010612
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBE2E7F0A;
	Mon,  8 Dec 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSHkygpF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hyaZgRcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2E2E62D9
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189437; cv=none; b=aA/1qHvvvNDr3B7OCG4iQ4EemzVWov//hAxf1aKZJpWMk94la/EnGGCdJU+95m3q20E/JauUT9L6sN+C0dbOeQgRfPmkGPqyTjdF+W17jdLC7GlmkYGIHlBzWVfLJuUllvNEXLyiZaBHS2ble5ASW73n0/mXkbIi2RMvBWsUYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189437; c=relaxed/simple;
	bh=AcilBXejN9DQOtem7ThvlrZz6P66A+EBUAV2IiiMizw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DP31I11maLA4nX9vAZ6aBJXcc9BqakSEksNfZqxuu1fDMlfvsrTjjUMAtRGOGab02l/R/hNGsfxa8cQDlp61gjUfRkp+rXX59arBn744hTOTZfuWwPP89rYfNhSGJZLCj6lQGQGSOcMDROVHKjGJErlNvAnkc5T920HkTFp987A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DSHkygpF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hyaZgRcJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B842uLZ109801
	for <linux-wireless@vger.kernel.org>; Mon, 8 Dec 2025 10:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	27ThYATAAINPTWQaE34A2M4rAVZ9HYZXEadsbnAE/DM=; b=DSHkygpFDkTJ/8gw
	+2YWyWoxmHQjCOYCObL28jJykWlXTL9WFwSLnOj4yzBUqmyYhCUc2ZEN/3obC88n
	RYd50BelXYrmDdudAoXAV7c+ZRNyYRXmYTVWLSOPxUA5utJya+JpGFca1yTDKIIs
	PACuUzSrDXptBKAzScTliuw6oahEBlYdGJrrkuYxAgpmFxvZaRdbDntp9aGTjzot
	jC7x+VVq3TIjikB6pCr3A1tjqNWLFOvPQgGNH8xRmH8tAab+9iLKTdYp7TjDOSDG
	KNp0IKbzVXK7SBMYxE9NBvOGxCYdpcsVR054z4KfdlvR1nB/oJ/ASHSnjimrsa5b
	rLoY6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awqabh2pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 10:23:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7ba92341f38so4330849b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765189434; x=1765794234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27ThYATAAINPTWQaE34A2M4rAVZ9HYZXEadsbnAE/DM=;
        b=hyaZgRcJ7wGIt2LJMEtnfTzj61PT68VIM0zjkinZOU7fGrbpXHZfUdj7iG+gPgFJRp
         eNONA9jy0FBmj+cufAHgxjJr18CSmvft4FPm2kbLgLFBLW94UNIwZAd1jc6UBV+fApyk
         jWg0hQpX12xtSefzHbhFFzApmpxAmctp/OBZ1A8ps/UWNgexxxy6w4/P0OslO9qhH5cN
         pOJlGblQMuhhYgLCn/sYPKx9xF0gbmFy0iVj12Hq8RanwxNVBG8UPqo+Bud3wEqiUXff
         BO2W2i/hu/6znzF2O4NXeyMe5gfmD5b86CurmlM/vONdV/pLMoAJ2P4LBXBQoV49IAyr
         BOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765189434; x=1765794234;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27ThYATAAINPTWQaE34A2M4rAVZ9HYZXEadsbnAE/DM=;
        b=XBJ1eagpX7MZ3tNALm+q7S++zHKXXWPKobMQOamdb2foa7GrzZu1bQ67nLvAGbmk++
         wKYYG3/BH7n1SRRGexXICTTT8cwV+wUePBZGXFsfbEdrcl+zRFvXFgljBKJEafddGpwu
         t1d0L1jtJuIHpYre98a5b87yI6JbW3YaoLzMfhf3UYbgUy1M2mlVp57AxpisDyzI4JYs
         +T5uGjEdtYGdNGfQdYlsLh7aUaWl2hkqisQC6UGB21EhE2PVV/p+rWA22Vflx8/S1x+a
         HrX8iqI/L67OF3qlDGTJe8IFPLzk3hlHBGcQNnGnEKTp5DB7Ffcd3qXiy5gvNFuNFm3K
         t9mQ==
X-Gm-Message-State: AOJu0YyE6MtAEyrXENQvfxZL3Jv/0Dax+58KPthJjpM8N0cRPUss1v3B
	pWDc/B08bD8XzHJ0rptPxIGMD+Bc3KAyqIT/PNPCHm/IfoGhVypatcTyWXr455LaaTAs5Z4zQLJ
	IQRLLZCQxhcPjYZ0a1F7tMQ9y4/5lpY+bdDv5xotjaiGh4mqb8PAC1DZUdi0EStfksnZERg==
X-Gm-Gg: ASbGncsTCPCZzeEEJTwXGAluKmUCQalRkT6LCBs3Y2kHsNAytd/gqavNnKNxduLIeOI
	IigU4uFysUcNtra7bjkiyx6uaMrDH85HP+am7bLIqlm/zf2+o8WN1fs8tqoCdZa41pDwa+qrAwJ
	4BhJmTKuZItBcrGeL1OAYjPtpVVethUKlN2qHRAsWGt5SkE3lRhPqTJAC1u7b887NlwVdksCmkK
	kTvCpH5h4WwN+VNok+s5fKp/eSOtj2or0B2vTraUB6LwVw00NK8hDsFA6tiX8HSfabDse8zvvsp
	uEODechtu55AoqngNJABtwMCZKkZRRC2WlCT8hRK1JXXd/CTQy7QKIX2ASYRMiUF1X0THNsse15
	jMC3rpEHC1ukgcg6LiBgyuYsfE7YNryBbgR/qTbkbm9xoYei5KTUTRIypl2l3OjPX0fZZsJdFcK
	U5GUauioM=
X-Received: by 2002:a05:6a00:2289:b0:7b8:349:1b33 with SMTP id d2e1a72fcca58-7e8bf85ac5emr5847882b3a.5.1765189433949;
        Mon, 08 Dec 2025 02:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMB3G/FedvrSHkS55lezyEum2mqkkBO/SByv08yG9sjg39uKLpRoF9PVtP2wH2vTh0IhNkbw==
X-Received: by 2002:a05:6a00:2289:b0:7b8:349:1b33 with SMTP id d2e1a72fcca58-7e8bf85ac5emr5847865b3a.5.1765189433461;
        Mon, 08 Dec 2025 02:23:53 -0800 (PST)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29ff6b56esm12702511b3a.20.2025.12.08.02.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 02:23:53 -0800 (PST)
Message-ID: <7ef46837-7799-4ede-9f5e-88a010d5d1d4@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 18:23:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: svVisLnKLdh_FRWw6mf65asG9hMxPPOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4NyBTYWx0ZWRfX2+pKYIIlRnL0
 4ikSR2XPg6/hkttGu02vGaAdSNtWqDRoZhPiW/H/hmodalqrOA9/LihQKw5Lor3GIOlvI97XyKN
 fWfFgOuJgZmBXni7oYs+k6h7YxNuTWWLRCmZV5w4aB6AYc20gn0b6p4SgnCb3dtU3UocSNyKhZL
 hgrWDrwROV105ZbCAws+eZtYM1LUcAn1+0kvPUJ9iitR/g7373wUXCLbjHg3FvbCNCPYmfMjCE+
 toB8j0HfFNugnO0r5Cm28WZxmSx3jps8Q4W2Kct33Awvi7QclP9pM6vlcWXBATOfqIYZCfSbgS8
 +rnZj6/FM6Y/O/WXQQSFbr1Oo88Ko0d9CdXW7Srf1VFzCUWaxpms+fADo+pc+kmrP4/BnRtD2Ok
 60coEWiK11wr81m196i33UIP0Nhnyg==
X-Proofpoint-GUID: svVisLnKLdh_FRWw6mf65asG9hMxPPOD
X-Authority-Analysis: v=2.4 cv=f7lFxeyM c=1 sm=1 tr=0 ts=6936a73a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=3EvvSBrUXICK9wu0dFAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080087



On 12/7/2025 1:58 AM, Alexandru Gagniuc wrote:
> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
> assumes that:
>   1. firmware will make a HOST_DDR_REGION_TYPE request, and
>   2. this request is processed before CALDB_MEM_REGION_TYPE
> 
> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
> after the host region.
> 
> However, if the HOST_DDR_REGION_TYPE request is not made, or the
> reserved-memory node is not present, then res.start and res.end are 0,
> and host_ddr_sz remains uninitialized. The physical address should
> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
> 
> resource_size(&res) returns 1 for an empty resource, and thus the if
> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
> 
> Use "if (res.end > res.start)" for the predicate, which correctly
> falls back to ATH11K_QMI_CALDB_ADDRESS.

In addition, does it make sense to do of_reserved_mem_region_to_resource() before the
loop, which may give CALDB_MEM_REGION_TYPE a chance even HOST_DDR_REGION_TYPE request is
not made?

> 
> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"")
> 
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index aea56c38bf8f3..6cc26d1c1e2a4 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>  				return ret;
>  			}
>  
> -			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
> +			if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>  				ath11k_dbg(ab, ATH11K_DBG_QMI,
>  					   "fail to assign memory of sz\n");
>  				return -EINVAL;
> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>  			}
>  
>  			if (ath11k_core_coldboot_cal_support(ab)) {
> -				if (resource_size(&res)) {
> +				if (res.end > res.start) {
>  					ab->qmi.target_mem[idx].paddr =
>  							res.start + host_ddr_sz;
>  					ab->qmi.target_mem[idx].iaddr =


