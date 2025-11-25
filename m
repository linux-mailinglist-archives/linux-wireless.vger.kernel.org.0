Return-Path: <linux-wireless+bounces-29343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD9C86076
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C934D445
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CF2248A5;
	Tue, 25 Nov 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkyrtaWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaOs8DyH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122341B4F09
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089287; cv=none; b=NlxIRBaCp9awfejoajSuOjjde7A3MloMF+rUfSqOWcY5ekjMq9osgO7iaK/GvoGnC0+M7EGqQv9PMB2q8PofcbMjGaDDOKzOcVtbRAPFPdiYDZoQ+9Yn8EOQcCSLbX8mHzLUatnhvKt+oLFpkl7GZG9WWoU8Bw/Ew0u2NKaiDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089287; c=relaxed/simple;
	bh=r2DFfPpZ2i3kDSKtZaDOyK+wMS9Iax66aLaU3RTMlmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=seJf2YYBStE4w3rTEwvH/KCqS1lMS472XcXw2ivetuCYUV9JfMYkSJ84CC6zDDI60OlXchZ6Ao2ZiOOFcfzbdJuD8e+uLVRDbFBl3BufpJ/A9YsfO7lXDFTmlvanvHOjV0e9+D0HFPxlJ05ji6cURGiNqXMJnTviATuXlDlCKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkyrtaWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaOs8DyH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APF7ouK2726963
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 16:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=; b=NkyrtaWKHf3BksNV
	co4/ZHHxJhVoEF38sLym/5hqSiUzlEvODNp1Htw0MyKx51h6lriWRYpdBaNEA9qw
	qfAPLZDkTcLFO00YMIH0tIMpdSyrkTxBQAAc66UZ+9SvkA66g0+Hlmg5F5CVOac4
	5bwA9HAMGUrTmK4xG5HdZM6gGdOzReCNKyUrldKOkFMgz5O277T5Vqo0K1ZEjHvF
	OZfMJSSk03Cn0ha/HI52HePRwh84J7R3/QhqJ6cMVyxVrylbjdEQ+sNv4uPpsRxb
	+x2OIswkstWjmFDvPLSRPD63e1DcGNxoh+YaKvth9MM9Fg4lLJ0OIB3WngbfZyIX
	DqJUHg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4an8rvsjun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 16:48:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7c7957d978aso2630983b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764089284; x=1764694084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=;
        b=QaOs8DyHAjFwWRdc61RTtjiKeTwfr4Mr5AdaZf7YTHc8YwdxHqkgqPmITdjkE2irHg
         TBMLDo9QOkubcwXmPZ2MnBqS5dDJRepGV7imKp6Hgu4Yr7BsRE9/DsWbVz0batYAszay
         nSqpTKFGP+L4CAJoRHhIXhQjdPyqcA4G1A55c83jICAu1SV5IFgNb9/AjNEKKBC/STSp
         ECxXi6i1UeFlaJkMWjlRoysdQsVq4I7Ekx6r1fW/OSVrYOE6b0aC/UO83wNwDeZtHvoh
         CfCuxmY/9DjL2jQQ9FEQNDYEdggt80vcunCXel3QYh6HbjYjB4Nc93vQpyl1yNVOjFSD
         vYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089284; x=1764694084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=;
        b=fEKszogs0hbUwWyOBnTQy2Y8fPaT6t0SYrIl3cXUOL7px2kxhNFp6VASRFQQQJHkrL
         e9NLuDWZVg95uOeMBYv9/y+MBfS1LHFSc7rFgAZdUGycXBjOzd93tzkUhDGSWlUWwDiu
         fWha57svunQcVnyDTr4TYy1oHy2F+Ltubd5BGM+6wgyKtEbZdyZVE7xOawn42L3E7aH2
         MMzk93kYLHgf6hahDgVFQTZKu1q6YJ5nOGTEqYN6qexh2vQH1K2Um7TooEUqQ58TgT/+
         wnjAQTwwQOed9q0mqmO/0GBnn64oUXoBxGpV4dGj/8uLBhFpVWH6QnSKLLwjqOfEaL5C
         ymuw==
X-Gm-Message-State: AOJu0YyhL/hZ3hQ8mHOf/+YWZZG8xs/MnIM7KwnMRsphlKOE38q2rNmU
	f0EOx0XgxGHnlIhRBwVU12Tf9sWujOy7kEBfkZ1QOiVi0bqvRHWlA6NXoViF2V483mISOC6L+ld
	+F8wziewYeR2wVIZ0Os0rJuM0CCiJwpT/7nh0EOeOVB+m0ddn3yh3/su2s5DPMQadeJZyRw==
X-Gm-Gg: ASbGncs90t8kSHSOtLYbF+r8S3kH0uI+DJI13h6odxYndwGkeKavp4OyWx8HeUsoExr
	3VJTtpO7p0v+DzP6cNIk4XqCl6e5fktE/j/tIe7CAaLMfJdEGcFjCnxqb3vvwX8OquOT/8R2mll
	wOdmfWEesW7jB/FOaw1BzFQqqiPppWKJTOWaFL25xCA/cbF9J7dpckKDvKKiFXuCsa6GJ+pRzgh
	vq5Wv9R4YrkvbaUiP/U5HGUrawzNKxpDCvLMWeuXaTRgN68/lw+6H6YpuWFBUjshDbrNd4NS7Gp
	PPHLw04X6z5vRHxMKxF1q2VB+AHxqXW0V7OjfgQSKtdyOO8z+jyRWXzI7uxKIgx+IamsfgYEB9G
	ivMpp2M7gP7eh+vnFQuvkw2oz9JtD0CDjge8rzt4GXdW7GjfJeOaYHcFuBcIYZDtVVMY83w==
X-Received: by 2002:a05:6a21:3399:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-36150ef8195mr16032891637.32.1764089283762;
        Tue, 25 Nov 2025 08:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPShcOIsEaNc3uW4NqPkq5KubUsXBKSz0C3elunNAPNo63sqiGW9+gfV1cqdAWum0P0h9A5Q==
X-Received: by 2002:a05:6a21:3399:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-36150ef8195mr16032862637.32.1764089283269;
        Tue, 25 Nov 2025 08:48:03 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm18841191b3a.55.2025.11.25.08.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:48:02 -0800 (PST)
Message-ID: <9627ce3e-9744-4250-9e6b-708771343c89@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 08:48:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-11-20
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20251120085433.8601-3-johannes@sipsolutions.net>
 <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XRbpC_pmkUlrbGSohGzGMZH02XbE1uqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE0MCBTYWx0ZWRfXxRhGtLsBs7wB
 pLoVPN5i92zK1JKXxDg8LJF21vyHUMQMZLNKdp6shT7Fnf1MrhFTpAdoXfueGFKs6sfRkZwP9wC
 s5gppupyoVIsNbxYOHNnD1+J/tLr0NWHqpjeNR9jPZ6tqV/60eTrRIlXrp4gWEPm+Iy5pqmPare
 RYbm+Xd3cC+6IoALaSQcAqsdkrE7HGWEZEAOwb2htirxJ9QYxxSpZmshD3mBzEvfa0ln/DfG1lx
 bthmy4TucBeZ63J71NYyk7+8GjBh6ERZmIzU6z1urNahiN73Qzd3dRidFpmxRT/NL5cM1fa7uyb
 qXhCyGuo34Q/5hs2TPyz6Q2LQas/cum4WqnCPfhj7c0WogTgfi8heqT0WWNSqnskFVb3xk8QLto
 E+DPwwlMStdsMU/awZsr+PZ7Q/8eAA==
X-Proofpoint-GUID: XRbpC_pmkUlrbGSohGzGMZH02XbE1uqz
X-Authority-Analysis: v=2.4 cv=Ushu9uwB c=1 sm=1 tr=0 ts=6925ddc4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9x0bo0beFLz6AYJxxT0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250140

On 11/20/2025 10:05 AM, Jeff Johnson wrote:
> On 11/20/2025 12:53 AM, Johannes Berg wrote:
>> Hi,
>>
>> Looks like things are quieting down, I fear maybe _too_ quiet
>> since we only have a single fix for rtw89 scanning.
> 
> Isn't that the way it is supposed to be heading into -rc7?
> :)
> 
> BTW internally we're finalizing the ath12k-ng => ath-next merge.
> It's a non-trivial merge of around 100 patches on top of around 60 patches
> since the branch point.
> 
> Current goal is get it to you next week for the v6.19 merge window.

Update: We are still validating the merged code and hence we will not be
issuing a pull request for v6.19 merge window.

/jeff

