Return-Path: <linux-wireless+bounces-21586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C89A8AED1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B217FF08
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433071DB34E;
	Wed, 16 Apr 2025 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVDk4SeN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AF19DF98
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744776286; cv=none; b=QV/GB5NF6ZL9+lHs7ZTbADNCGSdk0aTxwE9ndVmTZURvbbQuL5AgftU6AMWeNHw3GnyIeHdxDDSkQFqY6/ymcYAZLdhc1PSvAPGGeCKkf/wlcmDiiiWMJMjCXc2rtth0SmwoRNVKq2kDA8HNgc96e6STgU5CpTblkve+xbcgVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744776286; c=relaxed/simple;
	bh=EQ76YkHn8aRL7y7POlzo5gIvtFOl1FLMZr4rdCf/52w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QblOYpQz8QmkzH4B01pIUkQfISwURc0vqguBJj+JsPxcIUUuvCYeYcKzP7kBkxGvDptgGNT0SigpcrBeUl27u3UFb/prGKfID5rd330t05C0Q3kKdm+Aeb66SPwbYHKGhR67tqa4+Yca8rzSFlpFNgI92WPPDurjgLJxkP5mOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVDk4SeN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIWtvi013131
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	70UL/+TvMgIg/Zg9WALcrQO76O4dSA2hdprkTpMTm9w=; b=YVDk4SeNtVi6hQtM
	+XEpFlaVae//Ke792YS//f2ULn6D3iqeblPcJZJxI5fUJtqqMhtV6gYmhMAgWoKg
	1E3vaix8DIuzOqRpMTzU531kpQ5zObIDgqraYLotBC2FonW1GJSG6w/lRtKXtGTu
	qoBvcZO96zUfpspwombb9f0YOPKcQXBti6TyqpshjQPA5XQH2K3EDiy29RAkphdT
	UMf1StboNF8neyF2Vl2xZQ+BZBGtuipokBoQdMX/kJiiCs78QkFnjLzfS3d+8Bli
	/4KqFc+pGe73IL3TitlnwtBjvgE1Y6lPZaRONi0WqBf2wqmmHZYIW8t0hS6yukpT
	BNOUoA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6j9c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2262051205aso43744155ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 21:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744776283; x=1745381083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70UL/+TvMgIg/Zg9WALcrQO76O4dSA2hdprkTpMTm9w=;
        b=CPlA5lqwGxKa7rcf12Thk79VcRa5LC0eIuGOzVKQqw0stOdsN6oqm/VGGcrkUjAMjs
         5KSBA1QZjyB0PQz7WCIDanlKxCkWrcHzUB7HQL3mOyqxZIPMhR68sjXFe/NMJihqY6RT
         x2KwGJ2UO0ayefw78k+kcc2xDtEn5DW0bcMMzajSS44V2JRfhSBI0zcp/eVgtP6dtyvp
         cjMgn7Enx6KTH2QsUXQGQLBql4HGee5aHxan5rpZ/BFzdgWisL6+F4iCpc4d/AjQBUli
         RpGWBDqu5RCwvWFIcc7Yv+44VfHrK09U6koeiJpPxk8ZmL16D7BThDQUi4DvEQo3C7FA
         AQvQ==
X-Gm-Message-State: AOJu0YzV3Nt1Gxz6fUz5TlC58TXAe175/ieRcKDkk8N6PoVHaHZBkJJZ
	h1b9McBemDmdcn7L5zRV/R8CAJkFnytXNlcZ4FX+sEIO6ei/1y8QaPMIzOvKslpRo65lJ5Tu08G
	jH6aDJVH6TJiFInLDsmfkRMLNdwCFb4zCiP9RR6HjFLqB2X8L83Wx7bL91j4dF1QX0xK+rg4VXg
	==
X-Gm-Gg: ASbGnctfmGVbIPHnmLdfPStJ4QpnJnaoCbV7jZFJX4S4HeWWN+n1ORuuy7fYca35ysy
	ciGw6x/Ajf8+IEOUoPvXiEdE3m4TLasuJgAO2tIguuYphx1bAxwVhS9YcYxY7XtHJj3AyYYEoPJ
	NzYtHdSb67Irh/zesORfpwqZjz2pj8S1WwBHuftvYU6e6FbNAEpaAjjirRSWRCEaSAhCgpDh/cZ
	L3LwKCUbeH8F9xHmj1F37/mV42sazciTGT/WALBuIfFg8EX1PLJDDIZpsUKeVx15PNV39LAvA1L
	RpwYbRsRvy3k7vHZz2TxfKHYort2+3dTwL8mSYF/JQoxj90ysENhUA==
X-Received: by 2002:a17:903:1a44:b0:223:5e76:637a with SMTP id d9443c01a7336-22c35909c6amr5324935ad.23.1744776282658;
        Tue, 15 Apr 2025 21:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoEBj1D4kIegDEZ6lgS23aKyLsMg4L8z7Pg7/7ytFTcfMeWqeteiRCTgt0vwpmqzWiR0XfEA==
X-Received: by 2002:a17:903:1a44:b0:223:5e76:637a with SMTP id d9443c01a7336-22c35909c6amr5324685ad.23.1744776282260;
        Tue, 15 Apr 2025 21:04:42 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc4c8csm3685915ad.166.2025.04.15.21.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 21:04:41 -0700 (PDT)
Message-ID: <d21bc6fd-9e16-4d36-e8cd-3bb0f43edcce@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 09:34:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/3] wifi: ath12k: Fix frequency range in driver
Content-Language: en-US
To: Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-3-quic_rajson@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408042128.720263-3-quic_rajson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fftu4U3cO3NcrK3E75R0MCSkgWEda2jy
X-Proofpoint-GUID: fftu4U3cO3NcrK3E75R0MCSkgWEda2jy
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67ff2c5b cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hbFnv7ZSs8Y9jydCB-MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160031



On 4/8/2025 9:51 AM, Rajat Soni wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> During the initial WMI exchange, the firmware updates the
> hardware-supported start and end frequencies in the
> ath12k_wmi_hal_reg_capabilities_ext_arg structure. These frequencies,
> being hardware-supported, may not always align with the current
> regulatory operating frequencies. When operating as multiple grouped
> hardwares under a single wiphy, the driver advertises these values
> directly to the upper layer in the per-radio frequency range,
> which can be misleading.
> 
> Sample output snippet from iw phyX info command -
> 
> [..]
> Supported wiphy radios:
>            * Idx 0:
>                    Frequency Range: 2312 MHz - 2732 MHz
> 		 [..]
> 
>            * Idx 1:
>                    Frequency Range: 5150 MHz - 5330 MHz
> 		 [..]
> [..]
> 
> The frequency range displayed above is incorrect because the driver
> directly advertises the hardware-supported values to the upper layer.
> 
> The driver is aware of the current operating regulatory rules, and
> hence it can use this information to determine the final operating
> start and end frequencies.
> 
> To resolve this issue, add support to store the start and end
> frequencies received during the regulatory update event.
> Then, intersect these with the hardware-supported start and
> end frequencies, and finally, advertise the intersected values to the
> upper layer.
> 
> Sample output snippet from iw phyX info command after the fix -
> 
> [..]
> Supported wiphy radios:
>            * Idx 0:
>                    Frequency Range: 2402 MHz - 2472 MHz
> 		 [..]
> 
>            * Idx 1:
>                    Frequency Range: 5170 MHz - 5330 MHz
> 		 [..]
> [..]
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

