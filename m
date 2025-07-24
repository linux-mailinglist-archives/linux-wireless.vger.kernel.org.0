Return-Path: <linux-wireless+bounces-25995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AFB10DFB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838A517ADAD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7C1A0BD6;
	Thu, 24 Jul 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXIjMKSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC151552FA
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368527; cv=none; b=UgnxMqQt2bFnIQq+f+RyQKn9M3D6SOkFw4kivW6k8mNVIwu8KFKr3e80FoAFll0kT9y2Zi1m8JqjhGF9+wwTYr/XaQn8XCq3BaYv57+BZEHEc7HX4TjI28f9AqqlnSO8g+yl3fITA9uRgmWFsHelzD2t8nLJXf/MoOMxcLw1v50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368527; c=relaxed/simple;
	bh=6iBlyv0jsjVxC6Qab2jIL6laV4qezmHuNupbqQk2VKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0XPlHqN3elz7xlmVfFwSLAaCt4fR1KawacfPCWdPMzhhlQrXyb7q8r2ObmUxm99TibZwEgiTo4KjSg0eXHcNWicQK210L1SR8ZJ4qau0tQY3xG0HSaJzxr/qICprt93fGpNUrzkLCSB2DtHSJpAitBVS3dZSYuzCPyzdLKTO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXIjMKSC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9fjld010362
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CduzY1NxzGx9IxDeilA/pnDu0Qgs49OcUvR7vhku/HY=; b=oXIjMKSCCTvH+hI0
	+Sll9ZKGi54iWqnIqeu3Objksy6Oqnib5/md14blY28KG4GKnqIyp6fqrtWv0ZLy
	AmzUhTww8eCWOnRexFXyybopmZ/Bn4rTw2cieoA1U+UhH3G9V3yG9ywdxBHoJPDC
	nBMpLsiZGK164HhiIt/nCOyJmIp6SJVANdscj7qj7VwHZh3RC+HK4CL9XXTvKB2l
	RW7B8QIuLL7MC5eW/Ad5OfQXt65qzPeKs8zA0ra1s/TP7XKKnZg2PZ6tVyIlUnRh
	DAj4Du0DjaItXzd08B/NcfwKoDentm1jdfAdL5VabCjTBYBE6+t0ae8pUtdjVc1o
	Powv8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6waa56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:48:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2349fe994a9so8930115ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368524; x=1753973324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CduzY1NxzGx9IxDeilA/pnDu0Qgs49OcUvR7vhku/HY=;
        b=Rx8fGPWOVLBBF10QgC9e13ARejaDR7YpeezKSYv5ZT7yIygrM3XACc+85V0AwLD4X1
         wk3ZXV53qRoucXuXMn0QyYPoGJe9j6im9Gm4TsC3VxxY7lFPUr8jmUXu6vAu6EqK1hPM
         8SlP8eECwQMTYNxtPAYhZuE1Ii8z7XMF7siqYVVo3GVScNkaks13rWEuHPoqg/YmB8Ml
         g6A22kiZR60KdlL3oSwit5ztCr9Th/QYgTgsagSw9sTM/KBS4POk/NscPhz1rkzVWAon
         DyDAL3IL8qlb4qjZr0MAMqca04HTptUvupZ7OFDDyPTLRKx2Bq107JogVDUFwt6kVz67
         3CHg==
X-Gm-Message-State: AOJu0YxrF+GdOY66sgzRC+zEHXU7xwCmD/5uyEXovc3Pe4Fs/12TKY7Y
	mslVWoJg3S120W7EIAvI5rt7hkwzn+a+SRrpT/SysJX+6A6yO63luow3Vxw5E8qHGKqL001J52O
	gEARtlV4VbwH8arAn0ImxymMgL1a/XapMgc0dOVs3NWq+QmuKenNmaadv7i8igVJVUZt2NxyZIv
	UK+g==
X-Gm-Gg: ASbGncvidOvi0cwdA1wGapzNuHqJ3KaLtM2EwKfCDGPZjIb0SboyPFg+Evy2Ln2+7DP
	M9XcINrR+fDkJiLWfGQU58c3kvIUj3mG5lCh4QFnLUwxENVwwWCYy5ET58aAjFWJS1WIc3h+8Ue
	f7ByRAEbLfD4noL9PncbYs7wk0J1lnSjo4M/k/U/p3p51tivS7xNW2ombDQL13ZuxQkIPzuaQSl
	nX035n7QTBvLdTvu3yW37y/6+TOysrFx7kAuFcyZpG/o9yo/K4eXCn+b1DoFCs+8WrFYV3rGqS+
	tPtxyOq80RuEEERuMUoZXFcoHI4+NrnEtbPeEbKeYk+JPgdmmMWlRaIJAUJILpY4XEMceV7Auge
	/pfu8HTxuyVQX
X-Received: by 2002:a17:903:fab:b0:23c:7b65:9b08 with SMTP id d9443c01a7336-23f9813aa74mr105879685ad.1.1753368523762;
        Thu, 24 Jul 2025 07:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfwwLqMytPEHXGuRgikblICMhXyisURthwRZDZjR204cTZ/cSJkJe9/CvzBsJO5/I2Xsfc7A==
X-Received: by 2002:a17:903:fab:b0:23c:7b65:9b08 with SMTP id d9443c01a7336-23f9813aa74mr105879395ad.1.1753368523298;
        Thu, 24 Jul 2025 07:48:43 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.197.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475fc64sm17620465ad.19.2025.07.24.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:48:43 -0700 (PDT)
Message-ID: <0dab900f-6aad-0c8e-3324-e1be54d53456@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 20:18:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Add fallback for invalid channel
 number in PHY metadata
Content-Language: en-US
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Vinith Kumar R <quic_vinithku@quicinc.com>
References: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=688247cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=CkStrBlBBtcNoDngQR/Gdw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yQQfhEIX4B74JBb4vNkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMiBTYWx0ZWRfX1MAUFwUbVkrz
 Hee2lqXKwrw095rS2DX2V8D/auMX3feX38wPEFTtkorJtaoTtEAcVf2f8qb34ybM9TlPqO02w9x
 RT1E7eoWdbwJa+9TCmcOL8LNWlnT6HY6yCHR3CsWmQ4HIEwIjiROCGIYOj/O5TH6YiU89AXOIA0
 +qnWKHg8ozcr00gybN/hhcJwNTdReV/HinhF/OgHh4NGa1nwH5fbkRsvxir+oA17mONWaJFwYbV
 8yMiVRnLTITWxFUQTKqzHnPsWSPOJtlVvTxZ2rMicaW1rsJMfSHI4chdOdCQ3UrJ6WJTaLqKfkB
 HPAqw7nsNujiLDSqoxNLfC5c20BONOPmgtEJKJSHyWCoq7wAqRVfVdD0PVrkAb/KVdDQVnsxU1G
 gNrAQxBIDEnszpbwsZqFABgYUDZsjRQC4CfTrX892Zji35hPzvaWBb+iw1R6igVYiC+2gf6+
X-Proofpoint-ORIG-GUID: CzfLJN92Q_PRmPCh3t-dS0ZZ_kjUGC67
X-Proofpoint-GUID: CzfLJN92Q_PRmPCh3t-dS0ZZ_kjUGC67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=792 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240112



On 7/24/2025 12:36 AM, Aishwarya R wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently, ath12k_dp_rx_h_ppdu() determines the band and frequency
> based on the channel number and center frequency from the RX descriptor's
> PHY metadata. However, in rare cases, it is observed that frequency
> retrieved from the metadata may be invalid or unexpected especially for
> 6 GHz frames.
> This can result in a NULL sband, which prevents proper frequency assignment
> in rx_status and potentially leading to incorrect RX packet classification.
> 
> To fix this potential issue, add a fallback mechanism that uses
> ar->rx_channel to populate the band and frequency when the derived
> sband is invalid or missing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

