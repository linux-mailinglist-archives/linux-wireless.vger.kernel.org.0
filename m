Return-Path: <linux-wireless+bounces-21601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF5A906C9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16A1163DEF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403421FDE22;
	Wed, 16 Apr 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7PW5kJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A41F0E5C
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814575; cv=none; b=BP7pcOMfmPXwucTymm035qd8Q1ve0CfcYxsqo5+HHBvFYTkPtaNvlOdNIgDY+m26EsSHOrNj9+/RdTyilXEzUIQzs2oEA2uxlarOz3nteFqey6rF+bOKCY8JSfda5mBTKNTjhun2h/15bPI768Fy9Vny8vo9s7otfgYm0wdPJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814575; c=relaxed/simple;
	bh=mmOsz6S2lb1r6MXli5uGzDyY4TrxKDkcofnlecLR/Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLouvBjxbLTuUCO2pARKTwv6L9iK+/hMtnBaQc4YmRYVsm2KXT0MXb/HzM3h854NNZUelcIAUFNnAdA4Xdf3tHvdPJ3o0snRjIzDS/KVQ918daELldMPTJ/T0CzCEs+KN/VdCiU9mBDbFD3inSVr1zVeiDJDvyDIr745OhekDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7PW5kJP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mFiD007028
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 14:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q4SGPXBNbpJTbw+kKWEscmItSk+Ds2TtdKc3wNeiEUw=; b=j7PW5kJPR4DCodZE
	wDB6Z5s9NJDgY394gdk+JN7/ObElsMsm/f5Cd7lBHDHvEFaznn2NEWmY8FIp6+DW
	xTL3kXXXLZdvJfJP82UroDNRE6PZ58gEk5EhhiRB5xR/6+ssBPqguSUyWhrfTXBD
	Dilwj1MGNejZvMnsPsVG4xIZeA2S0y3J9WKYzrsngjZVoLEL6woaog8XuBXZjWjH
	UofA1Wlkibf+onipAY7Xo6+UApzJu8CU1I+hePgF+9KLIgX+Qj7qynLWuhJMlGlN
	H8FthkNyxPpDbqE6Z0KJI7fm/oPsCy1JaVvhKKW5NLMCKHx8T62V2fWHPB53QYGY
	yMf5Cw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjksxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 14:42:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73c2f5c284cso197785b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 07:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814570; x=1745419370;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4SGPXBNbpJTbw+kKWEscmItSk+Ds2TtdKc3wNeiEUw=;
        b=lfF+a4bZ2cN7GBWCk4hEyCpvYr2sLnZCNGkPyOAyGvRUmLhJkxTw3KKN4xdXrO5Ex3
         TjaAojTJkpzyVF0Gj4nb5euHb59KIEVT4Dpbw9TakwesUNxxiHyQUihFeiR6hGysH7S5
         TU8l2GX/Is3Dbw5ao3M/YcvxmVZdNVj9X+rovzkJOLiDO7ofnyJlDWrUigQezFA3IjfC
         hlrfxdWkEF68loOVBJlA4Wj+o37znNkw1HiV0Pduzew1lXCnYa1mXgaf4/qxl7ZUUdz3
         JOogHKyoTiZex8nQSPnMJusSxsJl2wxKsH9XZpYUjH4KCj4rn3XTL2lCBr/2QZUdIepZ
         g8yw==
X-Gm-Message-State: AOJu0YwmfSVoswDr/JetS7n6xk3R0gCIBn8Jf7UU2kB8eLdUzzcibA42
	pFNk2rb4g2832RyNyqQjqjpGlmWskjYm7+wBjhAnJVVEktaTLwMbHG1jT76t5bcCNQmWjDhDPdU
	QAcmEsD/4ooDdQbSMLyjwzejRCUqfn2/Zhzp9xMieV6gNPhLCwSxl6Q983APYJ3Y6uQ==
X-Gm-Gg: ASbGncv+D040PgzZWjQNM3IgDUt4qJFndNy7+KxbxElPeIqhlfJWJwBNb9eXRfwd/qR
	5VLIdbJcXaV0b50/gioDGeMdIHZigZrK4Q4ZWaeYh8+3o7HG8zycii3si7tYOnLw3K39aW3H8U9
	fWH6ROJbrKVdxdKSYI6rKj/IOUpV0DkKUIVLSLftPMTyWsW6mgHhAgiZnsrxfhqgelY6gQzKA+A
	+xGEHBkxM1oFa9SaqWaVagDMism6gKU1yFWJiuaG1FM1sioGtywBSomL3jIoJfHS6Aae96nYp7c
	pJPW4vg55UukNsYUh+fP2u8PzZhwml0ReE5ZciG/3vtnupw/4Wzz8pMaMsRZJjkzqLI=
X-Received: by 2002:a05:6a21:31c8:b0:1fd:e9c8:b8c3 with SMTP id adf61e73a8af0-203b3fbec73mr2896548637.26.1744814570574;
        Wed, 16 Apr 2025 07:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFGX4gVdDw4AKxAHDyZz0t/N2oN3itl4EwefxTunKN2wycEuAukkqfiC1dFFLsCYPIEopOQ==
X-Received: by 2002:a05:6a21:31c8:b0:1fd:e9c8:b8c3 with SMTP id adf61e73a8af0-203b3fbec73mr2896497637.26.1744814569881;
        Wed, 16 Apr 2025 07:42:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220c2d46sm1347657a12.21.2025.04.16.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 07:42:49 -0700 (PDT)
Message-ID: <fa96e5b4-09b4-4f94-afd1-5e6eb850e8c9@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 07:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/3] wifi: ath12k: Fix frequency range in driver
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-3-quic_rajson@quicinc.com>
 <e789aa3d-ab12-ed19-0d58-012004e365d1@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e789aa3d-ab12-ed19-0d58-012004e365d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AKpwfpHAOEHh7pZEcAPtPmaxWJafsg1j
X-Proofpoint-ORIG-GUID: AKpwfpHAOEHh7pZEcAPtPmaxWJafsg1j
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67ffc1eb cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ccNd2zmM-x14ZBnStIUA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=743 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160120

On 4/15/2025 9:09 PM, Vasanthakumar Thiagarajan wrote:
> You may need to rebase the series
> 
> Applying: wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
> Applying: wifi: ath12k: Fix frequency range in driver
> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:1122
> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
> Patch failed at 0002 wifi: ath12k: Fix frequency range in driver

It applied to my 'pending' branch with:
b4 am --prep-3way ...
git am -3 ...

/jeff



