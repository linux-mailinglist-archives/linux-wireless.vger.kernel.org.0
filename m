Return-Path: <linux-wireless+bounces-25430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC739B04E79
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E93B4CF9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6819DF4F;
	Tue, 15 Jul 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVk1xmge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FC18DB1A
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548640; cv=none; b=A/QAv8RaZz7ZBQ5K/YeKt4hZdXGu1nQ0NvYrwvJhrRQEE7FhkOycUEf5CgqNZzTQZOtaztSLYg4SslBIdK0OYXPgv4+YRYGaS+kAPau4ikcsAbkfFkWt4mJkJ3dyEQMn4+t58joofmJ2453Mp54eghAgFoYNSDWLVS6kQpnwyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548640; c=relaxed/simple;
	bh=1ilVfC+jxYYA3Y60yLlL4D+iquYBjKNl6CBbmWcaCWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teQVhBL0WDKH+A2N7AuEROy1hKzOBrXq1tyIm0LhrBAdBCa0yp/KqGmc3UKFqpOnW7PI4xm0LmGFbvLusENOm6xMXmQQi8dLtDzgXMjv4b+qqyNX5/rQSE1owt14pIp7oZZEuZ/lpLtYBZ4B7w3AyPILew/byVUZGuvWTGL+PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVk1xmge; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRcJF029642
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4DTCGRhIs1G8ZriYF+cftr7+2fBBpADwLLPYQcSjDfQ=; b=iVk1xmgevH0Cd481
	uiwcu9F9DZWyYT8EnqDaMDUEmqdnZ0zbnBzJa9WuNJhdf133S9JjXAWPtq62YDNc
	esNxyY0bsOuH5NOAc/uc4P5Kd5crdAKQ7WuSHbRRY+tqaMfCHBV5mbX8jxCBPyx2
	939zEAKOzKMIHVn3y1q2MWvwljD85Uky5e3+mu9uWXJtM3D4ELCrlBlLAw/My/EI
	822NEp0N1+FFee3YfhyQ4lw4ysC17GnFB38OzbZrt+5MePerlYgALIOe8lFe8Z8P
	l/MmUQgY5HNJs7sdKyuMXTDrV9FEfV0oYmjYWrWD0CFiiYAxjtT1Xh1biX/zSzqo
	mxtlig==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dq1cc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:03:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso8360855a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 20:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752548637; x=1753153437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DTCGRhIs1G8ZriYF+cftr7+2fBBpADwLLPYQcSjDfQ=;
        b=FlVvGeHaSBBz0GjHr9jrPZzjB3xy4yG0fyTjBWkbgW7NVZqkG3FtPve2vlLiGkA2lx
         et8LPb+SvnKR1u/reiqNQvMqJolIQwFEp12A6Z5jTrNzFl1iJWPfRD6a5UKl5Tmtisuk
         rjuS2QIj9BGNYSPZ/Pe/YFz3tyFkbczZn7mlEJVJgFo4A8fezNntYIQ65SUwEkemKZx4
         Pn68mRPHOs7H73bWWa+oLdruoHFekkDLKANw9TccVCU9DenH4d647LMm4y7UEcwwiqMl
         /HffGn5Q2KiTkHDeKK2bLP5YpAuruZoPcElxPN55WXgNZGu/+dqiCATl5lQYbSEmXdor
         3QRA==
X-Gm-Message-State: AOJu0YyAT4FcFDdTmpkn1qZZ/eTcz0gX8h1/5e6plRKIbUCosSUAlUqh
	ZRD1iB/Lp8WYzoYQl/j7OBWph6Cg/p+S0tSjyIAsWNnVfkfaRd7qGLzT6dzSXNjLFHalx7vG9xJ
	lmDRGCnbBNBRTlvvQwPB8qD4ij3uiBFQofZgoW/3O6dXCViIAgvMGOXBcIL3KlxS9A0Ek6A==
X-Gm-Gg: ASbGncu6Z8TtnMpAzmL/wWryCsAFw62D/onRsk3FpBK8Vx3WQC6EWJU+vtsjVjRvZsR
	ZYFdJ3DezpRDBuP7qkMOoqgpNhkE/22YHmbuabwVNXW9T7t/wiVrlHFQ2IX6SAj2698pk4xPgvg
	oa/0s0EsT3fA1dlHE8+gZGm9qBHitRvVb92UsE9NGK/GH94dD0L269vtBJudfxBpn/eoK8GbsRu
	r6SSCWLO4HOUfXFIdAYb7bbz/b8TlxqsRLMfhn2M0InMTV7NKg6/Nppq4C0NH6h9ruQUpVmT8y5
	xoNFDgVQs6RedoMnp65gFcgDKlMHG5VQ5LuV7Yu/JZepsu8JBoRWO6dOmpEGHoWliiz2lk5DiPo
	jHhwWqYmFDo3a
X-Received: by 2002:a17:90b:4a81:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-31c4ccd89b4mr28714302a91.18.1752548636980;
        Mon, 14 Jul 2025 20:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQk8UV8Z7wa/o8AdX75PKgIiy/izrir0RGwfamCQ4qVyHT6O7Nc98rChTuodHQMpHEAso/tQ==
X-Received: by 2002:a17:90b:4a81:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-31c4ccd89b4mr28714258a91.18.1752548636521;
        Mon, 14 Jul 2025 20:03:56 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.226.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb45d1asm11017676a91.30.2025.07.14.20.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 20:03:56 -0700 (PDT)
Message-ID: <36d25bdb-e0b6-e55a-4060-e7cdcfeb6417@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 08:33:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Validate peer_id before
 searching for peer
Content-Language: en-US
To: Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250714111438.1134438-1-nagarajan.maran@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250714111438.1134438-1-nagarajan.maran@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAyNyBTYWx0ZWRfX18cgV7cgnW+R
 5tF0ei8SStUTYAwgahU1wH5oKU/YEl2a4csdoasgl3NvRaRcdl4U5R826IDgJ8PD2X3SWJSHK25
 sn53mj+yO9g0hbbGAB5nsNVRMzaIjrjuVtsZ+HMIGJNb7jw8oBVcufwqSIzdWRBzXqUNqd3yG93
 ng0QfqCo/4WY4nJi91wgt7OSjrST7Vmx5kY59fyOYnuO7VPR4FIbj0vQ2NZOj4MP6/zBwq/54+5
 +Stb7I++4dkSn8cC8DGZw8NRg0cizHERAVvEarcXr0uqCRo+xZhvQm25CExVSUv5H9d90MgKwC2
 0TZkBH650b264wNNt7aBRqpj8b8ym4Gfq+OOVOyX0q3I6vHqHQTWj8q0y6VvZCXT3FQ+0Y2ovk2
 U3xI3T1P5nAPW6P6YzmpCkYSUEAM8yW/NaRMivF8FJkZ+p4Hy757PlFunqJsRQ6KoRZCL36X
X-Proofpoint-ORIG-GUID: z7HHgWNYm0prUqUBTXNfE8nq26TfUPoG
X-Proofpoint-GUID: z7HHgWNYm0prUqUBTXNfE8nq26TfUPoG
X-Authority-Analysis: v=2.4 cv=MpZS63ae c=1 sm=1 tr=0 ts=6875c51e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=bFupCVmCsjxzjGptNxIE4g==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=o3kOZhjVV3aoIho8ZNQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=598 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150027



On 7/14/2025 4:44 PM, Nagarajan Maran wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> In RX WBM error path, error packet is received with invalid
> peer_id (0x3FFF) as there is no peer associated with that packet.
> However, this invalid peer_id coincides with the ML peer_id valid
> bit mask, causing an unnecessary search in the ML peer list.
> 
> Prevent searching the peer list for invalid peer_id and return NULL.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

