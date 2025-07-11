Return-Path: <linux-wireless+bounces-25260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42618B0185F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36253B45B25
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD431F3B85;
	Fri, 11 Jul 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4jheiAi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3F252292
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226724; cv=none; b=EEwOYEDXuv4k30y1mY055eHytJ7K2+j1QvT8b+1f8Ra/1njrVjnsDNGg+dSRWRAQO0GUBZtq70vfWEhuxJ84Ep+ig9gKftd+EdnE1PZs0hubcJ4El4USMnRlZxGud9iXcNbXO6COplm7X6vW/O7AUE+ogezE3cGa7FfgTAdrfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226724; c=relaxed/simple;
	bh=muMfI4OOLnGlA/O3uFoM0JDLiikIYkooPujm1O815xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6ojPVLSSCp67ziVoU47VRO/jlPF81ZYbx14CcS5GJ0mSGsg7FaxwDbNvAd5iIC5E+8l+xESr8CPBlV14iUemAoN8hpf/aZ/zWPlg65P0Wv2ubnMmXKBxyFdTA0/WjEPUdXwrKmfRgE2titF+/WinHZmVu1vEzCG8/Ji1rHenoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4jheiAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XMtF030881
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGL/SZNkDefnD8rnQdJa++pgq2SPm6cH4YHcPivQI8U=; b=B4jheiAikNANkj5K
	kdYwcGuJnFijefFrmCxBtyoxZtDOTXk+XCvPIHtZk3qyGYiwoPlBX/iM4zGoQRTS
	1AwUwyIr7LKQlteGGmhK/BmUxZFoT5uxRJ3ZOeZIaQCaJcPmvA6W++WlJxPKcYlo
	ni04g1m2RZMPo+7pDDViLxBilHR0TbPAPNh5l8mp6rNdEqA6Q9JMM4V015IExrDl
	1hDgUz4+SAkwRH4u4zTxCJUlMC1qxcxxYbU4G5Nd2238m1GjH8E6lgmyJ6DIIRbp
	TjHIHDWrWyDWG9vvg1MRcOoCgGt1F4YcpSx8oQjdJELvMMeHckJisB4R//m2aqIq
	pgTETQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smber4tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:38:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e7550f7bso18797955ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226721; x=1752831521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGL/SZNkDefnD8rnQdJa++pgq2SPm6cH4YHcPivQI8U=;
        b=adKp/J+fXcV9oe8fnIQeNLXmNh4FZvbYkoqGuiNxEwV7E85iEqSETPzsPpUiP0Sgvc
         b3TWfRbLCaial+EkG5ksXQs+W9sUnBT2fHz7ZVR1WFtfPCBwum7fRl5mUKW9qYTKE1wI
         Jtw1aptIEjs7gNF8Icv2+TFN7M3Ko4r+h+d/Ap7SZ662StYCgk478Ty5WlnQMZROLDq3
         9KEz9oZGsy4aM/A1ri/HzhHdWoYad1vgLIfdlTyciqTXWAwHKGW7OuYEF/jEv26qdpO1
         wxjXwcAX2GKQYeYp048hcT5oKKwxwaJ/uyNLw/A/3KDmYFXxoNUBR5DUmmtRu1PWYjZu
         lZXA==
X-Gm-Message-State: AOJu0YzLRZpVnvdZRq/KiJY2LYvWn9lgQySGn1UGxlKUrLKrHS0aredE
	dO722i+crGbpxuLXp1C1rxYcU0QFVU586XyciENTQXD/CQPTnHBZ+bmIY6rRROaP9p1n5mGFD4P
	Vjul8v8iamznGMinyvBFwYuoMP6QyVhw1YNhzvzLoGKS2XRP6tJUvAFMBs7yPofngs+VxCA==
X-Gm-Gg: ASbGncsLk3yYgbjxXNSSdWOnjaX7zr2JDTUi6vuXm1aOfvk3FiaBSMAr8S+s+Ec/+WZ
	6AJVMBoVsQ/iE0X47FdYGKaSOxwXLWWH3hCPodSy332HQT5FVljY7Ot/bJXoFMi8zNSLR15eilD
	hiMJuh8TUTaWBKknjJJCIP3Mj0pepKHM3nyoymMp6GcbGnAZt0ehNitaYFfI+BvFzXNYUVA0c7s
	i6tEk0E+4qWHjhqCF74qDaPG5w2LaAK2HitnuzVQ415Jfumj2mDQTEPRNrfbbuxtA73VWRqHdVK
	O0aMYx0ZyRxJZaAA8YvdqJBFNu2CUGk8NkE3OAXgIzR4mEzPxbD6xWa+KyaMkTWz/mg2sT/vCCv
	wknpmRocYDfr18w2zJEWLKZFZGOglw/v7
X-Received: by 2002:a17:903:90e:b0:234:d7c5:a0f6 with SMTP id d9443c01a7336-23dede860c0mr32494655ad.31.1752226720666;
        Fri, 11 Jul 2025 02:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL/Jqdo5vlOQiCfiDk4KSGN3BOX4g13P+XxoqP0LXTTfRT6yCGKdy3OfUF0j3Ba8Bvb/D5fg==
X-Received: by 2002:a17:903:90e:b0:234:d7c5:a0f6 with SMTP id d9443c01a7336-23dede860c0mr32494245ad.31.1752226720121;
        Fri, 11 Jul 2025 02:38:40 -0700 (PDT)
Received: from [10.133.33.179] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333e6csm47071625ad.162.2025.07.11.02.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:38:39 -0700 (PDT)
Message-ID: <3cb437c4-d113-48fc-a672-d8f7fbbd11ff@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:38:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix packets received in WBM error
 ring with REO LUT enabled
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, tanguy@squaremind.io
References: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2NyBTYWx0ZWRfX4Kn0HCH5xh64
 3mDqfT+lP8olGFyaQoyGcZBeS1bivJgMrGEVIlmK67MydVTAJhY0ULqDuZOx5vCNg55+xp/f2vh
 76m2rrfbPI1FDDV7Cx6VSAi22c79zdnbJZoRJIFpjd/PyOnPoTogVk4iGfZH2ufNeJccoKLsQ3y
 BCBVtZ+TPc2xItlKM9AF1qUD+cSFEK6fW4WL+7bOwgH+i8M75V+7z0ie0r+eUzoa6bvPjU/JdXh
 Z+mVVJz1wnoocmCINlgaQ7XpySV4DjxYkKNAcYxs7fJKEmyLkXiHsK7ogClcEFbEfryjqI8/DYv
 LrOGfxIXdEPVgk9dKQvjEnmxPs/FEjSxZPNplSCQaPmOfDcGnBkdpdpF7tBxaVohkyCGCaZA3hD
 qPnMtIdKdSwl/XloNvBO5ybvSy1vBJCn5XJfrFk011H0FZmVOz4EGY1Of8j3hyQCvI0lA4Jh
X-Proofpoint-GUID: hAxpdNtoGIMGdddPA5a2jlJnG_to1yFY
X-Proofpoint-ORIG-GUID: hAxpdNtoGIMGdddPA5a2jlJnG_to1yFY
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6870dba1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=p8CdzvKiexFK_hkQNEAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110067



On 7/10/2025 9:17 AM, Nithyanantham Paramasivam wrote:
> Currently, packets are being received into the WBM error ring when
> REO queue lookup is enabled, resulting in degraded RX performance.
> The issue arises because the REO queue LUT TID memory reference is
> set to zero-it's being assigned before the memory is allocated.
> Fix this by assigning the REO queue TID memory reference in the LUT
> immediately after memory allocation to ensure correct packet
> processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Tanguy Serrat <tanguy@squaremind.io>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220282
> Fixes: 3b9cbce6fdd3 ("wifi: ath12k: alloc REO queue per station")
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index ed325aa6322d..65b4c91e4fe5 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1060,7 +1060,6 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
>  	}
>  
>  	rx_tid = &peer->rx_tid[tid];
> -	paddr_aligned = rx_tid->qbuf.paddr_aligned;
>  	/* Update the tid queue if it is already setup */
>  	if (rx_tid->active) {
>  		ret = ath12k_peer_rx_tid_reo_update(ar, peer, rx_tid,
> @@ -1072,6 +1071,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
>  		}
>  
>  		if (!ab->hw_params->reoq_lut_support) {
> +			paddr_aligned = rx_tid->qbuf.paddr_aligned;
>  			ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
>  								     peer_mac,
>  								     paddr_aligned, tid,
> @@ -1098,6 +1098,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
>  		return ret;
>  	}
>  
> +	paddr_aligned = rx_tid->qbuf.paddr_aligned;
>  	if (ab->hw_params->reoq_lut_support) {
>  		/* Update the REO queue LUT at the corresponding peer id
>  		 * and tid with qaddr.
> 
> base-commit: 45bbd91fc41b7cb6319e45e6fd732c5c8a0c44e3

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


