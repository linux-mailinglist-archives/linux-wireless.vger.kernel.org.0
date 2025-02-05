Return-Path: <linux-wireless+bounces-18487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33FA2832D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 04:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B23A1309
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9A12135C6;
	Wed,  5 Feb 2025 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQTFCsAx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDA1E505
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727940; cv=none; b=ov+vzsE3ZJrB67MSGWfeCJTCHDFzAZ/OliaB3C+6rf6dce15NtFDiCbGLXreK12m3/3wFbvnyOt5E9bCGA2DxWJs9RK0wbwHSMOtbXDt/aQIUGMgWd1ij8tWaB6Qr6lNq804PNibsFHQBjHwB4PQBJM3koZEV9tzzOkL7IlGyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727940; c=relaxed/simple;
	bh=Qlt3qJ0AxM3d8emEKR7E7AAwZ+Y+vvvCY13PAqqDceg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NKltAMh9a8QsvtZEZeXzEFsBMtZOwtjQZfUuoZy0exOblWtS+6ruqrcu03GeekBILWpVTJh2MFrTOUN2rk6s4wgLesMCGJdzsx7whOg8sS3y21pPP3vAj8DrUi3UupMTFZr4Sok0s6KD+pBK7BVJdc1qsAq7YahoHVlJ3ZKm3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQTFCsAx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514Iw98d014693
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 03:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S62PUSeqG14RqXzxFfuDYkNfcydTd1TcwBUSQTxQ6JI=; b=AQTFCsAxPDKVn1v+
	NpEH0eg/s4h23M2096KElbj790ACX3eB8meBb2OCN7s1O4PK0FFEK+Vj95FuKWKD
	yFGHcwvqjjEHFHxIiMWJJtCHDQ+JyZLzm6Z6Abl7fh8/DRKG+Lzs5DCthX2fCdoz
	Af6cGQ23s/LL4yIyJ6XiBll/SWZC7CB/IdK1nGbsLNqSo0xX5Dq7ntYJE0qRmCp6
	A3uTCKh5THpcLEnS2cGu9dwK6PpFG45l/o6JxGbimwG5cRHjlQ/wzvaTlS6aSyrS
	Xtc1dvYRr5jns6gs2BZqa/pyjrgxq0fs+nDVM/53YdG+SNkScdVKwEDZUzqYhQE0
	WVi90g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44krmygyd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 03:58:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166464e236so208229635ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 19:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738727931; x=1739332731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S62PUSeqG14RqXzxFfuDYkNfcydTd1TcwBUSQTxQ6JI=;
        b=Nz+xBaEkVICPVd5UNjJu8lUquY5vbSok6wMxQSjHBW61MhknTo9YPcyHCUWzGWUA2m
         4o+eKyAM+AIpbRi3f/Cd/8d7Jc28VB8RJSnhjWxZYnahOxbXnmMaOpM6pXa3iTj5Rsih
         38ftLyS3clCwyaQmA2j3S28yBLMn11BY9fl6e+4rFuT4PbAoJhuln7XfOK6zP1QYjbkp
         vdOdkGsQhHab96ZUjG0vGbtbSzIjmtk0/TCXE8VKsxnfdzSu+S/Ka3f+Y9EhPdlgYRh+
         N2VkMNiAaIEkI81hXbU1D+SzHkmb6fAjwUsJod6Mu+XHOrGT68elOvfY/Ace7hH02oq3
         59mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKmLW6gT95VGek8j02q39CK7orbSR5I4ZBZqAtbVYzl9HCQNiOqz4DXUC0HR9GC7ERSVvHXOCBbHW8Y1edDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbyNRNw9AWwAtt8CS1qqetW3zT85RT9CGBPHMH+vlaVCKrhlP
	F9OR/RUMV/lrBrR2oDMpoDXr+Kd0QUcW41BiGtWQ1Kps174FiTgl/CAgO/fDWBte8Qrm0jL280K
	YogH+ayKrc6lFlp7eL3ZnDFaf6homeTaBJS+ehzZS2VP6OARNKNzD75/sdEEiC0eBWQ==
X-Gm-Gg: ASbGncuusq6knb0w+BwlVpWu13GMj9s55ND0CvahKNoxR8bCi8IXmi9c3U4vXCNh+dB
	8J5kZW1pfLvgQrs9OLYzu4KcpHXtP51gFSYQHnjUiNE+fRco49knt9yZQa8HzlYwtw6pCgNhEpS
	dUAswVOQU6Uasr3wD7Q7hCbGW8IJwmUmxgiYGlVYS+Oq6B2I4K1mI2idtD2aIS+bU4E1iLndVm8
	Ew8njs6VYHkl2FHg+dJ5ri0Hn0GeTtV+IonFclLjaCLmetpkIfQgNuKhPC94tURIBO6q+f6bwWO
	b9ycWjsEhrlzquc6cFOpPyHGFaD6mSGXdZcDuzA=
X-Received: by 2002:a17:902:d481:b0:216:3e86:1cb9 with SMTP id d9443c01a7336-21f17f22af9mr21638115ad.50.1738727930961;
        Tue, 04 Feb 2025 19:58:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkNezxHQtquirLQM9BhytG3M3yW8pCBTj9PZq6uof5YtSc0sFPJl2awYudDFoNXr7qRfdbmA==
X-Received: by 2002:a17:902:d481:b0:216:3e86:1cb9 with SMTP id d9443c01a7336-21f17f22af9mr21637845ad.50.1738727930607;
        Tue, 04 Feb 2025 19:58:50 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad4fa6b3948sm2448796a12.26.2025.02.04.19.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 19:58:50 -0800 (PST)
Message-ID: <15632e7a-fd47-4940-91d7-1b75d51ae43e@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 09:28:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA
 beacon generation
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
 <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
 <db16febb-a58e-4a60-ab1a-212c30fb5313@oss.qualcomm.com>
 <a4809256-5806-4e1c-a12c-d5d2a6c0be44@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <a4809256-5806-4e1c-a12c-d5d2a6c0be44@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qCgqU63YBQvaiCEYIZyJOsQB3dktccr6
X-Proofpoint-ORIG-GUID: qCgqU63YBQvaiCEYIZyJOsQB3dktccr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_01,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=663 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050027

On 2/4/25 23:58, Aloka Dixit wrote:
> On 2/3/2025 8:41 PM, Aditya Kumar Singh wrote:
>> On 2/4/25 03:14, Aloka Dixit wrote:
>>> Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
>>> a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
>>> or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
>>> the same pointer. Instead store the pointer and pass it to the
>>> latter two functions.
>>>
>>
>> Same, Is this tested? Perhaps you forgot to add "Tested-on:" tag?
>>
>>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>>> ---
>>
>>
> 
> No, only ath12k patches are tested hence no tag here for ath11k.
> This patch doesn't change handling functionally and I confirmed that all 
> places using 'tx_arvif' first do NULL check because the refactored 
> function can return NULL. Functions ath11k_mac_setup_bcn_tmpl_mbssid() 
> and ath11k_mac_setup_bcn_tmpl_ema() always receive a non-NULL value now 
> because the caller ath11k_mac_setup_bcn_tmpl() sets 'tx_arvif = arvif' 
> whenever applicable.

Okay so in that case "No functionality change. Compile tested only." 
line should be there in commit text?

-- 
Aditya

