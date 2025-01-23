Return-Path: <linux-wireless+bounces-17857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F92A1A039
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D87D16C284
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C520C00D;
	Thu, 23 Jan 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhY1TUxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1515AF6
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737622589; cv=none; b=rfugq+wE6fyS0T+GC9ay/k0YuxTVjM2WsEROfexuqWFuVVnXfM9LBQDqe7xaS9tmqOdgHRPlynRS0lx9CMFMfRyUCEwdtpGIwijXFR6xYzSn1yXNLRoFC/3QXTD/agzwNrMBu3V2Zx0dk9nhLmV6vqva8dyxJh4sAs/BbYqfmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737622589; c=relaxed/simple;
	bh=61gKVxP9ysHNqjrjtcvQEy12tYtVQ6KqxMLDHhoU8IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZp5NzJb/Qn5R5DRjECZJ8DYslsR7xe2qrxE4Tr/8zum5SJeBF1eHx3cVk5z3S8Zliiy2B7fF/Y1uiP3c05JaT4AJCpkCs2HiUBRLqA9R+HnzLZwsI9bBdm1GSYuFRzNATzeNbfOQYt/Pbsuh7+y9+gOGrTVYQSBeh0RDcv0UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhY1TUxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N3wf4Q017074
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 08:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jlxbvaCX9NmA6y/u8QnhKeBlS7TBRAu0ZEid7fzMqA8=; b=mhY1TUxIRwnabJt4
	1HFRHdUMJt8KHviYuxLUB9EVOEOHnc77p3J+mDQK96Z/mjC1VNnxU4hVmAyvozCH
	wa63iQTIZ1egAu0o82tjVwpm5ef9uqgon9YNfPzJ0f4snl4qrWNEXxFKwup3nGqS
	GdNX8TTAClF2jhWSPJH4uooqK/s2Fr2+Rwtfc9Om9S0fA2XIMcgXjxkmJf7NDaea
	obY+5dKzbp52SuuejqA6F+24jiPFtvmbTuzQj2njVFW+2AppehKC2oRu4S2jJ7K5
	T6gCr4qdxpJb8A6MffZND5kFTceD4pX+XfQLNweJcZU8qTr7ybfQZfLuJotGjn+P
	vUzUAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bebbgk3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 08:56:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216728b170cso14175615ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 00:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737622586; x=1738227386;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlxbvaCX9NmA6y/u8QnhKeBlS7TBRAu0ZEid7fzMqA8=;
        b=N2r0kmldQx+d2LskgGWqEGT6t9Nt7pb/aM9MZV14wLv5SSmkk68Ut0f3HI8PgGX7r+
         aKQD3q/7CQkMMNmJ1EB12KQd5/WwjEhPNkMICPeiVIQmABcUE/+rMovvLg7sCx0R4NmG
         ZjMotyW+jnROVAG+q82frbIQGIFGHgEYotuqGJCoPMwRdTIHEe34dbHHdheJkM/BbSV6
         p3EDi9GwrY9rpogrwQ8b9lNMmr9w8lI/YztNIOf6oNtVPctJMhZ1r7iJcG6MeaOLJqMB
         JKA0f5qzETTa399FGBPlatFa1naP5lNz+A4njeIF+8rQxYwxHvnJNN4vd1WCzxlUmriA
         6xtg==
X-Forwarded-Encrypted: i=1; AJvYcCXTBsJvKrPpIdYwyr/0QaOX75IPYxuPzZhAkvbpgXbJB2KdayjYodk10fKQxk+GOXprwv8+kEdhInhWL7f9iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/4IEFsMOKA8UQJ1q7UmRoxwHmF4ZxxnoZSyDYoJAKdkZ7l9k
	XjRnCpN4UuccJmkHg/V+q9CwZZqNdaOki1FqBf7JFE6DfUI6XJjqpF+fTihp63qGr+GGxd7Cpo1
	Pv+ta/u8Ub4TdUN3FrAa7LRUATikVu7x6EqZS4ROEum3l8ygJCxOiY8vRpxl1HUuA/Q==
X-Gm-Gg: ASbGncsS03cTjmbPJ7pgIDnYXCOIQtJk2J7e/QRuRhZZ9kL9FmyJGFtPWEPqXiUCXfN
	9GX1WVafdyk8E1VhWtBB1K7auPSWwVBn3HprxD43hRgJuWs1kuSotixTYjhd+MSnV/sVokEU5vH
	MBLUXhGQ6Cso0iboZrxzh+Rq+tBDzxKpSRGQmgCdmj/iL3o/vpRVw1v4ovHxrfKip1K2oNJWR+z
	iG5ikmD7oCPpu4jswAv9sexYyy3YkUZ6fxm1zAdtTNQ24C+WYwDB7iryv9tW/tR6sEvsm5ck9an
	rUzGvL6TQa/RbLp4HTSHh5xvFClp
X-Received: by 2002:a05:6a20:565a:b0:1e1:aa24:2e5c with SMTP id adf61e73a8af0-1eb215eff85mr28108187637.38.1737622585729;
        Thu, 23 Jan 2025 00:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgHy6cXovfwkt5X6/yo7RKkzjIvA2/ze7qFbc41us030sNbtYXYDcDt3yHm/uwGPapYbm5zA==
X-Received: by 2002:a05:6a20:565a:b0:1e1:aa24:2e5c with SMTP id adf61e73a8af0-1eb215eff85mr28108171637.38.1737622585355;
        Thu, 23 Jan 2025 00:56:25 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab814955sm12431470b3a.48.2025.01.23.00.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 00:56:25 -0800 (PST)
Message-ID: <d45aeb9a-7817-49cb-be9a-2526c4eb7838@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 14:26:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix memory leak in ath12k_pci_remove()
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250123080226.1116479-1-quic_miaoqing@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250123080226.1116479-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vRMK1451lGKZSVlrD54kmTHe3gHKlg79
X-Proofpoint-ORIG-GUID: vRMK1451lGKZSVlrD54kmTHe3gHKlg79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=857 clxscore=1015 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230067

On 1/23/25 13:32, Miaoqing Pan wrote:
> Kmemleak reported this error:
> 
>    unreferenced object 0xffff1c165cec3060 (size 32):
>      comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
>      backtrace:
>        [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
>        [<000000001203b155>] kmalloc_trace+0x40/0x88
>        [<0000000028adc9c8>] _request_firmware+0xb8/0x608
>        [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
>        [<000000005011a682>] local_pci_probe+0x48/0xd0
>        [<00000000077cd295>] pci_device_probe+0xb4/0x200
>        [<0000000087184c94>] really_probe+0x150/0x2c0
> 
> The firmware memory was allocated in ath12k_pci_probe(), but not
> freed in ath12k_pci_remove() in case ATH12K_FLAG_QMI_FAIL bit is
> set. So call ath12k_fw_unmap() to free the memory.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.2.0-02280-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Miaoqing Pan<quic_miaoqing@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

