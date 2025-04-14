Return-Path: <linux-wireless+bounces-21497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01DAA87AED
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C53E3B2B7C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB99264FAE;
	Mon, 14 Apr 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOaKgudE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241E25A626
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620428; cv=none; b=N0SDnjxG5lsh9+KZQ6bfNgfY7xTH9EANAdmX3qqF5PPeIx9gvEhTUqCXYcukcHfS3yBz8YwMnYG9WoeiDSG8rgZOrMn+0/oWUAtvP9HFbrNNONqfx7UmMbOpM6pMC4OBce4BU5sRACAFNJFGpNWlY8Quraz4zv3Lky2n3EKjV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620428; c=relaxed/simple;
	bh=k7r7JNcOppFMNPYec5Y3bqDunEGbtzHE6Eez3cmSTNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcV2LKERJSd7el2HyYRP8zdsgDvDM6n5nbHmTGX1chlZ6aZRNe4Tvm39SI3LZp5ZNQ2DJD/LF+xUdTOccacnnVIxKfyA+7lXp7395xkRIrsUwFIsXlCfVB5iHTF/i27s35FKEa1dOpkMTKmNNMld+w2gODH/kFp/Wi19/ZAR1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOaKgudE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNpijn030194
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 08:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xj8e5oei6JOdb0HPupXEAc6CgdAdGfN72foVRMbbbuQ=; b=DOaKgudEC2b8pseR
	Bu6VyKBn5oSnFnaTg/d8G38T2N20dq24Uy15QQfZXGWrgnQwvULpA9UMSKfJ56mi
	VxYLs987SbeJub/DTLqDd3z8xp7HLaKKMpQx0p8/9NTDA6SDrWLuYhzjtiyg/X1t
	wMCU6tC7zDCvDxWDfG8UIlDai/1+GUgy6w8DkrHjquanQxedtUdUTgGZGGXB6gGF
	FhXazsyrjcbD1/3jLur266GJ1KudFYXImXDz9HUPh3sIF24nE9AAlEngKz1EoqGN
	e5qxgkgY7xcocU7IHWpSlaFCYM+2cCkFjU9KiEXUbQn8piwiVAQOWtcYiaG1dNbr
	VRVfsg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpks19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 08:47:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22410b910b0so28378295ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 01:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744620425; x=1745225225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj8e5oei6JOdb0HPupXEAc6CgdAdGfN72foVRMbbbuQ=;
        b=q36JBfqWISCgnnwZ+4uE4A+Un9jp+7UnSOrvwrr6lQzqJ1/p8+3SxT9eUfxCrRlrh1
         GsgTx6aSxNquijE42ph0TppKHfGFdhvxQT6BgTKiDMEm4f/IA+LUiBf17dO6xheWxsGM
         YcljQpn3hLzeIb6cu72FpDNBkuJc3Vzvy6nPtV4YTEvoVZgrwUZeXg3AAetadVVGLIGt
         xZfrhfnPx5QYlgA1FHRgWqMap+d6urYQeaDDh9VqZEDseCrFXxSid12r30p9bgobO+UM
         0QNsQgugYePBzfD+8dvu0NalGO3qEXVh/+3xB1ZC+7DWh/jE2ASnOmWc3CtmhzqJjVNU
         6vrw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9+y4W4vtqeEbvCfhAmM7IuwksFD7WaLDZAqmZfmdSbh/bywfg3hJtHKVMPoVauty8cDi9t3wny+6T1UHuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynDQBE5xEVoNXjslKjBW1Kv1va7ab5kXsFmdGi/tq8vnKTkJzY
	HqvOlTWARoOUZvugJu9MS3OecNstSoPuDI8giRSgpY0hZWhFqlokUh85mqT/tgLOvDRHCKz+DzF
	05iEfn2TI0UnCvo+L98JlqPdL5vQMQSWcRyq5zKdqWk1yElABjedC53CeL4LkqAjBBA==
X-Gm-Gg: ASbGncuRdt1Qmz3QqKPtWU08ora1Q+eY1u/heO0UzLDWxJWZqy1urNVecJTZK9F+tCo
	8s9yyMaXJ/FZ0kYSjbRxW/dlEnSPJOCo6LqPDYMGWY9dNP8iBc6Cu9bZolcn18N+z1xYNC9f2aY
	hxJikRF10HkH81h5Ux+gmxtS/RHqMVW4USJUD1uPEkux0XqlRLHTwIIOlJbtN2w1pAfPcSiqDOC
	/fZSVnG/cBsxL0ZOl3NKjLoSMsTEfh7zqE3Smo0fb+e7TBIxNyX/2elFAt4SWDWL48MmeEl2mMH
	a9d9j0/4SWRGW15eJq6ZaZ93A5WzuqUlotMy2pvDa2m41d0MRZ7UZA==
X-Received: by 2002:a17:903:3c6d:b0:224:a74:28c2 with SMTP id d9443c01a7336-22bea4c3e94mr182892995ad.29.1744620425452;
        Mon, 14 Apr 2025 01:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp7yFwbjgHGKx7tlCiZg+OFqMpG8Hw5702EW89wSfGmN3jPOC8NG+R8fOKfEBZPcmC7RgC0Q==
X-Received: by 2002:a17:903:3c6d:b0:224:a74:28c2 with SMTP id d9443c01a7336-22bea4c3e94mr182892725ad.29.1744620425129;
        Mon, 14 Apr 2025 01:47:05 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b2b6sm93432875ad.65.2025.04.14.01.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 01:47:04 -0700 (PDT)
Message-ID: <897a8b62-04b1-1ce6-bed4-ff2061636ae6@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 14:17:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 1/2] wifi: ath12k: handle scan link during
 vdev create
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com>
 <20250411-fix_scan_vdev_handling-v2-1-b6740896c144@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411-fix_scan_vdev_handling-v2-1-b6740896c144@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GthC7GMlD8Gsx0NwpDhc8IsGS6xjjne1
X-Proofpoint-GUID: GthC7GMlD8Gsx0NwpDhc8IsGS6xjjne1
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=67fccb8a cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ttVt3SnfeazVJPRM6VEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=668 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140063



On 4/11/2025 8:46 AM, Aditya Kumar Singh wrote:
> For scanning purposes, the driver can use link ID 15 (scan link). A future
> change will make non-ML interfaces to select the scan link. In this
> scenario, arvif->link_id will be used to retrieve the link configuration in
> ath12k_mac_vdev_create(). However, link ID 15 is not recognized as a valid
> link ID in the upper kernel, which will result in a failure to fetch
> link_conf and subsequently cause the scan to fail.
> 
> To avoid this issue, ensure link_conf is fetched only when the link ID is
> within the valid range. Since link_conf cannot be retrieved using the scan
> link, use vif->addr as the Ethernet address for creating the scan vdev.
> This address will serve as the source address (address 2) in the probe
> request frames during scanning. Additionally, use the automatic Tx power
> value for the vdev. As this is a scan vdev, these values do not affect the
> scan functionality.
> 
> Note that vif->addr will only be taken when a valid link_conf can not be
> fetched. Otherwise, link_conf's address will be taken as address 2.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

