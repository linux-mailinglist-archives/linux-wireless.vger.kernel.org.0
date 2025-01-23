Return-Path: <linux-wireless+bounces-17851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA4A19CC3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 03:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645F216D07F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC38F5A;
	Thu, 23 Jan 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CH+Z1dLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31072914
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597757; cv=none; b=lvQ8kGKEDAn4mMPIirrFC9BF+O6Amc+suNU1xTkdqjf0C2H5UFtd5istCqIajsKWqi+/XEhH/gkYwLpMoKF4WCREZPseKVqr5bON40of0T23MHnl3hzinXpQD+97g1hdwY8OEV/q90PcdLQ8QLpcXu86Gn1qHoe+YkdWYSkNQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597757; c=relaxed/simple;
	bh=0gkleLFR/1D6HPaOYGgzpjWg1DsyMbHNENf+5uGU4tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAYIMIkWJHzn5mHwu/okmGSioi9JRGvtVDu+X650t68PQqZmkMblgAL7uxzg90Y3dhV25CbeSIEDFvr0RUiDGGPUtVW5aJM4nqqdXHfKwX+vPmfDKZPeh6Hz9XoTzH6AdEaqg8DLXpAU5c+o8/cCRj9J1nhORxDMkKVQyx1YaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CH+Z1dLl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKEfrv004149
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 02:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sum5fgR6OpNWoyvX8DEoAFERZAA1eFid0RKeK/7stKY=; b=CH+Z1dLlxWYYjDYk
	BmDiZahL75ZU+vTv86D1lLiUbeifzb/IsDlA22OSW2nsrKXTwHb0ptBSRHZ8q1Ol
	qZJw8oPgNQ1YyuX2BrQRFiIrW6CYwnRKRJIXoMW9btN7efqGkUtxmqM839N78o1e
	an6fRnhEE5ApkLMmGxSxPtYMDwQng7wmV1oDe9j0kaKf23iwMmNiyyVjk31m/Htp
	Z02PbFfkU12EFx4fHpK0uQDj3X9wmHn5dFfb8nEDcLqiCXbYbSFkOHzG+LxzZxrn
	GFbRbkUbiEVmNzVJpVdoKFs6WBJ9KT68F2dKaWCnF4F/neM6IVAX3JA4lksk0q02
	QXREoA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b7ht0hst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 02:02:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso1399963a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737597753; x=1738202553;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sum5fgR6OpNWoyvX8DEoAFERZAA1eFid0RKeK/7stKY=;
        b=Bj3oNWilHwVotXXPnimp9/Q1LMo+3mwDvmtUz+cI8w/8nuYgjmr7f54QWrLhzThqvz
         1Bjp4hyTzJj91krnYlV5yy9MK6zRpveHo9fEI5qIngCTWcSfCZjPHw11KRySF4OYkqi5
         BkVjeRD1QC2x6rP8vsl1oPsREeILfZxASNxMZU/fp/LB7tPBv0kvvsDcJEIPKOQckgNB
         q8hF9EevbHGwRqdAGguBqNPhH0WE9i0WAAH+OUj5/ezVZ0UMMHCdJCafISkczJI3nEVQ
         AKWgu19ziMtx4S/W0m4rM70SJ5xy8AWMOZBxLuaUH9hV1TkLP8o3PxrLX8Jr1d/UWJfZ
         5o/Q==
X-Gm-Message-State: AOJu0Yx929kuchIRGC/GMVhy5osT1DJ5gXSxNk4Oi4eEP+NxlzOKanbR
	tpn1K8ea1pcCrPKXOEGwZgZ+1eIllcEicYUJWcxxgz1JY5qgE6LJqL1Q5IhS2qLJ8wgUx7Ti2uY
	CrGeK6xzjLnJcThwTUfoTrBz1rglHdibkVHHo7ZOy4GZr+fBrzxDypqta862sMYJd/g==
X-Gm-Gg: ASbGncs7gueWEOeLzMphxhgmP6MUeTJVXyTqtMUbtsI2qqRm8cLbI43rWxx2oj05BED
	KN1JU3ZlfTW/kNzGXB5xEbSkopNLXzZiyJmfJfvtg8xwK6arg34VDaa6mlU+1BUy+RPI6s2N2P7
	D5sQTE+Jcxiva57v87WFJDoOQSVwpGq92jY5OPs3OUVBJf7w+pEUkFHixtUwxK53zSf4FQ5TCsB
	ew2ZUdCHaE7StzFbb0Mzx0QlxQ3zGNwDxbj8ZsURagNu53aA+xqP1Oujm4KC58RJJsIFsvuPysw
	E2qfwUJrvorVFVdT0OwFQ3gKG6y+cQ==
X-Received: by 2002:a05:6a00:2914:b0:71e:4cff:2654 with SMTP id d2e1a72fcca58-72dafa00359mr31853699b3a.6.1737597753162;
        Wed, 22 Jan 2025 18:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgGU1iRGLTErvAyBaR1wlc4UEidp0zwgMDhEU+8PpT9dNMb4yjR4dH5UP+IOSgM/NizIjeOA==
X-Received: by 2002:a05:6a00:2914:b0:71e:4cff:2654 with SMTP id d2e1a72fcca58-72dafa00359mr31853659b3a.6.1737597752756;
        Wed, 22 Jan 2025 18:02:32 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab845d25sm11718420b3a.77.2025.01.22.18.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 18:02:32 -0800 (PST)
Message-ID: <dc9eafbb-1891-4e88-b9ad-0ed40342db6a@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 07:32:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error
 path
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250122160112.3234558-1-nico.escande@gmail.com>
 <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
 <d0dfce80-3e57-4efe-8552-b18bae9e9437@oss.qualcomm.com>
 <c6b65bee-3680-4e54-9d7a-2b582461cc73@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c6b65bee-3680-4e54-9d7a-2b582461cc73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wvgvlaBkZB5TSwilJpEcpMOrO8-wUteL
X-Proofpoint-GUID: wvgvlaBkZB5TSwilJpEcpMOrO8-wUteL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_11,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=886
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230014

On 1/23/25 01:49, Jeff Johnson wrote:
> On 1/22/2025 10:20 AM, Jeff Johnson wrote:
>> On 1/22/2025 8:46 AM, Aditya Kumar Singh wrote:
>>> On 1/22/25 21:31, Nicolas Escande wrote:
>>>> When vlan support was added, we missed that when
>>>> ath12k_dp_prepare_htt_metadata returns an error we also need to free the
>>>
>>> nit: Always refer function name with () for clarity.
>>>
>>>> skb holding the metadata before going on with the cleanup process.
>>>> Compile tested only.
>>>>
>>>> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
>>>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>>>> ---
>>>
>>> If there's going to be a new version please take care of above nit
>>> comment. Otherwise -
>>>
>>> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>>>
>>>
>>
>> I'll fixup () in both subject and description
> 
> fixup in pending:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=29d6569f323a88ccb3239abea562f6e691cfd9e4

Looks good.

-- 
Aditya

