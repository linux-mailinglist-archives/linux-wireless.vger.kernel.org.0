Return-Path: <linux-wireless+bounces-17443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD1A0C153
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3723B1646DA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783561C9B62;
	Mon, 13 Jan 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RR4OFbnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BF1C5D7E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796288; cv=none; b=nzKPEjzY79QpGq8ygsmJo9Lko0xc22XnGWV0gsYZiC5aEzTIPp978TL5h2e4F+hLaJFbNqipgyL4t7ICCeLC0/Re0Hk6EONE1yGGPHUcAk49QAOkTddUldfmmGp7W32kmbEWlyzfdAGztI3DazoP4Fq3wi8jsJ23dleX9/8k3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796288; c=relaxed/simple;
	bh=phDGQaTxU/yTSkJZYJR/LV8WD8o70wPyPyv73TSdVkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSjzMvSsSAwExxrzCeriPEmaqRrU68MEdVTAPpqUbNrCOD27LW5S5i9fP8oMdicy6d/xIHXjfq+Om9P8L2ogScS6znDlUc8jJwc8tPiUhGJY6vG/fjATYu+mTgPOtarWucATPEBk68aaCkxdIOV8FHKF6KU8h1nMwSCqCLfvaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RR4OFbnr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DEreHM021705
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AUOLFheOXaPn7vxOSNO6EuwVYDmzYgNLEdqYuajMpeg=; b=RR4OFbnroBM5qm0E
	p5NRoCQU7JDSJ5SXIFrd6rPqk3APLAwxMchaBNeGPWWT4sGlUjCMC6VZqtd7XX2C
	A2wcRfS4RTOUnWHBrRqlM1pB6PlTnClbWKPf+AkXfIjGevMke1y251dKg6kqejh2
	LbTdb+79bw3wrTGzBwZATiiosPV5/7yDE5yHtCNzpYBEhlcFOdQKq2fUQ/o/3Gqz
	9XG0Los0HPVqvXeCZNbXrtCpZ3EYwrPJxcLuxuyqigZ2+XjGmXibwDudlZXAaZVj
	gG7vE2w71YkJueQugEpQrQ7Z49S3O/WAnGv693A3KINBlJ9RY0fwFJyMGYzIvsu4
	4+GwYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44550agny1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:24:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2163dc0f689so119429955ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796284; x=1737401084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUOLFheOXaPn7vxOSNO6EuwVYDmzYgNLEdqYuajMpeg=;
        b=PCDbr/8m4KPtEt5xaMWj8zhueueLEgilu+KhmJJkUinnnqiGejyOX+wWCFXWPVQSGr
         5WZGTfhm5pMC9BNVfFiuW4fot3w4y2fkjS/0L/xI4ANHD/f2g1qSmIGL6uxP+46zhHJv
         tC/WuXuKmP/1AO6L3qctKUM/4VMl9AJ0vFEqUrV/SsG+5Le7tIYBFEUJWBl2OkzDf5QM
         FhWoERZlnqj5deDOpbLOPnRQt9jpKO1SgSikmfCk+XbE8523XSvtPA95lqgy7u0djXhm
         YANi6m9z1Vi8nJYm6XjtBeXezlMwkJF8hxIjwoo1J+Ktwc/WMufBDlRhLVT4+6MJhDoz
         6jjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTw8VCumU+njyzckWMhJNCP+cc5JSbfUomt9TUtdpDicLFgd2UBOYaeSfCZu5R6Ac5yK9FTTyR97AhSGpfCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysbwqdoZMPMztnC4MO5uVoWlK5v9IErpyYRoE3Z11ZVJ/1bCnU
	78FBg7RYW2vxDHPlcvO4fWNWIVXGDwpGtKaS79Azdti+Z+iscJcK5WcxKfSjQAM1WE+bESVKx9l
	tKWTDM4Z2Hi/JDQVBYgHLB4A5CIx40l59WxPv/uIk5f6S78AUMl+MrI9FcULEutBHsA==
X-Gm-Gg: ASbGncugDdIJFtNYvR6rc4nboyk+YBg448YhoajnNBfkOv7BFaYMpR+hCqL5K4GZK5f
	4c04OroCZe3FEM9cukAru6mD27AZqsfPEIf5Q7G9CCDWGbkndrh3nDc2RCNuQFUZLAdAZDYTEXx
	JXwuAcMH8HX2hbZ8J2vEQ95d4/k/g1CSCB4Fr/UiR6wfmljDx884Cq/wgemtFhQUGgTTvnX9jE/
	D/GtNTwGqdhp3++eT7uPgnki0um8x3hCTgFEpLPXW0CkXHK+ymnfpsayDeTgVklhvsCkxp6c0oX
	NgXFQVgeZ+wEQaNwUWcBCufkAAKwNNDUCsgKHmsKY9VLyPSRHg==
X-Received: by 2002:a05:6a20:841c:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1e88d0b6d05mr38829998637.30.1736796284312;
        Mon, 13 Jan 2025 11:24:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmceM+8RgiF0n8czYoLDHjbC9BgEP6OqgjVvqDc4obk6V9Mr5uL/MP3NmNz6OUjD3DEuWoyQ==
X-Received: by 2002:a05:6a20:841c:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1e88d0b6d05mr38829963637.30.1736796283924;
        Mon, 13 Jan 2025 11:24:43 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a6b4sm6405859b3a.60.2025.01.13.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:24:43 -0800 (PST)
Message-ID: <b3773859-4cb4-4d8c-aa61-fb227fc22bbd@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:24:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] wifi: ath12k: handle ath12k_core_reset() with
 hardware grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-9-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-9-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sA9-a20s-YiDV5yoef6BppkZU4BHXwyo
X-Proofpoint-GUID: sA9-a20s-YiDV5yoef6BppkZU4BHXwyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=988 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Currently, in ath12k_core_reset(), the device is powered up immediately
> after a power down. However, with hardware grouping, when one device
> asserts, all partner devices also asserts. If there is a delay in
> processing these asserts, by the time this device powers up, other devices
> might still be asserting, leading to an overall recovery failure.
> 
> To prevent this issue, ensure all asserts for a group are processed before
> initiating the power-up sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



