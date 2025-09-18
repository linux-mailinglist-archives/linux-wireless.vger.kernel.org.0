Return-Path: <linux-wireless+bounces-27485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165EB85A74
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18D51C23CFC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFD302CA6;
	Thu, 18 Sep 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFi9e74j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01027A929
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209444; cv=none; b=eBoZbaF2s3mhsAe904uWa1zJ8MOxBrW92iL3fUsSAybY71c8TRdrTs2gtobNb6BKMYV50symxs06B+VuLTQIRgrRQV7rlJl0dwqtolLxb94RqNoT2AgL8eJfnKjQ52nWsEzQLV4ZFH03bkCy+O9f1tMN8m7jJGm9etl0hCn1EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209444; c=relaxed/simple;
	bh=eHexsjWST8Mpsyps31lBz0UT880fxViH3NiR6TxIE44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyzcYn1YQdw/CI44xawHksT5mWOJNjU4GknT1d2GCn70cH1rfFHzdnzupB2UL6OgNJqO/CATgSmdFych7F3rNQHFD4qxBkimiVTR3E/phVPiCDRPVKxo2sy/DRAG4jpxpT9TdzUb4drL9WMa1Q1tzwJ+7worwuBSEXond4lbEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFi9e74j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IB1V0f029580
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 15:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bhSX98HuJMkyrMaoMiSuQu57olFpyJn5Wru3dPmWuJo=; b=dFi9e74jPDRlKBq9
	wyuv/FewfFCifXgDzVQNKatQxQ/gGqnQVf0D51B/j4e0LDOgDPm6FB9Pf1wHg26Y
	7XtX047T9jmYvLYORZjmXPWzDIuvE/WEAptzPhFj+lxn2J6av7XgMAtof0ThpoSR
	XUC/dPUpYXnV5hI+wCoHNetm43pcvQOKHH/9obHjSYCi+pCBUKFpR+JT73vW85TR
	Vy3XQOpFCKmRxk+ZwVjxLsP58ib2qr8yMc8F98JVXGTvEYNXleDneff21Bv+w9EP
	tQf0BueKnMnV4owOWYel4dgxDEqxKZUGfe+BDnBSscIFwOTFJrkRjXPe1u+NAngh
	Rn26sA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0xw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 15:30:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e0b001505so1089271a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 08:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209441; x=1758814241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhSX98HuJMkyrMaoMiSuQu57olFpyJn5Wru3dPmWuJo=;
        b=uMddo9IDZX4Dda5ZKYGbaWPJ9HnmCsZoBe5k1PsB2/Hyn4BZ6aRk5/XEYwStsbb4wy
         ohfz3+UD55FxvHlQIyhyxhb9c8oyEcwTGJ7Xti6CVU5UWpO6FwHlaApdQ89ZabRNV/L6
         tfkPQMq/pV0Fgfeeq5X6HeCiUaiIb7Xh6WmGXTpLCVMdc2ChnZ7CnhVKjHagvM6jctMt
         pejuk9frWH9Nd6rZPNNtBrLXQNlSCqLmDrCASRrQ91Vd3suXDBktZexjoKFv58PLiy+S
         IcoqhC7LNLs+PVlh340H36feCluzFuSOYt7Yrry4U/j61G1d1S/q8yJ56fVyPX3eiolg
         JkUQ==
X-Gm-Message-State: AOJu0Yx2B8bnkjJdelr0lVMHKAxxPw35Rp+mXG88l/N+GWlG1LjchDNJ
	0gtfpW/xAar1dXxDl4PE29u+6Kh8+ecjcxrvF4MmBmxr+owa+68kad0NQOpBfyEF+Hu9kRO1lsn
	XrnFVNtZz3j/69WfLjs2UmjruxU9iVkWmDzDIjpwemjOozo73J9P/jtt1kx7hmD3k8yMRXg==
X-Gm-Gg: ASbGncsHKoDliS2d55Vkd8x9lf9bNjA0sOUF//5JKhgDCJORflAdCOJ0ZNuSZ3SmmP9
	yzLVR+TgsehQ09/BXWVKR9mlljBE7u1tzbem8AoHkE2Ll+6vBmAn99XJpLOsQyznqJTg6/siqku
	B3yU3/igQwTEOTXX5OSjCkkHnX6kNJOzhqB5+LmFLn47GImAnbb6285RlXY+PRgI5ZAXO8lBTNJ
	GVjV8fFQSd9cHRZbIoafcGZet3FSzc2LDiy+y4sVgK0J/0HyKfwhVjHMPbLB4/TilGp0lCRy6a0
	nZoCYh2zOocesSRo6TmgjKmy58q4irkIInjVRiqgLaFNceE1s33Fjy4IVXQlvEDF8xHiYPw+F2F
	EffN1V3Jbbu0=
X-Received: by 2002:a17:90b:5590:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-32ee3f68353mr7443677a91.23.1758209440722;
        Thu, 18 Sep 2025 08:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJtZalFVe+kGAbPWvX/SFNLY4dbFllQVIHjbFGW3Gqec+5jAn3kcNmX6T2JYXIMtSPBWimIQ==
X-Received: by 2002:a17:90b:5590:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-32ee3f68353mr7443610a91.23.1758209440202;
        Thu, 18 Sep 2025 08:30:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061925esm2937000a91.2.2025.09.18.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:30:39 -0700 (PDT)
Message-ID: <3ecf5010-7480-c780-1bf7-b0e762bf293d@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 21:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] wifi: ath: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Content-Language: en-US
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
References: <20250813214933.897486-1-robh@kernel.org>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250813214933.897486-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UguHiksf9pN6pRtQlQSSssbmC0APn_8R
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc25a1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=31WDjHDmXr0yx5AvGNnQTg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjuCZWrZiTeoWwOd-AYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: UguHiksf9pN6pRtQlQSSssbmC0APn_8R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX88Cwaz2NZfGT
 Ou79Liomzd3EDuKOQ09GPhSuKzu3dnII2NWLYj2oeqW1W/49UED9JwPXMAiRzTWdYnuuSLKb4/R
 50rqStij/FUD2RBWqGqLwWXS8Z2b3r5+3V+4ilr6+wjVcZq6CrbD+WBeMAyQ9uh/E8JDS2cMzIF
 Ypiiwp11aimTQ8aATHnxJW7jL5e4H3CcUgxJf3hbl1A7AH2Let9Z9RaHPSpvcuInl2UkHJEMToG
 YRVj7y8gFJrNdiQ+lI10qLwmVt3e2iD6EEhJV27ZSWBDzYLsbzlhSsmGMfx8drcD/NrkNp+JaHA
 SBNAZecInCv++AcZXNv9MczROjfPVC7Q9uogSRJgi6cV3H19yJ2pnkJpy2rw90VTpU4TG2fr8od
 Sr7O8U1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/14/2025 3:19 AM, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different for ath10k. "memory-region" is
> optional, so failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

