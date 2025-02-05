Return-Path: <linux-wireless+bounces-18539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4142A28E2E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A357A3FCB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20614A088;
	Wed,  5 Feb 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsbWZ5t7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AE1494DF
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764597; cv=none; b=r2euCu/eL47GWv2NKoji38ArsEYvuudxmfQXr2RSJ5AbIHAkHHQRQcknuaPmVym2kZYcgzKR48LK9lqZ843aWclohfOYPCl4cGfxnAnIgk84gKWDkUgTKtDcLOY25rCsjyxCWevcgZ9sHoY4CS6mOek9f5We5b8lhY2DKnPDFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764597; c=relaxed/simple;
	bh=ELmu31UuOp7Jf8KIRvMw0zed7+2IwMJ+t0XkXdIcNj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFhTPwfqqxMgCl2OsHsQuwzMgVm3klYb6c4l9oYBNrHcpksxwYEK5O3rRa2qW65yDe5ywlQhHVyGXc+6H04x1Tcj9GWhdUR69IRW5Vz3NfC0bhiIBkU3q/zH9eefWkwRRB78ul/bi/IFecjUmSkgC7QJozonAsazzw3CUzD9F6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsbWZ5t7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515678WA029516
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 14:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7w3JP/cVcIEQr/swGtrAUB5rPEohaiFbEvSqpR+lohc=; b=XsbWZ5t7gLN1iOlh
	zhpC7Yl5Hxox1Raeoi1jS+a8dhUYhNxMqrWby2kBtItE73Ex/WW87zxRt/WdDehR
	BrwKvEkQsvOND4QtHgGNDvmFcbHYkLVfLgt9hGCO7002aN5Ml4mJ7+tZunJFP0cV
	XGC06RFYtfZfeWXemjX2U4dHw4Kh/pAJkfUS8BzzpxlFagODOX6q///MvZY8GT0z
	P6McwJPzyiaZo6hotZhiqmvJhYLXOFx8VvbbAnJn3EUhzMhpOH9YoxQbW2JgewNy
	7VhtItGQSdVdu+rlJcCML3v5Wi43ffZf1/NZW7cT9vWb5JAGLj957qObufjRj3up
	0yuZPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m2ea13c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 14:09:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f20211df2so9006725ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 06:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738764593; x=1739369393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w3JP/cVcIEQr/swGtrAUB5rPEohaiFbEvSqpR+lohc=;
        b=IX8QcIbhVwfvrRLDXtNIAXuyiC2OirSKKvTgFhhBqCFYMHEcdXlHT63avzePkazbNi
         XDTEpzE4w22ELxB4aXMkfVeQguZAhZ9LFGJrc3bLwDDGf8894r5KqnbSfP5wSE6Q+aos
         yuTtalU+HFQNb7Wls7Ov/L7v+0qdTDMsbpHRJvsqOBsLo8PrKk+jOTmmap0Xclc8zLWy
         0TRPZKurqj1e/DQZYg1P+L59x3LMnb2h9b/F6HppG7Kf9HC8KEie5NSLwYbfc0Z6O03o
         xs2bx1yfYUQHVJyyXsmtkgQQh5MXTRgqYQhMw4ELsFHUBuixc52faZLII8BF84H+a/LL
         nUog==
X-Gm-Message-State: AOJu0Ywkj5XilanMQmF/up8l49ab9Y1n+zilWsiPxi/CI8zdJOuzHGgY
	BhJMXCxey6JkqaWdbjHaQ5Df4Lk+s14rPQ6/mOGf4ZDtO03APFlIpCiPcPtXxbDm5uWeDUta38y
	Sfp8mhMURCUhp9y8AVfuCVm6F76WsiFehpmjHfMPqiD5iC6JrbHKl88Pu2tgJmuKoDQ==
X-Gm-Gg: ASbGncsMkJ0rS00ovNQoq30GHLxlQgfqyTKBxHsvf6Ug3vaxjfg06UXTvkR0zbMKt+f
	ldmgGUVyT5xo97W8KBy9mV/jaaK990fuC7bh7OM9Y8ES6ERZoTAJIxXQ6xgIXkXb5a1tRS72qKz
	aoz7/pGqBa6ZKWGM8E8HFPy0Wawj9Pa6N4z2YWxXWu5DpgDf9seo/xzmkqPo8Oh3sXK3a7VKWlE
	igSXng2WHdC++XuBF+K6u1R0/eRFukIBISzJiYsDxeSjMxzOVCAedaHEf0ujazKaJi9aOVAGaZn
	HVPgBlteQxYnq3HVXCHgYnA2ooltd26ghDK/61O/P7pdnG+PONsn
X-Received: by 2002:a17:903:1cd:b0:21f:1521:42f with SMTP id d9443c01a7336-21f17f2a696mr48122825ad.53.1738764593466;
        Wed, 05 Feb 2025 06:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbeFDdmyITBvXL2yRLiW9RtO0gymcSkv40yDdn04oMY3HCR8afEkO7vTit6UHSub9bSjzYTQ==
X-Received: by 2002:a17:903:1cd:b0:21f:1521:42f with SMTP id d9443c01a7336-21f17f2a696mr48122475ad.53.1738764593072;
        Wed, 05 Feb 2025 06:09:53 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f052bc69csm33220165ad.183.2025.02.05.06.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 06:09:52 -0800 (PST)
Message-ID: <c1a8143f-4b5c-e6a7-c1a8-b294b369ce39@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 19:39:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] wifi: ath12k: relocate a few functions in mac.c
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v2-6-764fb5973c1a@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-6-764fb5973c1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UrUQV3Ci26Eix5om1ePZsZk4Ewsvz9Zc
X-Proofpoint-GUID: UrUQV3Ci26Eix5om1ePZsZk4Ewsvz9Zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=654 impostorscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050112



On 2/4/2025 10:35 PM, Aditya Kumar Singh wrote:
> An upcoming change will invoke ath12k_mac_init_arvif(),
> ath12k_mac_assign_link_vif(), ath12k_mac_unassign_link_vif(), and
> ath12k_mac_remove_link_interface() from a line located above their current
> definition. Hence, relocate these functions to above so that these can be
> invoked later on.
> 
> No functionality changes. Compile tested only.
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

