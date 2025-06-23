Return-Path: <linux-wireless+bounces-24338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07267AE34B2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C66B16FD19
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DD1CCB4B;
	Mon, 23 Jun 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TownxR+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5A7261A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656080; cv=none; b=CIDdoCxgQOWluRfcI1ZpldjcAav5aSCTU54RLvSi71VKCcT3sle9tUtba6RJn9Do5tYRgnHXBiItpAI8h9dsTuQAINVS+0AxuFGKwThW6fPTMiIC96l/tkGxjXl5QPw2nJshN6m8sxBynHSwiMpZDHhDXBA3RdCE/PUbXb87K3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656080; c=relaxed/simple;
	bh=DIfUU6HEAalsVnlWwF6xRido4ZwXWk6Y8RNH2/T4heg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsY07R+P9+kZbg7zquF6Y9CLNH+Q7z/gvmtkzBFaQ7+WzxTy97jH8AYqsyKAXgwEiSrFmeSSsBREDNLSLXkn4Dvf/F1XVcNuu6lsem989rWwXWMDO/e7Exs9BoMEhWrk1UWRbp5e3pL3cfk7Wv9yketNbDukYU9bwEZ7757VLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TownxR+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N3eVUE029883
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJaUpKWaloU/fOL7e/dgz5PF5xRAJF3ZohSH7tC3q8o=; b=TownxR+uzJuqqY22
	KoYUnXvx8s+YZ/yUUriG9339Eb3p/1eyAHQVikqRlU7uZRzzW44XI732s2ouzWw2
	tYWef19edun8URilL1g2xE0izHw4DsA1jjjwKRwcAv/z2fBTkH6VWOFSiYhWglb9
	Pzo5zBurDSCljsmldDyb2OjoinnGpmeH/VywkkHmMwTDlwGO9OiCfkTKdAWcohNM
	SFbEOqf9z9ucvXefHh/SZM/5lahrAvJX31VSaI80ZD1HrtTRjORs6n/S1QTWQpVV
	HrUjB6apVTGDGd6AelslDd68uv2rVtARtF55Wu10+xibS3p/bQFwGirPo2TOcZGJ
	nofbyg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ey7k05xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2272633a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750656074; x=1751260874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJaUpKWaloU/fOL7e/dgz5PF5xRAJF3ZohSH7tC3q8o=;
        b=qZROd4svC1N6ChnStH1qL9CHe83e3iQf76x862KziyIpAN8QcCkti58e10Q7hDz12u
         wKijMy0uZgLKQU9glA4EAZmP1n97jKg8+ej/Ua4ucoavMmfFRbzDKx6+Q9PNogzOxcJo
         XtZRHJpsVriJiZAZJjhcuFnqZ3L1N/5ooXnhCH80eYVd2dpWq4fENl3PijuKMEZTyXTE
         PNVXdj15Ivl+QLu1o3fzJM+FCB1Mm4fopj0rrnj8jcUjRxHHqXojg4SZeamSN2MVMgB0
         E7NzHIUacUblf/mQfkuiK5rHwjjvnny9vTZ96X5eL0uiD/tgEVuMGuh3ew6zGJaFeBwI
         Csgg==
X-Gm-Message-State: AOJu0Yx64rdOx9kVwJaAUhgs2Vtx84y2x+P2FxDuqIhyG2v5jDc1Fb7T
	7mFTfwu+34iVzWzy5y9LMcb/CJTcNEuY5phOPaD/qgXrTcV19thJOwa16x6qowkbslUvt1rYUg0
	tMQ+C9FBM2IhayjH6JK+GLRP5uEw+tDIfYQ7OVp841iXMFS6oFNwRUkXYnYlZtMFmadNI8g==
X-Gm-Gg: ASbGncvPdD78XrPNpmtQYI2TiCDFe+Ct4/DUsUgBWfP2Cd2Z64xlvl2/jYOa+Z0/jwd
	q4wmL93izyiYHYlUaI+ddIkmkkNxOxljVO3U0ciV/NIk2Sp1NqGeTP+42p0bTK8SfDXsf9myzEm
	GiZ6j39x5IPh+gKC67eOQHqKu43IAJwuXTYA6kkylGZadWoYW4O4VVQfzQ7axHtos84MVgmiAmN
	ZmqLiDxZP/EA83ahYCCh3g4+85b9RW/YoCC7hFj2HfMxB7lhEzR8es+pSg2OpNveAG2HfsUtDrS
	CgBOkGqo7hGEYLO7jjmrF8Hll6w468EerkTsmBqe1vpKg39NSWa960ttATI/+Stk
X-Received: by 2002:a05:6a20:438c:b0:21f:62e7:cd08 with SMTP id adf61e73a8af0-22026d62492mr16734649637.8.1750656074025;
        Sun, 22 Jun 2025 22:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6sXlv3E9PXQKKHrhj7infmrUZxL1XGkkL3NJcuzzaEVBliA6CDYcfDWdSI/EDBJMpScx2g==
X-Received: by 2002:a05:6a20:438c:b0:21f:62e7:cd08 with SMTP id adf61e73a8af0-22026d62492mr16734626637.8.1750656073657;
        Sun, 22 Jun 2025 22:21:13 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b32075895f6sm4116924a12.21.2025.06.22.22.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:21:13 -0700 (PDT)
Message-ID: <aa9c4dfc-5b70-3893-73d8-ef590189f937@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 10:51:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 3/5] wifi: ath10k: Add missing include of
 export.h
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
 <20250611-ath-unused-export-v1-3-c36819df7e7b@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-3-c36819df7e7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YoEPR5YX c=1 sm=1 tr=0 ts=6858e44b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=U89tM0JWt6iRefauG40A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 43NwhrP9h4Ty0aG0_KFR2tGePqfGoC8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyOSBTYWx0ZWRfX5JZOsai3h+8z
 3u1azhzuH/0BoOq+vJ5Ewu00wgJnhMpN2LFrGoMVR8caPGst/dHuy1W6+gKVfgwDiIL1uQoAko3
 7kAYdBtYEaOaJCWnxkEK6C3t3ZUKIaDPhTRccc1yfG3a4QaxipAu+kPumGm8UvFKdJumrRivMh6
 NcIiDmDuocxMiaNybWi0kzPriUQaA80qsOGlNIXZxlo7Eycyvg2nJ+VP2E/5qjC43N/2GDu6w3W
 xonEB1VcZ03p76yeRa9jDhYyyc3T1M4DhFo7B8Wk16DRjkEDCdGFkp7u7oT/fH2Q2DF1u2IPdUx
 m6vg9+8/hgiZh7UVmvLN457D+IByYwLGVxb6c79FrHa0FSQGCdeBDpuq7Tkl90jGoXgPCFPI7ma
 sT00pCZinIw51elz9rF/wggmCFcIimFgRC3YpqI0pG76sDjXC7HsqnCtfCRb5dy/XCx8MVVC
X-Proofpoint-GUID: 43NwhrP9h4Ty0aG0_KFR2tGePqfGoC8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=922 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230029



On 6/11/2025 9:43 PM, Jeff Johnson wrote:
> Commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") introduced a new check that is producing
> the following warnings:
> 
> drivers/net/wireless/ath/ath10k/bmi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/ce.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/coredump.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/htc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/htt_rx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/htt_tx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/mac.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath10k/trace.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Add the missing #include to satisfy the check.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

