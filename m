Return-Path: <linux-wireless+bounces-17858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C79A1A0A7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 10:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC3B3A9255
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91C620C49F;
	Thu, 23 Jan 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4yF4hHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFC20CCDC
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623581; cv=none; b=HRcL9w83Rr1HqXMq3XZ3GdL5KDfvLrZ+PfnryIow51OWsG1JhgSBonqGa6qj0jUqgQDvXyfGBLfZZedgoPiQ3iKy75Bp+cyULQus/uO8sMw0DD6etnl6KuvrOzs007cxHG5vGqygo4ggKw6neLoWZWMVqFaA+XlQSE0r+5RdCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623581; c=relaxed/simple;
	bh=gkUtAHwmzGPvy6VdImod2FeyUJpKGmqZ1LuEQJAu+TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnF/pTWKGNbYdR8f7w6f/x78ecp6INOzcdznOxdiGL8goJ1hf5IWXzYHUzHsY/oU9jBqfPrCXKh3x1tkXmzsdIXs/IAScjK84qwY6r1UDcOLSpH4197HdIra1GpTnOPVoiIdLtAY+ECxva3cQcOesvuGB1vqHFT29LGy7a4c/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4yF4hHG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N4UUic006046
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8a4tOQ3adXhs+ywDF4eT+OTWG23DfBFoG6sF5Oz3mNk=; b=H4yF4hHGS5XGAaHa
	eXbaqTmu1UoifyfrZMDHgcHun72I0pMM7DTY8fIcFasuzOyP/ZPOjZyr75SxhZLE
	QlwDcf0/UJwoIGVIIn2SfY6PWp43qygvj5daTG184OKWgpEYO0VfEArDL6YkTlh5
	CgS9dx9sVc3fs0JzGl5KS8K3mNDZ2tBPOa6mgyzx6BXT8oYd92ss63KSHexpqrAS
	xfWdii5hFPoEVAB51Jj2LxVeFmg8T6B/eGKLkIHN1QfrGxyluqEMmU/gC1K2Ujxw
	kuUBUA0vcbWQ00G3eJ48mZHl2D+UrDNU4U8SCNRFsuHLujmK+g38pxZZWXhZz5gW
	rmBavQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bet8rkbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:12:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2162259a5dcso22585625ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 01:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737623578; x=1738228378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a4tOQ3adXhs+ywDF4eT+OTWG23DfBFoG6sF5Oz3mNk=;
        b=NzmQc+pwLHah6YrV910QC7WGQ7mVwm9YqwpYKT8RXAcyWi36cc/ejbjAe0nPN4AkL8
         DEc1QrNPIYrgjxmwOfGah6G36oPGUsaRCIslNkAyg8OZaU7YaWrXVds54uPPp+/cHL8i
         aB4k8MtH35DfZVIvUvMi9Ec6WIor/ATtWDMGhVkvuy6UY/4oewOiGjJYdYonKgo9O2LF
         9JNNkFBXi1WGc+lrP12Xd9QgiErts7OeUrrn4gAzrPD9iV5r7HPssyQMOSqIalCAVSRN
         D8lQIzL16wPzXk6MQcNXo2mN86XPchdk11/NR/DwphhAgRJdAix3f+zMgCF+4Y7xjVLt
         NmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3AQScADv6K5cZjY8xiCTkBy0XKk3ly7igGyeMCzoEA3JsaJvmLiLqS/VqRpJ/RHhGfLs/hBJy0+jSWsQTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbyyp7CUQOZ5ySk9EuP9WyBgN/BocpSYPtM9cIdkC0W14AFOA
	vaGGlHywVDNcMdILTHSEJwqYpj46c+jf6WhfOsbTjWxSnCtM0LVoyiNPi09kT2qhWlYLMG9+zsK
	c5NKtKW75mXMP6j/ODJKjlBcXE55rxHgdk28gbBzPHPGvo3VkkFAb5q/tRDtxl1TU+A==
X-Gm-Gg: ASbGncs+MCNdU2CysTVlWki+OggIh5+RcGzSd55YmmdtCGundvCkMDv4GgjrZVen/77
	rlpeWll1m5PN31uIACnEiBaUI2IVXEaEV1oJ2zkyWfNV84ms9EZFk7BQwG0uLHGmtbKFXQZgRcH
	s2h/NKSmq74ZXkaB0/+v1mOSSC6aLlmc/Ap5e795MT4Fw57+vNnaryWQZBW269RAMsFxMmIPXjP
	80aTEluISUQ/57bKHINtiLhWVx1n3piePh1pvhDMUCWDZDk2Lw5CbhKl0JGaVx2T/u1aa+zAsv0
	IqESwck8pTUIGjw+MzlUhRHFnOl6
X-Received: by 2002:a05:6a20:6a07:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1eb2144d77emr42096863637.3.1737623578441;
        Thu, 23 Jan 2025 01:12:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE2hs/awa9LugQFA7OEJciPPr5uR5wwYgai2qpVEyLiso45KDH5OanzCXu5yBVvj7dW7Jj2Q==
X-Received: by 2002:a05:6a20:6a07:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1eb2144d77emr42096837637.3.1737623578055;
        Thu, 23 Jan 2025 01:12:58 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ab13c2769b6sm6198546a12.31.2025.01.23.01.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 01:12:57 -0800 (PST)
Message-ID: <305ea8dc-7754-4ad1-8b34-151efbe38bda@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 14:42:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leak in ath11k_xxx_remove()
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250123084948.1124357-1-quic_miaoqing@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250123084948.1124357-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cbIw3ackzttbtErFmwTOE7GVzQnLJ3Dx
X-Proofpoint-ORIG-GUID: cbIw3ackzttbtErFmwTOE7GVzQnLJ3Dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=697 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230069

On 1/23/25 14:19, Miaoqing Pan wrote:
> The firmware memory was allocated in ath11k_pci_probe() or
> ath11k_ahb_probe(), but not freed in ath11k_xxx_remove() in case
> ATH11K_FLAG_QMI_FAIL bit is set. So call ath11k_fw_destroy() to
> free the memory.
> 
> Found while fixing the same problem in ath12k:
> https://lore.kernel.org/linux-wireless/20240314012746.2729101-1- 
> quic_miaoqing@quicinc.com
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan<quic_miaoqing@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

