Return-Path: <linux-wireless+bounces-30359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74809CF375D
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 13:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055DC3036C99
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E23314CD;
	Mon,  5 Jan 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5yWp8C1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hnPnq6ZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44930FC10
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615068; cv=none; b=JnMi4ifijK7ahORjBsO7wSlaemTFNPGqqz3mzCs0EhrYoeA9PgabKTNiEQ6KsqmgWNuaMNuZNZe6pLGwTITs5hdHD1RFWdXVTazOhMt8ugnwfT22w0PB8x54SXnLXoNEOR3NJbwWJaXjRL9PMfxKSQfZgiuKnv5NsJJGAInsV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615068; c=relaxed/simple;
	bh=ZQjSOGXN1WuxxWJBGrsK1KVOGW0JY6WIsZhNTKotkR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbGWk/yXBUhnsNWOMVG4bPBZruXZjKJzPDiyh/6HtCbPcZftZMQ1R18iiA9vyA03KjfWYVqtIZ7L83aFjAmuLencjTrBZJ8WTcBrpTF4jm1j+YnDPXFcatPNkdxpClgEgNA1P3x3w8NCgAuU1XQVSFP62VOYvqdgamlzIdkmXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5yWp8C1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hnPnq6ZW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605BnQNt3520978
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 12:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4kCgYZdo+n+b8GKJRaBKlif9iVWatEPxeuMHhHsse0=; b=e5yWp8C1XfjyIcZ6
	G2QP/WaJtqwpo9VIC0tmDk08WRl/PX98l6JOzSXkj+FsI42Bz/I0oS3PpziNUrLv
	PGH3G+YJJIXhk0gYVXE7ftPtKzkpEflYby/R2sTFy5V+WmXEMyNF+swez/Ppa5Ec
	yY/7tsRMQ/Jo/shZl2VcrtUQmZbEcZHvi2Gzg3vIF2fCIUO9NaYUcMRNwGBgvta0
	siA/41RX6ZC7oLJMF6I/YHj8BatxacVTYZkuILoATp7GC5nn1u+fmEO6d84AnuQJ
	W5VzJwsvNaFi21IfYT4UlEsM0uvX2GGfafK2m2VwqplB4WOier1cfGECI1/1GbsM
	1e+cZQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg6uu96te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 12:11:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso1534922a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767615063; x=1768219863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4kCgYZdo+n+b8GKJRaBKlif9iVWatEPxeuMHhHsse0=;
        b=hnPnq6ZWWvPibN16kaSL76jUSsyvbWpDiGVXLEHHsQSVsbtoeI/zTFc+S2b6faF9tK
         gyz1iB7gyBPg0VeXxvBHUbJrJRWE20hgLoujmW8ycLSGFzKrGt2sCfLKiWCp5Z9HOm9C
         gImYgVOZiZZhcZmeq8F2Ni3/oCGhLtusIpuBHn7Yz78xL+8fZLns8lqCkEy0F1gB5KKL
         YkbgZDyW5iTsVIMTYWMVIaMHcN2ERZW8iMWwGMu52vAMy4na7lxfO1KDSOYigiSqRV9S
         usym7EB2PN5MKY59qj6m02vI3hnVd54A0JaonyDW8tkNVTVglNcstUKHJuV1YCvUlNOn
         aQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615063; x=1768219863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4kCgYZdo+n+b8GKJRaBKlif9iVWatEPxeuMHhHsse0=;
        b=tS3loNzz9fnav+iJyIB11EtUZLkuBcGswRSbIRpGSD/Xk7dw6ZFt10bdtg9ak1pzrb
         WOKp7QgB+5RGVHHnTjtgjV79IKdIYwYN9fntyCYXU9lEMgSe7FQFRCaMWC/bIfs+0oNF
         jGhNV2GpzKOwS2ryiJAMlewYg7qiwIa7u2WqCsDu+82PeLRC/qYLObpll3oJfeRul0Ba
         8+5WQRk2t/mAZQRhxblkVYub9cFuNN1RS9BTSeaYoczTRs/rl+I+dhuGnwM9BGO93ZvL
         lmwvQsYPx0zn6s5hB9kQHQpJayngCjSSu20nxsNRCYcB5AaPzO0Ka6roqfF//sLGVv/K
         yBdQ==
X-Gm-Message-State: AOJu0YyB6L5/MPnhgzBvq9qk21ffB9ooRbjVMSNEgG85ldKkRD379Bw5
	UJlFoQeZknI32yc8eIx7QgTH236lM4jq0BxuZO1Xw0cirAds3iQYGoveVjVZvze9HuoFlV8R1eu
	Urg/n9DR5VToAE0uceNjenPe5HsxiFdygTv8RLX6b11C4oKPS4q/vtHIXUbR11f+GmNmdKw==
X-Gm-Gg: AY/fxX4p9CcQr265ARRfHf4QcbYvm3DgJQL3w+00cqrTxPzRmZ6KgpAZTDZsY2xuSiG
	zuVqEmreZmuGLgV1Rd1cPv//F2gfQnREJIzctXahxwYgK3T1Jv22dWcyaibPfjEwJmj7vY+owIw
	rIpTLkCJeuSVYvlLssr271wom6qvz8NqZbFCvszf9SoLYLaxBttqq0ueVr4B7rOkrPjHJrpTgPz
	fWvUSJ65HGHeRu46xHpqLQgDc5Ke2oR2HmoLALDdVgkkYvLVFt+j1AgQwiOmv0W4uGlX8xHK3jj
	CFRlo299QmY9s+hAWJAlbzL5692Q9JlQzBFxvP12zThnXLiaSUNiJsT+oK3dYa+jXFIJwNDH5E8
	JoK5M5bN2p27By7LvmgRIUZTxBADfF4+zUSgt1g2845tjhdq/Y5EhkaJtci/NYpO8
X-Received: by 2002:a17:90b:4a8f:b0:34c:6a13:c3bc with SMTP id 98e67ed59e1d1-34f453c9ee1mr6142903a91.9.1767615063396;
        Mon, 05 Jan 2026 04:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWOhRc9bpjbVSWMDyMnxDbgAkS+r/3EhXRK4JEu9ypA7SEU+gyF7A1CwjRzreLb2XVL9h5pA==
X-Received: by 2002:a17:90b:4a8f:b0:34c:6a13:c3bc with SMTP id 98e67ed59e1d1-34f453c9ee1mr6142881a91.9.1767615062839;
        Mon, 05 Jan 2026 04:11:02 -0800 (PST)
Received: from [10.110.80.189] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f45cc1e37sm3333202a91.4.2026.01.05.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 04:11:02 -0800 (PST)
Message-ID: <fc06e13e-9719-47c8-9423-02e561c7e43c@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 20:10:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
 <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
 <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
In-Reply-To: <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwNyBTYWx0ZWRfX4ewX+VzZvO5R
 02CiDB+XRDzMAD/hy0jckcHZI4BO/IVd65uWTvoQ6nNMO1qqDnk+cv7lj63L/rclcEejfS6XFXj
 46eTKn6vk9fsKXp7cDb1u2teSLaeh/MQ85C1bpM25Cplu6Er9BSHG0zcS8F+XX23UzDWU5Cvuc6
 lJPFbSUrtLm0MUkU2Cfb3HU19wOWKdWv4+Uv76ggj/kvw6lxI0sA5GYd86nmmtw8zZmCyD5BKUE
 oLVKYIR9zNqrdYbj2tF8pQSHOwG/XGHtNRZV7rEC9mQUpEZp7wwVf3cdYavmQSkEUECFS1HimXt
 2vaE1BlJ5m8bNwS1cFE4F9+XY0hHJum8nJAGR+ThGpY24jaxeT3CxMqaFpaPkYxoBxMk67O0GA3
 tclaEb7etpnBXB3EfmtLHmcTGkvDtW4ATKEW1dPAGDccVatHf1uPZynEObsoLkO/DMH8fHaGE3Y
 zaIpWjee13QLrhtaqGg==
X-Authority-Analysis: v=2.4 cv=eZ8wvrEH c=1 sm=1 tr=0 ts=695baa58 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lsjKkKj5qOhYR83dBvEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: d5s68qeGTJ5Hjuf9bMYoiUCGuGK_Ut4U
X-Proofpoint-ORIG-GUID: d5s68qeGTJ5Hjuf9bMYoiUCGuGK_Ut4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050107



On 12/31/2025 2:06 PM, Arend van Spriel wrote:
> Op 23 december 2025 10:27:46 schreef Qian Zhang 
> <qian.zhang@oss.qualcomm.com>:
> 
>> Channel Frequency Response (CFR) module will be initialized only when
>> the following criteria passes:
>> * Enabled CFR support for the hardware through the hardware param
>>   'cfr_support'
>> * WMI service enabled for the CFR support
>>   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/ 
>> wireless/ath/ath11k/core.c
>> index 812686173ac8..6a6bf6316ac9 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -1,7 +1,6 @@
>> // SPDX-License-Identifier: BSD-3-Clause-Clear
>> /*
>>  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
> 
> Hi Qiang Zhang,
> 
> Some explanation on this would have been nice. Doing this in a separate 
> patch would be even better.
> 
> Regards,
> Arend

The CFR-related statistics are reported through a special hardware ring. 
The changes here are for configuring buffers for these rings. Currently, 
255 buffers of size 8200 have been prepared for CFR. For hardware that 
does not support this feature, both the number and size of buffers are 
zero.
Do you think the changes in core.c should be made as a separate patch?

Thanks,
Qian

>>  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>  */
> 
> 


