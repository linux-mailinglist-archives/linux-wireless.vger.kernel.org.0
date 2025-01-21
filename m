Return-Path: <linux-wireless+bounces-17797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67063A182DA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 18:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC13A34CB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062A187FE4;
	Tue, 21 Jan 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SkhktG12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C51BF7E8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480388; cv=none; b=ZWlSNSv37PWpaQ2zOrH9A2m5RR1rkVpWV9XHm2mCQ86dpvBQOQ0bmR0xjgZfFqNbnlW1VjoPvuYDHSy3K4jysGOMoqelQ6G+U0tQRNEUKyODCVnvhFXpc6niMDChUkjCpPLp5e+6VVs3nMgNDxzHuoGsN57GV/PFom/MSXbUx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480388; c=relaxed/simple;
	bh=PgZ6D0hXOwpo2ETuSUmhoYXvTXcf971W2TRZK6ZwKa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbeoMF8++9KWwWV0MiiT5Y9JJwPPLIqxWIdw+gmYnnp4GYdFuPoDE0qoaWa+VlnQUe5dST4EpDgL4k/kvhsv5NfhaRDswg2gpEI19qw+KkOH8Zipzo/c0uoHFGsM4ve93lHq1Kgmx9HTLTaZMD+JqWbCMhxBOlprTGRV54S5xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SkhktG12; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LGr3IM001569
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 17:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xFyn+vIA68bXfr8/8e+p43567yde9skhLsXNicoGWx8=; b=SkhktG12cJ51tEwz
	f+Wr+gHSZQYIFvBDFIVdam4qEjwYJFoBwkUCp4xrYtGdshP7DN4eX1fLKE3E97GC
	Oj7xzsSacXMGTNuqSrGId4FvZXIbB3Fb/JjhnaaShOr2JeLXuwqpMEfn77fZcLNi
	GAUFN9jpPG6L0Sun4E0rGO/GaL/8io3jf43sufCBAP4wnjtT1LT6MVaf11w+bJ36
	cJcDKXeQYh1qsFV+dtumQTcvx5AAZEf+2jaXv10s9DurbKqhm3Cyksol6zdnXj2T
	of3u5wb7+aK1uSvKvdmMjbBk0Mnkvmswm9zcEpXJd7pWujVlbS06h9Faik83n7VO
	yZsqXw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a866sqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 17:26:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21681a2c0d5so108130075ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480383; x=1738085183;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFyn+vIA68bXfr8/8e+p43567yde9skhLsXNicoGWx8=;
        b=LiGTEwy1YZfDEUV9nMacEkp/xtCMWjYnFWvjv7B7icHbva72p49zYLz2G11ejJQLa/
         W0QjQoBkK3r1xV0cpMfbMlRakW5ThyhHqcOIILhxYKV29ZiYcY0rDXWRPfUq3y5mP2CB
         KJTemB020iYMQ5urXxYSGscghWWA6woCRUaEuCI8fv2bTZOMuENiuj1UzADPBqKFeu9V
         dxa9lp4rKlCUwNI3u10KU6+I3MdINyNd6cObdjKNb7SdMrzolcORK7MIDf+ZB2ij+WhQ
         kU08Qj/CuI1y94TiJw3R4rUyCyb/vBcEmzWwUJucMX/o+bL5AxaGOWhUK1cidEGeBair
         vrew==
X-Gm-Message-State: AOJu0Yx5fMHIendB9k5PXupORMvZx02wosjNwsXhrZdYcj+S6mmXTgZ5
	rSZtfCeVkwm4QpNNrOm9fMrGLXNoJui58YWEpyQ3mh8tXwr5my60Mu/Tozew1bI67GPD5F3GgRB
	FQuIzGbGTECMEXxJKz9ZbAhC7e2/Ai+DBofmCD2vydgYaIn3qGetgr2rMOzdjfQaRbQ==
X-Gm-Gg: ASbGncsg15j2Z7xjqneC/UdRLo66MbS4AyKRc0wf6ikCJDUzF0j8E9nUhtDKGeMvWTx
	sMHk6t+PNOg+/blpVxuql5ftw9vU2TaCqn4AQynP1UJCfidGMNTEJX0KNtckIsFSDz/yidTzG6t
	UyajXmJcADZZM+1d4eKvj5m0RPSNtUsAlUGHGO7zpkMdvDagyzfuEcYQuTTLH1OodftMTKg7VWh
	t1kPUTh0zH13ITTeQXciL4utYO88UoVvvPa7zyEiJdruHyrOTIR1EdK7x9qDN+4wBR8cgivd6WM
	PxAfLmkm8B5sQ2qiyZsTr9aRqkHjxvnLyskc/cBO8eGUX44tPw==
X-Received: by 2002:a17:903:2a88:b0:215:9894:5679 with SMTP id d9443c01a7336-21c34ccef5fmr268666605ad.0.1737480383397;
        Tue, 21 Jan 2025 09:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHebtlpbe2fjGTEr6g5IQsgumqvYjR2tRkHVlpjK0XAFtKdFaHaz7u47zr4G4o0OeZNi4LZCw==
X-Received: by 2002:a17:903:2a88:b0:215:9894:5679 with SMTP id d9443c01a7336-21c34ccef5fmr268666395ad.0.1737480382986;
        Tue, 21 Jan 2025 09:26:22 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc3232a4sm9137633a12.30.2025.01.21.09.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 09:26:22 -0800 (PST)
Message-ID: <0ab6d084-9fb7-4e8f-b0b7-71812a1492d6@oss.qualcomm.com>
Date: Tue, 21 Jan 2025 09:26:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] wifi: ath12k: Factory test mode support
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Cc: linux-wireless@vger.kernel.org
References: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dduxawJQ03-96bwq9Iq20vv-nP6ku2ki
X-Proofpoint-ORIG-GUID: dduxawJQ03-96bwq9Iq20vv-nP6ku2ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210140

+ath11k list since it is also modified (but no functional change)

On 1/19/2025 12:36 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (4):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
>   wifi: ath12k: Disable MLO in Factory Test Mode
> 
> ---
> v10:
>   -Combined patch[4/5] with patch[3/5]
> v9:
>   -Rebased on master-pending
> v8:
>   -Included change for assigning seg_hdr.pdev_id.
>   -Moved if block to start of ath12k_core_hw_group_set_mlo_capable()
> v7:
>   -Updated copyright
>   -Moved ath12k_ftm_check in ath12k_core_hw_group_set_mlo_capable()
> v6:
>   -Rebased on ToT
>   -Updated copyright
>   -Added patch[5/5]
> v5:
>   -Updated copyright
>   -Fixed line length within 90 char
> v4:
>   -Rebased on latest ToT
> v3:
>   -Rebased on latest ToT
>   -Updated Tested-on Tag
>   -Removed second parameter of ath12k_core_start()
>   -Updated copyright
> v2:
>   -Rebased on latest ath ToT
> ---
> 
>  drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  28 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  11 +
>  drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>  drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
>  .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>  14 files changed, 620 insertions(+), 82 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
> 
> base-commit: 0f5fcb566e7e6c1154540280d334fc71f7cbeb63


