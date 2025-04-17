Return-Path: <linux-wireless+bounces-21616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F846A91264
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2750E189CE3E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E941C5D70;
	Thu, 17 Apr 2025 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBsyDNw2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E77E1
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865688; cv=none; b=ebI3yfEPsbzvmdYEfHKEOBbFlLYRC6uqYlsxqbHw/G2inghtub4HH6uVMiSOKGPueuQ6DjyBry46OgK4jlRMtQPDFyYZ7298Sa7hIsPqpONAfm9BdJWWgEGlDb3vYXjsome1nLlaj1juOkIibM50ogRlEx3DKrSfEXyu/jkap9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865688; c=relaxed/simple;
	bh=mMmS9+fBFX6KwNWfnmj0t6jSE5GEPFyOvmktN9XZXtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6Jl/509uNGJKR1oNxTt4WD4jc7k7C5yWLyn76I+Q8qh+qMLU296HSFIt6S5FgZ4tt2Ot9XaXWN5/mzCB/U8Hd6Gn0EI8xjrZsg9rwsKBSmupXy6izxuClnnkYyQQ3bBLCtvmXmzWU26hXJQ/7SBvm1u4VwfYtbvBEvwEcnYmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBsyDNw2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMNwk5020885
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6O6GepC5eIrOp3iDevOUYzb/ofYkIHjNPUuqpF9IdtQ=; b=MBsyDNw24w10tTE1
	Sz/3Wm3OkNfiswdd2If8rp9NYqbU8OEM9pQn4XQ1cMP32FI8ZQsI7gDLktLHmAZq
	Xg4Ups2b9RM4/b5TQ3O0cpiuja8tj3Vh8Ifk8vjnl12XJLWbr4gXocBx0S4BNPoN
	PtZ3qWqdnJbHHE39Yk4QpeU/Wb6RjSrCRffoPpiOsUCG6bJbVZ9T240/NYlu6A5w
	XOQqbEzmShGQI72fA+BL5wctEFYJECba4tIiepK+CD0H/XiDdxVjLz74PwUZx3Bo
	Y7ajqRn2x6iLpFYWj6ae/wXtGoPq0yubPw1ybdzaFWbQUkLKzUnWgf5skjBWcVn0
	r5Rxjg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69wp84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:54:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7369b559169so282545b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865683; x=1745470483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6O6GepC5eIrOp3iDevOUYzb/ofYkIHjNPUuqpF9IdtQ=;
        b=e1bYhzGi2UFTxpfb5HSb7NtcoE/AvnhPBUlrAla4lghtyc1Vjv4c2nxoVNFfrEE4td
         D93Xb3VNRkxFY4Qc1cPrBXdxJqrtCcXTpk9222zLyOpyfkvmWDrxAWd8cqzvV8tFK3W5
         Z0RQcx6l9fRSP1fFH4UakRgJ+kSJCLTcrb2vxFpZWGSS+EaWMzPpVfoVXQsSlxnRgWh9
         DjFt+QKxIfcdeaf4ALz3nmUGl2xh3yjZ3I23RiUYLSwGAWe0KEWhv1sbglpLvDd2yuDT
         +B/Rq8I3zYM/nwx/pKWRI8MnF5hgMG8FN42g9XwkIXvH8DX3swZJQ3BnXklVAv6Le+wJ
         aW/w==
X-Gm-Message-State: AOJu0YyhQ1u327onGGJTbgHdQVfRDeVKfNpcWnfP2ULS+OSNV9OpasS5
	gIq381v3IoWCsbKYdqRUKw4KB4xJzaAZ+kQD8jXHMSA6zPqiwmRpOft2qOx6XYFpLHN8KX9/29X
	UgDjjdggnWT63D9Vomoi+O/9PPQWzNHa8IvG78v57PlnwvlUKDSaAZbhuB6X+yhtbzQ==
X-Gm-Gg: ASbGncvrbV9HBD02tac4P5WHZpqaWN8BfGLrlW/c8/pjxemMtQvga1Hu7GJGeygGCVC
	t9TnbrdM0K3PYi23af9VsMRXAZKJ3HVMzZyZoepBknrUmysGfyvqfuF40WNiYMcJT3OApO3+4ZH
	DUCUU25G2eDWyb1PuefyZuiu2MzGgVXGl6ksX75Mgm7+bRibQ081ybVRO8eUEdIUnYzcOpuKKvA
	FfXgE3OjToE+6TntsiXZ74r6ggeP4qyBEc6JwyI21tcNQSqM14c7K/6QoJdhXOdFYtBu1YI3yyc
	848MVyoam71JgdvpmoMApAZpCTeSqFqyFJKGUfYWFMo4E8H8NFSj/A==
X-Received: by 2002:a05:6a00:3a18:b0:736:a4ca:62e1 with SMTP id d2e1a72fcca58-73c266f3a8fmr5662443b3a.6.1744865683420;
        Wed, 16 Apr 2025 21:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJi4Ktz+OUftQ2wWueXWwIhdolURo7Uz6j82Djaj7l4S1SHU1r4LrjLWjzRFgdWWevtFeraw==
X-Received: by 2002:a05:6a00:3a18:b0:736:a4ca:62e1 with SMTP id d2e1a72fcca58-73c266f3a8fmr5662420b3a.6.1744865683020;
        Wed, 16 Apr 2025 21:54:43 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23332d2sm11362928b3a.159.2025.04.16.21.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:54:42 -0700 (PDT)
Message-ID: <1c7f3f7f-bd6e-ee96-761d-8f44766736f0@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:24:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v7] wifi: ath12k: delete mon reap timer
Content-Language: en-US
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250416022011.1935-1-kang.yang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250416022011.1935-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vVFGGt8mk9MT12FN0I4YlTrUOS5AEBtD
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=68008994 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=tbk3IEclxwNNDUlJFEYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: vVFGGt8mk9MT12FN0I4YlTrUOS5AEBtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=645 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036



On 4/16/2025 7:50 AM, Kang Yang wrote:
> Currently mon reap timer is not used, and it is not needed anymore for
> WCN7850.
> 
> So remove related code.
> 
> This change does not affect QCN9274, as the mon reap timer is not used
> for QCN9274.
> 
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

