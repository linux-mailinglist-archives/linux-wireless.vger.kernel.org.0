Return-Path: <linux-wireless+bounces-30731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7FD16EF2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9F13016199
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 07:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2AB30C62C;
	Tue, 13 Jan 2026 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOCmgVNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEuhB5IO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132E2DE6F3
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287614; cv=none; b=rrEdQtm/lK48VnZwPaRVtEyb2vcMUveiT5hn++rPga67daEiyIT0jyQmDbI3grFfsqJGc+zbCmN/0DG9XLIWrdNuT0iEF1gjbmXmEM/Hd3WkNMm6i/K5luA9v5s4+73+WfBKee3CKXzbXsOJV8AAwgc5xROhYpDkDACxG3G0l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287614; c=relaxed/simple;
	bh=IGkJdLUV0fzpoWdZ3Pzr7pe3ksxgaMVKHBAKNFlMm8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMkOMdevAq8hvHzeULyl+WC6x4XWId+AszeNcvoPG7LzBgLJbdOOEnrysQRm/Xfgz+xGmdzZZu6VlqWa8tdBgRRPxV63hF+rzBkZH2Fm5fshuAN4a15+FQJav7XrXxv/vXUjH29mzSToQ65bXiwKku83ub8whet00fhJRE0HhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LOCmgVNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CEuhB5IO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN5KNP1935836
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AXkl1pxhWWfkg7abcGoMjqh2hI4gBsUgUfa7xAd1HCc=; b=LOCmgVNyotarnjRP
	LYg4ysktQETM8j5iRiFGPW4fXtRYbPB+BKNtwF98HanNfsZnkXYWyHXilJj7l3yG
	50kcVtijaD36xh8V4F6WFav/U5zyByATVTtwsvULNUrbZvD5MGDMQlU6IIzcgcLm
	tNe6Xv/dcmNkiZIZulI9qvhVsBK3tL/CxIDiw5JWtU+Y8rV1MY9if1sNkZS233GL
	TfsE1zJKIIiRMHWKDWlEJsbBipVt2iCMR3O1lQbOm+VGbkiENOVBZdjSID2A2fv9
	a13Xilrusvl4sKCUkUvyEPCfgaGjUf6Gl3qjASgBhwMjIZshoHfTZdwqdjr+4ygq
	7BXf3A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6cnhujy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:00:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a31087af17so93581965ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 23:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768287611; x=1768892411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXkl1pxhWWfkg7abcGoMjqh2hI4gBsUgUfa7xAd1HCc=;
        b=CEuhB5IOx7yK40DF0n6bHuhseUMB40PWrkqa0dvdqdgyw4jAZQND5PIHJV7ijaG56S
         LYPajnHatwjATngw6kWy6DrSKRU9pcLIgBYYvl4OCwrOiuHZVnK+yjP+WjScs3j9e5hn
         qC+3rOTyfYTk23/gRXIKAMWrkKJQ8cOAdPvg3wbTeigoRvb7lw+vffcAaSPXxv+yc095
         Mb4ltSFU0UKvSEXezaSU1L4vvX5sPjIlxRL14FmnoZr+QFBh5aBHifEPDzt/Byr9kfcM
         uXlmly2azugoNQbOo7anYGIp+8yX+EGzx0AkMhDwwrSSAP21hreb/Rxa20E3+JCPh0Pw
         Wdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287611; x=1768892411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXkl1pxhWWfkg7abcGoMjqh2hI4gBsUgUfa7xAd1HCc=;
        b=PXI0KHP7obUQuLBkzSNbOiqwVoPN5nWJp2F6BtOWFXgRWXCTnbz+cLg9WAW1xKCQFX
         MoTaIiGvD9fr1nYvDdQlV+YGbkpSBvKpjSusxzJLZoaC8UD/Gq20lOQ/3J9OHxemUADZ
         M2e+9EJ4c7tFrZ1MsQOXZJHYMnlQq3i1Hi0v2t2FRRyg3TcFHjyT67A4lHVCchc824f1
         KnUfN4NQUKNPW4T02gVk2mdmRFJT6EvpRYxOHvZj8IqN6d7i7dgnoNn6z5gWID7nCVOl
         J9D0Ng2yazKGN9mWskZQ3o7DvdUy9NZdyqiyIfHejPVeuW8P4Ydu0MrMB9EHXoTU0tUI
         pOKw==
X-Forwarded-Encrypted: i=1; AJvYcCWwSxUUG/l+NFgjqd1CrK6ip/M64BpDPP2za8johrWGD0zKQNK+T01HgspLqZWKxPUG4xw2OS435JSApuEhAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHpsmgFIDpYYcJGpKj6Hvi1Efc/tgRZZN2m/0xjQnjD9Sn2hO
	KVdFDP7U/mqe8XXMG8gJTA9V6C4p+Mc3lZoYUjnbeneuoMtw5IQ0wSo+GBqP0nzfedo9RK1TTFD
	SqtY8qq7wPdj9HdRkknJiOW02YsWrA+dnNIDC3hntXVFA0RvlMaa0JddbVCfIhZLciBibYw==
X-Gm-Gg: AY/fxX5EB23T4ubGHWPnfo6GpGMitATpKqBiKBKWX3TXrOrS3bsO4eoPEkbx7DTimlT
	oY+PNFuQ+b+mkPv6aJofTjjY553wbcDevTtq/DXEFbeh4V6SikbZjXxVSxneiaLD18xO0cMQEW5
	HMBCOZTuubeMT7gMs3esFSF3hWvs6+/dv2HGr698cUi4dQbhj3qEdyYQuw5I1ASI9apdDFuQIys
	9UFIlvsd/FpsVVu6gwrRnEjOGvZAlsgSYphbVMnGg1P9eABFmwiKS63+LdufLZVYteCISUAHtyn
	G8QbXG2nwYK3LJoRCIWXus5Y5Gf7+jgoK0RI3z5X26250+B8Wp+gnT7qbWXesC+HooBwf3u6HqI
	KnQIhH30nGTc3RQ8mfXJhI4uO50GmBby5nCn/ZACtU3WSt6PCbWeLlFw=
X-Received: by 2002:a17:903:1247:b0:29e:990f:26fc with SMTP id d9443c01a7336-2a3ee4e83bamr170127775ad.34.1768287610720;
        Mon, 12 Jan 2026 23:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoBvHv5GkG1uqzqiAt0OKhlGVz7jlfGMEmjPek3NHMbLzWn9trU/s+03Gg1FjnduZCdWlX+A==
X-Received: by 2002:a17:903:1247:b0:29e:990f:26fc with SMTP id d9443c01a7336-2a3ee4e83bamr170127425ad.34.1768287610214;
        Mon, 12 Jan 2026 23:00:10 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8920sm190721945ad.85.2026.01.12.23.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:00:09 -0800 (PST)
Message-ID: <56c6471b-c878-4afd-8e8e-d56266ca9c64@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 12:30:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YZ9lo4V_mWjaOHwqJoc_caAi7K3BB0BE
X-Authority-Analysis: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=6965ed7b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=awC6CiPvetVZCStm32EA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: YZ9lo4V_mWjaOHwqJoc_caAi7K3BB0BE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NiBTYWx0ZWRfX6+im4hE+2VHx
 DDoR/hHDoEN52dt/NAnqA3SofY8t+RzARd/m9F8xe8mUaOb5Tn9WibXY5yV+ZWA9QoAy136rl49
 I74kT/gsg1D28rOot/wlXxg1iP9WCJkeasW56QoD047qqApu7xp7PexD/Vfx+i4BYv8y9DH5u26
 IHNm7WaVCbwdK2hSRQlncya9IslxSGKQbIk4aucFmlWHSU31YGiJ3NOLg//06bXaj+occLp8r9E
 hAR4BVV3SNi5QsTqpbYxNN3Nww4u7yZhVNKL5n+aE+CXZ0C3srZyrkLEkfiAtMLya0BtuWvgoUG
 sHUeNxVyuLmUMofYsMzTyAq1bbZ3wwmgnkZymnL9YRJtkDxLQ0tasTEMYjcKjAtPKBC5FhhZ2Fl
 BZNtBckOsa5jba6q/2zBAEM2Uhp+2d/Fmt6VIj8e32eOVzuKcUnMwb9IzArpThZT69RTDLvdM4d
 nMyrkkL07P9JpjURJdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130056



On 12/28/2025 8:44 PM, Alexandru Gagniuc wrote:
> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> is initialized in, core.c, a different file than the array. This
> spaghetti-like relation is fragile and not obvious. Accidentally
> setting ".max_tx_ring" too high leads to a hard to track out-of-
> bounds access and memory corruption.
> 
> There is a small ambiguity on the meaning of "max_tx_ring":
>   - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
>   - The highest number to use for array indexing (there are 3 rings)
> 
> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
> instead of #defines to initialize the length field.
> 
> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
> so use a constant to express the correct value. Add a static_assert()
> to fail compilation if the constant is accidentally set too high.

Text related to static_assert to be removed accordingly.

> 
> The intent is to make the code easier to understand rather than fix
> an existing bug.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

With the above minor comment addressed.

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

