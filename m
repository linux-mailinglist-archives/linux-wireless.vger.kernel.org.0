Return-Path: <linux-wireless+bounces-21570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F162CA8AC07
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 01:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BB73B5CA0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66C1990A7;
	Tue, 15 Apr 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IwNZlIJk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD42D86B7
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759373; cv=none; b=mOVCyeXV7xtSGp8nTeKgvY1FrZxE51VfxNHCtRjxS6c1hcR/+xeFcAjjAolNXMRBogVYtU58RMSQxmX6mEsEMfb6iTy9SzqrlsZ6pyKpFnmhIqH9sjh1vx9IRjbQ3ZVNE1bqyEtpYvdciNx6wqS3UR+WIk9nkMDHX3jnlQvQKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759373; c=relaxed/simple;
	bh=oJcf1iGzJ8hvGO2iDgfTfCBMOCJfFaiW+CZVE7Sw9+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfCzfjX4aIH4v35Mv2vUSE39lRWLtsWJagd7bSsLeMDLNZGA8Y4EkJGq5rzXefDCLYeX8JHhREtQ7R3splhkR5Fjg1JStrWkWEY00Qi05XSBLjA3YQi5O6IO3EnQ7yhyMu8vrL6cR1USSpjlJRsephoZ/FuH50SQQw2Bcbj776E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IwNZlIJk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FI2hNh023401
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 23:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJcf1iGzJ8hvGO2iDgfTfCBMOCJfFaiW+CZVE7Sw9+0=; b=IwNZlIJkrsZF2Hqf
	CoVCoCFWLyny264zWYG5Ea8+LVfnBgCKRdgYHnPoQkWc0VHb4gidTFQVMIu0yOdZ
	3FCaZJZ06JVvGSDV/Xo1AlQzNpwYIZPP2vB6E41VeeFmkvzWzZIhFi7MAvrREJKP
	Fc4uOS42ZgIXuBNt6UJUADHpB+A/NVK90sosJkm3E6qoVneww2C9XC8+NYBw8E6a
	pHynHws9nY1ISBSlPRLUZAs1il8GWhZxp0mUtlVKDuOopM6XZXQ/Wlt+K+R2Elrc
	uHWNp0Lp6sw5U8tb8pp6WSDutX6h/R9HUE9nN6W4rqNF+Srb0Ozo92TQzcmQnqaT
	wWd5nw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj99kcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 23:22:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224192ff68bso55097645ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 16:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744759368; x=1745364168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJcf1iGzJ8hvGO2iDgfTfCBMOCJfFaiW+CZVE7Sw9+0=;
        b=O+RyJ1UAQRZoNiyjldR8ErZu6pQZxsNy7CbLxwBy/6/UA0MLLVTm40fqsNSuOZiOQo
         e9E7UNgu9P4SGowervROXFSYwLCKInpFV1MoPbgS2AZcHEtYGQ0om7K2Ys08YBZZNUVE
         UjyenIU/M5ppjbqXMtSV6/v14oJeJHwyrWcDwRPJKcMrh7u+z4mWIiC1VV7NjxVH9WWG
         4eCJxwaY5zNsMAOpi9JQjLuqAhL0+4lDJ0BtehRSvyjcvrV6ijRnKFB8H9RHlowf7G5G
         JahdnTAlSPgvJ94zUUmyTeqxX1foebH9Nezy28rjgtOVXDoykQqC87kPcCtqY1kCzjOv
         0+Cw==
X-Gm-Message-State: AOJu0YxXPafNgKEW2b32yp94E4b2lzJyv+kMFgeyS/zw6YtJwdpqAyAf
	tPeMuuuZTGrNltSO8vcWWY9ZT0bDnCa2HVR6cdl+3semwRWPWgg7W4aL3AffrcQjEHwTqVKgbVd
	EjV3hwVpr1POiXtODDzkVy+4AVnFWOGjN5MB8c6dje38JO+npz5F+VfPWgmqDpKoGyA==
X-Gm-Gg: ASbGnctr1/wsikic6SPRguvNqtJS0eDDC/N+jzEdJ+Kh02pqj3IvhuWxN2W6ivF3avY
	OrKRbOiLv0AIhjUFR8x6zA1dazlTeZsDc/kCRtgrtI61mKmw4mS8o5Q2E4/FzSdkkwZ0Y8CqcJ8
	hgvJZ66+ksMmhGS4+UKfyfSNINAKaNtnoNFQ0bNenEchALSznsusJgPvXR2rJGxK1fT/a880BFB
	aBN+KUW1KongcnXAllWI3svpqNR96R98HHGyPQdQzvcUFfXAJLfeLTtGCAcM2mzloy/NeNL2pbf
	KgjK4RCORl5od6U5Mvl1UJGDjWoPajCV7GhKKCd6mXMoDJWxwlyLvfagceJfq+MbVXj3Qeq7JBh
	5SMBi
X-Received: by 2002:a17:902:d492:b0:224:1c1:4aba with SMTP id d9443c01a7336-22c31abac8emr11421215ad.50.1744759368347;
        Tue, 15 Apr 2025 16:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+jBVAqva7ozMrbvSnAzcxIfkA5OTu4Bc7w8zR2NNkixCoFXJ1y8Ha2vsmYYStJ1FRF4yZfg==
X-Received: by 2002:a17:902:d492:b0:224:1c1:4aba with SMTP id d9443c01a7336-22c31abac8emr11420965ad.50.1744759367958;
        Tue, 15 Apr 2025 16:22:47 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6798sm899615ad.216.2025.04.15.16.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 16:22:47 -0700 (PDT)
Message-ID: <bd0f1c55-e685-4ed5-bb3f-95e521bd3e1d@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 16:22:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/2] wifi: ath12k: correctly handle mcast
 packets for clients
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
 <20250411061523.859387-3-quic_sarishar@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250411061523.859387-3-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: j2YE3KspLCuR8oRrJf6Opoe38drKjSMD
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67feea49 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=XN0JUVIU5v_tRlagsdoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: j2YE3KspLCuR8oRrJf6Opoe38drKjSMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=650
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150167

On 4/10/2025 11:15 PM, Sarika Sharma wrote:
> Currently, RX is_mcbc bit is set for packest send from client as

In pending I modified: s/packest send/packets sent/

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=f2358d4e1724e40f8558d713cac36710dbbc8f37



