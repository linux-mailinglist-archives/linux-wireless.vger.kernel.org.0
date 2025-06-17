Return-Path: <linux-wireless+bounces-24220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BCADD87E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EE0189CEBB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F52264A5;
	Tue, 17 Jun 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nYz01sqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810A217F40
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178314; cv=none; b=VP8H6dB4nzSnV8lCoiHWeStZ+hUlE3AYqkUPGyBfDvPy/fbvNvIfrYITydvhL273QqTI15eKMlXjnwc2WF5T9U1SZf02L25j8UGbsy+yqX3xYIF4DUsOJ9jZg9WA29Hx0H2IrySkmf6uGjhHzTSDtFi17wG0T+/Dmrqby35p20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178314; c=relaxed/simple;
	bh=HpVc1Fpu52Pze28FQsu5z/A7YEOdWDg99rpihzG+m+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spn+pJ67JWsVefVQtD64dITUdNSE3PSRZl7sK+/zrejH5NREnephBMUiVx3/kFOsi5v646R3LjcQoDHa8C1m6EnpIPWTsNwj0mHMEWilJX4jqxX4GEcV17fwh4Crsjjng5y5SgJaTmi5+FdVtTzByfL0rndttqxxNKwjY2gFYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nYz01sqB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HDL91x020136
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+7OGmGpdvF+qEviVeVrWV/kac47I6U3U5/16oRtFhks=; b=nYz01sqBmekgo1M6
	yJn5/qrHHI9mpTrtoZq09qPOSYd/mCQ134McU6bzpzExB0z1rwcx46DMr5DIFH0D
	FtcVyfK4kNBdN+bvohUB9p/IuNayvAMYZPm3YR7u8KJBjQh6ND/O7yOjRxnaQ+uY
	ylyCJGYHc3n0LBkeElBgacnFMwAtNDhHlSvd7Q13TGC9ZoY8wCYqko31gNwKLo1H
	47smMC9D/430N8AyJCkwkYRcLSn8OVnQhcpCueChS3u6rhWMb8nTkUc0Zf3bPP//
	0AKmqla1pjnmNAvmRZcV6XgdOfV/j4eFuZ9hgS28IFZ8d0Vn7fs9T1gt9a3RUNuJ
	8QDCtA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5qpr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:38:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748764d84feso8086609b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 09:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178310; x=1750783110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7OGmGpdvF+qEviVeVrWV/kac47I6U3U5/16oRtFhks=;
        b=ptFGxpv8fBAW1u/yGdQB1CMRXePhviYZcjv45pC4aJg/RCP8DmiEXofSLS0FK4iI4m
         kUCHvji6IKXvPR7LesvtenuLQSDqZMi6RSWJXBtCTZ1eq0IjXGj0m1LP+cG9EWk43ZAc
         zCXHv9dRhIifynBh+MVXOxqT98Ec/4tpsUAOyZb8meF0jiljJfZXGiGaX5dGy3HFCiC+
         eveqkbhPjlLoS0Y6vB8FeMQX9x7KDWRKiIoA3FgNNsVg+YyeCIbm++tZmBPbOfvIgoVe
         2zy7lkgCQrTdQhzbocY2Aybhp00rWoHUrpCUoQ+bv9yqz8uFmc+o9V76l0KstgmUZ2kw
         hjLg==
X-Gm-Message-State: AOJu0YxCCBA5JN7nCTZh6+kRRLHYiLmzT3UFgQCIf8jyJJO+xh+MC/nU
	EfKunmHt+VBt5S3CiQLrLV6k7fNgoaXOnBXh7ISHiYsuAgsadcfrRdhxDHSNuFh1kBHJiO+qbvz
	XULrOxsI47Q8RK1rmAlF7hbl1rbRj57sVlB3mfyFFfJSuo2QWz33Qcb09eBZ7udNRfOhlMB5IxB
	lo0g==
X-Gm-Gg: ASbGncuK31c6ayEZEYPRLaUN+H61ZVpd101SoKY5v7B1m2uTwz8ri2ZAtv6qn4n+0xB
	xtXYxswG905SilVXXZw3Vjan/QzELQCQ9XXZDZam6IbEbjIeP/p9vkZZOBjFrzqGc9TzYRpQcqJ
	ruga4/Ijn+uOn9l3KtqWLVjBJkfJ2crVOhOdz9Cn05Glt+ikeyJdiq20FB12KuwsDAdZpfft5+e
	t28f6DSoNhYUSKON0OuaLFeXLi3qLP1rdGIF9Tqo513RMxUOWF795pCng6CZtVVAIBJ1IIYInmQ
	dvp+278k2SdC+xU4oAxSPqh0a/a/uL7faicXbYYlJ4pR2Vno+KAfI3M+1y3pQo2u6/YX53gZ8+x
	itgjAuHseTGiNv+g=
X-Received: by 2002:a05:6a00:14cd:b0:748:4652:bff4 with SMTP id d2e1a72fcca58-7489cfcb16amr18730436b3a.13.1750178310045;
        Tue, 17 Jun 2025 09:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2hu6ziKMb+46PhKkOTmrCbrON41+eSFTPnodVUx4lLRh4ASU8DKdDm3GLLpountd7Hx8Hrw==
X-Received: by 2002:a05:6a00:14cd:b0:748:4652:bff4 with SMTP id d2e1a72fcca58-7489cfcb16amr18730343b3a.13.1750178309523;
        Tue, 17 Jun 2025 09:38:29 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900074f1sm9388829b3a.67.2025.06.17.09.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:38:29 -0700 (PDT)
Message-ID: <527e2914-abd2-44cb-b2b1-5a6ed2792fc1@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 09:38:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Add support for transmit histogram
 stats
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250617042141.215540-1-quic_rdevanat@quicinc.com>
 <0c226bfb-6e0e-4569-89a1-9450cdc038d5@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <0c226bfb-6e0e-4569-89a1-9450cdc038d5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 74TuLjr8l49nnCH3mJA4wN5anI-ppg7k
X-Proofpoint-ORIG-GUID: 74TuLjr8l49nnCH3mJA4wN5anI-ppg7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEzMSBTYWx0ZWRfXxwBYFe9Tr2ck
 KDske0drBXLBkxBTnTGLqaqiKHlqXZ52Hr98C8eoliJ3TFFyqogtfUbs07v4NKBwiRtAipO6F8S
 Rw5Qz4ayfWQhGHgPC3HlGe//TrMBiCZNyJijpKuREqK7hmuUpxT/wDsv2DiUYdATwDpV/H7rD1w
 CbQOWLVHiC7HGtzBZPE7g4+q0uk9EFDfNCItgiVJYTHRYfk3I0hiskKSpLmfjLKgoi3zCz3T4X1
 vdwNxgJ4TNDc2/pFrEo01Go93RYsz4ZWOQkhyNm7Z71MSliGQAAPMgQiVCjnXZY4eCSqCtkFeUe
 r0phciZy4gKQ5ecS9UC4zd4ReDlLxID5Tt506EHq57C5Nv3oUHjNd9+f8IAQAEbV0wmgidqAVRe
 MyZwOHAmshF/XEEt4/N1I9Unz46fEvGfiZnL/FiUQn6ZA1due6OpLuZu7xJw4e1gFSujVT3B
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=68519a07 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=fErHcR0BBo8NarzEaYoA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=776 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170131

On 6/17/2025 4:15 AM, Roopni Devanathan wrote:
>> +static inline void
> 
> Please kindly ignore this patch, as there is 'inline' keyword usage in function
> definition. It is caught by wifibot and reported as error. I'll post a v2 of
> this patch with 'inline' keyword removed.

I've updated my workflow to check for this as well

