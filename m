Return-Path: <linux-wireless+bounces-21611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD8A9124C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A9A3B5810
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC41D89E4;
	Thu, 17 Apr 2025 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IvMX+PMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCE1C3F30
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865002; cv=none; b=IFEkYoHXMl87X5MeEYzv51+sUtWmgk4U7adaHADUd0CGYmdN/yv1DVdcnEsDLGxwxpRsbl71Iv84dxuNJ3NrlQaw4njTiG6lqVw84qv6EMgfMj4lCBhcJgKdTvlfOXZPg0GopCMwkdI7Qz2CpG2KAuTBgV1i33vCTCut6H7HHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865002; c=relaxed/simple;
	bh=KLF/UifRraZCMrlsQRPUUyJgLDqhzWPqyL06NnGXmhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFiONeRbIaDDOfPVjkkPO585+yLxNiSjXJzy8kuvYfl9xAcbETNxyuqbJ5tmh3LmMAVfQpgJ/IdU+Q9bdx1Vmo0L2auC4W9xj/KCKs7xBCX8t3ahqmiFmopWHy7kUsrfR9cxRRKLrOJX5egblOhmwVBjKZLnfFN4lXOKTQhxiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IvMX+PMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMdsWj000401
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fCpJDEnYU6sGpBaesuuZWJ6MbHU0YyqaOAWM+ZszPNA=; b=IvMX+PMoNxjTTjp7
	HATSb6oMbHeAjH5oOYlj1LPYIag8DB0nBp9rBWuUDTp0elAJFjhK+OZ7I41ybjRT
	gKtuyJP8f4448RJmyWd6U+Fj8LVpW6QS+1gzlBtBuxm+erW/R0w26OhnD1OODa4K
	uPrPZ/bEIhrbK0c2Xbzemm3oeMJ65Nsab5Kb+YeC7l/QDcLm0WLj2Jiage8J0WFO
	0NyjhFrVMDHSIPlCjzEHovOhNuQz9PIosjbtPrtuAEasyC1C5/NsYfZ2OfwUYkhK
	WZ0A3oZWg54wMScld/4XpHEEsSFCKq6KA+rvKsW6CxLlECidif/iD/E7Cr2rKUS2
	NH7mVw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vns4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:43:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a96112fso6499695ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744864999; x=1745469799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCpJDEnYU6sGpBaesuuZWJ6MbHU0YyqaOAWM+ZszPNA=;
        b=Obzed1h42C/Q4GUXk+5ADBSOB8o2DiUxIZBQzdOw8LkzDebR94iEwkaqRxgCZne6Ig
         1GKHR3er/alQTyOIEwkMmgwPRpNmKS6azie1JQUbyyLGWvaxbtGvehoYaPsTwLUgpJ2W
         ZuHE15ZthLDMnjuoS+w8WPBo9rXYodWmxZ9nWN1bXq99NAA2FA9kMv6Q+ub3Wzs6H3RA
         9kbdQSPd4XOrFr6ZPboUtnOiUmvha2MZwzMgbeNc61b3BK0yl4+/1o0ox0OumYkowIvG
         Wt0g8VKhKaZdg81cRly94CqA1tEflTTO1BJOsMsNAqA622swytowO1N0BHGtSQAuN9IF
         C4KQ==
X-Gm-Message-State: AOJu0Yy80awdzKuvKl2IJ8EVTEyPj2piVFKZ14gzRE9cxOic875us5Ar
	TNbd7T82lCaOPR0S+p/NFemW6H8di5h5TTR2ES2u3G7VUkkJ8bS6j8w9wEAuGpEmTVuIDF4VO4Z
	150I/yy1e/azJ/TihbzkT1V+309RAohXzUiggpAccr3mlKN0tpPB34cAn0d6ypMXIsA==
X-Gm-Gg: ASbGncs7osPR+oRMIIs3dQ1MCo7KYf5/SIzuiQHg2eJoM9J4fBnv30zaWy7oV/qeBQ6
	JR7a7M++QO5D+pDTh73Js/ZUruoIXI3NqgbgIh9DNQA03K4sFa4qevxm4UJcIE3Y59dgty3lF63
	wkJFYTLIBCVqJw7SlEmkuWtJzFuqO8wEECDCQtk2c+pZgvLhk3xhiZwJ0VW0OjmE5n10NWNfwep
	wNH92h6kF+tqbesmLsUzsLZlNLk3V7htxkiv54iFzG2htoN4LGYLAUeK2wbDdHQawxIw1ucjoqT
	pnhbbvK9J1EJQf6T3aYRchW0ZwD2U7IJ7ICm1sO2QinWqye5OsrTvQ==
X-Received: by 2002:a17:903:1aaf:b0:224:1781:a947 with SMTP id d9443c01a7336-22c358de2cdmr73234095ad.21.1744864998727;
        Wed, 16 Apr 2025 21:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErlshvBjFj0x5OLjuHcdiuSjlSiKknrO2d3yqj1ktoI0dScojOvPI2IeEpuD9mvPI+1SvmWg==
X-Received: by 2002:a17:903:1aaf:b0:224:1781:a947 with SMTP id d9443c01a7336-22c358de2cdmr73233835ad.21.1744864998336;
        Wed, 16 Apr 2025 21:43:18 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1ee39sm23789765ad.104.2025.04.16.21.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:43:18 -0700 (PDT)
Message-ID: <2ead024e-464c-2399-28b0-d40b8d32e21f@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:13:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Avoid allocating rx_stats when
 ext_rx_stats is disabled
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250409052647.81955-1-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250409052647.81955-1-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fKoggKe8DNVQ3OG4lf_z8IiUG0wweMmu
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=680086e7 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=6UfVyIx_0tLuMFyWIHAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: fKoggKe8DNVQ3OG4lf_z8IiUG0wweMmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=695 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170034



On 4/9/2025 10:56 AM, P Praneesh wrote:
> Currently, driver allocates the struct ath12k_rx_peer_stats for each
> station regardless of whether ext_rx_stats is enabled. This structure
> is populated by the monitor destination ring for both single-user and
> multi-user scenarios when ext_rx_stats is enabled. However, when
> ext_rx_stats is disabled, this allocation is unnecessary and results in
> additional memory consumption.
> 
> To address this issue, allocate the struct ath12k_rx_peer_stats only when
> ext_rx_stats is enabled through debugfs. This change prevents unnecessary
> memory allocation. Additionally, ensure that the station dump RSSI is
> updated irrespective of the ext_rx_stats enablement.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

