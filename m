Return-Path: <linux-wireless+bounces-30667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9CD105B3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 03:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670B630021D5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA72303CA0;
	Mon, 12 Jan 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5gzDsIq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gKO9Iyxc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE653043A2
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185361; cv=none; b=DtUGUrn07otbObCogCJad1CyytbuHlbFfSLbl+dw+T4cMF6+c7Eln3Ti36cE/RU27T6Sdpl52CGhatAT5AHDAi2/eE6gbXXSbUgXVg34AZXcrn8BEi5CArFiJ66KyJlrQ9W1WbvZcldonrfm6xUngcPX/8G3bqeMr1qy0yVlltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185361; c=relaxed/simple;
	bh=ZTph/gw1rlVbQkXc4dP5WnmvdAUhECUex2q1V+5pB/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrLXPwr/SbsMDLah6lT7/KYK8Z8ZsOvccLEUUmdkQKLNv0miHTR+XRUxn8nQLpVSUKWxduqjdJHVRDZ+8qEUN33WdhwJCfU7LmwTKEnQVSGhmoS7tskTDw6RPOJyOE4kVmzz6OwOvRFtTEWRskw5Shegt+7JL8maWUSD+1RZORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5gzDsIq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gKO9Iyxc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BLjGJA3923462
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6c/VxHfpcmIrMLF9ZDEPMqOWnrf58TnzdCmvY0qMQ6o=; b=n5gzDsIqHp02vjZ8
	FmSe/RNQExJ211IlsRjfKa0BtWLfdc0pCN/sbfUfRqTEl9iCEOzMPdKkHsAiP8Qc
	HRFtSwDR5WA518w41AvAv4b4XPn/3747S2S66bKkJ/bw142dWZimN8Y/hVKCJ9vY
	7mf+vYyrLCJEMVdMe4neNg0PZhYmXfEpIia49Y7cdyoQvZuFplMtdcFo2032cp+v
	uG98w5GgA7yNVltCzI+i6acGMRN1tHWYfr5hcQ1VisaFwLAKDrToik2bjlK6841u
	yHFsJPBx6TYzV7d0NFGFewLwUAq8qTmjn9D8SyXqDCKR4gIL4DGbpEjqjn1h/5RO
	1fCkvg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhak5s3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:35:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a13be531b2so64766335ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 18:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768185358; x=1768790158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6c/VxHfpcmIrMLF9ZDEPMqOWnrf58TnzdCmvY0qMQ6o=;
        b=gKO9IyxcnwQdActl7wDkhVziOe3S0OtRP3tbe8UjdmtnHE4LFz5PjI3zTzQdDhl61Y
         +0mKt9I9Q2wI8U9PUa75X2L+O5QV4QoF3PNWkXiyyyuMSXddXmZ9x7ABsRe33H+bXJEK
         F2KZSHKaXUpBcX5bRxslbILHYdDOpkhqL/fE0PMq28MYPKszianM7YSLeukOQAkeK5VZ
         M/EsLZcxQ1VrN6lgLjGOT3Ge8D3XqDJDKf8OtrDEfdealqPZbhCGLgNVsVdlHI8D9bpV
         M248072pqk6VvGMjZ/mVP4wsdaF4Y/Cky4GKH+vviarl5Jtf/pebJUHE0hS22IxTvvLx
         nEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768185358; x=1768790158;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c/VxHfpcmIrMLF9ZDEPMqOWnrf58TnzdCmvY0qMQ6o=;
        b=PFwAZrv+ZWq6jNpT9uGx7xUY5ZqUcwBfce/8gmNDuW1Q8ng2R+XE/pzcw/PjJOLeJc
         BSs3mPq1uWLv9uMIo6j4ykIYGOHJckP0rLwKL3KAgKEq8NM80vmAh2G3qB20J8z7hAxP
         T9rAjcN3i4vCjP096/CkH5sosF5x/MeXEBeKeWfYGlFVxQBsk+a18FmfLDUT1VcxsZsY
         fTPInL4QuIrNDpCY7P8hH4DosYJ3ETmRHY1OfwUHkgpTk8lWCNXUwD4U+p0wHmkQvdCl
         LFBz/kaEEuEybgGV6FucZrq5Z+TZyD5NisNCn6B4XcinWFjNxqBEa0y9rvi40nmCrSVh
         qz1g==
X-Forwarded-Encrypted: i=1; AJvYcCU7rqTw0LHZ9ogzi4UUiBZZMXYNsvey2OKpgarU2Nu40iZJq6p1pNslOdq18RzWEXEaKxKZwiZ6RwQUi7uBGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmvBCajHezW1b+i1oYEQpJ/Mw2zVD5eaz1gN8TXHW1D/hsLOG
	GfNDw+tKnM8yA0C27VxSaG5kSb5L2nuEMZlGVwN6bKJHcZ8105YIj2dD8GbrSTyUDS4X+zVeerd
	VCdoyUVjd5YNOGQ3zjY4lS68+0DqvHNEG6nBguclCwI4hPZDnTfCvEhf9GhVWqpvSzvvQBw==
X-Gm-Gg: AY/fxX4WgK4Hm9p8rvrC8OFQ8hQZHAPeVFdWOaHH4y+jw3lYJDiqsWpMn/2CL50eCVs
	tOTVQkTXi8ui2k6s6nEV53zm7HCDjUAbm0qIggz5a+qjZOo7mfS0C/xzAGDXErINzKSV/2cNG1f
	BkhoEVCe19/zgVz0C3QOz0DR7+52UQ4hCVh88TMlV2IzPRYoimbTt6v6XIIdmCF3RWDQqOr+0dB
	uMN1G2UiocUj504VieeuHlkmpu7k0kRZ36ZE2cvfY79I7VKQXBFpKIdiWpDb4xwrveDukcIulfV
	osvdQXqUW2quF/iDlIT6gLLeiX3neTzprbNUk5Z/l+GPeH20T0JfdUurPh+5CjczwoPGXEbcoO4
	poSYQbl3qlhaTUby+o3V+GX8WNwtlp2rWZY54rwdGP/kJq9Pfx8LAB1sb+Xw6+QTORHhDq1go+5
	lu0u5fOA==
X-Received: by 2002:a17:903:1a84:b0:2a0:be68:9456 with SMTP id d9443c01a7336-2a3ee4fed1emr135794665ad.46.1768185358196;
        Sun, 11 Jan 2026 18:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0qp4ogLpHOm8hfOd9xEVDvVklWm471t9sA5BmCY0MQQMxcM+W/YeyXFJQY2BqpmQzYKgnDg==
X-Received: by 2002:a17:903:1a84:b0:2a0:be68:9456 with SMTP id d9443c01a7336-2a3ee4fed1emr135794565ad.46.1768185357692;
        Sun, 11 Jan 2026 18:35:57 -0800 (PST)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f88casm16045651b3a.34.2026.01.11.18.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 18:35:57 -0800 (PST)
Message-ID: <09b6b13b-2b88-49b2-b865-f70996708c01@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 10:35:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
To: Ilya K <me@0upti.me>, tiwai@suse.de
Cc: ath11k@lists.infradead.org, jeff.johnson@oss.qualcomm.com,
        linux-wireless@vger.kernel.org, mpearson-lenovo@squebb.ca
References: <875xaypnkz.wl-tiwai@suse.de>
 <b410fa3f-0241-4805-afb0-efb950e04bd2@0upti.me>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b410fa3f-0241-4805-afb0-efb950e04bd2@0upti.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8_23F3hBMW1xDW05HAQYrvDpKx3OhzF-
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=69645e0e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mmW_J2VSl9LesBZo4rAA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 8_23F3hBMW1xDW05HAQYrvDpKx3OhzF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDAyMCBTYWx0ZWRfX//DW1ZAKYkYl
 Q3VhHBOayq4Q15nu0SeIMbHh6JLJoTcDin+JhYznKk+fnsqWv3yF/34spZ+UOkMSeUpLO6H1T0D
 U3pLUEFAWX0LjaeQzLZdJsIo9qd1oArJizXw6zoV9X6s+RH4AMc/ENKhPy0EqDqZGAXWDFnklAh
 Fonwd5HASDuIlt4MvROqK+757CjR+j1CJhJfhzvu3lxFg3/D6tDBR87swlIjn+Z3eYQ6glQMnAp
 XUj4wyYl2BeUhmDAcrfY+mCraEHYfeFFi7TOMWuls+6nHIv9Ed+AA4+Tofny1kPawwBgvtLPwEa
 LSuY6BXHCTxbS7+TAxErYWJs2qEUz3IOa+rVNcprPZ6OwuEzGb8HQadQC3ik9O493gLtymfvayK
 f2RyGLEZ1CirHJ6KypUgFIc5tb/DUFPgpZTrmsKP6Ic3pBKoCAWCC6s4c/21BmzgXO2o4CjOjKA
 H1ZCuumJNzoWtI4tgGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_09,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120020



On 1/11/2026 6:47 PM, Ilya K wrote:
> Hey folks,
> 
> Sorry for bumping an old-ish thread, but I've had the same issue on a T13 Gen3 machine as well (model 21CG), and there seems to be no better solution in sight.
> 
> Also, here's another instance of what I'm pretty sure is the same issue: https://lore.kernel.org/ath11k/6268b094-5a40-40d8-8461-9c9b0f9e1ae3@oss.qualcomm.com/T/#t
> 
> Can this get landed at least as a temporary workaround? Also, should I submit the 21CG quirk as a separate patch?

I had an off list discussion with Takashi, and based on the logs collected I don't think
this is not a suspend/resume issue, or even this is not a STA side issue.

Before we conclude whether your issue is the same or not, can you please describe your
issue in detail? specifically is it an unexpected wakeup or is it reconnection failure
after a normal wakeup?


