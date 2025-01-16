Return-Path: <linux-wireless+bounces-17614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC4A1447A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2238B166FB2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B81DC99E;
	Thu, 16 Jan 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+UQR/Ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346D13B58C
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737066476; cv=none; b=XGploIle3d9p0m1s6HIJqMG8r3kCA1V3atWWIS3Tk/oRHgwbxc/5voKBbeV+k0Wx/ljBiW3RHGjtqGCzc94L16rDCyXZ/MEroNcUpusbqxIMZ5fpGCr4RJIos2QSrnlhMLqUa/oH2Mpia8uSnWEjrVfgLm+S0+OiuuP0XhHOzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737066476; c=relaxed/simple;
	bh=5zcxxsbGodjIgxBiKhYmJqL8mSzCaddFIHOcg+0fGQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fa+FIMXuJs0UwwK+wCDJZflpPFZ7mLU3VLAuBftraSgT+SpzSjlATQQvFBOZIId5eHZE5nrHXhHgVFByLqFmDUnqzU++p2C/qvD0M0cXvZBOjyA6Si5YivN4vzWhg4n4X+vgnORiHdPRLGM+bwPbsptsBYL8+bqJ/iYFOTXu/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+UQR/Ki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEK1bG005681
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 22:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xGo09KYMPPRjhK/enIKlUz92CamNwS6kKxyZAl5uzYM=; b=j+UQR/Kie+JoF5c8
	+Kxw1ymnbr0QaD3woeaYUqV7/PQQ5E+0BbB+dwv2DZ7D9mcYaRcP+ZUxHoBCuFuO
	Q+KZZiC4DUfrG1clDhZAODXzXtg0Hd7HIe1Loan8KiLMcSGywA5+OCqjBg5Vekn2
	2hk0NjymYBBTr73jwmUCpB7bT8r8XLftWQILWYbTjxlbSExPs5e3g26AsBZDu4jb
	+mcqbvSuskzyT+3qoIo2j6XsRbahp1OZl9yueT4YCWJKd2VisZ9asXuXCP/W2LIN
	zAFXFYMGmOKkEzAum974oAeJ6BunYJSFgTAnScg7xCbhPx6sOKICY+vm7EYRdxJA
	cuMCjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4473sfs3de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 22:27:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2161d185f04so19496095ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 14:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737066466; x=1737671266;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGo09KYMPPRjhK/enIKlUz92CamNwS6kKxyZAl5uzYM=;
        b=wK+Lsnkh58MXFLi8PubEdaifp9PoglqoMgWpj5wJoMYrx7/aAC8RhSuOTDC+AJKwAG
         R+gbQvvx/UTl5V0E2kmkcjZrCnjgZp5e5ph8vY8eV1cDuV1E/RnihMgV1VD8XcUhtKvn
         kx5W63SIHWG5guLDRB+Av3PXGWuo3SCLmqFM1ZKx7R9z93ebax6KUkoHsewtvOU9S5lJ
         Vq2/J0wMasEd0WzIPPZbd87YN9sdB+aGTtu8uW+ed4exQdh6OdWkVqaHAwL8jduWfrfq
         oAPp5QX8CMp450yVSgxg/kIjZjl5bXbTZ1QMQYmN14u9JqHNgsLjz+FTzP7k22QhCZCo
         hSug==
X-Forwarded-Encrypted: i=1; AJvYcCVpuZ/0/bf5ZHvaWmllYErkmAAqnfAAoG5OpboYhviIgSMYbVAYYi9nlyu1hRYv9k3qHOIW8KLQ4yFmaALU2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrONWxqRyyV/4s9cxpixYeb+3MQEfnP1uGok6B+nJXt7PTfsje
	29geXUCSNmNHKgMJKUbGN+UNPE7Ec8W/ebstSM/Hf0uhnQ2ZK4wewh1rTE4iTbIp7/F6QbLeNdb
	0m9VKL2Inzn1KVXjSLQ+baRnenNBIk3HsIYYQJy+GVL6qbRCgSYHTwA1nqnE8fEiNbw==
X-Gm-Gg: ASbGnctFjHjzUcMvtMQsbf/xP6LNAjsCMV9u4tSBrVRB8iRE7fBX6J/gs/3sp/GHByn
	rInPOnch92fp2prrQfMf9uDOFWz8gNP2g/bc0sAyTEZZrxKaD5zf5gQJTQjBo5OzvMTQOcE7WxH
	IYsQ6eL3g9nLgVmEudnL49na8rgpWgBI1uZG5+capJFjzYKy3TG5tefY27DdwcJCbySTIcjU5Vr
	WYhqvzELUAFyPPFfH+92/OBYFhpauMCoFH9sS/N54PXwq+sDp17B8gLgcDwBn62z6EB7V7cQhpa
	O4R7FMDwl9rSGEz7H8+kANdjHFBgG+NKhsSFNSJ29mxpF/KCCg==
X-Received: by 2002:a17:902:fc8d:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-21c3540760emr6242395ad.17.1737066466306;
        Thu, 16 Jan 2025 14:27:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjVO/7b6/6ONrEtNjdMhKAKPGO1CAW6tywGRPInrnTp4C0qD2j8SMA6nlZIdeYiNEt27am2w==
X-Received: by 2002:a17:902:fc8d:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-21c3540760emr6242215ad.17.1737066465935;
        Thu, 16 Jan 2025 14:27:45 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bce3a7bbesm542587a12.42.2025.01.16.14.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 14:27:45 -0800 (PST)
Message-ID: <31a449c1-260b-4b70-9498-c5015e74c972@oss.qualcomm.com>
Date: Thu, 16 Jan 2025 14:27:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix memory leak in ath12k_pci_remove()
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, kvalo@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20240314012746.2729101-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20240314012746.2729101-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RQUFDdTHh2eVcTqYyqiyZpYSClppzApY
X-Proofpoint-ORIG-GUID: RQUFDdTHh2eVcTqYyqiyZpYSClppzApY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160166

On 3/13/2024 6:27 PM, Miaoqing Pan wrote:
> Kmemleak reported this error:
> 
>   unreferenced object 0xffff1c165cec3060 (size 32):
>     comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
>     backtrace:
>       [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
>       [<000000001203b155>] kmalloc_trace+0x40/0x88
>       [<0000000028adc9c8>] _request_firmware+0xb8/0x608
>       [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
>       [<000000005011a682>] local_pci_probe+0x48/0xd0
>       [<00000000077cd295>] pci_device_probe+0xb4/0x200
>       [<0000000087184c94>] really_probe+0x150/0x2c0
> 
> The firmware memory was allocated in ath12k_pci_probe(), but not
> freed in ath12k_pci_remove() in case ATH12K_FLAG_QMI_FAIL bit is
> set. So call ath12k_fw_unmap() to free the memory.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.2.0-02280-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 14954bc05144..f4b48f96a223 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1505,6 +1505,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>  	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
>  		ath12k_pci_power_down(ab);
>  		ath12k_qmi_deinit_service(ab);
> +		ath12k_fw_unmap(ab);
>  		goto qmi_fail;
>  	}
>  

This patch was previously deferred, and now no longer applies to ath/main.
If the fix is still valid, please post a new version of the patch.

/jeff

