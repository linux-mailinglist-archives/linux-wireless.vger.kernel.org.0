Return-Path: <linux-wireless+bounces-18379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A4A26C23
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F24D3A7521
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DC20127E;
	Tue,  4 Feb 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dO0a/CO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A225A655
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650561; cv=none; b=G8BN9grQ4qLaZCpPL10Mq7Hn+f7Xkjuk0XjcqX6EQptENoQugT7wuqVDRv5OCjVn99Ve7FGQXGzFgOsOabplYtDCnBL+75fx2nZ7UlGOjasqat60t2CbXR7C1hxeOHqD69LEjGxt3s6L/d8SF0L4THiOZNKg82uOpA/lrHXNGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650561; c=relaxed/simple;
	bh=grlU72PC8NF/4gqGawMG2lPnF3BuIyMFU/iprPnCpZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJiXJf7/gOqWKuhq9a/A5CZtycs3RVwCfHJdYQWPVNGOV7rev3QMNtsNPlbC5ux9KMtFzrMJjDfakVNJGAlGR8rcr3CU1BJCTg/T4i5qflhvvRDyc4McTbYv/wgiDrewAf1Wn/KU2bMXUQkVIjclGQWOD2uxZFWG68o++6Z2kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dO0a/CO4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513GEeav010516
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 06:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dw4RdPfMV+paR8BSlVBGfl2KemWUSGdoGSUtVVl1s+I=; b=dO0a/CO47SjcKH4d
	VglWTPbBR8ZYuC4qH0sp9jZmIHBlyeHzu/x/rUcM+WLpEJcY5nCDmelRvHYsRBHV
	a45LjWNBNelswR2Vd1aZPdQ7ukv0I+q1IyLj60HMiOzRNH7NWi/Cxd7b67rfAPvs
	UIf/P5DhSsbfMxcKCiVmKxg/49GRc4di3+GRY29ZUl5QofyxO11FokCCuWLpQw3T
	NfKwL/uA+GqfcR3dh1x0RBUnS2YRJaALhWD5KxxNFyI8NbYWmdJ12rGJChg5s+Lu
	PIDjY1+/4UYJCkfGwmgxPbgKDlpdWuZaIM8MVM5UZ22cTpKwgpZtZrzk31XA/ila
	0u/QlQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k159hm5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 06:29:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2167141e00eso124401165ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738650556; x=1739255356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dw4RdPfMV+paR8BSlVBGfl2KemWUSGdoGSUtVVl1s+I=;
        b=UnIkIlU/vlE1/jiLPvUdQFNF0Wc4YxPtFx+klUG0L0tw2YBEVClKUkDvCBoU0WEnXF
         Aspq3ol7f+vURD2im7AFIYtaAoHR+0BLKLpiStrVrSJRMo1v2wNuGaRKNhRClO+/PviK
         8IonRn7VJBX30YrBs1SCWpo2taf/jOJNE6AjcafjtRXu/eYyUBMQQDt95IhWgtcTPfHa
         U7sF52nNuI/GzV1KHESkesa86ANegnePhNRHvKUQIz/FYSEkPgJFlNRzULsIcL6p0lqD
         bXPz2Jwij0RIPCwS3gxDELHdEZdrDldxhGFhlT9IMnTyn2hHHt4y0x7clIC1hEw3W013
         FmwA==
X-Gm-Message-State: AOJu0Yxfy5CpYU3AlrdCGEN/Qz0MDZm6PIp54X86P7wZfYa9ntWFx74s
	+fxX4ahfRKBJPPb0C+w9GcCURzZMN2r07s5WbRzqGlq+KU4kTSpP16MMb0zvz116kBBgqjRVhjg
	LqZ05LRipbVJc4j0Z4k9ku5a6344Ir6L6eIehUN+CpwFM/EIJJTtWNe4aIe0+GQiVuZ6uzGN5JA
	==
X-Gm-Gg: ASbGncsmibZWbmyQYeTLy5WwQK2VbVmtTSwzXIZ5u4oLEQVVge6+ez3KXQI3L0U0pPH
	l57cbVidULJslH51Y6jvWOc0/4J849+sDTMcyD1AeWFYU/+Nl2OxhdmyeeepVxn/7uxmGgcppjX
	4KdWLqq87s5v+W/kgSO/6OYcO3Bm6SlgdmEHW8T7GqXm/7MycwgRDG9S/zuLYHPRsHZMhyOjMos
	X+KSHoLXKZzzPMwkLUrM6fOKeBXwNPzxrKB+sQ/VbTk0ytNm/etrc5vBqoWhURkZ9onmBF9YgGC
	Q3PNoZcPS8TX39F7ixpLTjC9QWy+TNK0CFk9Os0=
X-Received: by 2002:a17:902:ebca:b0:21d:dfae:2ffb with SMTP id d9443c01a7336-21ddfae347fmr330707235ad.17.1738650556418;
        Mon, 03 Feb 2025 22:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuQgf6eP8TP3R8aroNpvarjgHhOnZzvSaWCFsUni9H6ZSr+3e+0xv2JaH/flIE/Ge1XlHYdQ==
X-Received: by 2002:a17:902:ebca:b0:21d:dfae:2ffb with SMTP id d9443c01a7336-21ddfae347fmr330707045ad.17.1738650556033;
        Mon, 03 Feb 2025 22:29:16 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee30bsm86916915ad.35.2025.02.03.22.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 22:29:15 -0800 (PST)
Message-ID: <9df7c75b-31d8-4018-8418-9ca369fd9a82@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 11:59:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Pass correct values of center freq1 and
 center freq2 for 160 MHz
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250204053451.2703834-1-quic_surapk@quicinc.com>
 <20250204053451.2703834-2-quic_surapk@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250204053451.2703834-2-quic_surapk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pApFgYHe_0wmxj69xvoFg6a_mg03p4RE
X-Proofpoint-ORIG-GUID: pApFgYHe_0wmxj69xvoFg6a_mg03p4RE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040050

On 2/4/25 11:04, Suraj P Kizhakkethil wrote:
> Currently, for 160 MHz bandwidth, center frequency1 and
> center frequency2 are not passed correctly to the firmware.
> Set center frequency1 as the center frequency
> of the primary 80 MHz channel segment and center frequency2 as
> the center frequency of the 160 MHz channel and pass the values
> to the firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Suraj P Kizhakkethil<quic_surapk@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

